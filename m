Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01A88B6EF0
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2011 15:29:39 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC][PATCH] powerpc/book3e: Fix CPU feature handling on e5500
Date: Wed,  6 Apr 2011 00:29:32 -0500
Message-Id: <1302067772-32104-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_FTRS_POSSIBLE and CPU_FTRS_ALWAYS defines did not encompass
e5500 CPU features when built for 64-bit.  This causes issues with
cpu_has_feature() as it utilizes the POSSIBLE & ALWAYS defines as part
of its check.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* I'm concerned if its ok to assume 'enum' can handle a 64-bit mask or not.
  I'm assuming this is the reason that we use a #define on __powerpc64__

 arch/powerpc/include/asm/cputable.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index be3cdf9..8200e9d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -434,7 +434,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
-#ifdef __powerpc64__
+#if defined(__powerpc64__) && !defined(CONFIG_PPC_BOOK3E)
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
@@ -478,7 +478,7 @@ enum {
 };
 #endif /* __powerpc64__ */
 
-#ifdef __powerpc64__
+#if defined(__powerpc64__) && !defined(CONFIG_PPC_BOOK3E)
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
 	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_POWER6 &	\
-- 
1.7.3.4
