Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C7EF8DDE3D
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 05:06:26 +1000 (EST)
Date: Fri, 28 Sep 2007 14:06:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH] cpm: Describe multi-user ram in its own device node.
Message-ID: <20070928190616.GB20213@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The way the current CPM binding describes available multi-user (a.k.a.
dual-ported) RAM doesn't work well when there are multiple free regions,
and it doesn't work at all if the region doesn't begin at the start of
the muram area (as the hardware needs to be programmed with offsets into
this area).  The latter situation can happen with SMC UARTs on CPM2, as its
parameter RAM is relocatable, u-boot puts it at zero, and the kernel doesn't
support moving it.

It is now described with a muram node, similar to QE.  The current CPM
binding is sufficiently recent (i.e. never appeared in an official release)
that compatibility with existing device trees is not an issue.

The code supporting the new binding is shared between cpm1 and cpm2, rather
than remain separated.  QE should be able to use this code as well, once
minor fixes are made to its device trees.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 Documentation/powerpc/booting-without-of.txt |   40 ++++++-
 arch/powerpc/Kconfig.debug                   |    6 +-
 arch/powerpc/boot/cpm-serial.c               |   44 +++++--
 arch/powerpc/boot/dts/ep88xc.dts             |   13 ++-
 arch/powerpc/boot/dts/mpc8272ads.dts         |   11 ++
 arch/powerpc/boot/dts/mpc885ads.dts          |   13 ++-
 arch/powerpc/boot/dts/pq2fads.dts            |   13 ++-
 arch/powerpc/sysdev/commproc.c               |   11 ++-
 arch/powerpc/sysdev/cpm2_common.c            |   36 ++----
 arch/powerpc/sysdev/cpm_common.c             |  159 ++++++++++++++++++++++++++
 drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    4 +-
 include/asm-powerpc/commproc.h               |   12 ++
 include/asm-powerpc/cpm.h                    |   14 +++
 include/asm-powerpc/cpm2.h                   |   10 ++
 14 files changed, 338 insertions(+), 48 deletions(-)
 create mode 100644 include/asm-powerpc/cpm.h

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index c36dcd2..ce5d67f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -1861,9 +1861,7 @@ platforms are moved over to use the flattened-device-tree model.
 
    Properties:
    - compatible : "fsl,cpm1", "fsl,cpm2", or "fsl,qe".
-   - reg : The first resource is a 48-byte region beginning with
-           CPCR.  The second is the available general-purpose
-           DPRAM.
+   - reg : A 48-byte region beginning with CPCR.
 
    Example:
 	cpm@119c0 {
@@ -1871,7 +1869,7 @@ platforms are moved over to use the flattened-device-tree model.
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		compatible = "fsl,mpc8272-cpm", "fsl,cpm2";
-		reg = <119c0 30 0 2000>;
+		reg = <119c0 30>;
 	}
 
    ii) Properties common to mulitple CPM/QE devices
@@ -2017,6 +2015,40 @@ platforms are moved over to use the flattened-device-tree model.
 		fsl,cpm-command = <2e600000>;
 	};
 
+   viii) Multi-User RAM (MURAM)
+
+   The multi-user/dual-ported RAM is expressed as a bus under the CPM node.
+
+   Ranges must be set up subject to the following restrictions:
+
+   - Children's reg nodes must be offsets from the start of all muram, even
+     if the user-data area does not begin at zero.
+   - If multiple range entries are used, the difference between the parent
+     address and the child address must be the same in all, so that a single
+     mapping can cover them all while maintaining the ability to determine
+     CPM-side offsets with pointer subtraction.  It is recommended that
+     multiple range entries not be used.
+   - A child address of zero must be translatable, even if no reg resources
+     contain it.
+
+   A child "data" node must exist, compatible with "fsl,cpm-muram-data", to
+   indicate the portion of muram that is usable by the OS for arbitrary
+   purposes.  The data node may have an arbitrary number of reg resources,
+   all of which contribute to the allocatable muram pool.
+
+   Example, based on mpc8272:
+
+	muram@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 10000>;
+
+		data@0 {
+			compatible = "fsl,cpm-muram-data";
+			reg = <0 2000 9800 800>;
+		};
+	};
+
    m) Chipselect/Local Bus
 
    Properties:
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f4e5d22..464f9b4 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -245,9 +245,9 @@ config PPC_EARLY_DEBUG_44x_PHYSHIGH
 config PPC_EARLY_DEBUG_CPM_ADDR
 	hex "CPM UART early debug transmit descriptor address"
 	depends on PPC_EARLY_DEBUG_CPM
