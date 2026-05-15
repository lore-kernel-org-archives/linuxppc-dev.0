Return-Path: <linuxppc-dev+bounces-20985-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74795CD4F25
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 May 2026 15:51:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gHBX64FRfz2xTl;
	Sat, 16 May 2026 01:51:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778860310;
	cv=none; b=CRsiGV5Pa3AGSMqcsMH0/uok+dpPu2m9vHUKSSUBp7JA9ODhr79fjDonB5Qwsb8iWyygXYAn8keS7Cze5AxeQ9PKrIXbbn/XM4NPVeKQj0zJpf3fKOZRTE87E7kvRWXhODo9sShc49mRQObbFqhHlFUit05VNhnNMyhCwI854CQCWszldjBmG1LScu7zEPOid1LvSDJaQK5O5V1UwXp4RPpBRX2Zp57/3oDrpa26bEoC6quihPuGS5HZstpJZqoguT0u4fBXm4lVFUpgZUb0FUBB3KERlrsUvn7x+BRy16GYUyt2Q5yqDht+nYbI1PMjKTz/6uT1zCUFxm+5EKlm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778860310; c=relaxed/relaxed;
	bh=duReQAfsNR9OgUiFC1IjxrxHBNB8vEoP6dAxA6ZbOhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIDerqoedRhgTvVwQ5u0omp4i4BlfSxUur+QFurtKyQO6VJYdcFxD7k07qOWvRGrvlbf9SwSyzP9dgOaYnYGAGtiqPssHNV85yg/GsBcJuxkleFVRWXgH2FLcoxyQaicIZbwE0PZ8R+acVDez1P+hw1mIqtjWKASiEBirbmHqtP9nVnqPB1XDPMHPyrD+7oJF6tUbECOYJRhPIDvOZ79Co0s7m7BvPzTItUPzH86DloT1xUMXpbgZFwD8/SIOVOMD7UE1JQn4umStkf3hV7pmzrEiYPxvCwd+7qy0prlsWc6Pc/2xaSaNp3ciI2xxUGa/RS8XlLkUqmRdMw5PHu1LQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gGBr7b5r; dkim-atps=neutral; spf=pass (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gGBr7b5r;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gHBX56Dv5z2xHF
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2026 01:51:48 +1000 (AEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64FBPR8k3950769
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2026 15:51:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=duReQAfsNR9OgUiFC1IjxrxHBNB8vEoP6dAxA6ZbO
	hU=; b=gGBr7b5rzMcigfPP6D3XJl5x39mnFBRi6YmLVjdd5ctIXhQBOZSFpNWzM
	Kj3xjw8ilIzyKWZxdIQ9GcTuddrDCLjnO0PfFW51P4x9M8ZLkXZ+blLr6lr78AmX
	tzyxb/8LMEIhN5ypEGHNZLS0eMgOeEzhcfJ2XA24PWf+X10Hx0wKKcqaOB8eTgzf
	Tn2DHeMXNIagRzbWVlidlHgrzTCXR3kbre1hoGQS6jczpeSCMuhwWSqCfn3NfNun
	e9X56c4cCSKO4oVTgI5ZIOmskAGJ+8M9z5NLhDjMs4NpQQfhqMzbEEKCrnJR9qnd
	a3bO11dEiQ37u7NaJSNOI2YTfGdzQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e5m8yc00a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 15:51:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64FFd5g7022839;
	Fri, 15 May 2026 15:51:45 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcv6se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 May 2026 15:51:45 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64FFpiLC30409232
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 May 2026 15:51:44 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1026B5805A;
	Fri, 15 May 2026 15:51:44 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDEB958056;
	Fri, 15 May 2026 15:51:43 +0000 (GMT)
Received: from dhcp-9-16-48-107.atx-us.ibm.com (unknown [9.16.48.107])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 May 2026 15:51:43 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, ritesh.list@gmail.com, sbhat@linux.ibm.com,
        vaibhav@linux.ibm.com, donettom@linux.ibm.com, harshpb@linux.ibm.com,
        Gaurav Batra <gbatra@linux.ibm.com>
Subject: [PATCH v3] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Fri, 15 May 2026 10:51:43 -0500
Message-ID: <20260515155143.39050-1-gbatra@linux.ibm.com>
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
X-Proofpoint-GUID: ix7t_1sN364Cwa1lyk8LeCtMTQ_5MhOb
X-Authority-Analysis: v=2.4 cv=Os5/DS/t c=1 sm=1 tr=0 ts=6a074112 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8VRwuDZYO3urSD4AI04A:9
X-Proofpoint-ORIG-GUID: bdpO8m6pYw04TUmzzUQqd7N05vsOh_P8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE1OSBTYWx0ZWRfX4EJ1myWOutKl
 VmvQGefqTSpc2c2r/86PiXBN998fl1x0zvDaE9JwoBOJAwAkWYMbnvKof05FGrje0i5gCD+Jg7D
 NHFTN2nvh+C+mRYR/KB8Q5/dDMo6nxa//kfahIKZQrHoljBxmFweVs1MsX2Bzm1//6VS2GBmyEf
 01tyWWrwtUfUBO4kY/unWeIaJVuMrLiaw8CuxeqNZy/1CluBJamAuKGd+BYIxG/2r7ZCjB0Pws2
 7fE98jX5Sd2VFwILlzDMj6wwL91GkE3dzVKYoVa0KMB2KrTPYXiuuyvU9dCJETgcM2sPD4yRtUO
 mtVbymdrXRJcfwmSOqLxXirax3MyiIJgKPissJX4VGA2+y7U61njFWbv2U0QRcEwZWP3Oy+HeUl
 VhnXhE2XfPZXXN46Qf/KFt4lbZGu7ojBrVjT+ZmKitAUE+RAYgwKE8qknrIzoi8AV9bPRWO5+Mc
 +IvgiUT/YwLQsVF+quA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150159

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

V2 -> V3

1. Harsh: Remove R-b tags from the change log

   Response: Incorporated changes

2. Harsh: Change WARN_ON() to WARN_ONCE()

   Response: Incorporated changes

3. Harsh: Fix indendation

   Response: Incorporated changes

4. Harsh: Replace comment with a log if limit < arg->nr_pages ? 

   Response: Doesn't seems to be needed since the WARN_ONCE() will log this
   scenario. I removed the comment instead.

V1 -> V2

1. Harsh: Not only start_pfn, but end_pfn also needs to be within allowed
   range, which may require clamping arg->nr_pages if crossing the limits.

   Response: Incorporated changes.

 arch/powerpc/platforms/pseries/iommu.c | 58 ++++++++++++++++++--------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..7bbe070006fa 100644
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
@@ -1285,13 +1287,17 @@ static LIST_HEAD(failed_ddw_pdn_list);
 
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
+	}
 
 	return max_addr;
 }
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
@@ -2419,23 +2425,35 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
+		WARN_ONCE(1, "Limiting Page Range %lx - %lx to Max Mem Pages: %lx\n",
+					arg->start_pfn, arg->start_pfn + arg->nr_pages,
+					max_ram_pages);
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
-			/* XXX log error */
 		}
 		spin_unlock(&dma_win_list_lock);
 		break;
@@ -2443,12 +2461,10 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
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
-			/* XXX log error */
 		}
 		spin_unlock(&dma_win_list_lock);
 		break;
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


