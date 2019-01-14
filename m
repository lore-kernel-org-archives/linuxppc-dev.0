Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_FUZZY_SPRM,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08AADC43612
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 532C520659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 532C520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dWlz0sp7zDqTg
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 22:42:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dWdS13TgzDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 22:36:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43dWdR5XYVz9s9G; Mon, 14 Jan 2019 22:36:27 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43dWdR4PdLz9sDn; Mon, 14 Jan 2019 22:36:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 3/5] powerpc/syscalls: Split SPU-ness out of ABI
Date: Mon, 14 Jan 2019 22:36:18 +1100
Message-Id: <20190114113620.17558-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190114113620.17558-1-mpe@ellerman.id.au>
References: <20190114113620.17558-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: firoz.khan@linaro.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Using the ABI field to encode whether a syscall is usable by SPU
programs or not is a bit of kludge.

The ABI of the syscall doesn't change depending on the SPU-ness, but
in order to make the syscall generation work we have to pretend that
it does.

It also means we have more duplicated syscall lines than we need to,
and the SPU logic is not well contained, instead all of the syscall
generation targets need to know if they are spu or nospu.

So instead add another column to the table which is a boolean SPU
field. If the field has the value "spu" then the syscall is available
to SPU programs, any other value means the syscall is not available to
SPu programs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/syscalls/Makefile      |  12 +-
 arch/powerpc/kernel/syscalls/syscall.tbl   | 817 ++++++++++-----------
 arch/powerpc/kernel/syscalls/syscallhdr.sh |   2 +-
 arch/powerpc/kernel/syscalls/syscalltbl.sh |  10 +-
 4 files changed, 414 insertions(+), 427 deletions(-)

diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index 3d9d4e07f725..46823de91109 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
@@ -18,30 +18,30 @@ quiet_cmd_systbl = SYSTBL  $@
 		   '$(systbl_abis_$(basetarget))'		\
 		   '$(systbl_abi_$(basetarget))'
 
-syshdr_abis_unistd_32 := common,nospu,32
+syshdr_abis_unistd_32 := common,32
 $(uapi)/unistd_32.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
-syshdr_abis_unistd_64 := common,nospu,64
+syshdr_abis_unistd_64 := common,64
 $(uapi)/unistd_64.h: $(syscall) $(syshdr)
 	$(call if_changed,syshdr)
 
-systbl_abis_syscall_table_32 := common,nospu,32
+systbl_abis_syscall_table_32 := common,32
 systbl_abi_syscall_table_32 := 32
 $(kapi)/syscall_table_32.h: $(syscall) $(systbl)
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_64 := common,nospu,64
+systbl_abis_syscall_table_64 := common,64
 systbl_abi_syscall_table_64 := 64
 $(kapi)/syscall_table_64.h: $(syscall) $(systbl)
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_c32 := common,nospu,32
+systbl_abis_syscall_table_c32 := common,32
 systbl_abi_syscall_table_c32 := c32
 $(kapi)/syscall_table_c32.h: $(syscall) $(systbl)
 	$(call if_changed,systbl)
 
-systbl_abis_syscall_table_spu := common,spu
+systbl_abis_syscall_table_spu := common,64
 systbl_abi_syscall_table_spu := spu
 $(kapi)/syscall_table_spu.h: $(syscall) $(systbl)
 	$(call if_changed,systbl)
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index db3bbb8744af..67fb1e48cd68 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -3,425 +3,406 @@
 # system call numbers and entry vectors for powerpc
 #
 # The format is:
-# <number> <abi> <name> <entry point> <compat entry point>
+# <number> <abi> <spu?> <name> <entry point> <compat entry point>
 #
-# The <abi> can be common, spu, nospu, 64, or 32 for this file.
+# The <abi> can be common, 64, or 32 for this file.
+# To indicate a syscall can be used by SPU programs use "spu" for the spu column.
 #
