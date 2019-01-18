Return-Path: <SRS0=AYvg=P2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CCC43612
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC20820823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 16:48:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC20820823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43h6Mb6HRCzDqCB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Jan 2019 03:48:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=217.72.192.75; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43h5mC6kfLzDr2m
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Jan 2019 03:21:15 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MiagL-1hPLSf2sBb-00fmAm; Fri, 18 Jan 2019 17:19:38 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-api@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 17/29] syscalls: remove obsolete __IGNORE_ macros
Date: Fri, 18 Jan 2019 17:18:23 +0100
Message-Id: <20190118161835.2259170-18-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190118161835.2259170-1-arnd@arndb.de>
References: <20190118161835.2259170-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DdH60wNUBgz3ORuc+j1hCn614lQoDJNwbl1V5NlixSH/rexrQoE
 IdXAUNp3vob5ANgqtHQFpoAbtSvnHUC9HXHWJALVweGBrfrzYaYWlrueE5B9t5zXKCnAwBr
 ond52+JciiPSgiBA232NEEU8AqK9sIU8DoTiBaXXFD3yFnz3gDQ3dWCROZ8tzHcwjFIO1NC
 kh1mkXZqGzjI5MJnrM36w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:93rMBIOJPec=:/+lHk0bSFIJODP9zb8UMQU
 prGJ0K3OrVQDZnKOsBLZLlkyNDuinE3GuehbS0xjFM0t1TI9Ksttf/gLJyuj035c2THQykUYN
 Q0mjN1otkBDmDSF/MMVATdB4G1t4+ymLPNe7NLdUUew+5D/L85N+g0ODG3bhhJRWEPBI7NOLt
 m/tCCWx99ok/rRZ4QznSxIPK3wO43fCIWcBSyLNVTtKDzrwzn5OwPLYBHuFRymumtOL/DDCW/
 gpU/6o9AiblQACI5cqWF+By+Jzg1nmW7YfxIIdByBEJJ0bmynXHTmMprjQrirjKR0qYEMPsD7
 9dOB3Y31nXm6vliTg8EhF0aYW39XiEee90FOgqbTNse7zMek8J9zR+OK2stUEsAcm0OBjVr7S
 u7hwLU3cBR1HPnMPa0EiXgkFI3Y1Be2j4qFyVUN4CyLitt3Y4qsVs3Bg4zPyNV1rwxVj+K6kK
 5W9c4FybXySxpeQp3gyZPnqj8+PCK4FGHILZFZsCVfDd0k0gkcv3e1IttLHOV4siZxAAR8+5e
 nIoksxBaBSaUgAoigAQBZkE1wQwRZJ88Bx06+3EfS0aV1wN6Z8VK1JpYc5/PCSbb0yJ8ya5EB
 biNgjZMFKcig5eMRNe4OjV9vVLsl/jN0AcE1g66Piy8iIXvfnYAjJd2TVpWLC/xd/FVHSd83B
 q6wGDy3kxpQILeNw9h1e388Rr8v6mw9PLmcrfArNymX56aeYk3InP49ruyHUYaY9zXCMxlOkn
 kw6PY0phnOfbOEYl19zUPN1dcNx87xfQw/aMDQ==
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

These are all for ignoring the lack of obsolete system calls,
which have been marked the same way in scripts/checksyscall.sh,
so these can be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/include/asm/unistd.h   | 16 ----------------
 arch/parisc/include/asm/unistd.h |  3 ---
 arch/s390/include/asm/unistd.h   |  2 --
 arch/xtensa/include/asm/unistd.h | 12 ------------
 4 files changed, 33 deletions(-)

diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index b23d74a601b3..5e9eeb83d8d4 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -53,22 +53,6 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_CLONE
 
-/* whitelists for checksyscalls */
-#define __IGNORE_select
-#define __IGNORE_vfork
-#define __IGNORE_time
-#define __IGNORE_uselib
-#define __IGNORE_fadvise64_64
-#define __IGNORE_getdents64
-#if _MIPS_SIM == _MIPS_SIM_NABI32
-#define __IGNORE_truncate64
-#define __IGNORE_ftruncate64
-#define __IGNORE_stat64
-#define __IGNORE_lstat64
-#define __IGNORE_fstat64
-#define __IGNORE_fstatat64
-#endif
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_UNISTD_H */
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 9ec1026af877..385eae49ed02 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -10,9 +10,6 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
-#define __IGNORE_select			/* newselect */
-#define __IGNORE_fadvise64		/* fadvise64_64 */
-
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index ed08f114ee91..59202ceea1f6 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -10,8 +10,6 @@
 #include <uapi/asm/unistd.h>
 #include <asm/unistd_nr.h>
 
-#define __IGNORE_time
-
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_SYS_ALARM
diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index 0d34629dafc5..81cc52ea1bd5 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -10,18 +10,6 @@
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_GETPGRP
 
-/* 
- * Ignore legacy system calls in the checksyscalls.sh script
- */
-
-#define __IGNORE_fork				/* use clone */
-#define __IGNORE_time
-#define __IGNORE_alarm				/* use setitimer */
-#define __IGNORE_pause
-#define __IGNORE_mmap				/* use mmap2 */
-#define __IGNORE_vfork				/* use clone */
-#define __IGNORE_fadvise64			/* use fadvise64_64 */
-
 #define NR_syscalls				__NR_syscalls
 
 #endif /* _XTENSA_UNISTD_H */
-- 
2.20.0

