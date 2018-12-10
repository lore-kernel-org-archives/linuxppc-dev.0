Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC37C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B157E20821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:29:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B157E20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DGRz4WbRzDq6K
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 08:29:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tlfalcon@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DGJ00pm3zDqNt
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 08:22:39 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBALINTc069941
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:22:37 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9vwegay1-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:22:37 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.ibm.com>;
 Mon, 10 Dec 2018 21:22:36 -0000
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 21:22:34 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBALMWDi28770404
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 21:22:32 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A21F6BE051;
 Mon, 10 Dec 2018 21:22:32 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 15C5DBE04F;
 Mon, 10 Dec 2018 21:22:32 +0000 (GMT)
Received: from oc3765557031.ibm.com (unknown [9.85.206.46])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 10 Dec 2018 21:22:31 +0000 (GMT)
From: Thomas Falcon <tlfalcon@linux.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net 2/2] ibmvnic: Fix non-atomic memory allocation in IRQ
 context
Date: Mon, 10 Dec 2018 15:22:23 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544476943-5712-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1544476943-5712-1-git-send-email-tlfalcon@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121021-0036-0000-0000-00000A687FD6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010209; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129895; UDB=6.00587082; IPR=6.00910028; 
 MB=3.00024646; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 21:22:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121021-0037-0000-0000-000049EDD3AF
Message-Id: <1544476943-5712-3-git-send-email-tlfalcon@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812100190
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
Cc: Thomas Falcon <tlfalcon@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

ibmvnic_reset allocated new reset work item objects in a non-atomic
context. This can be called from a tasklet, generating the output below.
Allocate work items with the GFP_ATOMIC flag instead.

BUG: sleeping function called from invalid context at mm/slab.h:421
in_atomic(): 1, irqs_disabled(): 1, pid: 93, name: kworker/0:2
INFO: lockdep is turned off.
irq event stamp: 66049
hardirqs last  enabled at (66048): [<c000000000122468>] tasklet_action_common.isra.12+0x78/0x1c0
hardirqs last disabled at (66049): [<c000000000befce8>] _raw_spin_lock_irqsave+0x48/0xf0
softirqs last  enabled at (66044): [<c000000000a8ac78>] dev_deactivate_queue.constprop.28+0xc8/0x160
softirqs last disabled at (66045): [<c0000000000306e0>] call_do_softirq+0x14/0x24
CPU: 0 PID: 93 Comm: kworker/0:2 Kdump: loaded Not tainted 4.20.0-rc6-00001-g1b50a8f03706 #7
Workqueue: events linkwatch_event
Call Trace:
[c0000003fffe7ae0] [c000000000bc83e4] dump_stack+0xe8/0x164 (unreliable)
[c0000003fffe7b30] [c00000000015ba0c] ___might_sleep+0x2dc/0x320
[c0000003fffe7bb0] [c000000000391514] kmem_cache_alloc_trace+0x3e4/0x440
[c0000003fffe7c30] [d000000005b2309c] ibmvnic_reset+0x16c/0x360 [ibmvnic]
[c0000003fffe7cc0] [d000000005b29834] ibmvnic_tasklet+0x1054/0x2010 [ibmvnic]
[c0000003fffe7e00] [c0000000001224c8] tasklet_action_common.isra.12+0xd8/0x1c0
[c0000003fffe7e60] [c000000000bf1238] __do_softirq+0x1a8/0x64c
[c0000003fffe7f90] [c0000000000306e0] call_do_softirq+0x14/0x24
[c0000003f3967980] [c00000000001ba50] do_softirq_own_stack+0x60/0xb0
[c0000003f39679c0] [c0000000001218a8] do_softirq+0xa8/0x100
[c0000003f39679f0] [c000000000121a74] __local_bh_enable_ip+0x174/0x180
[c0000003f3967a60] [c000000000bf003c] _raw_spin_unlock_bh+0x5c/0x80
[c0000003f3967a90] [c000000000a8ac78] dev_deactivate_queue.constprop.28+0xc8/0x160
[c0000003f3967ad0] [c000000000a8c8b0] dev_deactivate_many+0xd0/0x520
[c0000003f3967b70] [c000000000a8cd40] dev_deactivate+0x40/0x60
[c0000003f3967ba0] [c000000000a5e0c4] linkwatch_do_dev+0x74/0xd0
[c0000003f3967bd0] [c000000000a5e694] __linkwatch_run_queue+0x1a4/0x1f0
[c0000003f3967c30] [c000000000a5e728] linkwatch_event+0x48/0x60
[c0000003f3967c50] [c0000000001444e8] process_one_work+0x238/0x710
[c0000003f3967d20] [c000000000144a48] worker_thread+0x88/0x4e0
[c0000003f3967db0] [c00000000014e3a8] kthread+0x178/0x1c0
[c0000003f3967e20] [c00000000000bfd0] ret_from_kernel_thread+0x5c/0x6c

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index ffc0cab05b0f..67cc6d9c8fd7 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2055,7 +2055,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 		}
 	}
 
-	rwi = kzalloc(sizeof(*rwi), GFP_KERNEL);
+	rwi = kzalloc(sizeof(*rwi), GFP_ATOMIC);
 	if (!rwi) {
 		spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 		ibmvnic_close(netdev);
-- 
2.12.3

