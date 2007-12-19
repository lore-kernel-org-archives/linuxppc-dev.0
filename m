Return-Path: <Tony.Li@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9B819DDE42
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 20:03:16 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	lBJ918NN020383
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 02:03:03 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id lBJ916uH021477
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:01:07 -0600 (CST)
Subject: [patch] mpc83xx: Add MPC837x PCIE controller RC mode support
From: Li Li <r64360@freescale.com>
To: Kumar Gala <kumar.gala@freescale.com>,
	kim phillips <Kim.Phillips@freescale.com>,
	Wood Scott <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 19 Dec 2007 16:48:13 +0800
Message-Id: <1198054093.6787.5.camel@Guyver>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Initial the MPC837x PCIE controller.
Note that configue address bit field is not compatible with PCIE spec 10a.
Just map first 16M pci configure space which corresponding to a bus configure space at boot.


Signed-off-by: Tony Li <tony.li@freescale.com>
---
 Makefile                                  |   17 ++-
 board/freescale/mpc837xemds/Makefile      |    2 +-
 board/freescale/mpc837xemds/mpc837xemds.c |    3 +
 board/freescale/mpc837xemds/pci.c         |    3 +-
 board/freescale/mpc837xemds/pcie.c        |   95 +++++++++
 cpu/mpc83xx/Makefile                      |    2 +-
 cpu/mpc83xx/pcie.c                        |  315 +++++++++++++++++++++++++++++
 doc/README.mpc837xemds                    |    6 +
 include/asm-ppc/immap_83xx.h              |  119 ++++++++++-
 include/configs/MPC837XEMDS.h             |   23 ++-
 include/mpc83xx.h                         |   42 ++++
 include/pci.h                             |    4 +
 12 files changed, 619 insertions(+), 12 deletions(-)
 create mode 100644 board/freescale/mpc837xemds/pcie.c
 create mode 100644 cpu/mpc83xx/pcie.c

diff --git a/Makefile b/Makefile
index f8a038a..5934f77 100644
--- a/Makefile
+++ b/Makefile
@@ -1831,13 +1831,26 @@ MPC8360EMDS_SLAVE_config:	unconfig
 	@$(MKCONFIG) -a MPC8360EMDS ppc mpc83xx mpc8360emds freescale
 
 MPC837XEMDS_config \
-MPC837XEMDS_HOST_config:	unconfig
+MPC837XEMDS_HOST_config \
+MPC837XEMDS_PCIE_config \
+MPC837XEMDS_PCIE_X2_config:	unconfig
 	@mkdir -p $(obj)include
 	@echo "" >$(obj)include/config.h ; \
 	if [ "$(findstring _HOST_,$@)" ] ; then \
 		echo -n "... PCI HOST " ; \
 		echo "#define CONFIG_PCI" >>$(obj)include/config.h ; \
-	fi ;
+		echo "#define CONFIG_PQ_MDS_PIB" >>$(obj)include/config.h ; \
+	fi ; \
+	if [ "$(findstring _PCIE_,$@)" ] ; then\
+		echo -n "... PCIE "; \
+		echo "#define CONFIG_PCI" >>$(obj)include/config.h ; \
+		echo "#define CONFIG_PCIE" >>$(obj)include/config.h ; \
+	fi; \
+	if [ "$(findstring _PCIE_X2_,$@)" ] ; then\
+		echo -n "_X2 "; \
+		echo "#define CONFIG_PCIE_X2" >>$(obj)include/config.h ; \
+	fi;
+
 	@$(MKCONFIG) -a MPC837XEMDS ppc mpc83xx mpc837xemds freescale
 
 sbc8349_config:		unconfig
diff --git a/board/freescale/mpc837xemds/Makefile b/board/freescale/mpc837xemds/Makefile
index 3cffcfb..319ebc2 100644
--- a/board/freescale/mpc837xemds/Makefile
+++ b/board/freescale/mpc837xemds/Makefile
@@ -25,7 +25,7 @@ include $(TOPDIR)/config.mk
 
 LIB	= $(obj)lib$(BOARD).a
 
-COBJS	:= $(BOARD).o pci.o nand.o
+COBJS	:= $(BOARD).o pci.o pcie.o nand.o
 
 SRCS	:= $(SOBJS:.o=.S) $(COBJS:.o=.c)
 OBJS	:= $(addprefix $(obj),$(COBJS))
diff --git a/board/freescale/mpc837xemds/mpc837xemds.c b/board/freescale/mpc837xemds/mpc837xemds.c
index 330e0e8..ff6f14a 100644
--- a/board/freescale/mpc837xemds/mpc837xemds.c
+++ b/board/freescale/mpc837xemds/mpc837xemds.c
@@ -48,6 +48,9 @@ int board_early_init_r(void)
 #ifdef CONFIG_PQ_MDS_PIB
 	pib_init();
 #endif
