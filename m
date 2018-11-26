Return-Path: <SRS0=3VWP=OF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F8FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:51:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1740F208E7
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Nov 2018 20:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1740F208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433fG20xSPzDqcK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:51:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433dyh5X9MzDqTw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 07:37:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wAQKYdOx168357
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:37:46 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p0nc06vf6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2018 15:37:46 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Mon, 26 Nov 2018 20:37:44 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 26 Nov 2018 20:37:42 -0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wAQKbfQY16711868
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 26 Nov 2018 20:37:42 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DCDE0C6057;
 Mon, 26 Nov 2018 20:37:41 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AACBCC6055;
 Mon, 26 Nov 2018 20:37:41 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (unknown [9.40.193.67])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 26 Nov 2018 20:37:41 +0000 (GMT)
Received: from ltczep4-lp5.aus.stglabs.ibm.com (localhost [IPv6:::1])
 by ltczep4-lp5.aus.stglabs.ibm.com (Postfix) with ESMTP id 64E3E40CAA83;
 Mon, 26 Nov 2018 14:37:41 -0600 (CST)
Subject: [Internal Review PATCH] powerpc/pseries: Move DRMEM processing out
 of numa.c
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Juliet Kim <minkim@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Mon, 26 Nov 2018 14:37:41 -0600
In-Reply-To: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
References: <20181126203633.11871.94010.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112620-0012-0000-0000-000016E041E0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010125; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123169; UDB=6.00583042; IPR=6.00903298; 
 MB=3.00024341; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-26 20:37:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112620-0013-0000-0000-0000553E95BB
Message-Id: <20181126203727.11871.10290.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-26_15:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811260175
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The implementation of the pseries-specific dynamic memory features
is currently implemented in several non-pseries-specific files.
This patch set moves the implementation of the device-tree parsing
code for the properties ibm,dynamic-memory, ibm,dynamic-memory-v2,
and its representation in the kernel into the platform-specific
directory to the Pseries features.

This patch refactors references to drmem features out of numa.c, so
that they can be moved to drmem.c.  Changes include exporting a few
support functions from numa.c via powerpc/include/asm/topology.h, and
the creation of platform function platform_parse_numa_properties that
any powerpc platform may implement.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/topology.h    |   13 +
 arch/powerpc/mm/numa.c                 |  238 +++--------------------
 arch/powerpc/platforms/pseries/drmem.c |  330 ++++++++++++++++++++++++++++----
 3 files changed, 329 insertions(+), 252 deletions(-)

diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/topology.h
index a4a718d..0c1ad7e 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -135,5 +135,18 @@ static inline void shared_proc_topology_init(void) {}
 #endif
 #endif
 
+extern unsigned long numa_enforce_memory_limit(unsigned long start,
+						unsigned long size);
+extern void initialize_distance_lookup_table(int nid,
+					const __be32 *associativity);
+extern int fake_numa_create_new_node(unsigned long end_pfn,
+					unsigned int *nid);
+
+struct assoc_arrays {
+	u32     n_arrays;
+	u32     array_sz;
+	const __be32 *arrays;
+};
+
 #endif /* __KERNEL__ */
 #endif	/* _ASM_POWERPC_TOPOLOGY_H */
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3a048e9..6c982df 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -39,7 +39,6 @@
 #include <asm/hvcall.h>
 #include <asm/setup.h>
 #include <asm/vdso.h>
-#include <asm/drmem.h>
 
 static int numa_enabled = 1;
 
@@ -87,8 +86,8 @@ static void __init setup_node_to_cpumask_map(void)
 	dbg("Node to cpumask map for %d nodes\n", nr_node_ids);
 }
 
-static int __init fake_numa_create_new_node(unsigned long end_pfn,
-						unsigned int *nid)
+int __init fake_numa_create_new_node(unsigned long end_pfn,
+					unsigned int *nid)
 {
 	unsigned long long mem;
 	char *p = cmdline;
@@ -194,7 +193,7 @@ int __node_distance(int a, int b)
 }
 EXPORT_SYMBOL(__node_distance);
 
-static void initialize_distance_lookup_table(int nid,
+void initialize_distance_lookup_table(int nid,
 		const __be32 *associativity)
 {
 	int i;
@@ -209,6 +208,7 @@ static void initialize_distance_lookup_table(int nid,
 		distance_lookup_table[nid][i] = of_read_number(entry, 1);
 	}
 }
+EXPORT_SYMBOL(initialize_distance_lookup_table);
 
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
@@ -356,98 +356,6 @@ static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
 	of_node_put(memory);
 }
 
