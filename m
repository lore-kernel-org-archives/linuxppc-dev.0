Subject: Re: Caching in the MPC107, linux 2.6
From: Adrian Cox <adrian@humboldt.co.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <20040315224843.GB14221@smtp.west.cox.net>
References: <1079088369.691.43.camel@newt>
	 <20040313170708.GA20738@smtp.west.cox.net> <1079380996.1677.2.camel@newt>
	 <20040315203849.GA13167@smtp.west.cox.net> <1079390532.1677.12.camel@newt>
	 <20040315224843.GB14221@smtp.west.cox.net>
Content-Type: multipart/mixed; boundary="=-f/3g6hB/+jObUq/YPG0Y"
Message-Id: <1079460373.1677.331.camel@newt>
Mime-Version: 1.0
Date: Tue, 16 Mar 2004 18:06:14 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-f/3g6hB/+jObUq/YPG0Y
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2004-03-15 at 22:48, Tom Rini wrote:
> On Mon, Mar 15, 2004 at 10:42:13PM +0000, Adrian Cox wrote:

> > I made my patch depend on CONFIG_MPC10X_BRIDGE, instead of
> > CONFIG_MPC10X_STORE_GATHERING, because I'm in the middle of porting
> > other MPC107 drivers from kernel 2.4 to 2.6.
>
> I can live with that I think.  Can you send that version and I'll do any
> additional cleanups (stylistically) ?

This is my latest version as two patches (I'm not 100% sure what was
damaging whitespace, but these are straight out of bk). The first patch
adds CONFIG_MPC10X_BRIDGE, and the second patch adds a new feature,
CPU_FTR_NEEDS_COHERENT. This requires a large edit to the cputable, but
gives a simple result in hashtable.S and ppc_mmu.c.

- Adrian Cox


--=-f/3g6hB/+jObUq/YPG0Y
Content-Disposition: attachment; filename=bridge.patch
Content-Type: text/x-patch; name=bridge.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1175  -> 1.1176
#	arch/ppc/syslib/Makefile	1.24    -> 1.25
#	    arch/ppc/Kconfig	1.63    -> 1.64
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/16	adrian@humboldt.co.uk	1.1176
# Add CONFIG_MPC10X_BRIDGE option
# --------------------------------------------
#
diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Tue Mar 16 17:00:54 2004
+++ b/arch/ppc/Kconfig	Tue Mar 16 17:00:54 2004
@@ -627,9 +627,14 @@
 	depends on 6xx && (LOPEC || SANDPOINT)
 	default y

+config MPC10X_BRIDGE
+	bool
+	depends on FORCE || LOPEC || SANDPOINT
+	default y
+
 config MPC10X_STORE_GATHERING
 	bool "Enable MPC10x store gathering"
-	depends on FORCE || SANDPOINT
+	depends on MPC10X_BRIDGE

 config CPC710_DATA_GATHERING
 	bool "Enable CPC710 data gathering"
diff -Nru a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
--- a/arch/ppc/syslib/Makefile	Tue Mar 16 17:00:54 2004
+++ b/arch/ppc/syslib/Makefile	Tue Mar 16 17:00:54 2004
@@ -45,8 +45,7 @@
 obj-$(CONFIG_GEMINI)		+= open_pic.o i8259.o indirect_pci.o
 obj-$(CONFIG_K2)		+= i8259.o indirect_pci.o todc_time.o \
 					pci_auto.o
-obj-$(CONFIG_LOPEC)		+= mpc10x_common.o indirect_pci.o pci_auto.o \
-					open_pic.o i8259.o todc_time.o
+obj-$(CONFIG_LOPEC)		+= pci_auto.o open_pic.o i8259.o todc_time.o
 obj-$(CONFIG_MCPN765)		+= todc_time.o indirect_pci.o pci_auto.o \
 					open_pic.o i8259.o pplus_common.o
 obj-$(CONFIG_MENF1)		+= todc_time.o i8259.o mpc10x_common.o \
