Return-Path: <markn@au1.ibm.com>
Received: from e23smtp03.au.ibm.com (E23SMTP03.au.ibm.com [202.81.18.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B6BEDDDDB
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:42:56 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp03.au.ibm.com (8.13.1/8.13.1) with ESMTP id m9RAfXm3011020
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:41:34 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9RAgp8W249664
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:42:51 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9RAgpJ8006006
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:42:51 +1100
Received: from ozlabs.au.ibm.com (ozlabs.au.ibm.com [9.190.163.12])
	by d23av01.au.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m9RAgpmP006003
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:42:51 +1100
Received: from wecm00-9-185-92-166.au.ibm.com (WECM00-9-185-92-166.au.ibm.com
	[9.185.92.166])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.au.ibm.com (Postfix) with ESMTP id 44D8F73744
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Oct 2008 21:42:48 +1100 (EST)
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: Add new CPU feature: CPU_FTR_UNALIGNED_LD_STD
Date: Mon, 27 Oct 2008 21:43:02 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810272143.02144.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add a new CPU feature bit, CPU_FTR_UNALIGNED_LD_STD, to be added
to the 64bit powerpc chips that can do unaligned load double and
store double (and not take a performance hit from it).

This is added to Power6 and Cell and will be used in an upcoming
patch to do the alignment in memcpy() only on CPUs that require
it.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 arch/powerpc/include/asm/cputable.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: upstream/arch/powerpc/include/asm/cputable.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/cputable.h
+++ upstream/arch/powerpc/include/asm/cputable.h
@@ -194,6 +194,7 @@ extern const char *powerpc_base_platform
 #define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
 #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
 #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
+#define CPU_FTR_UNALIGNED_LD_STD	LONG_ASM_CONST(0x0080000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -404,7 +405,7 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR)
+	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -415,7 +416,8 @@ extern const char *powerpc_base_platform
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ)
+	    CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ | \
+	    CPU_FTR_UNALIGNED_LD_STD)
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
