Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5AB13DDECB
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 04:13:51 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6AIDm2h019494
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:13:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l6AIDmxD485296
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:13:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6AIDmZB013977
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:13:48 -0400
Received: from [9.67.222.151] (wecm-9-67-222-151.wecm.ibm.com [9.67.222.151])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l6AIDmbP013919
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 14:13:48 -0400
Message-ID: <4693CC5B.4020207@linux.vnet.ibm.com>
Date: Tue, 10 Jul 2007 13:13:47 -0500
From: Mike Wolf <mjw@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Resend: [PATCH] oprofile support for Power 5++
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Reply-To: mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The patch has not been included and there have been no comments so
I'm resending.

This patch adds a new oprofile cpu type for Power 5 revision 3 chips.
The new name is ppc64/power5++ and is used so that the performance
counters can be set up correctly.

Signed-off-by: Mike Wolf <mjw@us.ibm.com>

-------- 
linux-2.6.18.ppc64.orig/arch/powerpc/kernel/cputable.c	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.18.ppc64/arch/powerpc/kernel/cputable.c	2007-06-11 12:29:47.000000000 -0500
@@ -236,6 +236,21 @@
 		.oprofile_mmcra_sipr	= MMCRA_SIPR,
 		.platform		= "power5",
 	},
+	{	/* Power5++ */
+		.pvr_mask		= 0xffffff00,
+		.pvr_value		= 0x003b0300,
+		.cpu_name		= "POWER5+ (gs)",
+		.cpu_features		= CPU_FTRS_POWER5,
+		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.oprofile_cpu_type	= "ppc64/power5++",
+		.oprofile_type		= PPC_OPROFILE_POWER4,
+		.oprofile_mmcra_sihv	= MMCRA_SIHV,
+		.oprofile_mmcra_sipr	= MMCRA_SIPR,
+		.platform		= "power5+",
+	},
 	{	/* Power5 GS */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x003b0000,
