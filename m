Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB6C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 14:51:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C8E20811
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 14:51:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C8E20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44ScfB5vZlzDqHx
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 01:51:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.187; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Scc12mzvzDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 01:49:30 +1100 (AEDT)
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MirfI-1gVosU3XTY-00evvU; Mon, 25 Mar 2019 15:47:51 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] arch: add pidfd and io_uring syscalls everywhere
Date: Mon, 25 Mar 2019 15:47:37 +0100
Message-Id: <20190325144737.703921-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190325143521.34928-1-arnd@arndb.de>
References: <20190325143521.34928-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:FaiSmcpLJnThW6vsEWTPc3eZitCiMhab0InT0D7d6aEZ3xK0KeF
 nK8qMOGthno72x/Fz7KEca9N3rVAXYRiDRvhLa+9QhO9gvPbiRU8stXBfu6psktrdc1SOdQ
 G+xthZKxJklpQuS7FKlE4v4cCNFOxpqoyNgVkAWct7egfuLN9SinwHFWh54qc4B0jxya8wv
 FFGJWDZO0d9Ak42p2sjIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VeHMENui6h8=:gmlHgeAW3Jw9dRKbbBxP60
 NExKOHMk7nyKOfTirf9saOEfiHAoOgwmAvP28ZIxUx9gP2N0otsQDyfvZPCyyPhtJl3XIRi1l
 YmYnVG9JaiF0JCACs2rq55zK6ELGLgYGTGVVkq5co429G/vaZectvZKwDEJYgtWWVpURXjL9Q
 xzp2KqWHQjTQDhswXVJQJ4y30WBpog90DbGJEFuYdsnd5TTMjYF6PG6b0l3gi2XG7XX9EynVz
 U7vsxlQOaTuAP93ldBhgMZ2BBgMbIVNZySWzM2m2N6udjHLgzTTgstL10MiKz0S+MI0/c8MAi
 QA1KTsIprkR4sdWROz2/sdI9PRqiUDyO0b127o25s6A1yIiwGfuJ78Cg9lizMwYw+LSdVUgll
 tA5HpsNihO6V7AZA/ePde+2Pczv1OQhQsluvS8PcfqbOZv/2ZWI+xfF/CDSuy0JkPUQlDyDuh
 pR7rV58nXB7Qt91BvPc87pZAAK6pmiNixLsCsKQdfCc5vNJz7LotR8zvoGhjP9BJrhu00awhx
 x0qCkosAMznPYsJ4ZgWNLDJtA67k4SuMxk8kWC6RJmCkDThNsI8+j+fGrMS4ja2gAJozexjy1
 bswafjJZem6CmQdjDuEXm+clOnDRJWatv713Q/Cv1XnsDJoVRhYBk9I4KzXemc4JZ7aI5nHBH
 tEl1fhURKUzzNLEwST26UJPyansVTZmkNnEGzHqCVSrIZpvmv3SIFyhF7wctlgGyzp3i2tCzw
 f9sJAT2Zy7Kd7FxEG9JFfQ4Q0WVo8ihWHGBQFA==
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-mips@vger.kernel.org,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Helge Deller <deller@gmx.de>, Russell King <linux@armlinux.org.uk>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Catalin Marinas <catalin.marinas@arm.com>, James Hogan <jhogan@kernel.org>,
 Firoz Khan <firoz.khan@linaro.org>, Matt Turner <mattst88@gmail.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, linux-m68k@lists.linux-m68k.org,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 linux-arm-kernel@lists.infradead.org, Richard Henderson <rth@twiddle.net>,
 Michal Simek <monstr@monstr.eu>, Tony Luck <tony.luck@intel.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>,
 linux-alpha@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Add the io_uring and pidfd_send_signal system calls to all architectures.

These system calls are designed to handle both native and compat tasks,
so all entries are the same across architectures, only arm-compat and
the generic tale still use an old format.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 4 ++++
 arch/arm/tools/syscall.tbl                  | 4 ++++
 arch/arm64/include/asm/unistd.h             | 2 +-
 arch/arm64/include/asm/unistd32.h           | 8 ++++++++
 arch/ia64/kernel/syscalls/syscall.tbl       | 4 ++++
 arch/m68k/kernel/syscalls/syscall.tbl       | 4 ++++
 arch/microblaze/kernel/syscalls/syscall.tbl | 4 ++++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 4 ++++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 4 ++++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 4 ++++
 arch/parisc/kernel/syscalls/syscall.tbl     | 4 ++++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 4 ++++
 arch/s390/kernel/syscalls/syscall.tbl       | 4 ++++
 arch/sh/kernel/syscalls/syscall.tbl         | 4 ++++
 arch/sparc/kernel/syscalls/syscall.tbl      | 4 ++++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 4 ++++
 16 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 63ed39cbd3bd..165f268beafc 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -463,3 +463,7 @@
 532	common	getppid				sys_getppid
 # all other architectures have common numbers for new syscall, alpha
 # is the exception.
