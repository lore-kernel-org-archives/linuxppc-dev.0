Return-Path: <dave@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 283A0DDF47
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:41 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9IL1E9024920
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:01 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILa1c183118
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 13:21:36 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9JLjfm012683
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 14:21:46 -0500
Subject: [PATCH 2/8] Add better comment on careful_allocation()
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:32 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182132.9C2A37FD@kernel>
Cc: Jon Tollefson <kniht@linux.vnet.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
	Dave Hansen <dave@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	"Serge E. Hallyn" <serue@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


The behavior in careful_allocation() really confused me
at first.  Add a comment to hopefully make it easier
on the next doofus that looks at it.

Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/mm/numa.c~cleanup-careful_allocation4 arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~cleanup-careful_allocation4	2008-12-09 10:16:05.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:05.000000000 -0800
@@ -840,8 +840,16 @@ static void __init *careful_allocation(i
 		      size, nid);
 
 	/*
-	 * If the memory came from a previously allocated node, we must
-	 * retry with the bootmem allocator.
+	 * We initialize the nodes in numeric order: 0, 1, 2...
+	 * and hand over control from the LMB allocator to the
+	 * bootmem allocator.  If this function is called for
+	 * node 5, then we know that all nodes <5 are using the
+	 * bootmem allocator instead of the LMB allocator.
+	 *
+	 * So, check the nid from which this allocation came
+	 * and double check to see if we need to use bootmem
+	 * instead of the LMB.  We don't free the LMB memory
+	 * since it would be useless.
 	 */
 	new_nid = early_pfn_to_nid(ret >> PAGE_SHIFT);
 	if (new_nid < nid) {
_