-static unsigned long read_n_cells(int n, const __be32 **buf)
-{
-	unsigned long result = 0;
-
-	while (n--) {
-		result = (result << 32) | of_read_number(*buf, 1);
-		(*buf)++;
-	}
-	return result;
-}
-
-struct assoc_arrays {
-	u32	n_arrays;
-	u32	array_sz;
-	const __be32 *arrays;
-};
-
-/*
- * Retrieve and validate the list of associativity arrays for drconf
- * memory from the ibm,associativity-lookup-arrays property of the
- * device tree..
- *
- * The layout of the ibm,associativity-lookup-arrays property is a number N
- * indicating the number of associativity arrays, followed by a number M
- * indicating the size of each associativity array, followed by a list
- * of N associativity arrays.
- */
-static int of_get_assoc_arrays(struct assoc_arrays *aa)
-{
-	struct device_node *memory;
-	const __be32 *prop;
-	u32 len;
-
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (!memory)
-		return -1;
-
-	prop = of_get_property(memory, "ibm,associativity-lookup-arrays", &len);
-	if (!prop || len < 2 * sizeof(unsigned int)) {
-		of_node_put(memory);
-		return -1;
-	}
-
-	aa->n_arrays = of_read_number(prop++, 1);
-	aa->array_sz = of_read_number(prop++, 1);
-
-	of_node_put(memory);
-
-	/* Now that we know the number of arrays and size of each array,
-	 * revalidate the size of the property read in.
-	 */
-	if (len < (aa->n_arrays * aa->array_sz + 2) * sizeof(unsigned int))
-		return -1;
-
-	aa->arrays = prop;
-	return 0;
-}
-
-/*
- * This is like of_node_to_nid_single() for memory represented in the
- * ibm,dynamic-reconfiguration-memory node.
- */
-static int of_drconf_to_nid_single(struct drmem_lmb *lmb)
-{
-	struct assoc_arrays aa = { .arrays = NULL };
-	int default_nid = 0;
-	int nid = default_nid;
-	int rc, index;
-
-	rc = of_get_assoc_arrays(&aa);
-	if (rc)
-		return default_nid;
-
-	if (min_common_depth > 0 && min_common_depth <= aa.array_sz &&
-	    !(lmb->flags & DRCONF_MEM_AI_INVALID) &&
-	    lmb->aa_index < aa.n_arrays) {
-		index = lmb->aa_index * aa.array_sz + min_common_depth - 1;
-		nid = of_read_number(&aa.arrays[index], 1);
-
-		if (nid == 0xffff || nid >= MAX_NUMNODES)
-			nid = default_nid;
-
-		if (nid > 0) {
-			index = lmb->aa_index * aa.array_sz;
-			initialize_distance_lookup_table(nid,
-							&aa.arrays[index]);
-		}
-	}
-
-	return nid;
-}
-
 /*
  * Figure out to which domain a cpu belongs and stick it there.
  * Return the id of the domain used.
@@ -536,7 +444,7 @@ static int ppc_numa_cpu_dead(unsigned int cpu)
  * or zero. If the returned value of size is 0 the region should be
  * discarded as it lies wholly above the memory limit.
  */
