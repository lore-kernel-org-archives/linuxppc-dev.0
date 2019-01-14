Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1858FC43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:44:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A71E20659
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 11:44:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A71E20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dWpj3JxZzDqW4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 22:44:29 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dWdV4FG4zDqT7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 22:36:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43dWdV08Cvz9s9G; Mon, 14 Jan 2019 22:36:30 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43dWdT5cJHz9sLt; Mon, 14 Jan 2019 22:36:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 4/5] powerpc/syscalls: Allow none instead of sys_ni_syscall
Date: Mon, 14 Jan 2019 22:36:19 +1100
Message-Id: <20190114113620.17558-4-mpe@ellerman.id.au>
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

diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 67fb1e48cd68..89e97c0e88bb 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -25,28 +25,28 @@
 14	common	spu	mknod				sys_mknod
 15	common	spu	chmod				sys_chmod
 16	common	spu	lchown				sys_lchown
-17	common	spu	break				sys_ni_syscall
-18	32	-	oldstat				sys_stat			sys_ni_syscall
-18	64	-	oldstat				sys_ni_syscall
+17	common	spu	break				none
+18	32	-	oldstat				sys_stat			none
+18	64	-	oldstat				none
 19	common	spu	lseek				sys_lseek			compat_sys_lseek
 20	common	spu	getpid				sys_getpid
 21	common	-	mount				sys_mount			compat_sys_mount
 22	32	-	umount				sys_oldumount
-22	64	spu	umount				sys_ni_syscall
+22	64	spu	umount				none
 23	common	spu	setuid				sys_setuid
 24	common	spu	getuid				sys_getuid
 25	common	spu	stime				sys_stime			compat_sys_stime
 26	common	-	ptrace				sys_ptrace			compat_sys_ptrace
 27	common	spu	alarm				sys_alarm
-28	32	-	oldfstat			sys_fstat			sys_ni_syscall
-28	64	-	oldfstat			sys_ni_syscall
+28	32	-	oldfstat			sys_fstat			none
+28	64	-	oldfstat			none
 29	common	-	pause				sys_pause
 30	common	-	utime				sys_utime			compat_sys_utime
-31	common	spu	stty				sys_ni_syscall
-32	common	spu	gtty				sys_ni_syscall
+31	common	spu	stty				none
+32	common	spu	gtty				none
 33	common	spu	access				sys_access
 34	common	spu	nice				sys_nice
-35	common	spu	ftime				sys_ni_syscall
+35	common	spu	ftime				none
 36	common	spu	sync				sys_sync
 37	common	spu	kill				sys_kill
 38	common	spu	rename				sys_rename
@@ -55,7 +55,7 @@
 41	common	spu	dup				sys_dup
 42	common	spu	pipe				sys_pipe
 43	common	spu	times				sys_times			compat_sys_times
-44	common	spu	prof				sys_ni_syscall
+44	common	spu	prof				none
 45	common	spu	brk				sys_brk
 46	common	spu	setgid				sys_setgid
 47	common	spu	getgid				sys_getgid
@@ -64,14 +64,14 @@
 50	common	spu	getegid				sys_getegid
 51	common	-	acct				sys_acct
 52	common	-	umount2				sys_umount
-53	common	spu	lock				sys_ni_syscall
+53	common	spu	lock				none
 54	common	spu	ioctl				sys_ioctl			compat_sys_ioctl
 55	common	spu	fcntl				sys_fcntl			compat_sys_fcntl
-56	common	spu	mpx				sys_ni_syscall
+56	common	spu	mpx				none
 57	common	spu	setpgid				sys_setpgid
-58	common	spu	ulimit				sys_ni_syscall
+58	common	spu	ulimit				none
 59	32	-	oldolduname			sys_olduname
-59	64	-	oldolduname			sys_ni_syscall
+59	64	-	oldolduname			none
 60	common	spu	umask				sys_umask
 61	common	spu	chroot				sys_chroot
 62	common	-	ustat				sys_ustat			compat_sys_ustat
@@ -80,35 +80,35 @@
 65	common	spu	getpgrp				sys_getpgrp
 66	common	spu	setsid				sys_setsid
 67	32	-	sigaction			sys_sigaction			compat_sys_sigaction
-67	64	-	sigaction			sys_ni_syscall
+67	64	-	sigaction			none
 68	common	spu	sgetmask			sys_sgetmask
 69	common	spu	ssetmask			sys_ssetmask
 70	common	spu	setreuid			sys_setreuid
 71	common	spu	setregid			sys_setregid
 72	32	-	sigsuspend			sys_sigsuspend
