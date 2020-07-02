Return-Path: <SRS0=FKTu=AN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311E3C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D9D620874
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 01:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUsvnQgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D9D620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49y0n96g92zDqss
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2020 11:26:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=iUsvnQgM; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49y0jJ4tBRzDqlg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jul 2020 11:23:32 +1000 (AEST)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 71A002085B;
 Thu,  2 Jul 2020 01:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593653010;
 bh=veRgKsegTkK+mGLSlUJksyux8IRzvf0/wRoMvomENGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iUsvnQgMbwLbTnH40KkwLIOH82/I842ScfwaXOH18hiM+at4JF1N0vXnXxgB43pL0
 Jj09pEzEbb8JhuJfsXkt+LaaZCu1IhNLdQv32g1ARsw/21rfvh1K6Z6RAxDOuKpkB9
 QY09pH8pCVGRGi0Lnjft1tuXPT2MEY+NJeU3MYv0=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 28/53] ibmvnic: continue to init in CRQ reset
 returns H_CLOSED
Date: Wed,  1 Jul 2020 21:21:37 -0400
Message-Id: <20200702012202.2700645-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
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
Cc: Dany Madden <drt@linux.ibm.com>, Sasha Levin <sashal@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S . Miller" <davem@davemloft.net>,
 netdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Dany Madden <drt@linux.ibm.com>

[ Upstream commit 8b40eb73509f5704a0e8cd25de0163876299f1a7 ]

Continue the reset path when partner adapter is not ready or H_CLOSED is
returned from reset crq. This patch allows the CRQ init to proceed to
establish a valid CRQ for traffic to flow after reset.

Signed-off-by: Dany Madden <drt@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 1b4d04e4474bb..2dbcbdbb0e4ad 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1958,13 +1958,18 @@ static int do_reset(struct ibmvnic_adapter *adapter,
 			release_sub_crqs(adapter, 1);
 		} else {
 			rc = ibmvnic_reset_crq(adapter);
-			if (!rc)
+			if (rc == H_CLOSED || rc == H_SUCCESS) {
 				rc = vio_enable_interrupts(adapter->vdev);
+				if (rc)
+					netdev_err(adapter->netdev,
+						   "Reset failed to enable interrupts. rc=%d\n",
+						   rc);
+			}
 		}
 
 		if (rc) {
 			netdev_err(adapter->netdev,
-				   "Couldn't initialize crq. rc=%d\n", rc);
+				   "Reset couldn't initialize crq. rc=%d\n", rc);
 			goto out;
 		}
 
-- 
2.25.1

