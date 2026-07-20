Return-Path: <linuxppc-dev+bounces-24428-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7569BC44512
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Jul 2026 02:12:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h3PD65hd1z2ygX;
	Mon, 20 Jul 2026 12:12:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784513542;
	cv=pass; b=VKqSvHRKS6tZaOzk6k7Xb3TC6wzCCPFLJly3HtjoVaLuq1UwdaL/BFGpi8Jo+rsD5Wp9bkgLB+YWj13L5sEWW16SNa6vYcoVtlXgo0492QALqBZUzBH8AIzuX6bhhMzzQDf/NYICgPVlKog6ZU8+37JITJoUQb0SqtI28tHp4bueKn8B0Gj3u8NLozPCrgQb/YLe9gipjzmFp0f6v4lyKs7wwEGGpbx5chA9syD8R2h1d7+tyXcEjgEJ0+qiN4PKBK8tORVG5bCKWOEYocsBWmuExqP8mTZNSAtKYQDklB76utLjb3SszT+uXcM5nZhBPazG1zXSn+Rm58wxBWBnOw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784513542; c=relaxed/relaxed;
	bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AklGU/UBDuMWLbiXl0lsDKyhiCk0AzYN8X52sawMyto81FlMdYvbGfsyywwW6NLJQz3BdMDkO6hmq+GoLKF4N+9pIjT62QbD3D48HQ0nHGPU3JSM6Oot8LvARsoPCBcvB74Bnbxes6jsSkcDhXuLeAtTJpnuCEvHsYz4YRZNTVz8OGs0E6tuVE599xrAMcEa6JG+Frato9FkwMzSI0CBC7RJXKzQz/WiY5dJWqRoHOEDYTjy0FWc5TbEMyZ4XVO0CBoJ9OamS8tKhAabCWBcA0wEto1JybwoCrhGA5VznRmZg7HmW7kcYXbA1ERkM6Xx0h7A42niwq0CykDobiDLhQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QJrmBpNI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=QJrmBpNI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h3PD54k5zz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2026 12:12:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OktZU+AeaLz51Sxg+L+9yricI5p6lTIvRCJ7udra7humT80xeE3RdgqMaEUBoURbovfIW8vIiqRsOThIa/ozZL21BVgi/XxMAlg0mVavpp3rOHAtP/e86OrF3qmzhLmRSJ/9eRjEzTuA8To7RNubloOq/OxPrLRRVQHrhOEB9oAWaaQEw9eEt8t9xDjVu4hZDIRapQe/+9AI9QLL6Evm1Snopr0NxPin1zYrXFyVWK6wpysEZ9RpX3m3liIawQUC5ZHQiCJZr2Prg8HDV2iV3egqvOvCrRWYJvpBvx6dS/xPMUuCtve2d8RD1tuZJqpVYTszwMyIuNbJA+5MEptA8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=eUXM874VPGGrhzsvZcJoNSEHkT5jfLurg6s6mC6ag/6sN+N7GITY5Rs3qC04io7AMAixOCN9+YQkSy+B8jGm1H2yRUQ6Q837Cy+GSVve7DBXUjUsjlByJQGIzcaMGpkNEstO9yPgk+QcVIx4a6CnIgArH/bXyE8qdFnYzDLV6eYunXMvRWYJrKrL1sOTVXeWHjl8vwYOeL/JxVQCEthwT7gIYVdavQi6ULJJk/PVq96Hgl8ciaLrr5q69xcFcKXTaQNuNkseEipdFJb8zUxHZukuOJzYNvgrulf99zW4kaJYBpH4KGGZROdfsYjAdfAyzwn9oe/2pBCgnsDXAH5V8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldRiNBCOJWyFngcj13VgJQfJt1BIcjx0qrIGck3hjtY=;
 b=QJrmBpNI8A5toAnyKZ7Np7K0YudqWKOXyFdSI6XR3fQdRCX+Ldlht+GS6aBewTDR45PAlWuX747KKQrMRd0e7mJq4zojbL08/Did+mF3Mukj2+0WRhPf6LjxsqNKra/ELpYZlu6NAhgEJQcMEguknbijw6cg1U1DBjysdu6BYXmUimKzZ/Amgc5bTBT3Dk2GdbOHmvz8BoEZDnnmoz4ERWAbDg0dxBxbRjKcud1XqlXXXFaRnglcn698SmfFkQAIlTi+YnIVk6oNveNJTLd8i0LCxEhVOy9evc0ESSyUGM7RVT9BVMDUXPIJ2ffKISltr6GwMl4uSnapVLT13Zs3VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by DB9PR04MB11580.eurprd04.prod.outlook.com (2603:10a6:10:608::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 02:12:11 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 02:12:11 +0000
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
Subject: [PATCH RESEND v4 net-next 03/14] net: enetc: convert ndo_set_rx_mode() to ndo_set_rx_mode_async()
Date: Mon, 20 Jul 2026 09:43:05 +0800
Message-Id: <20260720014317.1059359-4-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
References: <20260720014317.1059359-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::30)
 To VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|DB9PR04MB11580:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3070cc-8a37-46ac-ab87-08dee6044ee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|19092799006|376014|7416014|10067099003|11063799006|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4JvNTS75cujnhpd1/dXksYTf9Jew/FyNJgX+86rjBkCBRkHeQcV2JIrYyiqV/AQXN/5LNX7CScS+NbqB2IogNZhONRe3iuUL/Fw+tXbaBK3bjRqFgOFD2TJWuXm02VIR1ehQK0a1wHAkci5mPOVzg0HCeKp17vQNXD3SYvhy+n7iz1iIeLhZ93YvFkTuQMj3LIRGF3uTdfPNPXwr5TwGCtue1/vbPYnL8a1LlkMudnCbmKEgrKklLBkm9UEL2MiOf6Il88jfDd9ltIasy27z9A7o8TYTxsdHOlMhRcjdHmaTczc9CRnM6YmpG6uHE7vZv5jRIT8kQVZxFiBbKGHXv0+/HYcKB02GouTzTJGkcI82A9lrj0m1/+ViZEm91P0rjExwDm66+WXnSjdwLYhd4392ouyhISA2FlL4MOprnHSlXkRt51cG6CZByjb1yiy4nI0C66l4Xa1R+ojMUrzUtsc9t4t0QkcbUhC/n2S48z9b0yAi4hGlFqPToAFBWfVZRSOj+8IXUKZnW32bLxKVGQ2xn/LNdwMOH9uALXWhFwt92og/q5IIelUyzqDNBxZPjed0g53fMsTp41DBfdMqyDPNpYJB6mvP47DbJ+lD0FHnYMxS4QxrAb1OkVOWvRYC0Cw1jSuuypsSOg0s8sYrikk5iC5PlN8/B6BHlEzxk9wd3u8uLL8/IEJyxh06fSbUXRPJiTeoO8QYa1gI4Gn9EA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(19092799006)(376014)(7416014)(10067099003)(11063799006)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+nF1LvMrQ/slL6k8Kcpxe8o1V+p7vLuUY/jqlrm+Q2774LOUWlRvSNfEKC2?=
 =?us-ascii?Q?gXkxDTfyTqwaPmQhn5eq9Gdz1ksNvLgP9uGclQnS3A5LdAqAw4j2bJDN5tC+?=
 =?us-ascii?Q?CrAzoJ8rPwo6fvVAgpbLXDIwySIWBGw3Ad0AHxxTBMs6u0BdBS9kA6ZFO6fb?=
 =?us-ascii?Q?PiLYHg2MZUGltqoxPajga6c4lT8PB9M+Uwmi1iL4O4+GELKwuGHugQRnNW95?=
 =?us-ascii?Q?zznK3CwuSDPN2J93yGSM0YwDmshY5/ipyvNUpv46HaZA0hPOuMi9Vs9E4v1R?=
 =?us-ascii?Q?bDPAk+Xcxr1HpaHEJr+kgsYWANnDQjL/AQSYP5XsV1o2uZbFozXkiLjPUbo4?=
 =?us-ascii?Q?D4dzSzDJkllohhhvkhWPcYm2FDItRk/7h213XADHRQBpeJsnDssE2YP57YU9?=
 =?us-ascii?Q?BH+APP3D4QY81ktbj3C1IMQEOnhv82f3DD7Tz3x+jXmR2kGvZzgdS+8oFkXg?=
 =?us-ascii?Q?w1h0k+MnOlUC9UYG3FLo7PaEFGHblcocbc7bI/7Dslexil9BaBsIna7Vmisp?=
 =?us-ascii?Q?JH9IBvQ0ZehzZGHWuNGRgaaP27gdNptwDFDeRc4PAMZVHZo7y/jVvdIA/j4K?=
 =?us-ascii?Q?doIP0ifz5cYUqO28mI8p8XZmG466nlPK5l0fbvrj3p8JsNGN6Vlfk7OOrg1u?=
 =?us-ascii?Q?bCjfeDjQllCcHXlS7k/T75Xg82O+77qDE4EGcJwHrns6uRsoHkbaaNO3i4LL?=
 =?us-ascii?Q?1/8uQc3+5KPrXQjZvYReLdXgfxl+zcXYzuIshA9aaObBg0QmRR9ONyAdzwxx?=
 =?us-ascii?Q?4tdpTrXr6kzYJPP5q/iCIu0AAUNOntgAm6L3k0n3mBfv/GCJNI2tt0YTKo5b?=
 =?us-ascii?Q?HwZAblHHY3x50sasOeFUW6rRGGraJh1PB5mxpvfv2Xt8Ipd9i0J45CYT2ylO?=
 =?us-ascii?Q?3pSo8wzHX8v/y+Hyx84q6C24VOm/pqjBH3S9UDHcKDb85OWM2r9aKlg7TQa1?=
 =?us-ascii?Q?Kvxyn7mpa3DgoVZRykn9l7MRWAns3JwTIglJ8zHDAJdAGoc9GZVM7ZD9V5sc?=
 =?us-ascii?Q?PBoHg04D+lG2xEic9iPZktM17lHgeFY0p12ZVtvIkj4V5lP8/ng9tsPnPurQ?=
 =?us-ascii?Q?tfmsKA1Dj6OsyyaSAUfdzbkI21xdnU8C+UhtQfCBsDvJLnkR3reemt82JeSi?=
 =?us-ascii?Q?unviPKw/Ie9+tEsG2lMXkzCXlVSNKQEJVAponqmSTI/abmkuhz+7A12Km4Sx?=
 =?us-ascii?Q?tRlxmsrEKW1kfysfyzO8ZMamY4g/tFF+E23WoytW4MFOlJ6ZaVxPId+M23rW?=
 =?us-ascii?Q?is5U5jgvhS9O5lAEOlqEhV9Xxi6RvAIxoc5oOg4HlEvMfnciuHent56dqjRH?=
 =?us-ascii?Q?+dSgL/GeDNCVMywRYAtD3bTh3zeZPxjnX6TTb85IekumN8j25A+Jfh6kfM9D?=
 =?us-ascii?Q?S8Rys8Aqn+S5ma2+QoxuA4GUvk4zbbMhe3K5Ulci89RL47DGmSo07d/v1B0u?=
 =?us-ascii?Q?x4kZgAVrAg1eTBzPZ4LMR/Af/jTFgurNtA3b6Nn5SxrQllPnnrJ6YOoeMeRi?=
 =?us-ascii?Q?2BAAmX2szmRWHmgUIagZzppygxsU8VjR7CIt5RDmlN+i4XjIBj//o53u6z7n?=
 =?us-ascii?Q?fT8+3lsnSmvi6j1TFWnO2xOgGgBoRtL6A3JBxE8Fp36j+uXlVe9NLw8shovB?=
 =?us-ascii?Q?qCTAz1fVh6DS/68GXn090f5f9UYRiVj7v+JmSupz6vf6+tVUf5JoBXnCmGBl?=
 =?us-ascii?Q?jFerrb8N5JcJ+MP9aA0ZjqwxByeztZihvilrSGoYky8xPh4j1JzzCTSfe0zi?=
 =?us-ascii?Q?fv6LkHNerIY4/V+Y3F9Imwr97xW2Kl9cOKNxXVSiCOw42UpGMQ+J?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3070cc-8a37-46ac-ab87-08dee6044ee8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 02:12:11.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NM8/7gmTjUwULLt+Fqb2Tf29NwZ4XBgtVwVGFaL/M9UKhauT3JGZQw9xFYUM+DIxJtPQT9cazfh7Hog0ThGoVPgx94mRDZO0qrSCdKjToBfmQrgQsZo93dI2TWfTXtWb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11580

