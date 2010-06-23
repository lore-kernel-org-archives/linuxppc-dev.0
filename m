Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D8E7DB7369
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:30 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp03.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5NA0x6p020472
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:00:59 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5NA4Ug3618500
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:30 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5NA4RYV005221
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 20:04:29 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 24/40] trace syscalls,
	PPC: Convert more ppc32 compat syscalls to COMPAT_SYSCALL
Date: Wed, 23 Jun 2010 20:03:05 +1000
Message-Id: <1277287401-28571-25-git-send-email-imunsie@au1.ibm.com>
In-Reply-To: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
References: <1277287401-28571-1-git-send-email-imunsie@au1.ibm.com>
Cc: Chase Douglas <cndougla@linux.vnet.ibm.com>,
	Dave Kleikamp <shaggy@linux.vnet.ibm.com>,
	Frederic Weisbecker <fweisbec@gmail.com>, Jason Baron <jbaron@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	David Gibson <dwg@au1.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ian Munsie <imunsie@au1.ibm.com>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

Convert the remaining trivial 32bit compat syscalls to use the
COMPAT_SYSCALL_DEFINE family of macros.

The syscalls addressed by this commit were lacking the asmlinkage flag,
which will be added by the COMPAT_SYSCALL_DEFINE macros. This should not
be an issue as asmlinkage has no effect on PowerPC.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/kernel/signal_32.c |   19 +++++++++++++------
 arch/powerpc/kernel/sys_ppc32.c |   20 ++++++++++----------
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 2666101..e65d311 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -595,8 +595,10 @@ static long restore_user_regs(struct pt_regs *regs,
 }
 
 #ifdef CONFIG_PPC64
