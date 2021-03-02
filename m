Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CDC433DB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 19:48:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0974B60201
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 19:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0974B60201
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dqnk130cCz3cZ8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 06:48:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.220.15; helo=mx2.suse.de; envelope-from=msuchanek@suse.de;
 receiver=<UNKNOWN>)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Dqnjf2VJXz3bVY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Mar 2021 06:48:06 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id A79D8AC24;
 Tue,  2 Mar 2021 19:48:02 +0000 (UTC)
From: Michal Suchanek <msuchanek@suse.de>
To: netdev@vger.kernel.org
Subject: [PATCH] ibmvnic: Fix possibly uninitialized old_num_tx_queues
 variable warning.
Date: Tue,  2 Mar 2021 20:47:47 +0100
Message-Id: <20210302194747.21704-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
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
Cc: Sukadev Bhattiprolu <sukadev@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, Lijun Pan <ljp@linux.ibm.com>,
 Dany Madden <drt@linux.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

GCC 7.5 reports:
../drivers/net/ethernet/ibm/ibmvnic.c: In function 'ibmvnic_reset_init':
../drivers/net/ethernet/ibm/ibmvnic.c:5373:51: warning: 'old_num_tx_queues' may be used uninitialized in this function [-Wmaybe-uninitialized]
../drivers/net/ethernet/ibm/ibmvnic.c:5373:6: warning: 'old_num_rx_queues' may be used uninitialized in this function [-Wmaybe-uninitialized]

The variable is initialized only if(reset) and used only if(reset &&
something) so this is a false positive. However, there is no reason to
not initialize the variables unconditionally avoiding the warning.

Fixes: 635e442f4a48 ("ibmvnic: merge ibmvnic_reset_init and ibmvnic_init")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 118a4bd3f877..3bad762083c5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5219,16 +5219,14 @@ static int ibmvnic_reset_init(struct ibmvnic_adapter *adapter, bool reset)
 {
 	struct device *dev = &adapter->vdev->dev;
 	unsigned long timeout = msecs_to_jiffies(20000);
-	u64 old_num_rx_queues, old_num_tx_queues;
+	u64 old_num_rx_queues = adapter->req_rx_queues;
+	u64 old_num_tx_queues = adapter->req_tx_queues;
 	int rc;
 
 	adapter->from_passive_init = false;
 
-	if (reset) {
-		old_num_rx_queues = adapter->req_rx_queues;
-		old_num_tx_queues = adapter->req_tx_queues;
+	if (reset)
 		reinit_completion(&adapter->init_done);
-	}
 
 	adapter->init_done_rc = 0;
 	rc = ibmvnic_send_crq_init(adapter);
-- 
2.26.2

