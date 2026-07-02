Return-Path: <linuxppc-dev+bounces-23350-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC648C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Jul 2026 03:26:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grMjk02qwz2yvB;
	Thu, 02 Jul 2026 13:26:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782962777;
	cv=pass; b=Tjs1i/QiWe63C5Rx4d3FOZnCtqruJf0yHJ5P5VoT5/Pa44NM78ACwJJK+C4pMRYODa/9D0QKgKw1wUFLP5C4szm8ZTII/pUQOntnx+VFC3RKi0Sl22cCBQADxYoA8ufZb2OkyYJ2xwm3YS9qKteMvCVaYPNJjUlRSdYvpm8NVFink3k33U9YXl1bvDUShUFI/J0mQ4Pyd3c/Fi7NoYrFaGbN/SXGsq2xb6SBPAKSVoZvuKUMA3s5ABdG+MlrssLew7wpLkWmbraYiWqsKpKs2ibtoJUB63vthwHzGmvQzD1EgTOYq9NEDb0po1KoIVRQrtZGrZoEoUoF8spL+kv+YA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782962777; c=relaxed/relaxed;
	bh=Gk15mS+pO4+D9IvQpnvHtyxfkR43dr6DcsxgqroyM4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iOQ3oxD2gafHBCL5UtY3R4IBPY41ZhLPDdsTgL2iVaL49MbQCYoQliHChberTcfM3ss1ZEzySZNpOQDxwHFHjNFa4TlgeSFw2/n1IXKGAjVhKu6pZNGgqufCCwyKlwltJFC8urFLUnEw7Jc1N3lE9jeg3YBF2HnxdiE281YcMyvS3QWaN8/GZ0uyFkfWTtoizq2/wb383Un7dhNkBYkbiMYKvQml4/e80zue5QYuEDVb1GPuFu9jZq6lKq9djDug05Uk7UktdrM4/vsGO/sj8RqWE30dnUwg39kGU0rJVVzZBm1lCEAORJgHl18yBZVd5iWVO4LLvAkIATXB65CACw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CuHWU0vN; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=CuHWU0vN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grMjj0F9Lz2yvY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Jul 2026 13:26:17 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIhjUIek06JMHE+s7j294oh1tTnFKA9CHY9K7YGzDbjbIos6XTaKIKHoRrozrivIOzJTxnJOa3WggnQc4FEKwarKQpr/TWWEbUHWLRzo2J1aVuhcXbleqDTIaTLz+X9CuGHxv28v55zTBym07N1wsp2l6VEKEQbjKD8X7zL2HIXn4Mc9mMUbDha6g+qrklUEjpkHGYyEfrfUwhDXMRfI1X4RT+2pIzTYzTWUWWwyrBbOHI1LtWV4vfKjV8zAbRKLfoLu2tir3MF+L8e57mWBoJM1+/ZjNlsCW/vmBFZ2J6Z5pzZ8yE6vi36F6YlJ64x1687e/JAERb/7Ia62btu7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk15mS+pO4+D9IvQpnvHtyxfkR43dr6DcsxgqroyM4I=;
 b=sswMrivtdKOAUk1FKA3WQv6XgaycAWqiUpmY43WEG1u67GVCU+Xsqk9BdivuIBCHsMQCKxIcnpZOduR74sfSCLKx7rhHfDk4l8hUM2gDwB0qaYJsEh23rxiAwgmiE95wj0FUis70fOiQ7+FWpY73LbzImOA6MTHVSsiYTC989aXyHjhg71f7TACVjVxgt+R8bRDHcbsPAC59y6+2f2TWarBfGxLcf6Y6vCTylrzhsy2Z+JYIgqjA19wg12pz39540jxxxfPLsgHW0ko9CDixkIzYrJEZs0Oo9c5BSfMkmtB8K4V7X8yLhj5lYKmIAuvvdyjqa45+RpYo0JHQRoAhng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk15mS+pO4+D9IvQpnvHtyxfkR43dr6DcsxgqroyM4I=;
 b=CuHWU0vNoSY2cmYvhyzvN0l16K3gyBdhsS7OVhPQvxg0dZqp4sO7EhzQXO+1kJBpzChX6KxhjHYw1yk4w+9GJnygBouYVc3jfH+7QTllnoJB0f2+s+2sgTeN+PH91lpZbCZ5zs45p4weL7hPiykzehgrYl8UV3tChCnx9FUewlAzYshTQ+FsAowDDmk7fIJ7xS3VcX/Hbim5ssYf2Wk9HHW8jCNWj6Ar9kPBQ+fCp744h0xu78tuotSqJCrSlfG73AIvSygguH/LZYUtDhH9tGEK0NFwLsZRPxMnLcT/3M1f8CTZCVQZD/9njZ5i/kTNGnEvV5vOqlVcX21OZx0dAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by GVXPR04MB10248.eurprd04.prod.outlook.com (2603:10a6:150:1c1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 03:26:05 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%3]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 03:26:05 +0000
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
Subject: [PATCH v2 net-next 08/14] net: enetc: remove invalid code from enetc4_pl_mac_link_up()
Date: Thu,  2 Jul 2026 10:57:08 +0800
Message-Id: <20260702025714.456233-9-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702025714.456233-1-wei.fang@oss.nxp.com>
References: <20260702025714.456233-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::7) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|GVXPR04MB10248:EE_
X-MS-Office365-Filtering-Correlation-Id: db959a9f-540d-491b-d807-08ded7e9a65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|376014|1800799024|366016|3023799007|921020|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Gq9zzBvMCo2shwF62ipPi/Mr/I9gxA+LoNC0CH9lAvWg+z6eKx6BxXAfSmYX79pJ9sWrHlPMQ+26n/8KXzXkv+mdoWJzaWonefWqw6YGSTg4euCzgp3zIZ/znfizi0ff4kfRAry5MZhBzFavRxWCfQDtti7cxt9TDUSBQKRgWVmPxbjYBTOE2aZbOriMAYzD/hk29PjSaxWi7/876KXqJdBq+8Xvu2oXZiB0a3MwEJOxEIwhB3IkPwNWCxz3SZZ0/qKexaLGUyUtkmAwgIvZQ1DwFRgm7+uGkoTuJo/dfice2R9tvYFySRGPsharYIvS5QkWbpQEKznO1zrb636OKe5knC7BsiN+Q0uracF3MZH+LtWpwIupfcbCBo3nSgg55Z22pqECPyWow9KBSsZsLcui9pm7j6H8o3KX/7lxkMalcQSFIVeIMI01l/oI7D7aE3pdz5gL4IIY9vbEIWs+74uedCx41aH98UxlVHhOCI9ZF/FS6l+r+D5oEi0RMq4ZRqy/6XrRLR5rSjBBT2FnuNIap+543L3r3BCF/RSlu64NYr8SGuR7WZ8bOoLvYyB+V6JrEMJVUZwEpIydXaIw4aWwZkhTaHRx6iLWyeDrtMtOsJtTiLzAC0mRZllx7Ry2vq9L5yObQmkXP31GkteKFFwyz/2JpCO0P901UzuUodvtU/ZnqAudBmG8beUQ9IoPojI/FrXeKLviPuSH3ub5SQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(376014)(1800799024)(366016)(3023799007)(921020)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xoFsBzG7zv0HqKBXmesEIxV9FhnWcTnalEMgYQPVbtX2t1xPGWSy2nJkFMP6?=
 =?us-ascii?Q?LSwOQlFujRfxHuw31GadncL2wUIUgIWLzWF9P1ut7pdEPx7yT192fBljwDKv?=
 =?us-ascii?Q?F2U9hLPQvLCcROCVKl+0q2KmKdypYzxG0cF+DrL85YXocw8MnX2zY6ofkj4r?=
 =?us-ascii?Q?jh5AYC067uwSnC29G2KAA2q9ixEn7+UrzsKVRFL8Jx3izd1ijCUerKcCRdJe?=
 =?us-ascii?Q?wxsAIPrfd/zjy31zupABk5SQC2qEf2gZVR7pMj13rMDJmejpnEa2V5dJajbV?=
 =?us-ascii?Q?OODtA/Mg82L42hjT9tmTFv7nozOaO46U+sbMUgraYp63/4LO7jsA49vKX9SG?=
 =?us-ascii?Q?B4RE6okKcX/rubPeMP20IJ+1cgyz7CcgnJuhKL+LxF1yjtg5nnuY2zHB3DeG?=
 =?us-ascii?Q?ZbTHcTb7a/JflxctQFuNLvuEEQb9gW5SssIEGuil3fZZy/dXeeIOIwlLoftD?=
 =?us-ascii?Q?bjgoGA5oqrPkuxpAb4Qb8zDWtPB2uwXltYPh6aw0yCVKprEU1zxorqYkcLAO?=
 =?us-ascii?Q?ZFXP1B3Nfuls8wiDg0Z2GPE1uL/DYoFDk01G5YZCub24B+MR4AbxP7wNFoTt?=
 =?us-ascii?Q?wL8wtWAmYbILtNGilW1xCixidQUjr2VwjzS6k+pfVRabg1ULg5+OVGHtZGaz?=
 =?us-ascii?Q?ESzwt7tOEgtddZpFymbWnU66fmV0I8UJvcNXHKTE01c9zF03kjLj7nI3/YoL?=
 =?us-ascii?Q?BNrZJDO9SpPBoHGlCX07YmUOKePLWA0NCpLBSqftCjrYK70n7woxutozETQS?=
 =?us-ascii?Q?8tr569rQo8NDZys4CjRk3ODpVftGlyqkQtS6fQPDDlpa9QP3eyVjLN+u9q1Y?=
 =?us-ascii?Q?Hh4k0u1U/dD7xEXzsghWI8tGYtYN6LmJsWhe5cojfWWbM78XiZYyzaoE2kzv?=
 =?us-ascii?Q?3L2ClRYGMLPIascT85Etn0jHcbLN8qEzNjgXhC4faMhZQBr97Lsb+wPDgt1G?=
 =?us-ascii?Q?XABKcKL8vQMkQ+/vJZzlsNursxI0rOPmpLYqRNWV5MIEvjI605lQcO4xwh8C?=
 =?us-ascii?Q?pxMKhHb+wvzlvLrAXQqeWDgL+BZKxC0zGQWndOd/VJTdq0bHRJTxZe1PtCxg?=
 =?us-ascii?Q?KKm85a1/UVpKsgp3tcszX9eYiv9np77mE/9oxBQJMTO0Z1Yiq/FKP6tZapAh?=
 =?us-ascii?Q?tm58FI4pSV6bC2V4bqeHyVpB83vRdBOKDhKpGXOk/NDCkIslkpSygDtnj1Xi?=
 =?us-ascii?Q?G4ZObc08cnQtpOE7BNZI0Aezq6KtOwZa0folCsDa2rRxuIZeytuE8Bxfmdgc?=
 =?us-ascii?Q?Cxl+nyEdTJKiFo8r3q/yz6vH421USfivyxBnJTdfGAxHEmfQsrfDcYFTrl1W?=
 =?us-ascii?Q?y9DkFP+XPg1mn3+7E6ADzuMFY7H06hWVxy1w+9k6xkpYOZt5+GGIzVogIwxz?=
 =?us-ascii?Q?sXPwogu9IVO9LtkqclPvLxJpyXPI8gqlywUFXv+sSxm0stDEkHXlWZzstFq7?=
 =?us-ascii?Q?qwwUcYeQSABi18Et+67QjQ2RNau4tCE1CRD0jD6jY1Yrd8azGE5rXIT3/MCY?=
 =?us-ascii?Q?HXsn4gIlMLcqWyGV6ZCTZAugepu9J0IFBwAXKMKml2Cj1Ji3O5dTxUOYjbgy?=
 =?us-ascii?Q?p4pMhZ2/yeIk7oAdWtUUe96eQR6wfMgDixRw7EZl+UJrQUrnx2DQiIyI/ubH?=
 =?us-ascii?Q?hwD9DyqKoxUC9b84mY7SmI7iX0mnjLLudAkp50yrYf5Ztj4cclLb/340rnr2?=
 =?us-ascii?Q?N60nFKPY4AHxlwjMfDEYd16R5/HyR+T97R+T63UosoxXfhx6tGIXohIyHubB?=
 =?us-ascii?Q?B0ieMofDx/9KhfDIi9IsswJaTOXTlAQBPty/03trc6mvB8NZ0t5L?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db959a9f-540d-491b-d807-08ded7e9a65e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 03:26:05.2984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgmHHQLEslAqkAIU0nXL48poD5GLi9zFVhPfR1nKVSGCJSzEzlrb0IlzAjbrj++AHFwxvq4VjF6rHYY+qXggiI9S3vUseqmid+qBB6na3/HhhD67EgPD7PQHP5jM6QCv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10248

