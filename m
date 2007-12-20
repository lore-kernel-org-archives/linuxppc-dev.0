Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id 5932EDDE18
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:02:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 14/43] powerpc user_regset gpr
Message-Id: <20071220115755.29B5E26F98B@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:57:55 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This implements user_regset-style accessors for the powerpc general registers.
In the future these functions will be the only place that needs to understand
the user_regset layout (core dump format) and how it maps to the internal
representation of user thread state.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c |   91 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4edc118..e493fc0 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -119,6 +119,97 @@ int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
 	return -EIO;
 }
 
+static int gpr_get(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	if (target->thread.regs == NULL)
+		return -EIO;
+
+	CHECK_FULL_REGS(target->thread.regs);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  target->thread.regs,
+				  0, offsetof(struct pt_regs, msr));
+	if (!ret) {
+		unsigned long msr = get_user_msr(target);
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
+					  offsetof(struct pt_regs, msr),
+					  offsetof(struct pt_regs, msr) +
+					  sizeof(msr));
+	}
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
+		     offsetof(struct pt_regs, msr) + sizeof(long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.regs->orig_gpr3,
+					  offsetof(struct pt_regs, orig_gpr3),
+					  sizeof(struct pt_regs));
+	if (!ret)
+		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+					       sizeof(struct pt_regs), -1);
+
+	return ret;
+}
+
+static int gpr_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	unsigned long reg;
+	int ret;
+
+	if (target->thread.regs == NULL)
+		return -EIO;
+
+	CHECK_FULL_REGS(target->thread.regs);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 target->thread.regs,
+				 0, PT_MSR * sizeof(reg));
+
+	if (!ret && count > 0) {
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &reg,
+					 PT_MSR * sizeof(reg),
+					 (PT_MSR + 1) * sizeof(reg));
+		if (!ret)
+			ret = set_user_msr(target, reg);
+	}
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
+		     offsetof(struct pt_regs, msr) + sizeof(long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &target->thread.regs->orig_gpr3,
+					 PT_ORIG_R3 * sizeof(reg),
+					 (PT_MAX_PUT_REG + 1) * sizeof(reg));
+
+	if (PT_MAX_PUT_REG + 1 < PT_TRAP && !ret)
+		ret = user_regset_copyin_ignore(
+			&pos, &count, &kbuf, &ubuf,
+			(PT_MAX_PUT_REG + 1) * sizeof(reg),
+			PT_TRAP * sizeof(reg));
+
+	if (!ret && count > 0) {
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &reg,
+					 PT_TRAP * sizeof(reg),
+					 (PT_TRAP + 1) * sizeof(reg));
+		if (!ret)
+			ret = set_user_trap(target, reg);
+	}
+
+	if (!ret)
+		ret = user_regset_copyin_ignore(
+			&pos, &count, &kbuf, &ubuf,
+			(PT_TRAP + 1) * sizeof(reg), -1);
+
+	return ret;
+}
 
 static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
-- 
1.5.3.6
