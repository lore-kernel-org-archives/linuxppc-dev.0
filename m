Return-Path: <linuxppc-dev+bounces-24537-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EB2C44515
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 20:30:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3sbQ0HmHz2yLY;
	Tue, 21 Jul 2026 06:30:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784579442;
	cv=none; b=OxdkMl5XVa16492k34DUH+EQu/z//dGaL2h/F+AGshKVLBKf64sHv/UiCIzNR10FWKPcLF3GjN4MXEuZ9xBTCL3ot/DZ7FGmFpcc9udrDDDJkLq1PVaEHM5zD4+lWSm1BzxS+pQTEtNZ8WsZZfi/GPDrIXJ4KHxXVBMSFyxPir3Lppo71b1dDVHnRn+GPHR7Alb4nZfC5oK8ZW95ZT8b3s3Q7X8/crOBgJrMRPkSO/Ky4MwIPL+Y5E7JeNpCEfjOITL5V44Hdez6HPEO4ft4sNL1a47iOUGy+9Nj3ourMPWgDmWbkGfyyVyFf0LY2D+4VY+UgLysULyrAJ3HJePcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784579442; c=relaxed/relaxed;
	bh=B170ktvBJvb7IdCG3ZTa+eB9QaJTpQOOQSG14E40pM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ngPYp+3evzw9DGc/t1U9HnhuGsg5sbJbcpmfLX7YxjmsaD6Vw6hUkTmJl6qZisDiEh0GupULFOHDL8v2koxJERX7aw1gNxcfLZbcj8e0LYHG62m26aNim/Rl5YI68FKj9v4ZtctjwqaxR1MyKgWbkylLR7dvlfC46VRDVUWSVLj0+278ppD2BCHveusJIkNUPVALjm6T0ev4siffks5t0xzLvZrN/hnqvans1hvnWmXG4TPMh3i4Zgx6zRnKwCac87F6wEplCuRkoRc2XWjqyNXSCxU2itglZ8+lBSuJ89gnEBTBO3O3qbydZH3sZLf8RgCSdwN6Yk6gMDtKS5AfoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HRfMpuHj; dkim-atps=neutral; spf=pass (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.ibm.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HRfMpuHj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.ibm.com (client-ip=148.163.158.5; helo=mx0b-001b2d01.pphosted.com; envelope-from=gbatra@linux.ibm.com; receiver=lists.ozlabs.org)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3sbP1ZmBz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2026 06:30:40 +1000 (AEST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KJfjx83128808
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 20:30:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=B170ktvBJvb7IdCG3ZTa+eB9QaJTpQOOQSG14E40p
	M4=; b=HRfMpuHj9+yy+2hpsjI1WFelAMCKlLCXxC4AvKdEflG7FviEYZtXGxtKV
	tyAC1JSxVafaockiq1n+dPvZuy2/ZVWyIJmrQvrBRxiJV1AEwcWMtSNlj3T/4DDQ
	vSllC+crJ70BV2KHJnt1zsgH5P3Wp2QcsYCDTQ7e6/LfmhSt37Kje/pl/kd8OQ8o
	b7HGgtllS6ie9CE+vTyQoql1KXPste+CspGPo8fjkA3i8m0MooSfp/SPTCJhd5k2
	YEWwXNC/H3A6kvmP57+glKCFYOUZ2ZXECkygHvl4jDBP3wXodX9rn8epQBsVFYn8
	bLLII20iS4+dPHglUCXrm8RFEsvfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah12kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:30:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KKJb4A015427;
	Mon, 20 Jul 2026 20:30:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g72dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 20:30:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KKUaZL1639026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 20:30:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42C5058059;
	Mon, 20 Jul 2026 20:30:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619A658058;
	Mon, 20 Jul 2026 20:30:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.184.84])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 20:30:35 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: npiggin@gmail.com, ltc-dev@lists.linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, sbhat@linux.ibm.com,
        ritesh.list@gmail.com, harshpb@linux.ibm.com, vaibhav@linux.ibm.com,
        Gaurav Batra <gbatra@linux.ibm.com>
Subject: [PATCH] powerpc/pseries/iommu: switch to Default DMA window during kdump
Date: Mon, 20 Jul 2026 15:30:34 -0500
Message-ID: <20260720203034.95244-1-gbatra@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: McVNhb5keE3Z9RNj62uU-MwpVpar1Fxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX3878tUrEVNXL
 MGA92/V/ZEgiwOmZvjIsU5x+UzxGNKkVRZXdl5nRuug4I18T1xufBmfUvE3ABh05sB2HTbgVi3y
 tQVbOtaQzyYzMk/SWFvLestCoJc2S79XxdnjMqLtNVnOPl07TLwUk6yN1mrwid70/Wfz8k7zQvH
 Puh2XmPmUoLEiNK2JAmjvQGO3dX1o07Ggs9e8gVtAutl9fN8EZLkGrpUhfpmDswV1pJRliq57FG
 /8eSP4z+vbjkRzaDHBTpb7GhAG/WzuXzmNvLIv1A904Sfdd/hVKJH+RwqMlITLDcHNnJ64u7cFH
 g8bbEO4YvndTCco9OdOqeGOmvd3F5jK9D3eYbnWKupqfRE+km7xgKZ6GbANikXugUQaVHjhY3of
 UMJ4O0qNUZjXCjoBVFsSXyU5BQ3dDwBcWWUwpzogNxomE0L+f4PlGrPMUK/LRVz2FNyS9qoEpFt
 QhLLmnOOeI/foRyuTDg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMCBTYWx0ZWRfX36eE1DRfih8h
 0N3KgAdzfCq958Qs5GyyADMfNtf9HDX7cwOKLmLMTsCOVRWO7cllNFP6BWaCV2srgaZe+ZO3ZTa
 4enMm6ipJQXF3QQr87qugPfJppgHaS0=
