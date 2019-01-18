Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA68C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:45:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10A1E20823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10A1E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6Hj3XzpzDqjG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:45:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.17.13; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5m664TBzDr1q
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:10 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MZTyi-1gheoB1V02-00WSdJ; Fri, 18 Jan 2019 17:19:37 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 16/29] alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
Date: Fri, 18 Jan 2019 17:18:22 +0100
Message-Id: <20190118161835.2259170-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jsOw7NqQKS2zQ2Kn3Rl+vMqYljPTdUEHSKVnWEW+0Z+etDrnxOY
 fHRBu4AJ2H9ITzOOnIQmu/LvPg6oaokuIwQkItp+qBdIdD7bxckPyZ8Sxs4NOwtEHCSAnUH
 PATcQhNN+ieYB856u8/+6Y9ZbSsp4EBrFe61HTPJVqvuCuDQ4awBecyCY2Y/F+xR0K6VrtS
 S0fFIjG7g4/x+H+4JviEg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JL+1HsoFxsM=:cBJFwJBy7OBl33SJgynGOf
 EmNur2v4677HGSFzkbfaknFA95n0HTqqKB3lK8G36N+kfz/YYAgyNSQ0vsAdfHv8lhYMjGt9p
 M8WUKHlEr7hakd0YFqTMmYqzuRvf5OQhCO6VJWob6XAwR6tpdkRzOCkrG6G8sfDz0d6VY/hNz
 upEFggyCa4tZuOyNQJx/K1uvR42DpkBjNILmF7YFo+UwNzmRIGTttYrsBYHTpe1PkzRgVit+r
 j7SLw9Mb4BkxItIIOg0Qt2c5Oq54DLbA/d+tWgz6QwpjgSfDyguWB8kYlWaqTPuPH9rvSikR/
 z5iJ6+Y+g9zoUxtfCYnatVYC9tJKDuimc9MbGNzttROXmBklb/ksFc6NTsXvlop93uHH8kFZW
 EH8Uk0MtSGHSMNTx7TfNxVjZQD2p41Af7cdpQ0q7LLJMZ12Wiz3jRYV1s++sEe5YekYRPxPzI
 0UeWAqx5PBKwf0P5EIiRcD7zYJVp12kr6tChz9H4IAiwv9yHUyveQLYhjbD63KLNdQmOWwgxQ
 FDoUySY8h2BSH/6fWX31CKmRwF+KPHvEnrGvFcULjAx96+rWzASZopKWtsi/Oj9ONCxHrFK77
 zfvU9jlkJIiLbhOXwmibd0u52gtfrTcK5qxrB/RMFagbDTt5V/H0K7p98rbF0qtMgChfmWlw6
 9js9moRUD3b7UoD0g2g2uzOd41lIuDs6xFGHIXcYshauq1Q8Mf7vrPy5HgZEfkX3yFqd1V5g5
 9v/xHx798WmtLAP2+pB9Fa8UydU7D6olbZ12sQ==
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

Alpha has traditionally followed the OSF1 calling conventions
here, with its getxpid, getxuid, getxgid system calls returning
two different values in separate registers.

Following what glibc has done here, we can define getpid,
getuid and getgid to be aliases for getxpid, getxuid and getxgid
respectively, and add new system call numbers for getppid, geteuid
and getegid.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/alpha/include/asm/unistd.h        | 11 -----------
 arch/alpha/include/uapi/asm/unistd.h   |  5 +++++
 arch/alpha/kernel/syscalls/syscall.tbl |  3 +++
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 31ad350b58a0..986f5da9b7d8 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -19,15 +19,4 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
-/*
- * Ignore legacy syscalls that we don't use.
- */
-#define __IGNORE_getegid
-#define __IGNORE_geteuid
-#define __IGNORE_getgid
-#define __IGNORE_getpid
-#define __IGNORE_getppid
-#define __IGNORE_getuid
-
-
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 4507071f995f..71fd5db06866 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -7,6 +7,11 @@
 #define __NR_umount	__NR_umount2
 #define __NR_osf_shmat	__NR_shmat
 
+/* These return an extra value but can be used as aliases */
+#define __NR_getpid	__NR_getxpid
+#define __NR_getuid	__NR_getxuid
+#define __NR_getgid	__NR_getxgid
+
 #include <asm/unistd_32.h>
 
 #endif /* _UAPI_ALPHA_UNISTD_H */
diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index 0ebd59fdcb8b..337b8108771a 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -458,3 +458,6 @@
 527	common	rseq				sys_rseq
 528	common	statfs64			sys_statfs64
 529	common	fstatfs64			sys_fstatfs64
+530	common	getegid				sys_getegid
+531	common	geteuid				sys_geteuid
+532	common	getppid				sys_getppid
-- 
2.20.0