-72	64	-	sigsuspend			sys_ni_syscall
+72	64	-	sigsuspend			none
 73	32	-	sigpending			sys_sigpending			compat_sys_sigpending
-73	64	-	sigpending			sys_ni_syscall
+73	64	-	sigpending			none
 74	common	spu	sethostname			sys_sethostname
 75	common	spu	setrlimit			sys_setrlimit			compat_sys_setrlimit
 76	32	-	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
-76	64	-	getrlimit			sys_ni_syscall
+76	64	-	getrlimit			none
 77	common	spu	getrusage			sys_getrusage			compat_sys_getrusage
 78	common	spu	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
 79	common	spu	settimeofday			sys_settimeofday		compat_sys_settimeofday
 80	common	spu	getgroups			sys_getgroups
 81	common	spu	setgroups			sys_setgroups
-82	32	-	select				ppc_select			sys_ni_syscall
-82	64	-	select				sys_ni_syscall
+82	32	-	select				ppc_select			none
+82	64	-	select				none
 83	common	spu	symlink				sys_symlink
-84	32	-	oldlstat			sys_lstat			sys_ni_syscall
-84	64	-	oldlstat			sys_ni_syscall
+84	32	-	oldlstat			sys_lstat			none
+84	64	-	oldlstat			none
 85	common	spu	readlink			sys_readlink
 86	common	-	uselib				sys_uselib
 87	common	-	swapon				sys_swapon
 88	common	-	reboot				sys_reboot
 89	32	-	readdir				sys_old_readdir			compat_sys_old_readdir
-89	64	-	readdir				sys_ni_syscall
+89	64	-	readdir				none
 90	common	spu	mmap				sys_mmap
 91	common	spu	munmap				sys_munmap
 92	common	spu	truncate			sys_truncate			compat_sys_truncate
@@ -117,10 +117,10 @@
 95	common	spu	fchown				sys_fchown
 96	common	spu	getpriority			sys_getpriority
 97	common	spu	setpriority			sys_setpriority
-98	common	spu	profil				sys_ni_syscall
+98	common	spu	profil				none
 99	common	-	statfs				sys_statfs			compat_sys_statfs
 100	common	-	fstatfs				sys_fstatfs			compat_sys_fstatfs
-101	common	spu	ioperm				sys_ni_syscall
+101	common	spu	ioperm				none
 102	common	spu	socketcall			sys_socketcall			compat_sys_socketcall
 103	common	spu	syslog				sys_syslog
 104	common	spu	setitimer			sys_setitimer			compat_sys_setitimer
@@ -129,30 +129,30 @@
 107	common	spu	lstat				sys_newlstat			compat_sys_newlstat
 108	common	spu	fstat				sys_newfstat			compat_sys_newfstat
 109	32	-	olduname			sys_uname
-109	64	-	olduname			sys_ni_syscall
-110	common	spu	iopl				sys_ni_syscall
+109	64	-	olduname			none
+110	common	spu	iopl				none
 111	common	spu	vhangup				sys_vhangup
-112	common	spu	idle				sys_ni_syscall
-113	common	spu	vm86				sys_ni_syscall
+112	common	spu	idle				none
+113	common	spu	vm86				none
 114	common	spu	wait4				sys_wait4			compat_sys_wait4
 115	common	-	swapoff				sys_swapoff
 116	common	spu	sysinfo				sys_sysinfo			compat_sys_sysinfo
 117	common	-	ipc				sys_ipc				compat_sys_ipc
 118	common	spu	fsync				sys_fsync
 119	32	-	sigreturn			sys_sigreturn			compat_sys_sigreturn
-119	64	-	sigreturn			sys_ni_syscall
+119	64	-	sigreturn			none
 120	common	-	clone				ppc_clone
 121	common	spu	setdomainname			sys_setdomainname
 122	common	spu	uname				sys_newuname
-123	common	spu	modify_ldt			sys_ni_syscall
+123	common	spu	modify_ldt			none
 124	common	spu	adjtimex			sys_adjtimex			compat_sys_adjtimex
 125	common	spu	mprotect			sys_mprotect
 126	32	-	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
-126	64	-	sigprocmask			sys_ni_syscall
-127	common	spu	create_module			sys_ni_syscall
+126	64	-	sigprocmask			none
+127	common	spu	create_module			none
 128	common	-	init_module			sys_init_module
 129	common	-	delete_module			sys_delete_module
