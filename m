Return-Path: <moilanen@austin.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C02667C08
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 02:21:00 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAMFKow8023937
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 10:20:50 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kAMFKo5i172906
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 10:20:50 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kAMFKoh1027389
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 10:20:50 -0500
Subject: [PATCH] CAS DFP support
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain
Date: Wed, 22 Nov 2006 09:20:14 -0600
Message-Id: <1164208814.1954.372.camel@goblue>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When booting a Power6 in compat mode, the DFP bit must be set in the
client architecture call, or else firmware will downgrade the compliance
to P5 compat mode, thus removing VMX and DFP instructions.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

--- 2.6/arch/powerpc/kernel/prom_init.c~	2006-11-13 15:01:13.000000000
-0600
+++ 2.6/arch/powerpc/kernel/prom_init.c	2006-11-21 18:38:27.000000000
-0600
@@ -627,6 +627,7 @@ static void __init early_cmdline_parse(v
 /* Option vector 3: processor options supported */
 #define OV3_FP			0x80	/* floating point */
 #define OV3_VMX			0x40	/* VMX/Altivec */
+#define OV3_DFP			0x20	/* decimal floating point */
 
 /* Option vector 5: PAPR/OF options supported */
 #define OV5_LPAR		0x80	/* logical partitioning supported */
@@ -674,7 +675,7 @@ static unsigned char ibm_architecture_ve
 	/* option vector 3: processor options supported */
 	3 - 2,				/* length */
 	0,				/* don't ignore, don't halt */
-	OV3_FP | OV3_VMX,
+	OV3_FP | OV3_VMX | OV3_DFP,
 
 	/* option vector 4: IBM PAPR implementation */
 	2 - 2,				/* length */
