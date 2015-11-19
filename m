Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F00081A0BED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 07:24:49 +1100 (AEDT)
Received: from mail-lf0-x22a.google.com (mail-lf0-x22a.google.com
 [IPv6:2a00:1450:4010:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F4151141434
 for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2015 07:24:48 +1100 (AEDT)
Received: by lfaz4 with SMTP id z4so56074754lfa.0
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Nov 2015 12:24:45 -0800 (PST)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org,
	Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH] powerpc: wire up sys_mlock2
Date: Thu, 19 Nov 2015 23:23:09 +0300
Message-Id: <1447964589-4244-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tested with tools/testing/selftests/vm/mlock2-tests
both on ppc64 and ppc32

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/include/asm/systbl.h      | 1 +
 arch/powerpc/include/asm/unistd.h      | 2 +-
 arch/powerpc/include/uapi/asm/unistd.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index c9e26cb..dcce86c 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -382,3 +382,4 @@ COMPAT_SYS(shmat)
 SYSCALL(shmdt)
 SYSCALL(shmget)
 COMPAT_SYS(shmctl)
+SYSCALL_SPU(mlock2)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 6d8f802..4b6b8ac 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,7 +12,7 @@
 #include <uapi/asm/unistd.h>
 
 
-#define __NR_syscalls		378
+#define __NR_syscalls		379
 
 #define __NR__exit __NR_exit
 #define NR_syscalls	__NR_syscalls
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 81579e9..1effea5 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -400,5 +400,6 @@
 #define __NR_shmdt		375
 #define __NR_shmget		376
 #define __NR_shmctl		377
+#define __NR_mlock2		378
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
2.4.0
