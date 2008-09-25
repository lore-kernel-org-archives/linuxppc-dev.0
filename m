Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 29877DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 17:02:02 +1000 (EST)
Subject: [RFC/PATCH] powerpc: Cleanup 32/64 bit syscall int sign ext.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Thu, 25 Sep 2008 17:01:36 +1000
Message-Id: <1222326096.8277.178.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I noticed that our ABI says callers are responsible for sign extending.
That means that all int, long or similarly signed arguments to syscalls
must be explicitly sign-extended.

We already have wrappers to do that for -some- syscalls in arch code.
Those are in C and pretty ugly, copy/pasting a bunch of identically
useless comments all over, and are missing a lot of potential
candidates.

sparc64 uses a nicer macro system to generate trampolines in asm. It
also has a more complete list. But it's also missing some :-)

Now, there is a good point to be made that we don't absolutely need to
always sign extend. In many cases, the called function will just do a
cmplw for example, or an and to test bits in flags, and so it looks like
sign extension is not necessary. One could say that sign extending file
descriptors for example isn't terribly useful

But that sounds like a fragile approach to me. We don't know for sure
what new tricks the compiler will learn for example. In fact, when
taking the sparc64 list, I noticed that in some cases it -did- already
sign extend file descriptors and flags .. and in some cases not.

So I've spent a few hours combing through all of syscalls.h (and one
more that seems to be missing from this file, ie, pipe2, there may be
others) for anything using int, long or pid_t (which is signed, at least
on our 32-bit platforms).

I've then removed our old wrappers, created a new mechanism, totally
untested btw, based on the sparc64 one (the idea is that we might be
able to use a common table, at least for the bulk of the syscalls), and
I've left in there a bunch of comments about what I found possibly
missing in the sparc64 table which I added, where there are differences
that warrant different bits, etc...).

It's by no mean a final patch. It's for opening the discussion, and
possibly for David to get a chance to update his table if he feels like
it :-)

Cheers,
Ben.

Index: linux-work/arch/powerpc/include/asm/systbl.h
===================================================================
--- linux-work.orig/arch/powerpc/include/asm/systbl.h	2008-09-25 13:38:28.000000000 +1000
+++ linux-work/arch/powerpc/include/asm/systbl.h	2008-09-25 16:50:18.000000000 +1000
@@ -4,25 +4,25 @@
  */
 
 SYSCALL(restart_syscall)
-SYSCALL(exit)
+SYS32_SYS(exit)
 PPC_SYS(fork)
 SYSCALL_SPU(read)
 SYSCALL_SPU(write)
-COMPAT_SYS_SPU(open)
+SYS32_SYS_SPU(open)
 SYSCALL_SPU(close)
-COMPAT_SYS_SPU(waitpid)
-COMPAT_SYS_SPU(creat)
+SYS32_SYS_SPU(waitpid)
+SYS32_SYS_SPU(creat)
 SYSCALL_SPU(link)
 SYSCALL_SPU(unlink)
 COMPAT_SYS(execve)
 SYSCALL_SPU(chdir)
 COMPAT_SYS_SPU(time)
-SYSCALL_SPU(mknod)
+SYS32_SYS_SPU(mknod)
 SYSCALL_SPU(chmod)
 SYSCALL_SPU(lchown)
 SYSCALL(ni_syscall)
 OLDSYS(stat)
-SYSX_SPU(sys_lseek,ppc32_lseek,sys_lseek)
+SYS32_SYS_SPU(lseek)
 SYSCALL_SPU(getpid)
 COMPAT_SYS(mount)
 SYSX(sys_ni_syscall,sys_oldumount,sys_oldumount)
@@ -36,13 +36,13 @@ COMPAT_SYS(pause)
 COMPAT_SYS(utime)
 SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
-COMPAT_SYS_SPU(access)
-COMPAT_SYS_SPU(nice)
+SYS32_SYS_SPU(access)
+SYS32_SYS_SPU(nice)
 SYSCALL(ni_syscall)
 SYSCALL_SPU(sync)
-COMPAT_SYS_SPU(kill)
+SYS32_SYS_SPU(kill)
 SYSCALL_SPU(rename)
-COMPAT_SYS_SPU(mkdir)
+SYS32_SYS_SPU(mkdir)
 SYSCALL_SPU(rmdir)
 SYSCALL_SPU(dup)
 SYSCALL_SPU(pipe)
@@ -51,47 +51,47 @@ SYSCALL(ni_syscall)
 SYSCALL_SPU(brk)
 SYSCALL_SPU(setgid)
 SYSCALL_SPU(getgid)
-SYSCALL(signal)
+SYS32_SYS(signal)
 SYSCALL_SPU(geteuid)
 SYSCALL_SPU(getegid)
 SYSCALL(acct)
-SYSCALL(umount)
+SYS32_SYS(umount)
 SYSCALL(ni_syscall)
 COMPAT_SYS_SPU(ioctl)
 COMPAT_SYS_SPU(fcntl)
 SYSCALL(ni_syscall)
-COMPAT_SYS_SPU(setpgid)
+SYS32_SYS_SPU(setpgid)
 SYSCALL(ni_syscall)
 SYSX(sys_ni_syscall,sys_olduname, sys_olduname)
-COMPAT_SYS_SPU(umask)
+SYS32_SYS_SPU(umask)
 SYSCALL_SPU(chroot)
 SYSCALL(ustat)
 SYSCALL_SPU(dup2)
 SYSCALL_SPU(getppid)
 SYSCALL_SPU(getpgrp)
 SYSCALL_SPU(setsid)
-SYS32ONLY(sigaction)
+SYSX(sys_ni_syscall,sys32_sigaction,sys_sigaction)
 SYSCALL_SPU(sgetmask)
