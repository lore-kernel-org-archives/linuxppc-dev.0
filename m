Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 22 Nov 2006 18:55:34 +1100
Subject: [PATCH 8/9] Make 64-bit cpu features defined on 32-bit
In-Reply-To: <1164182122.302443.256192350213.qpush@cradle>
Message-Id: <20061122075539.4E92B67D89@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It saves #ifdef'ing in callers if we at least define the 64-bit cpu
features for 32-bit also.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 include/asm-powerpc/cputable.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: cell/include/asm-powerpc/cputable.h
===================================================================
--- cell.orig/include/asm-powerpc/cputable.h
+++ cell/include/asm-powerpc/cputable.h
@@ -312,7 +312,8 @@ extern void do_feature_fixups(unsigned l
 #define CPU_FTRS_E500_2	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
-#ifdef __powerpc64__
+
+/* 64-bit CPUs */
 #define CPU_FTRS_POWER3	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PPC_LE)
 #define CPU_FTRS_RS64	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
@@ -344,7 +345,6 @@ extern void do_feature_fixups(unsigned l
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
-#endif
 
 #ifdef __powerpc64__
 #define CPU_FTRS_POSSIBLE	\