@@ -55,18 +54,15 @@
 					i8259.o pci_auto.o pplus_common.o
 obj-$(CONFIG_OCOTEA)		+= indirect_pci.o pci_auto.o todc_time.o
 obj-$(CONFIG_PAL4)		+= cpc700_pic.o
-obj-$(CONFIG_PCORE)		+= mpc10x_common.o todc_time.o i8259.o \
-					indirect_pci.o pci_auto.o
-obj-$(CONFIG_POWERPMC250)	+= open_pic.o mpc10x_common.o \
-					indirect_pci.o pci_auto.o
+obj-$(CONFIG_PCORE)		+= todc_time.o i8259.o pci_auto.o
+obj-$(CONFIG_POWERPMC250)	+= open_pic.o pci_auto.o
 obj-$(CONFIG_PPLUS)		+= pplus_common.o open_pic.o i8259.o \
 				   indirect_pci.o todc_time.o pci_auto.o
 obj-$(CONFIG_PRPMC750)		+= open_pic.o indirect_pci.o pci_auto.o \
 					pplus_common.o
 obj-$(CONFIG_PRPMC800)		+= open_pic.o indirect_pci.o pci_auto.o \
 					pplus_common.o harrier.o
-obj-$(CONFIG_SANDPOINT)		+= i8259.o open_pic.o mpc10x_common.o \
-					pci_auto.o indirect_pci.o todc_time.o
+obj-$(CONFIG_SANDPOINT)		+= i8259.o open_pic.o pci_auto.o todc_time.o
 obj-$(CONFIG_SPRUCE)		+= cpc700_pic.o indirect_pci.o pci_auto.o \
 				   todc_time.o
 obj-$(CONFIG_8260)		+= m8260_setup.o ppc8260_pic.o
@@ -75,3 +71,4 @@
 obj-$(CONFIG_SERIAL_TEXT_DEBUG)	+= gen550_dbg.o
 endif
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
+obj-$(CONFIG_MPC10X_BRIDGE)     += mpc10x_common.o indirect_pci.o

--=-f/3g6hB/+jObUq/YPG0Y
Content-Disposition: attachment; filename=coherent.patch
Content-Type: text/x-patch; name=coherent.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1176  -> 1.1177
#	arch/ppc/mm/ppc_mmu.c	1.12    -> 1.13
#	include/asm-ppc/cputable.h	1.11    -> 1.12
#	arch/ppc/kernel/cputable.c	1.24    -> 1.25
#	arch/ppc/mm/hashtable.S	1.18    -> 1.19
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/03/16	adrian@humboldt.co.uk	1.1177
# Make setting of _PAGE_COHERENT depend on CPU_FTR_NEED_COHERENT, which can then
# be set by any condition that requires it: currently SMP and the combination of
# MPC10x/745x.
# --------------------------------------------
#
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	Tue Mar 16 17:11:42 2004
+++ b/arch/ppc/kernel/cputable.c	Tue Mar 16 17:11:42 2004
@@ -53,10 +53,23 @@
 #define PPC_FEATURE_ALTIVEC_COMP       	0
 #endif