-long compat_sys_rt_sigaction(int sig, const struct sigaction32 __user *act,
-		struct sigaction32 __user *oact, size_t sigsetsize)
+COMPAT_SYSCALL_DEFINE4(rt_sigaction, int, sig,
+		const struct sigaction32 __user *, act,
+		struct sigaction32 __user *, oact,
+		size_t, sigsetsize)
 {
 	struct k_sigaction new_ka, old_ka;
 	int ret;
@@ -632,8 +634,10 @@ long compat_sys_rt_sigaction(int sig, const struct sigaction32 __user *act,
  * of a signed int (msr in 32-bit mode) and the register representation
  * of a signed int (msr in 64-bit mode) is performed.
  */
-long compat_sys_rt_sigprocmask(u32 how, compat_sigset_t __user *set,
-		compat_sigset_t __user *oset, size_t sigsetsize)
+COMPAT_SYSCALL_DEFINE4(rt_sigprocmask, u32, how,
+		compat_sigset_t __user *, set,
+		compat_sigset_t __user *, oset,
+		size_t, sigsetsize)
 {
 	sigset_t s;
 	sigset_t __user *up;
@@ -660,7 +664,9 @@ long compat_sys_rt_sigprocmask(u32 how, compat_sigset_t __user *set,
 	return 0;
 }
 
-long compat_sys_rt_sigpending(compat_sigset_t __user *set, compat_size_t sigsetsize)
+COMPAT_SYSCALL_DEFINE2(rt_sigpending,
+		compat_sigset_t __user *, set,
+		compat_size_t, sigsetsize)
 {
 	sigset_t s;
 	int ret;
@@ -754,7 +760,8 @@ int copy_siginfo_from_user32(siginfo_t *to, struct compat_siginfo __user *from)
  * (msr in 32-bit mode) and the register representation of a signed int
  * (msr in 64-bit mode) is performed.
  */
-long compat_sys_rt_sigqueueinfo(u32 pid, u32 sig, compat_siginfo_t __user *uinfo)
+COMPAT_SYSCALL_DEFINE3(rt_sigqueueinfo, u32, pid, u32, sig,
+		compat_siginfo_t __user *, uinfo)
 {
 	siginfo_t info;
 	int ret;
diff --git a/arch/powerpc/kernel/sys_ppc32.c b/arch/powerpc/kernel/sys_ppc32.c
index ab45dde..6fc8ba9 100644
--- a/arch/powerpc/kernel/sys_ppc32.c
+++ b/arch/powerpc/kernel/sys_ppc32.c
@@ -73,8 +73,8 @@ COMPAT_SYSCALL_DEFINE3(sysfs, u32, option, u32, arg1,
 }
 
 #ifdef CONFIG_SYSVIPC
-long compat_sys_ipc(u32 call, u32 first, u32 second, u32 third, compat_uptr_t ptr,
-	       u32 fifth)
+COMPAT_SYSCALL_DEFINE6(ipc, u32, call, u32, first, u32, second, u32, third,
+		compat_uptr_t, ptr, u32, fifth)
 {
 	int version;
 
@@ -340,7 +340,7 @@ COMPAT_SYSCALL_DEFINE2(mkdir, const char __user *, pathname,
 	return sys_mkdir(pathname, (int)mode);
 }
 
-long compat_sys_nice(u32 increment)
+COMPAT_SYSCALL_DEFINE1(nice, u32, increment)
 {
 	/* sign extend increment */
 	return sys_nice((int)increment);
@@ -352,13 +352,13 @@ off_t ppc32_lseek(unsigned int fd, u32 offset, unsigned int origin)
 	return sys_lseek(fd, (int)offset, origin);
 }
 
-long compat_sys_truncate(const char __user * path, u32 length)
+COMPAT_SYSCALL_DEFINE2(truncate, const char __user *, path, u32, length)
 {
 	/* sign extend length */
 	return sys_truncate(path, (int)length);
 }
 
-long compat_sys_ftruncate(int fd, u32 length)
+COMPAT_SYSCALL_DEFINE2(ftruncate, int, fd, u32, length)
 {
 	/* sign extend length */
 	return sys_ftruncate(fd, (int)length);
@@ -486,25 +486,25 @@ COMPAT_SYSCALL_DEFINE2(setpgid, u32, pid, u32, pgid)
 	return sys_setpgid((int)pid, (int)pgid);
 }
 
-long compat_sys_getpriority(u32 which, u32 who)
+COMPAT_SYSCALL_DEFINE2(getpriority, u32, which, u32, who)
 {
 	/* sign extend which and who */
 	return sys_getpriority((int)which, (int)who);
 }
 
-long compat_sys_setpriority(u32 which, u32 who, u32 niceval)
+COMPAT_SYSCALL_DEFINE3(setpriority, u32, which, u32, who, u32, niceval)
 {
 	/* sign extend which, who and niceval */
 	return sys_setpriority((int)which, (int)who, (int)niceval);
 }
 
-long compat_sys_ioprio_get(u32 which, u32 who)
+COMPAT_SYSCALL_DEFINE2(ioprio_get, u32, which, u32, who)
 {
 	/* sign extend which and who */
 	return sys_ioprio_get((int)which, (int)who);
 }
 
-long compat_sys_ioprio_set(u32 which, u32 who, u32 ioprio)
+COMPAT_SYSCALL_DEFINE3(ioprio_set, u32, which, u32, who, u32, ioprio)
 {
 	/* sign extend which, who and ioprio */
 	return sys_ioprio_set((int)which, (int)who, (int)ioprio);
@@ -546,7 +546,7 @@ unsigned long compat_sys_mmap2(unsigned long addr, size_t len,
 	return sys_mmap(addr, len, prot, flags, fd, pgoff << 12);
 }
 
-long compat_sys_tgkill(u32 tgid, u32 pid, int sig)
+COMPAT_SYSCALL_DEFINE3(tgkill, u32, tgid, u32, pid, int, sig)
 {
 	/* sign extend tgid, pid */
 	return sys_tgkill((int)tgid, (int)pid, sig);
-- 
1.7.1
