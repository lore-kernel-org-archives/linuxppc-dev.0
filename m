Return-Path: <sam.bobroff@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B82C21A06FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 13:34:01 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Wed, 4 Jun 2014 13:34:00 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AC2E22CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jun 2014 13:33:57 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s543Xg9m6554062
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 13:33:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s543Xv7D002577
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Jun 2014 13:33:57 +1000
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: benh@au1.ibm.com
Subject: [PATCH 1/1] powerpc: correct DSCR during TM context switch
Date: Wed,  4 Jun 2014 13:33:56 +1000
Message-Id: <f1ddc3bc4b970a480367a45cdca51e879cb14df0.1401852531.git.sam.bobroff@au1.ibm.com>
Cc: aik@ozlabs.ru, mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Correct the DSCR SPR becoming temporarily corrupted when a task is
context switched when within a transaction. It is corrected when
the transaction is aborted (which will happen after a context switch)
but if the task has suspended (TSUSPEND) the transaction the incorrect
value can be seen.

The problem is caused by saving a thread's DSCR after it has already
been reverted to the CPU's default value:

__switch_to() calls __switch_to_tm()
	which calls tm_reclaim_task()
	which calls tm_reclaim_thread()
	which calls tm_reclaim() where the DSCR is reset
__switch_to() calls _switch
	_switch() saves the DSCR to thread.dscr

The fix is to treat the DSCR similarly to the TAR and save it early
in __switch_to().

The program below will expose the problem:

  #include <inttypes.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <assert.h>
  #include <asm/tm.h>

  #define TBEGIN          ".long 0x7C00051D ;"
  #define TEND            ".long 0x7C00055D ;"
  #define TCHECK          ".long 0x7C00059C ;"
  #define TSUSPEND        ".long 0x7C0005DD ;"
  #define TRESUME         ".long 0x7C2005DD ;"
  #define SPRN_TEXASR     0x82
  #define SPRN_DSCR       0x03

  int main(void) {
    uint64_t i = 0, rv, dscr1 = 1, dscr2, texasr;

    for (;;) {
      rv = 1;
      asm __volatile__ (
      "ld      3, %[dscr1];"
      "mtspr   %[sprn_dscr], 3;"
      TBEGIN
      "beq     1f;"
      TSUSPEND
      "2: ;"
      TCHECK
      "bc      4, 0, 2b;"
      "mfspr   3, %[sprn_dscr];"
      "std     3, %[dscr2];"
      "mfspr   3, %[sprn_texasr];"
      "std     3, %[texasr];"
      TRESUME
      TEND
      "li      %[rv], 0;"
      "1: ;"
      : [rv]"=r"(rv), [dscr2]"=m"(dscr2), [texasr]"=m"(texasr)
      : [dscr1]"m"(dscr1)
      , [sprn_dscr]"i"(SPRN_DSCR), [sprn_texasr]"i"(SPRN_TEXASR)
      : "memory", "r3"
      );
      assert(rv);
      if ((texasr >> 56) == TM_CAUSE_RESCHED) {
        putchar('!');
        fflush(stdout);
        i++;
      }
      else {
        putchar('.');
        fflush(stdout);
      }
      if (dscr2 != dscr1) {
        printf("\n==== DSCR incorrect: 0x%lx (expecting 0x%lx)\n", dscr2, dscr1);
        exit(EXIT_FAILURE);
      }
      if (i > 10) {
        printf("\n==== DSCR TM context switching seems OK.\n");
        exit(EXIT_SUCCESS);
      }
    }
  }

Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
---
 arch/powerpc/include/asm/switch_to.h |    6 ++++--
 arch/powerpc/kernel/entry_64.S       |    6 ------
 arch/powerpc/kernel/process.c        |    8 ++++----
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 2737f46..3efd0e5 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -16,13 +16,15 @@ struct thread_struct;
 extern struct task_struct *_switch(struct thread_struct *prev,
 				   struct thread_struct *next);
 #ifdef CONFIG_PPC_BOOK3S_64
-static inline void save_tar(struct thread_struct *prev)
+static inline void save_early_sprs(struct thread_struct *prev)
 {
 	if (cpu_has_feature(CPU_FTR_ARCH_207S))
 		prev->tar = mfspr(SPRN_TAR);
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		prev->dscr = mfspr(SPRN_DSCR);
 }
 #else
-static inline void save_tar(struct thread_struct *prev) {}
+static inline void save_early_sprs(struct thread_struct *prev) {}
 #endif
 
 extern void enable_kernel_fp(void);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 662c6dd..a107f4a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -432,12 +432,6 @@ BEGIN_FTR_SECTION
 	std	r24,THREAD_VRSAVE(r3)
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_PPC64
-BEGIN_FTR_SECTION
-	mfspr	r25,SPRN_DSCR
-	std	r25,THREAD_DSCR(r3)
-END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
-#endif
 	and.	r0,r0,r22
 	beq+	1f
 	andc	r22,r22,r0
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e247898..8d2065e 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -771,15 +771,15 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	WARN_ON(!irqs_disabled());
 
-	/* Back up the TAR across context switches.
+	/* Back up the TAR and DSCR across context switches.
 	 * Note that the TAR is not available for use in the kernel.  (To
 	 * provide this, the TAR should be backed up/restored on exception
 	 * entry/exit instead, and be in pt_regs.  FIXME, this should be in
 	 * pt_regs anyway (for debug).)
-	 * Save the TAR here before we do treclaim/trecheckpoint as these
-	 * will change the TAR.
+	 * Save the TAR and DSCR here before we do treclaim/trecheckpoint as
+	 * these will change them.
 	 */
-	save_tar(&prev->thread);
+	save_early_sprs(&prev->thread);
 
 	__switch_to_tm(prev);
 
-- 
1.7.10.4
