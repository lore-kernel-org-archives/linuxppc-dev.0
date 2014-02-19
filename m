Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8DB402C0082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 10:25:20 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Wed, 19 Feb 2014 16:25:17 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3B0611FF004A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 16:25:14 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1JNPEXX5439908
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Feb 2014 00:25:14 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1JNN70q002108
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Feb 2014 16:23:07 -0700
Date: Wed, 19 Feb 2014 15:23:01 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Michal Hocko <mhocko@suse.cz>, Mel Gorman <mgorman@suse.de>,
 linux-mm@kvack.org, Christoph Lameter <cl@linux.com>,
 David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Ben Herrenschmidt <benh@kernel.crashing.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/3] powerpc: enable CONFIG_HAVE_MEMORYLESS_NODES
Message-ID: <20140219232301.GE413@linux.vnet.ibm.com>
References: <20140219231641.GA413@linux.vnet.ibm.com>
 <20140219231714.GB413@linux.vnet.ibm.com>
 <20140219231800.GC413@linux.vnet.ibm.com>
 <20140219232221.GD413@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140219232221.GD413@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard found an issue with an LPAR that had no memory in Node
0.  Christoph Lameter recommended, as one possible solution, to use
numa_mem_id() for locality of the nearest memory node-wise. However,
numa_mem_id() [and the other related APIs] are only useful if
CONFIG_HAVE_MEMORYLESS_NODES is set.  This is only the case for ia64
currently, but clearly we can have memoryless nodes on ppc64. Add the
Kconfig option and define it to be the same value as CONFIG_NUMA.

On the LPAR in question, which was very inefficiently using slabs, this
took the slab consumption at boot from roughly 7GB to roughly 4GB.

Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: linuxppc-dev@lists.ozlabs.org

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a84816c..0f5cd68 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -449,6 +449,9 @@ config NODES_SHIFT
 	default "4"
 	depends on NEED_MULTIPLE_NODES
 
+config HAVE_MEMORYLESS_NODES
+	def_bool NUMA
+
 config USE_PERCPU_NUMA_NODE_ID
 	def_bool y
 	depends on NUMA
