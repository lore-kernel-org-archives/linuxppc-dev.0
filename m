Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2669EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A436A206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A436A206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBlD542MzDqvn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:48:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBPF15JXzDqpR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:32:48 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N1Ok1-1hR2tC1rfn-012tSW; Thu, 10 Jan 2019 17:25:25 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 15/15] arch: add pkey and rseq syscall numbers everywhere
Date: Thu, 10 Jan 2019 17:24:35 +0100
Message-Id: <20190110162435.309262-16-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cYFUki4ctg41NCVsfRZXUlD/defZca+1m4t7TyTRppdNihmgpcn
 20YcInCpgALpocQ3Jdh1oHW/YKt7D64ONPT9zaXB3P8cOXumHp+iHoO4kuPkFqthq9BiZWE
 f57EHmyQMPAV1cS+v4g4u0oJ9P6Tkhmo7tgSHPr6K2b25DrGAMnqjs/cMheYY+CqkoxnxB7
 Mq+Y+9Ek0yyLx4SlJWh2w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZFqZxmvovO0=:/T+7tpb/qzkxoQicyVGoKz
 EZOYXHcC0tqQzWR/nTsq8qXF/PJVkWpUrzMHK/lpnFc2RhFRPy5Rv4u913Mu9zGBWB+KZ0obn
 r2qM+iIZCeTxhe3pr5ycbA0nBW9BAHfFsOPyagUyOhNY4as50alvQuRC6S/uj9EAdZuMPaYA9
 qv/bZsEHExtT40S7j8inJ5El37sATfga+RJFahvuLUIGwNIZZJ+wSkECYeHWE6eL30A4W3cB+
 GIibMf1TbSWwBCFn6cB7fnQBeHnm3HqJtBfE7XdEjihXrUSI3WEbkyglDD/RhtGSnmr3+g3Vy
 JJeX4kYi4CXe9TCuOu/bwX1dNE4TSzqfBmidbsPpjOAdkXgoUGD2k3vmtcCtSX1aBCEz/B79L
 VrlKqlcFoTU88G6aSnte1Gt2QTebyBSbTQURM8SixZwZus1nGpa7yhkI1fpulgT+NFWlDoW+T
 8zfYhvZqEhH0oSWas6iA6Th7jPzC73YndqqW81PtPzcVbcItwWMkDN+INi3YdJz9vH9BdfU8N
 mJJKaBOd1vPOU03YaR6Bdu9680RX0vPfHTgEUUc6kFLp9K5z5LjuAuuU4hvB8usXUU/XLADmM
 61QPo9oyPwcH0BAbAqJgqjw/Tc8QP2Wg89pfYySsb3oZ7M70Mw023C3YnwG6gMNVrA+5WrA4l
 oRwr2cILRzr97u15pA/lqgCjuiXtHWymQhkEgeUYw/5DC/uTqlDadWLvNmf5K3UeAXjfOBV3K
 dCGzuG8bdmi5gtWzzX7g13DRCXwishPiUXWttUFzHUtH5nq+54/O05vNPoGkHLh6PMZIcziBU
 vhkzfVEpBv5jD8XC+BJ68m7+V8bk0ByE/0lHfJpdLG/SF3r+eYkjq6kDf3UI9ve2bsQzZK7FD
 CoM7b9WsA2qU4u36byHvgIHh4sKHrhDruqM8QTzmb26zg3Jnf3RhoGfhskxrEl
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
 catalin.marinas@arm.com, will.deacon@arm.com, linux@dominikbrodowski.net,
 jcmvbkbc@gmail.com, deepa.kernel@gmail.com, hpa@zytor.com,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, dave@stgolabs.net,
 deller@gmx.de, x86@kernel.org, linux@armlinux.org.uk, mingo@redhat.com,
 geert@linux-m68k.org, firoz.khan@linaro.org, mattst88@gmail.com,
 fenghua.yu@intel.com, Arnd Bergmann <arnd@arndb.de>, heiko.carstens@de.ibm.com,
 linux-m68k@lists.linux-m68k.org, ink@jurassic.park.msu.ru, luto@kernel.org,
 tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, monstr@monstr.eu,
 tony.luck@intel.com, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
 paul.burton@mips.com, ebiederm@xmission.com, linux-alpha@vger.kernel.org,
 schwidefsky@de.ibm.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Most architectures define system call numbers for the rseq and pkey system
calls, even when they don't support the features, and perhaps never will.

