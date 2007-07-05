Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7FF50DDF72
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jul 2007 03:03:51 +1000 (EST)
Message-Id: <20070705170241.635415000@lixom.net>
References: <20070705170233.258351000@lixom.net>
Date: Thu, 05 Jul 2007 12:03:03 -0500
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [patch 30/35] Disable PURR on pa6t
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Our PURR ticks at the wrong rate (same as the decrementer). Since it
doesn't really have any value-add besides on partitioned and multithreaded
systems, refrain from using it at the moment.


Index: 2.6.21/include/asm-powerpc/cputable.h
===================================================================
--- 2.6.21.orig/include/asm-powerpc/cputable.h
+++ 2.6.21/include/asm-powerpc/cputable.h
@@ -356,7 +356,7 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTRS_PA6T (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
+	    CPU_FTR_REAL_LE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 

--
