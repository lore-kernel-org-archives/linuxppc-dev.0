Return-Path: <SRS0=BLVf=OI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FFDC04EBA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 06:12:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDEB020868
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 06:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry06Y+OR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDEB020868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4356cZ5nGCzDr5h
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 17:12:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ry06Y+OR";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ry06Y+OR"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4356MM5VpWzDr4d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 17:00:47 +1100 (AEDT)
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 66441213A2;
 Thu, 29 Nov 2018 06:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1543471246;
 bh=7hpmEqVv55ABWE4GjC7XfnAzjZIF9tDpMaVuDcwSe2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ry06Y+ORV9OJ5mCWcoo2wyH1Cw/CDApGXzMZWofhrgXrVa8zj/JDy7pyW2/EnUr0K
 MmKj9EodiUaeZH1QVwoyh9oBT1Yv6NeU95RDdkWAE27Y6iSWKhJmDDUu5mXiOY5L5T
 TGuD4NACHy+8mr4TU34ikTPu4uPknlYz5Bc2CrKA=
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 62/68] ibmvnic: Update driver queues after change
 in ring size support
Date: Thu, 29 Nov 2018 00:55:53 -0500
Message-Id: <20181129055559.159228-62-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
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

[ Upstream commit 5bf032ef08e6a110edc1e3bfb3c66a208fb55125 ]

During device reset, queue memory is not being updated to accommodate
changes in ring buffer sizes supported by backing hardware. Track
any differences in ring buffer sizes following the reset and update
queue memory when possible.

Signed-off-by: Thomas Falcon <tlfalcon@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index f1d4d7a1278b..5ab21a1b5444 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1737,6 +1737,7 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 		    struct ibmvnic_rwi *rwi, u32 reset_state)
 {
 	u64 old_num_rx_queues, old_num_tx_queues;
+	u64 old_num_rx_slots, old_num_tx_slots;
 	struct net_device *netdev = adapter->netdev;
 	int i, rc;
 
@@ -1748,6 +1749,8 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 
 	old_num_rx_queues = adapter->req_rx_queues;
 	old_num_tx_queues = adapter->req_tx_queues;
+	old_num_rx_slots = adapter->req_rx_add_entries_per_subcrq;
+	old_num_tx_slots = adapter->req_tx_entries_per_subcrq;
 
 	ibmvnic_cleanup(netdev);
 
@@ -1810,7 +1813,11 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			if (rc)
 				return rc;
 		} else if (adapter->req_rx_queues != old_num_rx_queues ||
-			   adapter->req_tx_queues != old_num_tx_queues) {
+			   adapter->req_tx_queues != old_num_tx_queues ||
+			   adapter->req_rx_add_entries_per_subcrq !=
+							old_num_rx_slots ||
+			   adapter->req_tx_entries_per_subcrq !=
+							old_num_tx_slots) {
 			release_rx_pools(adapter);
 			release_tx_pools(adapter);
 			release_napi(adapter);
-- 
2.17.1