-	default "0xfa202808" if PPC_EP88XC
-	default "0xf0000808" if CPM2
-	default "0xff002808" if CPM1
+	default "0xfa202008" if PPC_EP88XC
+	default "0xf0000008" if CPM2
+	default "0xff002008" if CPM1
 	help
 	  This specifies the address of the transmit descriptor
 	  used for early debug output.  Because it is needed before
diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index fcb8b5e..28296fa 100644
--- a/arch/powerpc/boot/cpm-serial.c
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -56,7 +56,8 @@ static struct cpm_smc *smc;
 static struct cpm_scc *scc;
 struct cpm_bd *tbdf, *rbdf;
 static u32 cpm_cmd;
-static u8 *dpram_start;
+static u8 *muram_start;
+static u32 muram_offset;
 
 static void (*do_cmd)(int op);
 static void (*enable_port)(void);
@@ -114,13 +115,12 @@ static void scc_enable_port(void)
 
 static int cpm_serial_open(void)
 {
-	int dpaddr = 0x800;
 	disable_port();
 
 	out_8(&param->rfcr, 0x10);
 	out_8(&param->tfcr, 0x10);
 
-	rbdf = (struct cpm_bd *)(dpram_start + dpaddr);
+	rbdf = (struct cpm_bd *)muram_start;
 	rbdf->addr = (u8 *)(rbdf + 2);
 	rbdf->sc = 0xa000;
 	rbdf->len = 1;
@@ -131,8 +131,8 @@ static int cpm_serial_open(void)
 	tbdf->len = 1;
 
 	sync();
-	out_be16(&param->rbase, dpaddr);
-	out_be16(&param->tbase, dpaddr + sizeof(struct cpm_bd));
+	out_be16(&param->rbase, muram_offset);
+	out_be16(&param->tbase, muram_offset + sizeof(struct cpm_bd));
 
 	do_cmd(CPM_CMD_INIT_RX_TX);
 
@@ -178,7 +178,7 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
 	void *reg_virt[2];
 	int is_smc = 0, is_cpm2 = 0, n;
 	unsigned long reg_phys;
-	void *parent;
+	void *parent, *muram;
 
 	if (dt_is_compatible(devp, "fsl,cpm1-smc-uart")) {
 		is_smc = 1;
@@ -229,16 +229,36 @@ int cpm_console_init(void *devp, struct serial_console_data *scdp)
 
 	n = getprop(parent, "virtual-reg", reg_virt, sizeof(reg_virt));
 	if (n < (int)sizeof(reg_virt)) {
-		for (n = 0; n < 2; n++) {
-			if (!dt_xlate_reg(parent, n, &reg_phys, NULL))
-				return -1;
+		if (!dt_xlate_reg(parent, 0, &reg_phys, NULL))
+			return -1;
 
-			reg_virt[n] = (void *)reg_phys;
-		}
+		reg_virt[0] = (void *)reg_phys;
 	}
 
 	cpcr = reg_virt[0];
-	dpram_start = reg_virt[1];
+
+	muram = finddevice("/soc/cpm/muram/data");
+	if (!muram)
+		return -1;
+
+	/* For bootwrapper-compatible device trees, we assume that the first
+	 * entry has at least 18 bytes, and that #address-cells/#data-cells
+	 * is one for both parent and child.
+	 */
+
+	n = getprop(muram, "virtual-reg", reg_virt, sizeof(reg_virt));
+	if (n < (int)sizeof(reg_virt)) {
+		if (!dt_xlate_reg(muram, 0, &reg_phys, NULL))
+			return -1;
+
+		reg_virt[0] = (void *)reg_phys;
+	}
+
+	muram_start = reg_virt[0];
+
+	n = getprop(muram, "reg", &muram_offset, 4);
+	if (n < 4)
+		return -1;
 
 	scdp->open = cpm_serial_open;
 	scdp->putc = cpm_serial_putc;
diff --git a/arch/powerpc/boot/dts/ep88xc.dts b/arch/powerpc/boot/dts/ep88xc.dts
index 0406fc5..02705f2 100644
--- a/arch/powerpc/boot/dts/ep88xc.dts
+++ b/arch/powerpc/boot/dts/ep88xc.dts
@@ -142,9 +142,20 @@
 			command-proc = <9c0>;
 			interrupts = <0>;	// cpm error interrupt
 			interrupt-parent = <&CPM_PIC>;
-			reg = <9c0 40 2000 1c00>;
+			reg = <9c0 40>;
 			ranges;
 
+			muram@2000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 2000 2000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 1c00>;
+				};
+			};
+
 			brg@9f0 {
 				compatible = "fsl,mpc885-brg",
 				             "fsl,cpm1-brg",
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
index 3fe991d..188179d 100644
--- a/arch/powerpc/boot/dts/mpc8272ads.dts
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -124,6 +124,17 @@
 			reg = <119c0 30 0 2000>;
 			ranges;
 
+			muram@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 2000 9800 800>;
+				};
+			};
+
 			brg@119f0 {
 				compatible = "fsl,mpc8272-brg",
 				             "fsl,cpm2-brg",
diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
index cbcd16f..8848e63 100644
--- a/arch/powerpc/boot/dts/mpc885ads.dts
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -148,9 +148,20 @@
 			command-proc = <9c0>;
 			interrupts = <0>;	// cpm error interrupt
 			interrupt-parent = <&CPM_PIC>;
-			reg = <9c0 40 2000 1c00>;
+			reg = <9c0 40>;
 			ranges;
 
+			muram@2000 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 2000 2000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 1c00>;
+				};
+			};
+
 			brg@9f0 {
 				compatible = "fsl,mpc885-brg",
 				             "fsl,cpm1-brg",
diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/dts/pq2fads.dts
index 54e8bd1..2d56492 100644
--- a/arch/powerpc/boot/dts/pq2fads.dts
+++ b/arch/powerpc/boot/dts/pq2fads.dts
@@ -119,9 +119,20 @@
 			#size-cells = <1>;
 			#interrupt-cells = <2>;
 			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
-			reg = <119c0 30 0 2000>;
+			reg = <119c0 30>;
 			ranges;
 
+			muram@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0 10000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 2000 9800 800>;
+				};
+			};
+
 			brg@119f0 {
 				compatible = "fsl,mpc8280-brg",
 				             "fsl,cpm2-brg",
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index e37f0a8..4b3e93c 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -39,12 +39,15 @@
 #include <asm/tlbflush.h>
 #include <asm/rheap.h>
 #include <asm/prom.h>
+#include <asm/cpm.h>
 
 #include <asm/fs_pd.h>
 
 #define CPM_MAP_SIZE    (0x4000)
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 static void m8xx_cpm_dpinit(void);
+#endif
 static uint host_buffer; /* One page of host buffer */
 static uint host_end;    /* end + 1 */
 cpm8xx_t __iomem *cpmp;  /* Pointer to comm processor space */
@@ -193,7 +196,7 @@ end:
 	return sirq;
 }
 
