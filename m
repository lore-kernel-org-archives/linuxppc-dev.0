Return-Path: <gerickson@nuovations.com>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
	by ozlabs.org (Postfix) with SMTP id C8305DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 12:42:26 +1100 (EST)
From: Grant Erickson <gerickson@nuovations.com>
To: bluesmoke-devel@lists.sourceforge.net
Subject: [PATCH v2] Add PPC/4xx "ibm,sdram-4xx-ddr2" EDAC MC Driver
Date: Wed, 17 Dec 2008 17:42:21 -0800
Message-Id: <1229564541-18996-1-git-send-email-gerickson@nuovations.com>
Cc: linuxppc-dev@ozlabs.org, dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds support for an EDAC memory controller adaptation driver for
the "ibm,sdram-4xx-ddr2" ECC controller realized in the AMCC PowerPC
405EX[r].

Signed-off-by: Grant Erickson <gerickson@nuovations.com>
---
At present, this driver has been developed and tested against the
controller realization in the AMCC PPC405EX[r] on the AMCC Kilauea and
Haleakala boards (256 MiB w/o ECC memory soldered onto the board) and
a proprietary board based on those designs (128 MiB ECC memory, also
soldered onto the board).

In the future, dynamic feature detection and handling needs to be
added for the other realizations of this controller found in the
440SP, 440SPe, 460EX, 460GT and 460SX.

Eventually, this driver will likely be evolved and adapted to the
above variant realizations of this controller as well as broken apart
to handle the other known ECC-capable controllers prevalent in other
PPC4xx processors:

  - IBM SDRAM (405GP, 405CR and 405EP) "ibm,sdram-4xx"
  - IBM DDR1 (440GP, 440GX, 440EP and 440GR) "ibm,sdram-4xx-ddr"
  - Denali DDR1/DDR2 (440EPX and 440GRX) "denali,sdram-4xx-ddr2"

