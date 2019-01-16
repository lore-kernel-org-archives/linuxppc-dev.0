Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C442C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:38:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B4020675
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 13:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B4020675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fpF174jFzDqWC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 00:38:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fp0d2KlpzDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 00:27:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43fp0c1JpYz9sDX; Thu, 17 Jan 2019 00:27:28 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43fp0b0zJBz9sBZ; Thu, 17 Jan 2019 00:27:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH v2 4/5] powerpc/syscalls: Split SPU-ness out of ABI
Date: Thu, 17 Jan 2019 00:27:13 +1100
Message-Id: <20190116132714.20094-4-mpe@ellerman.id.au>
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

Using the ABI field to encode whether a syscall is usable by SPU
programs or not is a bit of kludge.

The ABI of the syscall doesn't change depending on the SPU-ness, but
in order to make the syscall generation work we have to pretend that
it does.

It also means we have more duplicated syscall lines than we need to,
and the SPU logic is not well contained, instead all of the syscall
generation targets need to know if they are spu or nospu.

So instead add a separate file which contains the information on which
syscalls are available for SPU programs. It's just a list of syscall
numbers with a single "spu" field. If the field has the value "spu"
then the syscall is available to SPU programs, any other value or no
entry entirely means the syscall is not available to SPU programs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/syscalls/Makefile      |  16 +-
 arch/powerpc/kernel/syscalls/spu.tbl       | 275 +++++++++++++++++++++
 arch/powerpc/kernel/syscalls/syscall.tbl   | 196 +++++++--------
 arch/powerpc/kernel/syscalls/syscalltbl.sh |  10 +-
 4 files changed, 381 insertions(+), 116 deletions(-)
 create mode 100644 arch/powerpc/kernel/syscalls/spu.tbl

v2: Split the spu information into a separate file rather than a new
column in syscall.tbl.

diff --git a/arch/powerpc/kernel/syscalls/Makefile b/arch/powerpc/kernel/syscalls/Makefile
index 3d9d4e07f725..1a6f57f2fba0 100644
--- a/arch/powerpc/kernel/syscalls/Makefile
+++ b/arch/powerpc/kernel/syscalls/Makefile
@@ -6,6 +6,7 @@ _dummy := $(shell [ -d '$(uapi)' ] || mkdir -p '$(uapi)')	\
 	  $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)')
 
 syscall := $(srctree)/$(src)/syscall.tbl
+sputbl := $(srctree)/$(src)/spu.tbl
 syshdr := $(srctree)/$(src)/syscallhdr.sh
 systbl := $(srctree)/$(src)/syscalltbl.sh
 
@@ -16,32 +17,33 @@ quiet_cmd_syshdr = SYSHDR  $@
 quiet_cmd_systbl = SYSTBL  $@
       cmd_systbl = $(CONFIG_SHELL) '$(systbl)' '$<' '$@'	\
 		   '$(systbl_abis_$(basetarget))'		\