+#ifdef CONFIG_PCIE
+	pcie_init_board();
+#endif
 	return 0;
 }
 
diff --git a/board/freescale/mpc837xemds/pci.c b/board/freescale/mpc837xemds/pci.c
index ab90979..72e8dcc 100644
--- a/board/freescale/mpc837xemds/pci.c
+++ b/board/freescale/mpc837xemds/pci.c
@@ -59,7 +59,8 @@ void pci_init_board(void)
 	pci_law[1].ar = LBLAWAR_EN | LBLAWAR_1MB;
 
 	udelay(2000);
-
+#if defined(CONFIG_PQ_MDS_PIB)
 	mpc83xx_pci_init(1, reg, 0);
+#endif
 }
 #endif /* CONFIG_PCI */
diff --git a/board/freescale/mpc837xemds/pcie.c b/board/freescale/mpc837xemds/pcie.c
new file mode 100644
index 0000000..474f848
--- /dev/null
+++ b/board/freescale/mpc837xemds/pcie.c
@@ -0,0 +1,95 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc.
+ * Tony Li <tony.li@freescale.com>
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ */
+
+#include <asm/mmu.h>
+#include <asm/io.h>
+#include <common.h>
+#include <mpc83xx.h>
+#include <pci.h>
+#include <asm/fsl_serdes.h>
+
+#if defined(CONFIG_PCIE)
+static struct pci_region pci_regions_0[] = {
+	{
+		bus_start: CFG_PCIE1_MEM_BASE,
+		phys_start: CFG_PCIE1_MEM_PHYS,
+		size: CFG_PCIE1_MEM_SIZE,
+		flags: PCI_REGION_MEM
+	},
+	{
+		bus_start: CFG_PCIE1_IO_BASE,
+		phys_start: CFG_PCIE1_IO_PHYS,
+		size: CFG_PCIE1_IO_SIZE,
+		flags: PCI_REGION_IO
+	}
+};
+
+static struct pci_region pci_regions_1[] = {
+	{
+		bus_start: CFG_PCIE2_MEM_BASE,
+		phys_start: CFG_PCIE2_MEM_PHYS,
+		size: CFG_PCIE2_MEM_SIZE,
+		flags: PCI_REGION_MEM
+	},
+	{
+		bus_start: CFG_PCIE2_IO_BASE,
+		phys_start: CFG_PCIE2_IO_PHYS,
+		size: CFG_PCIE2_IO_SIZE,
+		flags: PCI_REGION_IO
+	}
+};
+
+void pcie_init_board(void)
+{
+	volatile immap_t *immr = (volatile immap_t *)CFG_IMMR;
+	volatile clk83xx_t *clk = (volatile clk83xx_t *)&immr->clk;
+	volatile sysconf83xx_t *sysconf = &immr->sysconf;
+	volatile serdes83xx_t *serdes = &immr->serdes[1];
+	volatile law83xx_t *pcie_law = sysconf->pcielaw;
+	struct pci_region *reg[] = { pci_regions_0, pci_regions_1 };
+	u8 val8 = 0;
+	u8 orig_i2c_bus = 0;
+
+	disable_addr_trans();
+
+#if defined(CONFIG_PCIE_X2)
+	fsl_serdes_init(serdes, FSL_SERDES_MODE_PEX_X2);
+#else
+	fsl_serdes_init(serdes, FSL_SERDES_MODE_PEX);
+#endif
+
+	/* Configure the clock for PCIE controller */
+	clk->sccr &= ~0x003C0000;
+	clk->sccr |= 0x00140000;
+
+	/* Deassert the resets in the control register */
+	sysconf->pecr1 = 0xE0008000;
+#if !defined(CONFIG_PCIE_X2)
+	sysconf->pecr2 = 0xE0008000;
+#endif
+	udelay(2000);
+
+	/* Configure PCI Express Local Access Windows */
+	pcie_law[0].bar = CFG_PCIE1_BASE & LAWBAR_BAR;
+	pcie_law[0].ar = LBLAWAR_EN | LBLAWAR_512MB;
+
+	pcie_law[1].bar = CFG_PCIE2_BASE & LAWBAR_BAR;
+	pcie_law[1].ar = LBLAWAR_EN | LBLAWAR_512MB;
+
+#if defined(CONFIG_PCIE_X2)
+	mpc83xx_pcie_init(1, reg, 0);
+#else
+	mpc83xx_pcie_init(2, reg, 0);
+#endif
+}
+#endif /* CONFIG_PCIE */
diff --git a/cpu/mpc83xx/Makefile b/cpu/mpc83xx/Makefile
index 2329970..a6be7f0 100644
--- a/cpu/mpc83xx/Makefile
+++ b/cpu/mpc83xx/Makefile
@@ -29,7 +29,7 @@ LIB	= $(obj)lib$(CPU).a
 
 START	= start.o
 COBJS	= traps.o cpu.o cpu_init.o speed.o interrupts.o \
