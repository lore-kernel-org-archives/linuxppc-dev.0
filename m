Return-Path: <SRS0=LYrz=MO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770BC43143
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:59:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09B9E206B2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Oct 2018 15:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09B9E206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42PkPC1V4FzF3J4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 01:59:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux.vnet.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=nfont@linux.vnet.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.vnet.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42PkM13cVkzF37S
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 01:57:48 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w92FseG0015749
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2018 11:57:46 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mv9amxuv1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 11:57:45 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nfont@linux.vnet.ibm.com>;
 Tue, 2 Oct 2018 11:57:44 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
 by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 2 Oct 2018 11:57:43 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w92Fvg5P41812094
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Oct 2018 15:57:42 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 57CF9AC05B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 11:57:00 -0400 (EDT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2AE31AC060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 11:57:00 -0400 (EDT)
Received: from ltcalpine2-lp14.aus.stglabs.ibm.com (unknown [9.40.195.197])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Oct 2018 11:57:00 -0400 (EDT)
Subject: [PATCH v2] powerpc/pseries: Track LMB nid instead of using device tree
From: Nathan Fontenot <nfont@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 02 Oct 2018 10:35:59 -0500
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18100215-0060-0000-0000-000002B9FD2A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009809; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000267; SDB=6.01096848; UDB=6.00567194; IPR=6.00876891; 
 MB=3.00023591; MTD=3.00000008; XFM=3.00000015; UTC=2018-10-02 15:57:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18100215-0061-0000-0000-000046B56785
Message-Id: <153849454718.31242.7801365038229982137.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-10-02_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810020154
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

When removing memory we need to remove the memory from the node
it was added to instead of looking up the node it should be in
in the device tree.

During testing we have seen scenarios where the affinity for a
LMB changes due to a partition migration or PRRN event. In these
cases the node the LMB exists in may not match the node the device
tree indicates it belongs in. This can lead to a system crash
when trying to DLPAR remove the LMB after a migration or PRRN
event. The current code looks up the node in the device tree to
remove the LMB from, the crash occurs when we try to offline this
node and it does not have any data, i.e. node_data[nid] == NULL.

36:mon> e
cpu 0x36: Vector: 300 (Data Access) at [c0000001828b7810]
    pc: c00000000036d08c: try_offline_node+0x2c/0x1b0
    lr: c0000000003a14ec: remove_memory+0xbc/0x110
    sp: c0000001828b7a90
   msr: 800000000280b033
   dar: 9a28
 dsisr: 40000000
  current = 0xc0000006329c4c80
  paca    = 0xc000000007a55200   softe: 0        irq_happened: 0x01
    pid   = 76926, comm = kworker/u320:3

36:mon> t
[link register   ] c0000000003a14ec remove_memory+0xbc/0x110
[c0000001828b7a90] c00000000006a1cc arch_remove_memory+0x9c/0xd0 (unreliable)
[c0000001828b7ad0] c0000000003a14e0 remove_memory+0xb0/0x110
[c0000001828b7b20] c0000000000c7db4 dlpar_remove_lmb+0x94/0x160
[c0000001828b7b60] c0000000000c8ef8 dlpar_memory+0x7e8/0xd10
[c0000001828b7bf0] c0000000000bf828 handle_dlpar_errorlog+0xf8/0x160
[c0000001828b7c60] c0000000000bf8cc pseries_hp_work_fn+0x3c/0xa0
[c0000001828b7c90] c000000000128cd8 process_one_work+0x298/0x5a0
[c0000001828b7d20] c000000000129068 worker_thread+0x88/0x620
[c0000001828b7dc0] c00000000013223c kthread+0x1ac/0x1c0
[c0000001828b7e30] c00000000000b45c ret_from_kernel_thread+0x5c/0x80

To resolve this we need to track the node a LMB belongs to when
it is added to the system so we can remove it from that node instead
of the node that the device tree indicates it should belong to.

Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
---

Updates:
  V2: Fix builds to only track nid for LMBs when MEMORY_HOTPLUG
      is configured.

 arch/powerpc/include/asm/drmem.h                |   21 +++++++++++++++++++++
 arch/powerpc/mm/drmem.c                         |    6 +++++-
 arch/powerpc/platforms/pseries/hotplug-memory.c |   17 ++++++++---------
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/drmem.h b/arch/powerpc/include/asm/drmem.h
index 7c1d8e74b25d..7f3279b014db 100644
--- a/arch/powerpc/include/asm/drmem.h
+++ b/arch/powerpc/include/asm/drmem.h
@@ -17,6 +17,9 @@ struct drmem_lmb {
 	u32     drc_index;
 	u32     aa_index;
 	u32     flags;
+#ifdef CONFIG_MEMORY_HOTPLUG
+	int	nid;
+#endif
 };
 
 struct drmem_lmb_info {
@@ -104,4 +107,22 @@ static inline void invalidate_lmb_associativity_index(struct drmem_lmb *lmb)
 	lmb->aa_index = 0xffffffff;
 }
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline void lmb_set_nid(struct drmem_lmb *lmb)
+{
+	lmb->nid = memory_add_physaddr_to_nid(lmb->base_addr);
+}
+static inline void lmb_clear_nid(struct drmem_lmb *lmb)
+{
+	lmb->nid = -1;
+}
+#else
+static inline void lmb_set_nid(struct drmem_lmb *lmb)
+{
+}
+static inline void lmb_clear_nid(struct drmem_lmb *lmb)
+{
+}
+#endif
+
 #endif /* _ASM_POWERPC_LMB_H */
diff --git a/arch/powerpc/mm/drmem.c b/arch/powerpc/mm/drmem.c
index 3f1803672c9b..641891df2046 100644
--- a/arch/powerpc/mm/drmem.c
+++ b/arch/powerpc/mm/drmem.c
@@ -366,8 +366,10 @@ static void __init init_drmem_v1_lmbs(const __be32 *prop)
 	if (!drmem_info->lmbs)
 		return;
 
-	for_each_drmem_lmb(lmb)
+	for_each_drmem_lmb(lmb) {
 		read_drconf_v1_cell(lmb, &prop);
+		lmb_set_nid(lmb);
+	}
 }
 
 static void __init init_drmem_v2_lmbs(const __be32 *prop)
