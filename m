Return-Path: <linuxppc-dev+bounces-23174-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB629C43458
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2026 07:50:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gqFgF2K3Jz2ybQ;
	Tue, 30 Jun 2026 17:50:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782805817;
	cv=pass; b=RCsUnvOxDetQAPPAkFZ6SEACxkGXdZOwiz2E4byd/LL4qfBTkH65Qp2lcK7DMuCvG9lZA8NMQ4HzVS/Mdj2jw0zjJ+Wu7KM+vJcyF+bJvuIx4aF/BuWUQeJfyQvHarI4ABUBXL/PBVdV4wNwOVVOzTmISWKQ4Jia2y7Ht2BEVgJoglRErNqUYtAmmtizwtAVMjx+Hkd4RXqwuAx7FR7ZMcF0plQyKYt9Q/X7Nh2foZCebk539ZTmnGeGNnYnJ6wc1gPkFqXcdAYC2J/5H3RurF9rsAwSdZTXoP1HciyqflDe2W5gWNCslzsr1uijlVtRoK+AYgBRYUpdxPV96Nizmw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782805817; c=relaxed/relaxed;
	bh=hr483/LNKuNYbsM8vV+cU3zg/81XVRtl6ysav6ko9vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gi5iRBZJKfOgyUF6fNXUZebtTMq5pre+/j4UQZoO06caGeBa1RQKHjRgLhR5GY3uaGtw+A7z5g28jN35FY9XiKAj6oRz2Hip2JEFuahwZGiBYFBMNU3Lf8uFlr9m9KIaCNEp2Y1EkJJnt72O0WyiimvccBKUfslYILXIsvd78qBvjxULP9CApvfgfo2lE4iQ3BmrzsR27PXydPtniAZzG+q9NS3qnvUw4FG+2SNjje7OnESpcdjG2MAEe25n0CAIw7mdnJphhobHgXevqK63go1/QZ6Os+OYcRC+zM5+JRKC8gUf8EAMOSO5UeL5GjAHWCNPefNO5LwMJARotu8BzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GMChrfeq; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GMChrfeq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gqFgC38Hyz3bqW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2026 17:50:15 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctnpHcF/5hcNZI4ZetP6deHYdPXt0FK4qnhSWdVsq65KWHBqJLnlnqahcNfc282E6BAVPHfhBmkn3MdznWAKv67+pcUqjdbm+999KwvMRvhQuR2mPBMKNk+qK21Cuo6pt6ObK21ZGoxW0uF5Ap3b/eIOI315LGI/Cc1trJ9LM1rV2QjH36LTxmmfMiXlUJcYAdMHCR2+e7wbp3XSbPwhCDlByGS7OujNbc8hoImtrn5xzyHSWIbiZx7odqSAOs8LkZtbQzthcXX8Fgiw451sMx98eFFEb4C13XYwf8uP8g2svvY5V9asUdCjWF8r13vde1xhnLWEzVbBs3LoG7dJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hr483/LNKuNYbsM8vV+cU3zg/81XVRtl6ysav6ko9vc=;
 b=UzCrkUwEHd9U+Se0+DO9TTtToF/kud5Hgw4Ck3BdfjZuDseeTsregK0KaSIp/aMIpmkIOKy3cu6zifgFsazPW0CkJ/hrr9u+pzdb+QHOTaHDbpL9fHmyZhyUy3617jqoI0L2gr7FPnqSKk6tjBha6YFpwRvUhs8BhUmVdxzUg/BHz7Z+s02vLbXTRjdr09N+hArS8bNtDxwAYV+TGiClFOS3Eib9om3kwa9tmEBVHAX1OnUa3LeiTaqo8lkomhmDzAR1BRcRUTkzLhaCQqympgGAb4PfmnYR8auMaEBuEUp4a96WNlsjmQ1CqPOZuRO6jdjgQqnevlaDhbtKMjftBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hr483/LNKuNYbsM8vV+cU3zg/81XVRtl6ysav6ko9vc=;
 b=GMChrfeqEwTQoRoJL7wioAy2jK8jZtZgJpjkQBTDIfgq9lNIHBpdFUa3XxXZGIyB8QtNimfmXWyEW+wAUu9DennPxwpqwgk/X9gHG20cKsefjda4Lttr/FBB04jNwgmo6LmVWvSR211hkPr1HajTzzjesnwu/ok83Ju7FSK41dySOyzZAocM4S4nUyEGyzf1QAikzyxh7r0bjwXB81Ea7BzbORQggi6eOmKyCoJ8vR8UpsDF9w1njuAQ39ynCQTw1HhH8IxPuBSqOXoBGWOZdC+Liojpenpw0SKN5K/fibjE9fRRgbspYfPM2v7gmRsqN23MG1dgoEgz+2PMrvHPcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DUZPR04MB9918.eurprd04.prod.outlook.com (2603:10a6:10:4db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Tue, 30 Jun
 2026 07:49:54 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 07:49:54 +0000
From: wei.fang@oss.nxp.com
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	wei.fang@nxp.com,
	chleroy@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next 13/14] net: enetc: use alloc_etherdev_mqs() to create netdev for VF driver