-0	nospu	restart_syscall			sys_restart_syscall
-1	nospu	exit				sys_exit
-2	nospu	fork				ppc_fork
-3	common	read				sys_read
-4	common	write				sys_write
-5	common	open				sys_open			compat_sys_open
-6	common	close				sys_close
-7	common	waitpid				sys_waitpid
-8	common	creat				sys_creat
-9	common	link				sys_link
-10	common	unlink				sys_unlink
-11	nospu	execve				sys_execve			compat_sys_execve
-12	common	chdir				sys_chdir
-13	common	time				sys_time			compat_sys_time
-14	common	mknod				sys_mknod
-15	common	chmod				sys_chmod
-16	common	lchown				sys_lchown
-17	common	break				sys_ni_syscall
-18	32	oldstat				sys_stat			sys_ni_syscall
-18	64	oldstat				sys_ni_syscall
-18	spu	oldstat				sys_ni_syscall
-19	common	lseek				sys_lseek			compat_sys_lseek
-20	common	getpid				sys_getpid
-21	nospu	mount				sys_mount			compat_sys_mount
-22	32	umount				sys_oldumount
-22	64	umount				sys_ni_syscall
-22	spu	umount				sys_ni_syscall
-23	common	setuid				sys_setuid
-24	common	getuid				sys_getuid
-25	common	stime				sys_stime			compat_sys_stime
-26	nospu	ptrace				sys_ptrace			compat_sys_ptrace
-27	common	alarm				sys_alarm
-28	32	oldfstat			sys_fstat			sys_ni_syscall
-28	64	oldfstat			sys_ni_syscall
-28	spu	oldfstat			sys_ni_syscall
-29	nospu	pause				sys_pause
-30	nospu	utime				sys_utime			compat_sys_utime
-31	common	stty				sys_ni_syscall
-32	common	gtty				sys_ni_syscall
-33	common	access				sys_access
-34	common	nice				sys_nice
-35	common	ftime				sys_ni_syscall
-36	common	sync				sys_sync
-37	common	kill				sys_kill
-38	common	rename				sys_rename
-39	common	mkdir				sys_mkdir
-40	common	rmdir				sys_rmdir
-41	common	dup				sys_dup
-42	common	pipe				sys_pipe
-43	common	times				sys_times			compat_sys_times
-44	common	prof				sys_ni_syscall
-45	common	brk				sys_brk
-46	common	setgid				sys_setgid
-47	common	getgid				sys_getgid
-48	nospu	signal				sys_signal
-49	common	geteuid				sys_geteuid
-50	common	getegid				sys_getegid
-51	nospu	acct				sys_acct
-52	nospu	umount2				sys_umount
-53	common	lock				sys_ni_syscall
-54	common	ioctl				sys_ioctl			compat_sys_ioctl
-55	common	fcntl				sys_fcntl			compat_sys_fcntl
-56	common	mpx				sys_ni_syscall
-57	common	setpgid				sys_setpgid
-58	common	ulimit				sys_ni_syscall
-59	32	oldolduname			sys_olduname
-59	64	oldolduname			sys_ni_syscall
-59	spu	oldolduname			sys_ni_syscall
-60	common	umask				sys_umask
-61	common	chroot				sys_chroot
-62	nospu	ustat				sys_ustat			compat_sys_ustat
-63	common	dup2				sys_dup2
-64	common	getppid				sys_getppid
-65	common	getpgrp				sys_getpgrp
-66	common	setsid				sys_setsid
-67	32	sigaction			sys_sigaction			compat_sys_sigaction
-67	64	sigaction			sys_ni_syscall
-67	spu	sigaction			sys_ni_syscall
-68	common	sgetmask			sys_sgetmask
-69	common	ssetmask			sys_ssetmask
-70	common	setreuid			sys_setreuid
-71	common	setregid			sys_setregid
-72	32	sigsuspend			sys_sigsuspend
-72	64	sigsuspend			sys_ni_syscall
-72	spu	sigsuspend			sys_ni_syscall
-73	32	sigpending			sys_sigpending			compat_sys_sigpending
-73	64	sigpending			sys_ni_syscall
-73	spu	sigpending			sys_ni_syscall
-74	common	sethostname			sys_sethostname
-75	common	setrlimit			sys_setrlimit			compat_sys_setrlimit
-76	32	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
-76	64	getrlimit			sys_ni_syscall
-76	spu	getrlimit			sys_ni_syscall
-77	common	getrusage			sys_getrusage			compat_sys_getrusage
-78	common	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
-79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
-80	common	getgroups			sys_getgroups
-81	common	setgroups			sys_setgroups
-82	32	select				ppc_select			sys_ni_syscall
-82	64	select				sys_ni_syscall
-82	spu	select				sys_ni_syscall
-83	common	symlink				sys_symlink
-84	32	oldlstat			sys_lstat			sys_ni_syscall
-84	64	oldlstat			sys_ni_syscall
-84	spu	oldlstat			sys_ni_syscall
-85	common	readlink			sys_readlink
-86	nospu	uselib				sys_uselib
-87	nospu	swapon				sys_swapon
-88	nospu	reboot				sys_reboot
-89	32	readdir				sys_old_readdir			compat_sys_old_readdir
-89	64	readdir				sys_ni_syscall
-89	spu	readdir				sys_ni_syscall
-90	common	mmap				sys_mmap
-91	common	munmap				sys_munmap
-92	common	truncate			sys_truncate			compat_sys_truncate
-93	common	ftruncate			sys_ftruncate			compat_sys_ftruncate
-94	common	fchmod				sys_fchmod
-95	common	fchown				sys_fchown
-96	common	getpriority			sys_getpriority
-97	common	setpriority			sys_setpriority
-98	common	profil				sys_ni_syscall
-99	nospu	statfs				sys_statfs			compat_sys_statfs
-100	nospu	fstatfs				sys_fstatfs			compat_sys_fstatfs
-101	common	ioperm				sys_ni_syscall
-102	common	socketcall			sys_socketcall			compat_sys_socketcall
-103	common	syslog				sys_syslog
-104	common	setitimer			sys_setitimer			compat_sys_setitimer
-105	common	getitimer			sys_getitimer			compat_sys_getitimer
-106	common	stat				sys_newstat			compat_sys_newstat
-107	common	lstat				sys_newlstat			compat_sys_newlstat
-108	common	fstat				sys_newfstat			compat_sys_newfstat
-109	32	olduname			sys_uname
-109	64	olduname			sys_ni_syscall
-109	spu	olduname			sys_ni_syscall
-110	common	iopl				sys_ni_syscall
-111	common	vhangup				sys_vhangup
-112	common	idle				sys_ni_syscall
-113	common	vm86				sys_ni_syscall
-114	common	wait4				sys_wait4			compat_sys_wait4
-115	nospu	swapoff				sys_swapoff
-116	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
-117	nospu	ipc				sys_ipc				compat_sys_ipc
-118	common	fsync				sys_fsync
-119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
-119	64	sigreturn			sys_ni_syscall
-119	spu	sigreturn			sys_ni_syscall
-120	nospu	clone				ppc_clone
-121	common	setdomainname			sys_setdomainname
-122	common	uname				sys_newuname
-123	common	modify_ldt			sys_ni_syscall
-124	common	adjtimex			sys_adjtimex			compat_sys_adjtimex
-125	common	mprotect			sys_mprotect
-126	32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
-126	64	sigprocmask			sys_ni_syscall
-126	spu	sigprocmask			sys_ni_syscall
-127	common	create_module			sys_ni_syscall
-128	nospu	init_module			sys_init_module
-129	nospu	delete_module			sys_delete_module
-130	common	get_kernel_syms			sys_ni_syscall
-131	nospu	quotactl			sys_quotactl
-132	common	getpgid				sys_getpgid
-133	common	fchdir				sys_fchdir
-134	common	bdflush				sys_bdflush
-135	common	sysfs				sys_sysfs
-136	32	personality			sys_personality			ppc64_personality
-136	64	personality			ppc64_personality
-136	spu	personality			ppc64_personality
-137	common	afs_syscall			sys_ni_syscall
-138	common	setfsuid			sys_setfsuid
-139	common	setfsgid			sys_setfsgid
-140	common	_llseek				sys_llseek
-141	common	getdents			sys_getdents			compat_sys_getdents
-142	common	_newselect			sys_select			compat_sys_select
-143	common	flock				sys_flock
-144	common	msync				sys_msync
-145	common	readv				sys_readv			compat_sys_readv
-146	common	writev				sys_writev			compat_sys_writev
-147	common	getsid				sys_getsid
-148	common	fdatasync			sys_fdatasync
-149	nospu	_sysctl				sys_sysctl			compat_sys_sysctl
-150	common	mlock				sys_mlock
-151	common	munlock				sys_munlock
-152	common	mlockall			sys_mlockall
-153	common	munlockall			sys_munlockall
-154	common	sched_setparam			sys_sched_setparam
-155	common	sched_getparam			sys_sched_getparam
-156	common	sched_setscheduler		sys_sched_setscheduler
-157	common	sched_getscheduler		sys_sched_getscheduler
-158	common	sched_yield			sys_sched_yield
-159	common	sched_get_priority_max		sys_sched_get_priority_max
-160	common	sched_get_priority_min		sys_sched_get_priority_min
-161	common	sched_rr_get_interval		sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
-162	common	nanosleep			sys_nanosleep			compat_sys_nanosleep
-163	common	mremap				sys_mremap
-164	common	setresuid			sys_setresuid
-165	common	getresuid			sys_getresuid
-166	common	query_module			sys_ni_syscall
-167	common	poll				sys_poll
-168	common	nfsservctl			sys_ni_syscall
-169	common	setresgid			sys_setresgid
-170	common	getresgid			sys_getresgid
-171	common	prctl				sys_prctl
-172	nospu	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
-173	nospu	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
-174	nospu	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
-175	nospu	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
-176	nospu	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
-177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
-179	common	pread64				sys_pread64			compat_sys_pread64
-180	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
-181	common	chown				sys_chown
-182	common	getcwd				sys_getcwd
-183	common	capget				sys_capget
-184	common	capset				sys_capset
-185	nospu	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
-186	32	sendfile			sys_sendfile			compat_sys_sendfile
-186	64	sendfile			sys_sendfile64
-186	spu	sendfile			sys_sendfile64
-187	common	getpmsg				sys_ni_syscall
-188	common 	putpmsg				sys_ni_syscall
-189	nospu	vfork				ppc_vfork
-190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
-191	common	readahead			sys_readahead			compat_sys_readahead
-192	32	mmap2				sys_mmap2			compat_sys_mmap2
-193	32	truncate64			sys_truncate64			compat_sys_truncate64
-194	32	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
-195	32	stat64				sys_stat64
-196	32	lstat64				sys_lstat64
-197	32	fstat64				sys_fstat64
-198	nospu 	pciconfig_read			sys_pciconfig_read
-199	nospu 	pciconfig_write			sys_pciconfig_write
-200	nospu 	pciconfig_iobase		sys_pciconfig_iobase
-201	common 	multiplexer			sys_ni_syscall
-202	common	getdents64			sys_getdents64
-203	common	pivot_root			sys_pivot_root
-204	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
-205	common	madvise				sys_madvise
-206	common	mincore				sys_mincore
-207	common	gettid				sys_gettid
-208	common	tkill				sys_tkill
-209	common	setxattr			sys_setxattr
-210	common	lsetxattr			sys_lsetxattr
-211	common	fsetxattr			sys_fsetxattr
-212	common	getxattr			sys_getxattr
-213	common	lgetxattr			sys_lgetxattr
-214	common	fgetxattr			sys_fgetxattr
-215	common	listxattr			sys_listxattr
-216	common	llistxattr			sys_llistxattr
-217	common	flistxattr			sys_flistxattr
-218	common	removexattr			sys_removexattr
-219	common	lremovexattr			sys_lremovexattr
-220	common	fremovexattr			sys_fremovexattr
-221	common	futex				sys_futex			compat_sys_futex
-222	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
-223	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
+0	common	-	restart_syscall			sys_restart_syscall
+1	common	-	exit				sys_exit
+2	common	-	fork				ppc_fork
+3	common	spu	read				sys_read
+4	common	spu	write				sys_write
+5	common	spu	open				sys_open			compat_sys_open
+6	common	spu	close				sys_close
+7	common	spu	waitpid				sys_waitpid
+8	common	spu	creat				sys_creat
+9	common	spu	link				sys_link
+10	common	spu	unlink				sys_unlink
+11	common	-	execve				sys_execve			compat_sys_execve
+12	common	spu	chdir				sys_chdir
+13	common	spu	time				sys_time			compat_sys_time
+14	common	spu	mknod				sys_mknod
+15	common	spu	chmod				sys_chmod
+16	common	spu	lchown				sys_lchown
+17	common	spu	break				sys_ni_syscall
+18	32	-	oldstat				sys_stat			sys_ni_syscall
+18	64	-	oldstat				sys_ni_syscall
+19	common	spu	lseek				sys_lseek			compat_sys_lseek
+20	common	spu	getpid				sys_getpid
+21	common	-	mount				sys_mount			compat_sys_mount
+22	32	-	umount				sys_oldumount
+22	64	spu	umount				sys_ni_syscall
+23	common	spu	setuid				sys_setuid
+24	common	spu	getuid				sys_getuid
+25	common	spu	stime				sys_stime			compat_sys_stime
+26	common	-	ptrace				sys_ptrace			compat_sys_ptrace
+27	common	spu	alarm				sys_alarm
+28	32	-	oldfstat			sys_fstat			sys_ni_syscall
+28	64	-	oldfstat			sys_ni_syscall
+29	common	-	pause				sys_pause
+30	common	-	utime				sys_utime			compat_sys_utime
+31	common	spu	stty				sys_ni_syscall
+32	common	spu	gtty				sys_ni_syscall
+33	common	spu	access				sys_access
+34	common	spu	nice				sys_nice
+35	common	spu	ftime				sys_ni_syscall
+36	common	spu	sync				sys_sync
+37	common	spu	kill				sys_kill
+38	common	spu	rename				sys_rename
+39	common	spu	mkdir				sys_mkdir
+40	common	spu	rmdir				sys_rmdir
+41	common	spu	dup				sys_dup
+42	common	spu	pipe				sys_pipe
+43	common	spu	times				sys_times			compat_sys_times
+44	common	spu	prof				sys_ni_syscall
+45	common	spu	brk				sys_brk
+46	common	spu	setgid				sys_setgid
+47	common	spu	getgid				sys_getgid
+48	common	-	signal				sys_signal
+49	common	spu	geteuid				sys_geteuid
+50	common	spu	getegid				sys_getegid
+51	common	-	acct				sys_acct
+52	common	-	umount2				sys_umount
+53	common	spu	lock				sys_ni_syscall
+54	common	spu	ioctl				sys_ioctl			compat_sys_ioctl
+55	common	spu	fcntl				sys_fcntl			compat_sys_fcntl
+56	common	spu	mpx				sys_ni_syscall
+57	common	spu	setpgid				sys_setpgid
+58	common	spu	ulimit				sys_ni_syscall
+59	32	-	oldolduname			sys_olduname
+59	64	-	oldolduname			sys_ni_syscall
+60	common	spu	umask				sys_umask
+61	common	spu	chroot				sys_chroot
+62	common	-	ustat				sys_ustat			compat_sys_ustat
+63	common	spu	dup2				sys_dup2
+64	common	spu	getppid				sys_getppid
+65	common	spu	getpgrp				sys_getpgrp
+66	common	spu	setsid				sys_setsid
+67	32	-	sigaction			sys_sigaction			compat_sys_sigaction
+67	64	-	sigaction			sys_ni_syscall
+68	common	spu	sgetmask			sys_sgetmask
+69	common	spu	ssetmask			sys_ssetmask
+70	common	spu	setreuid			sys_setreuid
+71	common	spu	setregid			sys_setregid
+72	32	-	sigsuspend			sys_sigsuspend
+72	64	-	sigsuspend			sys_ni_syscall
+73	32	-	sigpending			sys_sigpending			compat_sys_sigpending
+73	64	-	sigpending			sys_ni_syscall
+74	common	spu	sethostname			sys_sethostname
+75	common	spu	setrlimit			sys_setrlimit			compat_sys_setrlimit
+76	32	-	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
+76	64	-	getrlimit			sys_ni_syscall
+77	common	spu	getrusage			sys_getrusage			compat_sys_getrusage
+78	common	spu	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
+79	common	spu	settimeofday			sys_settimeofday		compat_sys_settimeofday
+80	common	spu	getgroups			sys_getgroups
+81	common	spu	setgroups			sys_setgroups
+82	32	-	select				ppc_select			sys_ni_syscall
+82	64	-	select				sys_ni_syscall
+83	common	spu	symlink				sys_symlink
+84	32	-	oldlstat			sys_lstat			sys_ni_syscall
+84	64	-	oldlstat			sys_ni_syscall
+85	common	spu	readlink			sys_readlink
+86	common	-	uselib				sys_uselib
+87	common	-	swapon				sys_swapon
+88	common	-	reboot				sys_reboot
+89	32	-	readdir				sys_old_readdir			compat_sys_old_readdir
+89	64	-	readdir				sys_ni_syscall
+90	common	spu	mmap				sys_mmap
+91	common	spu	munmap				sys_munmap
+92	common	spu	truncate			sys_truncate			compat_sys_truncate
+93	common	spu	ftruncate			sys_ftruncate			compat_sys_ftruncate
+94	common	spu	fchmod				sys_fchmod
+95	common	spu	fchown				sys_fchown
+96	common	spu	getpriority			sys_getpriority
+97	common	spu	setpriority			sys_setpriority
+98	common	spu	profil				sys_ni_syscall
+99	common	-	statfs				sys_statfs			compat_sys_statfs
+100	common	-	fstatfs				sys_fstatfs			compat_sys_fstatfs
+101	common	spu	ioperm				sys_ni_syscall
+102	common	spu	socketcall			sys_socketcall			compat_sys_socketcall
+103	common	spu	syslog				sys_syslog
+104	common	spu	setitimer			sys_setitimer			compat_sys_setitimer
+105	common	spu	getitimer			sys_getitimer			compat_sys_getitimer
+106	common	spu	stat				sys_newstat			compat_sys_newstat
+107	common	spu	lstat				sys_newlstat			compat_sys_newlstat
+108	common	spu	fstat				sys_newfstat			compat_sys_newfstat
+109	32	-	olduname			sys_uname
+109	64	-	olduname			sys_ni_syscall
+110	common	spu	iopl				sys_ni_syscall
+111	common	spu	vhangup				sys_vhangup
+112	common	spu	idle				sys_ni_syscall
+113	common	spu	vm86				sys_ni_syscall
+114	common	spu	wait4				sys_wait4			compat_sys_wait4
+115	common	-	swapoff				sys_swapoff
+116	common	spu	sysinfo				sys_sysinfo			compat_sys_sysinfo
+117	common	-	ipc				sys_ipc				compat_sys_ipc
+118	common	spu	fsync				sys_fsync
+119	32	-	sigreturn			sys_sigreturn			compat_sys_sigreturn
+119	64	-	sigreturn			sys_ni_syscall
+120	common	-	clone				ppc_clone
+121	common	spu	setdomainname			sys_setdomainname
+122	common	spu	uname				sys_newuname
+123	common	spu	modify_ldt			sys_ni_syscall
+124	common	spu	adjtimex			sys_adjtimex			compat_sys_adjtimex
+125	common	spu	mprotect			sys_mprotect
+126	32	-	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
+126	64	-	sigprocmask			sys_ni_syscall
+127	common	spu	create_module			sys_ni_syscall
+128	common	-	init_module			sys_init_module
+129	common	-	delete_module			sys_delete_module
+130	common	spu	get_kernel_syms			sys_ni_syscall
+131	common	-	quotactl			sys_quotactl
+132	common	spu	getpgid				sys_getpgid
+133	common	spu	fchdir				sys_fchdir
+134	common	spu	bdflush				sys_bdflush
+135	common	spu	sysfs				sys_sysfs
+136	32	-	personality			sys_personality			ppc64_personality
+136	64	spu	personality			ppc64_personality
+137	common	spu	afs_syscall			sys_ni_syscall
+138	common	spu	setfsuid			sys_setfsuid
+139	common	spu	setfsgid			sys_setfsgid
+140	common	spu	_llseek				sys_llseek
+141	common	spu	getdents			sys_getdents			compat_sys_getdents
+142	common	spu	_newselect			sys_select			compat_sys_select
+143	common	spu	flock				sys_flock
+144	common	spu	msync				sys_msync
+145	common	spu	readv				sys_readv			compat_sys_readv
+146	common	spu	writev				sys_writev			compat_sys_writev
+147	common	spu	getsid				sys_getsid
+148	common	spu	fdatasync			sys_fdatasync
+149	common	-	_sysctl				sys_sysctl			compat_sys_sysctl
+150	common	spu	mlock				sys_mlock
+151	common	spu	munlock				sys_munlock
+152	common	spu	mlockall			sys_mlockall
+153	common	spu	munlockall			sys_munlockall
+154	common	spu	sched_setparam			sys_sched_setparam
+155	common	spu	sched_getparam			sys_sched_getparam
+156	common	spu	sched_setscheduler		sys_sched_setscheduler
+157	common	spu	sched_getscheduler		sys_sched_getscheduler
+158	common	spu	sched_yield			sys_sched_yield
+159	common	spu	sched_get_priority_max		sys_sched_get_priority_max
+160	common	spu	sched_get_priority_min		sys_sched_get_priority_min
+161	common	spu	sched_rr_get_interval		sys_sched_rr_get_interval	compat_sys_sched_rr_get_interval
+162	common	spu	nanosleep			sys_nanosleep			compat_sys_nanosleep
+163	common	spu	mremap				sys_mremap
+164	common	spu	setresuid			sys_setresuid
+165	common	spu	getresuid			sys_getresuid
+166	common	spu	query_module			sys_ni_syscall
+167	common	spu	poll				sys_poll
+168	common	spu	nfsservctl			sys_ni_syscall
+169	common	spu	setresgid			sys_setresgid
+170	common	spu	getresgid			sys_getresgid
+171	common	spu	prctl				sys_prctl
+172	common	-	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
+173	common	-	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+174	common	-	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+175	common	-	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+176	common	-	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+177	common 	-	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+178	common 	-	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+179	common	spu	pread64				sys_pread64			compat_sys_pread64
+180	common	spu	pwrite64			sys_pwrite64			compat_sys_pwrite64
+181	common	spu	chown				sys_chown
+182	common	spu	getcwd				sys_getcwd
+183	common	spu	capget				sys_capget
+184	common	spu	capset				sys_capset
+185	common	-	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+186	32	-	sendfile			sys_sendfile			compat_sys_sendfile
+186	64	spu	sendfile			sys_sendfile64
+187	common	spu	getpmsg				sys_ni_syscall
+188	common	spu 	putpmsg				sys_ni_syscall
+189	common	-	vfork				ppc_vfork
+190	common	spu	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
+191	common	spu	readahead			sys_readahead			compat_sys_readahead
+192	32	-	mmap2				sys_mmap2			compat_sys_mmap2
+193	32	-	truncate64			sys_truncate64			compat_sys_truncate64
+194	32	-	ftruncate64			sys_ftruncate64			compat_sys_ftruncate64
+195	32	-	stat64				sys_stat64
+196	32	-	lstat64				sys_lstat64
+197	32	-	fstat64				sys_fstat64
+198	common 	-	pciconfig_read			sys_pciconfig_read
+199	common 	-	pciconfig_write			sys_pciconfig_write
+200	common 	-	pciconfig_iobase		sys_pciconfig_iobase
+201	common	spu 	multiplexer			sys_ni_syscall
+202	common	spu	getdents64			sys_getdents64
+203	common	spu	pivot_root			sys_pivot_root
+204	32	-	fcntl64				sys_fcntl64			compat_sys_fcntl64
+205	common	spu	madvise				sys_madvise
+206	common	spu	mincore				sys_mincore
+207	common	spu	gettid				sys_gettid
+208	common	spu	tkill				sys_tkill
+209	common	spu	setxattr			sys_setxattr
+210	common	spu	lsetxattr			sys_lsetxattr
+211	common	spu	fsetxattr			sys_fsetxattr
+212	common	spu	getxattr			sys_getxattr
+213	common	spu	lgetxattr			sys_lgetxattr
+214	common	spu	fgetxattr			sys_fgetxattr
+215	common	spu	listxattr			sys_listxattr
+216	common	spu	llistxattr			sys_llistxattr
+217	common	spu	flistxattr			sys_flistxattr
+218	common	spu	removexattr			sys_removexattr
+219	common	spu	lremovexattr			sys_lremovexattr
+220	common	spu	fremovexattr			sys_fremovexattr
+221	common	spu	futex				sys_futex			compat_sys_futex
+222	common	spu	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
+223	common	spu	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
 # 224 unused