-	  spd_sdram.o ecc.o qe_io.o pci.o
+	  spd_sdram.o ecc.o qe_io.o pci.o pcie.o
 
 SRCS	:= $(START:.o=.S) $(SOBJS:.o=.S) $(COBJS:.o=.c)
 OBJS	:= $(addprefix $(obj),$(SOBJS) $(COBJS))
diff --git a/cpu/mpc83xx/pcie.c b/cpu/mpc83xx/pcie.c
new file mode 100644
index 0000000..acaf008
--- /dev/null
+++ b/cpu/mpc83xx/pcie.c
@@ -0,0 +1,315 @@
+/*
+ * Copyright (C) 2007 Freescale Semiconductor, Inc.
+ *
+ * Author: Tony Li <tony.li@freescale.com>,
+ * Based on PCI initialization.
+ *
+ * See file CREDITS for list of people who contributed to this
+ * project.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+#include <common.h>
+#include <pci.h>
+
+#include <asm/io.h>
+#include <mpc83xx.h>
+
+#ifdef CONFIG_83XX_GENERIC_PCIE
+#define PCIE_MAX_BUSES 2
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static struct pci_controller pcie_hose[PCIE_MAX_BUSES];
+static int pcie_num_buses;
+
+#define cfg_read(val, addr, type, op)	*val = op((type)(addr))
+#define cfg_write(val, addr, type, op)	op((type *)(addr), (val))
+
+#define PCIE_OP(rw, size, type, op)						\
+static int									\
+pcie_##rw##_config_##size(struct pci_controller *hose,				\
+			pci_dev_t dev, int offset, type val)			\
+{										\
+	u32 b, d, f;								\
+	if (hose->indirect_type == INDIRECT_TYPE_NO_PCIE_LINK)			\
+		return -1;							\
+	b = PCI_BUS(dev); d = PCI_DEV(dev) & 0x1f; f = PCI_FUNC(dev) & 0x7;	\
+	b = b - hose->first_busno;						\
+	dev = (b << 24) | (((d << 3) | f) << 16) | (offset & 0xfff);		\
+	cfg_##rw(val, (u32)hose->cfg_addr + (u32)dev, type, op);		\
+	return 0;								\
+}
+
+PCIE_OP(read, byte, u8 *, in_8)
+PCIE_OP(read, word, u16 *, in_le16)
+PCIE_OP(read, dword, u32 *, in_le32)
+PCIE_OP(write, byte, u8, out_8)
+PCIE_OP(write, word, u16, out_le16)
+PCIE_OP(write, dword, u32, out_le32)
+
+void pcie_setup_ops(struct pci_controller *hose, u32 cfg_addr)
+{
+	pci_set_ops(hose,
+			pcie_read_config_byte,
+			pcie_read_config_word,
+			pcie_read_config_dword,
+			pcie_write_config_byte,
+			pcie_write_config_word,
+			pcie_write_config_dword);
+
+	hose->cfg_addr = (unsigned long *)cfg_addr;
+}
+
+static void pcie_init_bus(int bus, struct pci_region *reg)
+{
+	volatile immap_t *immr = (volatile immap_t *)CFG_IMMR;
+	volatile pex83xx_t *pex = &immr->pciexp[bus];
+	volatile struct pex_outbound_window *out_win;
+	volatile struct pex_inbound_window *in_win;
+	struct pci_controller *hose = &pcie_hose[bus];
+	volatile void *hose_cfg_base;
+	static int max_bus = 0;
+	unsigned int ram_sz, barl, tar;
+	u16 reg16;
+	int i, j;
+
+	/* Enable pex csb bridge inbound & outbound transactions */
+	out_le32(&pex->bridge.pex_csb_ctrl,
+		in_le32(&pex->bridge.pex_csb_ctrl) | PEX_CSB_CTRL_OBPIOE |
+		PEX_CSB_CTRL_IBPIOE);
+	//	PEX_CSB_CTRL_IBPIOE | PEX_CSB_CTRL_WDMAE | PEX_CSB_CTRL_RDMAE);
+
+	/* Enable bridge outbound */
+	out_le32(&pex->bridge.pex_csb_obctrl, PEX_CSB_OBCTRL_PIOE |
+		PEX_CSB_OBCTRL_MEMWE | PEX_CSB_OBCTRL_IOWE |
+		PEX_CSB_OBCTRL_CFGWE);
+
+	out_win = &pex->bridge.pex_outbound_win[0];
+	if (bus) {
+		out_le32(&out_win->ar, PEX_OWAR_EN | PEX_OWAR_TYPE_CFG |
+			CFG_PCIE2_CFG_SIZE);
+		out_le32(&out_win->bar, CFG_PCIE2_CFG_BASE);
+	} else {
+		out_le32(&out_win->ar, PEX_OWAR_EN | PEX_OWAR_TYPE_CFG |
+			CFG_PCIE1_CFG_SIZE);
+		out_le32(&out_win->bar, CFG_PCIE1_CFG_BASE);
+	}
+	out_le32(&out_win->tarl, 0);
+	out_le32(&out_win->tarh, 0);
+
+	for (i = 0; i < 2; i++, reg++) {
+		u32 ar;
+		if (reg->size == 0)
+			break;
+
+		hose->regions[i] = *reg;
+		hose->region_count++;
+
+		out_win = &pex->bridge.pex_outbound_win[i + 1];
+		out_le32(&out_win->bar, reg->phys_start);
+		out_le32(&out_win->tarl, reg->bus_start);
+		out_le32(&out_win->tarh, 0);
+		ar = PEX_OWAR_EN | (reg->size & PEX_OWAR_SIZE);
+		if (reg->flags & PCI_REGION_IO)
+			ar |= PEX_OWAR_TYPE_IO;
+		else
+			ar |= PEX_OWAR_TYPE_MEM;
+		out_le32(&out_win->ar, ar);
+	}
+
+	out_le32(&pex->bridge.pex_csb_ibctrl, PEX_CSB_IBCTRL_PIOE);
+
+	ram_sz = gd->ram_size;
+	barl = 0;
+	tar = 0;
+	j = 0;
+	while (ram_sz > 0) {
+		in_win = &pex->bridge.pex_inbound_win[j];
+		out_le32(&in_win->barl, barl);
+		out_le32(&in_win->barh, 0x0);
+		out_le32(&in_win->tar, tar);
+		if (ram_sz >= 0x10000000) {
+			out_le32(&in_win->ar, PEX_IWAR_EN | PEX_IWAR_NSOV |
+				PEX_IWAR_TYPE_PF | 0x0FFFF000);
+			barl += 0x10000000;
+			tar += 0x10000000;
+			ram_sz -= 0x10000000;
+		}
+		else {
+			/* The UM  is not clear here.
+			 * So, round up to even Mb boundary */
+			unsigned int sz = 0;
+
+			ram_sz = ram_sz >> 20 +
+					((ram_sz & 0xFFFFF) ? 1 : 0);
+			if (!(ram_sz % 2))
+				ram_sz -= 1;
+			out_le32(&in_win->ar, PEX_IWAR_EN | PEX_IWAR_NSOV |
+				PEX_IWAR_TYPE_PF | (sz << 20) | 0xFF000);
+			ram_sz = 0;
+		}
+		j++;
+	}
+	i = hose->region_count++;
+	hose->regions[i].bus_start = 0;
+	hose->regions[i].phys_start = 0;
+	hose->regions[i].size = gd->ram_size;
+	hose->regions[i].flags = PCI_REGION_MEM | PCI_REGION_MEMORY;
+
+	in_win = &pex->bridge.pex_inbound_win[j];
+	out_le32(&in_win->barl, CFG_IMMR);
+	out_le32(&in_win->barh, 0);
+	out_le32(&in_win->tar, CFG_IMMR);
+	out_le32(&in_win->ar, PEX_IWAR_EN |
+		PEX_IWAR_TYPE_NO_PF | PEX_IWAR_SIZE_1M);
+
+	i = hose->region_count++;
+	hose->regions[i].bus_start = CFG_IMMR;
+	hose->regions[i].phys_start = CFG_IMMR;
+	hose->regions[i].size = 0x100000;
+	hose->regions[i].flags = PCI_REGION_MEM | PCI_REGION_MEMORY;
+
+	hose->first_busno = max_bus;
+	hose->last_busno = 0xff;
+
+	/* Enable the host virtual INTX interrupts */
+	out_le32(&pex->bridge.pex_int_axi_misc_enb,
+		in_le32(&pex->bridge.pex_int_axi_misc_enb) | 0x1E0);
+
+	pcie_setup_ops(hose, bus ? CFG_PCIE2_CFG_BASE : CFG_PCIE1_CFG_BASE);
+
+	pci_register_hose(hose);
+
+	/* Hose configure header is memory-mapped */
+	hose_cfg_base = (void *)pex;
+
+#if 1
+	get_clocks();
+	/* Configure the PCIE controller core clock ratio */
+	out_le32(hose_cfg_base + PEX_GCLK_RATIO,
+		(((bus ? gd->pciexp2_clk : gd->pciexp1_clk) / 1000000) * 16) / 333);
+	udelay(1000000);
+#endif
+
+	/* Enable the error reports */
+	reg16 = in_le16(hose_cfg_base + PCI_BRIDGE_CONTROL);
+	reg16 |= PCI_BRIDGE_CTL_SERR | PCI_BRIDGE_CTL_PARITY;
+	out_le16(hose_cfg_base + PCI_BRIDGE_CONTROL, reg16);
+
+#define PCIE_DEVICE_CONTROL	0x54
+#define PCIE_DEVICE_CTL_URR	0x8
+#define PCIE_DEVICE_CTL_FER	0x4
+#define PCIE_DEVICE_CTL_NFER	0x2
+#define PCIE_DEVICE_CTL_CER	0x1
+	reg16 = in_le16(hose_cfg_base + PCIE_DEVICE_CONTROL);
+	reg16 |= PCIE_DEVICE_CTL_URR | PCIE_DEVICE_CTL_FER |
+			PCIE_DEVICE_CTL_NFER | PCIE_DEVICE_CTL_CER; 
+	out_le16(hose_cfg_base + PCIE_DEVICE_CONTROL, reg16);
+
+#define PCIE_ADVANCED_ERR_CAP_CTL	0x118
+#define PCIE_ADVANCED_ERR_CAP_CTL_ECRCCE	0x100
+#define PCIE_ADVANCED_ERR_CAP_CTL_ECRCGE	0x40
+
+{
+	u32 reg32;
+	reg32 = in_le32(hose_cfg_base + PCIE_ADVANCED_ERR_CAP_CTL);
+	reg32 |= PCIE_ADVANCED_ERR_CAP_CTL_ECRCCE | PCIE_ADVANCED_ERR_CAP_CTL_ECRCGE;
+	out_le32(hose_cfg_base + PCIE_ADVANCED_ERR_CAP_CTL, reg32);
+
+#define PCIE_ROOT_ERROR_COMMAND	0x012c
+#define PCIE_ROOT_ERROR_COMMAND_FERE	0x4
+#define PCIE_ROOT_ERROR_COMMAND_NFERE	0x2
+#define PCIE_ROOT_ERROR_COMMAND_CERE	0x1
+	reg32 = in_le32(hose_cfg_base + PCIE_ROOT_ERROR_COMMAND);
+	reg32 |= PCIE_ROOT_ERROR_COMMAND_FERE | PCIE_ROOT_ERROR_COMMAND_NFERE |
+			PCIE_ROOT_ERROR_COMMAND_CERE;
+	out_le32(hose_cfg_base + PCIE_ROOT_ERROR_COMMAND, reg32);
+}
+
+#if 1	/* Do Type 1 bridge configuration */
+
+	out_8(hose_cfg_base + PCI_PRIMARY_BUS, 0);
+	out_8(hose_cfg_base + PCI_SECONDARY_BUS, 1);
+	out_8(hose_cfg_base + PCI_SUBORDINATE_BUS, 255);
+#endif
+
+	/*
+	 * Write to Command register
+	 */
+	reg16 = in_le16(hose_cfg_base + PCI_COMMAND);
+	reg16 |= PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY | PCI_COMMAND_IO |
+			PCI_COMMAND_SERR | PCI_COMMAND_PARITY;
+	out_le16(hose_cfg_base + PCI_COMMAND, reg16);
+
+	/*
+	 * Clear non-reserved bits in status register.
+	 */
+	out_le16(hose_cfg_base + PCI_STATUS, 0xffff);
+	out_8(hose_cfg_base + PCI_LATENCY_TIMER, 0x80);
+	out_8(hose_cfg_base + PCI_CACHE_LINE_SIZE, 0x08);
+
+	printf("PCIE%d: ", bus);
+
+	reg16 = in_le16(hose_cfg_base + PEX_LTSSM_STAT);
+	if (reg16 < 0x16) {
+		printf("No link\n", bus);
+		hose->indirect_type = INDIRECT_TYPE_NO_PCIE_LINK;
+	} else {
+		printf("link\n");
+	}
+
+#ifdef CONFIG_PCI_SCAN_SHOW
+	printf("PCI:   Bus Dev VenId DevId Class Int\n");
+#endif
+
+	/*
+	 * Hose scan.
+	 */
+	hose->last_busno = pci_hose_scan(hose);
+	max_bus = hose->last_busno + 1;
+}
+
+/*
+ * The caller must have already set SCCR, SERDES and the PCIE_LAW BARs
+ * must have been set to cover all of the requested regions.
+ */
+void mpc83xx_pcie_init(int num_buses, struct pci_region **reg, int warmboot)
+{
+	int i;
+
+	if (num_buses > PCIE_MAX_BUSES) {
+		printf("%d PCI buses requsted, %d supported\n",
+			num_buses, PCIE_MAX_BUSES);
+
+		num_buses = PCIE_MAX_BUSES;
+	}
+
+	pcie_num_buses = num_buses;
+
+	/*
+	 * Release PCI RST Output signal.
+	 * Power on to RST high must be at least 100 ms as per PCI spec.
+	 * On warm boots only 1 ms is required.
+	 */
+	udelay(warmboot ? 1000 : 100000);
+
+	for (i = 0; i < num_buses; i++)
+		pcie_init_bus(i, reg[i]);
+}
+
+#endif /* CONFIG_83XX_GENERIC_PCIE */
diff --git a/doc/README.mpc837xemds b/doc/README.mpc837xemds
index 3f0cdf7..5650782 100644
--- a/doc/README.mpc837xemds
+++ b/doc/README.mpc837xemds
@@ -45,6 +45,12 @@ Freescale MPC837xEMDS Board
 	0x8000_0000	0x8fff_ffff	PCI MEM prefetch	256M
 	0x9000_0000	0x9fff_ffff	PCI MEM non-prefetch	256M
 	0xc000_0000	0xdfff_ffff	Empty			512M