Date: Tue, 30 Jun 2026 15:20:35 +0800
Message-Id: <20260630072036.382761-14-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630072036.382761-1-wei.fang@oss.nxp.com>
References: <20260630072036.382761-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0183.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::16) To VE1PR04MB7216.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::22)
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
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DUZPR04MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: d92c7c51-aba1-4dee-0e74-08ded67c2c6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|1800799024|366016|921020|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	qlHag90bU9XdzncZ+b2TFsUWza02nA4ogwhaqrwbdUz96EJNGQao+bM7wiYcVcXAjUEtETTA8RLV0QEYS4lq/zm7GzlOxsNpZhv8EYnzLSMsxx8ghPwrq3x+uuklh8OsT/weMOcEhJIlM+7kVTW+mrdIW9W0/d+QqB1albT0SaAghLsq/z7F4ZAUQeuTbty5mrEeipejU0MtrThjJUVLIPj0+Ub2oND8dIf3OWVNVgrX0X9IoiCSQ1hPacoEjEICM/7Yw6W6fKpcDHp+46rT0k+YZAql750EzK0/XH4ri6f0XH7ApW8C3577SlOU66eQPDdm/x5o5KnF5zLhfDl2JwrDeiLA21tJeCHTQwJ9/zoQb9KILQetXhM6e/BfkSnK2S+685BezC0OPrsNf5vcHLkh6SgWg7XrVGlB1dcvhGGPI+4HXw+/f+0yzsuYLus68WcGMhuJEgftMtogPfMamj65cGTmnDrwR2kODY7ztrkuXmxLH/DB7aDKsCf5ZxYuUO4iiZxwpPuGRjt8loJuQlAphm1UloVQal27fgNpfCdsyXr7feJo4kDUbqEyTQF2u7j0uL79Pa2eNMIz7nyfYuG6/jlXOloUTo+gXKHdekFqLpPAFU1qe0WiWTcpKrsHNQ9OLhb6rTd+J8QT4vA8ZKj2k1F6xjhtNraIN9i3w3GBjbcCSNPf/Wu2ByYqGW8DqIkOWiv8iqoLPGatiCgVow==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(1800799024)(366016)(921020)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEqKahdVNjl2UKj56skSh9ekRkWHjdraWRDY3HIk9695a5F/EHZzhj7aYu7b?=
 =?us-ascii?Q?LSWFCAgKEhLxXJBondYiyXOfQbR5vY7m8/kE8iRyOwvNaQMAz6g02nY/82pg?=
 =?us-ascii?Q?RirIaPgwWoLuXPSUiXVve5r5lhlHuhjFnMZGq/vOOMIbdlkobJH7fp0skX7Z?=
 =?us-ascii?Q?1YCEeJ/m3hZ8Dp3YI24Ku23uzdrIJfa592RembV021ey9KOP+hvLwoQzeVFR?=
 =?us-ascii?Q?5/2/TU0q7Ggip9xylqUv5d9iSy/UYeQ6SBL1dPF8JBufNYJAhF14Wst8G6YQ?=
 =?us-ascii?Q?2dQPtrQZn8vCvkUnP3XpMgD5cRkir6ATNwbuxTy5uIuti6Ut5AU9NEMJ6Jqg?=
 =?us-ascii?Q?XuqSnQVnXD/M+MFs6agT0Qm9ljMJ0lH7zyfzvSdnCXdtPYreho3tysg9Mi1i?=
 =?us-ascii?Q?qyH08RcyqInnLxLTZw3glkOKb24qXj1fu2DSb3iJV1GWOvYS/8Ybvtxx7INT?=
 =?us-ascii?Q?ag+pvnWtk+MtkeB+xJ6zUgWML4Ww5JI0fj5h/usWy2fBVF3Eb5iUjAi+przB?=
 =?us-ascii?Q?kYZZmnZTzvCJuXUWL/sADsYrH/YeuiZv2RDvse5Tn3zKyT5ORGC1LTZUiVks?=
 =?us-ascii?Q?5alsMPnR9n1UA9dHJRDf1R6/5eCDBOWcDNdhYkaZGJIZvwA+bAdCmfM2YXSx?=
 =?us-ascii?Q?9gghGZbTHOPocYCE28XTUiamvVOm9SzzTMcq6vA+vqEan4Uom6K094JQKA63?=
 =?us-ascii?Q?MbSIJuRsSvTHRUPAaMLqiI2M1zBv4jqgX4O9sF+tEHleS/zOzGeBbXYGwmaS?=
 =?us-ascii?Q?ypnN3YyA2ZFQoDmV8WsQWxqj+kfh1nBI5JhfkMgHctRF3XWfJi/No5ZkZ8kq?=
 =?us-ascii?Q?essOTi43NE+T+/E1rgTQlnOzbFb6YJinxzbIgFOewlPxyMJa7IUYoN2ZZSVk?=
 =?us-ascii?Q?02ju72abOdVsisdf1UfK7hEv+dxvfJ3ivhxHj8qINBTAe30fu1j6JojreRGJ?=
 =?us-ascii?Q?FzRnPf+9lUhjiLg4TYy4qd+cE2xpcvkXLho88mW7sjn4iXwut3hgwnalWMp6?=
 =?us-ascii?Q?r07F3ICpaJBI+7+dIuVyjCfA6oppW/dn2rbhwh5d5FtdvWzzt6/KJQaSVBuy?=
 =?us-ascii?Q?Drz4un9R7PDQnjpc6Dwzvq7mo4ZJZu20kJ3VQPJyZ56w1/aS1ywEmCxmqQBv?=
 =?us-ascii?Q?n+g3BsolzRW6RvacuNNFyEG0oXhp2PBbPJKKySPxekN5GVX75Psc0pYfDXnl?=
 =?us-ascii?Q?ZBxqjYL8+evsOjK3CVG6Nq584pflXVFLlU+yhDnfDaeF7LZE6omqPKRs7Oqp?=
 =?us-ascii?Q?2PZU/iVRL6++I4LfVHdD9RfScjc33gkuDmMXXvgLZop2q+K4DiQoadsami48?=
 =?us-ascii?Q?YKQZxwIfS5hN8F37EbF4REsjBpkPldrUQhXkrQT7DPOBo0fgGrQ4pUQEdTw9?=
 =?us-ascii?Q?sshY9ZgNB7nTwAUIXtf0LBmbJqSzcV+xD5mooYDCRoxo+7rqMCRMsXyXCzfi?=
 =?us-ascii?Q?cdgIWOLirWQY5aAjrawd/K4ipumQCp3CIyuLmGoJ/7LomQl8LDC+xA49pr+u?=
 =?us-ascii?Q?MQ5nY5lR3grSZrQeyhern6blPS9jyeOXK1xzja5yppY6QNB6ntf2r6mw1snZ?=
 =?us-ascii?Q?rNlR6XiRqZN41WBHwAER0k/ILkKwR0jheQjX8phT+Xk7Kt5a9ONxTDfkXzsE?=
 =?us-ascii?Q?DWuqOoDv6b1omnViQ3ybYfIGLZ4PObiVfKP8cyuNudGEmJnuedn3/vIIsD0e?=
 =?us-ascii?Q?J3OZnHLpTU51aYIoX5GLhLv3MvP5Dte1ZkHpv+xjNJq9VdjdmbnaKOHSxO1d?=
 =?us-ascii?Q?+Yun8oXuHGk6hSLlBjc54qMf8BIEsJSOxvTKQdmK6MNAUN083nXt?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92c7c51-aba1-4dee-0e74-08ded67c2c6d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 07:49:54.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hwccpc6IAgvEgiQqPRWm/qF/IYXH7ej4h+L9F5LWwVDyMPCKDjVpEqVj4BCdAor1UIG2Iifxwqqn7otgtm1vBJQ1GVOKKyCTwqhhDfw1nC3prNY7y8eEzNZ6xtGe7L5s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9918