-		   '$(systbl_abi_$(basetarget))'
+		   '$(systbl_abi_$(basetarget))'		\
+		    $(sputbl)
 
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
diff --git a/arch/powerpc/kernel/syscalls/spu.tbl b/arch/powerpc/kernel/syscalls/spu.tbl
new file mode 100644
index 000000000000..f4f114503a98
--- /dev/null
+++ b/arch/powerpc/kernel/syscalls/spu.tbl
@@ -0,0 +1,275 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# The format is:
+# <number> <spu?>
+#
+# To indicate a syscall can be used by SPU programs use "spu" for the spu column.
+#
+# Syscalls that are not to be used by SPU programs can be left out of the file
+# entirely, or an entry with a value other than "spu" can be added.
+#
+3	spu
+4	spu
+5	spu
+6	spu
+7	spu
+8	spu
+9	spu
+10	spu
+12	spu
+13	spu
+14	spu
+15	spu
+16	spu
+17	spu
+19	spu
+20	spu
+23	spu
+24	spu
+25	spu
+27	spu
+31	spu
+32	spu
+33	spu
+34	spu
+35	spu
+36	spu
+37	spu
+38	spu
+39	spu
+40	spu
+41	spu
+42	spu
+43	spu
+44	spu
+45	spu
+46	spu
+47	spu
+49	spu
+50	spu
+53	spu
+54	spu
+55	spu
+56	spu
+57	spu
+58	spu
+60	spu
+61	spu
+63	spu
+64	spu
+65	spu
+66	spu
+68	spu
+69	spu
+70	spu
+71	spu
+74	spu
+75	spu
+77	spu
+78	spu
+79	spu
+80	spu
+81	spu
+83	spu
+85	spu
+90	spu
+91	spu
+92	spu
+93	spu
+94	spu
+95	spu
+96	spu
+97	spu
+98	spu
+101	spu
+102	spu
+103	spu
+104	spu
+105	spu
+106	spu
+107	spu
+108	spu
+110	spu
+111	spu
+112	spu
+113	spu
+114	spu
+116	spu
+118	spu
+121	spu
+122	spu
+123	spu
+124	spu
+125	spu
+127	spu
+130	spu
+132	spu
+133	spu
+134	spu
+135	spu
+136	spu
+137	spu
+138	spu
+139	spu
+140	spu
+141	spu
+142	spu
+143	spu
+144	spu
+145	spu
+146	spu
+147	spu
+148	spu
+150	spu
+151	spu
+152	spu
+153	spu
+154	spu
+155	spu
+156	spu
+157	spu
+158	spu
+159	spu
+160	spu
+161	spu
+162	spu
+163	spu
+164	spu
+165	spu
+166	spu
+167	spu
+168	spu
+169	spu
+170	spu
+171	spu
+179	spu
+180	spu
+181	spu
+182	spu
+183	spu
+184	spu
+186	spu
+187	spu
+188	spu
+190	spu
+191	spu
+201	spu
+202	spu
+203	spu
+205	spu
+206	spu
+207	spu
+208	spu
+209	spu
+210	spu
+211	spu
+212	spu
+213	spu
+214	spu
+215	spu
+216	spu
+217	spu
+218	spu
+219	spu
+220	spu
+221	spu
+222	spu
+223	spu
+225	spu
+227	spu
+228	spu
+229	spu
+230	spu
+231	spu
+233	spu
+236	spu
+237	spu
+238	spu
+239	spu
+240	spu
+241	spu
+242	spu
+243	spu
+244	spu
+245	spu
+246	spu
+247	spu
+248	spu
+250	spu
+251	spu
+252	spu
+253	spu
+255	spu
+282	spu
+283	spu
+284	spu
+285	spu
+286	spu
+287	spu
+288	spu
+289	spu
+290	spu
+291	spu
+292	spu
+293	spu
+294	spu
+295	spu
+296	spu
+297	spu
+298	spu
+299	spu
+300	spu
+301	spu
+302	spu
+304	spu
+305	spu
+306	spu
+307	spu
+308	spu
+311	spu
+312	spu
+313	spu
+314	spu
+315	spu
+316	spu
+317	spu
+319	spu
+320	spu
+321	spu
+325	spu
+326	spu
+327	spu
+328	spu
+329	spu
+330	spu
+331	spu
+332	spu
+333	spu
+334	spu
+335	spu
+336	spu
+337	spu
+338	spu
+339	spu
+340	spu
+341	spu
+342	spu
+343	spu
+344	spu
+345	spu
+346	spu
+347	spu
+348	spu
+349	spu
+350	spu
+355	spu
+356	spu
+357	spu
+358	spu
+359	spu
+360	spu
+361	spu
+364	spu
+365	spu
+380	spu
+381	spu
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index db3bbb8744af..c5907a2dbc86 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -5,11 +5,11 @@
 # The format is:
 # <number> <abi> <name> <entry point> <compat entry point>
 #
-# The <abi> can be common, spu, nospu, 64, or 32 for this file.
+# The <abi> can be common, 64, or 32 for this file.
 #
-0	nospu	restart_syscall			sys_restart_syscall
-1	nospu	exit				sys_exit
-2	nospu	fork				ppc_fork
+0	common	restart_syscall			sys_restart_syscall
+1	common	exit				sys_exit
+2	common	fork				ppc_fork
 3	common	read				sys_read
 4	common	write				sys_write
 5	common	open				sys_open			compat_sys_open
@@ -18,7 +18,7 @@
 8	common	creat				sys_creat
 9	common	link				sys_link
 10	common	unlink				sys_unlink
