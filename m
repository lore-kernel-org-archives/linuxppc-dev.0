Return-Path: <linuxppc-dev+bounces-20432-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07026FF885A
	for <linuxppc-dev@archiver.kernel.org>; Mon,  4 May 2026 20:55:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g8Yn82nvmz2xnK;
	Tue, 05 May 2026 06:55:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777928108;
	cv=none; b=LZyv3qHXXQ3onn6jCdiQB6sN2NMJnmdf+fUh9J8iihE5rJ/ctbMYmC2f59+WXhmJsEDAqRRleBG6oPtzLddubLE/N6maPYR1JmVtI6Zvt+/2x8wQ+YNA9l73NTB65y5sXz0yFQKTJ9NOX9uJ4hYmU9kjh3fAP9zTuq8rcXGYNYRIkPQYl/0tprS5zHqY45Wi8Vv1FGbhirzSPOg7Hogl4pGrjoFApxi4h1pUwzj/SKU4E9EYuXsIaMbF98sWbSDS7eoaCjiOLvf+lPCHxF8hwXJAb+H/uRYCiNXiF5AwyBw2c33oyVcVmK/TD1OmNi1oF/xLro/cqSvdzYFVdOK5LA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777928108; c=relaxed/relaxed;
	bh=JQAX1SYX4+M4+YTWoxZnmgTspISkbW0jMURzLUeqlC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aderlvC+5qFxeQoVfdlJLxrswb3vfOu0rID6SYEYpYDuePnAOYybr7zWylR8TrQwJYkWdaHwmUNearESM5LpPRqJvKEV7Yc9nmoZDkDjoEs+rRvvx2nLHNOSy4NtfX0MWk4dbcFJ0mRIyCmr0LBgwd1Zipi1kuv90DABT/+m8NLshopJmrombQk3d1CjEnkC/xnVPQhF+VNN2YGfrrhutJNvIcJQJTpB27C2d+IFNujbKesKdgfDD9OXA8nhM6JPSaR4SM8W7e/BTNFaEJWgqlWnqB2ETo8O7FZdCC6BJhwH8xsXFGGHjY/QOXY6enCdiyq714OPtSEgTjlNvFbarw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DWDcx900; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=DWDcx900;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g8Yn719qWz2xJT
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2026 06:55:06 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644EI8NQ2210426
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2026 20:55:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JQAX1SYX4+M4+YTWoxZnmgTspISkbW0jMURzLUeql
	C8=; b=DWDcx900EqkCYG2VGxDqMh5QnMOOWOFtN72M9KR0yvaA/IEPzErh+Wvba
	MRQp3giclx3VfTDAyLmvDcPCAHRmAG/XVgNMRADnNUPHxoJhMJVQTFfmbFNet8Gr
	EL886gyWnpkGvCRds4oiibccbzRSEk/Wmf7N0k1bmO0B1h3mld12gw7vEFyx8gbr
	C4Rl33Gw5P7PUiPH/VJh2lK/7WlhAnf1gj7yiA2XXi2YwUdu2X0gOZmDMpYQ8MNV
	NlCd3KGFu2fxmgHgPn0eWzFAJqwC62V5R3cuRXIub8c8Z3wXoYM7PXpmKMUCqhAJ
	Lqhl7tT4K33dX72tcjMhH117xIggg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y18uu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 20:55:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 644KsWLe030382;
	Mon, 4 May 2026 20:55:02 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyvxvwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 May 2026 20:55:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 644Kt05B23134886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 May 2026 20:55:00 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A16058051;
	Mon,  4 May 2026 20:55:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BC9F5805C;
	Mon,  4 May 2026 20:55:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.243.247])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 May 2026 20:55:00 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com,
        donettom@linux.ibm.com, vaibhav@linux.ibm.com, sbhat@linux.ibm.com,
        Gaurav Batra <gbatra@linux.ibm.com>
Subject: [PATCH] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Mon,  4 May 2026 15:54:59 -0500
Message-ID: <20260504205459.39185-1-gbatra@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: aAaWyRqmOzhWK-yCzRnPdXydGZU_JvxO
X-Proofpoint-GUID: KRU0xuTUS3CSc0LvV9J7bDeiMsx3otsC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE5MSBTYWx0ZWRfXzOXSuP+hQo8H
 TTGsvUiElI52dM6cl111P3qsZ7xGvGuv8b0o2BT6BFO2ivSAMKpujwXy8BsGnzI2jmBJeHk2oMR
 h+mPcFENAOsOIwUlggsicTE4EhM1noOUg/umj+AIrSq9M7pvFSzDuFqeMP7eqj7RO4oEb4D9dNM
 eC0uZ4ZgFl6yJLbNz2WIEZzbW0l71pAy/5Igr6XZk7gN17EGmur9ZHpzVzz45Wyu+XcyI3rjWIT
 upCzhS/Wr911PsZ1KkqPZE4jpggfu7UO8EUioYZh4YJTkjbgtr5Q902aJaZ9LKUkUUkspnNxUqT
 GrSqmTZeP2sJsiI5+agg1i7MHgFAMvEO+Flsivd/lJMXmOxTSgIihHWKwJMVNl05T7Oq9PDP/Zz
 nErnqp89QboVrU6gRzmCJwLxhnGU0Wkav1xLZAIvR3oHVUo6ABo/8YYfVc1Ye3+VsZvoczKcAYG
 NRyn9h3D99qaZO8fx/w==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69f907a7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=HZEbkqMDGSxefZWvAyoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040191

