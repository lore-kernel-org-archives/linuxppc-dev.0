Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0838ADDE47
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 16:41:50 +1100 (EST)
Date: Thu, 3 Jan 2008 16:41:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Check that the syscall table matches the syscall
	numbers
Message-Id: <20080103164141.8faa9f27.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hopefully this will catch any out of order additions to the
table in the future.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/systbl.S                |   44 ++++++++++++++++++++----
 arch/powerpc/platforms/cell/spu_callbacks.c |    3 ++
 include/asm-powerpc/systbl.h                |   50 +++++++++++++-------------
 3 files changed, 65 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 93219c3..89ea6f3 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -15,21 +15,50 @@
  */
 
 #include <asm/ppc_asm.h>
+#include <asm/unistd.h>
+
+/*
+ * These are here so that syscall number checking will work.
+ * Do not add any more.
+ */
+#define	__NR_llseek		__NR__llseek
+#undef	__NR_umount
+#define	__NR_umount		__NR_umount2
+#define __NR_old_getrlimit	__NR_getrlimit
+#define	__NR_newstat		__NR_stat
+#define __NR_newlstat		__NR_lstat
+#define __NR_newfstat		__NR_fstat
+#define __NR_newuname		__NR_uname
+#define __NR_sysctl		__NR__sysctl
+#define sys_ugetrlimit		sys_getrlimit
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.llong	.sys_##func,.sys_##func
-#define COMPAT_SYS(func)	.llong	.sys_##func,.compat_sys_##func
-#define PPC_SYS(func)		.llong	.ppc_##func,.ppc_##func
+#define CHECK_SYS(n)		.org .sys_call_table + n * 16
+
+#define SYSCALL(func)		CHECK_SYS(__NR_##func);	\
+				.llong	.sys_##func,.sys_##func
+#define COMPAT_SYS(func)	CHECK_SYS(__NR_##func); \
+				.llong	.sys_##func,.compat_sys_##func
+#define PPC_SYS(func)		CHECK_SYS(__NR_##func); \
+				.llong	.ppc_##func,.ppc_##func
 #define OLDSYS(func)		.llong	.sys_ni_syscall,.sys_ni_syscall
 #define SYS32ONLY(func)		.llong	.sys_ni_syscall,.compat_sys_##func
 #define SYSX(f, f3264, f32)	.llong	.f,.f3264
+#define SYSCALL_NI		.llong	.sys_ni_syscall,.sys_ni_syscall
 #else
-#define SYSCALL(func)		.long	sys_##func
-#define COMPAT_SYS(func)	.long	sys_##func
-#define PPC_SYS(func)		.long	ppc_##func
+#define CHECK_SYS(n)		.org sys_call_table + n * 4
+
+#define SYSCALL(func)		CHECK_SYS(__NR_##func); \
+				.long	sys_##func
+#define COMPAT_SYS(func)	CHECK_SYS(__NR_##func); \
+				.long	sys_##func
+#define PPC_SYS(func)		CHECK_SYS(__NR_##func); \
+				.long	ppc_##func
 #define OLDSYS(func)		.long	sys_##func
-#define SYS32ONLY(func)		.long	sys_##func
+#define SYS32ONLY(func)		CHECK_SYS(__NR_##func); \
+				.long	sys_##func
 #define SYSX(f, f3264, f32)	.long	f32
+#define SYSCALL_NI		.long	sys_ni_syscall
 #endif
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
@@ -39,6 +68,7 @@
 #ifdef CONFIG_PPC64
 #define sys_sigpending	sys_ni_syscall
 #define sys_old_getrlimit sys_ni_syscall
+#define compat_sys_ugetrlimit		compat_sys_getrlimit
 
 	.p2align	3
 #endif
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index dceb8b6..ae203be 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -40,12 +40,15 @@ static void *spu_syscall_table[] = {
 #define OLDSYS(func)		sys_ni_syscall,
 #define SYS32ONLY(func)		sys_ni_syscall,
 #define SYSX(f, f3264, f32)	sys_ni_syscall,
+#define SYSCALL_NI		sys_ni_syscall,
 
 #define SYSCALL_SPU(func)	sys_##func,
 #define COMPAT_SYS_SPU(func)	sys_##func,
 #define PPC_SYS_SPU(func)	ppc_##func,
 #define SYSX_SPU(f, f3264, f32)	f,
 
+#define sys_ugetrlimit		sys_getrlimit
+
 #include <asm/systbl.h>
 };
 
diff --git a/include/asm-powerpc/systbl.h b/include/asm-powerpc/systbl.h
index 11d5383..fa6c63b 100644
--- a/include/asm-powerpc/systbl.h
+++ b/include/asm-powerpc/systbl.h
@@ -20,7 +20,7 @@ COMPAT_SYS_SPU(time)
 SYSCALL_SPU(mknod)
 SYSCALL_SPU(chmod)
 SYSCALL_SPU(lchown)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 OLDSYS(stat)
 SYSX_SPU(sys_lseek,ppc32_lseek,sys_lseek)
 SYSCALL_SPU(getpid)
@@ -34,11 +34,11 @@ SYSCALL_SPU(alarm)
 OLDSYS(fstat)
 COMPAT_SYS(pause)
 COMPAT_SYS(utime)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