-static unsigned long __init numa_enforce_memory_limit(unsigned long start,
+unsigned long __init numa_enforce_memory_limit(unsigned long start,
 						      unsigned long size)
 {
 	/*
@@ -555,67 +463,20 @@ static unsigned long __init numa_enforce_memory_limit(unsigned long start,
 	return memblock_end_of_DRAM() - start;
 }
 
-/*
- * Reads the counter for a given entry in
- * linux,drconf-usable-memory property
- */
-static inline int __init read_usm_ranges(const __be32 **usm)
+static inline unsigned long read_n_cells(int n, const __be32 **buf)
 {
-	/*
-	 * For each lmb in ibm,dynamic-memory a corresponding
-	 * entry in linux,drconf-usable-memory property contains
-	 * a counter followed by that many (base, size) duple.
-	 * read the counter from linux,drconf-usable-memory
-	 */
-	return read_n_cells(n_mem_size_cells, usm);
-}
-
-/*
- * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
- * node.  This assumes n_mem_{addr,size}_cells have been set.
- */
-static void __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
-					const __be32 **usm)
-{
-	unsigned int ranges, is_kexec_kdump = 0;
-	unsigned long base, size, sz;
-	int nid;
-
-	/*
-	 * Skip this block if the reserved bit is set in flags (0x80)
-	 * or if the block is not assigned to this partition (0x8)
-	 */
-	if ((lmb->flags & DRCONF_MEM_RESERVED)
-	    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
-		return;
-
-	if (*usm)
-		is_kexec_kdump = 1;
-
-	base = lmb->base_addr;
-	size = drmem_lmb_size();
-	ranges = 1;
+	unsigned long result = 0;
 
-	if (is_kexec_kdump) {
-		ranges = read_usm_ranges(usm);
-		if (!ranges) /* there are no (base, size) duple */
-			return;
+	while (n--) {
+		result = (result << 32) | of_read_number(*buf, 1);
+		(*buf)++;
 	}
+	return result;
+}
 
-	do {
-		if (is_kexec_kdump) {
-			base = read_n_cells(n_mem_addr_cells, usm);
-			size = read_n_cells(n_mem_size_cells, usm);
-		}
-
-		nid = of_drconf_to_nid_single(lmb);
-		fake_numa_create_new_node(((base + size) >> PAGE_SHIFT),
-					  &nid);
-		node_set_online(nid);
-		sz = numa_enforce_memory_limit(base, size);
-		if (sz)
-			memblock_set_node(base, sz, &memblock.memory, nid);
-	} while (--ranges);
+int __weak platform_parse_numa_properties(int min_common_depth)
+{
+	return min_common_depth;
 }
 
 static int __init parse_numa_properties(void)
@@ -704,16 +565,7 @@ static int __init parse_numa_properties(void)
 			goto new_range;
 	}
 
-	/*
-	 * Now do the same thing for each MEMBLOCK listed in the
-	 * ibm,dynamic-memory property in the
-	 * ibm,dynamic-reconfiguration-memory node.
-	 */
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory) {
-		walk_drmem_lmbs(memory, numa_setup_drmem_lmb);
-		of_node_put(memory);
-	}
+	min_common_depth = platform_parse_numa_properties(min_common_depth);
 
 	return 0;
 }
