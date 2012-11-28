Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 699562C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2012 10:57:56 +1100 (EST)
Date: Thu, 29 Nov 2012 10:55:25 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 1/2] powerpc: remove section changes from _GLOBAL() and friends
Message-Id: <20121129105525.0e47b3b3e51aebe7ded3b7b6@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__29_Nov_2012_10_55_25_+1100_L9aWCG5d7NZ2VdDE"
Cc: Alan Modra <amodra@au1.ibm.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__29_Nov_2012_10_55_25_+1100_L9aWCG5d7NZ2VdDE
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

These sometimes produce unexpected results and make it hard to put the
start up code (for 64 bit) into the .head.text section.

This also adds some explicit .texts at the start of asm files that did
not have them.

Suggested by Alan Modra.

Cc: Alan Modra <amodra@au1.ibm.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/include/asm/ppc_asm.h             |    7 -------
 arch/powerpc/kernel/cpu_setup_44x.S            |    1 +
 arch/powerpc/kernel/cpu_setup_6xx.S            |    1 +
 arch/powerpc/kernel/cpu_setup_a2.S             |    1 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S      |    1 +
 arch/powerpc/kernel/cpu_setup_pa6t.S           |    1 +
 arch/powerpc/kernel/cpu_setup_power.S          |    1 +
 arch/powerpc/kernel/cpu_setup_ppc970.S         |    1 +
 arch/powerpc/kernel/entry_32.S                 |    2 ++
 arch/powerpc/kernel/fpu.S                      |    1 +
 arch/powerpc/kernel/head_64.S                  |    7 +++++++
 arch/powerpc/kernel/head_fsl_booke.S           |    2 ++
 arch/powerpc/kernel/idle_6xx.S                 |    5 +++++
 arch/powerpc/kernel/idle_book3e.S              |    2 ++
 arch/powerpc/kernel/l2cr_6xx.S                 |    1 +
 arch/powerpc/kernel/misc_32.S                  |    4 ++++
 arch/powerpc/kernel/misc_64.S                  |    1 +
 arch/powerpc/kernel/ppc_save_regs.S            |    2 ++
 arch/powerpc/kernel/reloc_32.S                 |    2 ++
 arch/powerpc/kernel/reloc_64.S                 |    2 ++
 arch/powerpc/kernel/swsusp_32.S                |    5 +++++
 arch/powerpc/kernel/swsusp_booke.S             |    5 +++++
 arch/powerpc/kernel/systbl.S                   |    2 ++
 arch/powerpc/kernel/vector.S                   |    2 ++
 arch/powerpc/kvm/book3s_hv_interrupts.S        |    2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S        |    2 ++
 arch/powerpc/kvm/book3s_interrupts.S           |    2 ++
 arch/powerpc/kvm/book3s_rmhandlers.S           |    2 ++
 arch/powerpc/kvm/booke_interrupts.S            |    2 ++
 arch/powerpc/kvm/bookehv_interrupts.S          |    2 ++
 arch/powerpc/kvm/fpu.S                         |    2 ++
 arch/powerpc/lib/checksum_64.S                 |    2 ++
 arch/powerpc/lib/copypage_power7.S             |    2 ++
 arch/powerpc/lib/copyuser_64.S                 |    1 +
 arch/powerpc/lib/copyuser_power7.S             |    2 ++
 arch/powerpc/lib/div64.S                       |    2 ++
 arch/powerpc/lib/hweight_64.S                  |    2 ++
 arch/powerpc/lib/ldstfp.S                      |    2 ++
 arch/powerpc/lib/mem_64.S                      |    2 ++
 arch/powerpc/lib/memcpy_64.S                   |    1 +
 arch/powerpc/lib/memcpy_power7.S               |    2 ++
 arch/powerpc/mm/slb_low.S                      |    2 ++
 arch/powerpc/mm/tlb_nohash_low.S               |    2 ++
 arch/powerpc/platforms/pasemi/powersave.S      |    2 ++
 arch/powerpc/platforms/powermac/cache.S        |    2 ++
 arch/powerpc/platforms/powernv/opal-wrappers.S |    2 ++
 arch/powerpc/sysdev/6xx-suspend.S              |    2 ++
 arch/powerpc/sysdev/dcr-low.S                  |    2 ++
 48 files changed, 98 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/ppc_asm.h b/arch/powerpc/include/asm/=