-225	common	tuxcall				sys_ni_syscall
-226	32	sendfile64			sys_sendfile64			compat_sys_sendfile64
-227	common	io_setup			sys_io_setup			compat_sys_io_setup
-228	common	io_destroy			sys_io_destroy
-229	common	io_getevents			sys_io_getevents		compat_sys_io_getevents
-230	common	io_submit			sys_io_submit			compat_sys_io_submit
-231	common	io_cancel			sys_io_cancel
-232	nospu	set_tid_address			sys_set_tid_address
-233	common	fadvise64			sys_fadvise64			ppc32_fadvise64
-234	nospu	exit_group			sys_exit_group
-235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
-236	common	epoll_create			sys_epoll_create
-237	common	epoll_ctl			sys_epoll_ctl
-238	common	epoll_wait			sys_epoll_wait
-239	common	remap_file_pages		sys_remap_file_pages
-240	common	timer_create			sys_timer_create		compat_sys_timer_create
-241	common	timer_settime			sys_timer_settime		compat_sys_timer_settime
-242	common	timer_gettime			sys_timer_gettime		compat_sys_timer_gettime
-243	common	timer_getoverrun		sys_timer_getoverrun
-244	common	timer_delete			sys_timer_delete
-245	common	clock_settime			sys_clock_settime		compat_sys_clock_settime
-246	common	clock_gettime			sys_clock_gettime		compat_sys_clock_gettime
-247	common	clock_getres			sys_clock_getres		compat_sys_clock_getres
-248	common	clock_nanosleep			sys_clock_nanosleep		compat_sys_clock_nanosleep
-249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
-249	64	swapcontext			ppc64_swapcontext
-249	spu	swapcontext			sys_ni_syscall
-250	common	tgkill				sys_tgkill
-251	common	utimes				sys_utimes			compat_sys_utimes
-252	common	statfs64			sys_statfs64			compat_sys_statfs64
-253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
-254	32	fadvise64_64			ppc_fadvise64_64
-254	spu	fadvise64_64			sys_ni_syscall
-255	common	rtas				sys_rtas
-256	32	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
-256	64	sys_debug_setcontext		sys_ni_syscall
-256	spu	sys_debug_setcontext		sys_ni_syscall
+225	common	spu	tuxcall				sys_ni_syscall
+226	32	-	sendfile64			sys_sendfile64			compat_sys_sendfile64
+227	common	spu	io_setup			sys_io_setup			compat_sys_io_setup
+228	common	spu	io_destroy			sys_io_destroy
+229	common	spu	io_getevents			sys_io_getevents		compat_sys_io_getevents
+230	common	spu	io_submit			sys_io_submit			compat_sys_io_submit
+231	common	spu	io_cancel			sys_io_cancel
+232	common	-	set_tid_address			sys_set_tid_address
+233	common	spu	fadvise64			sys_fadvise64			ppc32_fadvise64
+234	common	-	exit_group			sys_exit_group
+235	common	-	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+236	common	spu	epoll_create			sys_epoll_create
+237	common	spu	epoll_ctl			sys_epoll_ctl
+238	common	spu	epoll_wait			sys_epoll_wait
+239	common	spu	remap_file_pages		sys_remap_file_pages
+240	common	spu	timer_create			sys_timer_create		compat_sys_timer_create
+241	common	spu	timer_settime			sys_timer_settime		compat_sys_timer_settime
+242	common	spu	timer_gettime			sys_timer_gettime		compat_sys_timer_gettime
+243	common	spu	timer_getoverrun		sys_timer_getoverrun
+244	common	spu	timer_delete			sys_timer_delete
+245	common	spu	clock_settime			sys_clock_settime		compat_sys_clock_settime
+246	common	spu	clock_gettime			sys_clock_gettime		compat_sys_clock_gettime
+247	common	spu	clock_getres			sys_clock_getres		compat_sys_clock_getres
+248	common	spu	clock_nanosleep			sys_clock_nanosleep		compat_sys_clock_nanosleep
+249	32	-	swapcontext			ppc_swapcontext			ppc32_swapcontext
+249	64	-	swapcontext			ppc64_swapcontext
+250	common	spu	tgkill				sys_tgkill
+251	common	spu	utimes				sys_utimes			compat_sys_utimes
+252	common	spu	statfs64			sys_statfs64			compat_sys_statfs64
+253	common	spu	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
+254	32	-	fadvise64_64			ppc_fadvise64_64
+254	64	spu	fadvise64_64			sys_ni_syscall
+255	common	spu	rtas				sys_rtas
+256	32	-	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
+256	64	-	sys_debug_setcontext		sys_ni_syscall
 # 257 reserved for vserver