From: Wei Fang <wei.fang@nxp.com>

The current ndo_set_rx_mode() is called under netif_addr_lock spinlock
with BHs disabled, which prevents drivers from sleeping. To work around
this limitation, the enetc driver uses a dedicated workqueue to defer
MAC address list updates to a sleepable context.

Since commit 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and
netdev_rx_mode_work") introduced the ndo_set_rx_mode_async() callback,
drivers can now handle address list updates directly in a sleepable
context.

Therefore, convert the enetc driver to use ndo_set_rx_mode_async() and
remove the dedicated workqueue and the deferred work item accordingly.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.h  |   2 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 178 ++++++------------
 2 files changed, 58 insertions(+), 122 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.h b/drivers/net/ethernet/freescale/enetc/enetc.h
index 04a5dd5ea6c7..06a9f1ee0970 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc.h
@@ -324,8 +324,6 @@ struct enetc_si {
 	const struct enetc_drvdata *drvdata;
 	const struct enetc_si_ops *ops;
 
-	struct workqueue_struct *workqueue;
-	struct work_struct rx_mode_task;
 	struct dentry *debugfs_root;
 	struct enetc_msg_swbd msg; /* Only valid for VSI */
 };
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 48a74db90ed5..a02b01753ff2 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -101,24 +101,23 @@ static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 }
 
 static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