-void cpm_reset(void)
+void __init cpm_reset(void)
 {
 	sysconf8xx_t __iomem *siu_conf;
 
@@ -229,8 +232,12 @@ void cpm_reset(void)
 	out_be32(&siu_conf->sc_sdcr, 1);
 	immr_unmap(siu_conf);
 
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	cpm_muram_init();
+#else
 	/* Reclaim the DP memory for our use. */
 	m8xx_cpm_dpinit();
+#endif
 }
 
 /* We used to do this earlier, but have to postpone as long as possible
@@ -296,6 +303,7 @@ cpm_setbrg(uint brg, uint rate)
 		             CPM_BRG_EN | CPM_BRG_DIV16);
 }
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 /*
  * dpalloc / dpfree bits.
  */
@@ -397,6 +405,7 @@ uint cpm_dpram_phys(u8 *addr)
 	return (dpram_pbase + (uint)(addr - dpram_vbase));
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
 
 struct cpm_ioport16 {
 	__be16 dir, par, sor, dat, intr;
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 9058da2..453f8a5 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -46,7 +46,10 @@
 
 #include <sysdev/fsl_soc.h>
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 static void cpm2_dpinit(void);
+#endif
+
 cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor space */
 
 /* We allocate this here because it is used almost exclusively for
@@ -65,7 +68,11 @@ cpm2_reset(void)
 
 	/* Reclaim the DP memory for our use.
 	 */
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+	cpm_muram_init();
+#else
 	cpm2_dpinit();
+#endif
 
 	/* Tell everyone where the comm processor resides.
 	 */
@@ -312,6 +319,7 @@ int cpm2_smc_clk_setup(enum cpm_clk_target target, int clock)
 	return ret;
 }
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 /*
  * dpalloc / dpfree bits.
  */
