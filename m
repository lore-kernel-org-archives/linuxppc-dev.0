From: Benjamin Herrenschmidt <benjamin.herrenschmidt@wanadoo.fr>
To: Cort Dougan <cort@fsmlabs.com>, <linuxppc-commit@fsmlabs.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: CPU features again
Date: Wed, 18 Apr 2001 18:03:28 +0200
Message-Id: <20010418160328.15973@mailhost.mipsys.com>
In-Reply-To: <20010417140515.A17204@ftsoj.fsmlabs.com>
References: <20010417140515.A17204@ftsoj.fsmlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


While we are at it, the CPU features stuff is now working properly on SMP
too.

It relies on another change to binfmt_elf.c and friends that Alan have
merged in the ac tree and I pushed to bk today.

It still need a head_4/8xx.S implementation (possibly copy&paste of the
head.S one, I'm not too sure about the phys/virt stuffs on those as the
code is meant to run very early in head.S, before the kernel is relocated
down to 0)

Also, the definition of the feature bits exposed to glibc should be
reworked to put there features that really matter (they are different
from in-kernel features). I've filled them with "trivial" things like
FPU, Altivec or MMU presence (will there be a uClinux for PPC ?) for now.

Those feature bits have to be common accross the entire PPC range (and
possibly common with ppc64 too since ppc64 is supposed to run ppc32
binaries, except that ppc64 has 32 more bits to stuff it's own features
for 64 bits binaries).

Ben.

diff -Nru a/arch/ppc/boot/misc.c b/arch/ppc/boot/misc.c
--- a/arch/ppc/boot/misc.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/boot/misc.c	Wed Apr 18 18:00:14 2001
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include "../coffboot/zlib.h"
 #include "asm/residual.h"
+#include <linux/threads.h>
 #include <linux/elf.h>
 #include <linux/config.h>
 #include <asm/page.h>
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/Makefile	Wed Apr 18 18:00:14 2001
@@ -32,7 +32,7 @@
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o bitops.o ptrace.o \
 					ppc_htab.o semaphore.o syscalls.o  \
