Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A845C43444
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA2BE214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 22:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYiUMBwR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA2BE214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Q7TD5bBLzDqFF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Dec 2018 09:49:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iYiUMBwR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="iYiUMBwR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Q7B067jLzDqKq
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Dec 2018 09:36:40 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 423B5218E2;
 Wed, 26 Dec 2018 22:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1545863799;
 bh=cM4xCF8JpSWLBzE2CnD6dMYtbksXFv5bmWk2QCQH+u0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iYiUMBwR+0sUXFiTaH98ccO6sf9mPpkM/beIrjsfVjncDnhDUgKMcH+E5UJ4ZhSmD
 LaLcvU/3gOLG2f6K21Ugif4CZ0rOG3aHKeEBHmTTgqyRoZY1SwyaJXxJmBfLdL/wYk
 QqY7NnLD+b+xcKVH+w+ZRhYnr+nWAK+RT68+sTHs=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 26/97] ibmvnic: Convert reset work item mutex to
 spin lock
Date: Wed, 26 Dec 2018 17:34:46 -0500
Message-Id: <20181226223557.149329-26-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223557.149329-1-sashal@kernel.org>
References: <20181226223557.149329-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
 Thomas Falcon <tlfalcon@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Thomas Falcon <tlfalcon@linux.ibm.com>

[ Upstream commit 6c5c7489089608d89b7ce310bca44812e2b0a4a5 ]

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
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 16 +++++++++-------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 +-
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5ab21a1b5444..5058bd83bdd6 100644
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
@@ -4700,7 +4702,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
-	mutex_init(&adapter->rwi_lock);
+	spin_lock_init(&adapter->rwi_lock);
 	adapter->resetting = false;
 
 	adapter->mac_change_pending = false;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 735f481b1870..09465397b7ff 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1068,7 +1068,7 @@ struct ibmvnic_adapter {
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
 	enum ibmvnic_reset_reason reset_reason;
-	struct mutex rwi_lock;
+	spinlock_t rwi_lock;
 	struct list_head rwi_list;
 	struct work_struct ibmvnic_reset;
 	bool resetting;
-- 
2.19.1

