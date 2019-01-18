Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3CEC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:28:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C09020850
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C09020850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h5wY19yqzDr2w
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:28:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5ld3GhlzDr1q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:20:44 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKKd7-1gWQWS33t9-00LmRg; Fri, 18 Jan 2019 17:19:23 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 06/29] ARM: add migrate_pages() system call
Date: Fri, 18 Jan 2019 17:18:12 +0100
Message-Id: <20190118161835.2259170-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:o3bTb4elB3z+286rn9+b5BP7tK9ifOmWUW+jka5ZcLRoBINPDJf
 u8PIZcP2oUy73YnUflDiwxkNfXIDgII5Pyhk+V14swnaTnFx5ocmSc3GvbMfPHBlAdH2hOO
 HnGoII6EJed1+C6r0RoTYwRkjRvEbyOrLcmhc5DagzjWZlLv5X7xA8BSuap5Ej3vVq2kBkR
 J33viKVBFQ1JhizF8SI/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3TL+IMUlpzQ=:W4KhIatfhW7FMFXhanW/DA
 GRXuaIVZT5yLKobF9hxOAr0++qzuCRc1CvEdJhCRmyjg3tVnuVTea/UC1uvUl5+b8WbMQGZ2y
 IhAzxeBsFmWL53O9WpTTqoDT/nboxRQDmswH0/f/GTKPMN2z3vZwVUlRhzoSirbpF+lnxfjOZ
 sN/4WLTGYuHpbqrOxsstykpo2y8LRe1POgk4jbusH6bQF90n6M4iRhVrGRIOrVw2bdttMMlAA
 uT0OtEXxzSfFi0CYobAlGKnZqnyNhrd53D0fMCInpqHILWFd1DtjVcSRRThpH/sAtDi0bB10+
 Ugb1IEqZY/t6Vwsm27UEtY2WdRDnob3jplYpxp7LEYnA9+MmRRxsSQGX4rwbfAh61hF01Z6w6
 c1gGmtntitfEHrg2cn23IhBqYw4oKw2FRJOxB9tDFAw7RHOCw9DS4DZeuAH/963xwTtIZQzNY
 1aXUG6Znslmrc13+enLNNpHHdqS95uRqE0RLgCHtmqVJSvSINH3VB0iFWhAu52D9FeScou6Jt
 DMCljPSLrh3jHaukqC84MTlYT6tYVfPoAwYvF7QgVEd2kgvyMgY2cHJMjfNpvBVodJDtgelWN
 WyT2nqJHgERRpJagCPwbdtU6mcbVNfRzxffHnacQ4vUxt4V/sJi/kqkoPRbuRzxPSp7atXUfB
 1YBkP5nZaJQ1KkngOFAwcAZDCXzHTa7u9SVJNuPiXS2Wwsi0eYe4gZnZnIKeg8MQ2APOz+PXy
 XOmiTdMMxuVgn48bnD8Kw1Cy5XKVXUIjyQPYnQ==
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
 linux-s390@vger.kernel.org, deller@gmx.de, x86@kernel.org,
 linux@armlinux.org.uk, mingo@redhat.com, geert@linux-m68k.org,
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

The migrate_pages system call has an assigned number on all architectures
except ARM. When it got added initially in commit d80ade7b3231 ("ARM:
Fix warning: #warning syscall migrate_pages not implemented"), it was
intentionally left out based on the observation that there are no 32-bit
ARM NUMA systems.

However, there are now arm64 NUMA machines that can in theory run 32-bit
kernels (actually enabling NUMA there would require additional work)
as well as 32-bit user space on 64-bit kernels, so that argument is no
longer very strong.

Assigning the number lets us use the system call on 64-bit kernels as well
as providing a more consistent set of syscalls across architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/unistd.h     | 1 -
 arch/arm/tools/syscall.tbl        | 1 +
 arch/arm64/include/asm/unistd.h   | 2 +-
 arch/arm64/include/asm/unistd32.h | 2 ++
 4 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/unistd.h b/arch/arm/include/asm/unistd.h
index 88ef2ce1f69a..d713587dfcf4 100644
--- a/arch/arm/include/asm/unistd.h
+++ b/arch/arm/include/asm/unistd.h
@@ -45,7 +45,6 @@
  * Unimplemented (or alternatively implemented) syscalls
  */
 #define __IGNORE_fadvise64_64
-#define __IGNORE_migrate_pages
 
 #ifdef __ARM_EABI__
 /*
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 8edf93b4490f..86de9eb34296 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -414,3 +414,4 @@
 397	common	statx			sys_statx
 398	common	rseq			sys_rseq
 399	common	io_pgetevents		sys_io_pgetevents
+400	common	migrate_pages		sys_migrate_pages
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index a7b1fc58ffdf..261216c3336e 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -44,7 +44,7 @@
 #define __ARM_NR_compat_set_tls		(__ARM_NR_COMPAT_BASE + 5)
 #define __ARM_NR_COMPAT_END		(__ARM_NR_COMPAT_BASE + 0x800)
 
-#define __NR_compat_syscalls		400
+#define __NR_compat_syscalls		401
 #endif
 
 #define __ARCH_WANT_SYS_CLONE
diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
index 04ee190b90fe..f15bcbacb8f6 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_migrate_pages 400
+__SYSCALL(__NR_migrate_pages, compat_sys_migrate_pages)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