@@ -324,28 +332,6 @@ static u8 __iomem *im_dprambase;
 
 static void cpm2_dpinit(void)
 {
-	struct resource r;
-
-#ifdef CONFIG_PPC_CPM_NEW_BINDING
-	struct device_node *np;
-
-	np = of_find_compatible_node(NULL, NULL, "fsl,cpm2");
-	if (!np)
-		panic("Cannot find CPM2 node");
-
-	if (of_address_to_resource(np, 1, &r))
-		panic("Cannot get CPM2 resource 1");
-
-	of_node_put(np);
-#else
-	r.start = CPM_MAP_ADDR + CPM_DATAONLY_BASE;
-	r.end = r.start + CPM_DATAONLY_SIZE - 1;
-#endif
-
-	im_dprambase = ioremap(r.start, r.end - r.start + 1);
-	if (!im_dprambase)
-		panic("Cannot map DPRAM");
-
 	spin_lock_init(&cpm_dpmem_lock);
 
 	/* initialize the info header */
@@ -354,13 +340,16 @@ static void cpm2_dpinit(void)
 			sizeof(cpm_boot_dpmem_rh_block[0]),
 			cpm_boot_dpmem_rh_block);
 
+	im_dprambase = cpm2_immr->im_dprambase;
+
 	/* Attach the usable dpmem area */
 	/* XXX: This is actually crap. CPM_DATAONLY_BASE and
 	 * CPM_DATAONLY_SIZE is only a subset of the available dpram. It
 	 * varies with the processor and the microcode patches activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, 0, r.end - r.start + 1);
+	rh_attach_region(&cpm_dpmem_info, CPM_MAP_ADDR + CPM_DATAONLY_BASE,
+	                 CPM_DATAONLY_SIZE);
 }
 
 /* This function returns an index into the DPRAM area.
@@ -418,6 +407,7 @@ void *cpm_dpram_addr(unsigned long offset)
 	return (void *)(im_dprambase + offset);
 }
 EXPORT_SYMBOL(cpm_dpram_addr);
+#endif /* !CONFIG_PPC_CPM_NEW_BINDING */
 
 struct cpm2_ioports {
 	u32 dir, par, sor, odr, dat;
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 9daa6ac..66c8ad4 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -5,15 +5,27 @@
  *
  * Copyright 2007 Freescale Semiconductor, Inc.
  *
+ * Some parts derived from commproc.c/cpm2_common.c, which is:
+ * Copyright (c) 1997 Dan error_act (dmalek@jlc.net)
+ * Copyright (c) 1999-2001 Dan Malek <dan@embeddedalley.com>
+ * Copyright (c) 2000 MontaVista Software, Inc (source@mvista.com)
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
  * published by the Free Software Foundation.
  */
 
 #include <linux/init.h>
+#include <linux/of_device.h>
+
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/system.h>
+#include <asm/rheap.h>
+#include <asm/cpm.h>
+
 #include <mm/mmu_decl.h>
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_CPM
@@ -41,6 +53,153 @@ void __init udbg_init_cpm(void)
 		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, _PAGE_IO);
 #endif
 		udbg_putc = udbg_putc_cpm;
