Return-Path: <haokexin@gmail.com>
Received: from mail-yk0-x236.google.com (mail-yk0-x236.google.com
 [IPv6:2607:f8b0:4002:c07::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4ED5A1A0001
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 22:19:57 +1100 (AEDT)
Received: by ykr79 with SMTP id 79so1707735ykr.13
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Mar 2015 03:19:55 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc64: use fixed lock token for !CONFIG_PPC_SPLPAR
Date: Sat,  7 Mar 2015 19:19:43 +0800
Message-Id: <1425727183-30880-1-git-send-email-haokexin@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It makes no sense to use a variant lock token on a platform which
doesn't support for shared-processor logical partitions. Actually we
can eliminate a memory load by using a fixed lock token on these
platforms.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 arch/powerpc/include/asm/spinlock.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
index 4dbe072eecbe..d303cdad2519 100644
--- a/arch/powerpc/include/asm/spinlock.h
+++ b/arch/powerpc/include/asm/spinlock.h
@@ -30,7 +30,7 @@
 
 #define smp_mb__after_unlock_lock()	smp_mb()  /* Full ordering for lock. */
 
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC_SPLPAR
 /* use 0x800000yy when locked, where yy == CPU number */
 #ifdef __BIG_ENDIAN__
 #define LOCK_TOKEN	(*(u32 *)(&get_paca()->lock_token))
@@ -187,9 +187,13 @@ extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
 
 #ifdef CONFIG_PPC64
 #define __DO_SIGN_EXTEND	"extsw	%0,%0\n"
-#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
 #else
 #define __DO_SIGN_EXTEND
+#endif
+
+#ifdef CONFIG_PPC_SPLPAR
+#define WRLOCK_TOKEN		LOCK_TOKEN	/* it's negative */
+#else
 #define WRLOCK_TOKEN		(-1)
 #endif
 
-- 
2.1.0
