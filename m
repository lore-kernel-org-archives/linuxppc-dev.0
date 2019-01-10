Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46090C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:44:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20DA20685
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 17:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20DA20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bD0G4KPYzDqqD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 04:44:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bCfW0HHfzDqhY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 04:29:22 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N0o3X-1hSiHB2IRJ-00wl1W; Thu, 10 Jan 2019 18:22:36 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] y2038: add 64-bit time_t syscalls to all 32-bit
 architectures
Date: Thu, 10 Jan 2019 18:22:16 +0100
Message-Id: <20190110172216.313063-12-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110172216.313063-1-arnd@arndb.de>
References: <20190110172216.313063-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:r+IkUoP0oXwm41891g6lc/Fh4dgpRDbdJ2L0q0r25FU+D7aqvIj
 dvYUG+j56TfNpTSjZEBykSMw+LjDUGm9qxTWvuu3M9O1e3juY/f1mE0PUc0zVEeCjlXPWr8
 VnicKr845WwSUzM2qrvKSAm0Wc9Iltd0jPIjd9bvgW+70DOeVVM8TP6sPkvrVX+eHIKUUQN
 OnSlkKB9M7L+8h2yjog6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:p/ZMqWYFf7g=:z/HKRiN9m3H0xSTzzwgyDl
 Qz5KGmxvghaYpdnSfIxQi/Kwb/dW/7OGL/cObIJdNIJB9yZD0z6lo91+FwQqy9snvBOf84dZr
 bcbypLZjEeIPd1DupWW8IAxI48gHqf9IaU15ymbDoWrM+SDCsAP1/M1KZLFMg2uPUbux4E105
 c5JKAWNZI19mHF1nU35r8qtdyOnJVPMV+QtPJ3HI6R2bYE503RSzZHJHapZzeECh+Fz32vHtW
 u8p4XFeR4VkzJAk0yPAwTkF0HLsuKKVRtnFJkcsJvmVRXyLpCy1Mz7lQQkpJdeEu2EqiWWpNk
 wHf/juhQGw+UDB/HjopGcl6Igj7AMhpQyohGvrW8np9unmMNycrlh5hqwkp2/ayjb6RdWP6RU
 drwCAf6OegHfSRodreGiQvP1K8d7hWako/aa0tR6y7gUvLmb4u57F5mF9OnYfh5fRArnVRbJB
 fRFwRHiYba8L0JJuHn7EoJB/fP3ihNpqHhA1sLYP81criH/p0rC6NtMLTjJlDv/el3aLuRzbc
 JxdmSL36j1Q1f+wJWsK/fAv3qfl4pS0L0lyE9/r1aGQRctx4MJ063NVTTTTQr5ISG1hjvPzZG
 ug1CgM4uvdqNUxgnRqgVEodFy7JJSoeQZ3DE9ubYSzA1gC7I8NZwulTXGEKL6BN5pe8n2Sf1T
 HlFBT01QehtsL+/+QyAVBKjSKAWqk8DjlimYkUGlahQKoE+U02UWVX11HUmljj74rLfPGzRSg
 3V+zS+47bTZhI5+RYtWGm2/9VrB3g51oPTn9+w==
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
Cc: dalias@libc.org, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org,
 catalin.marinas@arm.com, will.deacon@arm.com, jcmvbkbc@gmail.com,
 deepa.kernel@gmail.com, hpa@zytor.com, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, deller@gmx.de,
 x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
 firoz.khan@linaro.org, mattst88@gmail.com, fenghua.yu@intel.com,
 Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-fsdevel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 monstr@monstr.eu, tony.luck@intel.com, linux-parisc@vger.kernel.org,
 netdev@vger.kernel.org, linux-mips@vger.kernel.org, paul.burton@mips.com,
 ebiederm@xmission.com, linux-alpha@vger.kernel.org, schwidefsky@de.ibm.com,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This adds 21 new system calls on each ABI that has 32-bit time_t
today. All of these have the exact same semantics as their existing
counterparts, and the new ones all have macro names that end in 'time64'
for clarification.

This gets us to the point of being able to safely use a C library
that has 64-bit time_t in user space. There are still a couple of
loose ends to tie up in various areas of the code, but this is the
big one, and should be entirely uncontroversial at this point.