ppc_asm.h
index ea2a86e..5c9af12 100644
--- a/arch/powerpc/include/asm/ppc_asm.h
+++ b/arch/powerpc/include/asm/ppc_asm.h
@@ -200,7 +200,6 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #define GLUE(a,b) XGLUE(a,b)
=20
 #define _GLOBAL(name) \
-	.section ".text"; \
 	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
@@ -214,7 +213,6 @@ name: \
 GLUE(.,name):
=20
 #define _INIT_GLOBAL(name) \
-	__REF; \
 	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
@@ -228,7 +226,6 @@ name: \
 GLUE(.,name):
=20
 #define _KPROBE(name) \
-	.section ".kprobes.text","a"; \
 	.align 2 ; \
 	.globl name; \
 	.globl GLUE(.,name); \
@@ -242,7 +239,6 @@ name: \
 GLUE(.,name):
=20
 #define _STATIC(name) \
-	.section ".text"; \
 	.align 2 ; \
 	.section ".opd","aw"; \
 name: \
@@ -254,7 +250,6 @@ name: \
 GLUE(.,name):
=20
 #define _INIT_STATIC(name) \
-	__REF; \
 	.align 2 ; \
 	.section ".opd","aw"; \
 name: \
@@ -272,13 +267,11 @@ GLUE(.,name):
 n:
=20
 #define _GLOBAL(n)	\
-	.text;		\
 	.stabs __stringify(n:F-1),N_FUN,0,0,n;\
 	.globl n;	\
 n:
=20
 #define _KPROBE(n)	\
-	.section ".kprobes.text","a";	\
 	.globl	n;	\
 n:
=20
diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_=
setup_44x.S
index e32b4a9..3cac909 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -17,6 +17,7 @@
 #include <asm/cputable.h>
 #include <asm/ppc_asm.h>
=20
+	.text
 _GLOBAL(__setup_cpu_440ep)
 	b	__init_fpu_44x
 _GLOBAL(__setup_cpu_440epx)
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_=
setup_6xx.S
index f8cd9fb..4b65da9 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -17,6 +17,7 @@
 #include <asm/cache.h>
 #include <asm/mmu.h>
=20
+	.text
 _GLOBAL(__setup_cpu_603)
 	mflr	r5
 BEGIN_MMU_FTR_SECTION
diff --git a/arch/powerpc/kernel/cpu_setup_a2.S b/arch/powerpc/kernel/cpu_s=
etup_a2.S
index 61f079e..3b52baa 100644
--- a/arch/powerpc/kernel/cpu_setup_a2.S
+++ b/arch/powerpc/kernel/cpu_setup_a2.S
@@ -36,6 +36,7 @@
 	(MMUCR1_EXTEND_PID | MMUCR1_CSINV_NEVER | MMUCR1_IRRE | \
 	 MMUCR1_DRRE | MMUCR1_TLBWE_BINV)
=20
+	.text
 _GLOBAL(__setup_cpu_a2)
 	/* Some of these are actually thread local and some are
 	 * core local but doing it always won't hurt
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kerne=
l/cpu_setup_fsl_booke.S
index dcd8819..fb5204f 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -19,6 +19,7 @@
 #include <asm/mmu-book3e.h>
 #include <asm/asm-offsets.h>
=20
+	.text
 _GLOBAL(__e500_icache_setup)
 	mfspr	r0, SPRN_L1CSR1
 	andi.	r3, r0, L1CSR1_ICE
diff --git a/arch/powerpc/kernel/cpu_setup_pa6t.S b/arch/powerpc/kernel/cpu=
_setup_pa6t.S
index d62cb9c..81fd7ac 100644
--- a/arch/powerpc/kernel/cpu_setup_pa6t.S
+++ b/arch/powerpc/kernel/cpu_setup_pa6t.S
@@ -25,6 +25,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
=20
+	.text
 /* Right now, restore and setup are the same thing */
 _GLOBAL(__restore_cpu_pa6t)
 _GLOBAL(__setup_cpu_pa6t)
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cp=
u_setup_power.S
index 57cf140..ced4a39 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -16,6 +16,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
=20
+	.text
 /* Entry: r3 =3D crap, r4 =3D ptr to cputable entry
  *
  * Note that we can be called twice for pseudo-PVRs
diff --git a/arch/powerpc/kernel/cpu_setup_ppc970.S b/arch/powerpc/kernel/c=
pu_setup_ppc970.S
index 12fac8d..220b479 100644
--- a/arch/powerpc/kernel/cpu_setup_ppc970.S
+++ b/arch/powerpc/kernel/cpu_setup_ppc970.S
@@ -16,6 +16,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cache.h>
=20
+	.text
 _GLOBAL(__cpu_preinit_ppc970)
 	/* Do nothing if not running in HV mode */
 	mfmsr	r0
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9499385..b2a4838 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -45,6 +45,8 @@
 #define LOAD_MSR_KERNEL(r, x)	li r,(x)
 #endif
