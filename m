Return-Path: <linuxppc-dev+bounces-25799-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E25C5B572
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2026 06:54:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLGLj3pQFz2yl0;
	Thu, 13 Aug 2026 16:54:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786604077;
	cv=pass; b=chlbNWBAkKojBby3N5yfJYgo+P0ZvRxtBjJikw2qg39pmDT73QRmziwdqC4nJMkpX+eTosGfPQt7GqypeeOmueIuFaGMSSJh5KFcEjqbu9/8jg2GFsEt9YnEq6EKLM4/JldBrpwDNs70gpDYIpKpyCoQsmBMwmD/LP4fCpt8xcWcgmY3KILc1KvR+Y4UQfWrDmubhJr4Wl6wsI+W/Q90u/+r+Ip9/FTvCzN1gmK+A6O5sMKFDWAllIKCIGVVbFxJ7Pu6NJCOcVVtSHcCkvEK5HZXE8S3jD4XYBADONXnzUT88R1oGKboi5T+SM/LXylRNJ2XdvipTRg0VTh6CUKqLw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786604077; c=relaxed/relaxed;
	bh=0xWwlyXh6NjVpNywIiyFiIxm5Z3Rfvcot4qedIkX5D8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QYmzPvrAARkNSB5h/VL0cs1VwIM9HtOUQ1WKShuYRVNC9RohYERx0+6ZVipKSFABYGonUJu2GmG6WbfdQnHcxC5imlxJfBI7PNFTHN4sMYxa0CZLtWz+IebwYVcfbd+qxrf7JecdZ5laOw6hiLrIugglRkYyJYWSAsNdphl/u6C28rSwykqyrGO5Jj1SlD9rWoVPeqVo/Tm56q2cSoKfo8TcLL5+oAF+FivOvRiZBV0WbulIeudfw9RHKjKZjtutkeveeDOf+NVWBc9RyhYKhhFabZaKGZRa5caK6/j02RiceZMB5INLCLBK9z2Z9WVlI1GjUv8A/D+oL9iXhtXZow==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iTx8r943; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=iTx8r943;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLGLh4X8Hz2yfR
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2026 16:54:36 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaHtcRUHdrpnYiqd5NXOlH9mYFUilKETa5j/CzQx8A+osz59HubsAPBz2BQ+jInHxkOfYQCpFv7qK3xAPNSlByeDSnIQ+UEjKhsP+MBgIjiGlNyZKhFaCWQGePa7g2v6feNkhMj54A5wgvi/JASOHBCFfRQFJgLp3IqCSrx2Qy4pcQAy38NISg4EpUSwdJQPxnj6UhK8pcc1QMTnguw42bU+Z5hpyOxFp2vjL0crZQjPkhgPkFWwe9pQTqMpA7LWI6yy6Cn3EJSU4rb876MAbrs0rmVnzldgID6cmriteW6jmkfChW8BrBw5CTo1zybHO4ZLEPiWRF5FKCOAiOalPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xWwlyXh6NjVpNywIiyFiIxm5Z3Rfvcot4qedIkX5D8=;
 b=ak3+rUOc/5tdm873L1dp3zo2KNwLFL6Q01l22NDalBgWyGONc6dUqMaFQwFtlhZJXM7w1OVVWJ3qd6Yd2iAMWoVoIgH7lYJ2o8dinJ5RC6XY7fQPw9Cctp5jbZgtcv5nlNpRMYuJUwF9f/+BgpvsE8+3fa80jaaY2vUYNDB3cxLVD4Dlio1TE0aDzITMM0C0HQj3Zybh54L4czHH5wyu/2QeMff8Q+cgcNdqzcO21pUaUIBpcz183M4i0M1XxzB5E/zn5JjEFwJZtO/uh4B5PWgMVQEHm7cpkr9yMGiu8XDER1Wi1SxXl+c5wVcrPNZ2g8Qbb6l/Xz/IplF+QdfanA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xWwlyXh6NjVpNywIiyFiIxm5Z3Rfvcot4qedIkX5D8=;
 b=iTx8r943llNpZ6Qxn9fRTs3IKVUTO22kBFtI5FcGUQBzVdTWFMYefdINpqu9ZZ55AIPQUTgnpjGZsAR0p35FazyE/m4jSILxnRnZLrV3VVQc8TxRaWAnJvUjGCP1D7m7WzDY1NDuqlQzdZiBjDglPbM5BDEMXwt0x3dpFLV4aVn+NOOr+jExreIxMwcUadSMVKHgGFZAQGMMxf6g2aKOZLojXkf7OfsPeJZE1E23yr8p2a/H4qoFQyZt0NhDBHrI/oW1h7m4TxGdaqFNx4xXoCIC7tp+q/GsWk+xjNY7gA37HMfzcAHjRfNPM/FqHhBe9TDNEMbrnZoZRciEwqbwyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by AM7PR04MB7158.eurprd04.prod.outlook.com (2603:10a6:20b:120::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 06:54:17 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0315.012; Thu, 13 Aug 2026
 06:54:17 +0000
From: shengjiu.wang@oss.nxp.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shawnguo@kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: [PATCH v4 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
Date: Thu, 13 Aug 2026 15:00:16 +0800
Message-Id: <20260813070020.719810-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
References: <20260813070020.719810-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PAXPR04MB9351.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::17)
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|AM7PR04MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: a592a3a4-02a2-4b0a-6f85-08def907b198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|366016|19092799006|1800799024|921020|6133799003|10067099003|56012099006|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aune0bygVDjcO/EXX7cezw4Ut5nIBQIh0hl7PGSXPLhOSYd3UsUSDGFpnMT5fNcASg21AqxEbg2qer3tpqgI06/UNLoC+eaqSG1COeQxqV6yJdl4VYBYdx7cUQuCfgnzfSvxS/0LQ70WVlgj76OaZZbHME50beZpkFylpg64sUgx5MagpHecxXzlz7I6cEtO+A1BicjrIPSCOoUqcu1+aJIO7P4bd9+r5toP2941F6AnaxGgaTtoUsW8MNj4Rlt7v/0KlaDi3zXoxiwaqDWJeJ/aONIYtxIxqZE4jyRbfE0PdpFDPac+4DyUXpteoRtpKvzKaq5OayT6fj6B6GaLDN61uuW3WD4uHMU5ogIJMwjsW8BRplx1fJKdgPXP6MX8iNo4fs+FqQWE5UJ7FuQmiEyWD8tBdH6iYfJEIDWctCKpFJXPTY1tqZ9pibhJuhVyZPQgoX07i9kuYeT12P10Ck87dgKXRLnEslbCN24dMDdaFUSzDr5jd2te+BL1+hflkZr2+SU7eCn13KXPqc9NNNZO5ihTdBIzBVnp2Sl3xKXrmNfLt1agsBGo6vr/D8Z5xyijSRTAv6y+CXdHtoLlmOxHPEEhA/Mw2h3Pfuy5WOAvUQeO44DmDKqZn564a7dnmOu1clFKrZ4uodd75URcLj1FW+QsbZzkt1cpTk7jIalPid3CPI1yUoM6tfYwl8U0eIN146KhgcC3XLJLsPKXpw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(19092799006)(1800799024)(921020)(6133799003)(10067099003)(56012099006)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aGDGKUfTgL2GHi++rBlqpdMecNm6gUknEwqFmUNhnDOjub2ks0xqDhqpfiEB?=
 =?us-ascii?Q?uSk5mk2SgNWG7u6HMMbpQra26VkauWAIkx5MHOaEgs0ONSMus9v8WVspsPpL?=
 =?us-ascii?Q?eC72k1hixN5Uf//CWvWgtxiQ1whMXNL0st5wYduosX2LMRE9KriykL27hcmC?=
 =?us-ascii?Q?vmv6MH/wLqh6Eat25Frs/Ifq/p3rjjWcOIjW8rx2zG08Z+EnHgncRc8qXmDS?=
 =?us-ascii?Q?bRAgD2zt/JzPgnrerIhXqvs1a6jVska2tu3sYBavrwsI88Gupgo2a9or73z1?=
 =?us-ascii?Q?V+ScLtL15bXn/58TNf3WAVgRrq38HAZg/knmhCLsJSR3nX/ChvFOQEWW1f2I?=
 =?us-ascii?Q?NqER0kRaAY0oqMmAPPWmVUECx8qVcu/WJ7+cRu7Rlb28Wnbyeo1vntHU7zqa?=
 =?us-ascii?Q?/Fe714DWVlpPuhE9RCOjORmfWM3knaROHgLvn/YcyyZ1FBn/2gZYQSXSpDVA?=
 =?us-ascii?Q?5HcCMh4wBTrzSZe+YUn4uuJ3z4KUsQHIs4mreqovOh3SrXHcx7McMYTd7+1L?=
 =?us-ascii?Q?BOH+6GofKsqf85snXUsXCNL7UZyYJaTApbXQlPQkLpVcACxUvN6rbNT9LCZX?=
 =?us-ascii?Q?blD4MThRUd97ni+XzE0IMDzWT0zjung1Ot/61Yg7DDGm4D2xmC0HDm0suxk9?=
 =?us-ascii?Q?jzo8b2cZWYxeLiNmDd8Qa1jgJLRh7UtJz5VQnYrnA53nanHQywjsDj+Z7BWP?=
 =?us-ascii?Q?FZg4KqNMS58Mp8ODJg2t8sPLV1qXr/u6mRNH2PLHspWn6Ogk9wuL6D+jPLjE?=
 =?us-ascii?Q?HLfms1uuyx6r27pKcnlbT8C3Tjjk5KOCPfTKVnB7KM9YruLyvopfrZt2/RTd?=
 =?us-ascii?Q?JHHi5ExJ5pdrzzjpoVe+LgUi11uElcoV3ufR8QrOnvX/g1XWR39Kx1Sw5UnH?=
 =?us-ascii?Q?BPr7VtJV8FRpYCOa7CaBonIr48v41jC80v8e2mZxTaWA/1+QLmmOKmkyRPIR?=
 =?us-ascii?Q?qr3pHCeVHi8MySpNjHb5x8VCZmG/AvtGAeiCGkeAUSDVkUEJl8jDGdoyeJM+?=
 =?us-ascii?Q?8St8pZ7sUAGdAiqMM8BAAEBzJIfJz7PMtLPGetxaV6XFGw63C63y9X7RRfgh?=
 =?us-ascii?Q?IrcB0jXKRb1wg5YDBHcqUmVb9uZ+zhaKDlkngiFIdFANIFoRsdaKXg6+9m1t?=
 =?us-ascii?Q?IdVVpq01IrG3lKb5X9D4Ir0bGpsH5mkUQKhN0Lf58s0l46sjvASLwyka0JdH?=
 =?us-ascii?Q?ouEISzxcywoTv4we/wgAR93cIZN4RWieidNTcCMR50/Ao7VU+8LG256VmXuq?=
 =?us-ascii?Q?zyM7FhuN4Zgn51rbdJzDrF2bj/xSM7+nBE3f9LhQcwxKZ7Oq7WOh2aiKklX0?=
 =?us-ascii?Q?APUFuCN2aUaKQyq1qgLdr52iBeggJMT6ZC2+lIXCFjdq8VkOLBKhJYFYOCGV?=
 =?us-ascii?Q?QzgpqwQILWWNED4U9QdnNkEKSAaIMNuqF7Qt0bxouS+XujZOH0W42aNPdWh7?=
 =?us-ascii?Q?Y94LGtCnd91OPUwlKMxxkCS9niYXss1q5ZVaZ4yhhoYxK/o0+z3xrw/CafHJ?=
 =?us-ascii?Q?EqqSt8d+Z3WaGCOJs9W3nX6Yd21G+8zVdQzxAsMjgrnTWuRPJyxcWCFfWYMK?=
 =?us-ascii?Q?BLfArL9DQV/7uacarhRNrC6rDVitraENBjhsh7O7rcGzMu5gIhl1OCvEth2O?=
 =?us-ascii?Q?RnGGx5D9y3qCtsTSdS4DDPLxEwTaKzWv43cPnlqAMaZNeMYRWbxpRJzceZYc?=
 =?us-ascii?Q?dl3LrguSq3RniW7wjRdG/M6BPKVEuZS15bYQeN79h3vAOqIrPEjvjX6ag3nH?=
 =?us-ascii?Q?Fr+cOkA264lZjTH+NL5wz3d4y7ptCbZr1pHUCtxzfR2zglF3wJsK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a592a3a4-02a2-4b0a-6f85-08def907b198
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 06:54:17.4020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ae4OJX+zl9vpkQ7qPH5TV4ShrT24TRk6i5pVd1l6wCefXmyUZYFkRuDn0Gk/YtQgUVb0Y8vAAhPf5/yFD668TqI+Wiyj9a8CVH8Yq6o7dwcL1Do8ab4vQSk6YCupKGS1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7158

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
The existing binding exposed only a single generic audio-graph port,
which cannot represent independent conversion paths when multiple pairs
are in use simultaneously.

Add a ports container that enumerates up to three sub-ports, each
representing an independent conversion path:
  port@0 -- conversion path 0
  port@1 -- conversion path 1
  port@2 -- conversion path 2

Each sub-port references audio-graph-port.yaml as before. Hardware pairs
are allocated dynamically at stream open time; each active stream
direction (playback or capture) on a port consumes one hardware pair.

For backwards compatibility, keep the old single port property but mark
it deprecated. A schema constraint (not: required: [port, ports]) ensures
that both forms cannot be used at the same time. The binding example is
updated to show the preferred ports form.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 .../bindings/sound/fsl,imx-asrc.yaml          | 45 ++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index 608defc93c1e..67d2826eef3f 100644
--- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
@@ -78,9 +78,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      "^port@[0-2]$":
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for an independent conversion path
+
   port:
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
+    deprecated: true
+    description: deprecated, use ports instead
 
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
@@ -125,6 +135,10 @@ required:
   - fsl,asrc-width
 
 allOf:
+  - not:
+      required:
+        - port
+        - ports
   - $ref: dai-common.yaml#
   - if:
       properties:
@@ -180,11 +194,32 @@ examples:
         fsl,asrc-rate = <48000>;
         fsl,asrc-width = <16>;
 
-        port {
-            playback-only;
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe00_ep>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
 
-            asrc_endpoint: endpoint {
-                remote-endpoint = <&fe00_ep>;
+            port@2 {
+                reg = <2>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
             };
-       };
+        };
     };
-- 
2.34.1