In particular, there are four system calls (getitimer, setitimer,
waitid, and getrusage) that don't have a 64-bit counterpart yet,
but these can all be safely implemented in the C library by wrapping
around the existing system calls because the 32-bit time_t they
pass only counts elapsed time, not time since the epoch. They
will be dealt with later.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The one point that still needs to be agreed on is the actual
number assignment. Following the earlier patch that added
the sysv IPC calls with common numbers where possible, I also
tried the same here, using consistent numbers on all 32-bit
architectures.

There are a couple of minor issues with this:

- On asm-generic, we now leave the numbers from 295 to 402
  unassigned, which wastes a small amount of kernel .data
  segment. Originally I had asm-generic start at 300 and
  everyone else start at 400 here, which was also not
  perfect, and we have gone beyond 400 already, so I ended
  up just using the same numbers as the rest here.

- Once we get to 512, we clash with the x32 numbers (unless
  we remove x32 support first), and probably have to skip
  a few more. I also considered using the 512..547 space
  for 32-bit-only calls (which never clash with x32), but
  that also seems to add a bit of complexity.

- On alpha, we have already used up the space up to 527
  (with a small hole between 261 and 299). We could sync
  up with that as well, but my feeling was that alpha syscalls
  are already special enough that I don't care.

Let me know if you have other ideas.
---
 arch/alpha/kernel/syscalls/syscall.tbl      |  2 +
 arch/arm/tools/syscall.tbl                  | 21 ++++++++++
 arch/arm64/include/asm/unistd.h             |  2 +-
 arch/arm64/include/asm/unistd32.h           | 41 +++++++++++++++++++
 arch/ia64/kernel/syscalls/syscall.tbl       |  1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 20 +++++++++
 arch/microblaze/kernel/syscalls/syscall.tbl | 21 ++++++++++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 21 ++++++++++
 arch/mips/kernel/syscalls/syscall_n64.tbl   |  1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 20 +++++++++
 arch/parisc/kernel/syscalls/syscall.tbl     | 21 ++++++++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 20 +++++++++
 arch/s390/kernel/syscalls/syscall.tbl       | 20 +++++++++
 arch/sh/kernel/syscalls/syscall.tbl         | 20 +++++++++
 arch/sparc/kernel/syscalls/syscall.tbl      | 20 +++++++++
 arch/x86/entry/syscalls/syscall_32.tbl      | 20 +++++++++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 21 ++++++++++
 include/uapi/asm-generic/unistd.h           | 45 ++++++++++++++++++++-
 scripts/checksyscalls.sh                    | 40 ++++++++++++++++++
 19 files changed, 375 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 25b4a7e76943..04d96d042180 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -456,3 +456,5 @@
 525	common	pkey_free			sys_pkey_free
 526	common	pkey_mprotect			sys_pkey_mprotect
 527	common	rseq				sys_rseq
+# all other architectures have common numbers for new syscall, alpha
+# is the exception.
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index a96d9b5ee04e..286afdc43283 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -416,3 +416,24 @@
 399	common	io_pgetevents		sys_io_pgetevents_time32
 400	common	migrate_pages		sys_migrate_pages
 401	common	kexec_file_load		sys_kexec_file_load
+# 402 is unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceiv_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 2c30e6f145ff..d1dd93436e1e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		402
+#define __NR_compat_syscalls		424
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 3ecec626fb0f..23c73db53d28 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -825,6 +825,47 @@ __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
 __SYSCALL(__NR_migrate_pages, sys_migrate_pages)
 #define __NR_kexec_file_load 401
 __SYSCALL(__NR_kexec_file_load, sys_kexec_file_load)