=20
+	.text
+
 #ifdef CONFIG_BOOKE
 	.globl	mcheck_transfer_to_handler
 mcheck_transfer_to_handler:
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index e0ada05..728f700 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -50,6 +50,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
=20
+	.text
 /*
  * This task wants to use the FPU now.
  * On UP, disable FP for the task which had the FPU previously,
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 116f086..8d3edb9 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -23,6 +23,7 @@
  */
=20
 #include <linux/threads.h>
+#include <linux/init.h>
 #include <asm/reg.h>
 #include <asm/page.h>
 #include <asm/mmu.h>
@@ -352,6 +353,8 @@ _GLOBAL(__start_initialization_multiplatform)
 	b	.__after_prom_start
 #endif /* CONFIG_PPC_BOOK3E */
=20
+	__REF
+
 _INIT_STATIC(__boot_from_prom)
 #ifdef CONFIG_PPC_OF_BOOT_TRAMPOLINE
 	/* Save parameters */
@@ -390,6 +393,8 @@ _INIT_STATIC(__boot_from_prom)
 	 * from OF while CONFIG_PPC_OF_BOOT_TRAMPOLINE isn't selected */
 	trap
=20
+	.text
+
 _STATIC(__after_prom_start)
 #ifdef CONFIG_RELOCATABLE
 	/* process relocations for the final address of the kernel */
@@ -677,6 +682,8 @@ _GLOBAL(relative_toc)
=20
 p_toc:	.llong	__toc_start + 0x8000 - 0b
=20
+	__REF
+
 /*
  * This is where the main kernel code starts.
  */
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/hea=
d_fsl_booke.S
index 6f62a73..4ec5625 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -776,6 +776,8 @@ tlb_write_entry:
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	rfi					/* Force context change */
=20
+	,text
+
 #ifdef CONFIG_SPE
 /* Note that the SPE support is closely modeled after the AltiVec
  * support.  Changes to one are likely to be applicable to the
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 1686916..4c414e9 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -187,6 +187,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
=20
 	.data
=20
+/*
+ * hmm, should this ".text" be here?  The following _GLOBAL()s
+ * used to switch to the text section
+ */
+	.text
 _GLOBAL(nap_save_msscr0)
 	.space	4*NR_CPUS
=20
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_b=
ook3e.S
index 4c7cb400..0d90d6a 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -17,6 +17,8 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
=20
+	.text
+
 /* 64-bit version only for now */
 #ifdef CONFIG_PPC64
=20
diff --git a/arch/powerpc/kernel/l2cr_6xx.S b/arch/powerpc/kernel/l2cr_6xx.S
index 97ec855..000b337 100644
--- a/arch/powerpc/kernel/l2cr_6xx.S
+++ b/arch/powerpc/kernel/l2cr_6xx.S
@@ -96,6 +96,7 @@ IMPORTANT:
  * passed in.
  *   -- paulus.
  */
+	.text
 _GLOBAL(_set_L2CR)
 	/* Make sure this is a 750 or 7400 chip */
 BEGIN_FTR_SECTION
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 19e096b..342c4d9 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -327,6 +327,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_UNIFIED_ID_CACHE)
  *
  * flush_icache_range(unsigned long start, unsigned long stop)
  */
