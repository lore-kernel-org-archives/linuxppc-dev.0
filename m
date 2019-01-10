Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2A8C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:53:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C16214C6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 16:53:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C16214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43bBs06HvyzDqxW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 03:53:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.73; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43bBPL6YQnzDqmQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 03:32:54 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MBDrM-1gZMT62Rmo-00CiB7; Thu, 10 Jan 2019 17:25:06 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] ia64: add __NR_umount2 definition
Date: Thu, 10 Jan 2019 17:24:21 +0100
Message-Id: <20190110162435.309262-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190110162435.309262-1-arnd@arndb.de>
References: <20190110162435.309262-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:AJT9SA8ciXw9tl+ZARfbMSJs7t7q7UPbK07TS1vkYi4fGRqmOxx
 AzigR/HepSHxzAtR37bpzxx0eGkGZ5xopih9slk2sajL2Y8iO5R4MzWIjYXabHCb7bInRu1
 vsNYQrqZWKPK8kqtpil2DEtQ/n/5Hq6pvEuRQVTxFUv9LuD45rAegpfUfRz8g1juc+SsTJ+
 0pTxXXrORP8FWsPcCwG3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IKCpGPbmV6I=:Kxu00Qjrt+9N3aaO2OQ9r2
 etMdc298VbR0SysEmkKwHFCd1zznlcLe50v/b+P7uXhAXTN3r4ZRmLD9J6rffyEdL8Aw5Tq0F
 vJ+utuQif3lLAPSLe70/KXEpLVQO/1fwIWxVJcrkRsGETU4qmb+t0zhFLcm/OjxJfnXJhG5mT
 H3x1+ClV181uWrjawDu5twvqZoztUAKQE2ZyvWuzBH5Ug7r7ktVqXeJ3eSdDHFYgj9cYZVvba
 ZxLFVjOXD39mHj6LtZC5z0exUwYMcGNfUZaG670bYjBedPkJ7CVuytLkkLuQK30Y+zi2GyCEe
 VsNHMSuxJvqsZPYjCyqvaoRhKbdMn+4F5/iKTTVlylnPibHzJAerNieEH3GUwRq4auOY+BGwy
 MvsYzIc32GF9CzC0ngZJKiFhuw3aNzSv2ZTPpUlR/hLcPpht80T7KtvPKkcFXp5Y2noBt1TNq
 nq1fmlX6bT+u4+eMkl2bZwS1qzTgUEwuAyDcSPGIzVeDcFwNMMexI9H+HFKQMcjpxiHdl9Q+m
 E9awgYjqoGWMn3I9EitBBU0BIj8SGnFG439ElP/AEoC+W97W0ngvwWOG1IqZ11+aH59oJfsTc
 6U6vCzBZLRV2UPMc3QycVjZJGpxopZ7gUPKCPyXBQHyGbrV97BR8Z7X5aJqpjfyH1cgWsy8Il
 Cg4Zx+0y33nVokZX4wHlRyrGN2f0I3ObWL3B6z6Yqw0hCLyJX2chkyWqU+8fTorA4lWUYX0Op
 aYJz6q0UwABW6GKEjtKGSW8uhXHB5LvhSE5fK3YZP3YvNSiWHnkTsrwADIfDNAvCt8TWLszEw
 v8iHlWa2YJo95svPJyegiytjHh6niO1Badn6BPMdkIn5AzR9fq2oI0okA9oQOCWOkvZnRauNa
 qFCXlkWX5fXG+zbu5HmmyhUPM4lvzhEQUtwGMh5NegMrGMQXA7H56zmLFYUFPR
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

Other architectures commonly use __NR_umount2 for sys_umount,
only ia64 and alpha use __NR_umount here. In order to synchronize
the generated tables, use umount2 like everyone else, and add back
the old name from asm/unistd.h for compatibility.

The __IGNORE_* lines are now all obsolete and can be removed as
a side-effect.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/ia64/include/asm/unistd.h        | 14 --------------
 arch/ia64/include/uapi/asm/unistd.h   |  2 ++
 arch/ia64/kernel/syscalls/syscall.tbl |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 0b08ebd2dfde..9ba6110b10b9 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -12,20 +12,6 @@
 
 #define NR_syscalls		__NR_syscalls /* length of syscall table */
 
-/*
- * The following defines stop scripts/checksyscalls.sh from complaining about
- * unimplemented system calls.  Glibc provides for each of these by using
- * more modern equivalent system calls.
- */
-#define __IGNORE_fork		/* clone() */
-#define __IGNORE_time		/* gettimeofday() */
-#define __IGNORE_alarm		/* setitimer(ITIMER_REAL, ... */
-#define __IGNORE_pause		/* rt_sigprocmask(), rt_sigsuspend() */
-#define __IGNORE_utime		/* utimes() */
-#define __IGNORE_getpgrp	/* getpgid() */
-#define __IGNORE_vfork		/* clone() */
-#define __IGNORE_umount2	/* umount() */
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_UTIME
 
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index b2513922dcb5..013e0bcacc39 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -15,6 +15,8 @@
 
 #define __NR_Linux      1024
 
+#define __NR_umount __NR_umount2
+
 #include <asm/unistd_64.h>
 
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
diff --git a/arch/ia64/kernel/syscalls/syscall.tbl b/arch/ia64/kernel/syscalls/syscall.tbl
index b22203b40bfe..e97caf51be42 100644
--- a/arch/ia64/kernel/syscalls/syscall.tbl
+++ b/arch/ia64/kernel/syscalls/syscall.tbl
@@ -29,7 +29,7 @@
 17	common	getpid				sys_getpid
 18	common	getppid				sys_getppid
 19	common	mount				sys_mount
-20	common	umount				sys_umount
+20	common	umount2				sys_umount
 21	common	setuid				sys_setuid
 22	common	getuid				sys_getuid
 23	common	geteuid				sys_geteuid
-- 
2.20.0

