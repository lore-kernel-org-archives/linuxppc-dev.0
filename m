Return-Path: <galak@freescale.com>
Date: Mon, 10 Oct 2005 14:41:50 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.61.0510101441240.1572@nylon.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: [PATCH] powerpc: Some fixes to allow building for a Book-E processor
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some minor fixes that are needed if we are building for a book-e
processor.  Book-e processors dont have DABR or hashed page tables.

Signed-off-by: Kumar K. Gala <kumar.gala@freescale.com>

---
commit dfc32a358c961c3fbfa94942ecb06da2e895ffe7
tree 61513cafc77bf3fb49ccf9ab652ff2a0b492b113
parent 05f62a5c049845eab8dfb3aeda55c18a2d4396e3
author Kumar K. Gala <kumar.gala@freescale.com> Mon, 10 Oct 2005 13:12:10 -0500
committer Kumar K. Gala <kumar.gala@freescale.com> Mon, 10 Oct 2005 13:12:10 -0500

 arch/powerpc/kernel/process.c |    2 ++
 arch/powerpc/mm/Makefile      |    5 ++---
 arch/powerpc/mm/fault.c       |    2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -214,6 +214,7 @@ int dump_spe(struct pt_regs *regs, elf_v
 }
 #endif /* CONFIG_SPE */
 
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 static void set_dabr_spr(unsigned long val)
 {
 	mtspr(SPRN_DABR, val);
@@ -238,6 +239,7 @@ int set_dabr(unsigned long dabr)
 }
 
 static DEFINE_PER_CPU(unsigned long, current_dabr);
+#endif /* !(CONFIG_4xx || CONFIG_BOOKE) */
 
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -3,10 +3,9 @@
 #
 
 obj-y				:= fault.o mem.o lmb.o
-obj-$(CONFIG_PPC32)		+= init.o pgtable.o mmu_context.o \
-				   tlb.o
+obj-$(CONFIG_PPC32)		+= init.o pgtable.o mmu_context.o
 obj-$(CONFIG_PPC64)		+= init64.o pgtable64.o mmu_context64.o
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu.o hash_32.o
+obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu.o hash_32.o tlb.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
 obj-$(CONFIG_FSL_BOOKE)		+= fsl_booke_mmu.o
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -80,6 +80,7 @@ static int store_updates_sp(struct pt_re
 	return 0;
 }
 
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 static void do_dabr(struct pt_regs *regs, unsigned long error_code)
 {
 	siginfo_t info;
@@ -101,6 +102,7 @@ static void do_dabr(struct pt_regs *regs
 	info.si_addr = (void __user *)regs->nip;
 	force_sig_info(SIGTRAP, &info, current);
 }
+#endif
 
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