@@ -922,37 +774,6 @@ static int __init early_topology_updates(char *p)
 
 #ifdef CONFIG_MEMORY_HOTPLUG
 /*
- * Find the node associated with a hot added memory section for
- * memory represented in the device tree by the property
- * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
- */
-static int hot_add_drconf_scn_to_nid(unsigned long scn_addr)
-{
-	struct drmem_lmb *lmb;
-	unsigned long lmb_size;
-	int nid = -1;
-
-	lmb_size = drmem_lmb_size();
-
-	for_each_drmem_lmb(lmb) {
-		/* skip this block if it is reserved or not assigned to
-		 * this partition */
-		if ((lmb->flags & DRCONF_MEM_RESERVED)
-		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
-			continue;
-
-		if ((scn_addr < lmb->base_addr)
-		    || (scn_addr >= (lmb->base_addr + lmb_size)))
-			continue;
-
-		nid = of_drconf_to_nid_single(lmb);
-		break;
-	}
-
-	return nid;
-}
-
-/*
  * Find the node associated with a hot added memory section for memory
  * represented in the device tree as a node (i.e. memory@XXXX) for
  * each memblock.
@@ -995,6 +816,11 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
 	return nid;
 }
 
+int __weak platform_hot_add_scn_to_nid(unsigned long scn_addr)
+{
+	return NUMA_NO_NODE;
+}
+
 /*
  * Find the node associated with a hot added memory section.  Section
  * corresponds to a SPARSEMEM section, not an MEMBLOCK.  It is assumed that
@@ -1002,17 +828,14 @@ static int hot_add_node_scn_to_nid(unsigned long scn_addr)
  */
 int hot_add_scn_to_nid(unsigned long scn_addr)
 {
-	struct device_node *memory = NULL;
 	int nid;
 
 	if (!numa_enabled || (min_common_depth < 0))
 		return first_online_node;
 
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory) {
-		nid = hot_add_drconf_scn_to_nid(scn_addr);
-		of_node_put(memory);
-	} else {
+	nid = platform_hot_add_scn_to_nid(scn_addr);
+	if (nid != NUMA_NO_NODE)
+	{
 		nid = hot_add_node_scn_to_nid(scn_addr);
 	}
 
@@ -1022,9 +845,13 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 	return nid;
 }
 
+u64 __weak platform_hot_add_drconf_memory_max(void)
+{
+	return 0;
+}
+
 static u64 hot_add_drconf_memory_max(void)
 {
-	struct device_node *memory = NULL;
 	struct device_node *dn = NULL;
 	const __be64 *lrdr = NULL;
 
@@ -1036,12 +863,7 @@ static u64 hot_add_drconf_memory_max(void)
 			return be64_to_cpup(lrdr);
 	}
 
-	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
-	if (memory) {
-		of_node_put(memory);
-		return drmem_lmb_memory_max();
-	}
-	return 0;
+	return platform_hot_add_drconf_memory_max();
 }
 
 /*
diff --git a/arch/powerpc/platforms/pseries/drmem.c b/arch/powerpc/platforms/pseries/drmem.c
index ccb0d3b..01ac651 100644
--- a/arch/powerpc/platforms/pseries/drmem.c
+++ b/arch/powerpc/platforms/pseries/drmem.c
@@ -16,8 +16,8 @@
 #include <linux/of_fdt.h>
 #include <linux/memblock.h>
 #include <asm/prom.h>
+#include <asm/iommu.h>
 #include <asm/drmem.h>
-#include <asm/platform.h>
 
 static struct drmem_lmb_info __drmem_info;
 struct drmem_lmb_info *drmem_info = &__drmem_info;
@@ -297,6 +297,76 @@ void __init walk_drmem_lmbs_early(unsigned long node,
 	memblock_dump_all();
 }
 
+/*
+ * Interpret the ibm dynamic reconfiguration memory LMBs.
+ * This contains a list of memory blocks along with NUMA affinity
+ * information.
+ */
+static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
+					const __be32 **usm)
+{
+	u64 base, size;
+	int is_kexec_kdump = 0, rngs;
+
+	base = lmb->base_addr;
+	size = drmem_lmb_size();
+	rngs = 1;
+
+	/*
+	 * Skip this block if the reserved bit is set in flags
+	 * or if the block is not assigned to this partition.
+	 */
+	if ((lmb->flags & DRCONF_MEM_RESERVED) ||
+	    !(lmb->flags & DRCONF_MEM_ASSIGNED))
+		return;
+
+	if (*usm)
+		is_kexec_kdump = 1;
+
+	if (is_kexec_kdump) {
+		/*
+		 * For each memblock in ibm,dynamic-memory, a
+		 * corresponding entry in linux,drconf-usable-memory
+		 * property contains a counter 'p' followed by 'p'
+		 * (base, size) duple. Now read the counter from
+		 * linux,drconf-usable-memory property
+		 */
+		rngs = dt_mem_next_cell(dt_root_size_cells, usm);
+		if (!rngs) /* there are no (base, size) duple */
+			return;
+	}
+
+	do {
+		if (is_kexec_kdump) {
+			base = dt_mem_next_cell(dt_root_addr_cells, usm);
+			size = dt_mem_next_cell(dt_root_size_cells, usm);
+		}
+
+		if (iommu_is_off) {
+			if (base >= 0x80000000ul)
+				continue;
+			if ((base + size) > 0x80000000ul)
+				size = 0x80000000ul - base;
+		}
+
+		pr_debug("Adding: %llx -> %llx\n", base, size);
+		if (validate_mem_limit(base, &size))
+			memblock_add(base, size);
+	} while (--rngs);
+}
+
+int __init platform_early_init_dt_scan_memory_ppc(unsigned long node,
+                                                const char *uname,
+                                                int depth, void *data)
+{
+        if (depth == 1 &&
+            strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
+                walk_drmem_lmbs_early(node, early_init_drmem_lmb);
+                return 0;
+        }
+
+	return -ENODEV;
+}
 #endif
 
 static int __init init_drmem_lmb_size(struct device_node *dn)
@@ -447,74 +517,246 @@ static int __init drmem_init(void)
 }
 late_initcall(drmem_init);
 
