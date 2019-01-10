Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3607DC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:51:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1BC8206B7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:51:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BC8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBpy5nWrzDqth
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:51:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.24; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBPH6HM0zDqnp
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:32:51 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MStGi-1gqtJn10Qg-00UNaT; Thu, 10 Jan 2019 17:25:13 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 06/15] ARM: add migrate_pages() system call
Date: Thu, 10 Jan 2019 17:24:26 +0100
Message-Id: <20190110162435.309262-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xU1TfvUWuXdLttcRhOwMDdJJXZRPbxZEzH/siDEOVU0h6xSKutI
 9QsRxUZDYmciiqijchskFcKTpq+zTdu1Z3OJ6HXVSfUcAA+HxeciwrBeeSL6Ckg3kR4vhW6
 M00Lmj5s9Y3w6Le9cFFx9VvdHdeeOpVNHkzmK9YN7A4Vyz/gVMPCkuNCa3YGL4MWEdk3Y2L
 uZjLpOEPaYJJ39nJiErlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hLUGgxEY8X8=:xNG3o7sRfJqQLUE25UzPlL
 CnOaq491Ig5QdUIpsE3OY2RymTNlkew3UdMmMeqR8/yLMPyKZ4xiH5WTdaxDX5o8eb+a5MbmM
 cK9Jn2E9tx/vU/yASdWa83mZIM506YiepnTAk+gzq1tPucAtCsa8f6dHdmPSMTe2JV5VVH14v
 enC+Jt1hf7JjhtpB9jKaU0XuRQhq3e4ihVSGK4RJYnqpNpw7MuyU+d6l7/TYnIG1ZZDXcQHtY
 IIpw1YOnL/Vif+S2eCon3xelADz7FlqLrO1rlAeBrNTQuB47sMX712phIY0bVfVl4cSxTj/9z
 CG6+4CUdrzEgIXu3ffJANuq2bNKfA9bvKZWKp5GycdBMeJzZzpkOxkLVDUlMq+Zm6HO3NthCE
 IOVjwAPokK4QhjnI+G+tlTcKVQx2Qyhaz085n6iQgb7aZLqSwUM/rXy2lgZdg1lujhJBxbxDa
 ZhX7CmLC4Lu6O6v0ymv5M4fu9dFyUowGOMmmHNUXJH7KvGjqzKi6sj7MMMWGinaQf2OsAsz5v
 8g9+lG9+6eKun+k3bomlqkS+rbEoqyA7UVDYEjPjsFjioKpyHUQID/gmcu2MIb7tYE0zmyxQw
 smSHTtq9yvmMBf5fDkVhYnoazsmUXCtjF8xlP/8kNZVTZAiQ4EVf/SBPha/SOZQR+oAtH1pRR
 p6lpKoKkHu2Zii5fu/kW7RY9ZEVjb8axs2HHTizG/5a4DA+iEFB+JTBJNZDrFU2uVJi/Vt8Hr
 t720sGF30ie2QVIWKMPDQ+q2J46hJn38bYkrSw==
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
index 04ee190b90fe..355fe2bc035b 100644
--- a/arch/arm64/include/asm/unistd32.h
+++ b/arch/arm64/include/asm/unistd32.h
@@ -821,6 +821,8 @@ __SYSCALL(__NR_statx, sys_statx)
 __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_io_pgetevents 399
 __SYSCALL(__NR_io_pgetevents, compat_sys_io_pgetevents)
+#define __NR_migrate_pages 400
+__SYSCALL(__NR_migrate_pages, sys_migrate_pages)
 
 /*
  * Please add new compat syscalls above this comment and update
-- 
2.20.0