From: Wei Fang <wei.fang@nxp.com>

When adding phylink MAC operations support to the NETC switch driver,
Russell King pointed out several pieces of invalid logic in the
.mac_link_up() implementation (see [1] and [2]):

1) Half-duplex backpressure is not supported by the kernel, Ethernet
   relies on packet dropping for congestion management.

2) phylink_autoneg_inband() is unnecessary, as RGMII in-band status is
   not supported.

3) TX and RX pause are disabled in half-duplex mode, so there is no
   need to override them in .mac_link_up().

The same invalid logic is also present in enetc4_pl_mac_link_up(), so
remove the invalid code from it.

Link: https://lore.kernel.org/imx/acEIQqI-_oyCym8O@shell.armlinux.org.uk/ # 1
Link: https://lore.kernel.org/imx/acEFwqmAvWls_9Ef@shell.armlinux.org.uk/ # 2
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../net/ethernet/freescale/enetc/enetc4_hw.h  |  1 -
 .../net/ethernet/freescale/enetc/enetc4_pf.c  | 35 +------------------
 2 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
index dea1fd0b8175..7a3ccc94b036 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_hw.h
@@ -198,7 +198,6 @@
 #define  PM_CMD_CFG_CNT_FRM_EN		BIT(13)
 #define  PM_CMD_CFG_TXP			BIT(15)
 #define  PM_CMD_CFG_SEND_IDLE		BIT(16)
