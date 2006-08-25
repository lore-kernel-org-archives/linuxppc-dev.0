Return-Path: <will_schmidt@vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C90BB67C61
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Aug 2006 06:47:06 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id k7PKl09B030298
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 16:47:00 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7PKl2J8294472
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 16:47:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7PKl2TK027961
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Aug 2006 16:47:02 -0400
Subject: [PATCH] fixup ibm_architecture_vec definition
From: Will Schmidt <will_schmidt@vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Fri, 25 Aug 2006 15:46:59 -0500
Message-Id: <1156538819.5959.18.camel@localhost>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>
Reply-To: will_schmidt@vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi, 

This problem was noticed by one of the Phyp firmware folks.
Our ibm,client-architecture-support call was failing.

This patch correctly terminates the PVR list, and corrects the vector
length parms being passed in.  

Please apply.   :-) 

Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 462bced..7065390 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -643,16 +643,17 @@ static unsigned char ibm_architecture_ve
 	W(0xfffe0000), W(0x003a0000),	/* POWER5/POWER5+ */
 	W(0xffff0000), W(0x003e0000),	/* POWER6 */
 	W(0xfffffffe), W(0x0f000001),	/* all 2.04-compliant and earlier */
+	W(0x00000000), W(0xffffffff),	/* Terminator-list-entry */
 	5 - 1,				/* 5 option vectors */
 
 	/* option vector 1: processor architectures supported */
-	3 - 1,				/* length */
+	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV1_PPC_2_00 | OV1_PPC_2_01 | OV1_PPC_2_02 | OV1_PPC_2_03 |
 	OV1_PPC_2_04 | OV1_PPC_2_05,
 
 	/* option vector 2: Open Firmware options supported */
-	34 - 1,				/* length */
+	34 - 2,				/* length */
 	OV2_REAL_MODE,
 	0, 0,
 	W(0xffffffff),			/* real_base */
@@ -666,16 +667,16 @@ static unsigned char ibm_architecture_ve
 	48,				/* max log_2(hash table size) */
 
 	/* option vector 3: processor options supported */
-	3 - 1,				/* length */
+	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV3_FP | OV3_VMX,
 
 	/* option vector 4: IBM PAPR implementation */
-	2 - 1,				/* length */
+	2 - 2,				/* length */
 	0,				/* don't halt */
 
 	/* option vector 5: PAPR/OF options */
-	3 - 1,				/* length */
+	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
 	OV5_LPAR | OV5_SPLPAR | OV5_LARGE_PAGES,
 };
