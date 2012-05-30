Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4777FB7012
 for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2012 17:43:41 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org, support@abatron.ch,
 Bob Cochran <ppc@mindchasers.com>
Subject: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
Date: Wed, 30 May 2012 09:43:34 +0200
Message-Id: <1338363814-19565-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Emulators such as BDI2000 and CodeWarrior needs to have MSR_DE set
in order to support break points.
This adds MSR_DE for kernel space only.
---

I have tested this briefly with BDI2000 on P2010(e500) and
it works for me. I don't know if there are any bad side effects, therfore
this RFC.

 arch/powerpc/include/asm/reg.h       |    2 +-
 arch/powerpc/include/asm/reg_booke.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7fdc2c0..25c8554 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -108,7 +108,7 @@
 #define MSR_USER64	MSR_USER32 | MSR_64BIT
 #elif defined(CONFIG_PPC_BOOK3S_32) || defined(CONFIG_8xx)
 /* Default MSR for kernel mode. */
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR)
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_DE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 500fe1d..0cb259b 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -37,7 +37,7 @@
 #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #else
-#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE|MSR_DE)
 #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
 #endif
 
-- 
1.7.3.4
