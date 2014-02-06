Return-Path: <iamjoonsoo.kim@lge.com>
Received: from lgemrelse7q.lge.com (LGEMRELSE7Q.lge.com [156.147.1.151])
 by ozlabs.org (Postfix) with ESMTP id A67652C009E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 19:06:59 +1100 (EST)
From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/3] topology: support node_numa_mem() for determining the
 fallback node
Date: Thu,  6 Feb 2014 17:07:05 +0900
Message-Id: <1391674026-20092-2-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <20140206020757.GC5433@linux.vnet.ibm.com>
 <1391674026-20092-1-git-send-email-iamjoonsoo.kim@lge.com>
Cc: Han Pingtian <hanpt@linux.vnet.ibm.com>, mpm@selenic.com,
 penberg@kernel.org, linux-mm@kvack.org, paulus@samba.org,
 Anton Blanchard <anton@samba.org>, David Rientjes <rientjes@google.com>,
 Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Wanpeng Li <liwanp@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

diff --git a/include/linux/topology.h b/include/linux/topology.h
index 12ae6ce..a6d5438 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -233,11 +233,20 @@ static inline int numa_node_id(void)
  * Use the accessor functions set_numa_mem(), numa_mem_id() and cpu_to_mem().
  */
 DECLARE_PER_CPU(int, _numa_mem_);
+int _node_numa_mem_[MAX_NUMNODES];
 
 #ifndef set_numa_mem
 static inline void set_numa_mem(int node)
 {
 	this_cpu_write(_numa_mem_, node);
+	_node_numa_mem_[numa_node_id()] = node;
+}
+#endif
+
+#ifndef get_numa_mem
+static inline int get_numa_mem(int node)
+{
+	return _node_numa_mem_[node];
 }
 #endif
 
@@ -260,6 +269,7 @@ static inline int cpu_to_mem(int cpu)
 static inline void set_cpu_numa_mem(int cpu, int node)
 {
 	per_cpu(_numa_mem_, cpu) = node;
+	_node_numa_mem_[numa_node_id()] = node;
 }
 #endif
 
@@ -273,6 +283,13 @@ static inline int numa_mem_id(void)
 }
 #endif
 
+#ifndef get_numa_mem
+static inline int get_numa_mem(int node)
+{
+	return node;
+}
+#endif
+
 #ifndef cpu_to_mem
 static inline int cpu_to_mem(int cpu)
 {
-- 
1.7.9.5