X-Proofpoint-GUID: tmYlRTqlmdBmTNn6tO3i_Iso2kue51BD
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5e856e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Hr_sB0k_5zeya_QuA1YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200220

In PowerPC (pseries) a non-virtualized adapter will have 2 DMA windows -
2GB default and a larger Dynamic DMA Window (DDW). DDW is large enough to
map total RAM to a device.

During normal functioning of OS, since RAM is pre-mapped, 2GB default
window is not used. The only scenario it might get used is when buffers in
pmemory are mapped to the device for DMA.

As of today, during kdump, during early device discovery, pci_dma_find()
finds that the device has 2 DMA windows. It selects to use DDW. This is a
kdump path and DMA window is needed for IO to the device.

Since, in the previous life of the LPAR (before panic), RAM was pre-mapped
via DDW, the DDW is completely full. So, in the iommu table initialization
code, iommu_table_clear() frees KDUMP_MIN_TCE_ENTRIES (2K) number of
TCEs.

But, it seems these are not enough for NVMe over Fibre-channel. When kdump
is trying to save vmcore on storage device, which is NVMe-FC, the
TCE usage is much more than 2K number of entries. The driver is mapping
a lot more buffers for DMA. After all the TCEs are consumed, iommu returns
iommu_alloc failures and the driver is not able to further map buffers for
IO. kdump fails to copy vmcore to NVMe-FC storage device.

Here are the driver logs and stack

lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.

iommu_map_phys+0x1c4/0x1f0 (unreliable)
dma_iommu_map_phys+0x54/0xa0
dma_map_phys+0x3f8/0x590
__nvme_fc_init_request+0x110/0x300 [nvme_fc]
nvme_fc_init_request+0x60/0xb8 [nvme_fc]
blk_mq_alloc_map_and_rqs+0x388/0x510
blk_mq_alloc_tag_set+0x2a4/0x5f0
nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
process_one_work+0x1e4/0x5a0
worker_thread+0x1ec/0x3e0

Increasing the number of free TCE entries in iommu_table_clear() will
increase the probability of hitting EEH since there could still be some
active IOs from the previous life of the kernel.

Instead, during kdump, we can switch to default 2GB DMA window. This window
will mostly be empty. Or, could be slightly used if buffers in pmemory
were mapped for IO.

Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..272e9aab66d4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -812,18 +812,11 @@ static struct device_node *pci_dma_find(struct device_node *dn,
 
 	/* parse DMA window property. During normal system boot, only default
 	 * DMA window is passed in OF. But, for kdump, a dedicated adapter might
-	 * have both default and DDW in FDT. In this scenario, DDW takes precedence
-	 * over default window.
+	 * have both default and DDW in FDT. In this scenario, default window
+	 * takes precedence over DDW. For a dedicated adapter, default window will
+	 * potentially have more unused TCEs.
 	 */
-	if (ddw_win) {
-		struct dynamic_dma_window_prop *p;
-
-		p = (struct dynamic_dma_window_prop *)ddw_prop;
-		prop->liobn = p->liobn;
-		prop->dma_base = p->dma_base;
-		prop->tce_shift = p->tce_shift;
-		prop->window_shift = p->window_shift;
-	} else if (default_win) {
+	if (default_win) {
 		unsigned long offset, size, liobn;
 
 		of_parse_dma_window(rdn, default_prop, &liobn, &offset, &size);
@@ -832,6 +825,14 @@ static struct device_node *pci_dma_find(struct device_node *dn,
 		prop->dma_base = cpu_to_be64(offset);
 		prop->tce_shift = cpu_to_be32(IOMMU_PAGE_SHIFT_4K);
 		prop->window_shift = cpu_to_be32(order_base_2(size));
+	} else {
+		struct dynamic_dma_window_prop *p;
+
+		p = (struct dynamic_dma_window_prop *)ddw_prop;
+		prop->liobn = p->liobn;
+		prop->dma_base = p->dma_base;
+		prop->tce_shift = p->tce_shift;
+		prop->window_shift = p->window_shift;
 	}
 
 	return rdn;

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.39.3


