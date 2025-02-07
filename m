Return-Path: <linuxppc-dev+bounces-5929-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B273C02198
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Feb 2025 02:00:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ypxxx0gRtz30T6;
	Fri,  7 Feb 2025 13:00:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738893621;
	cv=none; b=h6G/5FmdNgQKGW+YdrxpfivlwIBXC12z3RtffH8XSL5b9ZKFlb6xIsdOaQxLU074OrOyCEDD5EOR0ldKK51MSjFspacEp4/D//J9uMwVJbFx02CYuHnXLEMTqtXrKblhsGOOgBX92Vp93nDBkJOGOtcClxGg7TOEjIKGbX5rEigds5PVB7nRyPJ+osFcv9Mq93wuXlAizE+KMaJAdkieFFMRtaPTvF/leVsIysJA4QXlKthMIXB4UexSUlKX1+lHsYerT9kLphUqqgk8mUMxfwaAWVOBYr8TcCAJaKLf4V+HzEIGau65Ryrb3xLt4u4uUTSHxySZPXaazzOB+QZ0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738893621; c=relaxed/relaxed;
	bh=EWEPy0gRUh6TKsP3n+u6OpBmopCKhkQ7aLiLLVXUXVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hhr5QHFXYOXSU5PDYzphiEMbCPDonbjEtIFbmwjMG/KQ96wNc1xfiYt+gWd+RpMiIHuHCphNuIi8F7XPvv5wgl1LkRW07bllMjr3t6jMTktzGxouLbyFcYX/5/VD/LwIFpaNbOsmP0DJ36d1T6VDEqoHGV1HrOcDuSL3YYZqGOj3DWaDOFeFCiIUWc9de/LqVh6mL9oCDaPlu2x037MmKQSpSZ7/gBZjZR8uVULH+/Qv8LU3AQV0MtKSouKnuBxP/z6CQbXqKUlu2HWGG2u0YqRgOgSQrAuxw93Bevm7I1O2zrONsITAUDbxHdKTMJMqDg4PCnQ84W0Jr8r6GPfpfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhangzekun11@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=zhangzekun11@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ypxxw1P6gz30Sw
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2025 13:00:20 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YpxR8068dz22mXK;
	Fri,  7 Feb 2025 09:37:08 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A7731A0188;
	Fri,  7 Feb 2025 09:39:55 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 7 Feb
 2025 09:39:53 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <robh@kernel.org>, <saravanak@google.com>, <justin.chen@broadcom.com>,
	<florian.fainelli@broadcom.com>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>,
	<o.rempel@pengutronix.de>, <kory.maincent@bootlin.com>,
	<jacopo+renesas@jmondi.org>, <kieran.bingham+renesas@ideasonboard.com>,
	<laurent.pinchart+renesas@ideasonboard.com>, <maddy@linux.ibm.com>,
	<mpe@ellerman.id.au>, <npiggin@gmail.com>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <taras.chornyi@plvision.eu>, <edumazet@google.com>,
	<pabeni@redhat.com>, <sudeep.holla@arm.com>, <cristian.marussi@arm.com>
CC: <arm-scmi@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-media@vger.kernel.org>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <chenjun102@huawei.com>,
	<zhangzekun11@huawei.com>
Subject: [PATCH 8/9] net: prestera: Use of_find_node_by_name_balanced() to find device_node
Date: Fri, 7 Feb 2025 09:31:16 +0800
Message-ID: <20250207013117.104205-9-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250207013117.104205-1-zhangzekun11@huawei.com>
References: <20250207013117.104205-1-zhangzekun11@huawei.com>
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf500003.china.huawei.com (7.202.181.241)

Instead of directly using of_node_get() before of_find_node_by_name()
to balance the refcount of the device_node, using wraper function
of_find_node_by_name_balanced() to make code logic a bit simplier.

Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
---
 drivers/net/ethernet/marvell/prestera/prestera_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
index 440a4c42b405..5d10031bfa32 100644
--- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
+++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
@@ -378,8 +378,7 @@ static int prestera_port_sfp_bind(struct prestera_port *port)
 	if (!sw->np)
 		return 0;
 
-	of_node_get(sw->np);
-	ports = of_find_node_by_name(sw->np, "ports");
+	ports = of_find_node_by_name_balanced(sw->np, "ports");
 
 	for_each_child_of_node(ports, node) {
 		int num;
-- 
2.22.0


