Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406NXH37k0zF1kt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 21:42:07 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id s13so3090667pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 03:42:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH] powerpc: Fix smp_wmb barrier definition use use lwsync
 consistently
Date: Thu, 22 Mar 2018 20:41:46 +1000
Message-Id: <20180322104146.5350-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

asm/barrier.h is not always included after asm/synch.h, which meant
it was missing __SUBARCH_HAS_LWSYNC, so in some files smp_wmb() would
be eieio when it should be lwsync. kernel/time/hrtimer.c is one case.

__SUBARCH_HAS_LWSYNC is only used in one place, so just fold it in
to where it's used. Previously with my small simulator config, 377
instances of eieio in the tree. After this patch there are 55.

Cc: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/barrier.h | 3 ++-
 arch/powerpc/include/asm/synch.h   | 4 ----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index 10daa1d56e0a..c7c63959ba91 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -35,7 +35,8 @@
 #define rmb()  __asm__ __volatile__ ("sync" : : : "memory")
 #define wmb()  __asm__ __volatile__ ("sync" : : : "memory")
 
-#ifdef __SUBARCH_HAS_LWSYNC
+/* The sub-arch has lwsync */
+#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
 #    define SMPWMB      LWSYNC
 #else
 #    define SMPWMB      eieio
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index 63e7f5a1f105..6ec546090ba1 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -6,10 +6,6 @@
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
 
-#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
-#define __SUBARCH_HAS_LWSYNC
-#endif
-
 #ifndef __ASSEMBLY__
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
-- 
2.16.1