Only a few architectures are missing these, so just define them anyway
for consistency. If we decide to add them later to one of these, the
system call numbers won't get out of sync then.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h         | 4 ----
 arch/alpha/kernel/syscalls/syscall.tbl  | 4 ++++
 arch/ia64/kernel/syscalls/syscall.tbl   | 4 ++++
 arch/m68k/kernel/syscalls/syscall.tbl   | 4 ++++
 arch/parisc/include/asm/unistd.h        | 3 ---
 arch/parisc/kernel/syscalls/syscall.tbl | 4 ++++
 arch/s390/include/asm/unistd.h          | 3 ---
 arch/s390/kernel/syscalls/syscall.tbl   | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl     | 4 ++++
 arch/sparc/include/asm/unistd.h         | 5 -----
 arch/sparc/kernel/syscalls/syscall.tbl  | 4 ++++
 arch/xtensa/kernel/syscalls/syscall.tbl | 1 +
 12 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 564ba87bdc38..31ad350b58a0 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -29,9 +29,5 @@
 #define __IGNORE_getppid
 #define __IGNORE_getuid
 
-/* Alpha doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index b0e247287908..25b4a7e76943 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -452,3 +452,7 @@
 521	common	pwritev2			sys_pwritev2
 522	common	statx				sys_statx
 523	common	io_pgetevents			sys_io_pgetevents
+524	common	pkey_alloc			sys_pkey_alloc
+525	common	pkey_free			sys_pkey_free
+526	common	pkey_mprotect			sys_pkey_mprotect
+527	common	rseq				sys_rseq
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 2e93dbdcdb80..84e03de00177 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -339,3 +339,7 @@
 327	common	io_pgetevents			sys_io_pgetevents
 328	common	perf_event_open			sys_perf_event_open
 329	common	seccomp				sys_seccomp
+330	common	pkey_alloc			sys_pkey_alloc
+331	common	pkey_free			sys_pkey_free
+332	common	pkey_mprotect			sys_pkey_mprotect
+333	common	rseq				sys_rseq
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 5354ba02eed2..ae88b85d068e 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -388,6 +388,10 @@
 378	common	pwritev2			sys_pwritev2
 379	common	statx				sys_statx
 380	common	seccomp				sys_seccomp
+381	common	pkey_alloc			sys_pkey_alloc
+382	common	pkey_free			sys_pkey_free
+383	common	pkey_mprotect			sys_pkey_mprotect
+384	common	rseq				sys_rseq
 # room for arch specific calls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index c2c2afb28941..9ec1026af877 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -12,9 +12,6 @@
 
 #define __IGNORE_select			/* newselect */
 #define __IGNORE_fadvise64		/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index 9bbd2f9f56c8..e07231de3597 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -367,3 +367,7 @@
 348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 349	common	statx			sys_statx
 350	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+351	common	pkey_alloc		sys_pkey_alloc
+352	common	pkey_free		sys_pkey_free
+353	common	pkey_mprotect		sys_pkey_mprotect
+354	common	rseq			sys_rseq
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index a1fbf15d53aa..ed08f114ee91 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -11,9 +11,6 @@
 #include <asm/unistd_nr.h>
 
 #define __IGNORE_time
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 428cf512a757..f84ea364a302 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -391,6 +391,9 @@
 381  common	kexec_file_load		sys_kexec_file_load		compat_sys_kexec_file_load
 382  common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
 383  common	rseq			sys_rseq			compat_sys_rseq
+384  common	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
+385  common	pkey_free		sys_pkey_free			sys_pkey_free
+386  common	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
 # room for arch specific syscalls
 392	64	semtimedop		sys_semtimedop			-
 393  common	semget			sys_semget			sys_semget
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 6d0b84e3ef2d..3f96ad0424e1 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -391,6 +391,10 @@
 381	common	preadv2				sys_preadv2
 382	common	pwritev2			sys_pwritev2
 383	common	statx				sys_statx
+384	common	pkey_alloc			sys_pkey_alloc
+385	common	pkey_free			sys_pkey_free
+386	common	pkey_mprotect			sys_pkey_mprotect
+387	common	rseq				sys_rseq
 # room for arch specific syscalls
 393	common	semget				sys_semget
 394	common	semctl				sys_semctl
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 5194d86ef72d..08696ea5dca8 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -59,9 +59,4 @@
 #define __IGNORE_getresgid
 #endif
 
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 8c9580302422..24ebef675184 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -407,6 +407,10 @@
 359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
 360	common	statx			sys_statx
 361	common	io_pgetevents		sys_io_pgetevents		compat_sys_io_pgetevents
+362	common	pkey_alloc		sys_pkey_alloc
+363	common	pkey_free		sys_pkey_free
+364	common	pkey_mprotect		sys_pkey_mprotect
+365	common	rseq			sys_rseq
 # room for arch specific syscalls
 392	64	semtimedop			sys_semtimedop
 393	common	semget			sys_semget
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index f8befa11b0c4..c699e014e0dd 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -372,3 +372,4 @@
 349	common	pkey_alloc			sys_pkey_alloc
 350	common	pkey_free			sys_pkey_free
 351	common	statx				sys_statx
+352	common	rseq				sys_rseq
-- 
2.20.0