-				      struct enetc_mac_addr *mac,
-				      int mac_cnt)
+				      struct netdev_hw_addr_list *uc)
 {
 	struct maft_entry_data maft = {};
+	struct netdev_hw_addr *ha;
 	u16 si_bit = BIT(0);
-	int i, err;
+	int err;
 
 	maft.cfge.si_bitmap = cpu_to_le16(si_bit);
-	for (i = 0; i < mac_cnt; i++) {
-		ether_addr_copy(maft.keye.mac_addr, mac[i].addr);
-		err = ntmp_maft_add_entry(&pf->si->ntmp_user, i, &maft);
-		if (unlikely(err)) {
-			pf->num_mfe = i;
+	netdev_hw_addr_list_for_each(ha, uc) {
+		ether_addr_copy(maft.keye.mac_addr, ha->addr);
+		err = ntmp_maft_add_entry(&pf->si->ntmp_user, pf->num_mfe,
+					  &maft);
+		if (unlikely(err))
 			goto clear_maft_entries;
-		}
-	}
 
-	pf->num_mfe = mac_cnt;
+		pf->num_mfe++;
+	}
 
 	return 0;
 
@@ -128,23 +127,29 @@ static int enetc4_pf_add_maft_entries(struct enetc_pf *pf,
 	return  err;
 }
 
-static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
+static void enetc4_pf_set_uc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
 {
-	int max_num_mfe = pf->caps.mac_filter_num;
-	struct enetc_mac_filter mac_filter = {};
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_addr *mac_tbl;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[UC];
 	struct netdev_hw_addr *ha;
-	int i = 0, err;
-	int mac_cnt;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, uc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
+
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_uc_hash_filter(pf->si, 0, hash);
+}
+
+static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *uc)
+{
+	int mac_cnt = netdev_hw_addr_list_count(uc);
+	struct enetc_si *si = pf->si;
 
-	mac_cnt = netdev_uc_count(ndev);
 	if (!mac_cnt) {
-		netif_addr_unlock_bh(ndev);
 		/* clear both MAC hash and exact filters */
 		enetc_set_si_uc_hash_filter(si, 0, 0);
 		enetc4_pf_clear_maft_entries(pf);
@@ -152,79 +157,42 @@ static int enetc4_pf_set_uc_exact_filter(struct enetc_pf *pf)
 		return 0;
 	}
 
-	if (mac_cnt > max_num_mfe) {
-		err = -ENOSPC;
-		goto unlock_netif_addr;
-	}
-
-	mac_tbl = kzalloc_objs(*mac_tbl, mac_cnt, GFP_ATOMIC);
-	if (!mac_tbl) {
-		err = -ENOMEM;
-		goto unlock_netif_addr;
-	}
-
-	netdev_for_each_uc_addr(ha, ndev) {
-		enetc_add_mac_addr_ht_filter(&mac_filter, ha->addr);
-		ether_addr_copy(mac_tbl[i++].addr, ha->addr);
-	}
-
-	netif_addr_unlock_bh(ndev);
+	if (mac_cnt > pf->caps.mac_filter_num)
+		return -ENOSPC;
 
 	/* Set temporary unicast hash filters in case of Rx loss when
 	 * updating MAC address filter table
 	 */
-	bitmap_to_arr64(&hash, mac_filter.mac_hash_table,
-			ENETC_MADDR_HASH_TBL_SZ);
-	enetc_set_si_uc_hash_filter(si, 0, hash);
+	enetc4_pf_set_uc_hash_filter(pf, uc);
 	enetc4_pf_clear_maft_entries(pf);
 
-	if (!enetc4_pf_add_maft_entries(pf, mac_tbl, i))
+	if (!enetc4_pf_add_maft_entries(pf, uc)) {
+		enetc_reset_mac_addr_filter(&pf->mac_filter[UC]);
 		enetc_set_si_uc_hash_filter(si, 0, 0);
-
-	kfree(mac_tbl);
+	}
 
 	return 0;
-
-unlock_netif_addr:
-	netif_addr_unlock_bh(ndev);
-
-	return err;
 }
 