Patch v2 removes the 'type' field from the of_device_id match
structure to reflect the corresponding removal of the 'device_type'
field from the device tree node.

 drivers/edac/Kconfig                |    9 +
 drivers/edac/Makefile               |    2 +-
 drivers/edac/ppc4xx_edac.c          | 1332 +++++++++++++++++++++++++++++++++++
 drivers/edac/ppc4xx_edac.h          |  179 +++++
 4 files changed, 1521 insertions(+), 1 deletions(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index e0dbd38..ae950d7 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -167,4 +167,13 @@ config EDAC_CELL
 	  Cell Broadband Engine internal memory controller
 	  on platform without a hypervisor
 
+config EDAC_PPC4XX
+	tristate "PPC4xx IBM DDR2 Memory Controller"
+	depends on EDAC_MM_EDAC && 4xx
+	help
+	  This enables support for EDAC on the ECC memory used
+	  with the IBM DDR2 memory controller found in various
+	  PowerPC 4xx embedded processors such as the 405EX[r],
+	  440SP, 440SPe, 460EX, 460GT and 460SX.
+
 endif # EDAC
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 62c2d9b..de8d4c1 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -33,4 +33,4 @@ obj-$(CONFIG_EDAC_PASEMI)		+= pasemi_edac.o
 obj-$(CONFIG_EDAC_MPC85XX)		+= mpc85xx_edac.o
 obj-$(CONFIG_EDAC_MV64X60)		+= mv64x60_edac.o
 obj-$(CONFIG_EDAC_CELL)			+= cell_edac.o
-
+obj-$(CONFIG_EDAC_PPC4XX)		+= ppc4xx_edac.o
diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
new file mode 100644
index 0000000..5caadc6
--- /dev/null
+++ b/drivers/edac/ppc4xx_edac.c
@@ -0,0 +1,1332 @@
+/*
+ * Copyright (c) 2008 Nuovation System Designs, LLC
+ *   Grant Erickson <gerickson@nuovations.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/edac.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/types.h>
+
+#include <asm/dcr.h>
+
+#include "edac_core.h"
+#include "ppc4xx_edac.h"
+
+/*
+ * This file implements a driver for monitoring and handling events
+ * associated with the IMB DDR2 ECC controller found in the AMCC/IBM
+ * 405EX[r], 440SP, 440SPe, 460EX, 460GT and 460SX.
+ *
+ * As realized in the 405EX[r], this controller features:
+ *
+ *   - Support for registered- and non-registered DDR1 and DDR2 memory.
+ *   - 32-bit or 16-bit memory interface with optional ECC.
+ *
+ *     o ECC support includes:
+ *
+ *       - 4-bit SEC/DED
+ *       - Aligned-nibble error detect
+ *       - Bypass mode
+ *
+ *   - Two (2) memory banks/ranks.
+ *   - Up to 1 GiB per bank/rank in 32-bit mode and up to 512 MiB per
+ *     bank/rank in 16-bit mode.
+ *
+ * As realized in the 440SP and 440SPe, this controller changes/adds:
+ *
+ *   - 64-bit or 32-bit memory interface with optional ECC.
+ *
+ *     o ECC support includes:
+ *
+ *       - 8-bit SEC/DED
+ *       - Aligned-nibble error detect
+ *       - Bypass mode
+ *
+ *   - Up to 4 GiB per bank/rank in 64-bit mode and up to 2 GiB
+ *     per bank/rank in 32-bit mode.
+ *
+ * As realized in the 460EX and 460GT, this controller changes/adds:
+ *
+ *   - 64-bit or 32-bit memory interface with optional ECC.
+ *
+ *     o ECC support includes:
+ *
+ *       - 8-bit SEC/DED
+ *       - Aligned-nibble error detect
+ *       - Bypass mode
+ *
+ *   - Four (4) memory banks/ranks.
+ *   - Up to 16 GiB per bank/rank in 64-bit mode and up to 8 GiB
+ *     per bank/rank in 32-bit mode.
+ *
+ * At present, this driver has ONLY been tested against the controller
+ * realization in the 405EX[r] on the AMCC Kilauea and Haleakala
+ * boards (256 MiB w/o ECC memory soldered onto the board) and a
+ * proprietary board based on those designs (128 MiB ECC memory, also
+ * soldered onto the board).
+ *
+ * Dynamic feature detection and handling needs to be added for the
+ * other realizations of this controller listed above.
+ *
+ * Eventually, this driver will likely be adapted to the above variant
+ * realizations of this controller as well as broken apart to handle
+ * the other known ECC-capable controllers prevalent in other 4xx
+ * processors:
+ *
+ *   - IBM SDRAM (405GP, 405CR and 405EP)
+ *   - IBM DDR1 (440GP, 440GX, 440EP and 440GR)
+ *   - Denali DDR1/DDR2 (440EPX and 440GRX)
+ *
+ * Unfortunately, correctable errors report nothing more than the
+ * beat/cycle and byte/lane the correction occurred on and the check
+ * bit group that covered the error.
+ *
+ * In contrast, uncorrectable errors also report the failing address,
+ * the bus master and the transaction direction (i.e. read or write)
+ *
+ * Regardless of whether the error is a CE or a UE, we report the
+ * following pieces of information in the driver-unique message to the
+ * EDAC subsystem:
+ *
+ *   - Device tree path
+ *   - Bank(s)
+ *   - Check bit error group
+ *   - Beat(s)/lane(s)
+ */
+
+/* Preprocessor Definitions */
+
+#define	EDAC_OPSTATE_INT_STR		"interrupt"
+#define	EDAC_OPSTATE_POLL_STR		"polled"
+#define EDAC_OPSTATE_UNKNOWN_STR	"unknown"
+
+#define PPC4XX_EDAC_MODULE_NAME		"ppc4xx_edac"
+#define PPC4XX_EDAC_MODULE_REVISION	" v1.0.0 " __DATE__
+
+#define	PPC4XX_EDAC_MESSAGE_SIZE	256
+
+/*
+ * Kernel logging without an EDAC instance
+ */
+#define	ppc4xx_edac_printk(level, fmt, arg...) \
+	edac_printk(level, "PPC4xx MC", fmt, ##arg)
+
+#define ppc4xx_edac_debug(fmt, arg...) \
+	ppc4xx_edac_printk(KERN_DEBUG, fmt, ##arg)
+#define ppc4xx_edac_info(fmt, arg...) \
+	ppc4xx_edac_printk(KERN_INFO, fmt, ##arg)
+#define ppc4xx_edac_notice(fmt, arg...) \
+	ppc4xx_edac_printk(KERN_NOTICE, fmt, ##arg)
+#define ppc4xx_edac_warning(fmt, arg...) \
+	ppc4xx_edac_printk(KERN_WARNING, fmt, ##arg)
+#define ppc4xx_edac_err(fmt, arg...) \
+	ppc4xx_edac_printk(KERN_ERR, fmt, ##arg)
+
+/*
+ * Kernel logging with an EDAC instance
+ */
+#define ppc4xx_edac_mc_printk(mci, level, fmt, arg...) \
+	edac_mc_chipset_printk(mci, level, "PPC4xx", fmt, ##arg)
+
+#define ppc4xx_edac_mc_debug(mci, fmt, arg...) \
+	ppc4xx_edac_mc_printk(mci, KERN_DEBUG, fmt, ##arg)
+#define ppc4xx_edac_mc_info(mci, fmt, arg...) \
+	ppc4xx_edac_mc_printk(mci, KERN_INFO, fmt, ##arg)
+#define ppc4xx_edac_mc_notice(mci, fmt, arg...) \
+	ppc4xx_edac_mc_printk(mci, KERN_NOTICE, fmt, ##arg)
+#define ppc4xx_edac_mc_warning(mci, fmt, arg...) \
+	ppc4xx_edac_mc_printk(mci, KERN_WARNING, fmt, ##arg)
+#define ppc4xx_edac_mc_err(mci, fmt, arg...) \
+	ppc4xx_edac_mc_printk(mci, KERN_ERR, fmt, ##arg)
+
+/*
+ * Convenience macros to support indirect DCR read and write access to
+ * the SDRAM controller registers.
+ *
+ * TODO: If in the future the indirect address and data windows for
+ * this controller are not the same across realizations, the windows
+ * will have to be read from the device tree and these mnemonic
+ * accessors will have to become programmatic in a manner similar to
+ * the existing dcr_{map,unmap,read,write} functions.
+ */
+#define mfsdram(reg)			mfdcri(SDRAM0, SDRAM_ ## reg)
+#define mtsdram(reg, value)		mtdcri(SDRAM0, SDRAM_ ## reg, value)
+
+/*
+ * Macros to convert bank configuration size enumerations into MiB and
+ * page values.
+ */
+#define	SDRAM_MBCF_SZ_MiB_MIN		4
+#define SDRAM_MBCF_SZ_TO_MiB(n)		(SDRAM_MBCF_SZ_MiB_MIN \
+					 << (SDRAM_MBCF_SZ_DECODE(n)))
+#define SDRAM_MBCF_SZ_TO_PAGES(n)	(SDRAM_MBCF_SZ_MiB_MIN \
+					 << (20 - PAGE_SHIFT + \
+					     SDRAM_MBCF_SZ_DECODE(n)))
+
+/*
+ * Device tree interrupt indices
+ */
+#define INTMAP_ECCDED_INDEX		0	/* Double-bit Error Detect */
+#define	INTMAP_ECCSEC_INDEX		1	/* Single-bit Error Correct */
+
+/* Type Definitions */
+
+/*
+ * PPC4xx SDRAM memory controller private instance data
+ */
+struct ppc4xx_edac_pdata {
+	struct {
+		int sec;	/* Single-bit correctable error IRQ assigned */
+		int ded;	/* Double-bit detectable error IRQ assigned */
+	} irqs;
+};
+
+/*
+ * Various status data gathered and manipulated when checking and
+ * reporting ECC status.
+ */
+struct ppc4xx_ecc_status {
+	u32 ecces;
+	u32 besr;
+	u32 bearh;
+	u32 bearl;
+	u32 wmirq;
+};
+
+/* Function Prototypes */
+
+static int ppc4xx_edac_probe(struct of_device *device,
+			     const struct of_device_id *device_id);
+static int ppc4xx_edac_remove(struct of_device *device);
+
+/* Global Variables */
+
+/*
+ * Device tree node type and compatible tuples this driver can match
+ * on.
+ */
+static struct of_device_id ppc4xx_edac_match[] = {
+	{
+		.compatible	= "ibm,sdram-4xx-ddr2"
+	},
+	{ }
+};
+
+static struct of_platform_driver ppc4xx_edac_driver = {
+	.match_table		= ppc4xx_edac_match,
+	.probe			= ppc4xx_edac_probe,
+	.remove			= ppc4xx_edac_remove,
+	.driver			= {
+		.owner	= THIS_MODULE,
+		.name	= PPC4XX_EDAC_MODULE_NAME
+	}
+};
+
+/*
+ * TODO: The row and channel parameters likely need to be dynamically
+ * set based on the aforementioned variant controller realizations.
+ */
+static const unsigned ppc4xx_edac_nr_csrows = 2;
+static const unsigned ppc4xx_edac_nr_chans = 1;
+
+/*
+ * Strings associated with PLB master IDs capable of being posted in
+ * SDRAM_BESR or SDRAM_WMIRQ on uncorrectable ECC errors.
+ */
+static const char * const ppc4xx_plb_masters[9] = {
+	[SDRAM_PLB_M0ID_ICU]	= "ICU",
+	[SDRAM_PLB_M0ID_PCIE0]	= "PCI-E 0",
+	[SDRAM_PLB_M0ID_PCIE1]	= "PCI-E 1",
+	[SDRAM_PLB_M0ID_DMA]	= "DMA",
+	[SDRAM_PLB_M0ID_DCU]	= "DCU",
+	[SDRAM_PLB_M0ID_OPB]	= "OPB",
+	[SDRAM_PLB_M0ID_MAL]	= "MAL",
+	[SDRAM_PLB_M0ID_SEC]	= "SEC",
+	[SDRAM_PLB_M0ID_AHB]	= "AHB"
+};
+
+/**
+ * This routine determines whether the specified bank has an ECC
+ * error.
+ *
+ * @param status A pointer to the ECC status structure to check for an
+ * ECC bank error.
+ * @param bank The bank to check for an ECC error.
+ *
+ * @return True if the specified bank has an ECC error; otherwise,
+ * false.
+ */
+static bool
+ppc4xx_edac_check_bank_error(const struct ppc4xx_ecc_status *status,
+			     unsigned int bank)
+{
+	switch (bank) {
+
+	case 0:		return (status->ecces & SDRAM_ECCES_BK0ER);
+	case 1:		return (status->ecces & SDRAM_ECCES_BK1ER);
+	default:	return false;
+
+	}
+}
+
+/**
+ * This routine generates to the provided buffer the portion of the
+ * driver-unique report message associated with the ECCESS[BKNER]
+ * field of the specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the bank message being generated.
+ * @param status A pointer to the ECC status structure to generate the
+ * message from.
+ * @param buffer A pointer to the buffer in which to generate the
+ * message.
+ * @param size The size, in bytes, of space available in buffer.
+ *
+ * @return The number of characters generated on success; otherwise, <
+ * 0 on error.
+ */
+static int
+ppc4xx_edac_generate_bank_message(const struct mem_ctl_info *mci,
+				  const struct ppc4xx_ecc_status *status,
+				  char *buffer,
+				  size_t size)
+{
+	int n, total = 0;
+	size_t row, rows;
+
+	n = snprintf(buffer, size, "%s: Banks: ", mci->dev_name);
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+	for (rows = 0, row = 0; row < mci->nr_csrows; row++)
+		if (ppc4xx_edac_check_bank_error(status, row)) {
+			    n = snprintf(buffer, size,
+					 "%s%d",
+					 (rows++ ? ", " : ""), row);
+
+		    if (n < 0 || n >= size)
+			    goto fail;
+
+		    buffer += n;
+		    size -= n;
+		    total += n;
+		}
+
+	n = snprintf(buffer, size, "%s; ", rows ? "" : "None");
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+ fail:
+	return total;
+}
+
+/**
+ * This routine generates to the provided buffer the portion of the
+ * driver-unique report message associated with the ECCESS[CKBER]
+ * field of the specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the checkbit message being generated.
+ * @param status A pointer to the ECC status structure to generate the
+ * message from.
+ * @param buffer A pointer to the buffer in which to generate the
+ * message.
+ * @param size The size, in bytes, of space available in buffer.
+ *
+ * @return The number of characters generated on success; otherwise, <
+ * 0 on error.
+ */
+static int
+ppc4xx_edac_generate_checkbit_message(const struct mem_ctl_info *mci,
+				      const struct ppc4xx_ecc_status *status,
+				      char *buffer,
+				      size_t size)
+{
+	const char *ckber = NULL;
+
+	switch (status->ecces & SDRAM_ECCES_CKBER_MASK) {
+
+	case SDRAM_ECCES_CKBER_NONE:
+		ckber = "None";
+		break;
+
+	case SDRAM_ECCES_CKBER_32_ECC_0_3:
+		ckber = "ECC0:3";
+		break;
+
+	case SDRAM_ECCES_CKBER_32_ECC_4_8:
+		switch (mfsdram(MCOPT1) & SDRAM_MCOPT1_WDTH_MASK) {
+
+		case SDRAM_MCOPT1_WDTH_16:
+			ckber = "ECC0:3";
+			break;
+
+		case SDRAM_MCOPT1_WDTH_32:
+			ckber = "ECC4:8";
+			break;
+
+		default:
+			ckber = "Unknown";
+			break;
+
+		}
+		break;
+
+	case SDRAM_ECCES_CKBER_32_ECC_0_8:
+		ckber = "ECC0:8";
+		break;
+
+	default:
+		ckber = "Unknown";
+		break;
+
+	}
+
+	return snprintf(buffer, size, "Checkbit Error: %s", ckber);
+}
+
+/**
+ * This routine generates to the provided buffer the portion of the
+ * driver-unique report message associated with the ECCESS[BNCE]
+ * field of the specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the byte lane message being generated.
+ * @param status A pointer to the ECC status structure to generate the
+ * message from.
+ * @param buffer A pointer to the buffer in which to generate the
+ * message.
+ * @param size The size, in bytes, of space available in buffer.
+ *
+ * @return The number of characters generated on success; otherwise, <
+ * 0 on error.
+ */
+static int
+ppc4xx_edac_generate_lane_message(const struct mem_ctl_info *mci,
+				  const struct ppc4xx_ecc_status *status,
+				  char *buffer,
+				  size_t size)
+{
+	int n, total = 0;
+	size_t lane, lanes;
+	const unsigned int first_lane = 0;
+	const unsigned int lane_count = 16;
+
+	n = snprintf(buffer, size, "; Byte Lane Errors: ");
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+	for (lanes = 0, lane = first_lane; lane < lane_count; lane++) {
+		if ((status->ecces & SDRAM_ECCES_BNCE_ENCODE(lane)) != 0) {
+			n = snprintf(buffer, size,
+				     "%s%d",
+				     (lanes++ ? ", " : ""), lane);
+
+			if (n < 0 || n >= size)
+				goto fail;
+
+			buffer += n;
+			size -= n;
+			total += n;
+		}
+	}
+
+	n = snprintf(buffer, size, "%s; ", lanes ? "" : "None");
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+ fail:
+	return total;
+}
+
+/**
+ * This routine generates to the provided buffer the portion of the
+ * driver-unique report message associated with the ECCESS register of
+ * the specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the ECCES message being generated.
+ * @param status A pointer to the ECC status structure to generate the
+ * message from.
+ * @param buffer A pointer to the buffer in which to generate the
+ * message.
+ * @param size The size, in bytes, of space available in buffer.
+ *
+ * @return The number of characters generated on success; otherwise, <
+ * 0 on error.
+ */
+static int
+ppc4xx_edac_generate_ecc_message(const struct mem_ctl_info *mci,
+				 const struct ppc4xx_ecc_status *status,
+				 char *buffer,
+				 size_t size)
+{
+	int n, total = 0;
+
+	n = ppc4xx_edac_generate_bank_message(mci, status, buffer, size);
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+	n = ppc4xx_edac_generate_checkbit_message(mci, status, buffer, size);
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+	n = ppc4xx_edac_generate_lane_message(mci, status, buffer, size);
+
+	if (n < 0 || n >= size)
+		goto fail;
+
+	buffer += n;
+	size -= n;
+	total += n;
+
+ fail:
+	return total;
+}
+
+/**
+ * This routine generates to the provided buffer the portion of the
+ * driver-unique report message associated with the PLB-related BESR
+ * and/or WMIRQ registers of the specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the PLB message being generated.
+ * @param status A pointer to the ECC status structure to generate the
+ * message from.
+ * @param buffer A pointer to the buffer in which to generate the
+ * message.
+ * @param size The size, in bytes, of space available in buffer.
+ *
+ * @return The number of characters generated on success; otherwise, <
+ * 0 on error.
+ */
+static int
+ppc4xx_edac_generate_plb_message(const struct mem_ctl_info *mci,
+				 const struct ppc4xx_ecc_status *status,
+				 char *buffer,
+				 size_t size)
+{
+	unsigned int master;
+	bool read;
+
+	if ((status->besr & SDRAM_BESR_MASK) == 0)
+		return 0;
+
+	if ((status->besr & SDRAM_BESR_M0ET_MASK) == SDRAM_BESR_M0ET_NONE)
+		return 0;
+
+	read = ((status->besr & SDRAM_BESR_M0RW_MASK) == SDRAM_BESR_M0RW_READ);
+
+	master = SDRAM_BESR_M0ID_DECODE(status->besr);
+
+	return snprintf(buffer, size,
+			"%s error w/ PLB master %u \"%s\"; ",
+			(read ? "Read" : "Write"),
+			master,
+			(((master >= SDRAM_PLB_M0ID_FIRST) &&
+			  (master <= SDRAM_PLB_M0ID_LAST)) ?
+			 ppc4xx_plb_masters[master] : "UNKNOWN"));
+}
+
+/**
+ * This routine generates to the provided buffer the driver-unique
+ * EDAC report message from the specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the driver-unique message being generated.
+ * @param status A pointer to the ECC status structure to generate the
+ * message from.
+ * @param buffer A pointer to the buffer in which to generate the
+ * message.
+ * @param size The size, in bytes, of space available in buffer.
+ */
+static void
+ppc4xx_edac_generate_message(const struct mem_ctl_info *mci,
+			     const struct ppc4xx_ecc_status *status,
+			     char *buffer,
+			     size_t size)
+{
+	int n;
+
+	if (buffer == NULL || size == 0)
+		return;
+
+	n = ppc4xx_edac_generate_ecc_message(mci, status, buffer, size);
+
+	if (n < 0 || n >= size)
+		return;
+
+	buffer += n;
+	size -= n;
+
+	ppc4xx_edac_generate_plb_message(mci, status, buffer, size);
+}
+
+#ifdef DEBUG
+/**
+ * This routine dumps to the kernel log buffer the raw and
+ * interpretted specified ECC status.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the status being dumped.
+ * @param status A pointer to the ECC status structure to generate the
+ * dump from.
+ */
+static void
+ppc4xx_ecc_dump_status(const struct mem_ctl_info *mci,
+		       const struct ppc4xx_ecc_status *status)
+{
+	char message[PPC4XX_EDAC_MESSAGE_SIZE];
+
+	ppc4xx_edac_generate_message(mci, status, message, sizeof(message));
+
+	ppc4xx_edac_mc_info(mci,
+			    "\n"
+			    "\tECCES: 0x%08x\n"
+			    "\tWMIRQ: 0x%08x\n"
+			    "\tBESR:  0x%08x\n"
+			    "\tBEAR:  0x%08x%08x\n"
+			    "\t%s\n",
+			    status->ecces,
+			    status->wmirq,
+			    status->besr,
+			    status->bearh,
+			    status->bearl,
+			    message);
+}
+#endif /* DEBUG */
+
+/**
+ * Read and masks, as appropriate, all the relevant status registers
+ * that deal with ibm,sdram-4xx-ddr2 ECC errors. While we read all of
+ * them, for correctable errors, we only expect to deal with
+ * ECCES. For uncorrectable errors, we expect to deal with all of
+ * them.
+ *
+ * @param status A pointer to the ECC status structure to populate the
+ * ECC status with.
+ */
+static void
+ppc4xx_ecc_get_status(struct ppc4xx_ecc_status *status)
+{
+	status->ecces = mfsdram(ECCES) & SDRAM_ECCES_MASK;
+	status->wmirq = mfsdram(WMIRQ) & SDRAM_WMIRQ_MASK;
+	status->besr  = mfsdram(BESR)  & SDRAM_BESR_MASK;
+	status->bearl = mfsdram(BEARL);
+	status->bearh = mfsdram(BEARH);
+}
+
+/**
+ * This routine clears--by writing the masked (as appropriate) status
+ * values back to--the status registers that deal with
+ * ibm,sdram-4xx-ddr2 ECC errors.
+ *
+ * @param status A pointer to the ECC status structure containing the
+ * values to write to clear the ECC status.
+ */
+static void
+ppc4xx_ecc_clear_status(const struct ppc4xx_ecc_status *status)
+{
+	mtsdram(ECCES, status->ecces & SDRAM_ECCES_MASK);
+	mtsdram(WMIRQ, status->wmirq & SDRAM_WMIRQ_MASK);
+	mtsdram(BESR, status->besr & SDRAM_BESR_MASK);
+	mtsdram(BEARL, 0);
+	mtsdram(BEARH, 0);
+}
+
+/**
+ * This routine handles an ibm,sdram-4xx-ddr2 controller ECC
+ * correctable error. Per the aforementioned discussion, there's not
+ * enough status available to use the full EDAC correctable error
+ * interface, so we just pass driver-unique message to the "no info"
+ * interface.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the correctable error being handled and reported.
+ * @param status A pointer to the ECC status structure associated with
+ * the correctable error being handled and reported.
+ */
+static void
+ppc4xx_edac_handle_ce(struct mem_ctl_info *mci,
+		      const struct ppc4xx_ecc_status *status)
+{
+	int row;
+	char message[PPC4XX_EDAC_MESSAGE_SIZE];
+
+	ppc4xx_edac_generate_message(mci, status, message, sizeof(message));
+
+	for (row = 0; row < mci->nr_csrows; row++)
+		if (ppc4xx_edac_check_bank_error(status, row))
+			edac_mc_handle_ce_no_info(mci, message);
+}
+
+/**
+ * This routine handles an ibm,sdram-4xx-ddr2 controller ECC
+ * uncorrectable error.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the uncorrectable error being handled and reported.
+ * @param status A pointer to the ECC status structure associated with
+ * the uncorrectable error being handled and reported.
+ */
+static void
+ppc4xx_edac_handle_ue(struct mem_ctl_info *mci,
+		      const struct ppc4xx_ecc_status *status)
+{
+	const u64 bear = ((u64)status->bearh << 32 | status->bearl);
+	const unsigned long pfn = bear >> PAGE_SHIFT;
+	const unsigned long poff = bear & ~PAGE_MASK;
+	int row;
+	char message[PPC4XX_EDAC_MESSAGE_SIZE];
+
+	ppc4xx_edac_generate_message(mci, status, message, sizeof(message));
+
+	for (row = 0; row < mci->nr_csrows; row++)
+		if (ppc4xx_edac_check_bank_error(status, row))
+			edac_mc_handle_ue(mci, pfn, poff, row, message);
+}
+
+/**
+ * This routine is used to check and post ECC errors and is called by
+ * both the EDAC polling thread and this driver's CE and UE interrupt
+ * handler.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the ibm,sdram-4xx-ddr2 controller being checked.
+ */
+static void
+ppc4xx_edac_check(struct mem_ctl_info *mci)
+{
+#ifdef DEBUG
+	static unsigned int count;
+#endif
+	struct ppc4xx_ecc_status status;
+
+	ppc4xx_ecc_get_status(&status);
+
+#ifdef DEBUG
+	if (count++ % 30 == 0)
+		ppc4xx_ecc_dump_status(mci, &status);
+#endif
+
+	if (status.ecces & SDRAM_ECCES_UE)
+		ppc4xx_edac_handle_ue(mci, &status);
+
+	if (status.ecces & SDRAM_ECCES_CE)
+		ppc4xx_edac_handle_ce(mci, &status);
+
+	ppc4xx_ecc_clear_status(&status);
+}
+
+/**
+ * This routine implements the interrupt handler for both correctable
+ * and uncorrectable ECC errors for the ibm,sdram-4xx-ddr2
+ * controller. It simply calls through to the same routine used during
+ * polling to check, report and clear the ECC status.
+ *
+ * @param irq The virtual interrupt number being serviced
+ * @param dev_id
+ *
+ * @return
+ */
+static irqreturn_t
+ppc4xx_edac_isr(int irq, void *dev_id)
+{
+	struct mem_ctl_info *mci = (struct mem_ctl_info *)dev_id;
+
+	ppc4xx_edac_check(mci);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * This routine returns the EDAC device type width appropriate for the
+ * current controller configuration.
+ *
+ * TODO: This needs to be conditioned dynamically through feature
+ * flags or some such when other controller variants are supported as
+ * the 405EX[r] is 16-/32-bit and the others are 32-/64-bit with the
+ * 16- and 64-bit field definition/value/enumeration (b1) overloaded
+ * among them.
+ *
+ * @param mcopt1 The 32-bit Memory Controller Option 1 register value
+ * currently set for the controller, from which the width is derived.
+ *
+ * @return A device type width enumeration.
+ */
+static enum dev_type __devinit
+ppc4xx_edac_get_dtype(u32 mcopt1)
+{
+	switch (mcopt1 & SDRAM_MCOPT1_WDTH_MASK) {
+
+	case SDRAM_MCOPT1_WDTH_16:
+		return DEV_X2;
+
+	case SDRAM_MCOPT1_WDTH_32:
+		return DEV_X4;
+
+	default:
+		return DEV_UNKNOWN;
+	}
+}
+
+/**
+ * This routine returns the EDAC memory type appropriate for the
+ * current controller configuration.
+ *
+ * @param The 32-bit Memory Controller Option 1 register value
+ * currently set for the controller, from which the memory type is
+ * derived.
+ *
+ * @return A memory type enumeration.
+ */
+static enum mem_type __devinit
+ppc4xx_edac_get_mtype(u32 mcopt1)
+{
+	bool rden = ((mcopt1 & SDRAM_MCOPT1_RDEN_MASK) == SDRAM_MCOPT1_RDEN);
+
+	switch (mcopt1 & SDRAM_MCOPT1_DDR_TYPE_MASK) {
+
+	case SDRAM_MCOPT1_DDR2_TYPE:
+		return rden ? MEM_RDDR2 : MEM_DDR2;
+
+	case SDRAM_MCOPT1_DDR1_TYPE:
+		return rden ? MEM_RDDR : MEM_DDR;
+
+	default:
+		return MEM_UNKNOWN;
+
+	}
+}
+
+/**
+ * This routine intializes the virtual "chip select rows" associated
+ * with the EDAC memory controller instance. An ibm,sdram-4xx-ddr2
+ * controller bank/rank is mapped to a row.
+ *
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the ibm,sdram-4xx-ddr2 controller for which the
+ * csrows (i.e. banks/ranks) are being initialized.
+ * @param mcopt1 The 32-bit Memory Controller Option 1 register value
+ * currently set for the controller, from which bank width and memory
+ * typ information is derived.
+ *
+ * @return 0 if OK; otherwise, -EINVAL if the memory bank size
+ * configuration cannot be determined.
+ */
+static int __devinit
+ppc4xx_edac_init_csrows(struct mem_ctl_info *mci, u32 mcopt1)
+{
+	int status = 0;
+	enum mem_type mtype;
+	enum dev_type dtype;
+	enum edac_type edac_mode;
+	int row;
+	u32 mbxcf, size;
+	static u32 ppc4xx_last_page;
+
+	/* Establish the memory type and width */
+
+	mtype = ppc4xx_edac_get_mtype(mcopt1);
+	dtype = ppc4xx_edac_get_dtype(mcopt1);
+
+	/* Establish EDAC mode */
+
+	if (mci->edac_cap & EDAC_FLAG_SECDED)
+		edac_mode = EDAC_SECDED;
+	else if (mci->edac_cap & EDAC_FLAG_EC)
+		edac_mode = EDAC_EC;
+	else
+		edac_mode = EDAC_NONE;
+
+	/*
+	 * Initialize each chip select row structure which correspond
+	 * 1:1 with a controller bank/rank.
+	 */
+
+	for (row = 0; row < mci->nr_csrows; row++) {
+		struct csrow_info *csi = &mci->csrows[row];
+
+		/*
+		 * Get the configuration settings for this
+		 * row/bank/rank and skip disabled banks.
+		 */
+
+		mbxcf = mfsdram(MBXCF(row));
+
+		if ((mbxcf & SDRAM_MBCF_BE_MASK) != SDRAM_MBCF_BE_ENABLE)
+			continue;
+
+		/* Map the bank configuration size setting to pages. */
+
+		size = mbxcf & SDRAM_MBCF_SZ_MASK;
+
+		switch (size) {
+
+		case SDRAM_MBCF_SZ_4MB:
+		case SDRAM_MBCF_SZ_8MB:
+		case SDRAM_MBCF_SZ_16MB:
+		case SDRAM_MBCF_SZ_32MB:
+		case SDRAM_MBCF_SZ_64MB:
+		case SDRAM_MBCF_SZ_128MB:
+		case SDRAM_MBCF_SZ_256MB:
+		case SDRAM_MBCF_SZ_512MB:
+		case SDRAM_MBCF_SZ_1GB:
+		case SDRAM_MBCF_SZ_2GB:
+		case SDRAM_MBCF_SZ_4GB:
+		case SDRAM_MBCF_SZ_8GB:
+			csi->nr_pages = SDRAM_MBCF_SZ_TO_PAGES(size);
+			break;
+
+		default:
+			ppc4xx_edac_mc_err(mci,
+					   "Unrecognized memory bank %d size "
+					   "0x%08x\n",
+					   row, SDRAM_MBCF_SZ_DECODE(size));
+			status = -EINVAL;
+			goto done;
+		}
+
+		csi->first_page = ppc4xx_last_page;
+		csi->last_page	= csi->first_page + csi->nr_pages - 1;
+		csi->page_mask	= 0;
+
+		/*
+		 * It's unclear exactly what grain should be set to
+		 * here. The SDRAM_ECCES register allows resolution of
+		 * an error down to a nibble which would potentially
+		 * argue for a grain of '1' byte, even though we only
+		 * know the associated addres for uncorrectable
+		 * errors. This value is not used at present for
+		 * anything other than error reporting so getting it
+		 * wrong should be of little consequence. Other
+		 * possible values would be the PLB width (16), the
+		 * page size (PAGE_SIZE) or the memory width (2 or 4).
+		 */
+
+		csi->grain	= 1;
+
+		csi->mtype	= mtype;
+		csi->dtype	= dtype;
+
+		csi->edac_mode	= edac_mode;
+
+		ppc4xx_last_page += csi->nr_pages;
+	}
+
+ done:
+	return status;
+}
+
+/**
+ * This routine performs initialization of the EDAC memory controller
+ * instance and related driver-private data associated with the
+ * ibm,sdram-4xx-ddr2 memory controller the instance is bound to.
+ *
+ * @param mci A pointer to the EDAC memory controller instance being
+ * initialized.
+ * @param op A pointer to the OpenFirmware device tree node associated
+ * with the controller this EDAC instance is bound to.
+ * @param match A pointer to the OpenFirmware device tree match
+ * information associated with the controller this EDAC instance is
+ * bound to.
+ * @param mcopt1 The 32-bit Memory Controller Option 1 register value
+ * currently set for the controller, from which ECC capabilities and
+ * scrub mode are derived.
+ *
+ * @return 0 if OK; otherwise, < 0 on error.
+ */
+static int __devinit
+ppc4xx_edac_mc_init(struct mem_ctl_info *mci,
+		    struct of_device *op,
+		    const struct of_device_id *match,
+		    u32 mcopt1)
+{
+	int status = 0;
+	const u32 memcheck = (mcopt1 & SDRAM_MCOPT1_MCHK_MASK);
+	struct ppc4xx_edac_pdata *pdata = NULL;
+	const struct device_node *np = op->node;
+
+	/* Initial private data and driver pointers */
+
+	mci->dev = &op->dev;
+
+	dev_set_drvdata(mci->dev, mci);
+
+	pdata = mci->pvt_info;
+
+	pdata->irqs.sec = NO_IRQ;
+	pdata->irqs.ded = NO_IRQ;
+
+	/* Initialize controller capabilities and configuration */
+
+	mci->mtype_cap		= (MEM_FLAG_DDR | MEM_FLAG_RDDR |
+				   MEM_FLAG_DDR2 | MEM_FLAG_RDDR2);
+
+	mci->edac_ctl_cap	= (EDAC_FLAG_NONE |
+				   EDAC_FLAG_EC |
+				   EDAC_FLAG_SECDED);
+
+	mci->scrub_cap		= SCRUB_NONE;
+	mci->scrub_mode		= SCRUB_NONE;
+
+	/*
+	 * Update the actual capabilites based on the MCOPT1[MCHK]
+	 * settings. Scrubbing is only useful if reporting is enabled.
+	 */
+
+	switch (memcheck) {
+
+	case SDRAM_MCOPT1_MCHK_CHK:
+		mci->edac_cap	= EDAC_FLAG_EC;
+		break;
+
+	case SDRAM_MCOPT1_MCHK_CHK_REP:
+		mci->edac_cap	= (EDAC_FLAG_EC | EDAC_FLAG_SECDED);
+		mci->scrub_mode	= SCRUB_SW_SRC;
+		break;
+
+	default:
+		mci->edac_cap	= EDAC_FLAG_NONE;
+		break;
+
+	}
+
+	/* Initialize strings */
+
+	mci->mod_name		= PPC4XX_EDAC_MODULE_NAME;
+	mci->mod_ver		= PPC4XX_EDAC_MODULE_REVISION;
+	mci->ctl_name		= match->compatible,
+	mci->dev_name		= np->full_name;
+
+	/* Initialize callbacks */
+
+	mci->edac_check		= ppc4xx_edac_check;
+	mci->ctl_page_to_phys	= NULL;
+
+	/* Initialize chip select rows */
+
+	status = ppc4xx_edac_init_csrows(mci, mcopt1);
+
+	if (status)
+		ppc4xx_edac_mc_warning(mci, "Failed to initialize rows!\n");
+
+	return status;
+}
+
+/**
+ * This routine parses the correctable and uncorrectable error
+ * interrupts from the device tree node and maps and assigns them to
+ * the associated EDAC memory controller instance.
+ *
+ * @param op A pointer to the OpenFirmware device tree node associated
+ * with the controller this EDAC instance is bound to.
+ * @param mci A pointer to the EDAC memory controller instance
+ * associated with the ibm,sdram-4xx-ddr2 controller for which
+ * interrupts are being registered.
+ *
+ * @return 0 if OK; otherwise, -ENODEV if the interrupts could not be
+ * mapped and assigned.
+ */
+static int __devinit
+ppc4xx_edac_register_irq(struct of_device *op, struct mem_ctl_info *mci)
+{
+	int status = 0;
+	int ded_irq, sec_irq;
+	struct ppc4xx_edac_pdata *pdata = mci->pvt_info;
+	struct device_node *np = op->node;
+
+	ded_irq = irq_of_parse_and_map(np, INTMAP_ECCDED_INDEX);
+	sec_irq = irq_of_parse_and_map(np, INTMAP_ECCSEC_INDEX);
+
+	if (ded_irq == NO_IRQ || sec_irq == NO_IRQ) {
+		ppc4xx_edac_mc_err(mci, "Unable to map interrupts.\n");
+		status = -ENODEV;
+		goto fail;
+	}
+
+	status = request_irq(ded_irq,
+			     ppc4xx_edac_isr,
+			     IRQF_DISABLED,
+			     "[EDAC] MC ECCDED",
+			     mci);
+
+	if (status < 0) {
+		ppc4xx_edac_mc_err(mci, "Unable to request irq %d for ECC DED",
+				   ded_irq);
+		status = -ENODEV;
+		goto fail1;
+	}
+
+	status = request_irq(sec_irq,
+			     ppc4xx_edac_isr,
+			     IRQF_DISABLED,
+			     "[EDAC] MC ECCSEC",
+			     mci);
+
+	if (status < 0) {
+		ppc4xx_edac_mc_err(mci, "Unable to request irq %d for ECC SEC",
+				   sec_irq);
+		status = -ENODEV;
+		goto fail2;
+	}
+
+	ppc4xx_edac_mc_info(mci, "ECCDED irq is %d\n", ded_irq);
+	ppc4xx_edac_mc_info(mci, "ECCSEC irq is %d\n", sec_irq);
+
+	pdata->irqs.ded = ded_irq;
+	pdata->irqs.sec = sec_irq;
+
+	return 0;
+
+ fail2:
+	free_irq(sec_irq, mci);
+
+ fail1:
+	free_irq(ded_irq, mci);
+
+ fail:
+	return status;
+}
+
+/**
+ * This routine probes a specific ibm,sdram-4xx-ddr2 controller
+ * instance for binding with the driver.
+ *
+ * @param op A pointer to the OpenFirmware device tree node associated
+ * with the controller being probed for driver binding.
+ * @param match A pointer to the OpenFirmware device tree match
+ * information associated with the controller being probed for driver
+ * binding.
+ *
+ * @return 0 if the controller instance was successfully bound to the
+ * driver; otherwise, < 0 on error.
+ */
+static int __devinit
+ppc4xx_edac_probe(struct of_device *op, const struct of_device_id *match)
+{
+	int status = 0;
+	u32 mcopt1, memcheck;
+	const struct device_node *np = op->node;
+	struct mem_ctl_info *mci = NULL;
+	static int ppc4xx_edac_index;
+
+	/*
+	 * At this point, we only support the controller realized on
+	 * the AMCC PPC 405EX[r]. Reject anything else.
+	 */
+
+	if (!of_device_is_compatible(np, "ibm,sdram-405ex") &&
+	    !of_device_is_compatible(np, "ibm,sdram-405exr")) {
+		ppc4xx_edac_notice("Only the PPC405EX[r] is supported.\n");
+		return -ENODEV;
+	}
+
+	/*
+	 * First determine whether ECC is enabled at all. If not,
+	 * there is no useful checking or monitoring that can be done
+	 * for this controller.
+	 */
+
+	mcopt1 = mfsdram(MCOPT1);
+	memcheck = (mcopt1 & SDRAM_MCOPT1_MCHK_MASK);
+
+	if (memcheck == SDRAM_MCOPT1_MCHK_NON) {
+		ppc4xx_edac_info("%s: No ECC memory detected or "
+				 "ECC is disabled.\n", np->full_name);
+		status = -ENODEV;
+		goto done;
+	}
+
+	/*
+	 * At this point, we know ECC is enabled, allocate an EDAC
+	 * controller instance and perform the appropriate
+	 * initialization.
+	 */
+
+	mci = edac_mc_alloc(sizeof(struct ppc4xx_edac_pdata),
+			    ppc4xx_edac_nr_csrows,
+			    ppc4xx_edac_nr_chans,
+			    ppc4xx_edac_index);
+
+	if (mci == NULL) {
+		ppc4xx_edac_warning("%s: "
+				    "failed to allocate EDAC MC instance!\n",
+				    np->full_name);
+		status = -ENOMEM;
+		goto done;
+	}
+
+	status = ppc4xx_edac_mc_init(mci, op, match, mcopt1);
+
+	if (status) {
+		ppc4xx_edac_mc_warning(mci,
+				       "Failed to initialize instance!\n");
+		goto fail;
+	}
+
+	/*
+	 * We have a valid, initialized EDAC instance bound to the
+	 * controller. Attempt to register it with the EDAC subsystem
+	 * and, if necessary, register interrupts.
+	 */
+
+	if (edac_mc_add_mc(mci)) {
+		ppc4xx_edac_mc_warning(mci, "Failed to add instance!\n");
+		status = -ENODEV;
+		goto fail;
+	}
+
+	if (edac_op_state == EDAC_OPSTATE_INT) {
+		status = ppc4xx_edac_register_irq(op, mci);
+
+		if (status)
+			goto fail1;
+	}
+
+	ppc4xx_edac_index++;
+
+	return 0;
+
+ fail1:
+	edac_mc_del_mc(mci->dev);
+
+ fail:
+	edac_mc_free(mci);
+
+ done:
+	return status;
+}
+
+/**
+ * This routine unbinds the EDAC memory controller instance associated
+ * with the specified ibm,sdram-4xx-ddr2 controller described by the
+ * OpenFirmware device tree node passed as a parameter.
+ *
+ * @param op A pointer to the OpenFirmware device tree node associated
+ * with the controller this EDAC instance is to be unbound/removed from.
+ *
+ * @return Unconditionally 0.
+ */
+static int
+ppc4xx_edac_remove(struct of_device *op)
+{
+	struct mem_ctl_info *mci = dev_get_drvdata(&op->dev);
+	struct ppc4xx_edac_pdata *pdata = mci->pvt_info;
+
+	if (edac_op_state == EDAC_OPSTATE_INT) {
+		free_irq(pdata->irqs.sec, mci);
+		free_irq(pdata->irqs.ded, mci);
+	}
+
+	edac_mc_del_mc(mci->dev);
+	edac_mc_free(mci);
+
+	return 0;
+}
+
+/**
+ * This routine ensures that the EDAC memory controller reporting
+ * method is mapped to a sane value as the EDAC core defines the value
+ * to EDAC_OPSTATE_INVAL by default. We don't call the global
+ * opstate_init as that defaults to polling and we want interrupt as
+ * the default.
+ */
+static void inline __init
+ppc4xx_edac_opstate_init(void)
+{
+	switch (edac_op_state) {
+
+	case EDAC_OPSTATE_POLL:
+	case EDAC_OPSTATE_INT:
+		break;
+
+	default:
+		edac_op_state = EDAC_OPSTATE_INT;
+		break;
+	}
+
+	ppc4xx_edac_info("Reporting type: %s\n",
+			 ((edac_op_state == EDAC_OPSTATE_POLL) ?
+			  EDAC_OPSTATE_POLL_STR :
+			  ((edac_op_state == EDAC_OPSTATE_INT) ?
+			   EDAC_OPSTATE_INT_STR :
+			   EDAC_OPSTATE_UNKNOWN_STR)));
+}
+
+/**
+ * This routine is the driver/module insertion entry point. It
+ * initializes the EDAC memory controller reporting state and
+ * registers the driver as an OpenFirmware device tree platform
+ * driver.
+ */
+static int __init
+ppc4xx_edac_init(void)
+{
+	ppc4xx_edac_opstate_init();
+
+	return of_register_platform_driver(&ppc4xx_edac_driver);
+}
+
+/**
+ * This routine is the driver/module removal entry point. It
+ * unregisters the driver as an OpenFirmware device tree platform
+ * driver.
+ */
+static void __exit
+ppc4xx_edac_exit(void)
+{
+	of_unregister_platform_driver(&ppc4xx_edac_driver);
+}
+
+module_init(ppc4xx_edac_init);
+module_exit(ppc4xx_edac_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Grant Erickson <gerickson@nuovations.com>");
+MODULE_DESCRIPTION("EDAC Driver for the PPC4xx IBM DDR2 Memory Controller");
+module_param(edac_op_state, int, 0444);
+MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting State: "
+		 "0=" EDAC_OPSTATE_POLL_STR ", 2=" EDAC_OPSTATE_INT_STR);
diff --git a/drivers/edac/ppc4xx_edac.h b/drivers/edac/ppc4xx_edac.h
new file mode 100644
index 0000000..639449e
--- /dev/null
+++ b/drivers/edac/ppc4xx_edac.h
@@ -0,0 +1,179 @@
+/*
+ * Copyright (c) 2008 Nuovation System Designs, LLC
+ *   Grant Erickson <gerickson@nuovations.com>
+ *
+ * This file defines processor mnemonics for accessing and managing
+ * the IBM DDR1/DDR2 ECC controller found in the 405EX[r], 440SP,
+ * 440SPe, 460EX, 460GT and 460SX.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#ifndef __PPC4XX_EDAC_H
+#define __PPC4XX_EDAC_H
+
+#include <linux/types.h>
+
+/*
+ * Macro for generating register field mnemonics
+ */
+#define PPC_REG_BITS			32
+#define PPC_REG_VAL(bit, val)		((val) << ((PPC_REG_BITS - 1) - (bit)))
+#define PPC_REG_DECODE(bit, val)	((val) >> ((PPC_REG_BITS - 1) - (bit)))
+
+/*
+ * IBM 4xx DDR1/DDR2 SDRAM indirect Device Control Registers (DCRs)
+ */
+#define	DCRN_SDRAM0_BASE		0x010
+#define DCRN_SDRAM0_CONFIG_ADDR		(DCRN_SDRAM0_BASE+0x0)
+#define DCRN_SDRAM0_CONFIG_DATA		(DCRN_SDRAM0_BASE+0x1)
+
+/*
+ * IBM 4xx DDR1/DDR2 SDRAM memory controller registers (at least those
+ * relevant to ECC)
+ */
+#define SDRAM_BESR			0x00	/* Error status (read/clear) */
+#define SDRAM_BESRT			0x01	/* Error statuss (test/set)  */
+#define SDRAM_BEARL			0x02	/* Error address low	     */
+#define SDRAM_BEARH			0x03	/* Error address high	     */
+#define SDRAM_WMIRQ			0x06	/* Write master (read/clear) */
+#define SDRAM_WMIRQT			0x07	/* Write master (test/set)   */
+#define SDRAM_MCOPT1			0x20	/* Controller options 1	     */
+#define SDRAM_MBXCF_BASE		0x40	/* Bank n configuration base */
+#define	SDRAM_MBXCF(n)			(SDRAM_MBXCF_BASE + (4 * (n)))
+#define SDRAM_MB0CF			SDRAM_MBXCF(0)
+#define SDRAM_MB1CF			SDRAM_MBXCF(1)
+#define SDRAM_MB2CF			SDRAM_MBXCF(2)
+#define SDRAM_MB3CF			SDRAM_MBXCF(3)
+#define SDRAM_ECCCR			0x98	/* ECC error status	     */
+#define SDRAM_ECCES			SDRAM_ECCCR
+
+/*
+ * PLB Master IDs
+ */
+#define	SDRAM_PLB_M0ID_FIRST		0
+#define	SDRAM_PLB_M0ID_ICU		SDRAM_PLB_M0ID_FIRST
+#define	SDRAM_PLB_M0ID_PCIE0		1
+#define	SDRAM_PLB_M0ID_PCIE1		2
+#define	SDRAM_PLB_M0ID_DMA		3
+#define	SDRAM_PLB_M0ID_DCU		4
+#define	SDRAM_PLB_M0ID_OPB		5
+#define	SDRAM_PLB_M0ID_MAL		6
+#define	SDRAM_PLB_M0ID_SEC		7
+#define	SDRAM_PLB_M0ID_AHB		8
+#define SDRAM_PLB_M0ID_LAST		SDRAM_PLB_M0ID_AHB
+#define SDRAM_PLB_M0ID_COUNT		(SDRAM_PLB_M0ID_LAST - \
+					 SDRAM_PLB_M0ID_FIRST + 1)
+
+/*
+ * Memory Controller Bus Error Status Register
+ */
+#define SDRAM_BESR_MASK			PPC_REG_VAL(7, 0xFF)
+#define SDRAM_BESR_M0ID_MASK		PPC_REG_VAL(3, 0xF)
+#define	SDRAM_BESR_M0ID_DECODE(n)	PPC_REG_DECODE(3, n)
+#define SDRAM_BESR_M0ID_ICU		PPC_REG_VAL(3, SDRAM_PLB_M0ID_ICU)
+#define SDRAM_BESR_M0ID_PCIE0		PPC_REG_VAL(3, SDRAM_PLB_M0ID_PCIE0)
+#define SDRAM_BESR_M0ID_PCIE1		PPC_REG_VAL(3, SDRAM_PLB_M0ID_PCIE1)
+#define SDRAM_BESR_M0ID_DMA		PPC_REG_VAL(3, SDRAM_PLB_M0ID_DMA)
+#define SDRAM_BESR_M0ID_DCU		PPC_REG_VAL(3, SDRAM_PLB_M0ID_DCU)
+#define SDRAM_BESR_M0ID_OPB		PPC_REG_VAL(3, SDRAM_PLB_M0ID_OPB)
+#define SDRAM_BESR_M0ID_MAL		PPC_REG_VAL(3, SDRAM_PLB_M0ID_MAL)
+#define SDRAM_BESR_M0ID_SEC		PPC_REG_VAL(3, SDRAM_PLB_M0ID_SEC)
+#define SDRAM_BESR_M0ID_AHB		PPC_REG_VAL(3, SDRAM_PLB_M0ID_AHB)
+#define SDRAM_BESR_M0ET_MASK		PPC_REG_VAL(6, 0x7)
+#define SDRAM_BESR_M0ET_NONE		PPC_REG_VAL(6, 0)
+#define SDRAM_BESR_M0ET_ECC		PPC_REG_VAL(6, 1)
+#define SDRAM_BESR_M0RW_MASK		PPC_REG_VAL(7, 1)
+#define SDRAM_BESR_M0RW_WRITE		PPC_REG_VAL(7, 0)
+#define SDRAM_BESR_M0RW_READ		PPC_REG_VAL(7, 1)
+
+/*
+ * Memory Controller PLB Write Master Interrupt Register
+ */
+#define SDRAM_WMIRQ_MASK		PPC_REG_VAL(8, 0x1FF)
+#define	SDRAM_WMIRQ_ENCODE(id)		PPC_REG_VAL((id % \
+						     SDRAM_PLB_M0ID_COUNT), 1)
+#define SDRAM_WMIRQ_ICU			PPC_REG_VAL(SDRAM_PLB_M0ID_ICU, 1)
+#define SDRAM_WMIRQ_PCIE0		PPC_REG_VAL(SDRAM_PLB_M0ID_PCIE0, 1)
+#define SDRAM_WMIRQ_PCIE1		PPC_REG_VAL(SDRAM_PLB_M0ID_PCIE1, 1)
+#define SDRAM_WMIRQ_DMA			PPC_REG_VAL(SDRAM_PLB_M0ID_DMA, 1)
+#define SDRAM_WMIRQ_DCU			PPC_REG_VAL(SDRAM_PLB_M0ID_DCU, 1)
+#define SDRAM_WMIRQ_OPB			PPC_REG_VAL(SDRAM_PLB_M0ID_OPB, 1)
+#define SDRAM_WMIRQ_MAL			PPC_REG_VAL(SDRAM_PLB_M0ID_MAL, 1)
+#define SDRAM_WMIRQ_SEC			PPC_REG_VAL(SDRAM_PLB_M0ID_SEC, 1)
+#define SDRAM_WMIRQ_AHB			PPC_REG_VAL(SDRAM_PLB_M0ID_AHB, 1)
+
+/*
+ * Memory Controller Options 1 Register
+ */
+#define SDRAM_MCOPT1_MCHK_MASK	    PPC_REG_VAL(3, 0x3)	 /* ECC mask	     */
+#define SDRAM_MCOPT1_MCHK_NON	    PPC_REG_VAL(3, 0x0)	 /* No ECC gen	     */
+#define SDRAM_MCOPT1_MCHK_GEN	    PPC_REG_VAL(3, 0x2)	 /* ECC gen	     */
+#define SDRAM_MCOPT1_MCHK_CHK	    PPC_REG_VAL(3, 0x1)	 /* ECC gen and chk  */
+#define SDRAM_MCOPT1_MCHK_CHK_REP   PPC_REG_VAL(3, 0x3)	 /* ECC gen/chk/rpt  */
+#define SDRAM_MCOPT1_MCHK_DECODE(n) ((((u32)(n)) >> 28) & 0x3)
+#define SDRAM_MCOPT1_RDEN_MASK	    PPC_REG_VAL(4, 0x1)	 /* Rgstrd DIMM mask */
+#define SDRAM_MCOPT1_RDEN	    PPC_REG_VAL(4, 0x1)	 /* Rgstrd DIMM enbl */
+#define SDRAM_MCOPT1_WDTH_MASK	    PPC_REG_VAL(7, 0x1)	 /* Width mask	     */
+#define SDRAM_MCOPT1_WDTH_32	    PPC_REG_VAL(7, 0x0)	 /* 32 bits	     */
+#define SDRAM_MCOPT1_WDTH_16	    PPC_REG_VAL(7, 0x1)	 /* 16 bits	     */
+#define SDRAM_MCOPT1_DDR_TYPE_MASK  PPC_REG_VAL(11, 0x1) /* DDR type mask    */
+#define SDRAM_MCOPT1_DDR1_TYPE	    PPC_REG_VAL(11, 0x0) /* DDR1 type	     */
+#define SDRAM_MCOPT1_DDR2_TYPE	    PPC_REG_VAL(11, 0x1) /* DDR2 type	     */
+
+/*
+ * Memory Bank 0 - n Configuration Register
+ */
+#define SDRAM_MBCF_BA_MASK		PPC_REG_VAL(12, 0x1FFF)
+#define SDRAM_MBCF_SZ_MASK		PPC_REG_VAL(19, 0xF)
+#define SDRAM_MBCF_SZ_DECODE(mbxcf)	PPC_REG_DECODE(19, mbxcf)
+#define SDRAM_MBCF_SZ_4MB		PPC_REG_VAL(19, 0x0)
+#define SDRAM_MBCF_SZ_8MB		PPC_REG_VAL(19, 0x1)
+#define SDRAM_MBCF_SZ_16MB		PPC_REG_VAL(19, 0x2)
+#define SDRAM_MBCF_SZ_32MB		PPC_REG_VAL(19, 0x3)
+#define SDRAM_MBCF_SZ_64MB		PPC_REG_VAL(19, 0x4)
+#define SDRAM_MBCF_SZ_128MB		PPC_REG_VAL(19, 0x5)
+#define SDRAM_MBCF_SZ_256MB		PPC_REG_VAL(19, 0x6)
+#define SDRAM_MBCF_SZ_512MB		PPC_REG_VAL(19, 0x7)
+#define SDRAM_MBCF_SZ_1GB		PPC_REG_VAL(19, 0x8)
+#define SDRAM_MBCF_SZ_2GB		PPC_REG_VAL(19, 0x9)
+#define SDRAM_MBCF_SZ_4GB		PPC_REG_VAL(19, 0xA)
+#define SDRAM_MBCF_SZ_8GB		PPC_REG_VAL(19, 0xB)
+#define SDRAM_MBCF_AM_MASK		PPC_REG_VAL(23, 0xF)
+#define SDRAM_MBCF_AM_MODE0		PPC_REG_VAL(23, 0x0)
+#define SDRAM_MBCF_AM_MODE1		PPC_REG_VAL(23, 0x1)
+#define SDRAM_MBCF_AM_MODE2		PPC_REG_VAL(23, 0x2)
+#define SDRAM_MBCF_AM_MODE3		PPC_REG_VAL(23, 0x3)
+#define SDRAM_MBCF_AM_MODE4		PPC_REG_VAL(23, 0x4)
+#define SDRAM_MBCF_AM_MODE5		PPC_REG_VAL(23, 0x5)
+#define SDRAM_MBCF_AM_MODE6		PPC_REG_VAL(23, 0x6)
+#define SDRAM_MBCF_AM_MODE7		PPC_REG_VAL(23, 0x7)
+#define SDRAM_MBCF_AM_MODE8		PPC_REG_VAL(23, 0x8)
+#define SDRAM_MBCF_AM_MODE9		PPC_REG_VAL(23, 0x9)
+#define SDRAM_MBCF_BE_MASK		PPC_REG_VAL(31, 0x1)
+#define SDRAM_MBCF_BE_DISABLE		PPC_REG_VAL(31, 0x0)
+#define SDRAM_MBCF_BE_ENABLE		PPC_REG_VAL(31, 0x1)
+
+/*
+ * ECC Error Status
+ */
+#define SDRAM_ECCES_MASK		PPC_REG_VAL(21, 0x3FFFFF)
+#define SDRAM_ECCES_BNCE_MASK		PPC_REG_VAL(15, 0xFFFF)
+#define SDRAM_ECCES_BNCE_ENCODE(lane)	PPC_REG_VAL(((lane) & 0xF), 1)
+#define SDRAM_ECCES_CKBER_MASK		PPC_REG_VAL(17, 0x3)
+#define SDRAM_ECCES_CKBER_NONE		PPC_REG_VAL(17, 0)
+#define SDRAM_ECCES_CKBER_16_ECC_0_3	PPC_REG_VAL(17, 2)
+#define SDRAM_ECCES_CKBER_32_ECC_0_3	PPC_REG_VAL(17, 1)
+#define SDRAM_ECCES_CKBER_32_ECC_4_8	PPC_REG_VAL(17, 2)
+#define SDRAM_ECCES_CKBER_32_ECC_0_8	PPC_REG_VAL(17, 3)
+#define SDRAM_ECCES_CE			PPC_REG_VAL(18, 1)
+#define SDRAM_ECCES_UE			PPC_REG_VAL(19, 1)
+#define SDRAM_ECCES_BKNER_MASK		PPC_REG_VAL(21, 0x3)
+#define SDRAM_ECCES_BK0ER		PPC_REG_VAL(20, 1)
+#define SDRAM_ECCES_BK1ER		PPC_REG_VAL(21, 1)
+
+#endif /* __PPC4XX_EDAC_H */