From: Wei Fang <wei.fang@nxp.com>

The VF driver uses alloc_etherdev_mq() with ENETC_MAX_NUM_TXQS as the
queue count, which forces the TX and RX queue counts to be equal and
uses a compile-time constant rather than the actual hardware capability.

After enetc_get_si_caps() is called, si->num_tx_rings and
si->num_rx_rings reflect the actual number of rings assigned to the VF
by the PF. Switch to alloc_etherdev_mqs() so that the TX and RX queue
counts are set independently based on the real hardware values, avoiding
unnecessary queue structure allocation when the VF has fewer rings than
ENETC_MAX_NUM_TXQS.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc_vf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc_vf.c b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
index 9cdb0a4d6baf..3df515a6e333 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_vf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_vf.c
@@ -317,7 +317,8 @@ static int enetc_vf_probe(struct pci_dev *pdev,
 
 	enetc_get_si_caps(si);
 
-	ndev = alloc_etherdev_mq(sizeof(*priv), ENETC_MAX_NUM_TXQS);
+	ndev = alloc_etherdev_mqs(sizeof(*priv), si->num_tx_rings,
+				  si->num_rx_rings);
 	if (!ndev) {
 		err = -ENOMEM;
 		dev_err(&pdev->dev, "netdev creation failed\n");
-- 
2.34.1