In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
This OF property dictates what is the max size of RAM an LPAR can have,
including DR added memory.

In PowerPC, 16GB pages can be allocated at machine level and then
assigned to LPARs. These 16GB pages are added to LPAR memory at the time
of boot. The address range for these 16GB pages is above MAX RAM an LPAR
can have (ibm,lrdr-capacity). In the current implementation, these 16GB
pages are being excluded from pre-mapped TCEs. A driver can have DMA
buffers allocated from 16GB pages. This results in platform to raise an
EEH when DMA is attempted on buffers in 16GB memory range.

commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
adds TCEs for pmemory")

Prior to the above patch, memblock_end_of_DRAM() was being used to
determine the MAX memory of an LPAR. This included 16GB pages as well.
The issue with using memblock_end_of_DRAM() is that when pmemory is
converted to RAM via daxctl command, the DDW engine will incorrectly try
to add TCEs for pmemory as well.

Below is the address distribution of RAM, 16GB pages and pmemory for an
LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
assigned pmemory of 8GB.

RANGE                                 SIZE  STATE REMOVABLE     BLOCK
0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151

cat /sys/bus/nd/devices/region0/resource
0x40100000000
cat /sys/bus/nd/devices/region0/size
8589934592

The approach to fix this problem is to revert back the code changes
introduced by the above patch and to stash away the MAX memory of an
LPAR, including 16GB pages, at the LPAR boot time. This value is then
used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
iommu_mem_notifier()

Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 38 ++++++++++++++++++--------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..e74954b7add6 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -69,6 +69,8 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
 	return tbl;
 }
 
+static phys_addr_t pseries_ddw_max_ram;
+
 #ifdef CONFIG_IOMMU_API
 static struct iommu_table_group_ops spapr_tce_table_group_ops;
 #endif
@@ -1285,15 +1287,19 @@ static LIST_HEAD(failed_ddw_pdn_list);
 
 static phys_addr_t ddw_memory_hotplug_max(void)
 {
-	resource_size_t max_addr;
+	resource_size_t max_addr = memory_hotplug_max();
+	struct device_node *memory;
 
-#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
-	max_addr = hot_add_drconf_memory_max();
-#else
-	max_addr = memblock_end_of_DRAM();
-#endif
+	for_each_node_by_type(memory, "memory") {
+		struct resource res;
+
+		if (of_address_to_resource(memory, 0, &res))
+			continue;
 
-	return max_addr;
+		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
+		}
+
+		return max_addr;
 }
 
 /*
@@ -1446,7 +1452,7 @@ static struct property *ddw_property_create(const char *propname, u32 liobn, u64
 static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mask)
 {
 	int len = 0, ret;
-	int max_ram_len = order_base_2(ddw_memory_hotplug_max());
+	int max_ram_len = order_base_2(pseries_ddw_max_ram);
 	struct ddw_query_response query;
 	struct ddw_create_response create;
 	int page_shift;
@@ -1668,7 +1674,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn, u64 dma_mas
 
 	if (direct_mapping) {
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
+		ret = walk_system_ram_range(0, pseries_ddw_max_ram >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
@@ -2423,7 +2429,7 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 
 	/* This notifier can get called when onlining persistent memory as well.
 	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
-	 * always be above ddw_memory_hotplug_max()
+	 * always be above pseries_ddw_max_ram
 	 */
 
 	switch (action) {
@@ -2431,7 +2437,7 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
 			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
-				ddw_memory_hotplug_max()) {
+				pseries_ddw_max_ram) {
 				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
 						arg->nr_pages, window->prop);
 			}
@@ -2444,7 +2450,7 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
 			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
-				ddw_memory_hotplug_max()) {
+				pseries_ddw_max_ram) {
 				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
 						arg->nr_pages, window->prop);
 			}
@@ -2532,6 +2538,14 @@ void __init iommu_init_early_pSeries(void)
 	register_memory_notifier(&iommu_mem_nb);
 
 	set_pci_dma_ops(&dma_iommu_ops);
+
+	/* During init determine the max memory an LPAR can have and set it. This
+	 * will be used for pre-mapping RAM in DDW. memblock_end_of_DRAM() can
+	 * change during the running of LPAR - daxctl can add pmemory as
+	 * "system-ram". This memory range should not be pre-mapped in DDW since
+	 * the address of pmemory can be much higher than the DDW size.
+	 */
+	pseries_ddw_max_ram = ddw_memory_hotplug_max();
 }
 
 static int __init disable_multitce(char *str)

base-commit: 6d35786de28116ecf78797a62b84e6bf3c45aa5a
-- 
2.39.3


