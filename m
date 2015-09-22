Return-Path: <raghavendra.kt@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44AEA1A08C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 05:34:55 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <raghavendra.kt@linux.vnet.ibm.com>;
 Tue, 22 Sep 2015 15:34:51 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 04477C9006E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 15:25:52 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8MJYmwl62521482
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 19:34:48 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8MJYkL9002202
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 15:34:48 -0400
Date: Wed, 23 Sep 2015 01:06:20 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, anton@samba.org,
 akpm@linux-foundation.org, nacc@linux.vnet.ibm.com,
 gkurz@linux.vnet.ibm.com, grant.likely@linaro.org,
 nikunj@linux.vnet.ibm.com, vdavydov@parallels.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH V2  2/2] powerpc:numa Do not allocate bootmem memory for
 non existing nodes
Message-ID: <20150922193620.GA6942@linux.vnet.ibm.com>
Reply-To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
References: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1442282917-16893-3-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1442899743.18408.5.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1442899743.18408.5.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Michael Ellerman <mpe@ellerman.id.au> [2015-09-22 15:29:03]:

> On Tue, 2015-09-15 at 07:38 +0530, Raghavendra K T wrote:
> >
> > ... nothing
> 
> Sure this patch looks obvious, but please give me a changelog that proves
> you've thought about it thoroughly.
> 
> For example is it OK to use for_each_node() at this point in boot? Is there any
> historical reason why we did it with a hard coded loop? If so what has changed.
> What systems have you tested on? etc. etc.
> 
> cheers

Hi Michael,
resending the patches with the changelog.

Please note that the patch is in -mm tree already.

---8<---
>From 86ead2520662c362d7b9ebd452ce1c33e156016f Mon Sep 17 00:00:00 2001
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Date: Sun, 6 Sep 2015 12:54:40 +0530
Subject: [PATCH V2  2/2] powerpc:numa Do not allocate bootmem memory for non
 existing nodes

With the setup_nr_nodes(), we have already initialized
node_possible_map. So it is safe to use for_each_node here.

There are many places in the kernel that use hardcoded 'for' loop with
nr_node_ids, because all other architectures have numa nodes populated
serially. That should be reason we had maintained the same for powerpc.

But, since sparse numa node ids possible on powerpc, we
unnecessarily allocate memory for non existent numa nodes.

For e.g., on a system with 0,1,16,17 as numa nodes nr_node_ids=18
and we allocate memory for nodes 2-14. This patch we allocate
memory for only existing numa nodes.

The patch is boot tested on a 4 node tuleta [ confirming with printks ].
that it works as expected.

Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 8b9502a..8d8a541 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -80,7 +80,7 @@ static void __init setup_node_to_cpumask_map(void)
 		setup_nr_node_ids();
 
 	/* allocate the map */
-	for (node = 0; node < nr_node_ids; node++)
+	for_each_node(node)
 		alloc_bootmem_cpumask_var(&node_to_cpumask_map[node]);
 
 	/* cpumask_of_node() will now work */
-- 
1.7.11.7
