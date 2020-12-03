Return-Path: <SRS0=jgKV=FH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5EFC433C1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 14:13:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796D20705
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Dec 2020 14:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796D20705
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CmyV43GJbzDqcv
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Dec 2020 01:13:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CmxXP5ZggzDrMT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2020 00:29:57 +1100 (AEDT)
From: Sasha Levin <sashal@kernel.org>
Authentication-Results: mail.kernel.org;
 dkim=permerror (bad message/signature format)
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 12/23] ibmvnic: skip tx timeout reset while in
 resetting
Date: Thu,  3 Dec 2020 08:29:24 -0500
Message-Id: <20201203132935.931362-12-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201203132935.931362-1-sashal@kernel.org>
References: <20201203132935.931362-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
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
 Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Lijun Pan <ljp@linux.ibm.com>

[ Upstream commit 855a631a4c11458a9cef1ab79c1530436aa95fae ]

Sometimes it takes longer than 5 seconds (watchdog timeout) to complete
failover, migration, and other resets. In stead of scheduling another
timeout reset, we wait for the current one to complete.

Suggested-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
Reviewed-by: Dany Madden <drt@linux.ibm.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index e53994ca3142c..af1d9d2150616 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2266,6 +2266,12 @@ static void ibmvnic_tx_timeout(struct net_device *dev)
 {
 	struct ibmvnic_adapter *adapter = netdev_priv(dev);
 
+	if (test_bit(0, &adapter->resetting)) {
+		netdev_err(adapter->netdev,
+			   "Adapter is resetting, skip timeout reset\n");
+		return;
+	}
+
 	ibmvnic_reset(adapter, VNIC_RESET_TIMEOUT);
 }
 
-- 
2.27.0