+	0xa000_0000	0xafff_ffff	PCI Express 1 Mem	256M
+	0xb000_0000	0xb0ff_ffff	PCI Express 1 Config	16M
+	0xb100_0000	0xb17f_ffff	PCI Express 1 IO	8M
+	0xc000_0000	0xcfff_ffff	PCI Express 2 Mem	256M
+	0xd000_0000	0xd0ff_ffff	PCI Express 2 Config	16M
+	0xd100_0000	0xd17f_ffff	PCI Express 2 IO	8M
 	0xe000_0000	0xe00f_ffff	Int Mem Reg Space	1M
 	0xe010_0000	0xe02f_ffff	Empty			2M
 	0xe030_0000	0xe03f_ffff	PCI IO			1M
diff --git a/include/asm-ppc/immap_83xx.h b/include/asm-ppc/immap_83xx.h
index f011e48..3e863ad 100644
--- a/include/asm-ppc/immap_83xx.h
+++ b/include/asm-ppc/immap_83xx.h
@@ -50,21 +50,26 @@ typedef struct sysconf83xx {
 	law83xx_t lblaw[4];	/* LBIU local access window */
 	u8 res2[0x20];
 	law83xx_t pcilaw[2];	/* PCI local access window */
-	u8 res3[0x30];
+	u8 res3[0x10];
+	law83xx_t pcielaw[2];	/* PCI Express local access window */
+	u8 res4[0x10];
 	law83xx_t ddrlaw[2];	/* DDR local access window */
-	u8 res4[0x50];
+	u8 res5[0x50];
 	u32 sgprl;		/* System General Purpose Register Low */
 	u32 sgprh;		/* System General Purpose Register High */
 	u32 spridr;		/* System Part and Revision ID Register */
-	u8 res5[0x04];
+	u8 res6[0x04];
 	u32 spcr;		/* System Priority Configuration Register */
 	u32 sicrl;		/* System I/O Configuration Register Low */
 	u32 sicrh;		/* System I/O Configuration Register High */
-	u8 res6[0x0C];
+	u8 res7[0x0C];
 	u32 ddrcdr;		/* DDR Control Driver Register */
 	u32 ddrdsr;		/* DDR Debug Status Register */
 	u32 obir;		/* Output Buffer Impedance Register */
-	u8 res7[0xCC];
+	u8 res8[0xC];
+	u32 pecr1;		/* PCI Express control register 1 */
+	u32 pecr2;		/* PCI Express control register 2 */
+	u8 res9[0xB8];
 } sysconf83xx_t;
 
 /*
@@ -557,8 +562,110 @@ typedef struct security83xx {
 /*
  *  PCI Express
  */