-COMPAT_SYS_SPU(ssetmask)
+SYS32_SYS_SPU(ssetmask)
 SYSCALL_SPU(setreuid)
 SYSCALL_SPU(setregid)
 SYS32ONLY(sigsuspend)
 COMPAT_SYS(sigpending)
-COMPAT_SYS_SPU(sethostname)
+SYS32_SYS_SPU(sethostname)
 COMPAT_SYS_SPU(setrlimit)
 COMPAT_SYS(old_getrlimit)
-COMPAT_SYS_SPU(getrusage)
+SYS32_SYS_SPU(getrusage)
 COMPAT_SYS_SPU(gettimeofday)
 COMPAT_SYS_SPU(settimeofday)
-COMPAT_SYS_SPU(getgroups)
-COMPAT_SYS_SPU(setgroups)
+SYS32_SYS_SPU(getgroups)
+SYS32_SYS_SPU(setgroups)
 SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
 SYSCALL_SPU(symlink)
 OLDSYS(lstat)
-COMPAT_SYS_SPU(readlink)
+SYS32_SYS_SPU(readlink)
 SYSCALL(uselib)
-SYSCALL(swapon)
-SYSCALL(reboot)
+SYS32_SYS(swapon)
+SYS32_SYS(reboot)
 SYSX(sys_ni_syscall,compat_sys_old_readdir,old_readdir)
 SYSCALL_SPU(mmap)
 SYSCALL_SPU(munmap)
@@ -99,16 +99,16 @@ SYSCALL_SPU(truncate)
 SYSCALL_SPU(ftruncate)
 SYSCALL_SPU(fchmod)
 SYSCALL_SPU(fchown)
-COMPAT_SYS_SPU(getpriority)
-COMPAT_SYS_SPU(setpriority)
+SYS32_SYS_SPU(getpriority)
+SYS32_SYS_SPU(setpriority)
 SYSCALL(ni_syscall)
 COMPAT_SYS(statfs)
 COMPAT_SYS(fstatfs)
 SYSCALL(ni_syscall)
 COMPAT_SYS_SPU(socketcall)
-COMPAT_SYS_SPU(syslog)
-COMPAT_SYS_SPU(setitimer)
-COMPAT_SYS_SPU(getitimer)
+SYS32_SYS_SPU(syslog)
+SYS32_SYS_SPU(setitimer)
+SYS32_SYS_SPU(getitimer)
 COMPAT_SYS_SPU(newstat)
 COMPAT_SYS_SPU(newlstat)
 COMPAT_SYS_SPU(newfstat)
@@ -117,70 +117,70 @@ SYSCALL(ni_syscall)
 SYSCALL_SPU(vhangup)
 SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
-COMPAT_SYS_SPU(wait4)
+SYS32_SYS_SPU(wait4)
 SYSCALL(swapoff)
 COMPAT_SYS_SPU(sysinfo)
 COMPAT_SYS(ipc)
 SYSCALL_SPU(fsync)
 SYS32ONLY(sigreturn)
 PPC_SYS(clone)
-COMPAT_SYS_SPU(setdomainname)
+SYS32_SYS_SPU(setdomainname)
 PPC_SYS_SPU(newuname)
 SYSCALL(ni_syscall)
 COMPAT_SYS_SPU(adjtimex)
 SYSCALL_SPU(mprotect)
-SYSX(sys_ni_syscall,compat_sys_sigprocmask,sys_sigprocmask)
+SYSX(sys_ni_syscall,sys32_sigprocmask,sys_sigprocmask)
 SYSCALL(ni_syscall)
 SYSCALL(init_module)
 SYSCALL(delete_module)
 SYSCALL(ni_syscall)
 SYSCALL(quotactl)
-COMPAT_SYS_SPU(getpgid)
+SYS32_SYS_SPU(getpgid)
 SYSCALL_SPU(fchdir)
-SYSCALL_SPU(bdflush)
-COMPAT_SYS(sysfs)
+SYS32_SYS_SPU(bdflush)
+SYS32_SYS(sysfs)
 SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)
 SYSCALL(ni_syscall)
 SYSCALL_SPU(setfsuid)
 SYSCALL_SPU(setfsgid)
 SYSCALL_SPU(llseek)
 COMPAT_SYS_SPU(getdents)
-SYSX_SPU(sys_select,ppc32_select,ppc_select)
+SYSX_SPU(sys_select,sys32_select,ppc_select)
 SYSCALL_SPU(flock)
-SYSCALL_SPU(msync)
+SYS32_SYS_SPU(msync)
 COMPAT_SYS_SPU(readv)
 COMPAT_SYS_SPU(writev)
-COMPAT_SYS_SPU(getsid)
+SYS32_SYS_SPU(getsid)
 SYSCALL_SPU(fdatasync)
 COMPAT_SYS(sysctl)
 SYSCALL_SPU(mlock)
 SYSCALL_SPU(munlock)
-SYSCALL_SPU(mlockall)
+SYS32_SYS_SPU(mlockall)
 SYSCALL_SPU(munlockall)
-COMPAT_SYS_SPU(sched_setparam)
-COMPAT_SYS_SPU(sched_getparam)
-COMPAT_SYS_SPU(sched_setscheduler)
-COMPAT_SYS_SPU(sched_getscheduler)
+SYS32_SYS_SPU(sched_setparam)
+SYS32_SYS_SPU(sched_getparam)
+SYS32_SYS_SPU(sched_setscheduler)
+SYS32_SYS_SPU(sched_getscheduler)
 SYSCALL_SPU(sched_yield)
