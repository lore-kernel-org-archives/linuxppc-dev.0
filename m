Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBBFC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F3920874
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F3920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBLb3Xy0zDqHR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:30:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBG105SfzDqkj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:26:32 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N9Mh8-1hK9GT0x08-015KyR; Thu, 10 Jan 2019 17:25:09 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 03/15] ia64: assign syscall numbers for perf and seccomp
Date: Thu, 10 Jan 2019 17:24:23 +0100
Message-Id: <20190110162435.309262-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Aqo6N9d9grrvjwZZFEqN/kvQ31MLlDiiylB1bz3l3bnWOkX29Jb
 FIpuJ/jDdTbyft/4m0XHsdrBBVlm/5kn3AxdnjdvfrdFVcnigok/cmoOYzEopX64Kvw6dls
 WX4c0A3ajbuIPBhtDJnOxItEcolnrdicUdlbDH0vyMO4tFgIrLIN3zrBeur2mEJPy3oMIBX
 ZH1cdK/uOrjSnDnCsmVEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DcqPdkrtZkA=:QS9oAutwixmbvSVltaI9L6
 +m9uizBojpDw4Y/KGXSwSjuE5RFBEi7OZQFNyG/xCTeJGtb6VPYkwAOz9MsrA2pxEiUjFa9rG
 fuJdxhEHR1LixU3L7SSftPuAu/E+HMI7cMR38HXeU8sTwYxz1Lhfz/ndk7VKbWpgR6e48hHTh
 52oG4XPC5Sd/bup/d7xyO1GwtMOv8KicBE7MTnwJg30UL0KV+2zy8+uaQIIBfpCDfWM6kjw1Y
 9zf/dxhuEvLX4cTqoUgQnILjvndG21zv6xai7n9Mo8+weKMX3oFsIyKniIqcYSLZpFjZZad6J
 iFX8KqIDD2L15m14S+VUGqz3BXl9nnN+3YZmaY2aCgRLj+1lVPyqEAJNryhh8rK6FIJ8GHxDJ
 b6kKEjdlplavAtZsSD6iylVr6KSzwNw62ShZ5OZvUL5XVI3/keVLJIlNTf9Dj4xsiQPsm/3YS
 hBnYM2p500m6A4e6wcUThTchOc2YPdSSH2b1Gg0KaympGurdwlWM2AnEkcYg+rJMB8ejQK2OV
 FvODRVy/7YsxTrzkyuDInaJdUb6X2TzSWEOoqh1ifvX44kfRzsj3wFkCRTG7Tcl0WUsDB/tak
 aArpMEZ5ewfQfVdDVvG0xAc0R1LMlt+LCk6prUqgqK6D+A4b9mninT6hfcvtpKZL0P1KVrvKJ
 elmxmdqcPPwGsxzlTz8rV4AOm/8m9AoXxIvPJ0wCPLcEf+m+XNV/BH5QBhqwba8jH8VLEyHqT
 16Toqp4Rzx0iHqbsVLKUtulq49kZQX99otz0fw==
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

Most architectures have assigned numbers for both seccomp and
perf_event_open, even when they do not implement either.

ia64 is an exception here, so for consistency lets add numbers for both
of them. Unless CONFIG_PERF_EVENTS and CONFIG_SECCOMP are implemented,
the system calls just return -ENOSYS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/kernel/syscalls/syscall.tbl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index 52585281205b..2e93dbdcdb80 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -337,3 +337,5 @@
 325	common	pwritev2			sys_pwritev2
 326	common	statx				sys_statx
 327	common	io_pgetevents			sys_io_pgetevents
+328	common	perf_event_open			sys_perf_event_open
+329	common	seccomp				sys_seccomp
-- 
2.20.0

