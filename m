Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59E4068503
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2005 14:27:09 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 14:22:50 +1000
Message-Id: <1129090971.17365.271.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>, Steve Munroe <sjmunroe@us.ibm.com>
Subject: [PATCH] ppc32: Tell userland about lack of standard TB
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Glibc is about to get some new high precision timer stuff that relies on
the standard timebase of the PPC architecture. However, some (rare &
old) CPUs do not have such timebase and it is a bit annoying to have
your stuff just crash because you are running on the wrong CPU... This
exposes to userland a CPU feature bit that tells that the current
processor doesn't have a standard timebase. It's negative logic so that
glibc will still "just work" on older kernels (it will just be unhappy
on those old CPUs but that doesn't really matter as distro tend to
update glibc & kernel at the same time).

Might still be worth getting into 2.6.14 ...

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/cputable.c
===================================================================
--- linux-work.orig/arch/ppc/kernel/cputable.c	2005-10-12 11:43:52.000000000 +1000
+++ linux-work/arch/ppc/kernel/cputable.c	2005-10-12 11:48:07.000000000 +1000
@@ -91,7 +91,7 @@
 		.cpu_features		= CPU_FTR_COMMON | CPU_FTR_601 |
 			CPU_FTR_HPTE_TABLE,
 		.cpu_user_features 	= COMMON_PPC | PPC_FEATURE_601_INSTR |
-			PPC_FEATURE_UNIFIED_CACHE,
+			PPC_FEATURE_UNIFIED_CACHE | PPC_FEATURE_NO_TB,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.cpu_setup		= __setup_cpu_601
@@ -759,7 +759,8 @@
 		.cpu_name		= "403GCX",
 		.cpu_features		= CPU_FTR_SPLIT_ID_CACHE |
 			CPU_FTR_USE_TB,
-		.cpu_user_features	= PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
+		.cpu_user_features	= PPC_FEATURE_32 |
+		 	PPC_FEATURE_HAS_MMU | PPC_FEATURE_NO_TB,
 		.icache_bsize		= 16,
 		.dcache_bsize		= 16,
 	},
Index: linux-work/include/asm-ppc/cputable.h
===================================================================
--- linux-work.orig/include/asm-ppc/cputable.h	2005-09-22 14:07:27.000000000 +1000
+++ linux-work/include/asm-ppc/cputable.h	2005-10-12 11:47:06.000000000 +1000
@@ -24,6 +24,7 @@
 #define PPC_FEATURE_HAS_SPE		0x00800000
 #define PPC_FEATURE_HAS_EFP_SINGLE	0x00400000
 #define PPC_FEATURE_HAS_EFP_DOUBLE	0x00200000
+#define PPC_FEATURE_NO_TB		0x00100000
 
 #ifdef __KERNEL__
 