+SYSCALL_NI
+SYSCALL_NI
 COMPAT_SYS_SPU(access)
 COMPAT_SYS_SPU(nice)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL_SPU(sync)
 COMPAT_SYS_SPU(kill)
 SYSCALL_SPU(rename)
@@ -47,7 +47,7 @@ SYSCALL_SPU(rmdir)
 SYSCALL_SPU(dup)
 SYSCALL_SPU(pipe)
 COMPAT_SYS_SPU(times)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL_SPU(brk)
 SYSCALL_SPU(setgid)
 SYSCALL_SPU(getgid)
@@ -56,12 +56,12 @@ SYSCALL_SPU(geteuid)
 SYSCALL_SPU(getegid)
 SYSCALL(acct)
 SYSCALL(umount)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 COMPAT_SYS_SPU(ioctl)
 COMPAT_SYS_SPU(fcntl)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 COMPAT_SYS_SPU(setpgid)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSX(sys_ni_syscall,sys_olduname, sys_olduname)
 COMPAT_SYS_SPU(umask)
 SYSCALL_SPU(chroot)
@@ -101,10 +101,10 @@ SYSCALL_SPU(fchmod)
 SYSCALL_SPU(fchown)
 COMPAT_SYS_SPU(getpriority)
 COMPAT_SYS_SPU(setpriority)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 COMPAT_SYS(statfs)
 COMPAT_SYS(fstatfs)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 COMPAT_SYS_SPU(socketcall)
 COMPAT_SYS_SPU(syslog)
 COMPAT_SYS_SPU(setitimer)
@@ -113,10 +113,10 @@ COMPAT_SYS_SPU(newstat)
 COMPAT_SYS_SPU(newlstat)
 COMPAT_SYS_SPU(newfstat)
 SYSX(sys_ni_syscall,sys_uname,sys_uname)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL_SPU(vhangup)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
+SYSCALL_NI
+SYSCALL_NI
 COMPAT_SYS_SPU(wait4)
 SYSCALL(swapoff)
 COMPAT_SYS_SPU(sysinfo)
@@ -126,21 +126,21 @@ SYS32ONLY(sigreturn)
 PPC_SYS(clone)
 COMPAT_SYS_SPU(setdomainname)
 PPC_SYS_SPU(newuname)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 COMPAT_SYS_SPU(adjtimex)
 SYSCALL_SPU(mprotect)
 SYSX(sys_ni_syscall,compat_sys_sigprocmask,sys_sigprocmask)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL(init_module)
 SYSCALL(delete_module)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL(quotactl)
 COMPAT_SYS_SPU(getpgid)
 SYSCALL_SPU(fchdir)
 SYSCALL_SPU(bdflush)
 COMPAT_SYS(sysfs)
 SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL_SPU(setfsuid)
 SYSCALL_SPU(setfsgid)
 SYSCALL_SPU(llseek)
@@ -169,7 +169,7 @@ COMPAT_SYS_SPU(nanosleep)
 SYSCALL_SPU(mremap)
 SYSCALL_SPU(setresuid)
 SYSCALL_SPU(getresuid)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL_SPU(poll)
 COMPAT_SYS(nfsservctl)
 SYSCALL_SPU(setresgid)
@@ -190,10 +190,10 @@ SYSCALL_SPU(capget)
 SYSCALL_SPU(capset)
 COMPAT_SYS(sigaltstack)
 SYSX_SPU(sys_sendfile64,compat_sys_sendfile,sys_sendfile)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
+SYSCALL_NI
+SYSCALL_NI
 PPC_SYS(vfork)
-COMPAT_SYS_SPU(getrlimit)
+COMPAT_SYS_SPU(ugetrlimit)
 COMPAT_SYS_SPU(readahead)
 SYS32ONLY(mmap2)
 SYS32ONLY(truncate64)
@@ -204,7 +204,7 @@ SYSX(sys_ni_syscall,sys_fstat64,sys_fstat64)
 SYSCALL(pciconfig_read)
 SYSCALL(pciconfig_write)
 SYSCALL(pciconfig_iobase)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 SYSCALL_SPU(getdents64)
 SYSCALL_SPU(pivot_root)
 SYSX(sys_ni_syscall,compat_sys_fcntl64,sys_fcntl64)
@@ -227,8 +227,8 @@ SYSCALL_SPU(fremovexattr)
 COMPAT_SYS_SPU(futex)
 COMPAT_SYS_SPU(sched_setaffinity)
 COMPAT_SYS_SPU(sched_getaffinity)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
+SYSCALL_NI
+SYSCALL_NI
 SYS32ONLY(sendfile64)
 COMPAT_SYS_SPU(io_setup)
 SYSCALL_SPU(io_destroy)
@@ -260,7 +260,7 @@ COMPAT_SYS_SPU(fstatfs64)
 SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
 PPC_SYS_SPU(rtas)
 OLDSYS(debug_setcontext)
-SYSCALL(ni_syscall)
+SYSCALL_NI
 COMPAT_SYS(migrate_pages)
 COMPAT_SYS(mbind)
 COMPAT_SYS(get_mempolicy)
-- 
1.5.3.7

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