+struct pex_inbound_window {
+	u32 ar;
+	u32 tar;
+	u32 barl;
+	u32 barh;
+};
+
+struct pex_outbound_window {
+	u32 ar;
+	u32 bar;
+	u32 tarl;
+	u32 tarh;
+};
+
+struct pex_csb_bridge {
+	u32 pex_csb_ver;
+	u32 pex_csb_cab;
+	u32 pex_csb_ctrl;
+	u8 res0[8];
+	u32 pex_dms_dstmr;
+	u8 res1[4];
+	u32 pex_cbs_stat;
+	u8 res2[0x20];
+	u32 pex_csb_obctrl;
+	u32 pex_csb_obstat;
+	u8 res3[0x98];
+	u32 pex_csb_ibctrl;
+	u32 pex_csb_ibstat;
+	u8 res4[0xb8];
+	u32 pex_wdma_ctrl;
+	u32 pex_wdma_addr;
+	u32 pex_wdma_stat;
+	u8 res5[0x94];
+	u32 pex_rdma_ctrl;
+	u32 pex_rdma_addr;
+	u32 pex_rdma_stat;
+	u8 res6[0xd4];
+	u32 pex_ombcr;
+	u32 pex_ombdr;
+	u8 res7[0x38];
+	u32 pex_imbcr;
+	u32 pex_imbdr;
+	u8 res8[0x38];
+	u32 pex_int_enb;
+	u32 pex_int_stat;
+	u32 pex_int_apio_vec1;
+	u32 pex_int_apio_vec2;
+	u8 res9[0x10];
+	u32 pex_int_ppio_vec1;
+	u32 pex_int_ppio_vec2;
+	u32 pex_int_wdma_vec1;
+	u32 pex_int_wdma_vec2;
+	u32 pex_int_rdma_vec1;
+	u32 pex_int_rdma_vec2;
+	u32 pex_int_misc_vec;
+	u8 res10[4];
+	u32 pex_int_axi_pio_enb;
+	u32 pex_int_axi_wdma_enb;
+	u32 pex_int_axi_rdma_enb;
+	u32 pex_int_axi_misc_enb;
+	u32 pex_int_axi_pio_stat;
+	u32 pex_int_axi_wdma_stat;
+	u32 pex_int_axi_rdma_stat;
+	u32 pex_int_axi_misc_stat;
+	u8 res11[0xa0];
+	struct pex_outbound_window pex_outbound_win[4];
+	u8 res12[0x100];
+	u32 pex_epiwtar0;
+	u32 pex_epiwtar1;
+	u32 pex_epiwtar2;
+	u32 pex_epiwtar3;
+	u8 res13[0x70];
+	struct pex_inbound_window pex_inbound_win[4];
+};
+
 typedef struct pex83xx {
-	u8 fixme[0x1000];
+	u8 pex_cfg_header[0x404];
+	u32 pex_ltssm_stat;
+	u8 res0[0x30];
+	u32 pex_ack_replay_timeout;
+	u8 res1[4];
+	u32 pex_gclk_ratio;
+	u8 res2[0xc];
+	u32 pex_pm_timer;
+	u32 pex_pme_timeout;
+	u8 res3[4];
+	u32 pex_aspm_req_timer;
+	u8 res4[0x18];
+	u32 pex_ssvid_update;
+	u8 res5[0x34];
+	u32 pex_cfg_ready;
+	u8 res6[0x24];
+	u32 pex_bar_sizel;
+	u8 res7[4];
+	u32 pex_bar_sel;
+	u8 res8[0x20];
+	u32 pex_bar_pf;
+	u8 res9[0x88];
+	u32 pex_pme_to_ack_tor;
+	u8 res10[0xc];
+	u32 pex_ss_intr_mask;
+	u8 res11[0x25c];
+	struct pex_csb_bridge bridge;
+	u8 res12[0x160];
 } pex83xx_t;
 
 /*
diff --git a/include/configs/MPC837XEMDS.h b/include/configs/MPC837XEMDS.h
index 219c9da..503db23 100644
--- a/include/configs/MPC837XEMDS.h
+++ b/include/configs/MPC837XEMDS.h
@@ -374,7 +374,7 @@
 
 #ifdef CONFIG_PCI
 #define CONFIG_83XX_GENERIC_PCI	1 /* Use generic PCI setup */
