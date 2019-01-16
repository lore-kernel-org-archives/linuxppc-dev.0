Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8205C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:39:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C0E120675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0E120675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fpGr3X0jzDqV1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:39:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fp0f67tNzDqQ0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:27:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43fp0d5Dvlz9sD9; Thu, 17 Jan 2019 00:27:29 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43fp0d0v7vz9sMr; Thu, 17 Jan 2019 00:27:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH v2 5/5] powerpc/syscalls: Allow none instead of
 sys_ni_syscall
Date: Thu, 17 Jan 2019 00:27:14 +1100
Message-Id: <20190116132714.20094-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116132714.20094-1-mpe@ellerman.id.au>
References: <20190116132714.20094-1-mpe@ellerman.id.au>
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

sys_ni_syscall is the "not-implemented" syscall syscall, which just
returns -ENOSYS.

But unless you know that it's not obvious what it does, and even if
you do know what it means it doesn't stand out that well from other
real syscalls.

So teach the scripts to treat "none" as a synonym for
"sys_ni_syscall". This makes the table more readable.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/syscalls/syscall.tbl   | 90 +++++++++++-----------
 arch/powerpc/kernel/syscalls/syscalltbl.sh |  4 +
 2 files changed, 49 insertions(+), 45 deletions(-)

v2: Rebase on top of SPU change.

diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index c5907a2dbc86..988a7e29245f 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -24,28 +24,28 @@
 14	common	mknod				sys_mknod
 15	common	chmod				sys_chmod
 16	common	lchown				sys_lchown
-17	common	break				sys_ni_syscall
-18	32	oldstat				sys_stat			sys_ni_syscall
-18	64	oldstat				sys_ni_syscall
+17	common	break				none
+18	32	oldstat				sys_stat			none
+18	64	oldstat				none
 19	common	lseek				sys_lseek			compat_sys_lseek
 20	common	getpid				sys_getpid
 21	common	mount				sys_mount			compat_sys_mount
 22	32	umount				sys_oldumount
-22	64	umount				sys_ni_syscall
+22	64	umount				none
 23	common	setuid				sys_setuid
 24	common	getuid				sys_getuid
 25	common	stime				sys_stime			compat_sys_stime
 26	common	ptrace				sys_ptrace			compat_sys_ptrace
 27	common	alarm				sys_alarm
-28	32	oldfstat			sys_fstat			sys_ni_syscall
-28	64	oldfstat			sys_ni_syscall
+28	32	oldfstat			sys_fstat			none
+28	64	oldfstat			none
 29	common	pause				sys_pause
 30	common	utime				sys_utime			compat_sys_utime
-31	common	stty				sys_ni_syscall
-32	common	gtty				sys_ni_syscall
+31	common	stty				none
+32	common	gtty				none
 33	common	access				sys_access
 34	common	nice				sys_nice
-35	common	ftime				sys_ni_syscall
+35	common	ftime				none
 36	common	sync				sys_sync
 37	common	kill				sys_kill
 38	common	rename				sys_rename
@@ -54,7 +54,7 @@
 41	common	dup				sys_dup
 42	common	pipe				sys_pipe
 43	common	times				sys_times			compat_sys_times
-44	common	prof				sys_ni_syscall
+44	common	prof				none
 45	common	brk				sys_brk
 46	common	setgid				sys_setgid
 47	common	getgid				sys_getgid
@@ -63,14 +63,14 @@
 50	common	getegid				sys_getegid
 51	common	acct				sys_acct
 52	common	umount2				sys_umount
-53	common	lock				sys_ni_syscall
+53	common	lock				none
 54	common	ioctl				sys_ioctl			compat_sys_ioctl
 55	common	fcntl				sys_fcntl			compat_sys_fcntl
-56	common	mpx				sys_ni_syscall
+56	common	mpx				none
 57	common	setpgid				sys_setpgid
-58	common	ulimit				sys_ni_syscall
+58	common	ulimit				none
 59	32	oldolduname			sys_olduname