+		udbg_putc('X');
 	}
 }
 #endif
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+static spinlock_t cpm_muram_lock;
+static rh_block_t cpm_boot_muram_rh_block[16];
+static rh_info_t cpm_muram_info;
+static u8 __iomem *muram_vbase;
+static phys_addr_t muram_pbase;
+
+/* Max address size we deal with */
+#define OF_MAX_ADDR_CELLS	4
+
+int __init cpm_muram_init(void)
+{
+	struct device_node *np;
+	struct resource r;
+	u32 zero[OF_MAX_ADDR_CELLS] = {};
+	resource_size_t max = 0;
+	int i = 0;
+	int ret = 0;
+
+	printk("cpm_muram_init\n");
+
+	spin_lock_init(&cpm_muram_lock);
+	/* initialize the info header */
+	rh_init(&cpm_muram_info, 1,
+	        sizeof(cpm_boot_muram_rh_block) /
+	        sizeof(cpm_boot_muram_rh_block[0]),
+	        cpm_boot_muram_rh_block);
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,cpm-muram-data");
+	if (!np) {
+		printk(KERN_ERR "Cannot find CPM muram data node");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	muram_pbase = of_translate_address(np, zero);
+	if (muram_pbase == (phys_addr_t)OF_BAD_ADDR) {
+		printk(KERN_ERR "Cannot translate zero through CPM muram node");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	while (of_address_to_resource(np, i++, &r) == 0) {
+		if (r.end > max)
+			max = r.end;
+
+		rh_attach_region(&cpm_muram_info, r.start - muram_pbase,
+		                 r.end - r.start + 1);
+	}
+
+	muram_vbase = ioremap(muram_pbase, max - muram_pbase + 1);
+	if (!muram_vbase) {
+		printk(KERN_ERR "Cannot map CPM muram");
+		ret = -ENOMEM;
+	}
+
+out:
+	of_node_put(np);
+	return ret;
+}
+
+/**
+ * cpm_muram_alloc - allocate the requested size worth of multi-user ram
+ * @size: number of bytes to allocate
+ * @align: requested alignment, in bytes
+ *
+ * This function returns an offset into the muram area.
+ * Use cpm_dpram_addr() to get the virtual address of the area.
+ * Use cpm_muram_free() to free the allocation.
+ */
+unsigned long cpm_muram_alloc(unsigned long size, unsigned long align)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_muram_lock, flags);
+	cpm_muram_info.alignment = align;
+	start = rh_alloc(&cpm_muram_info, size, "commproc");
+	spin_unlock_irqrestore(&cpm_muram_lock, flags);
+
+	return start;
+}
+EXPORT_SYMBOL(cpm_muram_alloc);
+
+/**
+ * cpm_muram_free - free a chunk of multi-user ram
+ * @offset: The beginning of the chunk as returned by cpm_muram_alloc().
+ */
+int cpm_muram_free(unsigned long offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_muram_lock, flags);
+	ret = rh_free(&cpm_muram_info, offset);
+	spin_unlock_irqrestore(&cpm_muram_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(cpm_muram_free);
+
+/**
+ * cpm_muram_alloc_fixed - reserve a specific region of multi-user ram
+ * @offset: the offset into the muram area to reserve
+ * @size: the number of bytes to reserve
+ *
+ * This function returns "start" on success, -ENOMEM on failure.
+ * Use cpm_dpram_addr() to get the virtual address of the area.
+ * Use cpm_muram_free() to free the allocation.
+ */
+unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size)
+{
+	unsigned long start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpm_muram_lock, flags);
+	cpm_muram_info.alignment = 1;
+	start = rh_alloc_fixed(&cpm_muram_info, offset, size, "commproc");
+	spin_unlock_irqrestore(&cpm_muram_lock, flags);
+
+	return start;
+}
+EXPORT_SYMBOL(cpm_muram_alloc_fixed);
+
+/**
+ * cpm_muram_addr - turn a muram offset into a virtual address
+ * @offset: muram offset to convert
+ */
+void __iomem *cpm_muram_addr(unsigned long offset)
+{
+	return muram_vbase + offset;
+}
+EXPORT_SYMBOL(cpm_muram_addr);
+
+/**
+ * cpm_muram_phys - turn a muram virtual address into a DMA address
+ * @offset: virtual address from cpm_muram_addr() to convert
+ */
+dma_addr_t cpm_muram_dma(void __iomem *addr)
+{
+	return muram_pbase + ((u8 __iomem *)addr - muram_vbase);
+}
+EXPORT_SYMBOL(cpm_muram_dma);
+
+#endif /* CONFIG_PPC_CPM_NEW_BINDING */
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index 5bd4508..882dbc1 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -235,7 +235,7 @@ void scc4_lineif(struct uart_cpm_port *pinfo)
 int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 {
 	int dpmemsz, memsz;
-	u8 *dp_mem;
+	u8 __iomem *dp_mem;
 	unsigned long dp_offset;
 	u8 *mem_addr;
 	dma_addr_t dma_addr = 0;
@@ -278,7 +278,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 	pinfo->tx_buf = pinfo->rx_buf + L1_CACHE_ALIGN(pinfo->rx_nrfifos
 						       * pinfo->rx_fifosize);
 
-	pinfo->rx_bd_base = (cbd_t __iomem __force *)dp_mem;
+	pinfo->rx_bd_base = (cbd_t __iomem *)dp_mem;
 	pinfo->tx_bd_base = pinfo->rx_bd_base + pinfo->rx_nrfifos;
 
 	return 0;
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index 5dec324..0307c84 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -19,6 +19,7 @@
 
 #include <asm/8xx_immap.h>
 #include <asm/ptrace.h>
+#include <asm/cpm.h>
 
 /* CPM Command register.
 */
@@ -54,6 +55,7 @@
 
 #define mk_cr_cmd(CH, CMD)	((CMD << 8) | (CH << 4))
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 /* The dual ported RAM is multi-functional.  Some areas can be (and are
  * being) used for microcode.  There is an area that can only be used
  * as data ram for buffer descriptors, which is all we use right now.
@@ -62,17 +64,27 @@
 #define CPM_DATAONLY_BASE	((uint)0x0800)
 #define CPM_DATAONLY_SIZE	((uint)0x0700)
 #define CPM_DP_NOSPACE		((uint)0x7fffffff)
+#endif
 
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
 extern cpm8xx_t __iomem *cpmp; /* Pointer to comm processor */
+
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+#define cpm_dpalloc cpm_muram_alloc
+#define cpm_dpfree cpm_muram_free
+#define cpm_dpram_addr cpm_muram_addr
+#define cpm_dpram_phys cpm_muram_dma
+#else
 extern unsigned long cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(unsigned long offset);
 extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
 extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(unsigned long offset);
 extern uint cpm_dpram_phys(u8* addr);
+#endif
+
 extern void cpm_setbrg(uint brg, uint rate);
 
 extern uint m8xx_cpm_hostalloc(uint size);
diff --git a/include/asm-powerpc/cpm.h b/include/asm-powerpc/cpm.h
new file mode 100644
index 0000000..48df9f3
--- /dev/null
+++ b/include/asm-powerpc/cpm.h
@@ -0,0 +1,14 @@
+#ifndef __CPM_H
+#define __CPM_H
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+int cpm_muram_init(void);
+unsigned long cpm_muram_alloc(unsigned long size, unsigned long align);
+int cpm_muram_free(unsigned long offset);
+unsigned long cpm_muram_alloc_fixed(unsigned long offset, unsigned long size);
+void __iomem *cpm_muram_addr(unsigned long offset);
+dma_addr_t cpm_muram_dma(void __iomem *addr);
+
+#endif
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index d7b57ac..e698b1d 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -11,6 +11,7 @@
 #define __CPM2__
 
 #include <asm/immap_cpm2.h>
+#include <asm/cpm.h>
 
 /* CPM Command register.
 */
@@ -82,6 +83,7 @@
 #define mk_cr_cmd(PG, SBC, MCN, OP) \
 	((PG << 26) | (SBC << 21) | (MCN << 6) | OP)
 
+#ifndef CONFIG_PPC_CPM_NEW_BINDING
 /* Dual Port RAM addresses.  The first 16K is available for almost
  * any CPM use, so we put the BDs there.  The first 128 bytes are
  * used for SMC1 and SMC2 parameter RAM, so we start allocating
@@ -97,6 +99,7 @@
 #define CPM_DATAONLY_SIZE	((uint)(16 * 1024) - CPM_DATAONLY_BASE)
 #define CPM_FCC_SPECIAL_BASE	((uint)0x0000b000)
 #endif
+#endif
 
 /* The number of pages of host memory we allocate for CPM.  This is
  * done early in kernel initialization to get physically contiguous
@@ -109,11 +112,18 @@
  */
 extern cpm_cpm2_t __iomem *cpmp; /* Pointer to comm processor */
 
+#ifdef CONFIG_PPC_CPM_NEW_BINDING
+#define cpm_dpalloc cpm_muram_alloc
+#define cpm_dpfree cpm_muram_free
+#define cpm_dpram_addr cpm_muram_addr
+#else
 extern unsigned long cpm_dpalloc(uint size, uint align);
 extern int cpm_dpfree(unsigned long offset);
 extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
 extern void cpm_dpdump(void);
 extern void *cpm_dpram_addr(unsigned long offset);
+#endif
+
 extern void cpm_setbrg(uint brg, uint rate);
 extern void cpm2_fastbrg(uint brg, uint rate, int div16);
 extern void cpm2_reset(void);
-- 
1.5.3.2