@@ -412,6 +414,8 @@ static void __init init_drmem_v2_lmbs(const __be32 *prop)
 
 			lmb->aa_index = dr_cell.aa_index;
 			lmb->flags = dr_cell.flags;
+
+			lmb_set_nid(lmb);
 		}
 	}
 }
diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9a15d39995e5..58feca665b8c 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -382,7 +382,7 @@ static int dlpar_add_lmb(struct drmem_lmb *);
 static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
-	int nid, rc;
+	int rc;
 
 	if (!lmb_is_removable(lmb))
 		return -EINVAL;
@@ -392,14 +392,14 @@ static int dlpar_remove_lmb(struct drmem_lmb *lmb)
 		return rc;
 
 	block_sz = pseries_memory_block_size();
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
 
-	remove_memory(nid, lmb->base_addr, block_sz);
+	remove_memory(lmb->nid, lmb->base_addr, block_sz);
 
 	/* Update memory regions for memory remove */
 	memblock_remove(lmb->base_addr, block_sz);
 
 	invalidate_lmb_associativity_index(lmb);
+	lmb_clear_nid(lmb);
 	lmb->flags &= ~DRCONF_MEM_ASSIGNED;
 
 	return 0;
@@ -656,7 +656,7 @@ static int dlpar_memory_remove_by_ic(u32 lmbs_to_remove, u32 drc_index)
 static int dlpar_add_lmb(struct drmem_lmb *lmb)
 {
 	unsigned long block_sz;
-	int nid, rc;
+	int rc;
 
 	if (lmb->flags & DRCONF_MEM_ASSIGNED)
 		return -EINVAL;
@@ -667,13 +667,11 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 		return rc;
 	}
 
+	lmb_set_nid(lmb);
 	block_sz = memory_block_size_bytes();
 
-	/* Find the node id for this address */
-	nid = memory_add_physaddr_to_nid(lmb->base_addr);
-
 	/* Add the memory */
-	rc = add_memory(nid, lmb->base_addr, block_sz);
+	rc = add_memory(lmb->nid, lmb->base_addr, block_sz);
 	if (rc) {
 		invalidate_lmb_associativity_index(lmb);
 		return rc;
@@ -681,8 +679,9 @@ static int dlpar_add_lmb(struct drmem_lmb *lmb)
 
 	rc = dlpar_online_lmb(lmb);
 	if (rc) {
-		remove_memory(nid, lmb->base_addr, block_sz);
+		remove_memory(lmb->nid, lmb->base_addr, block_sz);
 		invalidate_lmb_associativity_index(lmb);
+		lmb_clear_nid(lmb);
 	} else {
 		lmb->flags |= DRCONF_MEM_ASSIGNED;
 	}

