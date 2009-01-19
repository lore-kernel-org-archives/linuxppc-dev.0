Return-Path: <chandru@in.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [59.145.155.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D03B5DE011
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 22:30:08 +1100 (EST)
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp03.in.ibm.com (8.13.1/8.13.1) with ESMTP id n0JBU3Nf000905
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 17:00:03 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0JBS7t94182134
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 16:58:07 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
	by d28av05.in.ibm.com (8.13.1/8.13.3) with ESMTP id n0JBU2fv011785
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jan 2009 22:30:03 +1100
From: Chandru <chandru@in.ibm.com>
To: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: 2.6.28-rc9 panics with crashkernel=256M while booting
Date: Mon, 19 Jan 2009 17:00:03 +0530
References: <200812241325.49404.chandru@in.ibm.com>
	<200901161746.36584.chandru@in.ibm.com>
	<1232128377.27278.69.camel@nimitz>
In-Reply-To: <1232128377.27278.69.camel@nimitz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901191700.03580.chandru@in.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In case either physbase or reserve_size are not page aligned and in addition
if the following condition is also true

node_ar.end_pfn = node->node_end_pfn = PFN_DOWN(physbase+reserve_size).

we may hit the BUG_ON(end > bdata->node_low_pfn) in mark_bootmem_node() in
mm/bootmem.c Hence pass the pfn that the physbase is part of and align
reserve_size before calling reserve_bootmem_node().

Signed-off-by: Chandru S <chandru@linux.vnet.ibm.com>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-2.6.29-rc2/arch/powerpc/mm/numa.c.orig	2009-01-19 16:14:49.000000000 +0530
+++ linux-2.6.29-rc2/arch/powerpc/mm/numa.c	2009-01-19 16:36:38.000000000 +0530
@@ -901,7 +901,8 @@ static void mark_reserved_regions_for_ni
 		get_node_active_region(start_pfn, &node_ar);
 		while (start_pfn < end_pfn &&
 			node_ar.start_pfn < node_ar.end_pfn) {
-			unsigned long reserve_size = size;
+			unsigned long reserve_size = (size >> PAGE_SHIFT) <<
+								PAGE_SHIFT;
 			/*
 			 * if reserved region extends past active region
 			 * then trim size to active region
@@ -917,7 +918,8 @@ static void mark_reserved_regions_for_ni
 				dbg("reserve_bootmem %lx %lx nid=%d\n",
 					physbase, reserve_size, node_ar.nid);
 				reserve_bootmem_node(NODE_DATA(node_ar.nid),
-						physbase, reserve_size,
+						(start_pfn << PAGE_SHIFT),
+						reserve_size,
 						BOOTMEM_DEFAULT);
 			}
 			/*