-11	nospu	execve				sys_execve			compat_sys_execve
+11	common	execve				sys_execve			compat_sys_execve
 12	common	chdir				sys_chdir
 13	common	time				sys_time			compat_sys_time
 14	common	mknod				sys_mknod
@@ -27,23 +27,20 @@
 17	common	break				sys_ni_syscall
 18	32	oldstat				sys_stat			sys_ni_syscall
 18	64	oldstat				sys_ni_syscall
-18	spu	oldstat				sys_ni_syscall
 19	common	lseek				sys_lseek			compat_sys_lseek
 20	common	getpid				sys_getpid
-21	nospu	mount				sys_mount			compat_sys_mount
+21	common	mount				sys_mount			compat_sys_mount
 22	32	umount				sys_oldumount
 22	64	umount				sys_ni_syscall
-22	spu	umount				sys_ni_syscall
 23	common	setuid				sys_setuid
 24	common	getuid				sys_getuid
 25	common	stime				sys_stime			compat_sys_stime
-26	nospu	ptrace				sys_ptrace			compat_sys_ptrace
+26	common	ptrace				sys_ptrace			compat_sys_ptrace
 27	common	alarm				sys_alarm
 28	32	oldfstat			sys_fstat			sys_ni_syscall
 28	64	oldfstat			sys_ni_syscall
-28	spu	oldfstat			sys_ni_syscall
-29	nospu	pause				sys_pause
-30	nospu	utime				sys_utime			compat_sys_utime
+29	common	pause				sys_pause
+30	common	utime				sys_utime			compat_sys_utime
 31	common	stty				sys_ni_syscall
 32	common	gtty				sys_ni_syscall
 33	common	access				sys_access
@@ -61,11 +58,11 @@
 45	common	brk				sys_brk
 46	common	setgid				sys_setgid
 47	common	getgid				sys_getgid
-48	nospu	signal				sys_signal
+48	common	signal				sys_signal
 49	common	geteuid				sys_geteuid
 50	common	getegid				sys_getegid
-51	nospu	acct				sys_acct
-52	nospu	umount2				sys_umount
+51	common	acct				sys_acct
+52	common	umount2				sys_umount
 53	common	lock				sys_ni_syscall
 54	common	ioctl				sys_ioctl			compat_sys_ioctl
 55	common	fcntl				sys_fcntl			compat_sys_fcntl
@@ -74,32 +71,27 @@
 58	common	ulimit				sys_ni_syscall
 59	32	oldolduname			sys_olduname
 59	64	oldolduname			sys_ni_syscall
-59	spu	oldolduname			sys_ni_syscall
 60	common	umask				sys_umask
 61	common	chroot				sys_chroot
-62	nospu	ustat				sys_ustat			compat_sys_ustat
+62	common	ustat				sys_ustat			compat_sys_ustat
 63	common	dup2				sys_dup2
 64	common	getppid				sys_getppid
 65	common	getpgrp				sys_getpgrp
 66	common	setsid				sys_setsid
 67	32	sigaction			sys_sigaction			compat_sys_sigaction
 67	64	sigaction			sys_ni_syscall
-67	spu	sigaction			sys_ni_syscall
 68	common	sgetmask			sys_sgetmask
 69	common	ssetmask			sys_ssetmask
 70	common	setreuid			sys_setreuid
 71	common	setregid			sys_setregid
 72	32	sigsuspend			sys_sigsuspend
 72	64	sigsuspend			sys_ni_syscall
-72	spu	sigsuspend			sys_ni_syscall
 73	32	sigpending			sys_sigpending			compat_sys_sigpending
 73	64	sigpending			sys_ni_syscall
-73	spu	sigpending			sys_ni_syscall
 74	common	sethostname			sys_sethostname
 75	common	setrlimit			sys_setrlimit			compat_sys_setrlimit
 76	32	getrlimit			sys_old_getrlimit		compat_sys_old_getrlimit
 76	64	getrlimit			sys_ni_syscall
-76	spu	getrlimit			sys_ni_syscall
 77	common	getrusage			sys_getrusage			compat_sys_getrusage
 78	common	gettimeofday			sys_gettimeofday		compat_sys_gettimeofday
 79	common	settimeofday			sys_settimeofday		compat_sys_settimeofday
@@ -107,18 +99,15 @@
 81	common	setgroups			sys_setgroups
 82	32	select				ppc_select			sys_ni_syscall
 82	64	select				sys_ni_syscall
