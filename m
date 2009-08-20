Return-Path: <mjw@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 498FAB7BA9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 09:22:00 +1000 (EST)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CBDC4DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Aug 2009 09:21:59 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7KNJqYe022983
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 17:19:52 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7KNLoAL253584
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 17:21:51 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7KNLo8Q030574
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 17:21:50 -0600
Received: from [9.10.86.161] (9-10-86-161.rchland.ibm.com [9.10.86.161])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	n7KNLokK030426
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Aug 2009 17:21:50 -0600
Subject: [PATCH] powerpc:  Adjust base and index registers in Altivec macros
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 20 Aug 2009 18:21:45 -0500
Message-Id: <1250810505.14522.3.camel@mx3>
Mime-Version: 1.0
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER6 systems RA needs to be the base and RB the index.  
If they are reversed you take a misdirect hit.  

Signed-off-by: Mike Wolf <mjwolf@us.ibm.com>

----
--- altivec.orig/arch/powerpc/include/asm/ppc_asm.h	2009-08-17 15:39:52.000000000 -0500
+++ altivec/arch/powerpc/include/asm/ppc_asm.h	2009-08-20 18:08:30.000000000 -0500
@@ -98,13 +98,13 @@
 #define REST_16FPRS(n, base)	REST_8FPRS(n, base); REST_8FPRS(n+8, base)
 #define REST_32FPRS(n, base)	REST_16FPRS(n, base); REST_16FPRS(n+16, base)
 
-#define SAVE_VR(n,b,base)	li b,THREAD_VR0+(16*(n));  stvx n,b,base
+#define SAVE_VR(n,b,base)	li b,THREAD_VR0+(16*(n));  stvx n,base,b
 #define SAVE_2VRS(n,b,base)	SAVE_VR(n,b,base); SAVE_VR(n+1,b,base)
 #define SAVE_4VRS(n,b,base)	SAVE_2VRS(n,b,base); SAVE_2VRS(n+2,b,base)
 #define SAVE_8VRS(n,b,base)	SAVE_4VRS(n,b,base); SAVE_4VRS(n+4,b,base)
 #define SAVE_16VRS(n,b,base)	SAVE_8VRS(n,b,base); SAVE_8VRS(n+8,b,base)
 #define SAVE_32VRS(n,b,base)	SAVE_16VRS(n,b,base); SAVE_16VRS(n+16,b,base)
-#define REST_VR(n,b,base)	li b,THREAD_VR0+(16*(n)); lvx n,b,base
+#define REST_VR(n,b,base)	li b,THREAD_VR0+(16*(n)); lvx n,base,b
 #define REST_2VRS(n,b,base)	REST_VR(n,b,base); REST_VR(n+1,b,base)
 #define REST_4VRS(n,b,base)	REST_2VRS(n,b,base); REST_2VRS(n+2,b,base)
 #define REST_8VRS(n,b,base)	REST_4VRS(n,b,base); REST_4VRS(n+4,b,base)
@@ -112,26 +112,26 @@
 #define REST_32VRS(n,b,base)	REST_16VRS(n,b,base); REST_16VRS(n+16,b,base)
 
 /* Save the lower 32 VSRs in the thread VSR region */
-#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,b,base)
+#define SAVE_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n));  STXVD2X(n,base,b)
 #define SAVE_2VSRS(n,b,base)	SAVE_VSR(n,b,base); SAVE_VSR(n+1,b,base)
 #define SAVE_4VSRS(n,b,base)	SAVE_2VSRS(n,b,base); SAVE_2VSRS(n+2,b,base)
 #define SAVE_8VSRS(n,b,base)	SAVE_4VSRS(n,b,base); SAVE_4VSRS(n+4,b,base)
 #define SAVE_16VSRS(n,b,base)	SAVE_8VSRS(n,b,base); SAVE_8VSRS(n+8,b,base)
 #define SAVE_32VSRS(n,b,base)	SAVE_16VSRS(n,b,base); SAVE_16VSRS(n+16,b,base)
-#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,b,base)
+#define REST_VSR(n,b,base)	li b,THREAD_VSR0+(16*(n)); LXVD2X(n,base,b)
 #define REST_2VSRS(n,b,base)	REST_VSR(n,b,base); REST_VSR(n+1,b,base)
 #define REST_4VSRS(n,b,base)	REST_2VSRS(n,b,base); REST_2VSRS(n+2,b,base)
 #define REST_8VSRS(n,b,base)	REST_4VSRS(n,b,base); REST_4VSRS(n+4,b,base)
 #define REST_16VSRS(n,b,base)	REST_8VSRS(n,b,base); REST_8VSRS(n+8,b,base)
 #define REST_32VSRS(n,b,base)	REST_16VSRS(n,b,base); REST_16VSRS(n+16,b,base)
 /* Save the upper 32 VSRs (32-63) in the thread VSX region (0-31) */
-#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,b,base)
+#define SAVE_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n));  STXVD2X(n+32,base,b)
 #define SAVE_2VSRSU(n,b,base)	SAVE_VSRU(n,b,base); SAVE_VSRU(n+1,b,base)
 #define SAVE_4VSRSU(n,b,base)	SAVE_2VSRSU(n,b,base); SAVE_2VSRSU(n+2,b,base)
 #define SAVE_8VSRSU(n,b,base)	SAVE_4VSRSU(n,b,base); SAVE_4VSRSU(n+4,b,base)
 #define SAVE_16VSRSU(n,b,base)	SAVE_8VSRSU(n,b,base); SAVE_8VSRSU(n+8,b,base)
 #define SAVE_32VSRSU(n,b,base)	SAVE_16VSRSU(n,b,base); SAVE_16VSRSU(n+16,b,base)
-#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,b,base)
+#define REST_VSRU(n,b,base)	li b,THREAD_VR0+(16*(n)); LXVD2X(n+32,base,b)
 #define REST_2VSRSU(n,b,base)	REST_VSRU(n,b,base); REST_VSRU(n+1,b,base)
 #define REST_4VSRSU(n,b,base)	REST_2VSRSU(n,b,base); REST_2VSRSU(n+2,b,base)
 #define REST_8VSRSU(n,b,base)	REST_4VSRSU(n,b,base); REST_4VSRSU(n+4,b,base)
