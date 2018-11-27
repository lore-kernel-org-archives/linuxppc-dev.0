Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C523C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:41:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B36EC2086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B36EC2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434G0b5bg9zDqkd
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 07:41:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=mwb@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434FvV395xzDqG6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 07:37:10 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wARKY7pS069969
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 15:37:08 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p187xmucj-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 15:37:07 -0500
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 27 Nov 2018 20:37:06 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 27 Nov 2018 20:37:04 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wARKb3CR17825848
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Nov 2018 20:37:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB79EB2064;
 Tue, 27 Nov 2018 20:37:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 25E0DB2068;
 Tue, 27 Nov 2018 20:37:03 +0000 (GMT)
Received: from oc5000245537.ibm.com (unknown [9.53.179.223])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Tue, 27 Nov 2018 20:37:03 +0000 (GMT)
In-Reply-To: <20181127203129.12853.49746.stgit@ltczep4-lp5.aus.stglabs.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/pseries: Move DRMEM processing out of numa.c
Openpgp: preference=signencrypt
Autocrypt: addr=mwb@linux.vnet.ibm.com; prefer-encrypt=mutual; keydata=
 xsBNBFcY7GcBCADzw3en+yzo9ASFGCfldVkIg95SAMPK0myXp2XJYET3zT45uBsX/uj9/2nA
 lBmXXeOSXnPfJ9V3vtiwcfATnWIsVt3tL6n1kqikzH9nXNxZT7MU/7gqzWZngMAWh/GJ9qyg
 DTOZdjsvdUNUWxtiLvBo7y+reA4HjlQhwhYxxvCpXBeRoF0qDWfQ8DkneemqINzDZPwSQ7zY
 t4F5iyN1I9GC5RNK8Y6jiKmm6bDkrrbtXPOtzXKs0J0FqWEIab/u3BDrRP3STDVPdXqViHua
 AjEzthQbGZm0VCxI4a7XjMi99g614/qDcXZCs00GLZ/VYIE8hB9C5Q+l66S60PLjRrxnABEB
 AAHNLU1pY2hhZWwgVy4gQnJpbmdtYW5uIDxtd2JAbGludXgudm5ldC5pYm0uY29tPsLAeAQT
 AQIAIgUCVxjsZwIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQSEdag3dpuTI0NAf8
 CKYTDKQLgOSjVrU2L5rM4lXaJRmQV6oidD3vIhKSnWRvPq9C29ifRG6ri20prTHAlc0vycgm
 41HHg0y2vsGgNXGTWC2ObemoZBI7mySXe/7Tq5mD/semGzOp0YWZ7teqrkiSR8Bw0p+LdE7K
 QmT7tpjjvuhrtQ3RRojUYcuy1nWUsc4D+2cxsnZslsx84FUKxPbLagDgZmgBhUw/sUi40s6S
 AkdViVCVS0WANddLIpG0cfdsV0kCae/XdjK3mRK6drFKv1z+QFjvOhc8QIkkxFD0da9w3tJj
 oqnqHFV5gLcHO6/wizPx/NV90y6RngeBORkQiRFWxTXS4Oj9GVI/Us7ATQRXGOxnAQgAmJ5Y
 ikTWrMWPfiveUacETyEhWVl7u8UhZcx3yy2te8O0ay7t9fYcZgIEfQPPVVus89acIXlG3wYL
 DDPvb21OprLxi+ZJ2a0S5we+LcSWN1jByxJlbWBq+/LcMtGAOhNLpysY1gD0Y4UW/eKS+TFZ
 562qKC3k1dBvnV9JXCgeS1taYFxRdVAn+2DwK3nuyG/DDq/XgJ5BtmyC3MMx8CiW3POj+O+l
 6SedIeAfZlZ7/xhijx82g93h07VavUQRwMZgZFsqmuxBxVGiav2HB+dNvs3PFB087Pvc9OHe
 qhajPWOP/gNLMmvBvknn1NToM9a8/E8rzcIZXoYs4RggRRYh6wARAQABwsBfBBgBAgAJBQJX
 GOxnAhsMAAoJEEhHWoN3abky+RUH/jE08/r5QzaNKYeVhu0uVbgXu5fsxqr2cAxhf+KuwT3T
 efhEP2alarxzUZdEh4MsG6c+X2NYLbD3cryiXxVx/7kSAJEFQJfA5P06g8NLR25Qpq9BLsN7
 ++dxQ+CLKzSEb1X24hYAJZpOhS8ev3ii+M/XIo+olDBKuTaTgB6elrg3CaxUsVgLBJ+jbRkW
 yQe2S5f/Ja1ThDpSSLLWLiLK/z7+gaqwhnwjQ8Z8Y9D2itJQcj4itHilwImsqwLG7SxzC0NX
 IQ5KaAFYdRcOgwR8VhhkOIVd70ObSZU+E4pTET1WDz4o65xZ89yfose1No0+r5ht/xWOOrh8
 53/hcWvxHVs=
Organization: IBM Linux Technology Center
Date: Tue, 27 Nov 2018 14:37:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18112720-0068-0000-0000-00000367E5A1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010132; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123648; UDB=6.00583330; IPR=6.00903778; 
 MB=3.00024358; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 20:37:05
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112720-0069-0000-0000-000046919EDF
Message-Id: <3a12822f-d205-4921-7fdb-b5c3b07cd8b2@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-27_17:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270173
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
Cc: Michael Bringmann <mwb@linux.vnet.ibm.com>, Juliet Kim <minkim@us.ibm.com>,
 Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
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