-82	spu	select				sys_ni_syscall
 83	common	symlink				sys_symlink
 84	32	oldlstat			sys_lstat			sys_ni_syscall
 84	64	oldlstat			sys_ni_syscall
-84	spu	oldlstat			sys_ni_syscall
 85	common	readlink			sys_readlink
-86	nospu	uselib				sys_uselib
-87	nospu	swapon				sys_swapon
-88	nospu	reboot				sys_reboot
+86	common	uselib				sys_uselib
+87	common	swapon				sys_swapon
+88	common	reboot				sys_reboot
 89	32	readdir				sys_old_readdir			compat_sys_old_readdir
 89	64	readdir				sys_ni_syscall
-89	spu	readdir				sys_ni_syscall
 90	common	mmap				sys_mmap
 91	common	munmap				sys_munmap
 92	common	truncate			sys_truncate			compat_sys_truncate
@@ -128,8 +117,8 @@
 96	common	getpriority			sys_getpriority
 97	common	setpriority			sys_setpriority
 98	common	profil				sys_ni_syscall
-99	nospu	statfs				sys_statfs			compat_sys_statfs
-100	nospu	fstatfs				sys_fstatfs			compat_sys_fstatfs
+99	common	statfs				sys_statfs			compat_sys_statfs
+100	common	fstatfs				sys_fstatfs			compat_sys_fstatfs
 101	common	ioperm				sys_ni_syscall
 102	common	socketcall			sys_socketcall			compat_sys_socketcall
 103	common	syslog				sys_syslog
@@ -140,20 +129,18 @@
 108	common	fstat				sys_newfstat			compat_sys_newfstat
 109	32	olduname			sys_uname
 109	64	olduname			sys_ni_syscall
-109	spu	olduname			sys_ni_syscall
 110	common	iopl				sys_ni_syscall
 111	common	vhangup				sys_vhangup
 112	common	idle				sys_ni_syscall
 113	common	vm86				sys_ni_syscall
 114	common	wait4				sys_wait4			compat_sys_wait4
-115	nospu	swapoff				sys_swapoff
+115	common	swapoff				sys_swapoff
 116	common	sysinfo				sys_sysinfo			compat_sys_sysinfo
-117	nospu	ipc				sys_ipc				compat_sys_ipc
+117	common	ipc				sys_ipc				compat_sys_ipc
 118	common	fsync				sys_fsync
 119	32	sigreturn			sys_sigreturn			compat_sys_sigreturn
 119	64	sigreturn			sys_ni_syscall
-119	spu	sigreturn			sys_ni_syscall
-120	nospu	clone				ppc_clone
+120	common	clone				ppc_clone
 121	common	setdomainname			sys_setdomainname
 122	common	uname				sys_newuname
 123	common	modify_ldt			sys_ni_syscall
@@ -161,19 +148,17 @@
 125	common	mprotect			sys_mprotect
 126	32	sigprocmask			sys_sigprocmask			compat_sys_sigprocmask
 126	64	sigprocmask			sys_ni_syscall
-126	spu	sigprocmask			sys_ni_syscall
 127	common	create_module			sys_ni_syscall
-128	nospu	init_module			sys_init_module
-129	nospu	delete_module			sys_delete_module
+128	common	init_module			sys_init_module
+129	common	delete_module			sys_delete_module
 130	common	get_kernel_syms			sys_ni_syscall
-131	nospu	quotactl			sys_quotactl
+131	common	quotactl			sys_quotactl
 132	common	getpgid				sys_getpgid
 133	common	fchdir				sys_fchdir
 134	common	bdflush				sys_bdflush
 135	common	sysfs				sys_sysfs
 136	32	personality			sys_personality			ppc64_personality
 136	64	personality			ppc64_personality
-136	spu	personality			ppc64_personality
 137	common	afs_syscall			sys_ni_syscall
 138	common	setfsuid			sys_setfsuid
 139	common	setfsgid			sys_setfsgid
@@ -186,7 +171,7 @@
 146	common	writev				sys_writev			compat_sys_writev
 147	common	getsid				sys_getsid
 148	common	fdatasync			sys_fdatasync
