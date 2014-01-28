Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7EF642C0081
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jan 2014 05:35:09 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 28 Jan 2014 11:35:06 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 598CD1FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 11:35:04 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0SIZ4G064618530
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 19:35:04 +0100
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0SIZ2iw022993
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 11:35:03 -0700
Date: Tue, 28 Jan 2014 10:34:57 -0800
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Christoph Lameter <cl@linux.com>
Subject: [PATCH] powerpc: enable CONFIG_HAVE_MEMORYLESS_NODES
Message-ID: <20140128183457.GA9315@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Rientjes <rientjes@google.com>, Pekka Enberg <penberg@kernel.org>,
 linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Matt Mackall <mpm@selenic.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, linuxppc-dev@lists.ozlabs.org,
 Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anton Blanchard found an issue with an LPAR that had no memory in Node
0. Christoph Lameter recommended, as one possible solution, to use
numa_mem_id() for locality of the nearest memory node-wise. However,
numa_mem_id() [and the other related APIs] are only useful if
CONFIG_HAVE_MEMORYLESS_NODES is set. This is only the case for ia64
currently, but clearly we can have memoryless nodes on ppc64. Add the
Kconfig option and define it to be the same value as CONFIG_NUMA.

On the LPAR in question, which was very inefficiently using slabs, this
took the slab consumption at boot from roughly 7GB to roughly 4GB.
    
---
Ben, the only question I have wrt this change is if it's appropriate to
change it for all powerpc configs (that have NUMA on)?

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 25493a0..bb2d5fe 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -447,6 +447,9 @@ config NODES_SHIFT
 	default "4"
 	depends on NEED_MULTIPLE_NODES
 
+config HAVE_MEMORYLESS_NODES
+	def_bool NUMA
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on PPC64