-COMPAT_SYS_SPU(sched_get_priority_max)
-COMPAT_SYS_SPU(sched_get_priority_min)
-COMPAT_SYS_SPU(sched_rr_get_interval)
+SYS32_SYS_SPU(sched_get_priority_max)
+SYS32_SYS_SPU(sched_get_priority_min)
+COMPAT_SYS_SPU(sched_rr_get_interval) /* XXX */
 COMPAT_SYS_SPU(nanosleep)
 SYSCALL_SPU(mremap)
 SYSCALL_SPU(setresuid)
 SYSCALL_SPU(getresuid)
 SYSCALL(ni_syscall)
-SYSCALL_SPU(poll)
-COMPAT_SYS(nfsservctl)
+SYS32_SYS_SPU(poll)
+SYS32_SYS(nfsservctl)
 SYSCALL_SPU(setresgid)
 SYSCALL_SPU(getresgid)
-COMPAT_SYS_SPU(prctl)
+SYS32_SYS_SPU(prctl)
 COMPAT_SYS(rt_sigreturn)
-COMPAT_SYS(rt_sigaction)
-COMPAT_SYS(rt_sigprocmask)
+SYS32_SYS(rt_sigaction)
+SYS32_SYS(rt_sigprocmask)
 COMPAT_SYS(rt_sigpending)
 COMPAT_SYS(rt_sigtimedwait)
-COMPAT_SYS(rt_sigqueueinfo)
+SYS32_SYS(rt_sigqueueinfo)
 COMPAT_SYS(rt_sigsuspend)
 COMPAT_SYS_SPU(pread64)
 COMPAT_SYS_SPU(pwrite64)
@@ -194,7 +194,7 @@ SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
 PPC_SYS(vfork)
 COMPAT_SYS_SPU(getrlimit)
-COMPAT_SYS_SPU(readahead)
+SYS32_SYS_SPU(readahead)
 SYS32ONLY(mmap2)
 SYS32ONLY(truncate64)
 SYS32ONLY(ftruncate64)