-258	nospu	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
-259	nospu	mbind				sys_mbind			compat_sys_mbind
-260	nospu	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
-261	nospu	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
-262	nospu	mq_open				sys_mq_open			compat_sys_mq_open
-263	nospu	mq_unlink			sys_mq_unlink
-264	nospu	mq_timedsend			sys_mq_timedsend		compat_sys_mq_timedsend
-265	nospu	mq_timedreceive			sys_mq_timedreceive		compat_sys_mq_timedreceive
-266	nospu	mq_notify			sys_mq_notify			compat_sys_mq_notify
-267	nospu	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
-268	nospu	kexec_load			sys_kexec_load			compat_sys_kexec_load
-269	nospu	add_key				sys_add_key
-270	nospu	request_key			sys_request_key
-271	nospu	keyctl				sys_keyctl			compat_sys_keyctl
-272	nospu	waitid				sys_waitid			compat_sys_waitid
-273	nospu	ioprio_set			sys_ioprio_set
-274	nospu	ioprio_get			sys_ioprio_get
-275	nospu	inotify_init			sys_inotify_init
-276	nospu	inotify_add_watch		sys_inotify_add_watch
-277	nospu	inotify_rm_watch		sys_inotify_rm_watch
-278	nospu	spu_run				sys_spu_run
-279	nospu	spu_create			sys_spu_create
-280	nospu	pselect6			sys_pselect6			compat_sys_pselect6
-281	nospu	ppoll				sys_ppoll			compat_sys_ppoll
-282	common	unshare				sys_unshare
-283	common	splice				sys_splice
-284	common	tee				sys_tee
-285	common	vmsplice			sys_vmsplice			compat_sys_vmsplice
-286	common	openat				sys_openat			compat_sys_openat
-287	common	mkdirat				sys_mkdirat
-288	common	mknodat				sys_mknodat
-289	common	fchownat			sys_fchownat
-290	common	futimesat			sys_futimesat			compat_sys_futimesat
-291	32	fstatat64			sys_fstatat64
-291	64	newfstatat			sys_newfstatat
-291	spu	newfstatat			sys_newfstatat
-292	common	unlinkat			sys_unlinkat
-293	common	renameat			sys_renameat
-294	common	linkat				sys_linkat
-295	common	symlinkat			sys_symlinkat
-296	common	readlinkat			sys_readlinkat
-297	common	fchmodat			sys_fchmodat
-298	common	faccessat			sys_faccessat
-299	common	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
-300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
-301	common	move_pages			sys_move_pages			compat_sys_move_pages
-302	common	getcpu				sys_getcpu
-303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
-304	common	utimensat			sys_utimensat			compat_sys_utimensat
-305	common	signalfd			sys_signalfd			compat_sys_signalfd
-306	common	timerfd_create			sys_timerfd_create
-307	common	eventfd				sys_eventfd
-308	common	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
-309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
-310	nospu	subpage_prot			sys_subpage_prot
-311	common	timerfd_settime			sys_timerfd_settime		compat_sys_timerfd_settime
-312	common	timerfd_gettime			sys_timerfd_gettime		compat_sys_timerfd_gettime
-313	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
-314	common	eventfd2			sys_eventfd2
-315	common	epoll_create1			sys_epoll_create1
-316	common	dup3				sys_dup3
-317	common	pipe2				sys_pipe2
-318	nospu	inotify_init1			sys_inotify_init1
-319	common	perf_event_open			sys_perf_event_open
-320	common	preadv				sys_preadv			compat_sys_preadv
-321	common	pwritev				sys_pwritev			compat_sys_pwritev
-322	nospu	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-323	nospu	fanotify_init			sys_fanotify_init
-324	nospu	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
-325	common	prlimit64			sys_prlimit64
-326	common	socket				sys_socket
-327	common	bind				sys_bind
-328	common	connect				sys_connect
-329	common	listen				sys_listen
-330	common	accept				sys_accept
-331	common	getsockname			sys_getsockname
-332	common	getpeername			sys_getpeername
-333	common	socketpair			sys_socketpair
-334	common	send				sys_send
-335	common	sendto				sys_sendto
-336	common	recv				sys_recv			compat_sys_recv
-337	common	recvfrom			sys_recvfrom			compat_sys_recvfrom
-338	common	shutdown			sys_shutdown
-339	common	setsockopt			sys_setsockopt			compat_sys_setsockopt
-340	common	getsockopt			sys_getsockopt			compat_sys_getsockopt
-341	common	sendmsg				sys_sendmsg			compat_sys_sendmsg
-342	common	recvmsg				sys_recvmsg			compat_sys_recvmsg
-343	common	recvmmsg			sys_recvmmsg			compat_sys_recvmmsg
-344	common	accept4				sys_accept4
-345	common	name_to_handle_at		sys_name_to_handle_at
-346	common	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
-347	common	clock_adjtime			sys_clock_adjtime		compat_sys_clock_adjtime
-348	common	syncfs				sys_syncfs
-349	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
-350	common	setns				sys_setns
-351	nospu	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
-352	nospu	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
-353	nospu	finit_module			sys_finit_module
-354	nospu	kcmp				sys_kcmp
-355	common	sched_setattr			sys_sched_setattr
-356	common	sched_getattr			sys_sched_getattr
-357	common	renameat2			sys_renameat2
-358	common	seccomp				sys_seccomp
-359	common	getrandom			sys_getrandom
-360	common	memfd_create			sys_memfd_create
-361	common	bpf				sys_bpf
-362	nospu	execveat			sys_execveat			compat_sys_execveat
-363	32	switch_endian			sys_ni_syscall
-363	64	switch_endian			ppc_switch_endian
-363	spu	switch_endian			sys_ni_syscall
-364	common	userfaultfd			sys_userfaultfd
-365	common	membarrier			sys_membarrier
-378	nospu	mlock2				sys_mlock2
-379	nospu	copy_file_range			sys_copy_file_range
-380	common	preadv2				sys_preadv2			compat_sys_preadv2
-381	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
-382	nospu	kexec_file_load			sys_kexec_file_load
-383	nospu	statx				sys_statx
-384	nospu	pkey_alloc			sys_pkey_alloc
-385	nospu	pkey_free			sys_pkey_free
-386	nospu	pkey_mprotect			sys_pkey_mprotect
-387	nospu	rseq				sys_rseq
-388	nospu	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+258	common	-	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+259	common	-	mbind				sys_mbind			compat_sys_mbind
+260	common	-	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
+261	common	-	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+262	common	-	mq_open				sys_mq_open			compat_sys_mq_open
+263	common	-	mq_unlink			sys_mq_unlink
+264	common	-	mq_timedsend			sys_mq_timedsend		compat_sys_mq_timedsend
+265	common	-	mq_timedreceive			sys_mq_timedreceive		compat_sys_mq_timedreceive
+266	common	-	mq_notify			sys_mq_notify			compat_sys_mq_notify
+267	common	-	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+268	common	-	kexec_load			sys_kexec_load			compat_sys_kexec_load
+269	common	-	add_key				sys_add_key
+270	common	-	request_key			sys_request_key
+271	common	-	keyctl				sys_keyctl			compat_sys_keyctl
+272	common	-	waitid				sys_waitid			compat_sys_waitid
+273	common	-	ioprio_set			sys_ioprio_set
+274	common	-	ioprio_get			sys_ioprio_get
+275	common	-	inotify_init			sys_inotify_init
+276	common	-	inotify_add_watch		sys_inotify_add_watch
+277	common	-	inotify_rm_watch		sys_inotify_rm_watch
+278	common	-	spu_run				sys_spu_run
+279	common	-	spu_create			sys_spu_create
+280	common	-	pselect6			sys_pselect6			compat_sys_pselect6
+281	common	-	ppoll				sys_ppoll			compat_sys_ppoll
+282	common	spu	unshare				sys_unshare
+283	common	spu	splice				sys_splice
+284	common	spu	tee				sys_tee
+285	common	spu	vmsplice			sys_vmsplice			compat_sys_vmsplice
+286	common	spu	openat				sys_openat			compat_sys_openat
+287	common	spu	mkdirat				sys_mkdirat
+288	common	spu	mknodat				sys_mknodat
+289	common	spu	fchownat			sys_fchownat
+290	common	spu	futimesat			sys_futimesat			compat_sys_futimesat
+291	32	-	fstatat64			sys_fstatat64
+291	64	spu	newfstatat			sys_newfstatat
+292	common	spu	unlinkat			sys_unlinkat
+293	common	spu	renameat			sys_renameat
+294	common	spu	linkat				sys_linkat
+295	common	spu	symlinkat			sys_symlinkat
+296	common	spu	readlinkat			sys_readlinkat
+297	common	spu	fchmodat			sys_fchmodat
+298	common	spu	faccessat			sys_faccessat
+299	common	spu	get_robust_list			sys_get_robust_list		compat_sys_get_robust_list
+300	common	spu	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
+301	common	spu	move_pages			sys_move_pages			compat_sys_move_pages
+302	common	spu	getcpu				sys_getcpu
+303	common	-	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+304	common	spu	utimensat			sys_utimensat			compat_sys_utimensat
+305	common	spu	signalfd			sys_signalfd			compat_sys_signalfd
+306	common	spu	timerfd_create			sys_timerfd_create
+307	common	spu	eventfd				sys_eventfd
+308	common	spu	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
+309	common	-	fallocate			sys_fallocate			compat_sys_fallocate
+310	common	-	subpage_prot			sys_subpage_prot
+311	common	spu	timerfd_settime			sys_timerfd_settime		compat_sys_timerfd_settime
+312	common	spu	timerfd_gettime			sys_timerfd_gettime		compat_sys_timerfd_gettime
+313	common	spu	signalfd4			sys_signalfd4			compat_sys_signalfd4
+314	common	spu	eventfd2			sys_eventfd2
+315	common	spu	epoll_create1			sys_epoll_create1
+316	common	spu	dup3				sys_dup3
+317	common	spu	pipe2				sys_pipe2
+318	common	-	inotify_init1			sys_inotify_init1
+319	common	spu	perf_event_open			sys_perf_event_open
+320	common	spu	preadv				sys_preadv			compat_sys_preadv
+321	common	spu	pwritev				sys_pwritev			compat_sys_pwritev
+322	common	-	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+323	common	-	fanotify_init			sys_fanotify_init
+324	common	-	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
+325	common	spu	prlimit64			sys_prlimit64
+326	common	spu	socket				sys_socket
+327	common	spu	bind				sys_bind
+328	common	spu	connect				sys_connect
+329	common	spu	listen				sys_listen
+330	common	spu	accept				sys_accept
+331	common	spu	getsockname			sys_getsockname
+332	common	spu	getpeername			sys_getpeername
+333	common	spu	socketpair			sys_socketpair
+334	common	spu	send				sys_send
+335	common	spu	sendto				sys_sendto
+336	common	spu	recv				sys_recv			compat_sys_recv
+337	common	spu	recvfrom			sys_recvfrom			compat_sys_recvfrom
+338	common	spu	shutdown			sys_shutdown
+339	common	spu	setsockopt			sys_setsockopt			compat_sys_setsockopt
+340	common	spu	getsockopt			sys_getsockopt			compat_sys_getsockopt
+341	common	spu	sendmsg				sys_sendmsg			compat_sys_sendmsg
+342	common	spu	recvmsg				sys_recvmsg			compat_sys_recvmsg
+343	common	spu	recvmmsg			sys_recvmmsg			compat_sys_recvmmsg
+344	common	spu	accept4				sys_accept4
+345	common	spu	name_to_handle_at		sys_name_to_handle_at
+346	common	spu	open_by_handle_at		sys_open_by_handle_at		compat_sys_open_by_handle_at
+347	common	spu	clock_adjtime			sys_clock_adjtime		compat_sys_clock_adjtime
+348	common	spu	syncfs				sys_syncfs
+349	common	spu	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
+350	common	spu	setns				sys_setns
+351	common	-	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
+352	common	-	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
+353	common	-	finit_module			sys_finit_module
+354	common	-	kcmp				sys_kcmp
+355	common	spu	sched_setattr			sys_sched_setattr
+356	common	spu	sched_getattr			sys_sched_getattr
+357	common	spu	renameat2			sys_renameat2
+358	common	spu	seccomp				sys_seccomp
+359	common	spu	getrandom			sys_getrandom
+360	common	spu	memfd_create			sys_memfd_create
+361	common	spu	bpf				sys_bpf
+362	common	-	execveat			sys_execveat			compat_sys_execveat
+363	32	-	switch_endian			sys_ni_syscall
+363	64	-	switch_endian			ppc_switch_endian
+364	common	spu	userfaultfd			sys_userfaultfd
+365	common	spu	membarrier			sys_membarrier
+378	common	-	mlock2				sys_mlock2
+379	common	-	copy_file_range			sys_copy_file_range
+380	common	spu	preadv2				sys_preadv2			compat_sys_preadv2
+381	common	spu	pwritev2			sys_pwritev2			compat_sys_pwritev2
+382	common	-	kexec_file_load			sys_kexec_file_load
+383	common	-	statx				sys_statx
+384	common	-	pkey_alloc			sys_pkey_alloc
+385	common	-	pkey_free			sys_pkey_free
+386	common	-	pkey_mprotect			sys_pkey_mprotect
+387	common	-	rseq				sys_rseq
+388	common	-	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
diff --git a/arch/powerpc/kernel/syscalls/syscallhdr.sh b/arch/powerpc/kernel/syscalls/syscallhdr.sh
index 9e066d026eeb..94d7045f819b 100644
--- a/arch/powerpc/kernel/syscalls/syscallhdr.sh
+++ b/arch/powerpc/kernel/syscalls/syscallhdr.sh
@@ -14,7 +14,7 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	printf "\n"
 
 	nxt=0
-	while read nr abi name entry compat ; do
+	while read nr abi spu name entry compat ; do
 		printf "#define __NR_%s\t%s\n" "${name}" "${nr}"
 		nxt=$((nr+1))
 	done
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index 01e57093a51a..c541baa8f2d6 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -21,12 +21,18 @@ emit() {
 grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	nxt=0
 
-	while read nr abi name entry compat ; do
+	while read nr abi spu name entry compat ; do
 		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
 			emit $nxt $nr $compat
+			nxt=$((nr+1))
+		elif [ "$my_abi" = "spu" ]; then
+			if [ "$spu" = "spu" ]; then
+				emit $nxt $nr $entry
+				nxt=$((nr+1))
+			fi
 		else
 			emit $nxt $nr $entry
+			nxt=$((nr+1))
 		fi
-		nxt=$((nr+1))
 	done
 ) > "$out"
-- 
2.20.1