-149	nospu	_sysctl				sys_sysctl			compat_sys_sysctl
+149	common	_sysctl				sys_sysctl			compat_sys_sysctl
 150	common	mlock				sys_mlock
 151	common	munlock				sys_munlock
 152	common	mlockall			sys_mlockall
@@ -209,26 +194,25 @@
 169	common	setresgid			sys_setresgid
 170	common	getresgid			sys_getresgid
 171	common	prctl				sys_prctl
-172	nospu	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
-173	nospu	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
-174	nospu	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
-175	nospu	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
-176	nospu	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
-177	nospu 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
-178	nospu 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+172	common	rt_sigreturn			sys_rt_sigreturn		compat_sys_rt_sigreturn
+173	common	rt_sigaction			sys_rt_sigaction		compat_sys_rt_sigaction
+174	common	rt_sigprocmask			sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+175	common	rt_sigpending			sys_rt_sigpending		compat_sys_rt_sigpending
+176	common	rt_sigtimedwait			sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait
+177	common 	rt_sigqueueinfo			sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+178	common 	rt_sigsuspend			sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 179	common	pread64				sys_pread64			compat_sys_pread64
 180	common	pwrite64			sys_pwrite64			compat_sys_pwrite64
 181	common	chown				sys_chown
 182	common	getcwd				sys_getcwd
 183	common	capget				sys_capget
 184	common	capset				sys_capset
-185	nospu	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
+185	common	sigaltstack			sys_sigaltstack			compat_sys_sigaltstack
 186	32	sendfile			sys_sendfile			compat_sys_sendfile
 186	64	sendfile			sys_sendfile64
-186	spu	sendfile			sys_sendfile64
 187	common	getpmsg				sys_ni_syscall
-188	common 	putpmsg				sys_ni_syscall
-189	nospu	vfork				ppc_vfork
+188	common	putpmsg				sys_ni_syscall
+189	common	vfork				ppc_vfork
 190	common	ugetrlimit			sys_getrlimit			compat_sys_getrlimit
 191	common	readahead			sys_readahead			compat_sys_readahead
 192	32	mmap2				sys_mmap2			compat_sys_mmap2
@@ -237,10 +221,10 @@
 195	32	stat64				sys_stat64
 196	32	lstat64				sys_lstat64
 197	32	fstat64				sys_fstat64
-198	nospu 	pciconfig_read			sys_pciconfig_read
-199	nospu 	pciconfig_write			sys_pciconfig_write
-200	nospu 	pciconfig_iobase		sys_pciconfig_iobase
-201	common 	multiplexer			sys_ni_syscall
+198	common 	pciconfig_read			sys_pciconfig_read
+199	common 	pciconfig_write			sys_pciconfig_write
+200	common 	pciconfig_iobase		sys_pciconfig_iobase
+201	common	multiplexer			sys_ni_syscall
 202	common	getdents64			sys_getdents64
 203	common	pivot_root			sys_pivot_root
 204	32	fcntl64				sys_fcntl64			compat_sys_fcntl64
@@ -271,10 +255,10 @@
 229	common	io_getevents			sys_io_getevents		compat_sys_io_getevents
 230	common	io_submit			sys_io_submit			compat_sys_io_submit
 231	common	io_cancel			sys_io_cancel
-232	nospu	set_tid_address			sys_set_tid_address
+232	common	set_tid_address			sys_set_tid_address
 233	common	fadvise64			sys_fadvise64			ppc32_fadvise64
-234	nospu	exit_group			sys_exit_group
-235	nospu	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
+234	common	exit_group			sys_exit_group
+235	common	lookup_dcookie			sys_lookup_dcookie		compat_sys_lookup_dcookie
 236	common	epoll_create			sys_epoll_create
 237	common	epoll_ctl			sys_epoll_ctl
 238	common	epoll_wait			sys_epoll_wait
@@ -290,42 +274,40 @@
 248	common	clock_nanosleep			sys_clock_nanosleep		compat_sys_clock_nanosleep
 249	32	swapcontext			ppc_swapcontext			ppc32_swapcontext
 249	64	swapcontext			ppc64_swapcontext
-249	spu	swapcontext			sys_ni_syscall
 250	common	tgkill				sys_tgkill
 251	common	utimes				sys_utimes			compat_sys_utimes
 252	common	statfs64			sys_statfs64			compat_sys_statfs64
 253	common	fstatfs64			sys_fstatfs64			compat_sys_fstatfs64
 254	32	fadvise64_64			ppc_fadvise64_64