-static void enetc4_pf_set_mac_hash_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mc_hash_filter(struct enetc_pf *pf,
+					 struct netdev_hw_addr_list *mc)
 {
-	struct net_device *ndev = pf->si->ndev;
-	struct enetc_mac_filter *mac_filter;
-	struct enetc_si *si = pf->si;
+	struct enetc_mac_filter *mac_filter = &pf->mac_filter[MC];
 	struct netdev_hw_addr *ha;
 	u64 hash;
 
-	netif_addr_lock_bh(ndev);
-	if (type & ENETC_MAC_FILTER_TYPE_UC) {
-		mac_filter = &pf->mac_filter[UC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_uc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_uc_hash_filter(si, 0, hash);
-	}
+	enetc_reset_mac_addr_filter(mac_filter);
+	netdev_hw_addr_list_for_each(ha, mc)
+		enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
 
-	if (type & ENETC_MAC_FILTER_TYPE_MC) {
-		mac_filter = &pf->mac_filter[MC];
-		enetc_reset_mac_addr_filter(mac_filter);
-		netdev_for_each_mc_addr(ha, ndev)
-			enetc_add_mac_addr_ht_filter(mac_filter, ha->addr);
-
-		bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
-				ENETC_MADDR_HASH_TBL_SZ);
-		enetc_set_si_mc_hash_filter(si, 0, hash);
-	}
-	netif_addr_unlock_bh(ndev);
+	bitmap_to_arr64(&hash, mac_filter->mac_hash_table,
+			ENETC_MADDR_HASH_TBL_SZ);
+	enetc_set_si_mc_hash_filter(pf->si, 0, hash);
 }
 
