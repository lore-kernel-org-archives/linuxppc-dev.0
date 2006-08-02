Return-Path: <sonny@kevlar.burdell.org>
Received: from kevlar.burdell.org (kevlar.burdell.org [66.92.73.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4C0D267B22
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 14:20:14 +1000 (EST)
Date: Wed, 2 Aug 2006 00:20:09 -0400
From: Sonny Rao <sonny@burdell.org>
To: paulus@samba.org
Subject: [PATCH] fix PMU initialization on pseries lpar
Message-ID: <20060802042009.GA15567@kevlar.burdell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We should not be calling power4_enable_pmcs() in
pseries_lpar_enable_pmcs(); just doing the hypercall is sufficient. 
Prior to 2.6.15 we did not call power4_enable_pmcs() for an lpar.

power4_enable_pmcs() tries to read the hid0 register which is no
longer legal for an lpar in newer Power processors.

--- a/arch/powerpc/platforms/pseries/setup.c	2006-04-23 01:45:09.000000000 -0500
+++ b/arch/powerpc/platforms/pseries/setup.c~pmcfix	2006-08-01 23:12:39.000000000 -0500
@@ -182,8 +182,6 @@ static void pseries_lpar_enable_pmcs(voi
 {
 	unsigned long set, reset;
 
-	power4_enable_pmcs();
-
 	set = 1UL << 63;
 	reset = 0;
 	plpar_hcall_norets(H_PERFMON, set, reset);
