Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 706581A000A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 10:16:42 +1000 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 20:16:39 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 108C46E8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 20:16:26 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7E0GaKW4719014
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Aug 2014 00:16:36 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7E0GZsZ011143
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 20:16:36 -0400
Date: Wed, 13 Aug 2014 17:16:29 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 3/4] Partial revert of 81c98869faa5 ("kthread: ensure
 locality of task_struct allocations")
Message-ID: <20140814001629.GL11121@linux.vnet.ibm.com>
References: <20140814001301.GI11121@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140814001301.GI11121@linux.vnet.ibm.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, Matt Mackall <mpm@selenic.com>,
 David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Paul Mackerras <paulus@samba.org>, Tejun Heo <tj@kernel.org>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Christoph Lameter <cl@linux.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After discussions with Tejun, we don't want to spread the use of
cpu_to_mem() (and thus knowledge of allocators/NUMA topology details)
into callers, but would rather ensure the callees correctly handle
memoryless nodes. With the previous patches ("topology: add support for
node_to_mem_node() to determine the fallback node" and "slub: fallback
to node_to_mem_node() node if allocating on memoryless node") adding and
using node_to_mem_node(), we can safely undo part of the change to the
kthread logic from 81c98869faa5 ("kthread: ensure locality of
task_struct allocations").
    
Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

diff --git a/kernel/kthread.c b/kernel/kthread.c
index ef483220e855..10e489c448fe 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -369,7 +369,7 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
 {
 	struct task_struct *p;
 
-	p = kthread_create_on_node(threadfn, data, cpu_to_mem(cpu), namefmt,
+	p = kthread_create_on_node(threadfn, data, cpu_to_node(cpu), namefmt,
 				   cpu);
 	if (IS_ERR(p))
 		return p;