-					align.o setup.o
+					align.o setup.o cputable.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_POWER4)		+= xics.o
 obj-$(CONFIG_PCI)		+= pci.o pci-dma.o
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/kernel/cputable.c	Wed Apr 18 18:00:14 2001
@@ -0,0 +1,224 @@
+#include <linux/config.h>
+#include <linux/string.h>
+#include <linux/sched.h>
+#include <linux/threads.h>
+#include <linux/init.h>
+#include <asm/cputable.h>
+
+struct cpu_spec* cur_cpu_spec[NR_CPUS];
+
+extern void __setup_cpu_601(int cpu_nr);
+extern void __setup_cpu_603(int cpu_nr);
+extern void __setup_cpu_604(int cpu_nr);
+extern void __setup_cpu_750(int cpu_nr);
+extern void __setup_cpu_7400(int cpu_nr);
+extern void __setup_cpu_7450(int cpu_nr);
+extern void __setup_cpu_power3(int cpu_nr);
+extern void __setup_cpu_power4(int cpu_nr);
+extern void __setup_cpu_generic(int cpu_nr);
+
+#define CLASSIC_PPC (!defined(CONFIG_8260) && !defined(CONFIG_8xx) && \
+	!defined(CONFIG_4xx) && !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4))
+
+/* This table only contains "desktop" CPUs, it need to be filled with
embedded
+ * ones as well...
+ */
+#define COMMON_PPC	PPC_FEATURE_32 | PPC_FEATURE_HAS_FPU |
PPC_FEATURE_HAS_MMU | \
+			PPC_FEATURE_UISA | PPC_FEATURE_OEA | PPC_FEATURE_VEA
+
+struct cpu_spec	cpu_specs[] = {
+#if CLASSIC_PPC
+    { 	/* 601 */
+	0xffff0000, 0x00010000, "601",
+	CPU_FTR_601_BROKEN_SYNC,
+	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
+	32, 32,
+	__setup_cpu_601
+    },
+    {	/* 603 */
+    	0xffff0000, 0x00030000, "603",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
+	COMMON_PPC,
+    	32, 32,
+	__setup_cpu_603
+    },
+    {	/* 603e */
+    	0xffff0000, 0x00060000, "603e",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_603
+    },
+    {	/* 603ev */
+    	0xffff0000, 0x00070000, "603ev",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_603
+    },
+    {	/* 604 */
+    	0xffff0000, 0x00040000, "604",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_604
+    },
+    {	/* 604e */
+    	0xfffff000, 0x00090000, "604e",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_604
+    },
+    {	/* 604r */
+    	0xffff0000, 0x00090000, "604r",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_604
+    },
+    {	/* 604ev */
+    	0xffff0000, 0x000a0000, "604ev",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_604
+    },
+    {	/* 750 (0x4202, don't support TAU ?) */
+    	0xffffffff, 0x00084202, "750",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
CPU_FTR_L2CR,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750
+    },
+    {	/* 750CX */
+    	0xffffff00, 0x00082200, "750CX",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
CPU_FTR_L2CR |
+    	CPU_FTR_TAU | CPU_FTR_ONCHIP_L2,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750
+    },
+    {	/* 740/750 (L2CR bit need fixup for 740) */
+    	0xffff0000, 0x00080000, "740/750",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
CPU_FTR_L2CR |
+    	CPU_FTR_TAU,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_750
+    },
+    {	/* 7400 rev 1.1 ? (no TAU) */
+    	0xffffffff, 0x000c1101, "7400 (1.1)",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
CPU_FTR_L2CR |
+    	CPU_FTR_ALTIVEC,
+	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
+	32, 32,
+	__setup_cpu_7400
+    },
+    {	/* 7400 */
+    	0xffff0000, 0x000c0000, "7400",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
CPU_FTR_L2CR |
+    	CPU_FTR_TAU | CPU_FTR_ALTIVEC,
+	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
+	32, 32,
+	__setup_cpu_7400
+    },
+    {	/* 7410 */
+    	0xffff0000, 0x800c0000, "7410",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_CAN_DOZE | CPU_FTR_USE_TB |
CPU_FTR_L2CR |
+    	CPU_FTR_TAU | CPU_FTR_ALTIVEC,
+	COMMON_PPC | PPC_FEATURE_HAS_ALTIVEC,
+	32, 32,
+	__setup_cpu_7400
+    },
+    {	/* default match, we assume split I/D cache & TB (non-601)... */
+    	0x00000000, 0x00000000, "(generic PPC)",
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
+	COMMON_PPC,
+	32, 32,
+	__setup_cpu_generic
+    },
+#endif /* CLASSIC_PPC */
+#ifdef CONFIG_POWER3
+    {	/* Power3 */
+    	0xffff0000, 0x00400000, "Power3 (630)",
+    	0, /* FixMe */
+    	PPC_FEATURE_32 | PPC_FEATURE_64,
+	128, 128,
+	__setup_cpu_power3
+    },
+    {	/* Power3+ */
+    	0xffff0000, 0x00410000, "Power3 (630+)",
+    	0, /* FixMe */
+    	PPC_FEATURE_32 | PPC_FEATURE_64,
+	128, 128,
+	__setup_cpu_power3
+    },
+#endif /* CONFIG_POWER3 */
+#ifdef CONFIG_POWER4
+    {	/* Power4 */
+    	0xffff0000, 0x00500000, "Power4",
+    	0, /* FixMe */
+    	PPC_FEATURE_32 | PPC_FEATURE_64,
+	128, 128,
+	__setup_cpu_power4
+    },
+#endif /* CONFIG_POWER4 */
+#ifdef CONFIG_8260
+    {	/* 8260 */
+    	0xffff0000, 0x00810000, "8260",
+    	0, /* FixMe */
+    	PPC_FEATURE_32,
+	32,32, /* ??? */
+	0, /*__setup_cpu_8260 */
+    },
+#endif /* CONFIG_8260 */
+#ifdef CONFIG_8xx
+    {	/* 8xx */
+    	0xffff0000, 0x00500000, "8xx",
+    	0, /* FixMe */
+    	PPC_FEATURE_32,
+	16,16,
+	0, /*__setup_cpu_8xx */
+    },
+#endif /* CONFIG_8xx */
+#ifdef CONFIG_4xx
+    {	/* 403GC */
+    	0xffffff00, 0x00200200, "403GC",
+    	0, /* FixMe */
+    	PPC_FEATURE_32,
+	16,16,
+	0, /*__setup_cpu_403 */
+    },
+    {	/* 403GCX */
+    	0xffffff00, 0x00201400, "403GCX",
+    	0, /* FixMe */
+    	PPC_FEATURE_32,
+	16,16,
+	0, /*__setup_cpu_403 */
+    },
+    {	/* 403G ?? */
+    	0xffff0000, 0x00200000, "403G ??",
+    	0, /* FixMe */
+    	PPC_FEATURE_32,
+	16,16,
+	0, /*__setup_cpu_403 */
+    },
+    {	/* 405GP */
+    	0xffff0000, 0x40110000, "405GP",
+    	0, /* FixMe */
+    	PPC_FEATURE_32,
+	16,16,
+	0, /*__setup_cpu_405 */
+    },
+#endif /* CONFIG_4xx */
+#if !CLASSIC_PPC
+    {	/* default match */
+    	0x00000000, 0x00000000, "(generic PPC)",
+    	0,
+    	PPC_FEATURE_32,
+	32,32,
+	0,
+    }
+#endif /* !CLASSIC_PPC */
+};
diff -Nru a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
--- a/arch/ppc/kernel/entry.S	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/entry.S	Wed Apr 18 18:00:14 2001
@@ -24,12 +24,14 @@
  */

 #include "ppc_asm.h"
+#include <linux/config.h>
+#include <linux/errno.h>
+#include <linux/sys.h>
+#include <linux/threads.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
-#include <linux/errno.h>
-#include <linux/sys.h>
-#include <linux/config.h>
+#include <asm/cputable.h>

 #undef SHOW_SYSCALLS
 #undef SHOW_SYSCALLS_TASK
@@ -218,7 +220,9 @@
 	mfmsr	r22
 	li	r0,MSR_FP	/* Disable floating-point */
 #ifdef CONFIG_ALTIVEC
+	BEGIN_FTR_SECTION()
 	oris	r0,r0,MSR_VEC@h
