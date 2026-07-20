Return-Path: <linuxppc-dev+bounces-24430-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6529C44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:12:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PDd3FMqz3bp7;
	Mon, 20 Jul 2026 12:12:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513569;
	cv=pass; b=Jq8pbrukTmFP+906cOXKbCyCEkdXqShWCn4smec8tJ5C6S5uEsRQWD6nNyCfEeb0/39qATIJ4ZuK14ObWpx3k/r4caS9ZowXusbJlJxVNPKD7HWuTyni0EwYbRc/65y3X3IXQHoX5aqa4Tawv8UtXgKOuNZ2X5CQ8I7pELde86nOxFIGKXCVWpoDGoMGX6ncklV78/Ly/4rRBS7nOHslbQc1sAKhj8GyoQQU2FTJa7vKYWatqYaFWCn269HJttV2tRfYrMjnKZPa9/gil2mLZmGkDfMbf5K5245EAg/acK1xYvRcDBRZhdL4LzrtYV9/j1cfecw95wbDiGDs7buHjg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513569; c=relaxed/relaxed;
	bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T4hY/ZQaufRdjBlE3W6qrJa+ty5NBDBfJKdkRLdrpHnRfmszbU/TRUEvfzDrnyrvjHryWsfu8BToedASqblr7MyG6jqbjzlX4p5ELi3NCwXBytSi9Iyr4Q3PyLL8f8rVCvg+fwr+k2ckCxBGaETSCiLmHJTspqApYvJklf+jFy0lgjDmNAYUPYYg2ItcDe7qhF0cDNDpH9zhpEP2Q5FgBjJCw0HMfqtaCvC4hxL92hD107qLcQ4f8F8NDVTNHRZF+x5gLPd54dhtacC9UR4OIuRBoYYsLGL13qyh6LV764Lstu4iLkjT18igiAkuV+W5gyZOkTxDhfXLmrzZaxQvjg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=g2HXtJ39; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=g2HXtJ39;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PDc4nmsz3bgK
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:48 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m53H9INH3H34vilnFzdtHfpEoBHWoJdocPqI3fLg7IFuPn7l85nP98SFlL8w1Q9ib8qUzJ2rCZjkRq08vFSoVclBEhje69KVMUDDm474WEE49fvKEeXQkBKd9YQ8qHyOWjNhFd8tWqQ+9xZWSHm4uyHjuJRApo1RWph2EUhJtnlnHXwxRJx7Cxxs33JLp4jvFSJcoWXkzw9gxS1vJR5uxN7ynUe92BcpES+DdsgN57R/pl/BKZQVQ2HvT7180pf65C1GMvG4nF0NWXli0fJV0+XJepCIdMkWZlGieTP/63C4u8YPhdk3s23M8mUAeTXDgF9OMBP0NpJNrLJcNvqEFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
 b=ayPNP7NHigzl+qK2UKcSxBIbF3xThBxhw53MLw3Qw3g+nAtGpVs8R9bnjOxsgYxUA4RfcenWJq1yTiiu2/pwtuvIq802T73e6K3SI5kQvjRWes9tYqoLAXXJvPLMKCfVScScWe6DPcUa0Jk/e3ARUL8hzXhQfEMNJPrHvx6F8bsVLrlgWHfBe50CYq4ttVk+SZkiqa1FGcb+OJUjLiMJ+jcxFglrH++0x4UqRbgQ2YjzjGwCIHq5eLJfVZ13qvP34fM4pBoxRAVlSCisRL91DzEmWSdTq7nTXkW1W5vWeeJlFFIAkQfeFVV0PusqQttmZy/S8j+93SFE2U7d2FAtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
 b=g2HXtJ39GUW9eA9DMbPmRrJjBb2N4zPL975/aGAi+fH/avh+soRrvKXdJpCy/iXRdqCLkKC+tIwq1PN1Mw/+OTTADG502GVISEChmch89uSYyginfvfNdV46BENSZKIOLFRh6sClgQ0WkNsQ03BQ9yxJS9NnwinsWHOuSdKXmYvz/8JtCQOMVfK/UJyNp+NAecfg+8aSqj1vapb6n5AV0DxdyqpIT4Cs7MDBmb1EeqEnRGb5rAItxb6Wm5+pMANUuqJmoxUQZSJ1mWxFjU2kEoLcBFrUvFZdCBvHrAEdsFpDVCBmS0LWjo2IKKAn+d0dt9RpCOjmdtnkIqtHdlI2OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GV1PR04MB10872.eurprd04.prod.outlook.com (2603:10a6:150:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Mon, 20 Jul
 2026 02:12:24 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:23 +0000
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
	chleroy@kernel.org,
	maxime.chevallier@bootlin.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RESEND v4 net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Mon, 20 Jul 2026 09:43:07 +0800
Message-Id: <20260720014317.1059359-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0146.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::10) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GV1PR04MB10872:EE_
X-MS-Office365-Filtering-Correlation-Id: 272ddb9a-9cac-4335-63c7-08dee6045675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|19092799006|921020|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	yi1RTVtYfYzqFa3f3NHekULLU4xHtZy17va4d1poK7KBWpUpqsg2oFeyML3tvVy0y2/OHE0ihpN2wVOX74QBYeYfh26+mr4z+LFWgAbgk6qFmHIabEFuRkq2Z69evibc3U2amkc6j9YpZ+sVNo88vCSUiOh/dx0GKKB/Rmqe/ivn2pZRG6xzfrBIcsBT/KE64j/7IVBgFcGUCpuAtUEMDMGp7wOtJprM2VZtlC2Y40pnwDTr4nfIOi7pAW90No0S+2gNnBLoKWogKAMbGunIFQR3ARPnhngQpeRerTww9ZuSW7CC2r1+gZjOBA+C2kYvm32sB0mkuvvwB3s0xw2q5HbDjSJUIIVvSBinoePB9wZ26LGGEgj3Xg8oqOPh5lvOkZHlZ1q21wGliNxhfuxI8zsW9Azld1aAA237yWDzmpf+RbqZJiUCN4yPodayK4XdM1JPgBteysJgLqVnLGoKIJB7/pLbnW+bPdciXGloh/qTreSX5NKLANpx9OkD/WXQz3+LgASbBD1K/vMBQD3za0v37xlFzGtkZvnainTzGJ+A4Mvvg6shs47cO47a38PW6r1w6FPzmfu+hS55f49mu29HmYPzNK9NWWsseMOeiJysw3SjqKN1mtjIwKrJzQfiVzIBshO+kG6KRZBMmUi79OPPX56pb3C9NHAqEruPUuLtfMiy2p47qdWZoib1psYIdogD5CAIM8dqFvSkffCs8Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(19092799006)(921020)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hhHeuWhRAIvfsAJuNao/tfEdWuO/6SMOaNf3BRE28ysIdNZNq4/HpLrvRp4N?=
 =?us-ascii?Q?EWHvTvA2CwfB6p0lYQJu73lVzT731bNJzcoP9UW479nchKMvP/j4sCjdb6ZC?=
 =?us-ascii?Q?jF2byRj3bn/t6UapZ1lIlETgsa5QwMw8+JdwmCvsSYWxKUON+sqcXOtIo33x?=
 =?us-ascii?Q?Zy8B71jd97/3My8nFkfyfWvCn/95xgsoeULKS9az7fEpa4tQ8mS3jefOy5xm?=
 =?us-ascii?Q?fske7pJZ6SRD6I502vtOmcU9jZbJzkowv436gtsl4hwW2wCY842zZnOTi7Ey?=
 =?us-ascii?Q?eMoyiA3H3XL798togCV3G2JzOy4wnf3ewgQ4dK2Qpeo3U/w0CjN+0fkrWy34?=
 =?us-ascii?Q?UbC8ieHphB/Uk5+jAhNtt30ZQZEgdMZsUCbfBz+5RXLIDZuAZZZbxMS0mha5?=
 =?us-ascii?Q?FLFeI6xFVvAr6uvpWK1TIooPRYgg1K82N+kpN0CQGzmxRd8s08ou6qI6tILO?=
 =?us-ascii?Q?vOKcrul/D+98Qv5xWB70msFCZVG+OHk4WP4OXSjiY1kX91iHYXu8gOAkr/Y0?=
 =?us-ascii?Q?CL43eZyxK9Y4NdXQj9K6LoE+lZDd120dVq6Gk3BbeYvTbzUt46ynRD1Zsklu?=
 =?us-ascii?Q?MnZdGvxV5lNGRMTKJF5YBVr3/iM6wGf78/0qhuaTMnXqxxWTzDPBcwLgVzLZ?=
 =?us-ascii?Q?4jK45YUDcVhZbA4leLo3e8Osei8u2tI4EtEYuHREKuh9hTREcOR5LHO+bpZE?=
 =?us-ascii?Q?p8pqkqdt5zSp0iPM4tysC1SkSnQV6wiQWiaFV1KLyLH+bUmugPqfMctKhwno?=
 =?us-ascii?Q?Sj7HHdY8Jwfn9dzB99ONNeTyjxSjj3dj6FkZIjCCJZWD7j5NjwTmrQ1j7poi?=
 =?us-ascii?Q?PIGoDDf1ux9czSpUx2WwPJkT05cBWyDScPXlACmytcXGzyJgp1NOzIIE2Sen?=
 =?us-ascii?Q?z7r7ys15EczK69OnCVBX2i9opabW0jZuaiiReTTZZ4pqtf36vyDjYug1+YpU?=
 =?us-ascii?Q?XZrxmykMiZj4uMJKtSMqef2Jup0KjeeoXUbeNvnMVUeQ6NTu8iRcwnc1kcZU?=
 =?us-ascii?Q?AY5zI0japNmvHgLeyVQvWpz3iwFXEGqAI+J0QE7PTx/JWeN04Ese9+KWtUdz?=
 =?us-ascii?Q?ALubwA3EY2yghqOVWhJSz9L96MpIuAyOhGO+HyGbP51NPE03hCY1v0G+uVbI?=
 =?us-ascii?Q?fNXZlCoBhR4Ra8yLQ9YsgjuIOPYLGqgvXMvBb+bkgRW4qfxcLGx74azM4Tok?=
 =?us-ascii?Q?U5jPDaeBHGwbCzXjPKRWeqhKnbmj4CQtA+n9kobwCkwFyhPHdfJawDjefLLE?=
 =?us-ascii?Q?LD27A4zeTYPRODAw2I1av+MEWXG+ibMOK9gelzIxjPJobfgL6SbfXJPnhfo6?=
 =?us-ascii?Q?fT77FWLYJQ9KEH8f/50t3wHmT0PTsrVqSr9tedYfKpn0nbLRZzAc4UGhrlan?=
 =?us-ascii?Q?xL1eMpZ+zhIbHdOTrO1k9gPt+BovbddsPapzMJrUKPbL/e8S0Hi8SpHW13SA?=
 =?us-ascii?Q?clHJNTMndbP/MEhcTDM3+owDAzTPSQpW3w2seeJJaTRIVbrK2KLccovSazX2?=
 =?us-ascii?Q?8IxOuB9YHJoJfP+KmGd+I6lGVdgt9mQ1eDX/wwtWHNuKkGz/CLH8vp/rMmuw?=
 =?us-ascii?Q?3wXv3DJTnNxShVG3JX77i4QvB0nFStsageTjmfUTavizCWTCIb/PffHzmezr?=
 =?us-ascii?Q?oNDC3K64rpMeVtFB/ctc/KrH9MX4htbViz8RWXD+4lmNAl84v1nlHZ5R9tiL?=
 =?us-ascii?Q?3JofoXu3Kim1Ha73eUtJJB7LHpxxoe0ODVSoSmvo9xjld31mowOXtMK7eejQ?=
 =?us-ascii?Q?eaQNFtv/YuX7GnG2f+p7DJgyqXUTVDjlu3vw1tngk3HW71khm5Xj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272ddb9a-9cac-4335-63c7-08dee6045675
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:23.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HU7OnV6Bt2hm5WhtIhq2jW29WKeDbRe9Yp3QmZl+DsbEDgiM8i7TBqF7WCkj7FcGSjPIlUgDjLwKzw62kWlQu/3tZ+Snwllm4i9fJbg36sGg20Cr0CfC+O5wjcxK/6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10872

From: Wei Fang <wei.fang@nxp.com>

enetc_create_debugfs() is called right after register_netdev(), at which
point ndev->name still holds the format "eth%d" (e.g., eth0) rather than
the final assigned name (e.g., via udev rules).

Use pci_name() instead of netdev_name() to name the debugfs directory.
The PCI device name is unique, stable, and available from the start,
making it a more reliable identifier for the debugfs entry. Therefore,
the observable debugfs path from something like
/sys/kernel/debug/eth0/mac_filter to a PCI BDF-style path such as
/sys/kernel/debug/0002:00:00.0/mac_filter.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
index 4a769d9e5679..be378bf8f74d 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_debugfs.c
@@ -81,10 +81,9 @@ DEFINE_SHOW_ATTRIBUTE(enetc_mac_filter);
 
 void enetc_create_debugfs(struct enetc_si *si)
 {
-	struct net_device *ndev = si->ndev;
 	struct dentry *root;
 
-	root = debugfs_create_dir(netdev_name(ndev), NULL);
+	root = debugfs_create_dir(pci_name(si->pdev), NULL);
 	if (IS_ERR(root))
 		return;
 
-- 
2.34.1