+/* 402 is unused */
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SYSCALL(__NR_pselect6_time64, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SYSCALL(__NR_ppoll_time64, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SYSCALL(__NR_recvmmsg_time64, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceiv_time64 419
+__SYSCALL(__NR_mq_timedreceiv_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SYSCALL(__NR_rt_sigtimedwait_time64, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 84e03de00177..ae18c430301c 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -343,3 +343,4 @@
 331	common	pkey_free			sys_pkey_free
 332	common	pkey_mprotect			sys_pkey_mprotect
 333	common	rseq				sys_rseq
+# 334 through 423 are reserved to sync up with other architectures
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index dec78dc5b056..da627bef806e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -403,3 +403,23 @@
 400	common	msgsnd				sys_msgsnd
 401	common	msgrcv				sys_msgrcv
 402	common	msgctl				sys_msgctl
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceiv_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 44a87649d681..5ca6677c0437 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -408,3 +408,24 @@
 398	common	statx				sys_statx
 399	common	io_pgetevents			sys_io_pgetevents_time32
 400	common	rseq				sys_rseq
+# 401 and 402 are unused
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceiv_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 6d1e019817c8..6218e3a08438 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -341,3 +341,24 @@
 330	n32	statx				sys_statx
 331	n32	rseq				sys_rseq
 332	n32	io_pgetevents			compat_sys_io_pgetevents
+# 333 through 402 are unassigned to sync up with generic numbers
+403	n32	clock_gettime64			sys_clock_gettime
+404	n32	clock_settime64			sys_clock_settime
+405	n32	clock_adjtime64			sys_clock_adjtime
+406	n32	clock_getres_time64		sys_clock_getres
+407	n32	clock_nanosleep_time64		sys_clock_nanosleep
+408	n32	timer_gettime64			sys_timer_gettime
+409	n32	timer_settime64			sys_timer_settime
+410	n32	timerfd_gettime64		sys_timerfd_gettime
+411	n32	timerfd_settime64		sys_timerfd_settime
+412	n32	utimensat_time64		sys_utimensat
+413	n32	pselect6_time64			compat_sys_pselect6_time64
+414	n32	ppoll_time64			compat_sys_ppoll_time64
+416	n32	io_pgetevents_time64		sys_io_pgetevents
+417	n32	recvmmsg_time64			compat_sys_recvmmsg_time64
+418	n32	mq_timedsend_time64		sys_mq_timedsend
+419	n32	mq_timedreceiv_time64		sys_mq_timedreceive
+420	n32	semtimedop_time64		sys_semtimedop
+421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
+422	n32	futex_time64			sys_futex
+423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index af0da757a7b2..c85502e67b44 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -337,3 +337,4 @@
 326	n64	statx				sys_statx
 327	n64	rseq				sys_rseq
 328	n64	io_pgetevents			sys_io_pgetevents
+# 329 through 423 are reserved to sync up with other architectures
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 54312c5b5343..0be1cddeda0c 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -391,3 +391,23 @@
 400	o32	msgsnd				sys_msgsnd			compat_sys_msgsnd
 401	o32	msgrcv				sys_msgrcv			compat_sys_msgrcv
 402	o32	msgctl				sys_msgctl			compat_sys_msgctl
+403	o32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	o32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	o32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	o32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	o32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	o32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	o32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	o32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	o32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	o32	utimensat_time64		sys_utimensat			sys_utimensat
+413	o32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	o32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	o32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	o32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	o32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	o32	mq_timedreceiv_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	o32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	o32	futex_time64			sys_futex			sys_futex
+423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 2521cd561769..51ae690484e4 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -399,3 +399,24 @@
 352	common	pkey_free		sys_pkey_free
 353	common	pkey_mprotect		sys_pkey_mprotect
 354	common	rseq			sys_rseq
+# 355 through 402 are unassigned to sync up with generic numbers
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceiv_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index ed02c21bb5a2..5c0936d862fc 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -484,3 +484,23 @@
 400	common	msgsnd				sys_msgsnd			compat_sys_msgsnd
 401	common	msgrcv				sys_msgrcv			compat_sys_msgrcv
 402	common	msgctl				sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceiv_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index b3199a744731..bc763c0bb245 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -406,3 +406,23 @@
 400  common	msgsnd			sys_msgsnd			compat_sys_msgsnd
 401  common	msgrcv			sys_msgrcv			compat_sys_msgrcv
 402  common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64		-				sys_clock_gettime
+404	32	clock_settime64		-				sys_clock_settime
+405	32	clock_adjtime64		-				sys_clock_adjtime
+406	32	clock_getres_time64	-				sys_clock_getres
+407	32	clock_nanosleep_time64	-				sys_clock_nanosleep
+408	32	timer_gettime64		-				sys_timer_gettime
+409	32	timer_settime64		-				sys_timer_settime
+410	32	timerfd_gettime64	-				sys_timerfd_gettime
+411	32	timerfd_settime64	-				sys_timerfd_settime
+412	32	utimensat_time64	-				sys_utimensat
+413	32	pselect6_time64		-				compat_sys_pselect6_time64
+414	32	ppoll_time64		-				compat_sys_ppoll_time64
+416	32	io_pgetevents_time64	-				sys_io_pgetevents
+417	32	recvmmsg_time64		-				compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64	-				sys_mq_timedsend
+419	32	mq_timedreceiv_time64	-				sys_mq_timedreceive
+420	32	semtimedop_time64	-				sys_semtimedop
+421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64		-				sys_futex
+423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index d3993b305cab..dcf3f8c91652 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -406,3 +406,23 @@
 400	common	msgsnd				sys_msgsnd
 401	common	msgrcv				sys_msgrcv
 402	common	msgctl				sys_msgctl
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceiv_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index fde7491f76e8..18858a7eea02 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -449,3 +449,23 @@
 400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
 401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
 402	common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		sys_io_pgetevents
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceiv_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 1ad4b1c5417d..b21ddeeb43cb 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -409,3 +409,23 @@
 400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
 401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
 402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
+403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
+404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
+405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
+406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
+407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nanosleep
+408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
+409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
+410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
+411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
+412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
+413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
+414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
+416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
+417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
+418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
+419	i386	mq_timedreceiv_time64	sys_mq_timedreceive		__ia32_sys_mq_timedreceive
+420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
+421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
+422	i386	futex_time64		sys_futex			__ia32_sys_futex
+423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sys_sched_rr_get_interval
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 482673389e21..f63e1d8c0437 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -373,3 +373,24 @@
 350	common	pkey_free			sys_pkey_free
 351	common	statx				sys_statx
 352	common	rseq				sys_rseq
+# 353 through 402 are unassigned to sync up with generic numbers
+403	common	clock_gettime64			sys_clock_gettime
+404	common	clock_settime64			sys_clock_settime
+405	common	clock_adjtime64			sys_clock_adjtime
+406	common	clock_getres_time64		sys_clock_getres
+407	common	clock_nanosleep_time64		sys_clock_nanosleep
+408	common	timer_gettime64			sys_timer_gettime
+409	common	timer_settime64			sys_timer_settime
+410	common	timerfd_gettime64		sys_timerfd_gettime
+411	common	timerfd_settime64		sys_timerfd_settime
+412	common	utimensat_time64		sys_utimensat
+413	common	pselect6_time64			sys_pselect6
+414	common	ppoll_time64			sys_ppoll
+416	common	io_pgetevents_time64		sys_io_pgetevents
+417	common	recvmmsg_time64			sys_recvmmsg
+418	common	mq_timedsend_time64		sys_mq_timedsend
+419	common	mq_timedreceiv_time64		sys_mq_timedreceive
+420	common	semtimedop_time64		sys_semtimedop
+421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
+422	common	futex_time64			sys_futex
+423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index af38c660c857..b8626863a90f 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -740,9 +740,52 @@ __SC_COMP_3264(__NR_io_pgetevents, sys_io_pgetevents_time32, sys_io_pgetevents,
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
+/* 295 through 402 are unassigned to sync up with generic numbers */
+#if __BITS_PER_LONG == 32
+#define __NR_clock_gettime64 403
+__SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
+#define __NR_clock_settime64 404
+__SYSCALL(__NR_clock_settime64, sys_clock_settime)
+#define __NR_clock_adjtime64 405
+__SYSCALL(__NR_clock_adjtime64, sys_clock_adjtime)
+#define __NR_clock_getres_time64 406
+__SYSCALL(__NR_clock_getres_time64, sys_clock_getres)
+#define __NR_clock_nanosleep_time64 407
+__SYSCALL(__NR_clock_nanosleep_time64, sys_clock_nanosleep)
+#define __NR_timer_gettime64 408
+__SYSCALL(__NR_timer_gettime64, sys_timer_gettime)
+#define __NR_timer_settime64 409
+__SYSCALL(__NR_timer_settime64, sys_timer_settime)
+#define __NR_timerfd_gettime64 410
+__SYSCALL(__NR_timerfd_gettime64, sys_timerfd_gettime)
+#define __NR_timerfd_settime64 411
+__SYSCALL(__NR_timerfd_settime64, sys_timerfd_settime)
+#define __NR_utimensat_time64 412
+__SYSCALL(__NR_utimensat_time64, sys_utimensat)
+#define __NR_pselect6_time64 413
+__SC_COMP(__NR_pselect6_time64, sys_pselect6, compat_sys_pselect6_time64)
+#define __NR_ppoll_time64 414
+__SC_COMP(__NR_ppoll_time64, sys_ppoll, compat_sys_ppoll_time64)
+#define __NR_io_pgetevents_time64 416
+__SYSCALL(__NR_io_pgetevents_time64, sys_io_pgetevents)
+#define __NR_recvmmsg_time64 417
+__SC_COMP(__NR_recvmmsg_time64, sys_recvmmsg, compat_sys_recvmmsg_time64)
+#define __NR_mq_timedsend_time64 418
+__SYSCALL(__NR_mq_timedsend_time64, sys_mq_timedsend)
+#define __NR_mq_timedreceiv_time64 419
+__SYSCALL(__NR_mq_timedreceiv_time64, sys_mq_timedreceive)
+#define __NR_semtimedop_time64 420
+__SYSCALL(__NR_semtimedop_time64, sys_semtimedop)
+#define __NR_rt_sigtimedwait_time64 421
+__SC_COMP(__NR_rt_sigtimedwait_time64, sys_rt_sigtimedwait, compat_sys_rt_sigtimedwait_time64)
+#define __NR_futex_time64 422
+__SYSCALL(__NR_futex_time64, sys_futex)
+#define __NR_sched_rr_get_interval_time64 423
+__SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#endif
 
 #undef __NR_syscalls
-#define __NR_syscalls 295
+#define __NR_syscalls 424
 
 /*
  * 32 bit systems traditionally used different
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index cf931003395f..45aac9dac53b 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -84,6 +84,26 @@ cat << EOF
 #define __IGNORE_statfs64
 #define __IGNORE_llseek
 #define __IGNORE_mmap2
+#define __IGNORE_clock_gettime64
+#define __IGNORE_clock_settime64
+#define __IGNORE_clock_adjtime64
+#define __IGNORE_clock_getres_time64
+#define __IGNORE_clock_nanosleep_time64
+#define __IGNORE_timer_gettime64
+#define __IGNORE_timer_settime64
+#define __IGNORE_timerfd_gettime64
+#define __IGNORE_timerfd_settime64
+#define __IGNORE_utimensat_time64
+#define __IGNORE_pselect6_time64
+#define __IGNORE_ppoll_time64
+#define __IGNORE_io_pgetevents_time64
+#define __IGNORE_recvmmsg_time64
+#define __IGNORE_mq_timedsend_time64
+#define __IGNORE_mq_timedreceiv_time64
+#define __IGNORE_semtimedop_time64
+#define __IGNORE_rt_sigtimedwait_time64
+#define __IGNORE_futex_time64
+#define __IGNORE_sched_rr_get_interval_time64
 #else
 #define __IGNORE_sendfile
 #define __IGNORE_ftruncate
@@ -98,6 +118,26 @@ cat << EOF
 #define __IGNORE_statfs
 #define __IGNORE_lseek
 #define __IGNORE_mmap
+#define __IGNORE_clock_gettime
+#define __IGNORE_clock_settime
+#define __IGNORE_clock_adjtime
+#define __IGNORE_clock_getres
+#define __IGNORE_clock_nanosleep
+#define __IGNORE_timer_gettime
+#define __IGNORE_timer_settime
+#define __IGNORE_timerfd_gettime
+#define __IGNORE_timerfd_settime
+#define __IGNORE_utimensat
+#define __IGNORE_pselect6
+#define __IGNORE_ppoll
+#define __IGNORE_io_pgetevents
+#define __IGNORE_recvmmsg
+#define __IGNORE_mq_timedsend
+#define __IGNORE_mq_timedreceiv
+#define __IGNORE_semtimedop
+#define __IGNORE_rt_sigtimedwait
+#define __IGNORE_futex
+#define __IGNORE_sched_rr_get_interval
 #endif
 
 /* i386-specific or historical system calls */
-- 
2.20.0