-254	spu	fadvise64_64			sys_ni_syscall
+254	64	fadvise64_64			sys_ni_syscall
 255	common	rtas				sys_rtas
 256	32	sys_debug_setcontext		sys_debug_setcontext		sys_ni_syscall
 256	64	sys_debug_setcontext		sys_ni_syscall
-256	spu	sys_debug_setcontext		sys_ni_syscall
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
+258	common	migrate_pages			sys_migrate_pages		compat_sys_migrate_pages
+259	common	mbind				sys_mbind			compat_sys_mbind
+260	common	get_mempolicy			sys_get_mempolicy		compat_sys_get_mempolicy
+261	common	set_mempolicy			sys_set_mempolicy		compat_sys_set_mempolicy
+262	common	mq_open				sys_mq_open			compat_sys_mq_open
+263	common	mq_unlink			sys_mq_unlink
+264	common	mq_timedsend			sys_mq_timedsend		compat_sys_mq_timedsend
+265	common	mq_timedreceive			sys_mq_timedreceive		compat_sys_mq_timedreceive
+266	common	mq_notify			sys_mq_notify			compat_sys_mq_notify
+267	common	mq_getsetattr			sys_mq_getsetattr		compat_sys_mq_getsetattr
+268	common	kexec_load			sys_kexec_load			compat_sys_kexec_load
+269	common	add_key				sys_add_key
+270	common	request_key			sys_request_key
+271	common	keyctl				sys_keyctl			compat_sys_keyctl
+272	common	waitid				sys_waitid			compat_sys_waitid
+273	common	ioprio_set			sys_ioprio_set
+274	common	ioprio_get			sys_ioprio_get
+275	common	inotify_init			sys_inotify_init
+276	common	inotify_add_watch		sys_inotify_add_watch
+277	common	inotify_rm_watch		sys_inotify_rm_watch
+278	common	spu_run				sys_spu_run
+279	common	spu_create			sys_spu_create
+280	common	pselect6			sys_pselect6			compat_sys_pselect6
+281	common	ppoll				sys_ppoll			compat_sys_ppoll
 282	common	unshare				sys_unshare
 283	common	splice				sys_splice
 284	common	tee				sys_tee
@@ -337,7 +319,6 @@
 290	common	futimesat			sys_futimesat			compat_sys_futimesat
 291	32	fstatat64			sys_fstatat64
 291	64	newfstatat			sys_newfstatat
-291	spu	newfstatat			sys_newfstatat
 292	common	unlinkat			sys_unlinkat
 293	common	renameat			sys_renameat
 294	common	linkat				sys_linkat
@@ -349,14 +330,14 @@
 300	common	set_robust_list			sys_set_robust_list		compat_sys_set_robust_list
 301	common	move_pages			sys_move_pages			compat_sys_move_pages
 302	common	getcpu				sys_getcpu
-303	nospu	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
+303	common	epoll_pwait			sys_epoll_pwait			compat_sys_epoll_pwait
 304	common	utimensat			sys_utimensat			compat_sys_utimensat
 305	common	signalfd			sys_signalfd			compat_sys_signalfd
 306	common	timerfd_create			sys_timerfd_create
 307	common	eventfd				sys_eventfd
 308	common	sync_file_range2		sys_sync_file_range2		compat_sys_sync_file_range2
-309	nospu	fallocate			sys_fallocate			compat_sys_fallocate
-310	nospu	subpage_prot			sys_subpage_prot
+309	common	fallocate			sys_fallocate			compat_sys_fallocate
+310	common	subpage_prot			sys_subpage_prot
 311	common	timerfd_settime			sys_timerfd_settime		compat_sys_timerfd_settime
 312	common	timerfd_gettime			sys_timerfd_gettime		compat_sys_timerfd_gettime
 313	common	signalfd4			sys_signalfd4			compat_sys_signalfd4
@@ -364,13 +345,13 @@
 315	common	epoll_create1			sys_epoll_create1
 316	common	dup3				sys_dup3
 317	common	pipe2				sys_pipe2
