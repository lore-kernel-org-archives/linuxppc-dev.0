Return-Path: <SRS0+5e6470665161f9dca089+1186+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A5B5E67C53
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 05:36:32 +1100 (EST)
Subject: Re: Incorrect order of last two arguments of ptrace for requests
	PPC_PTRACE_GETREGS, SETREGS, GETFPREGS, SETFPREGS
From: David Woodhouse <dwmw2@infradead.org>
To: supriya kannery <supriyak@in.ibm.com>
In-Reply-To: <453F421A.6070507@in.ibm.com>
References: <453F421A.6070507@in.ibm.com>
Content-Type: multipart/mixed; boundary="=-kaajnNrN3ClK/2QNwuM3"
Date: Wed, 22 Nov 2006 18:36:20 +0000
Message-Id: <1164220580.12365.8.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-kaajnNrN3ClK/2QNwuM3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-10-25 at 16:23 +0530, supriya kannery wrote:
> In ptrace, when request is PPC_PTRACE_GETREGS, SETREGS, GETFPREGS and 
> SETFPREGS, order of the last two arguments is not correct.
> 
> General format of ptrace is ptrace (request, pid, addr, data).  For the 
> above mentioned request ids in ppc64, if we use ptrace like
> 
>  long reg[32];
>  ptrace (PPC_PTRACE_GETREGS, pid, 0, &reg[0]);
> 
> the return value is always -1.
> 
> If we exchange the last two arguments like,
> 
>  ptrace (PPC_PTRACE_GETREGS, pid, &reg[0], 0);
> 
> it works!
> 
> This is because PPC_PTRACE_GETREGS option for powerpc is implemented 
> such that general purpose
> registers of the child process get copied to the address variable 
> instead of data variable. Same is
> the case with other PPC request options PPC_PTRACE_SETREGS, GETFPREGS 
> and SETFPREGS.
> 
> Prepared a patch for this problem and tested with 2.6.18-rc6 kernel. 
> This patch can be applied directly to 2.6.19-rc3 kernel.

A more appropriate place to send this would be the linux-ppc development
list.

-- 
dwmw2

--=-kaajnNrN3ClK/2QNwuM3
Content-Disposition: attachment; filename=ppc_ptrace_params.patch
Content-Type: text/x-patch; name=ppc_ptrace_params.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naurp linux-2.6.18-rc6/arch/powerpc/kernel/ptrace.c linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace.c
--- linux-2.6.18-rc6/arch/powerpc/kernel/ptrace.c	2006-10-19 18:09:01.000000000 +0530
+++ linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace.c	2006-10-19 18:11:37.000000000 +0530
@@ -406,7 +406,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -421,7 +421,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
@@ -436,7 +436,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		flush_fp_to_thread(child);
 
@@ -453,7 +453,7 @@ long arch_ptrace(struct task_struct *chi
 	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned long __user *tmp = (unsigned long __user *)addr;
+		unsigned long __user *tmp = (unsigned long __user *)data;
 
 		flush_fp_to_thread(child);
 
diff -Naurp linux-2.6.18-rc6/arch/powerpc/kernel/ptrace32.c linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace32.c
--- linux-2.6.18-rc6/arch/powerpc/kernel/ptrace32.c	2006-10-19 18:09:01.000000000 +0530
+++ linux-2.6.18-rc6-mod/arch/powerpc/kernel/ptrace32.c	2006-10-19 18:11:41.000000000 +0530
@@ -345,7 +345,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_GETREGS: { /* Get GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = put_user(*reg, tmp);
@@ -360,7 +360,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_SETREGS: { /* Set GPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.regs)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		for (i = 0; i < 32; i++) {
 			ret = get_user(*reg, tmp);
@@ -375,7 +375,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_GETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		flush_fp_to_thread(child);
 
@@ -392,7 +392,7 @@ long compat_sys_ptrace(int request, int 
 	case PPC_PTRACE_SETFPREGS: { /* Get FPRs 0 - 31. */
 		int i;
 		unsigned long *reg = &((unsigned long *)child->thread.fpr)[0];
-		unsigned int __user *tmp = (unsigned int __user *)addr;
+		unsigned int __user *tmp = (unsigned int __user *)data;
 
 		flush_fp_to_thread(child);
 

--=-kaajnNrN3ClK/2QNwuM3--