-#define  PM_CMD_CFG_HD_FCEN		BIT(18)
 #define  PM_CMD_CFG_SFD			BIT(21)
 #define  PM_CMD_CFG_TX_FLUSH		BIT(22)
 #define  PM_CMD_CFG_TX_LOWP_EN		BIT(23)
diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index db7bad2c3cbd..a77ef62672c7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -588,11 +588,6 @@ static void enetc4_mac_config(struct enetc_pf *pf, unsigned int mode,
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
 		val |= IFMODE_RGMII;
-		/* We need to enable auto-negotiation for the MAC
-		 * if its RGMII interface support In-Band status.
-		 */
-		if (phylink_autoneg_inband(mode))
-			val |= PM_IF_MODE_ENA;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
 		val |= IFMODE_RMII;
@@ -690,22 +685,6 @@ static void enetc4_set_rmii_mac(struct enetc_pf *pf, int speed, int duplex)
 	enetc_port_mac_wr(si, ENETC4_PM_IF_MODE(0), val);
 }
 
-static void enetc4_set_hd_flow_control(struct enetc_pf *pf, bool enable)
-{
-	struct enetc_si *si = pf->si;
-	u32 old_val, val;
-
-	if (!pf->caps.half_duplex)
-		return;
-
-	old_val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
-	val = u32_replace_bits(old_val, enable ? 1 : 0, PM_CMD_CFG_HD_FCEN);
-	if (val == old_val)
-		return;
-
-	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
-}
-
 static void enetc4_set_rx_pause(struct enetc_pf *pf, bool rx_pause)
 {
 	struct enetc_si *si = pf->si;
@@ -881,13 +860,11 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 	struct enetc_pf *pf = phylink_to_enetc_pf(config);
 	struct enetc_si *si = pf->si;
 	struct enetc_ndev_priv *priv;
-	bool hd_fc = false;
 
 	priv = netdev_priv(si->ndev);
 	enetc4_set_port_speed(priv, speed);
 
-	if (!phylink_autoneg_inband(mode) &&
-	    phy_interface_mode_is_rgmii(interface))
+	if (phy_interface_mode_is_rgmii(interface))
 		enetc4_set_rgmii_mac(pf, speed, duplex);
 
 	if (interface == PHY_INTERFACE_MODE_RMII)
@@ -899,18 +876,8 @@ static void enetc4_pl_mac_link_up(struct phylink_config *config,
 		 */
 		if (priv->active_offloads & ENETC_F_QBU)
 			tx_pause = false;
-	} else { /* DUPLEX_HALF */
-		if (tx_pause || rx_pause)
-			hd_fc = true;
-
-		/* As per 802.3 annex 31B, PAUSE frames are only supported
-		 * when the link is configured for full duplex operation.
-		 */
-		tx_pause = false;
-		rx_pause = false;
 	}
 
-	enetc4_set_hd_flow_control(pf, hd_fc);
 	enetc4_set_tx_pause(pf, priv->num_rx_rings, tx_pause);
 	enetc4_set_rx_pause(pf, rx_pause);
 	enetc4_mac_tx_enable(pf);
-- 
2.34.1


