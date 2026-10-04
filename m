Return-Path: <linuxppc-dev+bounces-28876-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0129CA5FEC
	for <linuxppc-dev@archiver.kernel.org>; Sun,  4 Oct 2026 10:31:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hyJjV0hS8z30St;
	Sun, 04 Oct 2026 21:31:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791109918;
	cv=none; b=UetsAqpDAi3ZNVYBcpQ0EziJTX+Oq+RfaDXJj279YuiUJfGNTIrWvSLXGiwyyCn/yrvKTHuLh9mAhdNxYy89sNMvLkjR0ChTtLkNBtaR1fQ2hp2Rqtta3tnAv4zLfqe47gv9tiTE7zF/WnEr/A4D0LpcKvWfYH/nx5kxd7lqze2phftgIZo5HEM36B46ppvD3yBCrSLThwVV6b1Uz5l639GpwGD3PYBoYlHJ0agWn4S6O0N5dkWjm7Y2LCBL1DjRD2coL7Ooe2jJNt8qO3vrxlPhxXEEdTbSkVvKvsXwQOZNDy8G1DwLelEPdY4gQkysvQZxh2CyrE6eksaAft22QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791109918; c=relaxed/relaxed;
	bh=O+46VD+H9Rar1sjoDBo4y4zvWHDRInLA900zopAROnE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QI7pvPdA1T8qff1ZgMDNO8e2a7erAbV363iW/tpOpLbvS0yrChkrHDFaA9ApNAM6nPWybH5qJya7vKZ6RCdk4abuJI/mRPtJ1KMeXy0V/tO9BGRj23fqJoZGVcPkBhuenkwh/jt3hXnx0uYkG6ACp7VZDrIz6ytozCrGBOk9Rvhp0vyCYuAwwIPsZFCA2o4f0ebxS58qAABNp1EiCoRAIG8oubG61GXndd06eNTbac5Hd42UwYHLyxYEs1i6Pk0HKVeEqDKHbb6LTamI5u2IAh8pNcOqDWRV8o5lqNrbxOT0ZRq0izxuq35sowI8FGgx8WJdXJS3vX3vJxy2tLyqxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=N6Kgbwwe; dkim-atps=neutral; spf=pass (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn; receiver=lists.ozlabs.org) smtp.mailfrom=seu.edu.cn
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=N6Kgbwwe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=seu.edu.cn (client-ip=45.254.49.198; helo=mail-m49198.qiye.163.com; envelope-from=runyu.xiao@seu.edu.cn; receiver=lists.ozlabs.org)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hyJjN0VHXz30RN
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Oct 2026 21:31:49 +1100 (AEDT)
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4feb7a9b1;
	Sun, 4 Oct 2026 18:31:41 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: ibmvnic: defer close from reset allocation failure
Date: Sun,  4 Oct 2026 18:31:31 +0800
Message-Id: <20261004103131.1205618-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa106782b4b03a1kunmbc768e8c338b56
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB5PVkJKTUsfGktDQh5DGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=N6Kgbwwe2tF8Qar+ypwMokXB7CfsMi6TyJUqbGTK/OVplPwJHccEzmd+g6rltyM+w3EkkhhdbL3KColHbnOoyA+tjQAGaK6tmMZYyk0sl9XgTyVkZzvJyXyoaiZBcaXiaUs/DIDTRJoAtWE4hdF1JbveRkNXIzOCKr70u7AsLsU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=O+46VD+H9Rar1sjoDBo4y4zvWHDRInLA900zopAROnE=;
	h=date:mime-version:subject:message-id:from;

ibmvnic_reset() can be called by the CRQ tasklet. If allocating the
reset work item fails, it currently calls ibmvnic_close() after
dropping rwi_lock, but ibmvnic_close() reaches napi_disable() and
other sleepable teardown paths.

Defer the close to a work item and keep the work within the adapter
lifetime. Track removal separately from the visible adapter state so
ibmvnic_close() cannot make removal look active again after remove()
has begun. Check that monotonic flag while scheduling reset and
delayed reset work, and drain all work before releasing the adapter.

Use complete_all() for probe_done because the reset and close workers
may wait for probe completion concurrently.

The issue was identified by code inspection. No runtime reproduction or
real hardware testing is available.

Fixes: ed651a10875f ("ibmvnic: Updated reset handling")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 54 ++++++++++++++++++++++++------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 ++
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 5a510eed33..4da3fd7ce0 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2152,6 +2152,26 @@ static int ibmvnic_close(struct net_device *netdev)
 	return rc;
 }
 
