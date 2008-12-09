Return-Path: <dave@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 748F5DDF76
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 05:21:55 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id mB9ILAJ5017900
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:10 -0700
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mB9ILbT5177174
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:37 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mB9ILaRd004951
	for <linuxppc-dev@ozlabs.org>; Tue, 9 Dec 2008 11:21:36 -0700
Subject: [PATCH 3/8] cleanup careful_allocation(): bootmem already panics
To: paulus@samba.org
From: Dave Hansen <dave@linux.vnet.ibm.com>
Date: Tue, 09 Dec 2008 10:21:33 -0800
References: <20081209182130.DB2150A2@kernel>
In-Reply-To: <20081209182130.DB2150A2@kernel>
Message-Id: <20081209182133.B06DD407@kernel>
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


If we fail a bootmem allocation, the bootmem code itself
panics.  No need to redo it here.

Also change the wording of the other panic.  We don't
strictly have to allocate memory on the specified node.
It is just a hint and that node may not even *have* any
memory on it.  In that case we can and do fall back to
other nodes.


Signed-off-by: Dave Hansen <dave@linux.vnet.ibm.com>
---

 linux-2.6.git-dave/arch/powerpc/mm/numa.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff -puN arch/powerpc/mm/numa.c~cleanup-careful_allocation arch/powerpc/mm/numa.c
--- linux-2.6.git/arch/powerpc/mm/numa.c~cleanup-careful_allocation	2008-12-09 10:16:05.000000000 -0800
+++ linux-2.6.git-dave/arch/powerpc/mm/numa.c	2008-12-09 10:16:05.000000000 -0800
@@ -836,7 +836,7 @@ static void __init *careful_allocation(i
 		ret = __lmb_alloc_base(size, align, lmb_end_of_DRAM());
 
 	if (!ret)
-		panic("numa.c: cannot allocate %lu bytes on node %d",
+		panic("numa.c: cannot allocate %lu bytes for node %d",
 		      size, nid);
 
 	/*
@@ -856,10 +856,6 @@ static void __init *careful_allocation(i
 		ret = (unsigned long)__alloc_bootmem_node(NODE_DATA(new_nid),
 				size, align, 0);
 
-		if (!ret)
-			panic("numa.c: cannot allocate %lu bytes on node %d",
-			      size, new_nid);
-
 		ret = __pa(ret);
 
 		dbg("alloc_bootmem %lx %lx\n", ret, size);
_
