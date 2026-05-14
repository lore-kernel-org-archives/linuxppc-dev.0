Return-Path: <linuxppc-dev+bounces-20960-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 610ECCD37AC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 14 May 2026 18:54:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gGfdr52k1z2xtC;
	Fri, 15 May 2026 04:54:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778784896;
	cv=none; b=YYswgs3sj6qndKFggSYw3qB4w19tXMgaBIK1JttnfeTUlbZSS2EAqriKtu28+FuAimS0lyEl2RD9sPk7YLjgYd6mRf7jgfUZnFdA5vJVmJJcw8JG3G1x6O+xepZbeg+sipagpQSwlT1I0ha3OtGXrrOQRDkuopUfgfhha6/z+2/wJkMOoB9XmWq39DZzPzF7K8NEuOAu599srTurZI6AQKL2hf2nRtAeZh0v+H1QMlGrqzxaIGuHTyRkhxZ/KIEeh58q9GJpmBrZFIYYAoKuu4gOs9KBLZC87oXYrK6CKSRDove6qfBr0AZesCTaDg/QTShPZFt8ZZ1Y/upA+dw6TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778784896; c=relaxed/relaxed;
	bh=Wp0AntsT5Fz76ydI3IQIe+RP34uUT6zWjvJSv/Ph61k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VTlv2zlEWnY+a/gEbXolI6GxnnjhhGPBXHV/fSxFXpyXFMzkjvyNEHGL8tfdFbYjE4AhtG1N/yXuvkzPkzT1XPnSoNLXP3KqXDnFcnvMZHez/u9YJ1A2DGzE5ZFkBfycuclQq4cDNRx8vkoRAS/jvEUq4oE07j4E7XVHR2j5/K/vg2DHI5UgMTfq4zQPW44xBoMeDaGnKxEEWh4vdGcGdbGWxoLH+k+sxgNUuZhz5ZRrn5rKVM6THsBRLsNVIPAg1OkXplKY5GHfL4VvgSaO3Dqe5mUmgypd0PZivUNkjAn+BgGSixOUc+4BXwoBS1gUQbod55/jQtbO8Ube+FWdRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a6KDkQtP; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=a6KDkQtP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gGfdp6T44z2xnQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 04:54:53 +1000 (AEST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E75FXr3187682
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2026 18:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Wp0AntsT5Fz76ydI3IQIe+RP34uUT6zWjvJSv/Ph6
	1k=; b=a6KDkQtP0HwQ6G15KF6qrjodGSDB0aC1QzUKmz9a/CqccrWveEpOPf0zQ
	ifEdX611EgJ4NY0OwUz5/9aCxk+5hPo1tug/BSvtB6+2AUelcnuPCXaMdkuiDaGy
	J6sLJTOvnfT/zy7qof/Y1jI7UL/VEqOGAj/fPA7yeEE6WKb7cBiH9o3vvSWlyeMt
	3DLfliqu4tImVHA9dgHJUYkmn6b2Mnk1Up4EwnNCOWn1oH9Gygfn00A6lBL8mVus
	Q74+g5BUuWo445dRQQqXKqc6/pAFuDvz+YeJr26gYFobCo7akfe68IGPYvMO5+PV
	jKepZbluEIxt1LUjD3aiga3Q7UhRw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5p398-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:54:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EIsVAf027282;
	Thu, 14 May 2026 18:54:50 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvc81s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:54:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EIsmRm28967672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:54:49 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A8958067;
	Thu, 14 May 2026 18:54:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA1458065;
	Thu, 14 May 2026 18:54:48 +0000 (GMT)
Received: from dhcp-9-16-48-107.atx-us.ibm.com (unknown [9.16.48.107])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:54:48 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com, sbhat@linux.ibm.com,
        vaibhav@linux.ibm.com, donettom@linux.ibm.com, harshpb@linux.ibm.com,
        Gaurav Batra <gbatra@linux.ibm.com>
Subject: [PATCH v2] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Thu, 14 May 2026 13:54:48 -0500
Message-ID: <20260514185448.34434-1-gbatra@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a061a7b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HZEbkqMDGSxefZWvAyoA:9
X-Proofpoint-ORIG-GUID: i428Poh-pj8NHw6Oj9CDQ_x_irshjs49
X-Proofpoint-GUID: XoBT6-LBaxjTdEFcKxwoQ_X_Kz8dRGDB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE4NiBTYWx0ZWRfX3y8HfaBvs7QM
 aVGdmghXRxRb8L2Pwbb4VFtCHi30aq7AumiVKJQSqrMB8fvz3P9hq9ylrO2/S3lCu62b5555Y79
 L2kz3gUvK6ncLkoA6bGhAktqGuEvfUTVO4IWDHCJGbr7eYA9zS0AvzYe/jhvaAcn+FvLWTNgwmz
 YxXybk88/ja00UlmstM+qiBsHdrc1E0H/Qs3YEfhiS6AAqMC7THUYI2rDfaPdlg7Iq4PX2wetPs
 mg218dnJF3RDOODVN89cGMCX49L7YjnFUv2Q+Eh6B8WMG0arHk6iUAi2h+Spu5dwfzFDFCnwY8G
 mLbscI/XDcYTfR2bVojQvSIeIxEaEDjyLbgPScBM8k5MQT8pytTB3/UozZkUWUme//AlepLDYhh
 n/v1Hy75DReK6jLKsqwquQWRVAbNCUGjZ63OUe9ZSyHVhWAHJIJmJlM9aqUVD4bzkp7z7QMdr52
 SEP9cOLMMiioWiRE/JA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140186

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

Change log:

V1 -> V2

1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
   range, which may require clamping arg->nr_pages if crossing the limits.

   Response: Incorporated changes.

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>

 arch/powerpc/platforms/pseries/iommu.c | 56 ++++++++++++++++++--------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..fdb160b72938 100644
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
+
+		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
+		}
 
-	return max_addr;
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
@@ -2419,21 +2425,32 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 {
 	struct dma_win *window;
 	struct memory_notify *arg = data;
+	unsigned long limit = arg->nr_pages;
+	unsigned long max_ram_pages = pseries_ddw_max_ram >> PAGE_SHIFT;
 	int ret = 0;
 
 	/* This notifier can get called when onlining persistent memory as well.
 	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
-	 * always be above ddw_memory_hotplug_max()
+	 * always be above pseries_ddw_max_ram
 	 */
+	if (arg->start_pfn >= max_ram_pages)
+		return NOTIFY_OK;
+
+	/* RAM is being DLPAR'ed. The range should never exceed max ram.
+	 * Just in case, clamp the range and throw a warning.
+	 */
+	if (arg->start_pfn + limit > max_ram_pages) {
+		limit = max_ram_pages - arg->start_pfn;
+		WARN_ON(1);
+	}
 
 	switch (action) {
 	case MEM_GOING_ONLINE:
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
-			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
-				ddw_memory_hotplug_max()) {
+			if (window->direct) {
 				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
-						arg->nr_pages, window->prop);
+						limit, window->prop);
 			}
 			/* XXX log error */
 		}
@@ -2443,10 +2460,9 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 	case MEM_OFFLINE:
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
-			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
-				ddw_memory_hotplug_max()) {
+			if (window->direct) {
 				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
-						arg->nr_pages, window->prop);
+						limit, window->prop);
 			}
 			/* XXX log error */
 		}
@@ -2532,6 +2548,14 @@ void __init iommu_init_early_pSeries(void)
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