+static void ibmvnic_close_work(struct work_struct *work)
+{
+	struct ibmvnic_adapter *adapter = container_of(work,
+							struct ibmvnic_adapter,
+							ibmvnic_close_work);
+	unsigned long flags;
+	bool removing;
+
+	/* The close path can sleep, so run it outside the CRQ tasklet. */
+	wait_for_completion(&adapter->probe_done);
+	rtnl_lock();
+	spin_lock_irqsave(&adapter->rwi_lock, flags);
+	removing = adapter->removing;
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
+
+	if (!removing)
+		ibmvnic_close(adapter->netdev);
+	rtnl_unlock();
+}
+
 /**
  * get_hdr_lens - fills list of L2/L3/L4 hdr lens
  * @hdr_field: bitfield determining needed headers
@@ -3229,9 +3249,12 @@ static void __ibmvnic_reset(struct work_struct *work)
 	if (adapter->state == VNIC_PROBING &&
 	    !wait_for_completion_timeout(&adapter->probe_done, timeout)) {
 		dev_err(dev, "Reset thread timed out on probe");
-		queue_delayed_work(system_long_wq,
-				   &adapter->ibmvnic_delayed_reset,
-				   IBMVNIC_RESET_DELAY);
+		spin_lock_irqsave(&adapter->rwi_lock, flags);
+		if (!adapter->removing)
+			queue_delayed_work(system_long_wq,
+					   &adapter->ibmvnic_delayed_reset,
+					   IBMVNIC_RESET_DELAY);
+		spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 		return;
 	}
 
@@ -3265,7 +3288,7 @@ static void __ibmvnic_reset(struct work_struct *work)
 	 */
 	need_reset = false;
 	spin_lock(&adapter->rwi_lock);
-	if (!list_empty(&adapter->rwi_list)) {
+	if (!adapter->removing && !list_empty(&adapter->rwi_list)) {
 		if (test_and_set_bit_lock(0, &adapter->resetting)) {
 			queue_delayed_work(system_long_wq,
 					   &adapter->ibmvnic_delayed_reset,
@@ -3422,7 +3445,8 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 	 * a failover reset scheduled, we will detect and drop the
 	 * duplicate reset when walking the ->rwi_list below.
 	 */
-	if (adapter->state == VNIC_REMOVING ||
+	if (adapter->removing ||
+	    adapter->state == VNIC_REMOVING ||
 	    adapter->state == VNIC_REMOVED ||
 	    (adapter->failover_pending && reason != VNIC_RESET_FAILOVER)) {
 		ret = EBUSY;
@@ -3458,11 +3482,11 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 
 	ret = 0;
 err:
-	/* ibmvnic_close() below can block, so drop the lock first */
-	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
-
 	if (ret == ENOMEM)
-		ibmvnic_close(netdev);
+		queue_work(system_long_wq, &adapter->ibmvnic_close_work);
+
+	/* ibmvnic_close() can block, so defer it out of atomic context. */
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
 
 	return -ret;
 }
@@ -6466,6 +6490,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	SET_NETDEV_DEV(netdev, &dev->dev);
 
 	INIT_WORK(&adapter->ibmvnic_reset, __ibmvnic_reset);
+	INIT_WORK(&adapter->ibmvnic_close_work, ibmvnic_close_work);
 	INIT_DELAYED_WORK(&adapter->ibmvnic_delayed_reset,
 			  __ibmvnic_delayed_reset);
 	INIT_LIST_HEAD(&adapter->rwi_list);
@@ -6568,7 +6593,8 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 		goto cpu_notif_add_failed;
 	}
 
-	complete(&adapter->probe_done);
+	complete_all(&adapter->probe_done);
+	flush_work(&adapter->ibmvnic_close_work);
 
 	return 0;
 
@@ -6591,10 +6617,14 @@ static int ibmvnic_probe(struct vio_dev *dev, const struct vio_device_id *id)
 	/* cleanup worker thread after releasing CRQ so we don't get
 	 * transport events (i.e new work items for the worker thread).
 	 */
+	spin_lock_irqsave(&adapter->rwi_lock, flags);
+	adapter->removing = true;
 	adapter->state = VNIC_REMOVING;
-	complete(&adapter->probe_done);
+	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
+	complete_all(&adapter->probe_done);
 	flush_work(&adapter->ibmvnic_reset);
 	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
+	flush_work(&adapter->ibmvnic_close_work);
 
 	flush_reset_queue(adapter);
 
@@ -6620,6 +6650,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
 	 * from the flush_work() below, can make progress.
 	 */
 	spin_lock(&adapter->rwi_lock);
+	adapter->removing = true;
 	adapter->state = VNIC_REMOVING;
 	spin_unlock(&adapter->rwi_lock);
 
@@ -6629,6 +6660,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
 
 	flush_work(&adapter->ibmvnic_reset);
 	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
+	flush_work(&adapter->ibmvnic_close_work);
 
 	rtnl_lock();
 	unregister_netdevice(netdev);
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 480dc58707..d8c8a6d230 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1045,6 +1045,7 @@ struct ibmvnic_adapter {
 
 	struct tasklet_struct tasklet;
 	enum vnic_state state;
+	bool removing;
 	/* Used for serialization of state field. When taking both state
 	 * and rwi locks, take state lock first.
 	 */
@@ -1056,6 +1057,7 @@ struct ibmvnic_adapter {
 	 */
 	spinlock_t rwi_lock;
 	struct work_struct ibmvnic_reset;
+	struct work_struct ibmvnic_close_work;
 	struct delayed_work ibmvnic_delayed_reset;
 	unsigned long resetting;
 	/* last device reset time */
-- 
2.34.1