+/*
+ * Retrieve and validate the list of associativity arrays for drconf
+ * memory from the ibm,associativity-lookup-arrays property of the
+ * device tree..
+ *
+ * The layout of the ibm,associativity-lookup-arrays property is a number N
+ * indicating the number of associativity arrays, followed by a number M
+ * indicating the size of each associativity array, followed by a list
+ * of N associativity arrays.
+ */
+static int of_get_assoc_arrays(struct assoc_arrays *aa)
+{
+	struct device_node *memory;
+	const __be32 *prop;
+	u32 len;
+
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (!memory)
+		return -1;
+
+	prop = of_get_property(memory, "ibm,associativity-lookup-arrays", &len);
+	if (!prop || len < 2 * sizeof(unsigned int)) {
+		of_node_put(memory);
+		return -1;
+	}
+
+	aa->n_arrays = of_read_number(prop++, 1);
+	aa->array_sz = of_read_number(prop++, 1);
+
+	of_node_put(memory);
+
+	/* Now that we know the number of arrays and size of each array,
+	 * revalidate the size of the property read in.
+	 */
+	if (len < (aa->n_arrays * aa->array_sz + 2) * sizeof(unsigned int))
+		return -1;
+
+	aa->arrays = prop;
+	return 0;
+}
+
+static int current_min_common_depth;
+static int n_mem_addr_cells, n_mem_size_cells;
 
 /*
- * Interpret the ibm dynamic reconfiguration memory LMBs.
- * This contains a list of memory blocks along with NUMA affinity
- * information.
+ * This is like numa.c:of_node_to_nid_single() for memory represented
+ * in the ibm,dynamic-reconfiguration-memory node.
  */
-static void __init early_init_drmem_lmb(struct drmem_lmb *lmb,
-					const __be32 **usm)
+static int of_drconf_to_nid_single(struct drmem_lmb *lmb)
 {
-	u64 base, size;
-	int is_kexec_kdump = 0, rngs;
+	struct assoc_arrays aa = { .arrays = NULL };
+	int default_nid = 0;
+	int nid = default_nid;
+	int rc, index;
+
+	rc = of_get_assoc_arrays(&aa);
+	if (rc)
+		return default_nid;
+
+	if (current_min_common_depth > 0 && current_min_common_depth <= aa.array_sz &&
+	    !(lmb->flags & DRCONF_MEM_AI_INVALID) &&
+	    lmb->aa_index < aa.n_arrays) {
+		index = lmb->aa_index * aa.array_sz + current_min_common_depth - 1;
+		nid = of_read_number(&aa.arrays[index], 1);
+
+		if (nid == 0xffff || nid >= MAX_NUMNODES)
+			nid = default_nid;
+
+		if (nid > 0) {
+			index = lmb->aa_index * aa.array_sz;
+			initialize_distance_lookup_table(nid,
+							&aa.arrays[index]);
+		}
+	}
 
-	base = lmb->base_addr;
-	size = drmem_lmb_size();
-	rngs = 1;
+	return nid;
+}
 