-318	nospu	inotify_init1			sys_inotify_init1
+318	common	inotify_init1			sys_inotify_init1
 319	common	perf_event_open			sys_perf_event_open
 320	common	preadv				sys_preadv			compat_sys_preadv
 321	common	pwritev				sys_pwritev			compat_sys_pwritev
-322	nospu	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-323	nospu	fanotify_init			sys_fanotify_init
-324	nospu	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
+322	common	rt_tgsigqueueinfo		sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+323	common	fanotify_init			sys_fanotify_init
+324	common	fanotify_mark			sys_fanotify_mark		compat_sys_fanotify_mark
 325	common	prlimit64			sys_prlimit64
 326	common	socket				sys_socket
 327	common	bind				sys_bind
@@ -397,10 +378,10 @@
 348	common	syncfs				sys_syncfs
 349	common	sendmmsg			sys_sendmmsg			compat_sys_sendmmsg
 350	common	setns				sys_setns
-351	nospu	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
-352	nospu	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
-353	nospu	finit_module			sys_finit_module
-354	nospu	kcmp				sys_kcmp
+351	common	process_vm_readv		sys_process_vm_readv		compat_sys_process_vm_readv
+352	common	process_vm_writev		sys_process_vm_writev		compat_sys_process_vm_writev
+353	common	finit_module			sys_finit_module
+354	common	kcmp				sys_kcmp
 355	common	sched_setattr			sys_sched_setattr
 356	common	sched_getattr			sys_sched_getattr
 357	common	renameat2			sys_renameat2
@@ -408,20 +389,19 @@
 359	common	getrandom			sys_getrandom
 360	common	memfd_create			sys_memfd_create
 361	common	bpf				sys_bpf
-362	nospu	execveat			sys_execveat			compat_sys_execveat
+362	common	execveat			sys_execveat			compat_sys_execveat
 363	32	switch_endian			sys_ni_syscall
 363	64	switch_endian			ppc_switch_endian
-363	spu	switch_endian			sys_ni_syscall
 364	common	userfaultfd			sys_userfaultfd
 365	common	membarrier			sys_membarrier
-378	nospu	mlock2				sys_mlock2
-379	nospu	copy_file_range			sys_copy_file_range
+378	common	mlock2				sys_mlock2
+379	common	copy_file_range			sys_copy_file_range
 380	common	preadv2				sys_preadv2			compat_sys_preadv2
 381	common	pwritev2			sys_pwritev2			compat_sys_pwritev2
-382	nospu	kexec_file_load			sys_kexec_file_load
-383	nospu	statx				sys_statx
-384	nospu	pkey_alloc			sys_pkey_alloc
-385	nospu	pkey_free			sys_pkey_free
-386	nospu	pkey_mprotect			sys_pkey_mprotect
-387	nospu	rseq				sys_rseq
-388	nospu	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
+382	common	kexec_file_load			sys_kexec_file_load
+383	common	statx				sys_statx
+384	common	pkey_alloc			sys_pkey_alloc
+385	common	pkey_free			sys_pkey_free
+386	common	pkey_mprotect			sys_pkey_mprotect
+387	common	rseq				sys_rseq
+388	common	io_pgetevents			sys_io_pgetevents		compat_sys_io_pgetevents
diff --git a/arch/powerpc/kernel/syscalls/syscalltbl.sh b/arch/powerpc/kernel/syscalls/syscalltbl.sh
index 01e57093a51a..0e98a6d64b5f 100644
--- a/arch/powerpc/kernel/syscalls/syscalltbl.sh
+++ b/arch/powerpc/kernel/syscalls/syscalltbl.sh
@@ -5,6 +5,7 @@ in="$1"
 out="$2"
 my_abis=`echo "($3)" | tr ',' '|'`
 my_abi="$4"
+spu_table="$5"
 
 emit() {
 	t_nxt="$1"
@@ -24,9 +25,16 @@ grep -E "^[0-9A-Fa-fXx]+[[:space:]]+${my_abis}" "$in" | sort -n | (
 	while read nr abi name entry compat ; do
 		if [ "$my_abi" = "c32" ] && [ ! -z "$compat" ]; then
 			emit $nxt $nr $compat
+			nxt=$((nr+1))
+		elif [ "$my_abi" = "spu" ]; then
+			grep -E "^$nr[[:space:]]+spu[[:space:]]*$" "$spu_table" > /dev/null
+			if [ $? -eq 0 ]; then
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

