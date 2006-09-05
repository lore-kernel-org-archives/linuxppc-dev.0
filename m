Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id CA7C667B52
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 03:28:16 +1000 (EST)
Date: Tue, 5 Sep 2006 12:27:32 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, anton@samba.org
Subject: [2/5] powerpc: Divorce CPU_FTR_CTRL from CPU_FTR_PPCAS_ARCH_V2_BASE
Message-ID: <20060905122732.169d0fde@localhost.localdomain>
In-Reply-To: <20060904175742.5472a6fa@localhost.localdomain>
References: <20060904175742.5472a6fa@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The performance monitor implementation (including CTRL register behaviour)
is just included in PPC v2 as an example, it's not truly part of the base.

It's actually a somewhat misleading feature, but I'll leave that be for
now: The precense of the register is not what the feature bit is used
for, but instead it's used to determine if it contains the runlatch
bit for idle reporting of the performance monitor. For alternative
implementations, the register might still exist but the bit might have
different meaning (or no meaning at all).

For now, split it off and don't include it in CPU_FTR_PPCAS_ARCH_V2_BASE.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/include/asm-powerpc/cputable.h
===================================================================
--- merge.orig/include/asm-powerpc/cputable.h
+++ merge/include/asm-powerpc/cputable.h
@@ -148,7 +148,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 
 #define CPU_FTR_PPCAS_ARCH_V2_BASE (CPU_FTR_SLB | \
 					CPU_FTR_TLBIEL | CPU_FTR_NOEXECUTE | \
-					CPU_FTR_NODSISRALIGN | CPU_FTR_CTRL)
+					CPU_FTR_NODSISRALIGN)
 
 /* iSeries doesn't support large pages */
 #ifdef CONFIG_PPC_ISERIES
@@ -313,24 +313,25 @@ extern void do_cpu_ftr_fixups(unsigned l
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | \
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
 #define CPU_FTRS_POWER4	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_MMCRA)
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_MMCRA)
 #define CPU_FTRS_PPC970	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA)
 #define CPU_FTRS_POWER5	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR)
 #define CPU_FTRS_POWER6 (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_REAL_LE)
 #define CPU_FTRS_CELL	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
-	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_CTRL | CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
+	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 #endif