-59	64	oldolduname			sys_ni_syscall
+59	64	oldolduname			none
 60	common	umask				sys_umask
 61	common	chroot				sys_chroot
 62	common	ustat				sys_ustat			compat_sys_ustat
@@ -79,35 +79,35 @@
 65	common	getpgrp				sys_getpgrp
 66	common	setsid				sys_setsid
 67	32	sigaction			sys_sigaction			compat_sys_sigaction
-67	64	sigaction			sys_ni_syscall
+67	64	sigaction			none
 68	common	sgetmask			sys_sgetmask
 69	common	ssetmask			sys_ssetmask
 70	common	setreuid			sys_setreuid
 71	common	setregid			sys_setregid
 72	32	sigsuspend			sys_sigsuspend
-72	64	sigsuspend			sys_ni_syscall
+72	64	sigsuspend			none
 73	32	sigpending			sys_sigpending			compat_sys_sigpending
-73	64	sigpending			sys_ni_syscall
+73	64	sigpending			none
 74	common	sethostname			sys_sethostname
 75	common	setrlimit			sys_setrlimit			compat_sys_setrlimit
 76	32	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
-76	64	getrlimit			sys_ni_syscall
+76	64	getrlimit			none
 77	common	getrusage			sys_getrusage			compat_sys_getrusage
 78	common	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
 79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
 80	common	getgroups			sys_getgroups
 81	common	setgroups			sys_setgroups
-82	32	select				ppc_select			sys_ni_syscall
-82	64	select				sys_ni_syscall
+82	32	select				ppc_select			none
+82	64	select				none
 83	common	symlink				sys_symlink
-84	32	oldlstat			sys_lstat			sys_ni_syscall
-84	64	oldlstat			sys_ni_syscall
+84	32	oldlstat			sys_lstat			none
+84	64	oldlstat			none
 85	common	readlink			sys_readlink
 86	common	uselib				sys_uselib
 87	common	swapon				sys_swapon
 88	common	reboot				sys_reboot
 89	32	readdir				sys_old_readdir			compat_sys_old_readdir
-89	64	readdir				sys_ni_syscall
+89	64	readdir				none
 90	common	mmap				sys_mmap
 91	common	munmap				sys_munmap
 92	common	truncate			sys_truncate			compat_sys_truncate
@@ -116,10 +116,10 @@
 95	common	fchown				sys_fchown
 96	common	getpriority			sys_getpriority
 97	common	setpriority			sys_setpriority
-98	common	profil				sys_ni_syscall
+98	common	profil				none
 99	common	statfs				sys_statfs			compat_sys_statfs
 100	common	fstatfs				sys_fstatfs			compat_sys_fstatfs
-101	common	ioperm				sys_ni_syscall
+101	common	ioperm				none
 102	common	socketcall			sys_socketcall			compat_sys_socketcall
 103	common	syslog				sys_syslog
 104	common	setitimer			sys_setitimer			compat_sys_setitimer
@@ -128,30 +128,30 @@
 107	common	lstat				sys_newlstat			compat_sys_newlstat
 108	common	fstat				sys_newfstat			compat_sys_newfstat
 109	32	olduname			sys_uname
-109	64	olduname			sys_ni_syscall
-110	common	iopl				sys_ni_syscall
+109	64	olduname			none
+110	common	iopl				none
 111	common	vhangup				sys_vhangup
-112	common	idle				sys_ni_syscall
-113	common	vm86				sys_ni_syscall
+112	common	idle				none
+113	common	vm86				none
 114	common	wait4				sys_wait4			compat_sys_wait4
 115	common	swapoff				sys_swapoff
 116	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
 117	common	ipc				sys_ipc				compat_sys_ipc
 118	common	fsync				sys_fsync
 119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
-119	64	sigreturn			sys_ni_syscall
+119	64	sigreturn			none
 120	common	clone				ppc_clone
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
-123	common	modify_ldt			sys_ni_syscall
+123	common	modify_ldt			none
 124	common	adjtimex			sys_adjtimex			compat_sys_adjtimex
 125	common	mprotect			sys_mprotect
 126	32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