+static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
+{
+	struct device_node *memory = NULL;
+
+	memory = of_find_node_by_type(memory, "memory");
+	if (!memory)
+		panic("numa.c: No memory nodes found!");
+
+	*n_addr_cells = of_n_addr_cells(memory);
+	*n_size_cells = of_n_size_cells(memory);
+	of_node_put(memory);
+}
+
+static inline unsigned long read_n_cells(int n, const __be32 **buf)
+{
+        unsigned long result = 0;
+
+        while (n--) {
+                result = (result << 32) | of_read_number(*buf, 1);
+                (*buf)++;
+        }
+        return result;
+}
+
+/*
+ * Reads the counter for a given entry in
+ * linux,drconf-usable-memory property
+ */
+static inline int __init read_usm_ranges(const __be32 **usm)
+{
 	/*
-	 * Skip this block if the reserved bit is set in flags
-	 * or if the block is not assigned to this partition.
+	 * For each lmb in ibm,dynamic-memory a corresponding
+	 * entry in linux,drconf-usable-memory property contains
+	 * a counter followed by that many (base, size) duple.
+	 * read the counter from linux,drconf-usable-memory
 	 */
-	if ((lmb->flags & DRCONF_MEM_RESERVED) ||
-	    !(lmb->flags & DRCONF_MEM_ASSIGNED))
+	return read_n_cells(n_mem_size_cells, usm);
+}
+
+/*
+ * Extract NUMA information from the ibm,dynamic-reconfiguration-memory
+ * node.  This assumes n_mem_{addr,size}_cells have been set.
+ */
+static void __init numa_setup_drmem_lmb(struct drmem_lmb *lmb,
+					const __be32 **usm)
+{
+	unsigned int ranges, is_kexec_kdump = 0;
+	unsigned long base, size, sz;
+	int nid;
+
+	/*
+	 * Skip this block if the reserved bit is set in flags (0x80)
+	 * or if the block is not assigned to this partition (0x8)
+	 */
+	if ((lmb->flags & DRCONF_MEM_RESERVED)
+	    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
 		return;
 
 	if (*usm)
 		is_kexec_kdump = 1;
 
+	base = lmb->base_addr;
+	size = drmem_lmb_size();
+	ranges = 1;
+
 	if (is_kexec_kdump) {
-		/*
-		 * For each memblock in ibm,dynamic-memory, a
-		 * corresponding entry in linux,drconf-usable-memory
-		 * property contains a counter 'p' followed by 'p'
-		 * (base, size) duple. Now read the counter from
-		 * linux,drconf-usable-memory property
-		 */
-		rngs = dt_mem_next_cell(dt_root_size_cells, usm);
-		if (!rngs) /* there are no (base, size) duple */
+		ranges = read_usm_ranges(usm);
+		if (!ranges) /* there are no (base, size) duple */
 			return;
 	}
 
+        get_n_mem_cells(&n_mem_addr_cells, &n_mem_size_cells);
+
 	do {
 		if (is_kexec_kdump) {
-			base = dt_mem_next_cell(dt_root_addr_cells, usm);
-			size = dt_mem_next_cell(dt_root_size_cells, usm);
+			base = read_n_cells(n_mem_addr_cells, usm);
+			size = read_n_cells(n_mem_size_cells, usm);
 		}
 
-		if (iommu_is_off) {
-			if (base >= 0x80000000ul)
-				continue;
-			if ((base + size) > 0x80000000ul)
-				size = 0x80000000ul - base;
-		}
+		nid = of_drconf_to_nid_single(lmb);
+		fake_numa_create_new_node(((base + size) >> PAGE_SHIFT),
+					  &nid);
+		node_set_online(nid);
+		sz = numa_enforce_memory_limit(base, size);
+		if (sz)
+			memblock_set_node(base, sz, &memblock.memory, nid);
+	} while (--ranges);
+}
 
-		DBG("Adding: %llx -> %llx\n", base, size);
-		if (validate_mem_limit(base, &size))
-			memblock_add(base, size);
-	} while (--rngs);
+int __init platform_parse_numa_properties(int min_common_depth)
+{
+	struct device_node *memory;
+
+	/*
+	 * Now do the same thing for each MEMBLOCK listed in the
+	 * ibm,dynamic-memory property in the
+	 * ibm,dynamic-reconfiguration-memory node.
+	 */
+	current_min_common_depth = min_common_depth;
+	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+	if (memory) {
+		walk_drmem_lmbs(memory, numa_setup_drmem_lmb);
+		of_node_put(memory);
+	}
+	return current_min_common_depth;
 }
 
-int __init platform_early_init_dt_scan_memory_ppc(unsigned long node,
-						const char *uname,
-						int depth, void *data)
+u64 platform_hot_add_drconf_memory_max(void)
 {
-	if (depth == 1 &&
-	    strcmp(uname, "ibm,dynamic-reconfiguration-memory") == 0) {
-		walk_drmem_lmbs_early(node, early_init_drmem_lmb);
-		return 0;
+        struct device_node *memory = NULL;
+
+        memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+        if (memory) {
+                of_node_put(memory);
+                return drmem_lmb_memory_max();
+        }
+        return 0;
+}
+
+
+/*
+ * Find the node associated with a hot added memory section for
+ * memory represented in the device tree by the property
+ * ibm,dynamic-reconfiguration-memory/ibm,dynamic-memory.
+ */
+static int hot_add_drconf_scn_to_nid(unsigned long scn_addr)
+{
+	struct drmem_lmb *lmb;
+	unsigned long lmb_size;
+	int nid = -1;
+
+	lmb_size = drmem_lmb_size();
+
+	for_each_drmem_lmb(lmb) {
+		/* skip this block if it is reserved or not assigned to
+		 * this partition */
+		if ((lmb->flags & DRCONF_MEM_RESERVED)
+		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
+			continue;
+
+		if ((scn_addr < lmb->base_addr)
+		    || (scn_addr >= (lmb->base_addr + lmb_size)))
+			continue;
+
+		nid = of_drconf_to_nid_single(lmb);
+		break;
 	}
 
-	return -ENODEV;
+	return nid;
+}
+
+int platform_hot_add_scn_to_nid(unsigned long scn_addr)
+{
+        struct device_node *memory = NULL;
+	int nid;
+
+        memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
+        if (memory) {
+                nid = hot_add_drconf_scn_to_nid(scn_addr);
+                of_node_put(memory);
+		return nid;
+        } else {
+		return NUMA_NO_NODE;
+	}
 }

