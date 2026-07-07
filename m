Return-Path: <linuxppc-dev+bounces-23688-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5CBC43458
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2026 08:47:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gvZbx0rwzz3c2h;
	Tue, 07 Jul 2026 18:47:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783414045;
	cv=pass; b=EkSI073HrJIyQ1EhRLmUgaXH9FfFwFZucgTawRxrG3eqeAGUZeU5Xj4E01yUb6fKnDSaUQzikRAEOfh5DStL4vBLkRYnQRP69reWJOEIxhFKmXUg+61yvnC+goXOxD8Sykmg2xuK0pi/rw63QtZnTDo9wOoTxPtMGKmW8RC0oPLxDMFDDHQbBM0Q4zuThAX51xY5pAe4isoOUngijbMI6Rt7lRX/wQTNEcTjTnm/z+Bxb/5No3FmvWYm8raj1vpvAhvjLcjTO45k80+fG+9qsOqEV1p/6NGyeD61wHAiTfyHIWxikv6UX7iNfLpAw6Dj9d0rbIWcCcMzHWIkCbKBkA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783414045; c=relaxed/relaxed;
	bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WR2nFYxtkeRNVbaPReO3wYe+JrLqsGpVObTQeywYw4IwoCRBXaLvvBoXdfZp4ooIqkuiB8AxF5RL0LfL6Xh9uiVhquY/1gcPKvkdpWnd7zoj/6GWXnzp7XdS7iREqpHv8CN38j3q/TwUivLeK9z3XNgWiRMhwxOzBqQmZbNIn35m0B61ftMA+p5ZW3pcEJq44lnQly75Saq9ajkKP7Mm85DnnX+9tQeAOiGTajSbTAEPm+P70eDaiQ4+lOKoQ8SvXrLxshMXdesmD2wG8X5RDWzyR5OsmO3Un+kEE5UqHaykE2ZOEcSBv9bH7+0F9CEhdG4ytXvCODC9RR2wPw1uEg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dX3IQEB1; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=dX3IQEB1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gvZbw2sJ1z3c1w
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jul 2026 18:47:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adcTlW5xZEckMiJ/VTf9Alah6hv4iVdk9paDrR6xPczySKiCNUqxNdAnhbCps/PLPyZyZHkaDGlCF24aouMondZa031+bqSN5LezNcMp+xmFZAp0wCJN/TJqZqRRGbR5BnwS95iMrw6TbJiWtACcgYz7v8Hdr574xdoj7rpZpmruzCP9YlLS4xGTx9sVmCpQFF7hznQkeD4dGqyCxuMSV4dJivKQWabx49t7uad8SloYfFcU552p1qD0vgrJioDlVVzXDFpATF1HgqDxtTT/IBGnx4gJQJoyDH2WeuXtP+/LtJlEdhndH9h1ZCkuM+PSgzk3ebjK76qsYZZc04BOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
 b=vkVVdMCcS7t6xI156GLHzysVkPeSMdsfDGdV7KLqc8/jlhF52leofUntlzhGc/wlJzcee+YisaBZK+0TYgt7R5EZaH5/nh4Dd7VAEbuD8Ht0S25vQQoANLKUQGcTEtzZ895iWPw/jMVXawCZdqW1x+5AC8uouGOHxQfol6zuH3cQ3nd+IbIuSktiUpOt82Q6UOgyvVb+ZF6zDzslFoTIJyphFUOEVgMJ36G9mgGjti3KDfb7+LU551SiDSyid2xvI7G7b/0KYOA7uMWSwD37ycLGLJHeRYiIvaFCveFjdkdBHtNKrlFycYK3cSzw/o9ViAjy8djrzq7y9Ze1PlTqGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYjMGG0kvHDgPdRGauLzjXwroEFEnwIdqnPLvRwJK0Y=;
 b=dX3IQEB1FNEPE1NtPd8gnn3dWl7l2kMyhLfA5gvKg0UU4IaoVam8wJF9K/Qv4NV9lR7d71klj5UyRgzPT/+CYPn1pyeC0KMUfSzX8ygGhf+tuiEoTQGFUKMDfD8PahzEQLYfy9l8WRS0r3Q9CgmUoeO0979MtYQCXQhStNJWQsAvSVyd+bMlH/Wh+ap1L+2CKw8eFN3OEthW8vAg10fz8uhd415Z0rB2qoVRFoGUeSQFbO+uUauFOvGRITX+xxR8yk3uTG+3jJ1zhFLk55aQjRvSnXMVIgB2xxwzv6REmkhoYIMSxIMgS1WZpABl5M3lx131/QxThpRLDLjf3JaUuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DBBPR04MB7898.eurprd04.prod.outlook.com (2603:10a6:10:1ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 08:47:22 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 08:47:22 +0000
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
Subject: [PATCH v4 net-next 05/14] net: enetc: use PCI device name for debugfs directory
Date: Tue,  7 Jul 2026 16:18:25 +0800
Message-Id: <20260707081834.710730-6-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260707081834.710730-1-wei.fang@oss.nxp.com>
References: <20260707081834.710730-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DBBPR04MB7898:EE_
X-MS-Office365-Filtering-Correlation-Id: 42ea96cd-ce12-4484-a21f-08dedc045c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|19092799006|11063799006|22082099003|56012099006|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	3UorJbcpQvZJh/jjhZdXuPSUX0EaimqzyVYk6EcYnNZXZjXVuC1FEjaVIrqK4ElmdZzLUjEIihhw8wZHrMTyQZAL0AgRmuRN8cFPDO6mzG2mWX1YJ1kvas8wxQF313yio1E+wIFB+rHrlNfBlUWu4MCCCmWXn8vnnaW3A6iRbYOsBQorXt8Wl7YY0qHNwSDxiJts2F28zG/U7r4NSQRT8DBeZA87GBe9xSxYOONM+GGqlTlsStb4c/gr1bZHIXG49tRCo35wo0n5mO21u9a9UP1TVNIXvzFQ5JAy6qXTzrvWsFCiBjLs9VfqvypihVwRFt7BNTgffp37q37bcsDU4IkE6l02k5+RrSS7TRH5uUziCF/KIyfo32hXwdsWVuvxhP9GPoYhs7E7qEenZV5E/AKdSQPClqeSpR/EnDCzLerfN2fDHK+1kdUTpsQ69CuWZsapRHOZJUBMSE3+tEHYJdvHuXlvd7axbrIZQoJ8OIQE4X7Ox+OEu5SNbJbiau+gHF9d7sjQuI4SzzdzkP2s/fcpR9yev/aR/8m6uKT6ereNKAILYyEHGMxT/BtoO0zejIR5pL9okzC+dlLS1Q6m1obXjnCEHYbEgc2A9TK3a8RuloWh8ZyDjKGP3uriHjex7MEQf4jt6exH9zFrVCDbfMLfVBNrHzLmasKSzacGtHjHmcQco7CiuEvCAtVPsMEXciwxxQkcgWc9+tfgnf8hNw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(19092799006)(11063799006)(22082099003)(56012099006)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?riEN7tMdwLYlab0rqH90eRiBZFHEPvBFR/nLcxZMaUG0iFdedR+WwmzkyuZ9?=
 =?us-ascii?Q?6sIGb5z6NIuWGRwV11aJiLmimUQq5WNwBCC6YqBhitKw8UD0gun+UtDgO4u/?=
 =?us-ascii?Q?7vZrxZuRJXxSRPKaJ1iVTTJ/JfLTL6Iv0rN5hqe/2Yawrodc7gS//nD0Cemw?=
 =?us-ascii?Q?BlEj7VGBaxQ+Lov9MtmFlHv+vtIpni2vYR2muoU1DbKCw3ey1sZnV2zsgba1?=
 =?us-ascii?Q?CJDgQx8cl1hibZYo/GXv3mEe2EYT1XfpdDqJEUIzKH7R6Qc1kXkGdThPdLhy?=
 =?us-ascii?Q?RrKSv7Kji8JquBBGFOpW5/Vf218sW6n+d++8vHOFmz4qdiuZzsMs9lahooyU?=
 =?us-ascii?Q?F1y371G7NA6xb0FmbSIZxIDXORB/PbEYnfVe/J6foQyGhNhAY7NIldaDu0W3?=
 =?us-ascii?Q?ekLg0HVExI9O6KMWxZNzAOKIGWx0xLryLEG4i7lWgd/VkvGQsfFbssELNtZ7?=
 =?us-ascii?Q?56NnjHBQWxpuBH4iODZPhXhuno0XQT/BxM6QL1IMYIgphBm02FZSFPY4gU0P?=
 =?us-ascii?Q?uoN19Tl6J9zd8KZVTPZj4vdO4idVYyTYxKHF/11ZQNDu/zmzmgBg9pY7DB16?=
 =?us-ascii?Q?ZN53i5Ow48RxB0lG5f+9K3gsn57Ga7AZgT9VZqz/017scCH6kZT0mc3ka5Pb?=
 =?us-ascii?Q?HhK01QbdQEn0XIdVH/5fDniqlmJSaUqszXxiU3UpOJNP+YmS21HLrji+hLxV?=
 =?us-ascii?Q?iLOrNa4j2cJel/aMdZDHU7DufSXboP3WZ2MCgY1XWxEqmDy/tTKO/tppAhZd?=
 =?us-ascii?Q?8xMp/ztHGyitJbpQ2/9XHfXn+vJy/jT8WRzrebNfJ6r3XSTXvbqTxdGNYxFM?=
 =?us-ascii?Q?/EYu61wd8YS36vrhNhnwq23mVCgZItUv3xdxUQi+GsJmIy+E1aeLUKab96xN?=
 =?us-ascii?Q?dk68m8sLu3+3vLJFxL1tEBm5GDmRb36ri093ruStkHau7WCDD6sQRdmQFeMr?=
 =?us-ascii?Q?m/au22/ysahiIzjU3sOdVJ+Yv+QTQYxu7+BAL0Co/L+BKQ4JNKOu8BbDn1m/?=
 =?us-ascii?Q?ssV41diGOQdwp9rcjIx5ZLM9Y66OU+3lD3Dt0QcxV4Olzdm1jd3f/lMt3Gye?=
 =?us-ascii?Q?w3NLcdPSHNf4CJDld1Qc1Z9KAactJW6PNsUtxqqdNhjJRY45uoESKak4yQc4?=
 =?us-ascii?Q?CHWvpyJhlKVWN1z4rmgsOgPAdjWvitoQn3dbv7Qx23pSPj5gwJZFWb+mSgkw?=
 =?us-ascii?Q?WRrnznzRhkJJa8SjiVrFwaIMcFzgzBG2vZ9PBf4WW1gCrD8t5ip/19ZtwzEz?=
 =?us-ascii?Q?INyLAS1T0/f6y7kUGknn8GlmgO8PMuaF6S8N4WN+FOZmmWW4AClcoZA9flTz?=
 =?us-ascii?Q?yv9zIv7qeb9r1zmrcL07v7tkbPApfzWBeA4F9nEkWHZGhxxBoQ7/3SfaiRUH?=
 =?us-ascii?Q?qTrcHDRA4TF7mPDOTgfkR/DGIJoAR9Nr+8i/9jTK+iBEJB7Ffbc77KakooR/?=
 =?us-ascii?Q?g+Q1Wm6cHcHBImtZyZjfcTzg1Aj5Fvmq/6gvrP3x2p4C+hvE+zZwdo52HIMF?=
 =?us-ascii?Q?+flZ3nsqOp+HYacLwBCLwJ8JzOuDNt/6JKQiluXQNCGcP7be+nVuwgrCWrR7?=
 =?us-ascii?Q?bRfVOs2+idWKXqiQz91MDLykikHTvWAivo1+CznbeveLiuuBcs/irUXx11fn?=
 =?us-ascii?Q?FesWP2hyoscLduGVWa0g1IyZtAmwa+L39JmE2YTlBtLi8r4/ksdPkeI82/R9?=
 =?us-ascii?Q?1yfKHCvYAc60ftwwslQiDo9H0nGkrPxXBjrNWITnX5Ppi7vGEx91souYXs0k?=
 =?us-ascii?Q?/n93Lkf6xh5XfrYIQ+U2U3GfooBIceWkNMD99zGory9TPiEQva/D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ea96cd-ce12-4484-a21f-08dedc045c9c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 08:47:22.6181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5s1wq6MJSzFLkLtQ5+vkf8ObTCb5/5XBBzGAuk/8ZG6dU4Y+XDX0XFXGm28nNLLeWBcHiLFNDzSdTxeXa8eHXkSlB68F7Y1XKjQOqWkaq8yibu8ymKcAY5uUDhIXGet
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7898

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