+	.section	".kprobes.text","a"
 _KPROBE(__flush_icache_range)
 BEGIN_FTR_SECTION
 	blr				/* for 601, do nothing */
@@ -357,6 +358,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 	sync				/* additional sync needed on g4 */
 	isync
 	blr
+
+	.text
+
 /*
  * Write any modified data cache blocks out to memory.
  * Does not invalidate the corresponding cache lines (especially for
diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
index 5cfa800..0fbe125 100644
--- a/arch/powerpc/kernel/misc_64.S
+++ b/arch/powerpc/kernel/misc_64.S
@@ -67,6 +67,7 @@ PPC64_CACHES:
  *   flush all bytes from start through stop-1 inclusive
  */
=20
+	.section	".kprobes.text","a"
 _KPROBE(__flush_icache_range)
=20
 /*
diff --git a/arch/powerpc/kernel/ppc_save_regs.S b/arch/powerpc/kernel/ppc_=
save_regs.S
index 1b1787d..48b41a0 100644
--- a/arch/powerpc/kernel/ppc_save_regs.S
+++ b/arch/powerpc/kernel/ppc_save_regs.S
@@ -13,6 +13,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
=20
+	.text
+
 /*
  * Grab the register values as they are now.
  * This won't do a particularly good job because we really
diff --git a/arch/powerpc/kernel/reloc_32.S b/arch/powerpc/kernel/reloc_32.S
index ef46ba6..180a356a 100644
--- a/arch/powerpc/kernel/reloc_32.S
+++ b/arch/powerpc/kernel/reloc_32.S
@@ -31,6 +31,8 @@ R_PPC_RELATIVE =3D 22
  * r3 =3D desired final address
  */
=20
+	.text
+
 _GLOBAL(relocate)
=20
 	mflr	r0		/* Save our LR */
diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
index b47a0e1..3ced962 100644
--- a/arch/powerpc/kernel/reloc_64.S
+++ b/arch/powerpc/kernel/reloc_64.S
@@ -15,6 +15,8 @@ RELA =3D 7
 RELACOUNT =3D 0x6ffffff9
 R_PPC64_RELATIVE =3D 22
=20
+	.text
+
 /*
  * r3 =3D desired final address of kernel
  */
diff --git a/arch/powerpc/kernel/swsusp_32.S b/arch/powerpc/kernel/swsusp_3=
2.S
index ba4dee3..7cd3243 100644
--- a/arch/powerpc/kernel/swsusp_32.S
+++ b/arch/powerpc/kernel/swsusp_32.S
@@ -33,6 +33,11 @@
 	.section .data
 	.align	5
=20
+/* should this ".text" really be here?  The _GLOBAL() used to have
+ * the ".text" embedded in it.
+ */
+	.text
+
 _GLOBAL(swsusp_save_area)
 	.space	SL_SIZE
=20
diff --git a/arch/powerpc/kernel/swsusp_booke.S b/arch/powerpc/kernel/swsus=
p_booke.S
index 11a3930..f30f5d3 100644
--- a/arch/powerpc/kernel/swsusp_booke.S
+++ b/arch/powerpc/kernel/swsusp_booke.S
@@ -39,6 +39,11 @@
 	.section .data
 	.align	5
=20
+/*
+ * Should this ".text" be here?  The _GLOBAL() used to have
+ * the ".text" embedded in it.
+ */
+	.text
 _GLOBAL(swsusp_save_area)
 	.space	SL_SIZE
=20
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 93219c3..af3d3be 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -36,6 +36,8 @@
 #define PPC_SYS_SPU(func)	PPC_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
