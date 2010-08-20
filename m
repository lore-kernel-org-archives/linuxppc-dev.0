Return-Path: <sonny@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E0077B70DC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 20 Aug 2010 14:54:24 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o7K4nVqU002312
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2010 22:49:31 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o7K4sLtj122950
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2010 22:54:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o7K4sLBK023220
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2010 22:54:21 -0600
Received: from us.ibm.com (dyn9414181.austin.ibm.com [9.41.41.81])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o7K4sLAm023215
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Aug 2010 22:54:21 -0600
Resent-Message-ID: <20100820045615.GU16505@us.ibm.com>
Date: Thu, 19 Aug 2010 23:10:19 -0500
From: Sonny Rao <sonnyrao@us.ibm.com>
To: linux-ppc@lists.ozlabs.org
Subject: [PATCH 2/2]: Powerpc: Fix EHCA driver on relocatable kernel
Message-ID: <20100820041019.GT16505@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rdma@vger.kernel.org, fenkes@de.ibm.com, raisch@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

the eHCA driver registers a MR for all of kernel memory, but makes the
assumption that valid memory exists at KERNELBASE.  This assumption
may not be true in the case of a relocatable kernel, so use KERNELBASE
+ PHYSICAL_START to get the true beginning of usable kernel memory.

This patch depends on the earlier patch which exports the necessary
symbol for PHYSICAL_START in a relocatable kernel.

cc: Joachim Fenkes <fenkes@de.ibm.com>
cc: Christoph Raisch <raisch@de.ibm.com>
cc: Hoan-Ham Hguyen <hnguyen@de.ibm.com>
Signed-off-by: Sonny Rao <sonnyrao@us.ibm.com>


Index: linux-2.6/drivers/infiniband/hw/ehca/ehca_mrmw.c
===================================================================
--- linux-2.6.orig/drivers/infiniband/hw/ehca/ehca_mrmw.c	2010-08-09 22:16:57.688652613 -0500
+++ linux-2.6/drivers/infiniband/hw/ehca/ehca_mrmw.c	2010-08-19 22:53:03.451507146 -0500
@@ -171,7 +171,7 @@
 		}

 		ret = ehca_reg_maxmr(shca, e_maxmr,
-				     (void *)ehca_map_vaddr((void *)KERNELBASE),
+				     (void *)ehca_map_vaddr((void *)(KERNELBASE + PHYSICAL_START)),
 				     mr_access_flags, e_pd,
 				     &e_maxmr->ib.ib_mr.lkey,
 				     &e_maxmr->ib.ib_mr.rkey);
@@ -1636,7 +1636,7 @@

 	/* register internal max-MR on HCA */
 	size_maxmr = ehca_mr_len;
-	iova_start = (u64 *)ehca_map_vaddr((void *)KERNELBASE);
+	iova_start = (u64 *)ehca_map_vaddr((void *)(KERNELBASE + PHYSICAL_START));
 	ib_pbuf.addr = 0;
 	ib_pbuf.size = size_maxmr;
 	num_kpages = NUM_CHUNKS(((u64)iova_start % PAGE_SIZE) + size_maxmr,
@@ -2209,7 +2209,7 @@
 {
 	/* a MR is treated as max-MR only if it fits following: */
 	if ((size == ehca_mr_len) &&
-	    (iova_start == (void *)ehca_map_vaddr((void *)KERNELBASE))) {
+	    (iova_start == (void *)ehca_map_vaddr((void *)(KERNELBASE + PHYSICAL_START)))) {
 		ehca_gen_dbg("this is a max-MR");
 		return 1;
 	} else
