Return-Path: <moilanen@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0E688DDF8F
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Mar 2007 08:52:20 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l22Lqt2l005206
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2007 16:52:55 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l22LqAWZ234002
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2007 16:52:10 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l22Lq9i7026659
	for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2007 16:52:09 -0500
Subject: [PATCH] DMA 4GB boundary protection
From: Jake Moilanen <moilanen@austin.ibm.com>
To: paulus@samba.org, olof@lixom.net
Content-Type: text/plain
Date: Fri, 02 Mar 2007 15:49:43 -0600
Message-Id: <1172872183.5310.145.camel@goblue>
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

There are many adapters which can not handle DMAing acrosss any 4 GB
boundary.  For instance the latest Emulex adapters.  

This normally is not an issue as firmware gives us dma-windows under
4gigs.  However, some of the new System-P boxes have dma-windows above
4gigs, and this present a problem.

I propose fixing it in the IOMMU allocation instead of making each
driver protect against it as it is more efficient, and won't require
changing every driver which has not considered this issue.

This patch checks to see if the mapping spans a 4 gig boundary, and if
it does, retries the allocation.  It tries the next allocation at the
start of the crossed 4 gig boundary.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
---

 arch/powerpc/kernel/iommu.c |   10 ++++++++++
 1 files changed, 10 insertions(+)

Index: powerpc/arch/powerpc/kernel/iommu.c
===================================================================
--- powerpc.orig/arch/powerpc/kernel/iommu.c
+++ powerpc/arch/powerpc/kernel/iommu.c
@@ -76,6 +76,7 @@ static unsigned long iommu_range_alloc(s
                                        unsigned int align_order)
 { 
 	unsigned long n, end, i, start;
+	unsigned long start_addr, end_addr;
 	unsigned long limit;
 	int largealloc = npages > 15;
 	int pass = 0;
@@ -146,6 +147,15 @@ static unsigned long iommu_range_alloc(s
 		}
 	}
 
+	/* DMA cannot cross 4 GB boundary */
+	start_addr = (n + tbl->it_offset) << PAGE_SHIFT;
+	end_addr = (end + tbl->it_offset) << PAGE_SHIFT;
+	if ((start_addr >> 32) != (end_addr >> 32)) {
+		end_addr &= 0xffffffff00000000l;
+		start = (end_addr >> PAGE_SHIFT) - tbl->it_offset;
+		goto again;
+	}
+
 	for (i = n; i < end; i++)
 		if (test_bit(i, tbl->it_map)) {
 			start = i+1;