=20
+	.text
+
 #ifdef CONFIG_PPC64
 #define sys_sigpending	sys_ni_syscall
 #define sys_old_getrlimit sys_ni_syscall
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index e830289..8560e88 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -7,6 +7,8 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
=20
+	.text
+
 /*
  * load_up_altivec(unused, unused, tsk)
  * Disable VMX for the task which had it previously,
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/boo=
k3s_hv_interrupts.S
index 84035a5..f319e2f 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -28,6 +28,8 @@
 #include <asm/exception-64s.h>
 #include <asm/ppc-opcode.h>
=20
+	.text
+
 /*************************************************************************=
****
  *                                                                        =
   *
  *     Guest entry / exit code that is in kernel module memory (vmalloc)  =
   *
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/boo=
k3s_hv_rmhandlers.S
index 74a24bb..f8667e3 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -28,6 +28,8 @@
 #include <asm/exception-64s.h>
 #include <asm/kvm_book3s_asm.h>
=20
+	.text
+
 /*************************************************************************=
****
  *                                                                        =
   *
  *        Real Mode handlers that need to be in the linear mapping        =
   *
diff --git a/arch/powerpc/kvm/book3s_interrupts.S b/arch/powerpc/kvm/book3s=
_interrupts.S
index 48cbbf8..672c21a 100644
--- a/arch/powerpc/kvm/book3s_interrupts.S
+++ b/arch/powerpc/kvm/book3s_interrupts.S
@@ -50,6 +50,8 @@
 	PPC_LL	r30, VCPU_GPR(R30)(vcpu); \
 	PPC_LL	r31, VCPU_GPR(R31)(vcpu); \
=20
+	.text
+
 /*************************************************************************=
****
  *                                                                        =
   *
  *     Guest entry / exit code that is in kernel module memory (highmem)  =
   *
diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s=
_rmhandlers.S
index 9ecf6e3..4883e92 100644
--- a/arch/powerpc/kvm/book3s_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_rmhandlers.S
@@ -28,6 +28,8 @@
 #include <asm/exception-64s.h>
 #endif
=20
+	.text
+
 /*************************************************************************=
****
  *                                                                        =
   *
  *        Real Mode handlers that need to be in low physical memory       =
   *
diff --git a/arch/powerpc/kvm/booke_interrupts.S b/arch/powerpc/kvm/booke_i=
nterrupts.S
index bb46b32..f379cda 100644
--- a/arch/powerpc/kvm/booke_interrupts.S
+++ b/arch/powerpc/kvm/booke_interrupts.S
@@ -73,6 +73,8 @@ _GLOBAL(kvmppc_handler_\ivor_nr)
 	bctr
 .endm
=20
+	.text
+
 _GLOBAL(kvmppc_handlers_start)
 KVM_HANDLER BOOKE_INTERRUPT_CRITICAL SPRN_SPRG_RSCRATCH_CRIT SPRN_CSRR0
 KVM_HANDLER BOOKE_INTERRUPT_MACHINE_CHECK  SPRN_SPRG_RSCRATCH_MC SPRN_MCSR=
R0
diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/booke=
hv_interrupts.S
index 099fe82..4ec294f 100644
--- a/arch/powerpc/kvm/bookehv_interrupts.S
+++ b/arch/powerpc/kvm/bookehv_interrupts.S
@@ -60,6 +60,8 @@
 #define NEED_DEAR		0x00000002 /* save faulting DEAR */
 #define NEED_ESR		0x00000004 /* save faulting ESR */
=20
+	.text
+
 /*
  * On entry:
  * r4 =3D vcpu, r5 =3D srr0, r6 =3D srr1
diff --git a/arch/powerpc/kvm/fpu.S b/arch/powerpc/kvm/fpu.S
index bf68d59..dfe7d48 100644
--- a/arch/powerpc/kvm/fpu.S
+++ b/arch/powerpc/kvm/fpu.S
@@ -22,6 +22,8 @@
=20
 /* Instructions operating on single parameters */
=20
+	.text
+
 /*
  * Single operation with one input operand
  *
diff --git a/arch/powerpc/lib/checksum_64.S b/arch/powerpc/lib/checksum_64.S
index 167f725..539d9ac 100644
--- a/arch/powerpc/lib/checksum_64.S
+++ b/arch/powerpc/lib/checksum_64.S
@@ -17,6 +17,8 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
=20
+	.text
+
 /*
  * ip_fast_csum(r3=3Dbuf, r4=3Dlen) -- Optimized for IP header
  * len is in words and is always >=3D 5.
diff --git a/arch/powerpc/lib/copypage_power7.S b/arch/powerpc/lib/copypage=
_power7.S
index 0ef75bf..df72190 100644
--- a/arch/powerpc/lib/copypage_power7.S
+++ b/arch/powerpc/lib/copypage_power7.S
@@ -20,6 +20,8 @@
 #include <asm/page.h>
 #include <asm/ppc_asm.h>
=20
+	.text
+
 _GLOBAL(copypage_power7)
 	/*
 	 * We prefetch both the source and destination using enhanced touch
diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index d73a590..9e57cd5 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
=20
+	.text
 	.align	7
 _GLOBAL(__copy_tofrom_user)
 BEGIN_FTR_SECTION
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser=
_power7.S
index 0d24ff1..c2b2269 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -19,6 +19,8 @@
  */
 #include <asm/ppc_asm.h>
