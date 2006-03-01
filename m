Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABC0D67A3D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Mar 2006 15:07:14 +1100 (EST)
Subject: [PATCH] Expose SMT and L1 icache snoop userland features
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 01 Mar 2006 15:07:07 +1100
Message-Id: <1141186028.4157.33.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes userland aware of the icache snoop capability of the
POWER5 (and possibly others in the future) and of SMT capabilities.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/powerpc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/powerpc/kernel/cputable.c	2006-02-07 13:17:04.000000000 +1100
+++ linux-work/arch/powerpc/kernel/cputable.c	2006-03-01 14:59:20.000000000 +1100
@@ -53,8 +53,10 @@ extern void __setup_cpu_ppc970(unsigned 
 				 PPC_FEATURE_HAS_MMU)
 #define COMMON_USER_PPC64	(COMMON_USER | PPC_FEATURE_64)
 #define COMMON_USER_POWER4	(COMMON_USER_PPC64 | PPC_FEATURE_POWER4)
-#define COMMON_USER_POWER5	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5)
-#define COMMON_USER_POWER5_PLUS	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5_PLUS)
+#define COMMON_USER_POWER5	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5 |\
+				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
+#define COMMON_USER_POWER5_PLUS	(COMMON_USER_PPC64 | PPC_FEATURE_POWER5_PLUS|\
+				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP)
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
 
@@ -267,7 +269,8 @@ struct cpu_spec	cpu_specs[] = {
 		.cpu_name		= "Cell Broadband Engine",
 		.cpu_features		= CPU_FTRS_CELL,
 		.cpu_user_features	= COMMON_USER_PPC64 |
-			PPC_FEATURE_CELL | PPC_FEATURE_HAS_ALTIVEC_COMP,
+			PPC_FEATURE_CELL | PPC_FEATURE_HAS_ALTIVEC_COMP |
+			PPC_FEATURE_SMT,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.cpu_setup		= __setup_cpu_be,
Index: linux-work/include/asm-powerpc/cputable.h
===================================================================
--- linux-work.orig/include/asm-powerpc/cputable.h	2006-02-28 16:52:18.000000000 +1100
+++ linux-work/include/asm-powerpc/cputable.h	2006-03-01 14:27:51.000000000 +1100
@@ -20,6 +20,8 @@
 #define PPC_FEATURE_POWER5_PLUS		0x00020000
 #define PPC_FEATURE_CELL		0x00010000
 #define PPC_FEATURE_BOOKE		0x00008000
+#define PPC_FEATURE_SMT			0x00004000
+#define PPC_FEATURE_ICACHE_SNOOP	0x00002000
 
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