+	END_FTR_SECTION(CPU_FTR_ALTIVEC,CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
 	andc	r22,r22,r0
 	stw	r20,_NIP(r1)
@@ -368,12 +372,10 @@
 	andi.	r0,r0,MSR_PR
 	beq+	1f
 #ifdef CONFIG_ALTIVEC
-	mfpvr	r8			/* check if we are on a G4 */
-	srwi	r8,r8,16
-	cmpwi	r8,PVR_7400@h
-	bne	2f
+	BEGIN_FTR_SECTION()
 	lwz	r0,THREAD+THREAD_VRSAVE(r2)
 	mtspr	SPRN_VRSAVE,r0		/* if so, restore VRSAVE reg */
+	END_FTR_SECTION(CPU_FTR_ALTIVEC,CPU_FTR_ALTIVEC)
 2:
 #endif /* CONFIG_ALTIVEC */
 	addi	r0,r1,INT_FRAME_SIZE	/* size of frame */
diff -Nru a/arch/ppc/kernel/hashtable.S b/arch/ppc/kernel/hashtable.S
--- a/arch/ppc/kernel/hashtable.S	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/hashtable.S	Wed Apr 18 18:00:14 2001
@@ -27,6 +27,7 @@
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <linux/config.h>
+#include <asm/cputable.h>

 /*
  * Load a PTE into the hash table, if possible.
diff -Nru a/arch/ppc/kernel/head.S b/arch/ppc/kernel/head.S
--- a/arch/ppc/kernel/head.S	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/head.S	Wed Apr 18 18:00:14 2001
@@ -30,7 +30,9 @@
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <linux/config.h>
+#include <linux/threads.h>
 #include <asm/mmu.h>
+#include <asm/cputable.h>

 #ifdef CONFIG_APUS
 #include <asm/amigappc.h>
@@ -147,8 +149,14 @@
 	mr	r4,r30
 	bl	fix_mem_constants
 #endif /* CONFIG_APUS */
+#ifdef CONFIG_GEMINI
+	li	r3,0
+#endif
+	bl	identify_cpu
+	bl	do_cpu_ftp_fixups

 #ifndef CONFIG_GEMINI
+
 /* Switch MMU off, clear BATs and flush TLB. At this point, r3 contains
  * the physical address we are running at, returned by prom_init()
  */
@@ -753,12 +761,10 @@
 	addi	r24,r1,STACK_FRAME_OVERHEAD
 	stw	r24,PT_REGS(r23)
 #ifdef CONFIG_ALTIVEC
-	mfpvr	r24			/* check if we are on a G4 */
-	srwi	r24,r24,16
-	cmpwi	r24,PVR_7400@h
-	bne	2f
+	BEGIN_FTR_SECTION()
 	mfspr	r22,SPRN_VRSAVE		/* if so, save vrsave register value */
 	stw	r22,THREAD_VRSAVE(r23)
+	END_FTR_SECTION(CPU_FTR_ALTIVEC,CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
 2:	addi	r2,r23,-THREAD		/* set r2 to current */
 	tovirt(r2,r2)
@@ -1274,10 +1280,24 @@
 	SYNC
 	MTMSRD(r0)
 	isync
-#else
-	bl	enable_caches
 #endif
+	li	r3, 0
+	bl	identify_cpu

+	/* Call setup_cpu for this CPU */
+	mr	r3,r24
+	lis	r5,cur_cpu_spec@ha
+	addi	r5,r5, cur_cpu_spec@l
+	tophys(r5,r5)
+	slwi	r4,r24,2
+	add	r5,r5,r4
+	lwz	r5,0(r5)
+	tophys(r5,r5)
+	lwz	r6,CPU_SPEC_SETUP_OFFSET(r5)
+	tophys(r6,r6)
+	mtctr	r6
+	bctrl
+
 	/* get current */
 	lis	r2,current_set@h
 	ori	r2,r2,current_set@l
@@ -1315,54 +1335,91 @@
 /*
  * Enable caches and 604-specific features if necessary.
  */
-enable_caches:
-	mfspr	r9,PVR
-	rlwinm	r9,r9,16,16,31
-	cmpi	0,r9,1
-	beq	6f			/* not needed for 601 */
+_GLOBAL(__setup_cpu_601)
+	blr
+_GLOBAL(__setup_cpu_603)
+	mflr	r4
+	bl	setup_common_caches
+	mtlr	r4
+	blr
+_GLOBAL(__setup_cpu_604)
+	mflr	r4
+	bl	setup_common_caches
+	bl	setup_604_hid0
+	mtlr	r4
+	blr
+_GLOBAL(__setup_cpu_750)
+	mflr	r4
+	bl	setup_common_caches
+	bl	setup_750_7400_hid0
+	mtlr	r4
+	blr
+_GLOBAL(__setup_cpu_7400)
+	mflr	r4
+	bl	setup_common_caches
+	bl	setup_750_7400_hid0
+	mtlr	r4
+	blr
+_GLOBAL(__setup_cpu_7450)
+	blr
+_GLOBAL(__setup_cpu_power3)
+	blr
+_GLOBAL(__setup_cpu_power4)
+	blr
+_GLOBAL(__setup_cpu_generic)
+	blr
+
+/* Enable caches for 603's, 604, 750 & 7400 */
+setup_common_caches:
 	mfspr	r11,HID0
 	andi.	r0,r11,HID0_DCE
 	ori	r11,r11,HID0_ICE|HID0_DCE
 	ori	r8,r11,HID0_ICFI
-	bne	3f			/* don't invalidate the D-cache */
+	bne	1f			/* don't invalidate the D-cache */
 	ori	r8,r8,HID0_DCI		/* unless it wasn't enabled */
-3:
+1:
 	sync
 	mtspr	HID0,r8			/* enable and invalidate caches */
 	sync
 	mtspr	HID0,r11		/* enable caches */
 	sync
 	isync
-	cmpi	0,r9,4			/* check for 604 */
-	cmpi	1,r9,9			/* or 604e */
-	cmpi	2,r9,10			/* or mach5 / 604r */
-	cmpi	3,r9,8			/* check for 750 (G3) */
-	cmpi	4,r9,12			/* or 7400 (G4) */
-	cror	2,2,6
-	cror	2,2,10
-	bne	4f
-	ori	r11,r11,HID0_SIED|HID0_BHTE /* for 604[e|r], enable */
-	bne	2,5f
-	ori	r11,r11,HID0_BTCD	/* superscalar exec & br history tbl */
-	b	5f
-4:
-	cror	14,14,18
-	bne	3,6f
-	/* for G3/G4:
-	 * enable Store Gathering (SGE), Address Brodcast (ABE),
-	 * Branch History Table (BHTE), Branch Target ICache (BTIC)
-	 */
+	blr
+
+/* 604, 604e, 604ev, ...
+ * Enable superscalar exec & branch history
+ */
+setup_604_hid0:
+	mfspr	r11,HID0
+	ori	r11,r11,HID0_SIED|HID0_BHTE
+	bne	2,1f
+	ori	r11,r11,HID0_BTCD
+	isync
+	mtspr	HID0,r11
+	sync
+	isync
+1:
+	blr
+
+/* 740/750/7400/7410
+ * Enable Store Gathering (SGE), Address Brodcast (ABE),
+ * Branch History Table (BHTE), Branch Target ICache (BTIC)
+ * Dynamic Power Management (DPM), Speculative (SPD)
+ * Clear Instruction cache throttling (ICTC)
+ */
+setup_750_7400_hid0:
+	mfspr	r11,HID0
 	ori	r11,r11,HID0_SGE | HID0_ABE | HID0_BHTE | HID0_BTIC
 	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
 	li	r3,HID0_SPD
 	andc	r11,r11,r3		/* clear SPD: enable speculative */
  	li	r3,0
  	mtspr	ICTC,r3			/* Instruction Cache Throttling off */
-5:	isync
+	isync
 	mtspr	HID0,r11
 	sync
 	isync
-6:	blr
+	blr

 /*
  * Load stuff into the MMU.  Intended to be called with
@@ -1407,9 +1464,14 @@
  * This is where the main kernel code starts.
  */
 start_here:
-#ifndef CONFIG_PPC64BRIDGE
-	bl	enable_caches
-#endif
+	/* Call setup_cpu for CPU 0 */
+	li	r3,0 /* cpu# */
+	lis	r5,cur_cpu_spec@ha
+	addi	r5,r5,cur_cpu_spec@l
+	lwz	r5,0(r5)
+	lwz	r5,CPU_SPEC_SETUP_OFFSET(r5)
+	mtctr	r5
+	bctrl

 	/* ptr to current */
 	lis	r2,init_task_union@h
@@ -1563,6 +1625,88 @@
 	RFI
 #endif

+	/* identify_cpu, called with r3 = phys offset
+	 * and r24 = CPU number
+	 */
+identify_cpu:
+	lis	r8,cpu_specs@ha
+	addi	r8,r8,cpu_specs@l
+	addis	r8,r8,-KERNELBASE@h /* Fix APUS ! */
+	add	r8,r8,r3
+	mfpvr	r7
+1:
+	lwz	r5,CPU_SPEC_PVR_MASK_OFFSET(r8)
+	and	r5,r5,r7
+	lwz	r6,CPU_SPEC_PVR_VALUE_OFFSET(r8)
+	cmplw	0,r6,r5
+	beq	1f
+	addi	r8,r8,CPU_SPEC_ENTRY_SIZE
+	b	1b
+1:
+	lis	r6,cur_cpu_spec@ha
+	addi	r6,r6,cur_cpu_spec@l
+	addis	r6,r6,-KERNELBASE@h /* Fix APUS ! */
+	add	r6,r6,r3
+	slwi	r4,r24,2
+	add	r6,r6,r4
+	addis	r8,r8,KERNELBASE@h /* Fix APUS ! */
+	sub	r8,r8,r3
+	stw	r8,0(r6)
+	blr
+
+do_cpu_ftp_fixups:
+	/* We are running at r3, pre-calc r3-KERNELBASE */
+	mr	r5,r3
+	addis	r5,r5,-KERNELBASE@h
+
+	/* Get CPU 0 features */
+	lis	r6,cur_cpu_spec@ha
+	addi	r6,r6,cur_cpu_spec@l
+	add	r6,r6,r5
+	lwz	r4,0(r6)
+	add	r4,r4,r5
+	lwz	r4,CPU_SPEC_FEATURES_OFFSET(r4)
+
+	/* Get the fixup table */
+	lis	r6,__start___ftr_fixup@ha
+	addi	r6,r6,__start___ftr_fixup@l
+	add	r6,r6,r5
+	lis	r7,__stop___ftr_fixup@ha
+	addi	r7,r7,__stop___ftr_fixup@l
+	add	r7,r7,r5
+
+	/* Do the fixup */
+1:	cmplw	0,r6,r7
+	bge	5f
+	lwz	r8,0(r6)	/* mask */
+	and	r8,r8,r4
+	lwz	r9,4(r6)	/* value */
+	cmplw	0,r8,r9
+	beq	4f
+	lwz	r8,8(r6)	/* section begin */
+	lwz	r9,12(r6)	/* section end */
+	subf.	r9,r8,r9
+	beq	4f
+	srwi	r9,r9,2
+	/* todo: if large section, add a branch at the start of it */
+	mtctr	r9
+	add	r8,r8,r5
+	lis	r0,0x60000000@h	/* nop */
+3:	stw	r0,0(r8)
+	andi.	r10,r4,CPU_FTR_SPLIT_ID_CACHE@l
+	beq	2f
+	dcbst	0,r8		/* suboptimal, but simpler */
+	sync
+	icbi	0,r8
+2:
+	addi	r8,r8,4
+	bdnz	3b
+	sync				/* additional sync needed on g4 */
+	isync
+4:	addi	r6,r6,16
+	b	1b
+5:	blr
+
 #ifndef CONFIG_POWER4
 /*
  * Use the first pair of BAT registers to map the 1st 16MB
diff -Nru a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
--- a/arch/ppc/kernel/idle.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/idle.c	Wed Apr 18 18:00:14 2001
@@ -30,6 +30,7 @@
 #include <asm/processor.h>
 #include <asm/mmu.h>
 #include <asm/cache.h>
+#include <asm/cputable.h>

 void zero_paged(void);
 void power_save(void);
@@ -49,15 +50,8 @@
 {
 	int do_power_save = 0;

-	/* only sleep on the 603-family/750 processors */
-	switch (_get_PVR() >> 16) {
-	case 3:			/* 603 */
-	case 6:			/* 603e */
-	case 7:			/* 603ev */
-	case 8:			/* 750 */
-	case 12:		/* 7400 */
+	if (cur_cpu_spec[smp_processor_id()]->cpu_features & CPU_FTR_CAN_DOZE)
 		do_power_save = 1;
-	}

 	/* endless loop with no priority at all */
 	current->nice = 20;
diff -Nru a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
--- a/arch/ppc/kernel/misc.S	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/misc.S	Wed Apr 18 18:00:14 2001
@@ -14,11 +14,13 @@

 #include <linux/config.h>
 #include <linux/sys.h>
+#include <linux/threads.h>
 #include <asm/unistd.h>
 #include <asm/errno.h>
 #include <asm/processor.h>
 #include <asm/page.h>
 #include <asm/cache.h>
+#include <asm/cputable.h>
 #include "ppc_asm.h"

 	.text
@@ -896,14 +898,10 @@
  *   -- paulus.
  */
 _GLOBAL(_set_L2CR)
-	/* Make sure this is a 750 or 7400 chip */
-	mfspr	r4,PVR
-	rlwinm	r4,r4,16,16,31
-	cmpwi	r4,0x0008
-	cmpwi	cr1,r4,0x000c
-	cror	2,2,4*cr1+2
-	bne	99f
-
+	BEGIN_FTR_SECTION()
+	li	r3,-1
+	blr
+	END_FTR_SECTION(CPU_FTR_L2CR,0)
 	/* Turn off interrupts and data relocation. */
 	mfmsr	r7		/* Save MSR in r7 */
 	rlwinm	r4,r7,0,17,15
@@ -1007,20 +1005,12 @@
 	isync
 	blr

-99:	li	r3,-1
-	blr
-
 _GLOBAL(_get_L2CR)
-	/* Make sure this is a 750 chip */
-	mfspr	r3,PVR
-	srwi	r3,r3,16
-	cmpwi	r3,0x0008
-	cmpwi	cr1,r3,0x000c
-	li	r3,0
-	cror	2,2,4*cr1+2
-	bnelr
 	/* Return the L2CR contents */
+	li	r3, 0
+	BEGIN_FTR_SECTION()
 	mfspr	r3,L2CR
+	END_FTR_SECTION(CPU_FTR_L2CR,CPU_FTR_L2CR)
 	blr

 /* --- End of PowerLogix code ---
diff -Nru a/arch/ppc/kernel/mk_defs.c b/arch/ppc/kernel/mk_defs.c
--- a/arch/ppc/kernel/mk_defs.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/mk_defs.c	Wed Apr 18 18:00:14 2001
@@ -23,6 +23,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
+#include <asm/cputable.h>

 #define DEFINE(sym, val) \
 	asm volatile("\n#define\t" #sym "\t%0" : : "i" (val))
@@ -114,5 +115,11 @@
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
 	DEFINE(CLONE_VM, CLONE_VM);
+	/* About the CPU features table */
+	DEFINE(CPU_SPEC_ENTRY_SIZE, sizeof(struct cpu_spec));
+	DEFINE(CPU_SPEC_PVR_MASK_OFFSET, offsetof(struct cpu_spec, pvr_mask));
+	DEFINE(CPU_SPEC_PVR_VALUE_OFFSET, offsetof(struct cpu_spec, pvr_value));
+	DEFINE(CPU_SPEC_FEATURES_OFFSET, offsetof(struct cpu_spec, cpu_features));
+	DEFINE(CPU_SPEC_SETUP_OFFSET, offsetof(struct cpu_spec, cpu_setup));
 	return 0;
 }
diff -Nru a/arch/ppc/kernel/pmac_setup.c b/arch/ppc/kernel/pmac_setup.c
--- a/arch/ppc/kernel/pmac_setup.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/pmac_setup.c	Wed Apr 18 18:00:14 2001
@@ -62,6 +62,7 @@
 #include <asm/keyboard.h>
 #include <asm/dma.h>
 #include <asm/bootx.h>
+#include <asm/cputable.h>

 #include <asm/time.h>
 #include "local_irq.h"
@@ -134,7 +135,7 @@
 {
 	int cpu = smp_processor_id();

-	if ( (_get_PVR() >> 16) != 8 && (_get_PVR() >> 16) != 12 )
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR))
 		return;

 	if (cpu == 0){
@@ -275,20 +276,22 @@
 {
 	struct device_node *cpu;
 	int *fp;
-
+	unsigned long pvr = (_get_PVR() >> 16) & 0xffff;
+
 	/* Set loops_per_jiffy to a half-way reasonable value,
 	   for use until calibrate_delay gets called. */
 	cpu = find_type_devices("cpu");
 	if (cpu != 0) {
 		fp = (int *) get_property(cpu, "clock-frequency", NULL);
 		if (fp != 0) {
-			switch (_get_PVR() >> 16) {
+			switch (pvr) {
 			case 4:		/* 604 */
 			case 8:		/* G3 */
 			case 9:		/* 604e */
 			case 10:	/* mach V (604ev5) */
 			case 12:	/* G4 */
 			case 20:	/* 620 */
+			case 0x800c:	/* 7410 */
 				loops_per_jiffy = *fp / HZ;
 				break;
 			default:	/* 601, 603, etc. */
@@ -308,7 +311,7 @@
 	pmac_find_bridges();

 	/* Checks "l2cr-value" property in the registry */
-	if ( (_get_PVR() >> 16) == 8 || (_get_PVR() >> 16) == 12 ) {
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
 		struct device_node *np = find_devices("cpus");
 		if (np == 0)
 			np = find_type_devices("cpu");
diff -Nru a/arch/ppc/kernel/ppc_asm.h b/arch/ppc/kernel/ppc_asm.h
--- a/arch/ppc/kernel/ppc_asm.h	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/ppc_asm.h	Wed Apr 18 18:00:14 2001
@@ -67,9 +67,10 @@
 #define REST_32VR(n,b,base)	REST_16VR(n,b,base); REST_16VR(n+16,b,base)

 #ifdef CONFIG_PPC601_SYNC_FIX
-#define SYNC \
+#define SYNC BEGIN_FTR_SECTION()  \
 	sync; \
-	isync
+	isync; \
+	END_FTR_SECTION(CPU_FTR_601_BROKEN_SYNC,CPU_FTR_601_BROKEN_SYNC)
 #else
 #define	SYNC
 #endif
diff -Nru a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
--- a/arch/ppc/kernel/ppc_htab.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/ppc_htab.c	Wed Apr 18 18:00:14 2001
@@ -19,6 +19,7 @@
 #include <linux/stat.h>
 #include <linux/sysctl.h>
 #include <linux/ctype.h>
+#include <linux/threads.h>

 #include <asm/uaccess.h>
 #include <asm/bitops.h>
@@ -27,6 +28,7 @@
 #include <asm/residual.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
+#include <asm/cputable.h>

 static ssize_t ppc_htab_read(struct file * file, char * buf,
 			     size_t count, loff_t *ppos);
@@ -117,11 +119,7 @@
 	if (count < 0)
 		return -EINVAL;

-	switch ( _get_PVR()>>16 )
-	{
-	case 4:  /* 604 */
-	case 9:  /* 604e */
-	case 10: /* 604ev5 */
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 		asm volatile ("mfspr %0,952 \n\t"
 		    "mfspr %1,953 \n\t"
 		    "mfspr %2,954 \n\t"
@@ -137,9 +135,6 @@
 			      "PMC2\t\t: %08lx (%s)\n",
 			      pmc1, pmc1_lookup(mmcr0),
 			      pmc2, pmc2_lookup(mmcr0));
-		break;
-	default:
-		break;
 	}


@@ -246,37 +241,23 @@
 	/* turn off performance monitoring */
 	if ( !strncmp( buffer, "off", 3) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			asm volatile ("mtspr %0, %3 \n\t"
 			    "mtspr %1, %3 \n\t"
 			    "mtspr %2, %3 \n\t"
 			    :: "i" (MMCR0), "i" (PMC1), "i" (PMC2), "r" (0));
-			break;
-		default:
-			break;
 		}

 	}

 	if ( !strncmp( buffer, "reset", 5) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* reset PMC1 and PMC2 */
 			asm volatile (
 				"mtspr 953, %0 \n\t"
 				"mtspr 954, %0 \n\t"
 				:: "r" (0));
-			break;
-		default:
-			break;
 		}
 		htab_reloads = 0;
 		htab_evicts = 0;
@@ -286,11 +267,7 @@

 	if ( !strncmp( buffer, "user", 4) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 			asm("mfspr %0,%1\n\t"  : "=r" (tmp) : "i" (MMCR0));
 			tmp &= ~(0x60000000);
@@ -301,19 +278,12 @@
 				"mtspr %5,%4 \n\t"    /* reset the pmc2 */
 				:: "r" (tmp), "i" (MMCR0), "i" (0),
 				"i" (PMC1),  "r" (0), "i"(PMC2) );
-			break;
-		default:
-			break;
 		}
 	}

 	if ( !strncmp( buffer, "kernel", 6) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 			asm("mfspr %0,%1\n\t"  : "=r" (tmp) : "i" (MMCR0));
 			tmp &= ~(0x60000000);
@@ -324,20 +294,13 @@
 				"mtspr %5,%4 \n\t"    /* reset the pmc2 */
 				:: "r" (tmp), "i" (MMCR0), "i" (0),
 				"i" (PMC1),  "r" (0), "i"(PMC2) );
-			break;
-		default:
-			break;
 		}
 	}

 	/* PMC1 values */
 	if ( !strncmp( buffer, "dtlb", 4) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 			asm("mfspr %0,%1\n\t"  : "=r" (tmp) : "i" (MMCR0));
 			tmp &= ~(0x7f<<7);
@@ -352,11 +315,7 @@

 	if ( !strncmp( buffer, "ic miss", 7) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 			asm("mfspr %0,%1\n\t"  : "=r" (tmp) : "i" (MMCR0));
 			tmp &= ~(0x7f<<7);
@@ -372,11 +331,7 @@
 	/* PMC2 values */
 	if ( !strncmp( buffer, "load miss time", 14) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 		       asm volatile(
 			       "mfspr %0,%1\n\t"     /* get current mccr0 */
@@ -392,11 +347,7 @@

 	if ( !strncmp( buffer, "itlb", 4) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 		       asm volatile(
 			       "mfspr %0,%1\n\t"     /* get current mccr0 */
@@ -412,11 +363,7 @@

 	if ( !strncmp( buffer, "dc miss", 7) )
 	{
-		switch ( _get_PVR()>>16 )
-		{
-		case 4:  /* 604 */
-		case 9:  /* 604e */
-		case 10: /* 604ev5 */
+		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
 			/* setup mmcr0 and clear the correct pmc */
 		       asm volatile(
 			       "mfspr %0,%1\n\t"     /* get current mccr0 */
@@ -516,9 +463,9 @@
 		"0.5", "1.0", "(reserved2)", "(reserved3)"
 	};

-	if ( ((_get_PVR() >> 16) != 8) && ((_get_PVR() >> 16) != 12))
+	if (!(cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR))
 		return -EFAULT;
-
+
 	if ( /*!table->maxlen ||*/ (filp->f_pos && !write)) {
 		*lenp = 0;
 		return 0;
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/ppc_ksyms.c	Wed Apr 18 18:00:14 2001
@@ -45,6 +45,7 @@
 #include <asm/smp.h>
 #endif /* CONFIG_SMP */
 #include <asm/time.h>
+#include <asm/cputable.h>

 #ifdef  CONFIG_8xx
 #include "../8xx_io/commproc.h"
@@ -372,3 +373,5 @@
 #endif
 extern long *ret_from_intercept;
 EXPORT_SYMBOL(ret_from_intercept);
+EXPORT_SYMBOL(cur_cpu_spec);
+
diff -Nru a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
--- a/arch/ppc/kernel/setup.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/kernel/setup.c	Wed Apr 18 18:00:14 2001
@@ -26,6 +26,7 @@
 #include <asm/amigappc.h>
 #include <asm/smp.h>
 #include <asm/elf.h>
+#include <asm/cputable.h>
 #ifdef CONFIG_8xx
 #include <asm/mpc8xx.h>
 #include <asm/8xx_immap.h>
@@ -239,89 +240,20 @@

 		pvr = GET_PVR;

-		switch (PVR_VER(pvr))
-		{
-		case 0x0001:
-			len += sprintf(len+buffer, "601\n");
-			break;
-		case 0x0003:
-			len += sprintf(len+buffer, "603\n");
-			break;
-		case 0x0004:
-			len += sprintf(len+buffer, "604\n");
-			break;
-		case 0x0006:
-			len += sprintf(len+buffer, "603e\n");
-			break;
-		case 0x0007:
-			len += sprintf(len+buffer, "603");
-			if (((pvr >> 12) & 0xF) == 1) {
-				pvr ^= 0x00001000;	/* revision fix-up */
-				len += sprintf(len+buffer, "r\n");
-			} else {
-				len += sprintf(len+buffer, "ev\n");
-			}
-			break;
-		case 0x0008:		/* 740/750(P) */
-		case 0x1008:
-			len += sprintf(len+buffer, "750%s\n",
-				       PVR_VER(pvr) == 0x1008 ? "P" : "");
+		if (cur_cpu_spec[i]->pvr_mask)
+			len += sprintf(len+buffer, "%s", cur_cpu_spec[i]->cpu_name);
+		else
+			len += sprintf(len+buffer, "unknown (%08x)", pvr);
+#ifdef CONFIG_ALTIVEC
+		if (cur_cpu_spec[i]->cpu_features & CPU_FTR_ALTIVEC) {
+			len += sprintf(len+buffer, ", altivec supported\n");
+		} else
+#endif
+			len += sprintf(len+buffer, "\n");
+		if (cur_cpu_spec[i]->cpu_features & CPU_FTR_TAU) {
 			len += sprintf(len+buffer, "temperature \t: %lu C\n",
 				       cpu_temp());
-			break;
-		case 0x0009:		/* 604e/604r */
-		case 0x000A:
-			len += sprintf(len+buffer, "604");
-
-			if (PVR_VER(pvr) == 0x000A ||
-			    ((pvr >> 12) & 0xF) != 0) {
-				pvr &= ~0x00003000;	/* revision fix-up */
-				len += sprintf(len+buffer, "r\n");
-			} else {
-				len += sprintf(len+buffer, "e\n");
-			}
-			break;
-		case 0x000C:
-			len += sprintf(len+buffer, "7400 (G4");
-#ifdef CONFIG_ALTIVEC
-			len += sprintf(len+buffer, ", altivec supported");
-#endif /* CONFIG_ALTIVEC */
-			len += sprintf(len+buffer, ")\n");
-			break;
-		case 0x0020:
-			len += sprintf(len+buffer, "403G");
-			switch ((pvr >> 8) & 0xFF) {
-			case 0x02:
-				len += sprintf(len+buffer, "C\n");
-				break;
-			case 0x14:
-				len += sprintf(len+buffer, "CX\n");
-				break;
-			}
-			break;
-		case 0x0035:
-			len += sprintf(len+buffer, "POWER4\n");
-			break;
-		case 0x0040:
-			len += sprintf(len+buffer, "POWER3 (630)\n");
-			break;
-		case 0x0041:
-			len += sprintf(len+buffer, "POWER3 (630+)\n");
-			break;
-		case 0x0050:
-			len += sprintf(len+buffer, "8xx\n");
-			break;
-		case 0x0081:
-			len += sprintf(len+buffer, "82xx\n");
-			break;
-		case 0x4011:
-			len += sprintf(len+buffer, "405GP\n");
-			break;
-		default:
-			len += sprintf(len+buffer, "unknown (%08x)\n", pvr);
-			break;
 		}
-
 		/*
 		 * Assume here that all clock rates are the same in a
 		 * smp system.  -- Cort
@@ -562,6 +494,7 @@
 		extern int __map_without_bats;
 		__map_without_bats = 1;
 	}
+
 #else
 #if defined(CONFIG_4xx)
 	oak_init(r3, r4, r5, r6, r7);
@@ -658,8 +591,7 @@
 /* Checks "l2cr=xxxx" command-line option */
 int ppc_setup_l2cr(char *str)
 {
-	if ( ((_get_PVR() >> 16) == 8) || ((_get_PVR() >> 16) == 12) )
-	{
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_L2CR) {
 		unsigned long val = simple_strtoul(str, NULL, 0);
 		printk(KERN_INFO "l2cr set to %lx\n", val);
                 _set_L2CR(0);           /* force invalidate by disable
cache */
@@ -711,18 +643,12 @@
 	 * Systems with OF can look in the properties on the cpu node(s)
 	 * for a possibly more accurate value.
 	 */
-	dcache_bsize = icache_bsize = 32;	/* most common value */
-	switch (_get_PVR() >> 16) {
-	case 1:		/* 601, with unified cache */
-		ucache_bsize = 32;
-		break;
-	/* XXX need definitions in here for 8xx etc. */
-	case 0x40:
-	case 0x41:
-	case 0x35:	/* 64-bit POWER3, POWER3+, POWER4 */
-		dcache_bsize = icache_bsize = 128;
-		break;
-	}
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_SPLIT_ID_CACHE) {
+		dcache_bsize = cur_cpu_spec[0]->dcache_bsize;
+		icache_bsize = cur_cpu_spec[0]->icache_bsize;
+		ucache_bsize = 0;
+	} else
+		ucache_bsize = dcache_bsize = icache_bsize = cur_cpu_spec[0]->dcache_bsize;

 	/* reboot on panic */
 	panic_timeout = 180;
diff -Nru a/arch/ppc/mbxboot/misc.c b/arch/ppc/mbxboot/misc.c
--- a/arch/ppc/mbxboot/misc.c	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/mbxboot/misc.c	Wed Apr 18 18:00:14 2001
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include "../coffboot/zlib.h"
 #include "asm/residual.h"
+#include <linux/threads.h>
 #include <linux/elf.h>
 #include <linux/config.h>
 #include <asm/page.h>
diff -Nru a/arch/ppc/vmlinux.lds b/arch/ppc/vmlinux.lds
--- a/arch/ppc/vmlinux.lds	Wed Apr 18 18:00:14 2001
+++ b/arch/ppc/vmlinux.lds	Wed Apr 18 18:00:14 2001
@@ -65,6 +65,10 @@
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;

+  __start___ftr_fixup = .;
+  __ftr_fixup : { *(__ftr_fixup) }
+  __stop___ftr_fixup = .;
+
   __start___ksymtab = .;	/* Kernel symbol table */
   __ksymtab : { *(__ksymtab) }
   __stop___ksymtab = .;
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/include/asm-ppc/cputable.h	Wed Apr 18 18:00:14 2001
@@ -0,0 +1,74 @@
+#ifndef __ASM_PPC_CPUTABLE_H
+#define __ASM_PPC_CPUTABLE_H
+
+/* Exposed to userland CPU features */
+#define PPC_FEATURE_32			0x80000000
+#define PPC_FEATURE_64			0x40000000
+#define PPC_FEATURE_UISA		0x20000000
+#define PPC_FEATURE_OEA			0x10000000
+#define PPC_FEATURE_VEA			0x08000000
+#define PPC_FEATURE_601_INSTR		0x04000000
+#define PPC_FEATURE_IBM_EE		0x02000000
+#define PPC_FEATURE_HAS_ALTIVEC		0x00080000
+#define PPC_FEATURE_HAS_FPU		0x00040000
+#define PPC_FEATURE_HAS_MMU		0x00020000
+#define PPC_FEATURE_HAS_4xxMAC		0x00010000
+#define PPC_FEATURE_UNIFIED_CACHE	0x00008000
+
+#ifdef __KERNEL__
+
+#ifndef __ASSEMBLY__
+
+/* This structure can grow, it's real size is used by head.S code
+ * via the mkdefs mecanism.
+ */
+struct cpu_spec {
+	/* CPU is matched via (PVR & pvr_mask) == pvr_value */
+	unsigned int	pvr_mask;
+	unsigned int	pvr_value;
+
+	char*		cpu_name;
+	unsigned int	cpu_features;		/* Kernel features */
+	unsigned int	cpu_user_features;	/* Userland features */
+
+	/* cache line sizes */
+	unsigned int	icache_bsize;
+	unsigned int	dcache_bsize;
+
+	/* this is called to initialize various CPU bits like L1 cache,
+	 * BHT, SPD, etc... from head.S before branching to identify_machine
+	 */
+	void		(*cpu_setup)(int cpu_nr);
+};
+
+extern struct cpu_spec		cpu_specs[];
+extern struct cpu_spec		*cur_cpu_spec[NR_CPUS];
+
+#endif /* __ASSEMBLY__ */
+
+/* CPU kernel features */
+#define CPU_FTR_SPLIT_ID_CACHE		0x00000001
+#define CPU_FTR_L2CR			0x00000002
+#define CPU_FTR_ONCHIP_L2		0x00000004
+#define CPU_FTR_ALTIVEC			0x00000008
+#define CPU_FTR_TAU			0x00000010
+#define CPU_FTR_CAN_DOZE		0x00000020
+#define CPU_FTR_USE_TB			0x00000040
+#define CPU_FTR_604_PERF_MON		0x00000080
+#define CPU_FTR_601_BROKEN_SYNC		0x00000100
+
+#ifdef __ASSEMBLY__
+
+#define BEGIN_FTR_SECTION()		98:
+#define END_FTR_SECTION(msk,val)	99: \
+					.section __ftr_fixup,"a"; \
+					.align 2; \
+					.long msk; \
+					.long val; \
+					.long 98b; \
+					.long 99b; \
+					.previous;
+#endif /* __ASSEMBLY__ */
+
+#endif /* __ASM_PPC_CPUTABLE_H */
+#endif /* __KERNEL__ */
\ No newline at end of file
diff -Nru a/include/asm-ppc/elf.h b/include/asm-ppc/elf.h
--- a/include/asm-ppc/elf.h	Wed Apr 18 18:00:14 2001
+++ b/include/asm-ppc/elf.h	Wed Apr 18 18:00:14 2001
@@ -5,6 +5,7 @@
  * ELF register definitions..
  */
 #include <asm/ptrace.h>
+#include <asm/cputable.h>

 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
 #define ELF_NFPREG	33	/* includes fpscr */
@@ -57,7 +58,7 @@
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */

-#define ELF_HWCAP	(0)
+#define ELF_HWCAP	(cur_cpu_spec[0]->cpu_user_features)

 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