-#define CONFIG_PQ_MDS_PIB	1 /* PQ MDS Platform IO Board */
+#define CONFIG_83XX_GENERIC_PCIE	1 /* Use generic PCIE setup*/
 
 #define CONFIG_NET_MULTI
 #define CONFIG_PCI_PNP		/* do pci plug-and-play */
@@ -384,6 +384,27 @@
 #define CFG_PCI_SUBSYS_VENDORID 0x1957	/* Freescale */
 #endif /* CONFIG_PCI */
 
+/* PCIE address map */
+#define CFG_PCIE1_BASE		0xA0000000
+#define CFG_PCIE1_MEM_BASE	CFG_PCIE1_BASE
+#define CFG_PCIE1_MEM_PHYS	CFG_PCIE1_MEM_BASE
+#define CFG_PCIE1_MEM_SIZE	0x10000000
+#define CFG_PCIE1_CFG_BASE	(CFG_PCIE1_MEM_BASE + CFG_PCIE1_MEM_SIZE)
+#define CFG_PCIE1_CFG_SIZE	0x01000000
+#define CFG_PCIE1_IO_BASE	0x0
+#define CFG_PCIE1_IO_PHYS	(CFG_PCIE1_CFG_BASE + CFG_PCIE1_CFG_SIZE)
+#define CFG_PCIE1_IO_SIZE	0x00800000
+
+#define CFG_PCIE2_BASE		0xC0000000
+#define CFG_PCIE2_MEM_BASE	CFG_PCIE2_BASE
+#define CFG_PCIE2_MEM_PHYS	CFG_PCIE2_MEM_BASE
+#define CFG_PCIE2_MEM_SIZE	0x10000000
+#define CFG_PCIE2_CFG_BASE	(CFG_PCIE2_MEM_BASE + CFG_PCIE2_MEM_SIZE)
+#define CFG_PCIE2_CFG_SIZE	0x01000000
+#define CFG_PCIE2_IO_BASE	0x0
+#define CFG_PCIE2_IO_PHYS	(CFG_PCIE2_CFG_BASE + CFG_PCIE2_CFG_SIZE)
+#define CFG_PCIE2_IO_SIZE	0x00800000
+
 #ifndef CONFIG_NET_MULTI
 #define CONFIG_NET_MULTI	1
 #endif