+534	common	pidfd_send_signal		sys_pidfd_send_signal
+535	common	io_uring_setup			sys_io_uring_setup
+536	common	io_uring_enter			sys_io_uring_enter
+537	common	io_uring_register		sys_io_uring_register
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 9016f4081bb9..0393917eaa57 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -437,3 +437,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 310d8f1cae7a..c6946fe640e6 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -49,7 +49,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		424
+#define __NR_compat_syscalls		428
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 5590f2623690..23f1a44acada 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -866,6 +866,14 @@ __SYSCALL(__NR_rt_sigtimedwait_time64, compat_sys_rt_sigtimedwait_time64)
 __SYSCALL(__NR_futex_time64, sys_futex)
 #define __NR_sched_rr_get_interval_time64 423
 __SYSCALL(__NR_sched_rr_get_interval_time64, sys_sched_rr_get_interval)
+#define __NR_pidfd_send_signal 424
+__SYSCALL(__NR_pidfd_send_signal, sys_pidfd_send_signal)
+#define __NR_io_uring_setup 425
+__SYSCALL(__NR_io_uring_setup, sys_io_uring_setup)
+#define __NR_io_uring_enter 426
+__SYSCALL(__NR_io_uring_enter, sys_io_uring_enter)
+#define __NR_io_uring_register 427
+__SYSCALL(__NR_io_uring_register, sys_io_uring_register)
 
 /*
  * Please add new compat syscalls above this comment and update
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index ab9cda5f6136..56e3d0b685e1 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -344,3 +344,7 @@
 332	common	pkey_free			sys_pkey_free
 333	common	rseq				sys_rseq
 # 334 through 423 are reserved to sync up with other architectures
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 125c14178979..df4ec3ec71d1 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -423,3 +423,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 8ee3a8c18498..4964947732af 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -429,3 +429,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 15f4117900ee..9392dfe33f97 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -362,3 +362,7 @@
 421	n32	rt_sigtimedwait_time64		compat_sys_rt_sigtimedwait_time64
 422	n32	futex_time64			sys_futex
 423	n32	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	n32	pidfd_send_signal		sys_pidfd_send_signal
+425	n32	io_uring_setup			sys_io_uring_setup
+426	n32	io_uring_enter			sys_io_uring_enter
+427	n32	io_uring_register		sys_io_uring_register
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index c85502e67b44..c4a49f7d57bb 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -338,3 +338,7 @@
 327	n64	rseq				sys_rseq
 328	n64	io_pgetevents			sys_io_pgetevents
 # 329 through 423 are reserved to sync up with other architectures
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 2e063d0f837e..e849e8ffe4a2 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -411,3 +411,7 @@
 421	o32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	o32	futex_time64			sys_futex			sys_futex
 423	o32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	o32	pidfd_send_signal		sys_pidfd_send_signal
+425	o32	io_uring_setup			sys_io_uring_setup
+426	o32	io_uring_enter			sys_io_uring_enter
+427	o32	io_uring_register		sys_io_uring_register
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index b26766c6647d..fe8ca623add8 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -420,3 +420,7 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index b18abb0c3dae..00f5a63c8d9a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -505,3 +505,7 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 02579f95f391..3eb56e639b96 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -426,3 +426,7 @@
 421	32	rt_sigtimedwait_time64	-				compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64		-				sys_futex
 423	32	sched_rr_get_interval_time64	-			sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index bfda678576e4..480b057556ee 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -426,3 +426,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index b9a5a04b2d2c..a1dd24307b00 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -469,3 +469,7 @@
 421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
 422	32	futex_time64			sys_futex			sys_futex
 423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index 6af49929de85..30084eaf8422 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -394,3 +394,7 @@
 421	common	rt_sigtimedwait_time64		sys_rt_sigtimedwait
 422	common	futex_time64			sys_futex
 423	common	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
-- 
2.20.0

