Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 36B791A0B6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Sep 2014 05:06:49 +1000 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 9 Sep 2014 13:06:46 -0600
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 229BF3E40047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 13:06:44 -0600 (MDT)
Received: from d03av01.ahe.boulder.ibm.com (d03av01.boulder.ibm.com
 [9.17.195.167])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s89J6iZR25821190
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 21:06:44 +0200
Received: from d03av01.ahe.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.ahe.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s89J6d1e006710
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Sep 2014 13:06:43 -0600
Date: Tue, 9 Sep 2014 12:06:30 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/3] Partial revert of 81c98869faa5 ("kthread: ensure
 locality of task_struct allocations")
Message-ID: <20140909190630.GF22906@linux.vnet.ibm.com>
References: <20140909190154.GC22906@linux.vnet.ibm.com>
 <20140909190326.GD22906@linux.vnet.ibm.com>
 <20140909190514.GE22906@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140909190514.GE22906@linux.vnet.ibm.com>
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
kthread logic from 81c98869faa5.

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