diff --git a/include/mpc83xx.h b/include/mpc83xx.h
index 306c970..bad60fe 100644
--- a/include/mpc83xx.h
+++ b/include/mpc83xx.h
@@ -1409,6 +1409,48 @@
 #define DDRCDR_M_ODR		0x00000002
 #define DDRCDR_Q_DRN		0x00000001
 
+/* PCIE Bridge Register
+ */
+#define PEX_CSB_CTRL_OBPIOE	0x00000001
+#define PEX_CSB_CTRL_IBPIOE	0x00000002
+#define PEX_CSB_CTRL_WDMAE	0x00000004
+#define PEX_CSB_CTRL_RDMAE	0x00000008
+
+#define PEX_CSB_OBCTRL_PIOE	0x00000001
+#define PEX_CSB_OBCTRL_MEMWE	0x00000002
+#define PEX_CSB_OBCTRL_IOWE	0x00000004
+#define PEX_CSB_OBCTRL_CFGWE	0x00000008
+
+#define PEX_CSB_IBCTRL_PIOE	0x00000001
+
+#define PEX_OWAR_EN		0x00000001
+#define PEX_OWAR_TYPE_CFG	0x00000000
+#define PEX_OWAR_TYPE_IO	0x00000002
+#define PEX_OWAR_TYPE_MEM	0x00000004
+#define PEX_OWAR_RLXO		0x00000008
+#define PEX_OWAR_NANP		0x00000010
+#define PEX_OWAR_SIZE		0xFFFFF000
+
+#define PEX_IWAR_EN		0x00000001
+#define PEX_IWAR_TYPE_INT	0x00000000
+#define PEX_IWAR_TYPE_PF	0x00000004
+#define PEX_IWAR_TYPE_NO_PF	0x00000006
+#define PEX_IWAR_NSOV		0x00000008
+#define PEX_IWAR_NSNP		0x00000010
+#define PEX_IWAR_SIZE		0xFFFFF000
+#define PEX_IWAR_SIZE_1M	0x000FF000
+#define PEX_IWAR_SIZE_2M	0x001FF000
+#define PEX_IWAR_SIZE_4M	0x003FF000
+#define PEX_IWAR_SIZE_8M	0x007FF000
+#define PEX_IWAR_SIZE_16M	0x00FFF000
+#define PEX_IWAR_SIZE_32M	0x01FFF000
+#define PEX_IWAR_SIZE_64M	0x03FFF000
+#define PEX_IWAR_SIZE_128M	0x07FFF000
+#define PEX_IWAR_SIZE_256M	0x0FFFF000
+
+#define PEX_LTSSM_STAT		0x404
+#define PEX_GCLK_RATIO		0x440
+
 #ifndef __ASSEMBLY__
 struct pci_region;
 void mpc83xx_pci_init(int num_buses, struct pci_region **reg, int warmboot);
diff --git a/include/pci.h b/include/pci.h
index 8e5dacc..a0a84c9 100644
--- a/include/pci.h
+++ b/include/pci.h
@@ -374,6 +374,8 @@ extern void pci_cfgfunc_config_device(struct pci_controller* hose, pci_dev_t dev
 
 #define MAX_PCI_REGIONS		7
 
+#define INDIRECT_TYPE_NO_PCIE_LINK	1
+
 /*
  * Structure of a PCI controller (host bridge)
  */
@@ -386,6 +388,8 @@ struct pci_controller {
 	volatile unsigned int *cfg_addr;
 	volatile unsigned char *cfg_data;
 
+	int indirect_type;
+
 	struct pci_region regions[MAX_PCI_REGIONS];
 	int region_count;
 
-- 
1.5.2
