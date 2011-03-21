Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFFD3B6F74
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Mar 2011 11:18:54 +1100 (EST)
Subject: [PATCH] powerpc/ptrace: Remove BUG_ON when full register set not
	available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 11:18:46 +1100
Message-ID: <1300666726.2402.94.camel@pasglop>
Mime-Version: 1.0
Cc: Mike Wolf <mjw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mike Wolf <mjw@linux.vnet.ibm.com>

In some cases during a threaded core dump not all the threads will have
a full register set. This happens when the signal causing the core dump
races with a thread exiting.  The race happens when the exiting thread
has entered the kernel for the last time before the signal arrives, but
doesn't get far enough through the exit code to avoid being included
in the core dump.

So we get a thread included in the core dump which is never going to go
out to userspace again and only has a partial register set recorded

Normally we would catch each thread as it is about to go into userspace
and capture the full register set then.

However, this exiting thread is never going to go out to userspace
again, so we have no way to capture its full register set.  It doesn't
really matter, though, as this is a thread which is effectively
already dead.

So instead of hitting a BUG() in this case (a really bad choice of
action in the first place), we use a poison value for the register
values.

[BenH]: Some cosmetic/stylistic changes and fix build on ppc32

Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/ptrace.h |    2 ++
 arch/powerpc/kernel/ptrace.c      |   15 ++++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
index 0175a67..48223f9 100644
--- a/arch/powerpc/include/asm/ptrace.h
+++ b/arch/powerpc/include/asm/ptrace.h
@@ -125,8 +125,10 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
 #endif /* ! __powerpc64__ */
 #define TRAP(regs)		((regs)->trap & ~0xF)
 #ifdef __powerpc64__
+#define NV_REG_POISON		0xdeadbeefdeadbeefUL
 #define CHECK_FULL_REGS(regs)	BUG_ON(regs->trap & 1)
 #else
+#define NV_REG_POISON		0xdeadbeef
 #define CHECK_FULL_REGS(regs)						      \
 do {									      \
 	if ((regs)->trap & 1)						      \
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9065369..895b082 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -229,12 +229,16 @@ static int gpr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
 {
-	int ret;
+	int i, ret;
 
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
+	if (!FULL_REGS(target->thread.regs)) {
+		/* We have a partial register set.  Fill 14-31 with bogus values */
+		for (i = 14; i < 32; i++)
+			target->thread.regs->gpr[i] = NV_REG_POISON;
+	}
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  target->thread.regs,
@@ -641,11 +645,16 @@ static int gpr32_get(struct task_struct *target,
 	compat_ulong_t *k = kbuf;
 	compat_ulong_t __user *u = ubuf;
 	compat_ulong_t reg;
+	int i;
 
 	if (target->thread.regs == NULL)
 		return -EIO;
 
-	CHECK_FULL_REGS(target->thread.regs);
+	if (!FULL_REGS(target->thread.regs)) {
+		/* We have a partial register set.  Fill 14-31 with bogus values */
+		for (i = 14; i < 32; i++)
+			target->thread.regs->gpr[i] = NV_REG_POISON; 
+	}
 
 	pos /= sizeof(reg);
 	count /= sizeof(reg);
