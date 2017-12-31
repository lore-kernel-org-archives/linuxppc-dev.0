Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z8xDD1nq1zDqy4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jan 2018 10:21:46 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBVNKp7D068792
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Dec 2017 18:21:43 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2f6rphy2x2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Dec 2017 18:21:43 -0500
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Sun, 31 Dec 2017 18:21:42 -0500
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: cyrilbur@gmail.com
Subject: [PATCH 1/2] powerpc/tm: Fix endianness flip on trap
Date: Sun, 31 Dec 2017 18:20:45 -0500
Message-Id: <1514762446-1323-1-git-send-email-gromero@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently it's possible that a thread on PPC64 LE has its endianness
flipped inadvertently to Big-Endian resulting in a crash once the process
is back from the signal handler.

If giveup_all() is called when regs->msr has the bits MSR.FP and MSR.VEC
disabled (and hence MSR.VSX disabled too) it returns without calling
check_if_tm_restore_required() which copies regs->msr to ckpt_regs->msr if
the process caught a signal whilst in transactional mode. Then once in
setup_tm_sigcontexts() MSR from ckpt_regs.msr is used, but since
check_if_tm_restore_required() was not called previuosly, gp_regs[PT_MSR]
gets a copy of invalid MSR bits as MSR in ckpt_regs was not updated from
regs->msr and so is zeroed. Later when leaving the signal handler once in
sys_rt_sigreturn() the TS bits of gp_regs[PT_MSR] are checked to determine
if restore_tm_sigcontexts() must be called to pull in the correct MSR state
into the user context. Because TS bits are zeroed
restore_tm_sigcontexts() is never called and MSR restored from the user
context on returning from the signal handler has the MSR.LE (the endianness
bit) forced to zero (Big-Endian). That leads, for instance, to 'nop' being
treated as an illegal instruction in the following sequence:

	tbegin.
	beq	1f
	trap
	tend.
1:	nop

on PPC64 LE machines and the process dies just after returning from the
signal handler.

PPC64 BE is also affected but in a subtle way since forcing Big-Endian on
a BE machine does not change the endianness.

This commit fixes the issue described above by ensuring that once in
setup_tm_sigcontexts() the MSR used is from regs->msr instead of from
ckpt_regs->msr and by ensuring that we pull in only the MSR.FP, MSR.VEC,
and MSR.VSX bits from ckpt_regs->msr.

The fix was tested both on LE and BE machines and no regression regarding
the powerpc/tm selftests was observed.

Signed-off-by: Gustavo Romero <gromero@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/signal_64.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 4b9ca35..b1b9962 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -207,7 +207,7 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	elf_vrreg_t __user *tm_v_regs = sigcontext_vmx_regs(tm_sc);
 #endif
 	struct pt_regs *regs = tsk->thread.regs;
-	unsigned long msr = tsk->thread.ckpt_regs.msr;
+	unsigned long msr = tsk->thread.regs->msr;
 	long err = 0;
 
 	BUG_ON(tsk != current);
@@ -216,6 +216,12 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 
 	WARN_ON(tm_suspend_disabled);
 
+	/* Restore checkpointed FP, VEC, and VSX bits from ckpt_regs as
+	 * it contains the correct FP, VEC, VSX state after we treclaimed
+	 * the transaction and giveup_all() was called on reclaiming.
+	 */
+	msr |= tsk->thread.ckpt_regs.msr & (MSR_FP | MSR_VEC | MSR_VSX);
+
 	/* Remove TM bits from thread's MSR.  The MSR in the sigcontext
 	 * just indicates to userland that we were doing a transaction, but we
 	 * don't want to return in transactional state.  This also ensures
-- 
2.7.4