=20
+	.text
+
 	.macro err1
 100:
 	.section __ex_table,"a"
diff --git a/arch/powerpc/lib/div64.S b/arch/powerpc/lib/div64.S
index 83d9832..439c5f5 100644
--- a/arch/powerpc/lib/div64.S
+++ b/arch/powerpc/lib/div64.S
@@ -16,6 +16,8 @@
 #include <asm/ppc_asm.h>
 #include <asm/processor.h>
=20
+	.text
+
 _GLOBAL(__div64_32)
 	lwz	r5,0(r3)	# get the dividend into r5/r6
 	lwz	r6,4(r3)
diff --git a/arch/powerpc/lib/hweight_64.S b/arch/powerpc/lib/hweight_64.S
index 9b96ff2..6db0f35 100644
--- a/arch/powerpc/lib/hweight_64.S
+++ b/arch/powerpc/lib/hweight_64.S
@@ -22,6 +22,8 @@
=20
 /* Note: This code relies on -mminimal-toc */
=20
+	.text
+
 _GLOBAL(__arch_hweight8)
 BEGIN_FTR_SECTION
 	b .__sw_hweight8
diff --git a/arch/powerpc/lib/ldstfp.S b/arch/powerpc/lib/ldstfp.S
index 85aec08..2707323 100644
--- a/arch/powerpc/lib/ldstfp.S
+++ b/arch/powerpc/lib/ldstfp.S
@@ -37,6 +37,8 @@ reg =3D reg + 1
 	.endr
 	.endm
=20
+	.text
+
 /* Get the contents of frN into fr0; N is in r3. */
 _GLOBAL(get_fpr)
 	mflr	r0
diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
index f4fcb0b..6f7e636 100644
--- a/arch/powerpc/lib/mem_64.S
+++ b/arch/powerpc/lib/mem_64.S
@@ -12,6 +12,8 @@
 #include <asm/errno.h>
 #include <asm/ppc_asm.h>
=20
+	.text
+
 _GLOBAL(memset)
 	neg	r0,r3
 	rlwimi	r4,r4,8,16,23
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index d2bbbc8..d318765 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -9,6 +9,7 @@
 #include <asm/processor.h>
 #include <asm/ppc_asm.h>
=20
+	.text
 	.align	7
 _GLOBAL(memcpy)
 BEGIN_FTR_SECTION
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_pow=
er7.S
index 0663630..e804ab8 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -19,6 +19,8 @@
  */
 #include <asm/ppc_asm.h>
=20
+	.text
+
 _GLOBAL(memcpy_power7)
 #ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 1a16ca2..fd2413b 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -23,6 +23,8 @@
 #include <asm/pgtable.h>
 #include <asm/firmware.h>