@@ -211,61 +211,61 @@ SYSX(sys_ni_syscall,compat_sys_fcntl64,s
 SYSCALL_SPU(madvise)
 SYSCALL_SPU(mincore)
 SYSCALL_SPU(gettid)
-SYSCALL_SPU(tkill)
-SYSCALL_SPU(setxattr)
-SYSCALL_SPU(lsetxattr)
-SYSCALL_SPU(fsetxattr)
+SYS32_SYS_SPU(tkill)
+SYS32_SYS_SPU(setxattr)
+SYS32_SYS_SPU(lsetxattr)
+SYS32_SYS_SPU(fsetxattr)
 SYSCALL_SPU(getxattr)
 SYSCALL_SPU(lgetxattr)
-SYSCALL_SPU(fgetxattr)
+SYS32_SYS_SPU(fgetxattr)
 SYSCALL_SPU(listxattr)
 SYSCALL_SPU(llistxattr)
-SYSCALL_SPU(flistxattr)
+SYS32_SYS_SPU(flistxattr)
 SYSCALL_SPU(removexattr)
 SYSCALL_SPU(lremovexattr)
-SYSCALL_SPU(fremovexattr)
-COMPAT_SYS_SPU(futex)
-COMPAT_SYS_SPU(sched_setaffinity)
-COMPAT_SYS_SPU(sched_getaffinity)
+SYS32_SYS_SPU(fremovexattr)
+SYS32_SYS_SPU(futex)
+SYS32_SYS_SPU(sched_setaffinity)
+SYS32_SYS_SPU(sched_getaffinity)
 SYSCALL(ni_syscall)
 SYSCALL(ni_syscall)
 SYS32ONLY(sendfile64)
 COMPAT_SYS_SPU(io_setup)
 SYSCALL_SPU(io_destroy)
 COMPAT_SYS_SPU(io_getevents)
-COMPAT_SYS_SPU(io_submit)
+SYS32_SYS_SPU(io_submit)
 SYSCALL_SPU(io_cancel)
 SYSCALL(set_tid_address)
 SYSX_SPU(sys_fadvise64,ppc32_fadvise64,sys_fadvise64)
-SYSCALL(exit_group)
+SYS32_SYS(exit_group)
 SYSX(sys_lookup_dcookie,ppc32_lookup_dcookie,sys_lookup_dcookie)
-SYSCALL_SPU(epoll_create)
-SYSCALL_SPU(epoll_ctl)
-SYSCALL_SPU(epoll_wait)
+SYS32_SYS_SPU(epoll_create)
+SYS32_SYS_SPU(epoll_ctl)
+SYS32_SYS_SPU(epoll_wait)
 SYSCALL_SPU(remap_file_pages)
 SYSX_SPU(sys_timer_create,compat_sys_timer_create,sys_timer_create)
-COMPAT_SYS_SPU(timer_settime)
+SYS32_SYS_SPU(timer_settime)
 COMPAT_SYS_SPU(timer_gettime)
 SYSCALL_SPU(timer_getoverrun)
 SYSCALL_SPU(timer_delete)
 COMPAT_SYS_SPU(clock_settime)
 COMPAT_SYS_SPU(clock_gettime)
 COMPAT_SYS_SPU(clock_getres)
-COMPAT_SYS_SPU(clock_nanosleep)
+SYS32_SYS_SPU(clock_nanosleep)
 SYSX(ppc64_swapcontext,ppc32_swapcontext,ppc_swapcontext)
-COMPAT_SYS_SPU(tgkill)
+SYS32_SYS_SPU(tgkill)
 COMPAT_SYS_SPU(utimes)
 COMPAT_SYS_SPU(statfs64)
 COMPAT_SYS_SPU(fstatfs64)
-SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
+SYSX(sys_ni_syscall, sys32_fadvise64_64, ppc_fadvise64_64)
 PPC_SYS_SPU(rtas)
 OLDSYS(debug_setcontext)
 SYSCALL(ni_syscall)
-COMPAT_SYS(migrate_pages)
+SYS32_SYS(migrate_pages)
 COMPAT_SYS(mbind)
 COMPAT_SYS(get_mempolicy)
-COMPAT_SYS(set_mempolicy)
-COMPAT_SYS(mq_open)
+SYS32_SYS(set_mempolicy)
+SYS32_SYS(mq_open)
 SYSCALL(mq_unlink)
 COMPAT_SYS(mq_timedsend)
 COMPAT_SYS(mq_timedreceive)
@@ -275,50 +275,50 @@ COMPAT_SYS(kexec_load)
 COMPAT_SYS(add_key)
 COMPAT_SYS(request_key)
 COMPAT_SYS(keyctl)
-COMPAT_SYS(waitid)
-COMPAT_SYS(ioprio_set)
-COMPAT_SYS(ioprio_get)
+SYS32_SYS(waitid)
+SYS32_SYS(ioprio_set)
+SYS32_SYS(ioprio_get)
 SYSCALL(inotify_init)
-SYSCALL(inotify_add_watch)
-SYSCALL(inotify_rm_watch)
-SYSCALL(spu_run)
-SYSCALL(spu_create)
+SYS32_SYS(inotify_add_watch)
+SYS32_SYS(inotify_rm_watch)
+SYS32_SYS(spu_run)
+SYS32_SYS(spu_create)
 COMPAT_SYS(pselect6)
 COMPAT_SYS(ppoll)
 SYSCALL_SPU(unshare)
-SYSCALL_SPU(splice)
-SYSCALL_SPU(tee)
-COMPAT_SYS_SPU(vmsplice)
+SYS32_SYS_SPU(splice)
+SYS32_SYS_SPU(tee)
+SYS32_SYS_SPU(vmsplice)
 COMPAT_SYS_SPU(openat)
 SYSCALL_SPU(mkdirat)
-SYSCALL_SPU(mknodat)
-SYSCALL_SPU(fchownat)
+SYS32_SYS_SPU(mknodat)
+SYS32_SYS_SPU(fchownat)
 COMPAT_SYS_SPU(futimesat)
-SYSX_SPU(sys_newfstatat, sys_fstatat64, sys_fstatat64)
-SYSCALL_SPU(unlinkat)
-SYSCALL_SPU(renameat)
-SYSCALL_SPU(linkat)
-SYSCALL_SPU(symlinkat)
-SYSCALL_SPU(readlinkat)
-SYSCALL_SPU(fchmodat)
-SYSCALL_SPU(faccessat)
-COMPAT_SYS_SPU(get_robust_list)
+SYSX_SPU(sys_newfstatat, sys32_fstatat64, sys32_fstatat64)
+SYS32_SYS_SPU(unlinkat)
+SYS32_SYS_SPU(renameat)
+SYS32_SYS_SPU(linkat)
+SYS32_SYS_SPU(symlinkat)
+SYS32_SYS_SPU(readlinkat)
+SYS32_SYS_SPU(fchmodat)
+SYS32_SYS_SPU(faccessat)
+SYS32_SYS_SPU(get_robust_list)
 COMPAT_SYS_SPU(set_robust_list)
-COMPAT_SYS_SPU(move_pages)
+SYS32_SYS_SPU(move_pages)
 SYSCALL_SPU(getcpu)
-COMPAT_SYS(epoll_pwait)
+SYS32_SYS(epoll_pwait)
 COMPAT_SYS_SPU(utimensat)
-COMPAT_SYS_SPU(signalfd)
-SYSCALL_SPU(timerfd_create)
+SYS32_SYS_SPU(signalfd)
+SYS32_SYS_SPU(timerfd_create)
 SYSCALL_SPU(eventfd)
 COMPAT_SYS_SPU(sync_file_range2)
-COMPAT_SYS(fallocate)
+SYS32_SYS(fallocate)
 SYSCALL(subpage_prot)
 COMPAT_SYS_SPU(timerfd_settime)
 COMPAT_SYS_SPU(timerfd_gettime)
-COMPAT_SYS_SPU(signalfd4)
-SYSCALL_SPU(eventfd2)
-SYSCALL_SPU(epoll_create1)
-SYSCALL_SPU(dup3)
-SYSCALL_SPU(pipe2)
-SYSCALL(inotify_init1)
+SYS32_SYS_SPU(signalfd4)
+SYS32_SYS_SPU(eventfd2)
+SYS32_SYS_SPU(epoll_create1)
+SYS32_SYS_SPU(dup3)
+SYS32_SYS_SPU(pipe2)
+SYS32_SYS(inotify_init1)
Index: linux-work/arch/powerpc/kernel/Makefile
===================================================================
--- linux-work.orig/arch/powerpc/kernel/Makefile	2008-09-25 13:23:15.000000000 +1000
+++ linux-work/arch/powerpc/kernel/Makefile	2008-09-25 13:23:27.000000000 +1000
@@ -30,7 +30,7 @@ obj-y				:= cputable.o ptrace.o syscalls
 				   init_task.o process.o systbl.o idle.o \
 				   signal.o
 obj-y				+= vdso32/
-obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
+obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o sys_simple32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_ppc970.o \
 				   cpu_setup_pa6t.o \
Index: linux-work/arch/powerpc/kernel/sys_ppc32.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/sys_ppc32.c	2008-09-25 14:27:22.000000000 +1000
+++ linux-work/arch/powerpc/kernel/sys_ppc32.c	2008-09-25 14:54:34.000000000 +1000
@@ -89,16 +89,6 @@ int cp_compat_stat(struct kstat *stat, s
 	return err;
 }
 
-/* Note: it is necessary to treat option as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sysfs(u32 option, u32 arg1, u32 arg2)
-{
-	return sys_sysfs((int)option, arg1, arg2);
-}
-
 asmlinkage long compat_sys_pause(void)
 {
 	current->state = TASK_INTERRUPTIBLE;
@@ -129,8 +119,6 @@ static inline long put_tv32(struct compa
 }
 
 
-
-
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 extern struct timezone sys_tz;
@@ -152,7 +140,6 @@ asmlinkage long compat_sys_gettimeofday(
 }
 
 
-
 asmlinkage long compat_sys_settimeofday(struct compat_timeval __user *tv, struct timezone __user *tz)
 {
 	struct timespec kts;
@@ -308,19 +295,6 @@ out:
 	return error;
 }
 
-/* Note: it is necessary to treat option as an unsigned int, 
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_prctl(u32 option, u32 arg2, u32 arg3, u32 arg4, u32 arg5)
-{
-	return sys_prctl((int)option,
-			 (unsigned long) arg2,
-			 (unsigned long) arg3,
-			 (unsigned long) arg4,
-			 (unsigned long) arg5);
-}
 
 /* Note: it is necessary to treat pid as an unsigned int, 
  * with the corresponding cast to a signed int to insure that the 
@@ -342,271 +316,6 @@ asmlinkage long compat_sys_sched_rr_get_
 	return ret;
 }
 
-/* Note: it is necessary to treat mode as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_access(const char __user * filename, u32 mode)
-{
-	return sys_access(filename, (int)mode);
-}
-
-
-/* Note: it is necessary to treat mode as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_creat(const char __user * pathname, u32 mode)
-{
-	return sys_creat(pathname, (int)mode);
-}
-
-
-/* Note: it is necessary to treat pid and options as unsigned ints,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_waitpid(u32 pid, unsigned int __user * stat_addr, u32 options)
-{
-	return sys_waitpid((int)pid, stat_addr, (int)options);
-}
-
-
-/* Note: it is necessary to treat gidsetsize as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_getgroups(u32 gidsetsize, gid_t __user *grouplist)
-{
-	return sys_getgroups((int)gidsetsize, grouplist);
-}
-
-
-/* Note: it is necessary to treat pid as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_getpgid(u32 pid)
-{
-	return sys_getpgid((int)pid);
-}
-
-
-
-/* Note: it is necessary to treat pid as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_getsid(u32 pid)
-{
-	return sys_getsid((int)pid);
-}
-
-
-/* Note: it is necessary to treat pid and sig as unsigned ints,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_kill(u32 pid, u32 sig)
-{
-	return sys_kill((int)pid, (int)sig);
-}
-
-
-/* Note: it is necessary to treat mode as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_mkdir(const char __user * pathname, u32 mode)
-{
-	return sys_mkdir(pathname, (int)mode);
-}
-
-long compat_sys_nice(u32 increment)
-{
-	/* sign extend increment */
-	return sys_nice((int)increment);
-}
-
-off_t ppc32_lseek(unsigned int fd, u32 offset, unsigned int origin)
-{
-	/* sign extend n */
-	return sys_lseek(fd, (int)offset, origin);
-}
-
-/* Note: it is necessary to treat bufsiz as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_readlink(const char __user * path, char __user * buf, u32 bufsiz)
-{
-	return sys_readlink(path, buf, (int)bufsiz);
-}
-
-/* Note: it is necessary to treat option as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sched_get_priority_max(u32 policy)
-{
-	return sys_sched_get_priority_max((int)policy);
-}
-
-
-/* Note: it is necessary to treat policy as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sched_get_priority_min(u32 policy)
-{
-	return sys_sched_get_priority_min((int)policy);
-}
-
-
-/* Note: it is necessary to treat pid as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sched_getparam(u32 pid, struct sched_param __user *param)
-{
-	return sys_sched_getparam((int)pid, param);
-}
-
-
-/* Note: it is necessary to treat pid as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sched_getscheduler(u32 pid)
-{
-	return sys_sched_getscheduler((int)pid);
-}
-
-
-/* Note: it is necessary to treat pid as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sched_setparam(u32 pid, struct sched_param __user *param)
-{
-	return sys_sched_setparam((int)pid, param);
-}
-
-
-/* Note: it is necessary to treat pid and policy as unsigned ints,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_sched_setscheduler(u32 pid, u32 policy, struct sched_param __user *param)
-{
-	return sys_sched_setscheduler((int)pid, (int)policy, param);
-}
-
-
-/* Note: it is necessary to treat len as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_setdomainname(char __user *name, u32 len)
-{
-	return sys_setdomainname(name, (int)len);
-}
-
-
-/* Note: it is necessary to treat gidsetsize as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_setgroups(u32 gidsetsize, gid_t __user *grouplist)
-{
-	return sys_setgroups((int)gidsetsize, grouplist);
-}
-
-
-asmlinkage long compat_sys_sethostname(char __user *name, u32 len)
-{
-	/* sign extend len */
-	return sys_sethostname(name, (int)len);
-}
-
-
-/* Note: it is necessary to treat pid and pgid as unsigned ints,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_setpgid(u32 pid, u32 pgid)
-{
-	return sys_setpgid((int)pid, (int)pgid);
-}
-
-long compat_sys_getpriority(u32 which, u32 who)
-{
-	/* sign extend which and who */
-	return sys_getpriority((int)which, (int)who);
-}
-
-long compat_sys_setpriority(u32 which, u32 who, u32 niceval)
-{
-	/* sign extend which, who and niceval */
-	return sys_setpriority((int)which, (int)who, (int)niceval);
-}
-
-long compat_sys_ioprio_get(u32 which, u32 who)
-{
-	/* sign extend which and who */
-	return sys_ioprio_get((int)which, (int)who);
-}
-
-long compat_sys_ioprio_set(u32 which, u32 who, u32 ioprio)
-{
-	/* sign extend which, who and ioprio */
-	return sys_ioprio_set((int)which, (int)who, (int)ioprio);
-}
-
-/* Note: it is necessary to treat newmask as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_ssetmask(u32 newmask)
-{
-	return sys_ssetmask((int) newmask);
-}
-
-asmlinkage long compat_sys_syslog(u32 type, char __user * buf, u32 len)
-{
-	/* sign extend len */
-	return sys_syslog(type, buf, (int)len);
-}
-
-
-/* Note: it is necessary to treat mask as an unsigned int,
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-asmlinkage long compat_sys_umask(u32 mask)
-{
-	return sys_umask((int)mask);
-}
 
 #ifdef CONFIG_SYSCTL_SYSCALL
 struct __sysctl_args32 {
@@ -668,12 +377,6 @@ unsigned long compat_sys_mmap2(unsigned 
 	return sys_mmap(addr, len, prot, flags, fd, pgoff << 12);
 }
 
-long compat_sys_tgkill(u32 tgid, u32 pid, int sig)
-{
-	/* sign extend tgid, pid */
-	return sys_tgkill((int)tgid, (int)pid, sig);
-}
-
 /* 
  * long long munging:
  * The 32 bit ABI passes long longs in an odd even register pair.
Index: linux-work/arch/powerpc/kernel/sys_simple32.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-work/arch/powerpc/kernel/sys_simple32.S	2008-09-25 16:51:04.000000000 +1000
@@ -0,0 +1,205 @@
+#include <linux/errno.h>
+#include <asm/ppc_asm.h>
+
+	.section	".text"
+	.align 7
+
+#define ARG0	r3
+#define ARG1	r4
+#define ARG2	r5
+#define ARG3	r6
+#define ARG4	r7
+#define ARG5	r7
+
+#define XGLUE(a,b) a##b
+#define GLUE(a,b) XGLUE(a,b)
+
+#define SIGN1(stub,syscall,reg1)		\
+	_GLOBAL(sys32_##stub)			\
+	extsw	reg1,reg1;			\
+	b	.##syscall;
+
+#define SIGN2(stub,syscall,reg1,reg2)		\
+	_GLOBAL(sys32_##stub)			\
+	extsw	reg1,reg1;			\
+	extsw	reg2,reg2;			\
+	b	.##syscall;
+
+#define SIGN3(stub,syscall,reg1,reg2,reg3)	\
+	_GLOBAL(sys32_##stub)			\
+	extsw	reg1,reg1;			\
+	extsw	reg2,reg2;			\
+	extsw	reg3,reg3;			\
+	b	.##syscall;
+
+#define SIGN4(stub,syscall,reg1,reg2,reg3,reg4)	\
+	_GLOBAL(sys32_##stub)			\
+	extsw	reg1,reg1;			\
+	extsw	reg2,reg2;			\
+	extsw	reg3,reg3;			\
+	extsw	reg4,reg4;			\
+	b	.##syscall;
+
+SIGN1(exit,sys_exit,ARG0)
+SIGN1(exit_group,sys_exit,ARG0)
+SIGN2(wait4,compat_sys_wait4,ARG0,ARG2) /* sparc missing ARG0 */
+SIGN1(creat,sys_creat,ARG1)
+SIGN1(mknod,sys_mknod,ARG1)
+SIGN1(umount,sys_umount,ARG1)
+SIGN1(signal,sys_signal,ARG0)
+SIGN1(access,sys_access,ARG1)
+SIGN1(msync,sys_msync,ARG2)
+SIGN2(reboot,sys_reboot,ARG0,ARG1)
+SIGN1(setitimer,compat_sys_setitimer,ARG0)
+SIGN1(getitimer,compat_sys_getitimer,ARG0)
+SIGN1(sethostname,sys_sethostname,ARG1)
+SIGN1(swapon,sys_swapon,ARG1)
+SIGN1(sigaction,compat_sys_sigaction,ARG0)
+SIGN1(rt_sigaction,compat_sys_rt_sigaction,ARG0)
+SIGN1(sigprocmask,compat_sys_sigprocmask,ARG0)
+SIGN1(rt_sigprocmask,compat_sys_rt_sigprocmask,ARG0)
+SIGN2(rt_sigqueueinfo,compat_sys_rt_sigqueueinfo,ARG0,ARG1)
+SIGN1(getrusage,compat_sys_getrusage,ARG0)
+SIGN1(setxattr,sys_setxattr,ARG4)
+SIGN1(lsetxattr,sys_lsetxattr,ARG4)
+SIGN1(fsetxattr,sys_fsetxattr,ARG4)
+SIGN1(fgetxattr,sys_fgetxattr,ARG0)
+SIGN1(flistxattr,sys_flistxattr,ARG0)
+SIGN1(fremovexattr,sys_fremovexattr,ARG0)
+SIGN2(tkill,sys_tkill,ARG0,ARG1)
+SIGN1(epoll_create,sys_epoll_create,ARG0)
+SIGN3(epoll_ctl,sys_epoll_ctl,ARG0,ARG1,ARG2)
+SIGN3(epoll_wait,sys_epoll_wait,ARG0,ARG2,ARG3)
+SIGN1(readahead,compat_sys_readahead,ARG0)
+SIGN2(fadvise64,ppc32_fadvise64,ARG0,ARG5)	/* (1) */
+SIGN2(fadvise64_64,ppc_fadvise64_64,ARG0,ARG1)	/* (1) */
+SIGN2(bdflush,sys_bdflush,ARG0,ARG1)
+SIGN1(mlockall,sys_mlockall,ARG0)
+SIGN1(nfsservctl,compat_sys_nfsservctl,ARG0)
+SIGN1(clock_nanosleep,compat_sys_clock_nanosleep,ARG1)
+SIGN1(timer_settime,compat_sys_timer_settime,ARG1)
+SIGN1(io_submit,compat_sys_io_submit,ARG1)
+SIGN1(mq_open,compat_sys_mq_open,ARG1)
+SIGN1(select,compat_sys_select,ARG0)
+SIGN1(mkdir,sys_mkdir,ARG1)
+SIGN1(futex,compat_sys_futex,ARG1)	/* sparc has spurrious ARG2 and 5 */
+SIGN1(sysfs,sys_sysfs,ARG0)		/* sparc weirdo useless wrapper */
+/* We have our own sendfile wrappers in C that do sign too,
+ * FIXME: create generic compat_* variants, everybody seem to have the same
+ * SIGN2(sendfile,compat_sys_sendfile,ARG0,ARG1) */
+/* SIGN2(sendfile64,compat_sys_sendfile64,ARG0,ARG1) */
+SIGN1(prctl,sys_prctl,ARG0)
+/* SIGN1(sched_rr_get_interval,compat_sys_sched_rr_get_interval,ARG0) */
+SIGN2(waitpid,sys_waitpid,ARG0,ARG2)
+SIGN1(getgroups,sys_getgroups,ARG0)
+SIGN1(getpgid,sys_getpgid,ARG0)
+SIGN2(getpriority,sys_getpriority,ARG0,ARG1)
+SIGN1(getsid,sys_getsid,ARG0)
+SIGN2(kill,sys_kill,ARG0,ARG1)
+SIGN1(nice,sys_nice,ARG0)
+SIGN1(lseek,sys_lseek,ARG1)
+SIGN2(open,sys_open,ARG1,ARG2)
+SIGN1(readlink,sys_readlink,ARG2)
+SIGN1(sched_get_priority_max,sys_sched_get_priority_max,ARG0)
+SIGN1(sched_get_priority_min,sys_sched_get_priority_min,ARG0)
+SIGN1(sched_getparam,sys_sched_getparam,ARG0)
+SIGN1(sched_getscheduler,sys_sched_getscheduler,ARG0)
+SIGN1(sched_setparam,sys_sched_setparam,ARG0)
+SIGN2(sched_setscheduler,sys_sched_setscheduler,ARG0,ARG1)
+SIGN1(setdomainname,sys_setdomainname,ARG1)
+SIGN1(setgroups,sys_setgroups,ARG0)
+SIGN2(setpgid,sys_setpgid,ARG0,ARG1)
+SIGN3(setpriority,sys_setpriority,ARG0,ARG1,ARG2)
+SIGN1(ssetmask,sys_ssetmask,ARG0)
+SIGN2(syslog,sys_syslog,ARG0,ARG2)
+SIGN1(umask,sys_umask,ARG0)
+SIGN3(tgkill,sys_tgkill,ARG0,ARG1,ARG2)
+SIGN1(socketcall,compat_sys_socketcall,ARG0)
+SIGN2(ioprio_get,sys_ioprio_get,ARG0,ARG1)
+SIGN3(ioprio_set,sys_ioprio_set,ARG0,ARG1,ARG2)
+SIGN2(splice,sys_splice,ARG0,ARG1)
+SIGN1(sync_file_range2,sys_sync_file_range2,ARG0)
+SIGN2(tee,sys_tee,ARG0,ARG1)
+SIGN1(vmsplice,compat_sys_vmsplice,ARG0)
+
+/* Not on sparc or ppc so far ... */
+SIGN3(waitid,compat_sys_waitid,ARG0,ARG1,ARG3)
+SIGN1(sched_setaffinity,compat_sys_sched_setaffinity,ARG0)
+SIGN1(sched_getaffinity,compat_sys_sched_getaffinity,ARG0)
+SIGN1(madvise,sys_madvise,ARG2)
+SIGN1(dup3,sys_dup3,ARG2)
+SIGN1(poll,sys_poll,ARG2) /* (2) */
+SIGN1(epoll_create1,sys_epoll_create1,ARG0)
+SIGN3(epoll_pwait,compat_sys_epoll_pwait,ARG0,ARG2,ARG3)
+SIGN4(ptrace,compat_sys_ptrace,ARG0,ARG1,ARG2,ARG3)
+SIGN1(set_mempolicy,compat_sys_set_mempolicy,ARG0)
+SIGN1(migrate_pages,compat_sys_migrate_pages,ARG0)
+SIGN2(move_pages,compat_sys_move_pages,ARG0,ARG5)
+SIGN1(inotify_init1,sys_inotify_init1,ARG0)
+SIGN1(inotify_add_watch,sys_inotify_add_watch,ARG0)
+SIGN1(inotify_rm_watch,inotify_rm_watch,ARG0)
+SIGN2(mknodat,sys_mknodat,ARG0,ARG2)
+SIGN2(mkdirat,sys_mkdirat,ARG0,ARG2)
+SIGN2(unlinkat,sys_unlinkat,ARG0,ARG2)
+SIGN1(symlinkat,sys_symlinkat,ARG1)
+SIGN3(linkat,sys_linkat,ARG0,ARG2,ARG4)
+SIGN2(renameat,sys_renameat,ARG0,ARG1)
+SIGN2(faccessat,sys_faccessat,ARG0,ARG2)
+SIGN2(fchmodat,sys_fchmodat,ARG0,ARG2)
+SIGN2(fchownat,sys_fchownat,ARG0,ARG4)
+SIGN2(openat,compat_sys_openat,ARG2,ARG3) /* compat_* takes ARG0 unsigned */
+SIGN2(fstatat64,sys_fstatat64,ARG0,ARG3)
+SIGN2(readlinkat,sys_readlinkat,ARG0,ARG3)
+SIGN1(utimensat,compat_sys_utimensat,ARG3) /* compat_* takes ARG0 unsigned */
+SIGN1(get_robust_list,compat_sys_get_robust_list,ARG0)
+SIGN1(signalfd,compat_sys_signalfd,ARG0)
+SIGN2(signalfd4,compat_sys_signalfd4,ARG0,ARG3)
+SIGN2(timerfd_create,sys_timerfd_create,ARG0,ARG1)
+SIGN2(timerfd_settime,compat_sys_timerfd_settime,ARG0,ARG1)
+SIGN1(timerfd_gettime,compat_sys_timerfd_gettime,ARG0)
+SIGN1(eventfd2,sys_eventfd2,ARG1)
+SIGN2(fallocate,compat_sys_fallocate,ARG0,ARG1) /* (3) */
+SIGN1(pipe2,sys_pipe2,ARG1) /* missing from linux/syscalls.h */
+
+/* powerpc only */
+SIGN1(spu_run,sys_spu_run,ARG0)
+SIGN3(spu_create,sys_spu_create,ARG1,ARG2,ARG3)
+
+
+/* None of the CONFIG_UID16 is here. powerpc doesn't use them, sparc64
+ * seems to though, and might want to fix these:
+ *
+ * sys_getgroups16
+ * sys_setgroups16
+ */
+
+/* Not in the list because the generic compat_ variant takes
+ * the int/long/pid_t argument as an unsigned:
+ *
+ * compat_sys_io_getevents
+ * compat_sys_keyctl
+ * sys_futimesat
+ */
+
+/* None of the direct socketcalls are in there, powerpc doesn't have
+ * the direct variants (ouch ! must fix !) and sparc64 uses separate
+ * fixups for them afaik
+ */
+
+/* The various SysV IPC calls are indirect and handled in C code */
+
+/* (1) arguments different from sparc due to different reg alignment
+ *     when passing 64 bits values in 2 registers
+ *
+ * (2) both sparc64 and powerpc didn't sign extend the "timeout"
+ *     argument to poll which is a long. However, that -might- be on
+ *     purpose, I need to check. IE. sys_poll() assumes negative timeouts
+ *     are in jiffies (yuck !), it's possible that we avoid exposing that
+ *     crap interface by zero-extending instead as a "feature"...
+ *
+ * (3) We have the compat_ accessor in arch code, might be worth either
+ *     moving the sign extension there or making the compat_ variant
+ *     generic...
+ */
+
+
Index: linux-work/arch/powerpc/kernel/systbl.S
===================================================================
--- linux-work.orig/arch/powerpc/kernel/systbl.S	2008-09-25 14:03:06.000000000 +1000
+++ linux-work/arch/powerpc/kernel/systbl.S	2008-09-25 14:40:02.000000000 +1000
@@ -19,6 +19,7 @@
 #ifdef CONFIG_PPC64
 #define SYSCALL(func)		.llong	.sys_##func,.sys_##func
 #define COMPAT_SYS(func)	.llong	.sys_##func,.compat_sys_##func