-130	common	spu	get_kernel_syms			sys_ni_syscall
+130	common	spu	get_kernel_syms			none
 131	common	-	quotactl			sys_quotactl
 132	common	spu	getpgid				sys_getpgid
 133	common	spu	fchdir				sys_fchdir
@@ -160,7 +160,7 @@
 135	common	spu	sysfs				sys_sysfs
 136	32	-	personality			sys_personality			ppc64_personality
 136	64	spu	personality			ppc64_personality
-137	common	spu	afs_syscall			sys_ni_syscall
+137	common	spu	afs_syscall			none
 138	common	spu	setfsuid			sys_setfsuid
 139	common	spu	setfsgid			sys_setfsgid
 140	common	spu	_llseek				sys_llseek
@@ -189,9 +189,9 @@
 163	common	spu	mremap				sys_mremap
 164	common	spu	setresuid			sys_setresuid
 165	common	spu	getresuid			sys_getresuid
-166	common	spu	query_module			sys_ni_syscall
+166	common	spu	query_module			none
 167	common	spu	poll				sys_poll
-168	common	spu	nfsservctl			sys_ni_syscall
+168	common	spu	nfsservctl			none
 169	common	spu	setresgid			sys_setresgid
 170	common	spu	getresgid			sys_getresgid
 171	common	spu	prctl				sys_prctl
@@ -211,8 +211,8 @@
 185	common	-	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
 186	32	-	sendfile			sys_sendfile			compat_sys_sendfile
 186	64	spu	sendfile			sys_sendfile64
-187	common	spu	getpmsg				sys_ni_syscall
-188	common	spu 	putpmsg				sys_ni_syscall
+187	common	spu	getpmsg				none
+188	common	spu 	putpmsg				none
 189	common	-	vfork				ppc_vfork
 190	common	spu	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	common	spu	readahead			sys_readahead			compat_sys_readahead
@@ -225,7 +225,7 @@
 198	common 	-	pciconfig_read			sys_pciconfig_read
 199	common 	-	pciconfig_write			sys_pciconfig_write
 200	common 	-	pciconfig_iobase		sys_pciconfig_iobase
-201	common	spu 	multiplexer			sys_ni_syscall
+201	common	spu 	multiplexer			none
 202	common	spu	getdents64			sys_getdents64
 203	common	spu	pivot_root			sys_pivot_root
 204	32	-	fcntl64				sys_fcntl64			compat_sys_fcntl64
@@ -249,7 +249,7 @@
 222	common	spu	sched_setaffinity		sys_sched_setaffinity		compat_sys_sched_setaffinity
 223	common	spu	sched_getaffinity		sys_sched_getaffinity		compat_sys_sched_getaffinity
 # 224 unused
-225	common	spu	tuxcall				sys_ni_syscall
+225	common	spu	tuxcall				none
 226	32	-	sendfile64			sys_sendfile64			compat_sys_sendfile64
 227	common	spu	io_setup			sys_io_setup			compat_sys_io_setup
 228	common	spu	io_destroy			sys_io_destroy
@@ -280,10 +280,10 @@
 252	common	spu	statfs64			sys_statfs64			compat_sys_statfs64
 253	common	spu	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
 254	32	-	fadvise64_64			ppc_fadvise64_64
-254	64	spu	fadvise64_64			sys_ni_syscall
+254	64	spu	fadvise64_64			none
 255	common	spu	rtas				sys_rtas
-256	32	-	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
-256	64	-	sys_debug_setcontext		sys_ni_syscall
+256	32	-	sys_debug_setcontext		sys_debug_setcontext		none
+256	64	-	sys_debug_setcontext		none
 # 257 reserved for vserver
 258	common	-	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
 259	common	-	mbind				sys_mbind			compat_sys_mbind
@@ -391,7 +391,7 @@
 360	common	spu	memfd_create			sys_memfd_create
 361	common	spu	bpf				sys_bpf
 362	common	-	execveat			sys_execveat			compat_sys_execveat
-363	32	-	switch_endian			sys_ni_syscall
+363	32	-	switch_endian			none
 363	64	-	switch_endian			ppc_switch_endian
 364	common	spu	userfaultfd			sys_userfaultfd
 365	common	spu	membarrier			sys_membarrier
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index c541baa8f2d6..094de5e9ead5 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -11,6 +11,10 @@ emit() {
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

