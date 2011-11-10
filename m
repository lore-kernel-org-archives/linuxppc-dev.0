Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 9B186100804
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:08:50 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 08/17] powerpc/e500: Remove conditional "lwsync"
 substitution
Date: Wed,  9 Nov 2011 19:07:06 -0500
Message-Id: <1320883635-17194-9-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Timur Tabi <B04825@freescale.com>,
 linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As FreeScale e500 systems have different cacheline sizes from e500mc, it
is basically impossible for the kernel to support both in a single
system image at present.

Given that one is SPE-float and the other is classic-float, they are not
generally userspace-compatible either.

This patch updates the conditional to depend on whether the system is
actually targetting an "e500" or "e500mc" core and entirely removes the
unused sync-to-lwsync-replacement on e500v1/e500v2 systems.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/include/asm/synch.h |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index d7cab44..3d518b6 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -5,8 +5,11 @@
 #include <linux/stringify.h>
 #include <asm/feature-fixups.h>
 
-#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
+#if defined(__powerpc64__) || defined(CONFIG_FSL_E500MC)
 #define __SUBARCH_HAS_LWSYNC
+#define LWSYNC lwsync
+#else
+#define LWSYNC sync
 #endif
 
 #ifndef __ASSEMBLY__
@@ -25,17 +28,6 @@ static inline void isync(void)
 }
 #endif /* __ASSEMBLY__ */
 
-#if defined(__powerpc64__)
-#    define LWSYNC	lwsync
-#elif defined(CONFIG_E500)
-#    define LWSYNC					\
-	START_LWSYNC_SECTION(96);			\
-	sync;						\
-	MAKE_LWSYNC_SECTION_ENTRY(96, __lwsync_fixup);
-#else
-#    define LWSYNC	sync
-#endif
-
 #ifdef CONFIG_SMP
 #define __PPC_ACQUIRE_BARRIER				\
 	START_LWSYNC_SECTION(97);			\
-- 
1.7.2.5