-static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
+static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type,
+				     struct netdev_hw_addr_list *uc,
+				     struct netdev_hw_addr_list *mc)
 {
 	/* Currently, the MAC address filter table (MAFT) only has 4 entries,
 	 * and multiple multicast addresses for filtering will be configured
@@ -232,15 +200,16 @@ static void enetc4_pf_set_mac_filter(struct enetc_pf *pf, int type)
 	 * unicast filtering. If the number of unicast addresses exceeds the
 	 * table capacity, the MAC hash filter will be used.
 	 */
-	if (type & ENETC_MAC_FILTER_TYPE_UC && enetc4_pf_set_uc_exact_filter(pf)) {
+	if (type & ENETC_MAC_FILTER_TYPE_UC &&
+	    enetc4_pf_set_uc_exact_filter(pf, uc)) {
 		/* Fall back to the MAC hash filter */
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_UC);
+		enetc4_pf_set_uc_hash_filter(pf, uc);
 		/* Clear the old MAC exact filter */
 		enetc4_pf_clear_maft_entries(pf);
 	}
 
 	if (type & ENETC_MAC_FILTER_TYPE_MC)
-		enetc4_pf_set_mac_hash_filter(pf, ENETC_MAC_FILTER_TYPE_MC);
+		enetc4_pf_set_mc_hash_filter(pf, mc);
 }
 
 static const struct enetc_pf_ops enetc4_pf_ops = {
@@ -467,17 +436,17 @@ static void enetc4_pf_free(struct enetc_pf *pf)
 	enetc4_free_ntmp_user(pf->si);
 }
 
