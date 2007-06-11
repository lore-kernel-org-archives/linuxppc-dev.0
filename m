Return-Path: <mjw@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D93BDDECE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 04:49:27 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l5BInNAP024504
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 14:49:23 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l5BInJwE266806
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 12:49:20 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l5BInISb007563
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 12:49:19 -0600
Received: from [9.10.86.124] (mx3.rchland.ibm.com [9.10.86.124])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l5BInIlH007548
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 12:49:18 -0600
Subject: [PATCH] oprofile support for Power 5++
From: Mike Wolf <mjw@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 13:49:18 -0500
Message-Id: <1181587758.20372.1.camel@localhost>
Mime-Version: 1.0
Reply-To: mjw@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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
