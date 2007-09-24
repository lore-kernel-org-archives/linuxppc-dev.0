Return-Path: <roland@redhat.com>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id 2766CDDE1B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 10:00:03 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: ptrace CHECK_FULL_REGS
Message-Id: <20070924235052.5AFC24D04B7@magilla.localdomain>
Date: Mon, 24 Sep 2007 16:50:52 -0700 (PDT)
Cc: David Woodhouse <dwmw2@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This restores the CHECK_FULL_REGS sanity check to every place that can
access the nonvolatile GPRs for ptrace.  This is already done for
native-bitwidth PTRACE_PEEKUSR, but was omitted for many other cases
(32-bit ptrace, PTRACE_GETREGS, etc.); I think there may have been more
uniform checks before that were lost in the recent cleanup of GETREGS et al.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/ptrace.c   |    4 ++++
 arch/powerpc/kernel/ptrace32.c |    8 ++++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8a177bd..40d34b3 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -331,6 +331,7 @@ static long arch_ptrace_old(struct task_struct *child, long request, long addr,
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
 		unsigned long __user *tmp = (unsigned long __user *)addr;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
 			if (ret)
@@ -346,6 +347,7 @@ static long arch_ptrace_old(struct task_struct *child, long request, long addr,
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
 		unsigned long __user *tmp = (unsigned long __user *)addr;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
 			if (ret)
@@ -517,6 +519,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 			ret = -EIO;
 			break;
 		}
+		CHECK_FULL_REGS(child->thread.regs);
 		ret = 0;
 		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
 			ret |= __put_user(ptrace_get_reg(child, ui),
@@ -537,6 +540,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 			ret = -EIO;
 			break;
 		}
+		CHECK_FULL_REGS(child->thread.regs);
 		ret = 0;
 		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
 			ret = __get_user(tmp, (unsigned long __user *) data);
diff --git a/arch/powerpc/kernel/ptrace32.c b/arch/powerpc/kernel/ptrace32.c
index 9e6baea..6b86960 100644
--- a/arch/powerpc/kernel/ptrace32.c
+++ b/arch/powerpc/kernel/ptrace32.c
@@ -53,6 +53,7 @@ static long compat_ptrace_old(struct task_struct *child, long request,
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
 		unsigned int __user *tmp = (unsigned int __user *)addr;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
 			if (ret)
@@ -68,6 +69,7 @@ static long compat_ptrace_old(struct task_struct *child, long request,
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
 		unsigned int __user *tmp = (unsigned int __user *)addr;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
 			if (ret)
@@ -164,6 +166,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		if ((addr & 3) || (index > PT_FPSCR32))
 			break;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		if (index < PT_FPR0) {
 			tmp = ptrace_get_reg(child, index);
 		} else {
@@ -210,6 +213,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		if ((addr & 3) || numReg > PT_FPSCR)
 			break;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		if (numReg >= PT_FPR0) {
 			flush_fp_to_thread(child);
 			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
@@ -270,6 +274,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		if ((addr & 3) || (index > PT_FPSCR32))
 			break;
 
+		CHECK_FULL_REGS(child->thread.regs);
 		if (index < PT_FPR0) {
 			ret = ptrace_put_reg(child, index, data);
 		} else {
@@ -307,6 +312,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 		 */
 		if ((addr & 3) || (numReg > PT_FPSCR))
 			break;
+		CHECK_FULL_REGS(child->thread.regs);
 		if (numReg < PT_FPR0) {
 			unsigned long freg = ptrace_get_reg(child, numReg);
 			if (index % 2)
@@ -342,6 +348,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 			ret = -EIO;
 			break;
 		}
+		CHECK_FULL_REGS(child->thread.regs);
 		ret = 0;
 		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
 			ret |= __put_user(ptrace_get_reg(child, ui),
@@ -359,6 +366,7 @@ long compat_sys_ptrace(int request, int pid, unsigned long addr,
 			ret = -EIO;
 			break;
 		}
+		CHECK_FULL_REGS(child->thread.regs);
 		ret = 0;
 		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
 			ret = __get_user(tmp, (unsigned int __user *) data);