+#define SYS32_SYS(func)		.llong	.sys_##func,.sys32_##func
 #define PPC_SYS(func)		.llong	.ppc_##func,.ppc_##func
 #define OLDSYS(func)		.llong	.sys_ni_syscall,.sys_ni_syscall
 #define SYS32ONLY(func)		.llong	.sys_ni_syscall,.compat_sys_##func
@@ -26,6 +27,7 @@
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
+#define SYS32_SYS(func)		.long	sys_##func
 #define PPC_SYS(func)		.long	ppc_##func
 #define OLDSYS(func)		.long	sys_##func
 #define SYS32ONLY(func)		.long	sys_##func
@@ -33,6 +35,7 @@
 #endif
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
+#define SYS32_SYS_SPU(func)	SYS32_SYS(func)
 #define PPC_SYS_SPU(func)	PPC_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
Index: linux-work/arch/powerpc/platforms/cell/spu_callbacks.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/cell/spu_callbacks.c	2008-09-25 14:04:33.000000000 +1000
+++ linux-work/arch/powerpc/platforms/cell/spu_callbacks.c	2008-09-25 14:40:21.000000000 +1000
@@ -36,6 +36,7 @@
 static void *spu_syscall_table[] = {
 #define SYSCALL(func)		sys_ni_syscall,
 #define COMPAT_SYS(func)	sys_ni_syscall,
+#define SYS32_SYS(func)		sys_ni_syscall,
 #define PPC_SYS(func)		sys_ni_syscall,
 #define OLDSYS(func)		sys_ni_syscall,
 #define SYS32ONLY(func)		sys_ni_syscall,
@@ -43,6 +44,7 @@ static void *spu_syscall_table[] = {
 
 #define SYSCALL_SPU(func)	sys_##func,
 #define COMPAT_SYS_SPU(func)	sys_##func,
+#define SYS32_SYS_SPU(func)	sys_##func,
 #define PPC_SYS_SPU(func)	ppc_##func,
 #define SYSX_SPU(f, f3264, f32)	f,
 
Index: linux-work/arch/powerpc/kernel/systbl_chk.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/systbl_chk.c	2008-09-25 14:57:42.000000000 +1000
+++ linux-work/arch/powerpc/kernel/systbl_chk.c	2008-09-25 14:58:52.000000000 +1000
@@ -17,6 +17,7 @@
 
 #define SYSCALL(func)		__NR_##func
 #define COMPAT_SYS(func)	__NR_##func
+#define SYS32_SYS(func)		__NR_##func
 #define PPC_SYS(func)		__NR_##func
 #ifdef CONFIG_PPC64
 #define OLDSYS(func)		-1
@@ -29,6 +30,7 @@
 
 #define SYSCALL_SPU(func)	SYSCALL(func)
 #define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
+#define SYS32_SYS_SPU(func)	SYS32_SYS(func)
 #define PPC_SYS_SPU(func)	PPC_SYS(func)
 #define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