-126	64	sigprocmask			sys_ni_syscall
-127	common	create_module			sys_ni_syscall
+126	64	sigprocmask			none
+127	common	create_module			none
 128	common	init_module			sys_init_module
 129	common	delete_module			sys_delete_module
-130	common	get_kernel_syms			sys_ni_syscall
+130	common	get_kernel_syms			none
 131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
@@ -159,7 +159,7 @@
 135	common	sysfs				sys_sysfs
 136	32	personality			sys_personality			ppc64_personality
 136	64	personality			ppc64_personality
-137	common	afs_syscall			sys_ni_syscall
+137	common	afs_syscall			none
 138	common	setfsuid			sys_setfsuid
 139	common	setfsgid			sys_setfsgid
 140	common	_llseek				sys_llseek
@@ -188,9 +188,9 @@
 163	common	mremap				sys_mremap
 164	common	setresuid			sys_setresuid
 165	common	getresuid			sys_getresuid
-166	common	query_module			sys_ni_syscall
+166	common	query_module			none
 167	common	poll				sys_poll
-168	common	nfsservctl			sys_ni_syscall
+168	common	nfsservctl			none
 169	common	setresgid			sys_setresgid
 170	common	getresgid			sys_getresgid
 171	common	prctl				sys_prctl
@@ -210,8 +210,8 @@
 185	common	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
 186	32	sendfile			sys_sendfile			compat_sys_sendfile
 186	64	sendfile			sys_sendfile64
-187	common	getpmsg				sys_ni_syscall
-188	common	putpmsg				sys_ni_syscall
+187	common	getpmsg				none
+188	common	putpmsg				none
 189	common	vfork				ppc_vfork
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	common	readahead			sys_readahead			compat_sys_readahead
@@ -224,7 +224,7 @@
 198	common 	pciconfig_read			sys_pciconfig_read
 199	common 	pciconfig_write			sys_pciconfig_write
 200	common 	pciconfig_iobase		sys_pciconfig_iobase
-201	common	multiplexer			sys_ni_syscall
+201	common	multiplexer			none
 202	common	getdents64			sys_getdents64
 203	common	pivot_root			sys_pivot_root
 204	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
@@ -248,7 +248,7 @@
 222	common	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
 223	common	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
 # 224 unused
-225	common	tuxcall				sys_ni_syscall
+225	common	tuxcall				none
 226	32	sendfile64			sys_sendfile64			compat_sys_sendfile64
 227	common	io_setup			sys_io_setup			compat_sys_io_setup
 228	common	io_destroy			sys_io_destroy
@@ -279,10 +279,10 @@
 252	common	statfs64			sys_statfs64			compat_sys_statfs64
 253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
 254	32	fadvise64_64			ppc_fadvise64_64
-254	64	fadvise64_64			sys_ni_syscall
+254	64	fadvise64_64			none
 255	common	rtas				sys_rtas
-256	32	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
-256	64	sys_debug_setcontext		sys_ni_syscall
+256	32	sys_debug_setcontext		sys_debug_setcontext		none
+256	64	sys_debug_setcontext		none
 # 257 reserved for vserver
 258	common	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
 259	common	mbind				sys_mbind			compat_sys_mbind
@@ -390,7 +390,7 @@
 360	common	memfd_create			sys_memfd_create
 361	common	bpf				sys_bpf
 362	common	execveat			sys_execveat			compat_sys_execveat
-363	32	switch_endian			sys_ni_syscall
+363	32	switch_endian			none
 363	64	switch_endian			ppc_switch_endian
 364	common	userfaultfd			sys_userfaultfd
 365	common	membarrier			sys_membarrier
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index 0e98a6d64b5f..f9987e265f3f 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -12,6 +12,10 @@ emit() {
 	t_nr="$2"
 	t_entry="$3"
 
+	if [ "$t_entry" = "none" ]; then
+		t_entry="sys_ni_syscall"
+	fi
+
 	while [ $t_nxt -lt $t_nr ]; do
 		printf "__SYSCALL(%s,sys_ni_syscall, )\n" "${t_nxt}"
 		t_nxt=$((t_nxt+1))
-- 
2.20.1

