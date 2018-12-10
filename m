Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D004C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F334120855
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 21:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F334120855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DGNw4q7BzDqRZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 08:26:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux.ibm.com
 (client-ip=148.163.156.1; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=tlfalcon@linux.ibm.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43DGHx58K1zDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 08:22:37 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wBALILAD090188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:22:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2p9x3bw1ay-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 16:22:35 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <tlfalcon@linux.ibm.com>;
 Mon, 10 Dec 2018 21:22:35 -0000
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
 by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Dec 2018 21:22:32 -0000
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wBALMUMB28442786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 10 Dec 2018 21:22:30 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C632EBE04F;
 Mon, 10 Dec 2018 21:22:30 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A70EBE051;
 Mon, 10 Dec 2018 21:22:30 +0000 (GMT)
Received: from oc3765557031.ibm.com (unknown [9.85.206.46])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
 Mon, 10 Dec 2018 21:22:30 +0000 (GMT)
From: Thomas Falcon <tlfalcon@linux.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net 1/2] ibmvnic: Convert reset work item mutex to spin lock
Date: Mon, 10 Dec 2018 15:22:22 -0600
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544476943-5712-1-git-send-email-tlfalcon@linux.ibm.com>
References: <1544476943-5712-1-git-send-email-tlfalcon@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18121021-0012-0000-0000-000016E77EC3
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010210; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01129895; UDB=6.00587082; IPR=6.00910028; 
 MB=3.00024646; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-10 21:22:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121021-0013-0000-0000-000055680145
Message-Id: <1544476943-5712-2-git-send-email-tlfalcon@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-12-10_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
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

ibmvnic_reset can create and schedule a reset work item from
an IRQ context, so do not use a mutex, which can sleep. Convert
the reset work item mutex to a spin lock. Locking debugger generated
the trace output below.

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:908
in_atomic(): 1, irqs_disabled(): 1, pid: 120, name: kworker/8:1
4 locks held by kworker/8:1/120:
 #0: 0000000017c05720 ((wq_completion)"events"){+.+.}, at: process_one_work+0x188/0x710
 #1: 00000000ace90706 ((linkwatch_work).work){+.+.}, at: process_one_work+0x188/0x710
 #2: 000000007632871f (rtnl_mutex){+.+.}, at: rtnl_lock+0x30/0x50
 #3: 00000000fc36813a (&(&crq->lock)->rlock){..-.}, at: ibmvnic_tasklet+0x88/0x2010 [ibmvnic]