=20
+	.text
+
 /* void slb_allocate_realmode(unsigned long ea);
  *
  * Create an SLB entry for the given EA (user or kernel).
diff --git a/arch/powerpc/mm/tlb_nohash_low.S b/arch/powerpc/mm/tlb_nohash_=
low.S
index 626ad08..487f71a 100644
--- a/arch/powerpc/mm/tlb_nohash_low.S
+++ b/arch/powerpc/mm/tlb_nohash_low.S
@@ -35,6 +35,8 @@
 #include <asm/processor.h>
 #include <asm/bug.h>
=20
+	.text
+
 #if defined(CONFIG_40x)
=20
 /*
diff --git a/arch/powerpc/platforms/pasemi/powersave.S b/arch/powerpc/platf=
orms/pasemi/powersave.S
index 56f45ad..29a64fa 100644
--- a/arch/powerpc/platforms/pasemi/powersave.S
+++ b/arch/powerpc/platforms/pasemi/powersave.S
@@ -43,6 +43,8 @@
 1:	cmpd 	r3,r3;		\
 	bne	1b
=20
+	.text
+
 _doze:
 	PRE_SLEEP_SEQUENCE
 	DOZE
diff --git a/arch/powerpc/platforms/powermac/cache.S b/arch/powerpc/platfor=
ms/powermac/cache.S
index 6be1a4a..af387c9 100644
--- a/arch/powerpc/platforms/powermac/cache.S
+++ b/arch/powerpc/platforms/powermac/cache.S
@@ -18,6 +18,8 @@
 #include <asm/ppc_asm.h>
 #include <asm/cputable.h>
=20
+	.text
+
 /*
  * Flush and disable all data caches (dL1, L2, L3). This is used
  * when going to sleep, when doing a PMU based cpufreq transition,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/=
platforms/powernv/opal-wrappers.S
index 3bb07e5..1a9648a 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -14,6 +14,8 @@
 #include <asm/asm-offsets.h>
 #include <asm/opal.h>
=20
+	.text
+
 /* TODO:
  *
  * - Trace irqs in/off (needs saving/restoring all args, argh...)
diff --git a/arch/powerpc/sysdev/6xx-suspend.S b/arch/powerpc/sysdev/6xx-su=
spend.S
index cf48e9c..c87ced0 100644
--- a/arch/powerpc/sysdev/6xx-suspend.S
+++ b/arch/powerpc/sysdev/6xx-suspend.S
@@ -16,6 +16,8 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
=20
+	.text
+
 _GLOBAL(mpc6xx_enter_standby)
 	mflr	r4
=20
diff --git a/arch/powerpc/sysdev/dcr-low.S b/arch/powerpc/sysdev/dcr-low.S
index d3098ef..aadc7ec 100644
--- a/arch/powerpc/sysdev/dcr-low.S
+++ b/arch/powerpc/sysdev/dcr-low.S
@@ -26,6 +26,8 @@
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;	\
 	blr
=20
+	.text
+
 _GLOBAL(__mfdcr)
 	DCR_ACCESS_PROLOG(__mfdcr_table)
=20
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__29_Nov_2012_10_55_25_+1100_L9aWCG5d7NZ2VdDE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJQtqRtAAoJEECxmPOUX5FECMIP/RsNlMaUsPLLlx1O6pDWogA3
s9JlWoN4qrrB0LQEO/KTxpRJBevGSWybO0kp3uibkXokElCIfZYwX7DP67PAIR+q
z5euHnJ3mILMrdjicGdeRiXY3wiWiUM+/MjAbD/AhZUFblUCp7usYk36Xh+b+uvo
w7Pr93Xby9LzzR91pxaR2nhv2nL62+aNjMLmKjn+xt+MOT2rSF1JJu4QFtQ8Fzzo
a0v6BKE3U/jr8NwQgmVO8umFHKbNAtU7VFBtW7gnbc1GbSQSSCGU5QH3l7qpXgtd
GScxRzEnukf0eX4rSZAs6M+yPVHcZwAJn5VHXiozUAnyodqXyrCfIa2S3X5JRTMB
UX2xtdcUDflpoCnrs/qbjTOm4RYclgY3YWbkUuGeNL2gxZreaucUcX7L/TIkKXXZ
BhmLCv36vYSk3yZRqCLhTpmkDjrcY9cJnoY46MRCwhtH6+fNHpKWYhYcpW9xQfc2
GIjoxEqK5BrnZ0Yx1k0bbWo2Owu9p0b6KmVxdfjHvl6+79tFtNd8TJRZYgPDwfZp
MFMgNYQPD/UvUSDQ7Vy4x+NKW77MdzEqKQFdi6zfedfhFovIf5UMkUWrlm8U4Dx6
c1wJzMoV0azm7kD1XGsdnbJXHPp4y51foTcZPUotXFUcJkdBjlNAyoh3dO+xQRss
A6n/WTf8ROEgRRPw9YCk
=ikoq
-----END PGP SIGNATURE-----

--Signature=_Thu__29_Nov_2012_10_55_25_+1100_L9aWCG5d7NZ2VdDE--