-static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
+static int enetc4_pf_set_rx_mode(struct net_device *ndev,
+				 struct netdev_hw_addr_list *uc,
+				 struct netdev_hw_addr_list *mc)
 {
-	struct enetc_si *si = container_of(work, struct enetc_si, rx_mode_task);
-	struct enetc_pf *pf = enetc_si_priv(si);
-	struct net_device *ndev = si->ndev;
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct enetc_si *si = priv->si;
 	bool uc_promisc = false;
 	bool mc_promisc = false;
 	int type = 0;
 
-	rtnl_lock();
-
 	if (ndev->flags & IFF_PROMISC) {
 		uc_promisc = true;
 		mc_promisc = true;
@@ -500,17 +469,9 @@ static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
 		enetc_set_si_mc_hash_filter(si, 0, 0);
 
 	/* Set new MAC filter */
-	enetc4_pf_set_mac_filter(pf, type);
-
-	rtnl_unlock();
-}
+	enetc4_pf_set_mac_filter(pf, type, uc, mc);
 
-static void enetc4_pf_set_rx_mode(struct net_device *ndev)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct enetc_si *si = priv->si;
-
-	queue_work(si->workqueue, &si->rx_mode_task);
+	return 0;
 }
 
 static int enetc4_pf_set_features(struct net_device *ndev,
@@ -540,7 +501,7 @@ static const struct net_device_ops enetc4_ndev_ops = {
 	.ndo_start_xmit		= enetc_xmit,
 	.ndo_get_stats		= enetc_get_stats,
 	.ndo_set_mac_address	= enetc_pf_set_mac_addr,
-	.ndo_set_rx_mode	= enetc4_pf_set_rx_mode,
+	.ndo_set_rx_mode_async	= enetc4_pf_set_rx_mode,
 	.ndo_set_features	= enetc4_pf_set_features,
 	.ndo_vlan_rx_add_vid	= enetc_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid	= enetc_vlan_rx_del_vid,
@@ -983,19 +944,6 @@ static void enetc4_link_deinit(struct enetc_ndev_priv *priv)
 	enetc_mdiobus_destroy(pf);
 }
 
-static int enetc4_psi_wq_task_init(struct enetc_si *si)
-{
-	char wq_name[24];
-
-	INIT_WORK(&si->rx_mode_task, enetc4_psi_do_set_rx_mode);
-	snprintf(wq_name, sizeof(wq_name), "enetc-%s", pci_name(si->pdev));
-	si->workqueue = create_singlethread_workqueue(wq_name);
-	if (!si->workqueue)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int enetc4_pf_netdev_create(struct enetc_si *si)
 {
 	struct device *dev = &si->pdev->dev;
@@ -1036,12 +984,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	if (err)
 		goto err_link_init;
 
-	err = enetc4_psi_wq_task_init(si);
-	if (err) {
-		dev_err(dev, "Failed to init workqueue\n");
-		goto err_wq_init;
-	}
-
 	err = register_netdev(ndev);
 	if (err) {
 		dev_err(dev, "Failed to register netdev\n");
@@ -1051,8 +993,6 @@ static int enetc4_pf_netdev_create(struct enetc_si *si)
 	return 0;
 
 err_reg_netdev:
-	destroy_workqueue(si->workqueue);
-err_wq_init:
 	enetc4_link_deinit(priv);
 err_link_init:
 	enetc_free_msix(priv);
@@ -1070,8 +1010,6 @@ static void enetc4_pf_netdev_destroy(struct enetc_si *si)
 	struct net_device *ndev = si->ndev;
 
 	unregister_netdev(ndev);
-	cancel_work(&si->rx_mode_task);
-	destroy_workqueue(si->workqueue);
 	enetc4_link_deinit(priv);
 	enetc_free_msix(priv);
 	free_netdev(ndev);
-- 
2.34.1