irq event stamp: 26293
hardirqs last  enabled at (26292): [<c000000000122468>] tasklet_action_common.isra.12+0x78/0x1c0
hardirqs last disabled at (26293): [<c000000000befce8>] _raw_spin_lock_irqsave+0x48/0xf0
softirqs last  enabled at (26288): [<c000000000a8ac78>] dev_deactivate_queue.constprop.28+0xc8/0x160
softirqs last disabled at (26289): [<c0000000000306e0>] call_do_softirq+0x14/0x24
CPU: 8 PID: 120 Comm: kworker/8:1 Kdump: loaded Not tainted 4.20.0-rc6 #6
Workqueue: events linkwatch_event
Call Trace:
[c0000003fffa7a50] [c000000000bc83e4] dump_stack+0xe8/0x164 (unreliable)
[c0000003fffa7aa0] [c00000000015ba0c] ___might_sleep+0x2dc/0x320
[c0000003fffa7b20] [c000000000be960c] __mutex_lock+0x8c/0xb40
[c0000003fffa7c30] [d000000006202ac8] ibmvnic_reset+0x78/0x330 [ibmvnic]
[c0000003fffa7cc0] [d0000000062097f4] ibmvnic_tasklet+0x1054/0x2010 [ibmvnic]
[c0000003fffa7e00] [c0000000001224c8] tasklet_action_common.isra.12+0xd8/0x1c0
[c0000003fffa7e60] [c000000000bf1238] __do_softirq+0x1a8/0x64c
[c0000003fffa7f90] [c0000000000306e0] call_do_softirq+0x14/0x24
[c0000003f3f87980] [c00000000001ba50] do_softirq_own_stack+0x60/0xb0
[c0000003f3f879c0] [c0000000001218a8] do_softirq+0xa8/0x100
[c0000003f3f879f0] [c000000000121a74] __local_bh_enable_ip+0x174/0x180
[c0000003f3f87a60] [c000000000bf003c] _raw_spin_unlock_bh+0x5c/0x80
[c0000003f3f87a90] [c000000000a8ac78] dev_deactivate_queue.constprop.28+0xc8/0x160
[c0000003f3f87ad0] [c000000000a8c8b0] dev_deactivate_many+0xd0/0x520
[c0000003f3f87b70] [c000000000a8cd40] dev_deactivate+0x40/0x60
[c0000003f3f87ba0] [c000000000a5e0c4] linkwatch_do_dev+0x74/0xd0
[c0000003f3f87bd0] [c000000000a5e694] __linkwatch_run_queue+0x1a4/0x1f0
[c0000003f3f87c30] [c000000000a5e728] linkwatch_event+0x48/0x60
[c0000003f3f87c50] [c0000000001444e8] process_one_work+0x238/0x710
[c0000003f3f87d20] [c000000000144a48] worker_thread+0x88/0x4e0
[c0000003f3f87db0] [c00000000014e3a8] kthread+0x178/0x1c0
[c0000003f3f87e20] [c00000000000bfd0] ret_from_kernel_thread+0x5c/0x6c

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 16 +++++++++-------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index ed50b8dee44f..ffc0cab05b0f 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1939,8 +1939,9 @@ static int do_hard_reset(struct ibmvnic_adapter *adapter,
 static struct ibmvnic_rwi *get_next_rwi(struct ibmvnic_adapter *adapter)
 {
 	struct ibmvnic_rwi *rwi;
+	unsigned long flags;
 
-	mutex_lock(&adapter->rwi_lock);
+	spin_lock_irqsave(&adapter->rwi_lock, flags);
 
 	if (!list_empty(&adapter->rwi_list)) {
 		rwi = list_first_entry(&adapter->rwi_list, struct ibmvnic_rwi,
@@ -1950,7 +1951,7 @@ static struct ibmvnic_rwi *get_next_rwi(struct ibmvnic_adapter *adapter)
 		rwi = NULL;
 	}
 
-	mutex_unlock(&adapter->rwi_lock);
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 	return rwi;
 }
 
@@ -2025,6 +2026,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	struct list_head *entry, *tmp_entry;
 	struct ibmvnic_rwi *rwi, *tmp;
 	struct net_device *netdev = adapter->netdev;
+	unsigned long flags;
 	int ret;
 
 	if (adapter->state == VNIC_REMOVING ||
@@ -2041,13 +2043,13 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 		goto err;
 	}
 
-	mutex_lock(&adapter->rwi_lock);
+	spin_lock_irqsave(&adapter->rwi_lock, flags);
 
 	list_for_each(entry, &adapter->rwi_list) {
 		tmp = list_entry(entry, struct ibmvnic_rwi, list);
 		if (tmp->reset_reason == reason) {
 			netdev_dbg(netdev, "Skipping matching reset\n");
-			mutex_unlock(&adapter->rwi_lock);
+			spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 			ret = EBUSY;
 			goto err;
 		}
@@ -2055,7 +2057,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 
 	rwi = kzalloc(sizeof(*rwi), GFP_KERNEL);
 	if (!rwi) {
-		mutex_unlock(&adapter->rwi_lock);
+		spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 		ibmvnic_close(netdev);
 		ret = ENOMEM;
 		goto err;
@@ -2069,7 +2071,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	}
 	rwi->reset_reason = reason;
 	list_add_tail(&rwi->list, &adapter->rwi_list);
-	mutex_unlock(&adapter->rwi_lock);
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 	adapter->resetting = true;
 	netdev_dbg(adapter->netdev, "Scheduling reset (reason %d)\n", reason);
 	schedule_work(&adapter->ibmvnic_reset);
@@ -4759,7 +4761,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
-	mutex_init(&adapter->rwi_lock);
+	spin_lock_init(&adapter->rwi_lock);
 	adapter->resetting = false;
 
 	adapter->mac_change_pending = false;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 99c4f8d331ce..f2018dbebfa5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1075,7 +1075,7 @@ struct ibmvnic_adapter {
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
 	enum ibmvnic_reset_reason reset_reason;
-	struct mutex rwi_lock;
+	spinlock_t rwi_lock;
 	struct list_head rwi_list;
 	struct work_struct ibmvnic_reset;
 	bool resetting;
-- 
2.12.3

