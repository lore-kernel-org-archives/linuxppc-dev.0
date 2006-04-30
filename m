Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 50B2567B17
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Apr 2006 23:28:26 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Wire up *at syscalls
References: <jeu08ippb9.fsf@sykes.suse.de>
	<1145924011.16166.465.camel@shinybook.infradead.org>
	<17489.50396.320494.589703@cargo.ozlabs.ibm.com>
Date: Sun, 30 Apr 2006 15:28:10 +0200
In-Reply-To: <17489.50396.320494.589703@cargo.ozlabs.ibm.com> (Paul
	Mackerras's message of "Fri, 28 Apr 2006 17:31:40 +1000")
Message-ID: <jeodyjw5ud.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> writes:

> David Woodhouse writes:
>
>> Hm, do we really need that? How about something based on this instead...
>> note that I used CONFIG_PPC_CELL because dependencies on CONFIG_*_MODULE
>> in the static kernel are evil.
>
> Nice idea, but you didn't change the syscall entry path to multiply
> the syscall number by 24 instead of 16.  It would be nice to have a
> way to do something like that but generate two separate tables instead
> of a single table with 3 entries per syscall.

Like this?  Only compile-tested so far.

Andreas.

---
 arch/powerpc/kernel/systbl.S                |  309 ---------------------------
 arch/powerpc/platforms/cell/spu_callbacks.c |  311 +---------------------------
 include/asm-powerpc/systbl.h                |  304 +++++++++++++++++++++++++++
 3 files changed, 322 insertions(+), 602 deletions(-)

Index: linux-2.6.17-rc3-git3/arch/powerpc/kernel/systbl.S
===================================================================
--- linux-2.6.17-rc3-git3.orig/arch/powerpc/kernel/systbl.S	2006-04-30 13:47:29.000000000 +0200
+++ linux-2.6.17-rc3-git3/arch/powerpc/kernel/systbl.S	2006-04-30 13:58:29.000000000 +0200
@@ -32,6 +32,10 @@
 #define SYS32ONLY(func)		.long	sys_##func
 #define SYSX(f, f3264, f32)	.long	f32
 #endif
+#define SYSCALL_SPU(func)	SYSCALL(func)
+#define COMPAT_SYS_SPU(func)	COMPAT_SYS(func)
+#define PPC_SYS_SPU(func)	PPC_SYS(func)
+#define SYSX_SPU(f, f3264, f32)	SYSX(f, f3264, f32)
 
 #ifdef CONFIG_PPC64
 #define sys_sigpending	sys_ni_syscall
@@ -39,307 +43,4 @@
 #endif
 
 _GLOBAL(sys_call_table)
-SYSCALL(restart_syscall)
-SYSCALL(exit)
-PPC_SYS(fork)
-SYSCALL(read)
-SYSCALL(write)
-COMPAT_SYS(open)
-SYSCALL(close)
-COMPAT_SYS(waitpid)
-COMPAT_SYS(creat)
-SYSCALL(link)
-SYSCALL(unlink)
-COMPAT_SYS(execve)
-SYSCALL(chdir)
-COMPAT_SYS(time)
-SYSCALL(mknod)
-SYSCALL(chmod)
-SYSCALL(lchown)
-SYSCALL(ni_syscall)
-OLDSYS(stat)
-SYSX(sys_lseek,ppc32_lseek,sys_lseek)
-SYSCALL(getpid)
-COMPAT_SYS(mount)
-SYSX(sys_ni_syscall,sys_oldumount,sys_oldumount)
-SYSCALL(setuid)
-SYSCALL(getuid)
-COMPAT_SYS(stime)
-COMPAT_SYS(ptrace)
-SYSCALL(alarm)
-OLDSYS(fstat)
-COMPAT_SYS(pause)
-COMPAT_SYS(utime)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
-COMPAT_SYS(access)
-COMPAT_SYS(nice)
-SYSCALL(ni_syscall)
-SYSCALL(sync)
-COMPAT_SYS(kill)
-SYSCALL(rename)
-COMPAT_SYS(mkdir)
-SYSCALL(rmdir)
-SYSCALL(dup)
-SYSCALL(pipe)
-COMPAT_SYS(times)
-SYSCALL(ni_syscall)
-SYSCALL(brk)
-SYSCALL(setgid)
-SYSCALL(getgid)
-SYSCALL(signal)
-SYSCALL(geteuid)
-SYSCALL(getegid)
-SYSCALL(acct)
-SYSCALL(umount)
-SYSCALL(ni_syscall)
-COMPAT_SYS(ioctl)
-COMPAT_SYS(fcntl)
-SYSCALL(ni_syscall)
-COMPAT_SYS(setpgid)
-SYSCALL(ni_syscall)
-SYSX(sys_ni_syscall,sys_olduname, sys_olduname)
-COMPAT_SYS(umask)
-SYSCALL(chroot)
-SYSCALL(ustat)
-SYSCALL(dup2)
-SYSCALL(getppid)
-SYSCALL(getpgrp)
-SYSCALL(setsid)
-SYS32ONLY(sigaction)
-SYSCALL(sgetmask)
-COMPAT_SYS(ssetmask)
-SYSCALL(setreuid)
-SYSCALL(setregid)
-SYS32ONLY(sigsuspend)
-COMPAT_SYS(sigpending)
-COMPAT_SYS(sethostname)
-COMPAT_SYS(setrlimit)
-COMPAT_SYS(old_getrlimit)
-COMPAT_SYS(getrusage)
-COMPAT_SYS(gettimeofday)
-COMPAT_SYS(settimeofday)
-COMPAT_SYS(getgroups)
-COMPAT_SYS(setgroups)
-SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
-SYSCALL(symlink)
-OLDSYS(lstat)
-COMPAT_SYS(readlink)
-SYSCALL(uselib)
-SYSCALL(swapon)
-SYSCALL(reboot)
-SYSX(sys_ni_syscall,old32_readdir,old_readdir)
-SYSCALL(mmap)
-SYSCALL(munmap)
-SYSCALL(truncate)
-SYSCALL(ftruncate)
-SYSCALL(fchmod)
-SYSCALL(fchown)
-COMPAT_SYS(getpriority)
-COMPAT_SYS(setpriority)
-SYSCALL(ni_syscall)
-COMPAT_SYS(statfs)
-COMPAT_SYS(fstatfs)
-SYSCALL(ni_syscall)
-COMPAT_SYS(socketcall)
-COMPAT_SYS(syslog)
-COMPAT_SYS(setitimer)
-COMPAT_SYS(getitimer)
-COMPAT_SYS(newstat)
-COMPAT_SYS(newlstat)
-COMPAT_SYS(newfstat)
-SYSX(sys_ni_syscall,sys_uname,sys_uname)
-SYSCALL(ni_syscall)
-SYSCALL(vhangup)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
-COMPAT_SYS(wait4)
-SYSCALL(swapoff)
-COMPAT_SYS(sysinfo)
-COMPAT_SYS(ipc)
-SYSCALL(fsync)
-SYS32ONLY(sigreturn)
-PPC_SYS(clone)
-COMPAT_SYS(setdomainname)
-PPC_SYS(newuname)
-SYSCALL(ni_syscall)
-COMPAT_SYS(adjtimex)
-SYSCALL(mprotect)
-SYSX(sys_ni_syscall,compat_sys_sigprocmask,sys_sigprocmask)
-SYSCALL(ni_syscall)
-SYSCALL(init_module)
-SYSCALL(delete_module)
-SYSCALL(ni_syscall)
-SYSCALL(quotactl)
-COMPAT_SYS(getpgid)
-SYSCALL(fchdir)
-SYSCALL(bdflush)
-COMPAT_SYS(sysfs)
-SYSX(ppc64_personality,ppc64_personality,sys_personality)
-SYSCALL(ni_syscall)
-SYSCALL(setfsuid)
-SYSCALL(setfsgid)
-SYSCALL(llseek)
-COMPAT_SYS(getdents)
-SYSX(sys_select,ppc32_select,ppc_select)
-SYSCALL(flock)
-SYSCALL(msync)
-COMPAT_SYS(readv)
-COMPAT_SYS(writev)
-COMPAT_SYS(getsid)
-SYSCALL(fdatasync)
-COMPAT_SYS(sysctl)
-SYSCALL(mlock)
-SYSCALL(munlock)
-SYSCALL(mlockall)
-SYSCALL(munlockall)
-COMPAT_SYS(sched_setparam)
-COMPAT_SYS(sched_getparam)
-COMPAT_SYS(sched_setscheduler)
-COMPAT_SYS(sched_getscheduler)
-SYSCALL(sched_yield)
-COMPAT_SYS(sched_get_priority_max)
-COMPAT_SYS(sched_get_priority_min)
-COMPAT_SYS(sched_rr_get_interval)
-COMPAT_SYS(nanosleep)
-SYSCALL(mremap)
-SYSCALL(setresuid)
-SYSCALL(getresuid)
-SYSCALL(ni_syscall)
-SYSCALL(poll)
-COMPAT_SYS(nfsservctl)
-SYSCALL(setresgid)
-SYSCALL(getresgid)
-COMPAT_SYS(prctl)
-COMPAT_SYS(rt_sigreturn)
-COMPAT_SYS(rt_sigaction)
-COMPAT_SYS(rt_sigprocmask)
-COMPAT_SYS(rt_sigpending)
-COMPAT_SYS(rt_sigtimedwait)
-COMPAT_SYS(rt_sigqueueinfo)
-COMPAT_SYS(rt_sigsuspend)
-COMPAT_SYS(pread64)
-COMPAT_SYS(pwrite64)
-SYSCALL(chown)
-SYSCALL(getcwd)
-SYSCALL(capget)
-SYSCALL(capset)
-COMPAT_SYS(sigaltstack)
-SYSX(sys_sendfile64,compat_sys_sendfile,sys_sendfile)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
-PPC_SYS(vfork)
-COMPAT_SYS(getrlimit)
-COMPAT_SYS(readahead)
-SYS32ONLY(mmap2)
-SYS32ONLY(truncate64)
-SYS32ONLY(ftruncate64)
-SYSX(sys_ni_syscall,sys_stat64,sys_stat64)
-SYSX(sys_ni_syscall,sys_lstat64,sys_lstat64)
-SYSX(sys_ni_syscall,sys_fstat64,sys_fstat64)
-SYSCALL(pciconfig_read)
-SYSCALL(pciconfig_write)
-SYSCALL(pciconfig_iobase)
-SYSCALL(ni_syscall)
-SYSCALL(getdents64)
-SYSCALL(pivot_root)
-SYSX(sys_ni_syscall,compat_sys_fcntl64,sys_fcntl64)
-SYSCALL(madvise)
-SYSCALL(mincore)
-SYSCALL(gettid)
-SYSCALL(tkill)
-SYSCALL(setxattr)
-SYSCALL(lsetxattr)
-SYSCALL(fsetxattr)
-SYSCALL(getxattr)
-SYSCALL(lgetxattr)
-SYSCALL(fgetxattr)
-SYSCALL(listxattr)
-SYSCALL(llistxattr)
-SYSCALL(flistxattr)
-SYSCALL(removexattr)
-SYSCALL(lremovexattr)
-SYSCALL(fremovexattr)
-COMPAT_SYS(futex)
-COMPAT_SYS(sched_setaffinity)
-COMPAT_SYS(sched_getaffinity)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
-SYS32ONLY(sendfile64)
-COMPAT_SYS(io_setup)
-SYSCALL(io_destroy)
-COMPAT_SYS(io_getevents)
-COMPAT_SYS(io_submit)
-SYSCALL(io_cancel)
-SYSCALL(set_tid_address)
-SYSX(sys_fadvise64,ppc32_fadvise64,sys_fadvise64)
-SYSCALL(exit_group)
-SYSX(sys_lookup_dcookie,ppc32_lookup_dcookie,sys_lookup_dcookie)
-SYSCALL(epoll_create)
-SYSCALL(epoll_ctl)
-SYSCALL(epoll_wait)
-SYSCALL(remap_file_pages)
-SYSX(sys_timer_create,compat_sys_timer_create,sys_timer_create)
-COMPAT_SYS(timer_settime)
-COMPAT_SYS(timer_gettime)
-SYSCALL(timer_getoverrun)
-SYSCALL(timer_delete)
-COMPAT_SYS(clock_settime)
-COMPAT_SYS(clock_gettime)
-COMPAT_SYS(clock_getres)
-COMPAT_SYS(clock_nanosleep)
-SYSX(ppc64_swapcontext,ppc32_swapcontext,ppc_swapcontext)
-COMPAT_SYS(tgkill)
-COMPAT_SYS(utimes)
-COMPAT_SYS(statfs64)
-COMPAT_SYS(fstatfs64)
-SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
-PPC_SYS(rtas)
-OLDSYS(debug_setcontext)
-SYSCALL(ni_syscall)
-SYSCALL(ni_syscall)
-COMPAT_SYS(mbind)
-COMPAT_SYS(get_mempolicy)
-COMPAT_SYS(set_mempolicy)
-COMPAT_SYS(mq_open)
-SYSCALL(mq_unlink)
-COMPAT_SYS(mq_timedsend)
-COMPAT_SYS(mq_timedreceive)
-COMPAT_SYS(mq_notify)
-COMPAT_SYS(mq_getsetattr)
-COMPAT_SYS(kexec_load)
-COMPAT_SYS(add_key)
-COMPAT_SYS(request_key)
-COMPAT_SYS(keyctl)
-COMPAT_SYS(waitid)
-COMPAT_SYS(ioprio_set)
-COMPAT_SYS(ioprio_get)
-SYSCALL(inotify_init)
-SYSCALL(inotify_add_watch)
-SYSCALL(inotify_rm_watch)
-SYSCALL(spu_run)
-SYSCALL(spu_create)
-COMPAT_SYS(pselect6)
-COMPAT_SYS(ppoll)
-SYSCALL(unshare)
-SYSCALL(splice)
-SYSCALL(tee)
-SYSCALL(vmsplice)
-COMPAT_SYS(openat)
-SYSCALL(mkdirat)
-SYSCALL(mknodat)
-SYSCALL(fchownat)
-COMPAT_SYS(futimesat)
-SYSX(sys_newfstatat, sys_fstatat64, sys_fstatat64)
-SYSCALL(unlinkat)
-SYSCALL(renameat)
-SYSCALL(linkat)
-SYSCALL(symlinkat)
-SYSCALL(readlinkat)
-SYSCALL(fchmodat)
-SYSCALL(faccessat)
-
-/*
- * please add new calls to arch/powerpc/platforms/cell/spu_callbacks.c
- * as well when appropriate.
- */
+#include <asm/systbl.h>
Index: linux-2.6.17-rc3-git3/arch/powerpc/platforms/cell/spu_callbacks.c
===================================================================
--- linux-2.6.17-rc3-git3.orig/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-30 13:47:29.000000000 +0200
+++ linux-2.6.17-rc3-git3/arch/powerpc/platforms/cell/spu_callbacks.c	2006-04-30 14:12:43.000000000 +0200
@@ -34,304 +34,19 @@
  */
 
 void *spu_syscall_table[] = {
-	[__NR_restart_syscall]		sys_ni_syscall, /* sys_restart_syscall */
-	[__NR_exit]			sys_ni_syscall, /* sys_exit */
-	[__NR_fork]			sys_ni_syscall, /* ppc_fork */
-	[__NR_read]			sys_read,
-	[__NR_write]			sys_write,
-	[__NR_open]			sys_open,
-	[__NR_close]			sys_close,
-	[__NR_waitpid]			sys_waitpid,
-	[__NR_creat]			sys_creat,
-	[__NR_link]			sys_link,
-	[__NR_unlink]			sys_unlink,
-	[__NR_execve]			sys_ni_syscall, /* sys_execve */
-	[__NR_chdir]			sys_chdir,
-	[__NR_time]			sys_time,
-	[__NR_mknod]			sys_mknod,
-	[__NR_chmod]			sys_chmod,
-	[__NR_lchown]			sys_lchown,
-	[__NR_break]			sys_ni_syscall,
-	[__NR_oldstat]			sys_ni_syscall,
-	[__NR_lseek]			sys_lseek,
-	[__NR_getpid]			sys_getpid,
-	[__NR_mount]			sys_ni_syscall, /* sys_mount */
-	[__NR_umount]			sys_ni_syscall,
-	[__NR_setuid]			sys_setuid,
-	[__NR_getuid]			sys_getuid,
-	[__NR_stime]			sys_stime,
-	[__NR_ptrace]			sys_ni_syscall, /* sys_ptrace */
-	[__NR_alarm]			sys_alarm,
-	[__NR_oldfstat]			sys_ni_syscall,
-	[__NR_pause]			sys_ni_syscall, /* sys_pause */
-	[__NR_utime]			sys_ni_syscall, /* sys_utime */
-	[__NR_stty]			sys_ni_syscall,
-	[__NR_gtty]			sys_ni_syscall,
-	[__NR_access]			sys_access,
-	[__NR_nice]			sys_nice,
-	[__NR_ftime]			sys_ni_syscall,
-	[__NR_sync]			sys_sync,
-	[__NR_kill]			sys_kill,
-	[__NR_rename]			sys_rename,
-	[__NR_mkdir]			sys_mkdir,
-	[__NR_rmdir]			sys_rmdir,
-	[__NR_dup]			sys_dup,
-	[__NR_pipe]			sys_pipe,
-	[__NR_times]			sys_times,
-	[__NR_prof]			sys_ni_syscall,
-	[__NR_brk]			sys_brk,
-	[__NR_setgid]			sys_setgid,
-	[__NR_getgid]			sys_getgid,
-	[__NR_signal]			sys_ni_syscall, /* sys_signal */
-	[__NR_geteuid]			sys_geteuid,
-	[__NR_getegid]			sys_getegid,
-	[__NR_acct]			sys_ni_syscall, /* sys_acct */
-	[__NR_umount2]			sys_ni_syscall, /* sys_umount */
-	[__NR_lock]			sys_ni_syscall,
-	[__NR_ioctl]			sys_ioctl,
-	[__NR_fcntl]			sys_fcntl,
-	[__NR_mpx]			sys_ni_syscall,
-	[__NR_setpgid]			sys_setpgid,
-	[__NR_ulimit]			sys_ni_syscall,
-	[__NR_oldolduname]		sys_ni_syscall,
-	[__NR_umask]			sys_umask,
-	[__NR_chroot]			sys_chroot,
-	[__NR_ustat]			sys_ni_syscall, /* sys_ustat */
-	[__NR_dup2]			sys_dup2,
-	[__NR_getppid]			sys_getppid,
-	[__NR_getpgrp]			sys_getpgrp,
-	[__NR_setsid]			sys_setsid,
-	[__NR_sigaction]		sys_ni_syscall,
-	[__NR_sgetmask]			sys_sgetmask,
-	[__NR_ssetmask]			sys_ssetmask,
-	[__NR_setreuid]			sys_setreuid,
-	[__NR_setregid]			sys_setregid,
-	[__NR_sigsuspend]		sys_ni_syscall,
-	[__NR_sigpending]		sys_ni_syscall,
-	[__NR_sethostname]		sys_sethostname,
-	[__NR_setrlimit]		sys_setrlimit,
-	[__NR_getrlimit]		sys_ni_syscall,
-	[__NR_getrusage]		sys_getrusage,
-	[__NR_gettimeofday]		sys_gettimeofday,
-	[__NR_settimeofday]		sys_settimeofday,
-	[__NR_getgroups]		sys_getgroups,
-	[__NR_setgroups]		sys_setgroups,
-	[__NR_select]			sys_ni_syscall,
-	[__NR_symlink]			sys_symlink,
-	[__NR_oldlstat]			sys_ni_syscall,
-	[__NR_readlink]			sys_readlink,
-	[__NR_uselib]			sys_ni_syscall, /* sys_uselib */
-	[__NR_swapon]			sys_ni_syscall, /* sys_swapon */
-	[__NR_reboot]			sys_ni_syscall, /* sys_reboot */
-	[__NR_readdir]			sys_ni_syscall,
-	[__NR_mmap]			sys_mmap,
-	[__NR_munmap]			sys_munmap,
-	[__NR_truncate]			sys_truncate,
-	[__NR_ftruncate]		sys_ftruncate,
-	[__NR_fchmod]			sys_fchmod,
-	[__NR_fchown]			sys_fchown,
-	[__NR_getpriority]		sys_getpriority,
-	[__NR_setpriority]		sys_setpriority,
-	[__NR_profil]			sys_ni_syscall,
-	[__NR_statfs]			sys_ni_syscall, /* sys_statfs */
-	[__NR_fstatfs]			sys_ni_syscall, /* sys_fstatfs */
-	[__NR_ioperm]			sys_ni_syscall,
-	[__NR_socketcall]		sys_socketcall,
-	[__NR_syslog]			sys_syslog,
-	[__NR_setitimer]		sys_setitimer,
-	[__NR_getitimer]		sys_getitimer,
-	[__NR_stat]			sys_newstat,
-	[__NR_lstat]			sys_newlstat,
-	[__NR_fstat]			sys_newfstat,
-	[__NR_olduname]			sys_ni_syscall,
-	[__NR_iopl]			sys_ni_syscall,
-	[__NR_vhangup]			sys_vhangup,
-	[__NR_idle]			sys_ni_syscall,
-	[__NR_vm86]			sys_ni_syscall,
-	[__NR_wait4]			sys_wait4,
-	[__NR_swapoff]			sys_ni_syscall, /* sys_swapoff */
-	[__NR_sysinfo]			sys_sysinfo,
-	[__NR_ipc]			sys_ni_syscall, /* sys_ipc */
-	[__NR_fsync]			sys_fsync,
-	[__NR_sigreturn]		sys_ni_syscall,
-	[__NR_clone]			sys_ni_syscall, /* ppc_clone */
-	[__NR_setdomainname]		sys_setdomainname,
-	[__NR_uname]			ppc_newuname,
-	[__NR_modify_ldt]		sys_ni_syscall,
-	[__NR_adjtimex]			sys_adjtimex,
-	[__NR_mprotect]			sys_mprotect,
-	[__NR_sigprocmask]		sys_ni_syscall,
-	[__NR_create_module]		sys_ni_syscall,
-	[__NR_init_module]		sys_ni_syscall, /* sys_init_module */
-	[__NR_delete_module]		sys_ni_syscall, /* sys_delete_module */
-	[__NR_get_kernel_syms]		sys_ni_syscall,
-	[__NR_quotactl]			sys_ni_syscall, /* sys_quotactl */
-	[__NR_getpgid]			sys_getpgid,
-	[__NR_fchdir]			sys_fchdir,
-	[__NR_bdflush]			sys_bdflush,
-	[__NR_sysfs]			sys_ni_syscall, /* sys_sysfs */
-	[__NR_personality]		ppc64_personality,
-	[__NR_afs_syscall]		sys_ni_syscall,
-	[__NR_setfsuid]			sys_setfsuid,
-	[__NR_setfsgid]			sys_setfsgid,
-	[__NR__llseek]			sys_llseek,
-	[__NR_getdents]			sys_getdents,
-	[__NR__newselect]		sys_select,
-	[__NR_flock]			sys_flock,
-	[__NR_msync]			sys_msync,
-	[__NR_readv]			sys_readv,
-	[__NR_writev]			sys_writev,
-	[__NR_getsid]			sys_getsid,
-	[__NR_fdatasync]		sys_fdatasync,
-	[__NR__sysctl]			sys_ni_syscall, /* sys_sysctl */
-	[__NR_mlock]			sys_mlock,
-	[__NR_munlock]			sys_munlock,
-	[__NR_mlockall]			sys_mlockall,
-	[__NR_munlockall]		sys_munlockall,
-	[__NR_sched_setparam]		sys_sched_setparam,
-	[__NR_sched_getparam]		sys_sched_getparam,
-	[__NR_sched_setscheduler]	sys_sched_setscheduler,
-	[__NR_sched_getscheduler]	sys_sched_getscheduler,
-	[__NR_sched_yield]		sys_sched_yield,
-	[__NR_sched_get_priority_max]	sys_sched_get_priority_max,
-	[__NR_sched_get_priority_min]	sys_sched_get_priority_min,
-	[__NR_sched_rr_get_interval]	sys_sched_rr_get_interval,
-	[__NR_nanosleep]		sys_nanosleep,
-	[__NR_mremap]			sys_mremap,
-	[__NR_setresuid]		sys_setresuid,
-	[__NR_getresuid]		sys_getresuid,
-	[__NR_query_module]		sys_ni_syscall,
-	[__NR_poll]			sys_poll,
-	[__NR_nfsservctl]		sys_ni_syscall, /* sys_nfsservctl */
-	[__NR_setresgid]		sys_setresgid,
-	[__NR_getresgid]		sys_getresgid,
-	[__NR_prctl]			sys_prctl,
-	[__NR_rt_sigreturn]		sys_ni_syscall, /* ppc64_rt_sigreturn */
-	[__NR_rt_sigaction]		sys_ni_syscall, /* sys_rt_sigaction */
-	[__NR_rt_sigprocmask]		sys_ni_syscall, /* sys_rt_sigprocmask */
-	[__NR_rt_sigpending]		sys_ni_syscall, /* sys_rt_sigpending */
-	[__NR_rt_sigtimedwait]		sys_ni_syscall, /* sys_rt_sigtimedwait */
-	[__NR_rt_sigqueueinfo]		sys_ni_syscall, /* sys_rt_sigqueueinfo */
-	[__NR_rt_sigsuspend]		sys_ni_syscall, /* sys_rt_sigsuspend */
-	[__NR_pread64]			sys_pread64,
-	[__NR_pwrite64]			sys_pwrite64,
-	[__NR_chown]			sys_chown,
-	[__NR_getcwd]			sys_getcwd,
-	[__NR_capget]			sys_capget,
-	[__NR_capset]			sys_capset,
-	[__NR_sigaltstack]		sys_ni_syscall, /* sys_sigaltstack */
-	[__NR_sendfile]			sys_sendfile64,
-	[__NR_getpmsg]			sys_ni_syscall,
-	[__NR_putpmsg]			sys_ni_syscall,
-	[__NR_vfork]			sys_ni_syscall, /* ppc_vfork */
-	[__NR_ugetrlimit]		sys_getrlimit,
-	[__NR_readahead]		sys_readahead,
-	[192]				sys_ni_syscall,
-	[193]				sys_ni_syscall,
-	[194]				sys_ni_syscall,
-	[195]				sys_ni_syscall,
-	[196]				sys_ni_syscall,
-	[197]				sys_ni_syscall,
-	[__NR_pciconfig_read]		sys_ni_syscall, /* sys_pciconfig_read */
-	[__NR_pciconfig_write]		sys_ni_syscall, /* sys_pciconfig_write */
-	[__NR_pciconfig_iobase]		sys_ni_syscall, /* sys_pciconfig_iobase */
-	[__NR_multiplexer]		sys_ni_syscall,
-	[__NR_getdents64]		sys_getdents64,
-	[__NR_pivot_root]		sys_pivot_root,
-	[204]				sys_ni_syscall,
-	[__NR_madvise]			sys_madvise,
-	[__NR_mincore]			sys_mincore,
-	[__NR_gettid]			sys_gettid,
-	[__NR_tkill]			sys_tkill,
-	[__NR_setxattr]			sys_setxattr,
-	[__NR_lsetxattr]		sys_lsetxattr,
-	[__NR_fsetxattr]		sys_fsetxattr,
-	[__NR_getxattr]			sys_getxattr,
-	[__NR_lgetxattr]		sys_lgetxattr,
-	[__NR_fgetxattr]		sys_fgetxattr,
-	[__NR_listxattr]		sys_listxattr,
-	[__NR_llistxattr]		sys_llistxattr,
-	[__NR_flistxattr]		sys_flistxattr,
-	[__NR_removexattr]		sys_removexattr,
-	[__NR_lremovexattr]		sys_lremovexattr,
-	[__NR_fremovexattr]		sys_fremovexattr,
-	[__NR_futex]			sys_futex,
-	[__NR_sched_setaffinity]	sys_sched_setaffinity,
-	[__NR_sched_getaffinity]	sys_sched_getaffinity,
-	[__NR_tuxcall]			sys_ni_syscall,
-	[226]				sys_ni_syscall,
-	[__NR_io_setup]			sys_io_setup,
-	[__NR_io_destroy]		sys_io_destroy,
-	[__NR_io_getevents]		sys_io_getevents,
-	[__NR_io_submit]		sys_io_submit,
-	[__NR_io_cancel]		sys_io_cancel,
-	[__NR_set_tid_address]		sys_ni_syscall, /* sys_set_tid_address */
-	[__NR_fadvise64]		sys_fadvise64,
-	[__NR_exit_group]		sys_ni_syscall, /* sys_exit_group */
-	[__NR_lookup_dcookie]		sys_ni_syscall, /* sys_lookup_dcookie */
-	[__NR_epoll_create]		sys_epoll_create,
-	[__NR_epoll_ctl]		sys_epoll_ctl,
-	[__NR_epoll_wait]		sys_epoll_wait,
-	[__NR_remap_file_pages]		sys_remap_file_pages,
-	[__NR_timer_create]		sys_timer_create,
-	[__NR_timer_settime]		sys_timer_settime,
-	[__NR_timer_gettime]		sys_timer_gettime,
-	[__NR_timer_getoverrun]		sys_timer_getoverrun,
-	[__NR_timer_delete]		sys_timer_delete,
-	[__NR_clock_settime]		sys_clock_settime,
-	[__NR_clock_gettime]		sys_clock_gettime,
-	[__NR_clock_getres]		sys_clock_getres,
-	[__NR_clock_nanosleep]		sys_clock_nanosleep,
-	[__NR_swapcontext]		sys_ni_syscall, /* ppc64_swapcontext */
-	[__NR_tgkill]			sys_tgkill,
-	[__NR_utimes]			sys_utimes,
-	[__NR_statfs64]			sys_statfs64,
-	[__NR_fstatfs64]		sys_fstatfs64,
-	[254]				sys_ni_syscall,
-	[__NR_rtas]			ppc_rtas,
-	[256]				sys_ni_syscall,
-	[257]				sys_ni_syscall,
-	[258]				sys_ni_syscall,
-	[__NR_mbind]			sys_ni_syscall, /* sys_mbind */
-	[__NR_get_mempolicy]		sys_ni_syscall, /* sys_get_mempolicy */
-	[__NR_set_mempolicy]		sys_ni_syscall, /* sys_set_mempolicy */
-	[__NR_mq_open]			sys_ni_syscall, /* sys_mq_open */
-	[__NR_mq_unlink]		sys_ni_syscall, /* sys_mq_unlink */
-	[__NR_mq_timedsend]		sys_ni_syscall, /* sys_mq_timedsend */
-	[__NR_mq_timedreceive]		sys_ni_syscall, /* sys_mq_timedreceive */
-	[__NR_mq_notify]		sys_ni_syscall, /* sys_mq_notify */
-	[__NR_mq_getsetattr]		sys_ni_syscall, /* sys_mq_getsetattr */
-	[__NR_kexec_load]		sys_ni_syscall, /* sys_kexec_load */
-	[__NR_add_key]			sys_ni_syscall, /* sys_add_key */
-	[__NR_request_key]		sys_ni_syscall, /* sys_request_key */
-	[__NR_keyctl]			sys_ni_syscall, /* sys_keyctl */
-	[__NR_waitid]			sys_ni_syscall, /* sys_waitid */
-	[__NR_ioprio_set]		sys_ni_syscall, /* sys_ioprio_set */
-	[__NR_ioprio_get]		sys_ni_syscall, /* sys_ioprio_get */
-	[__NR_inotify_init]		sys_ni_syscall, /* sys_inotify_init */
-	[__NR_inotify_add_watch]	sys_ni_syscall, /* sys_inotify_add_watch */
-	[__NR_inotify_rm_watch]		sys_ni_syscall, /* sys_inotify_rm_watch */
-	[__NR_spu_run]			sys_ni_syscall, /* sys_spu_run */
-	[__NR_spu_create]		sys_ni_syscall, /* sys_spu_create */
-	[__NR_pselect6]			sys_ni_syscall, /* sys_pselect */
-	[__NR_ppoll]			sys_ni_syscall, /* sys_ppoll */
-	[__NR_unshare]			sys_unshare,
-	[__NR_splice]			sys_splice,
-	[__NR_tee]			sys_tee,
-	[__NR_vmsplice]			sys_vmsplice,
-	[__NR_openat]			sys_openat,
-	[__NR_mkdirat]			sys_mkdirat,
-	[__NR_mknodat]			sys_mknodat,
-	[__NR_fchownat]			sys_fchownat,
-	[__NR_futimesat]		sys_futimesat,
-	[__NR_newfstatat]		sys_newfstatat,
-	[__NR_unlinkat]			sys_unlinkat,
-	[__NR_renameat]			sys_renameat,
-	[__NR_linkat]			sys_linkat,
-	[__NR_symlinkat]		sys_symlinkat,
-	[__NR_readlinkat]		sys_readlinkat,
-	[__NR_fchmodat]			sys_fchmodat,
-	[__NR_faccessat]		sys_faccessat,
+#define SYSCALL(func)		sys_ni_syscall,
+#define COMPAT_SYS(func)	sys_ni_syscall,
+#define PPC_SYS(func)		sys_ni_syscall,
+#define OLDSYS(func)		sys_ni_syscall,
+#define SYS32ONLY(func)		sys_ni_syscall,
+#define SYSX(f, f3264, f32)	sys_ni_syscall,
+
+#define SYSCALL_SPU(func)	sys_##func,
+#define COMPAT_SYS_SPU(func)	sys_##func,
+#define PPC_SYS_SPU(func)	ppc_##func,
+#define SYSX_SPU(f, f3264, f32)	f,
+
+#include <asm/systbl.h>
 };
 
 long spu_sys_callback(struct spu_syscall_block *s)
Index: linux-2.6.17-rc3-git3/include/asm-powerpc/systbl.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.17-rc3-git3/include/asm-powerpc/systbl.h	2006-04-30 14:17:52.000000000 +0200
@@ -0,0 +1,304 @@
+/*
+ * List of powerpc syscalls. For the meaning of the _SPU suffix see
+ * arch/powerpc/platforms/cell/spu_callbacks.c
+ */
+
+SYSCALL(restart_syscall)
+SYSCALL(exit)
+PPC_SYS(fork)
+SYSCALL_SPU(read)
+SYSCALL_SPU(write)
+COMPAT_SYS_SPU(open)
+SYSCALL_SPU(close)
+COMPAT_SYS_SPU(waitpid)
+COMPAT_SYS_SPU(creat)
+SYSCALL_SPU(link)
+SYSCALL_SPU(unlink)
+COMPAT_SYS(execve)
+SYSCALL_SPU(chdir)
+COMPAT_SYS_SPU(time)
+SYSCALL_SPU(mknod)
+SYSCALL_SPU(chmod)
+SYSCALL_SPU(lchown)
+SYSCALL(ni_syscall)
+OLDSYS(stat)
+SYSX_SPU(sys_lseek,ppc32_lseek,sys_lseek)
+SYSCALL_SPU(getpid)
+COMPAT_SYS(mount)
+SYSX(sys_ni_syscall,sys_oldumount,sys_oldumount)
+SYSCALL_SPU(setuid)
+SYSCALL_SPU(getuid)
+COMPAT_SYS_SPU(stime)
+COMPAT_SYS(ptrace)
+SYSCALL_SPU(alarm)
+OLDSYS(fstat)
+COMPAT_SYS(pause)
+COMPAT_SYS(utime)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+COMPAT_SYS_SPU(access)
+COMPAT_SYS_SPU(nice)
+SYSCALL(ni_syscall)
+SYSCALL_SPU(sync)
+COMPAT_SYS_SPU(kill)
+SYSCALL_SPU(rename)
+COMPAT_SYS_SPU(mkdir)
+SYSCALL_SPU(rmdir)
+SYSCALL_SPU(dup)
+SYSCALL_SPU(pipe)
+COMPAT_SYS_SPU(times)
+SYSCALL(ni_syscall)
+SYSCALL_SPU(brk)
+SYSCALL_SPU(setgid)
+SYSCALL_SPU(getgid)
+SYSCALL(signal)
+SYSCALL_SPU(geteuid)
+SYSCALL_SPU(getegid)
+SYSCALL(acct)
+SYSCALL(umount)
+SYSCALL(ni_syscall)
+COMPAT_SYS_SPU(ioctl)
+COMPAT_SYS_SPU(fcntl)
+SYSCALL(ni_syscall)
+COMPAT_SYS_SPU(setpgid)
+SYSCALL(ni_syscall)
+SYSX(sys_ni_syscall,sys_olduname, sys_olduname)
+COMPAT_SYS_SPU(umask)
+SYSCALL_SPU(chroot)
+SYSCALL(ustat)
+SYSCALL_SPU(dup2)
+SYSCALL_SPU(getppid)
+SYSCALL_SPU(getpgrp)
+SYSCALL_SPU(setsid)
+SYS32ONLY(sigaction)
+SYSCALL_SPU(sgetmask)
+COMPAT_SYS_SPU(ssetmask)
+SYSCALL_SPU(setreuid)
+SYSCALL_SPU(setregid)
+SYS32ONLY(sigsuspend)
+COMPAT_SYS(sigpending)
+COMPAT_SYS_SPU(sethostname)
+COMPAT_SYS_SPU(setrlimit)
+COMPAT_SYS(old_getrlimit)
+COMPAT_SYS_SPU(getrusage)
+COMPAT_SYS_SPU(gettimeofday)
+COMPAT_SYS_SPU(settimeofday)
+COMPAT_SYS_SPU(getgroups)
+COMPAT_SYS_SPU(setgroups)
+SYSX(sys_ni_syscall,sys_ni_syscall,ppc_select)
+SYSCALL_SPU(symlink)
+OLDSYS(lstat)
+COMPAT_SYS_SPU(readlink)
+SYSCALL(uselib)
+SYSCALL(swapon)
+SYSCALL(reboot)
+SYSX(sys_ni_syscall,old32_readdir,old_readdir)
+SYSCALL_SPU(mmap)
+SYSCALL_SPU(munmap)
+SYSCALL_SPU(truncate)
+SYSCALL_SPU(ftruncate)
+SYSCALL_SPU(fchmod)
+SYSCALL_SPU(fchown)
+COMPAT_SYS_SPU(getpriority)
+COMPAT_SYS_SPU(setpriority)
+SYSCALL(ni_syscall)
+COMPAT_SYS(statfs)
+COMPAT_SYS(fstatfs)
+SYSCALL(ni_syscall)
+COMPAT_SYS_SPU(socketcall)
+COMPAT_SYS_SPU(syslog)
+COMPAT_SYS_SPU(setitimer)
+COMPAT_SYS_SPU(getitimer)
+COMPAT_SYS_SPU(newstat)
+COMPAT_SYS_SPU(newlstat)
+COMPAT_SYS_SPU(newfstat)
+SYSX(sys_ni_syscall,sys_uname,sys_uname)
+SYSCALL(ni_syscall)
+SYSCALL_SPU(vhangup)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+COMPAT_SYS_SPU(wait4)
+SYSCALL(swapoff)
+COMPAT_SYS_SPU(sysinfo)
+COMPAT_SYS(ipc)
+SYSCALL_SPU(fsync)
+SYS32ONLY(sigreturn)
+PPC_SYS(clone)
+COMPAT_SYS_SPU(setdomainname)
+PPC_SYS_SPU(newuname)
+SYSCALL(ni_syscall)
+COMPAT_SYS_SPU(adjtimex)
+SYSCALL_SPU(mprotect)
+SYSX(sys_ni_syscall,compat_sys_sigprocmask,sys_sigprocmask)
+SYSCALL(ni_syscall)
+SYSCALL(init_module)
+SYSCALL(delete_module)
+SYSCALL(ni_syscall)
+SYSCALL(quotactl)
+COMPAT_SYS_SPU(getpgid)
+SYSCALL_SPU(fchdir)
+SYSCALL_SPU(bdflush)
+COMPAT_SYS(sysfs)
+SYSX_SPU(ppc64_personality,ppc64_personality,sys_personality)
+SYSCALL(ni_syscall)
+SYSCALL_SPU(setfsuid)
+SYSCALL_SPU(setfsgid)
+SYSCALL_SPU(llseek)
+COMPAT_SYS_SPU(getdents)
+SYSX_SPU(sys_select,ppc32_select,ppc_select)
+SYSCALL_SPU(flock)
+SYSCALL_SPU(msync)
+COMPAT_SYS_SPU(readv)
+COMPAT_SYS_SPU(writev)
+COMPAT_SYS_SPU(getsid)
+SYSCALL_SPU(fdatasync)
+COMPAT_SYS(sysctl)
+SYSCALL_SPU(mlock)
+SYSCALL_SPU(munlock)
+SYSCALL_SPU(mlockall)
+SYSCALL_SPU(munlockall)
+COMPAT_SYS_SPU(sched_setparam)
+COMPAT_SYS_SPU(sched_getparam)
+COMPAT_SYS_SPU(sched_setscheduler)
+COMPAT_SYS_SPU(sched_getscheduler)
+SYSCALL_SPU(sched_yield)
+COMPAT_SYS_SPU(sched_get_priority_max)
+COMPAT_SYS_SPU(sched_get_priority_min)
+COMPAT_SYS_SPU(sched_rr_get_interval)
+COMPAT_SYS_SPU(nanosleep)
+SYSCALL_SPU(mremap)
+SYSCALL_SPU(setresuid)
+SYSCALL_SPU(getresuid)
+SYSCALL(ni_syscall)
+SYSCALL_SPU(poll)
+COMPAT_SYS(nfsservctl)
+SYSCALL_SPU(setresgid)
+SYSCALL_SPU(getresgid)
+COMPAT_SYS_SPU(prctl)
+COMPAT_SYS(rt_sigreturn)
+COMPAT_SYS(rt_sigaction)
+COMPAT_SYS(rt_sigprocmask)
+COMPAT_SYS(rt_sigpending)
+COMPAT_SYS(rt_sigtimedwait)
+COMPAT_SYS(rt_sigqueueinfo)
+COMPAT_SYS(rt_sigsuspend)
+COMPAT_SYS_SPU(pread64)
+COMPAT_SYS_SPU(pwrite64)
+SYSCALL_SPU(chown)
+SYSCALL_SPU(getcwd)
+SYSCALL_SPU(capget)
+SYSCALL_SPU(capset)
+COMPAT_SYS(sigaltstack)
+SYSX_SPU(sys_sendfile64,compat_sys_sendfile,sys_sendfile)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+PPC_SYS(vfork)
+COMPAT_SYS_SPU(getrlimit)
+COMPAT_SYS_SPU(readahead)
+SYS32ONLY(mmap2)
+SYS32ONLY(truncate64)
+SYS32ONLY(ftruncate64)
+SYSX(sys_ni_syscall,sys_stat64,sys_stat64)
+SYSX(sys_ni_syscall,sys_lstat64,sys_lstat64)
+SYSX(sys_ni_syscall,sys_fstat64,sys_fstat64)
+SYSCALL(pciconfig_read)
+SYSCALL(pciconfig_write)
+SYSCALL(pciconfig_iobase)
+SYSCALL(ni_syscall)
+SYSCALL_SPU(getdents64)
+SYSCALL_SPU(pivot_root)
+SYSX(sys_ni_syscall,compat_sys_fcntl64,sys_fcntl64)
+SYSCALL_SPU(madvise)
+SYSCALL_SPU(mincore)
+SYSCALL_SPU(gettid)
+SYSCALL_SPU(tkill)
+SYSCALL_SPU(setxattr)
+SYSCALL_SPU(lsetxattr)
+SYSCALL_SPU(fsetxattr)
+SYSCALL_SPU(getxattr)
+SYSCALL_SPU(lgetxattr)
+SYSCALL_SPU(fgetxattr)
+SYSCALL_SPU(listxattr)
+SYSCALL_SPU(llistxattr)
+SYSCALL_SPU(flistxattr)
+SYSCALL_SPU(removexattr)
+SYSCALL_SPU(lremovexattr)
+SYSCALL_SPU(fremovexattr)
+COMPAT_SYS_SPU(futex)
+COMPAT_SYS_SPU(sched_setaffinity)
+COMPAT_SYS_SPU(sched_getaffinity)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+SYS32ONLY(sendfile64)
+COMPAT_SYS_SPU(io_setup)
+SYSCALL_SPU(io_destroy)
+COMPAT_SYS_SPU(io_getevents)
+COMPAT_SYS_SPU(io_submit)
+SYSCALL_SPU(io_cancel)
+SYSCALL(set_tid_address)
+SYSX_SPU(sys_fadvise64,ppc32_fadvise64,sys_fadvise64)
+SYSCALL(exit_group)
+SYSX(sys_lookup_dcookie,ppc32_lookup_dcookie,sys_lookup_dcookie)
+SYSCALL_SPU(epoll_create)
+SYSCALL_SPU(epoll_ctl)
+SYSCALL_SPU(epoll_wait)
+SYSCALL_SPU(remap_file_pages)
+SYSX_SPU(sys_timer_create,compat_sys_timer_create,sys_timer_create)
+COMPAT_SYS_SPU(timer_settime)
+COMPAT_SYS_SPU(timer_gettime)
+SYSCALL_SPU(timer_getoverrun)
+SYSCALL_SPU(timer_delete)
+COMPAT_SYS_SPU(clock_settime)
+COMPAT_SYS_SPU(clock_gettime)
+COMPAT_SYS_SPU(clock_getres)
+COMPAT_SYS_SPU(clock_nanosleep)
+SYSX(ppc64_swapcontext,ppc32_swapcontext,ppc_swapcontext)
+COMPAT_SYS_SPU(tgkill)
+COMPAT_SYS_SPU(utimes)
+COMPAT_SYS_SPU(statfs64)
+COMPAT_SYS_SPU(fstatfs64)
+SYSX(sys_ni_syscall, ppc_fadvise64_64, ppc_fadvise64_64)
+PPC_SYS_SPU(rtas)
+OLDSYS(debug_setcontext)
+SYSCALL(ni_syscall)
+SYSCALL(ni_syscall)
+COMPAT_SYS(mbind)
+COMPAT_SYS(get_mempolicy)
+COMPAT_SYS(set_mempolicy)
+COMPAT_SYS(mq_open)
+SYSCALL(mq_unlink)
+COMPAT_SYS(mq_timedsend)
+COMPAT_SYS(mq_timedreceive)
+COMPAT_SYS(mq_notify)
+COMPAT_SYS(mq_getsetattr)
+COMPAT_SYS(kexec_load)
+COMPAT_SYS(add_key)
+COMPAT_SYS(request_key)
+COMPAT_SYS(keyctl)
+COMPAT_SYS(waitid)
+COMPAT_SYS(ioprio_set)
+COMPAT_SYS(ioprio_get)
+SYSCALL(inotify_init)
+SYSCALL(inotify_add_watch)
+SYSCALL(inotify_rm_watch)
+SYSCALL(spu_run)
+SYSCALL(spu_create)
+COMPAT_SYS(pselect6)
+COMPAT_SYS(ppoll)
+SYSCALL_SPU(unshare)
+SYSCALL_SPU(splice)
+SYSCALL_SPU(tee)
+SYSCALL_SPU(vmsplice)
+COMPAT_SYS_SPU(openat)
+SYSCALL_SPU(mkdirat)
+SYSCALL_SPU(mknodat)
+SYSCALL_SPU(fchownat)
+COMPAT_SYS_SPU(futimesat)
+SYSX_SPU(sys_newfstatat, sys_fstatat64, sys_fstatat64)
+SYSCALL_SPU(unlinkat)
+SYSCALL_SPU(renameat)
+SYSCALL_SPU(linkat)
+SYSCALL_SPU(symlinkat)
+SYSCALL_SPU(readlinkat)
+SYSCALL_SPU(fchmodat)
+SYSCALL_SPU(faccessat)

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
