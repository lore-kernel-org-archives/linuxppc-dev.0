Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 493A7DDF45
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 03:03:42 +1000 (EST)
Date: Fri, 11 Apr 2008 21:03:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/8] [POWERPC] fsl_lbc: implement few routines to manage
	FSL UPMs
Message-ID: <20080411170340.GA2649@polina.dev.rtsoft.ru>
References: <20080311172106.GA4766@localhost.localdomain>
	<20080311172408.GB7727@localhost.localdomain>
	<EE642BFC-4262-44E8-BD48-E76E5418C276@kernel.crashing.org>
	<20080411161311.GA28067@polina.dev.rtsoft.ru>
	<47FF8F56.50803@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <47FF8F56.50803@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 11:18:30AM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>> On Fri, Apr 11, 2008 at 09:09:57AM -0500, Kumar Gala wrote:
>>> On Mar 11, 2008, at 12:24 PM, Anton Vorontsov wrote:
>>>> These will be used by the FSL UPM NAND driver.
>>> can this be a bit more descriptive.  What exactly are these functions 
>>>  trying to accomplish.
>>
>> Yeah, sorry about that. Here is updated patch, with a bit more descriptive
>> comment, and highly kernel-doc'ed functions.
>>
>>>> +int fsl_upm_find(u32 base, struct fsl_upm *upm)
>>> what is base?
>>
>> Address base, as in LBC Base address register. Fixed down below.
>
> Should it be phys_addr_t?

Well, today I don't see much sense in this other than for documentation
purposes, this code is 32bit centric anyway. But ok, let's do it.

>> +/**
>> + * fsl_upm_find - find pre-programmed UPM via base address
>> + * @addr_base:	base address of the memory bank controlled by the UPM
>> + * @upm:	pointer to the allocated fsl_upm structure
>> + *
>> + * This function walks UPMs comparing "Base address" field of the BR registers
>> + * with the supplied addr_base argument. When bases are match, this function
>> + * fills fsl_upm structure so you can use it with the rest of UPM API. On
>> + * success this function returns 0, otherwise it returns appropriate errno
>> + * value.
>> + */
>
> The FCM driver does something very similar; could we name this something  
> more generic such as fsl_lbc_find?

Ok. Updated patch follows.

Thanks!

- - - -
From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [POWERPC] fsl_lbc: implement few UPM routines

Freescale UPM can be used to adjust localbus timings or to generate
orbitrary, pre-programmed "patterns" on the external Localbus signals.
This patch implements few routines so drivers could work with UPMs in
safe and generic manner.

So far there is just one user of these routines: Freescale UPM NAND
driver.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/Kconfig          |    5 ++
 arch/powerpc/sysdev/Makefile  |    1 +
 arch/powerpc/sysdev/fsl_lbc.c |  129 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/fsl_lbc.h |   88 ++++++++++++++++++++++++++++
 4 files changed, 223 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/sysdev/fsl_lbc.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ef12db0..9c68592 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -491,6 +491,11 @@ config FSL_PCI
  	bool
 	select PPC_INDIRECT_PCI
 
+config FSL_LBC
+	bool
+	help
+	  Freescale Localbus support
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 15f3e85..62b6ef0 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
 obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o
+obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_RAPIDIO)		+= fsl_rio.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
new file mode 100644
index 0000000..422c8fa
--- /dev/null
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -0,0 +1,129 @@
+/*
+ * Freescale LBC and UPM routines.
+ *
+ * Copyright (c) 2007-2008  MontaVista Software, Inc.
+ *
+ * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <asm/fsl_lbc.h>
+
+spinlock_t fsl_lbc_lock = __SPIN_LOCK_UNLOCKED(fsl_lbc_lock);
+
+struct fsl_lbc_regs __iomem *fsl_lbc_regs;
+EXPORT_SYMBOL(fsl_lbc_regs);
+
+static char __initdata *compat_lbc[] = {
+	"fsl,pq2-localbus",
+	"fsl,pq2pro-localbus",
+	"fsl,pq3-localbus",
+	"fsl,elbc",
+};
+
+static int __init fsl_lbc_init(void)
+{
+	struct device_node *lbus;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(compat_lbc); i++) {
+		lbus = of_find_compatible_node(NULL, NULL, compat_lbc[i]);
+		if (lbus)
+			goto found;
+	}
+	return -ENODEV;
+
+found:
+	fsl_lbc_regs = of_iomap(lbus, 0);
+	of_node_put(lbus);
+	if (!fsl_lbc_regs)
+		return -ENOMEM;
+	return 0;
+}
+arch_initcall(fsl_lbc_init);
+
+/**
+ * fsl_lbc_find - find Localbus bank
+ * @addr_base:	base address of the memory bank
+ *
+ * This function walks LBC banks comparing "Base address" field of the BR
+ * registers with the supplied addr_base argument. When bases match this
+ * function returns bank number (starting with 0), otherwise it returns
+ * appropriate errno value.
+ */
+int fsl_lbc_find(phys_addr_t addr_base)
+{
+	int i;
+
+	if (!fsl_lbc_regs)
+		return -ENODEV;
+
+	for (i = 0; i < ARRAY_SIZE(fsl_lbc_regs->bank); i++) {
+		__be32 br = in_be32(&fsl_lbc_regs->bank[i].br);
+		__be32 or = in_be32(&fsl_lbc_regs->bank[i].or);
+
+		if (br & BR_V && (br & or & BR_BA) == addr_base)
+			return i;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL(fsl_lbc_find);
+
+/**
+ * fsl_upm_find - find pre-programmed UPM via base address
+ * @addr_base:	base address of the memory bank controlled by the UPM
+ * @upm:	pointer to the allocated fsl_upm structure
+ *
+ * This function fills fsl_upm structure so you can use it with the rest of
+ * UPM API. On success this function returns 0, otherwise it returns
+ * appropriate errno value.
+ */
+int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm)
+{
+	int bank;
+	__be32 br;
+
+	bank = fsl_lbc_find(addr_base);
+	if (bank < 0)
+		return bank;
+
+	br = in_be32(&fsl_lbc_regs->bank[bank].br);
+
+	switch (br & BR_MSEL) {
+	case BR_MS_UPMA:
+		upm->mxmr = &fsl_lbc_regs->mamr;
+		break;
+	case BR_MS_UPMB:
+		upm->mxmr = &fsl_lbc_regs->mbmr;
+		break;
+	case BR_MS_UPMC:
+		upm->mxmr = &fsl_lbc_regs->mcmr;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (br & BR_PS) {
+	case BR_PS_8:
+		upm->width = 8;
+		break;
+	case BR_PS_16:
+		upm->width = 16;
+		break;
+	case BR_PS_32:
+		upm->width = 32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(fsl_upm_find);
diff --git a/include/asm-powerpc/fsl_lbc.h b/include/asm-powerpc/fsl_lbc.h
index 13a3c28..303f548 100644
--- a/include/asm-powerpc/fsl_lbc.h
+++ b/include/asm-powerpc/fsl_lbc.h
@@ -24,6 +24,8 @@
 #define __ASM_FSL_LBC_H
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
+#include <asm/io.h>
 
 struct fsl_lbc_bank {
 	__be32 br;             /**< Base Register  */
@@ -98,6 +100,11 @@ struct fsl_lbc_regs {
 	__be32 mar;             /**< UPM Address Register */
 	u8 res1[0x4];
 	__be32 mamr;            /**< UPMA Mode Register */
+#define MxMR_OP_NO	(0 << 28) /**< normal operation */
+#define MxMR_OP_WA	(1 << 28) /**< write array */
+#define MxMR_OP_RA	(2 << 28) /**< read array */
+#define MxMR_OP_RP	(3 << 28) /**< run pattern */
+#define MxMR_MAD	0x3f      /**< machine address */
 	__be32 mbmr;            /**< UPMB Mode Register */
 	__be32 mcmr;            /**< UPMC Mode Register */
 	u8 res2[0x8];
@@ -220,4 +227,85 @@ struct fsl_lbc_regs {
 	u8 res8[0xF00];
 };
 
+extern struct fsl_lbc_regs __iomem *fsl_lbc_regs;
+extern spinlock_t fsl_lbc_lock;
+
+/*
+ * FSL UPM routines
+ */
+struct fsl_upm {
+	__be32 __iomem *mxmr;
+	int width;
+};
+
+extern int fsl_lbc_find(phys_addr_t addr_base);
+extern int fsl_upm_find(phys_addr_t addr_base, struct fsl_upm *upm);
+
+/**
+ * fsl_upm_start_pattern - start UPM patterns execution
+ * @upm:	pointer to the fsl_upm structure obtained via fsl_upm_find
+ * @pat_offset:	UPM pattern offset for the command to be executed
+ *
+ * This routine programmes UPM so the next memory access that hits an UPM
+ * will trigger pattern execution, starting at pat_offset.
+ */
+static inline void fsl_upm_start_pattern(struct fsl_upm *upm, u8 pat_offset)
+{
+	clrsetbits_be32(upm->mxmr, MxMR_MAD, MxMR_OP_RP | pat_offset);
+}
+
+/**
+ * fsl_upm_end_pattern - end UPM patterns execution
+ * @upm:	pointer to the fsl_upm structure obtained via fsl_upm_find
+ *
+ * This routine reverts UPM to normal operation mode.
+ */
+static inline void fsl_upm_end_pattern(struct fsl_upm *upm)
+{
+	clrbits32(upm->mxmr, MxMR_OP_RP);
+
+	while (in_be32(upm->mxmr) & MxMR_OP_RP)
+		cpu_relax();
+}
+
+/**
+ * fsl_upm_run_pattern - actually run an UPM pattern
+ * @upm:	pointer to the fsl_upm structure obtained via fsl_upm_find
+ * @io_base:	remapped pointer to where memory access should happen
+ * @mar:	MAR register content during pattern execution
+ *
+ * This function triggers dummy write to the memory specified by the io_base,
+ * thus UPM pattern actually executed. Note that mar usage depends on the
+ * pre-programmed AMX bits in the UPM RAM.
+ */
+static inline int fsl_upm_run_pattern(struct fsl_upm *upm,
+				      void __iomem *io_base, u32 mar)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fsl_lbc_lock, flags);
+
+	out_be32(&fsl_lbc_regs->mar, mar << (32 - upm->width));
+
+	switch (upm->width) {
+	case 8:
+		out_8(io_base, 0x0);
+		break;
+	case 16:
+		out_be16(io_base, 0x0);
+		break;
+	case 32:
+		out_be32(io_base, 0x0);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	spin_unlock_irqrestore(&fsl_lbc_lock, flags);
+
+	return ret;
+}
+
 #endif /* __ASM_FSL_LBC_H */
-- 
1.5.4.5
