Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5A173100B27
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:47 +1100 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HOqLH024865
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:24:52 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXZvF136844
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o98HXYxs021986
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 11:33:35 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 04/11] ppc: add memory_hotplug_max
Date: Fri,  8 Oct 2010 10:33:05 -0700
Message-Id: <1286559192-10898-5-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
	David Rientjes <rientjes@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a function to get the maximum address that can be hotplug added.
This is needed to calculate the size of the tce table needed to cover
all memory in 1:1 mode.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
Comments on where to export?
---
 arch/powerpc/include/asm/mmzone.h |    5 +++++
 arch/powerpc/mm/numa.c            |   26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index aac87cb..fd3fd58 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -33,6 +33,9 @@ extern int numa_cpu_lookup_table[];
 extern cpumask_var_t node_to_cpumask_map[];
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern unsigned long max_pfn;
+u64 memory_hotplug_max(void);
+#else
+#define memory_hotplug_max() memblock_end_of_DRAM()
 #endif
 
 /*
@@ -42,6 +45,8 @@ extern unsigned long max_pfn;
 #define node_start_pfn(nid)	(NODE_DATA(nid)->node_start_pfn)
 #define node_end_pfn(nid)	(NODE_DATA(nid)->node_end_pfn)
 
+#else
+#define memory_hotplug_max() memblock_end_of_DRAM()
 #endif /* CONFIG_NEED_MULTIPLE_NODES */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 002878c..f98b0d2 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1246,4 +1246,30 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 	return nid;
 }
 
+static u64 hot_add_drconf_memory_max(void)
+{
+        struct device_node *memory = NULL;
+        unsigned int drconf_cell_cnt = 0;
+        u64 lmb_size = 0;
+        const u32 *dm = 0;
+
+        memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+        if (memory) {
+                drconf_cell_cnt = of_get_drconf_memory(memory, &dm);
+                lmb_size = of_get_lmb_size(memory);
+                of_node_put(memory);
+        }
+        return lmb_size * drconf_cell_cnt;
+}
+
+/*
+ * memory_hotplug_max - return max address of memory that may be added
+ *
+ * This is currently only used on systems that support drconfig memory
+ * hotplug.
+ */
+u64 memory_hotplug_max(void)
+{
+        return max(hot_add_drconf_memory_max(), memblock_end_of_DRAM());
+}
 #endif /* CONFIG_MEMORY_HOTPLUG */
-- 
1.7.1