+#ifdef CONFIG_MPC10X_BRIDGE
+#define CPU_FTR_745X_MPC107             CPU_FTR_NEED_COHERENT
+#else
+#define CPU_FTR_745X_MPC107             0
+#endif
+
+#ifdef CONFIG_SMP
+#define CPU_FTR_COMMON                  CPU_FTR_NEED_COHERENT
+#else
+#define CPU_FTR_COMMON                  0
+#endif
+
 struct cpu_spec	cpu_specs[] = {
 #if CLASSIC_PPC
     { 	/* 601 */
 	0xffff0000, 0x00010000, "601",
+	CPU_FTR_COMMON |
 	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
 	32, 32,
@@ -64,6 +77,7 @@
     },
     {	/* 603 */
     	0xffff0000, 0x00030000, "603",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -72,6 +86,7 @@
     },
     {	/* 603e */
     	0xffff0000, 0x00060000, "603e",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -80,6 +95,7 @@
     },
     {	/* 603ev */
     	0xffff0000, 0x00070000, "603ev",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
     	CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -88,6 +104,7 @@
     },
     {	/* 604 */
     	0xffff0000, 0x00040000, "604",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -96,6 +113,7 @@
     },
     {	/* 604e */
     	0xfffff000, 0x00090000, "604e",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -104,6 +122,7 @@
     },
     {	/* 604r */
     	0xffff0000, 0x00090000, "604r",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -112,6 +131,7 @@
     },
     {	/* 604ev */
     	0xffff0000, 0x000a0000, "604ev",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
 	CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
@@ -120,6 +140,7 @@
     },
     {	/* 740/750 (0x4202, don't support TAU ?) */
     	0xffffffff, 0x00084202, "740/750",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -128,6 +149,7 @@
     },
     {	/* 745/755 */
     	0xfffff000, 0x00083000, "745/755",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -136,6 +158,7 @@
     },
     {	/* 750CX (80100 and 8010x?) */
     	0xfffffff0, 0x00080100, "750CX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -144,6 +167,7 @@
     },
     {	/* 750CX (82201 and 82202) */
     	0xfffffff0, 0x00082200, "750CX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -152,6 +176,7 @@
     },
     {	/* 750CXe (82214) */
     	0xfffffff0, 0x00082210, "750CXe",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -160,6 +185,7 @@
     },
     {	/* 750FX rev 1.x */
     	0xffffff00, 0x70000100, "750FX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
 	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_NO_DPM,
@@ -169,6 +195,7 @@
     },
     {	/* 750FX rev 2.0 must disable HID0[DPM] */
     	0xffffffff, 0x70000200, "750FX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
 	CPU_FTR_NO_DPM,
@@ -178,6 +205,7 @@
     },
     {	/* 750FX (All revs except 2.0) */
     	0xffff0000, 0x70000000, "750FX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP |
 	CPU_FTR_DUAL_PLL_750FX | CPU_FTR_HAS_HIGH_BATS,
@@ -188,6 +216,7 @@

     {	/* 740/750 (L2CR bit need fixup for 740) */
     	0xffff0000, 0x00080000, "740/750",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_HPTE_TABLE | CPU_FTR_CAN_NAP,
 	COMMON_PPC,
@@ -196,6 +225,7 @@
     },
     {	/* 7400 rev 1.1 ? (no TAU) */
     	0xffffffff, 0x000c1101, "7400 (1.1)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_CAN_NAP,
@@ -205,6 +235,7 @@
     },
     {	/* 7400 */
     	0xffff0000, 0x000c0000, "7400",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_CAN_NAP,
@@ -214,6 +245,7 @@
     },
     {	/* 7410 */
     	0xffff0000, 0x800c0000, "7410",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_TAU | CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_CAN_NAP,
@@ -223,6 +255,7 @@
     },
     {	/* 7450 2.0 - no doze/nap */
     	0xffffffff, 0x80000200, "7450",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450,
@@ -232,6 +265,7 @@
     },
     {	/* 7450 2.1 */
     	0xffffffff, 0x80000201, "7450",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
@@ -242,6 +276,7 @@
     },
     {	/* 7450 2.3 and newer */
     	0xffff0000, 0x80000000, "7450",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR,
@@ -251,6 +286,7 @@
     },
     {	/* 7455 rev 1.x */
     	0xffffff00, 0x80010100, "7455",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_HAS_HIGH_BATS,
@@ -260,6 +296,7 @@
     },
     {	/* 7455 rev 2.0 */
     	0xffffffff, 0x80010200, "7455",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
@@ -270,6 +307,7 @@
     },
     {	/* 7455 others */
     	0xffff0000, 0x80010000, "7455",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
@@ -280,6 +318,7 @@
     },
     {	/* 7457 */
     	0xffff0000, 0x80020000, "7457",
+	CPU_FTR_COMMON | CPU_FTR_745X_MPC107 |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_CAN_NAP |
 	CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 	CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
@@ -290,6 +329,7 @@
     },
     {	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 	0x7fff0000, 0x00810000, "82xx",
+	CPU_FTR_COMMON |
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
 	COMMON_PPC,
 	32, 32,
@@ -297,6 +337,7 @@
     },
     {	/* default match, we assume split I/D cache & TB (non-601)... */
     	0x00000000, 0x00000000, "(generic PPC)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
@@ -306,6 +347,7 @@
 #ifdef CONFIG_PPC64BRIDGE
     {	/* Power3 */
     	0xffff0000, 0x00400000, "Power3 (630)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
     	COMMON_PPC | PPC_FEATURE_64,
 	128, 128,
@@ -313,6 +355,7 @@
     },
     {	/* Power3+ */
     	0xffff0000, 0x00410000, "Power3 (630+)",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
     	COMMON_PPC | PPC_FEATURE_64,
 	128, 128,
@@ -320,6 +363,7 @@
     },
 	{	/* I-star */
 		0xffff0000, 0x00360000, "I-star",
+		CPU_FTR_COMMON |
 		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 		COMMON_PPC | PPC_FEATURE_64,
 		128, 128,
@@ -327,6 +371,7 @@
 	},
 	{	/* S-star */
 		0xffff0000, 0x00370000, "S-star",
+		CPU_FTR_COMMON |
 		CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 		COMMON_PPC | PPC_FEATURE_64,
 		128, 128,
@@ -336,6 +381,7 @@
 #ifdef CONFIG_POWER4
     {	/* Power4 */
     	0xffff0000, 0x00350000, "Power4",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
     	COMMON_PPC | PPC_FEATURE_64,
 	128, 128,
@@ -343,6 +389,7 @@
     },
     {	/* PPC970 */
 	0xffff0000, 0x00390000, "PPC970",
+	CPU_FTR_COMMON |
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE |
 	CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP,
 	COMMON_PPC | PPC_FEATURE_64 | PPC_FEATURE_ALTIVEC_COMP,
@@ -353,6 +400,7 @@
 #ifdef CONFIG_8xx
     {	/* 8xx */
     	0xffff0000, 0x00500000, "8xx",
+	CPU_FTR_COMMON |
 		/* CPU_FTR_CAN_DOZE is possible, if the 8xx code is there.... */
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
@@ -363,6 +411,7 @@
 #ifdef CONFIG_40x
     {	/* 403GC */
     	0xffffff00, 0x00200200, "403GC",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 	16, 16,
@@ -370,6 +419,7 @@
     },
     {	/* 403GCX */
     	0xffffff00, 0x00201400, "403GCX",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 	16, 16,
@@ -377,6 +427,7 @@
     },
     {	/* 403G ?? */
     	0xffff0000, 0x00200000, "403G ??",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 	16, 16,
@@ -384,6 +435,7 @@
     },
     {	/* 405GP */
     	0xffff0000, 0x40110000, "405GP",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -391,6 +443,7 @@
     },
     {	/* STB 03xxx */
     	0xffff0000, 0x40130000, "STB03xxx",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -398,6 +451,7 @@
     },
     {	/* STB 04xxx */
     	0xffff0000, 0x41810000, "STB04xxx",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -405,6 +459,7 @@
     },
     {	/* NP405L */
     	0xffff0000, 0x41610000, "NP405L",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -412,6 +467,7 @@
     },
     {	/* NP4GS3 */
     	0xffff0000, 0x40B10000, "NP4GS3",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -419,6 +475,7 @@
     },
     {   /* NP405H */
         0xffff0000, 0x41410000, "NP405H",
+	CPU_FTR_COMMON |
         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
         PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
         32, 32,
@@ -426,6 +483,7 @@
      },
      {	/* 405GPr */
     	0xffff0000, 0x50910000, "405GPr",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -433,6 +491,7 @@
     },
     {   /* STBx25xx */
         0xffff0000, 0x51510000, "STBx25xx",
+	CPU_FTR_COMMON |
         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
         PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
         32, 32,
@@ -440,6 +499,7 @@
      },
      {	/* 405LP */
     	0xffff0000, 0x41F10000, "405LP",
+	CPU_FTR_COMMON |
     	CPU_FTR_SPLIT_ID_CACHE |  CPU_FTR_USE_TB,
     	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
 	32, 32,
@@ -447,6 +507,7 @@
      },
      {	/* Xilinx Virtex-II Pro  */
 	0xffff0000, 0x20010000, "Virtex-II Pro",
+	CPU_FTR_COMMON |
 	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
 	PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
 	32, 32,
@@ -457,6 +518,7 @@
 #ifdef CONFIG_44x
     { /* 440GP Rev. B */
         0xf0000fff, 0x40000440, "440GP Rev. B",
+	CPU_FTR_COMMON |
         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
         PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
         32, 32,
@@ -464,6 +526,7 @@
     },
     { /* 440GP Rev. C */
         0xf0000fff, 0x40000481, "440GP Rev. C",
+	CPU_FTR_COMMON |
         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
         PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
         32, 32,
@@ -471,6 +534,7 @@
     },
     { /* 440GX Rev. A */
         0xf0000fff, 0x50000850, "440GX Rev. A",
+	CPU_FTR_COMMON |
         CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
         PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
         32, 32,
@@ -480,7 +544,7 @@
 #if !CLASSIC_PPC
     {	/* default match */
     	0x00000000, 0x00000000, "(generic PPC)",
-    	0,
+	CPU_FTR_COMMON,
     	PPC_FEATURE_32,
 	32, 32,
 	0,
diff -Nru a/arch/ppc/mm/hashtable.S b/arch/ppc/mm/hashtable.S
--- a/arch/ppc/mm/hashtable.S	Tue Mar 16 17:11:42 2004
+++ b/arch/ppc/mm/hashtable.S	Tue Mar 16 17:11:42 2004
@@ -346,9 +346,9 @@
 	rlwimi	r5,r5,32-2,31,31	/* _PAGE_USER -> PP lsb */
 	ori	r8,r8,0xe14		/* clear out reserved bits and M */
 	andc	r8,r5,r8		/* PP = user? (rw&dirty? 2: 3): 0 */
-#ifdef CONFIG_SMP
+BEGIN_FTR_SECTION
 	ori	r8,r8,_PAGE_COHERENT	/* set M (coherence required) */
-#endif
+END_FTR_SECTION_IFSET(CPU_FTR_NEED_COHERENT)

 	/* Construct the high word of the PPC-style PTE (r5) */
 #ifndef CONFIG_PPC64BRIDGE
diff -Nru a/arch/ppc/mm/ppc_mmu.c b/arch/ppc/mm/ppc_mmu.c
--- a/arch/ppc/mm/ppc_mmu.c	Tue Mar 16 17:11:42 2004
+++ b/arch/ppc/mm/ppc_mmu.c	Tue Mar 16 17:11:42 2004
@@ -137,10 +137,10 @@
 	int wimgxpp;
 	union ubat *bat = BATS[index];

-#ifdef CONFIG_SMP
-	if ((flags & _PAGE_NO_CACHE) == 0)
+	if (((flags & _PAGE_NO_CACHE) == 0) &&
+	    (cur_cpu_spec[0]->cpu_features & CPU_FTR_NEED_COHERENT))
 		flags |= _PAGE_COHERENT;
-#endif
+
 	bl = (size >> 17) - 1;
 	if (PVR_VER(mfspr(PVR)) != 1) {
 		/* 603, 604, etc. */
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	Tue Mar 16 17:11:42 2004
+++ b/include/asm-ppc/cputable.h	Tue Mar 16 17:11:42 2004
@@ -75,6 +75,7 @@
 #define CPU_FTR_DUAL_PLL_750FX		0x00004000
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
+#define CPU_FTR_NEED_COHERENT           0x00020000

 #ifdef __ASSEMBLY__


--=-f/3g6hB/+jObUq/YPG0Y--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
