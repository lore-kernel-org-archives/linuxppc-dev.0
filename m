Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AA8412C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 10:16:53 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 16:16:50 -0700
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D576F38C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 18:16:47 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JNGl6X9175308
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 23:16:47 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JNGklM023323
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 18:16:47 -0500
Date: Wed, 19 Feb 2014 15:16:41 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Nish Aravamudan <nacc@linux.vnet.ibm.com>
Subject: [PATCH 0/3] powerpc: support memoryless nodes
Message-ID: <20140219231641.GA413@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Hocko <mhocko@suse.cz>, linux-mm@kvack.org,
 Mel Gorman <mgorman@suse.de>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have seen several issues recently on powerpc LPARs with memoryless
node NUMA configurations, e.g. (an extreme case):

numactl --hardware
available: 2 nodes (0,3)
node 0 cpus:
node 0 size: 0 MB
node 0 free: 0 MB
node 3 cpus: 0 1 2 3
node 3 size: 8142 MB
node 3 free: 7765 MB
node distances:
node   0   3 
  0:  10  20 
  3:  20  10 

powerpc doesn't set CONFIG_HAVE_MEMORYLESS_NODES, so we are missing out
on a lot of the core-kernel support necessary. This series attempts to
fix this by enabling the config option, which requires a few other
changes as well.

1/3: mm: return NUMA_NO_NODE in local_memory_node if zonelists are not
setup
2/3: powerpc: enable CONFIG_HAVE_PERCPU_NUMA_NODE_ID
3/3: powerpc: enable CONFIG_HAVE_MEMORYLESS_NODES

I have tested this series with Christoph's patch (currently being
discussed): http://www.spinics.net/lists/linux-mm/msg69452.html

Thanks,
Nish
