Return-Path: <linuxppc-dev+bounces-27881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC75CC982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 03:30:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hplwJ6NGdz30MZ;
	Tue, 22 Sep 2026 13:30:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790047808;
	cv=pass; b=KZve7XQqIfvmKfviyfF8eSrpMmCJiYpjQfyQaI9k1/n8P5Z55nvgwr78+ybkpeBZNo0E1qRaNLL/hMTm7f0Yv18zEFXdJM1+IPIoKoVQhTYdm/APnj3dsSONcrkC379DCN7uW0sEqEYMPA991N9g9A2vOoR3X3Kjt7R5Gp/eg86T+O82R8Glx6VSrCIcx9KCZMMp8ka7WdRcHIaSIzPgsv8VmuT5pnDkt9AiBy0DmuvVx5Bc5HMjScR6UcemmM/wh151pRiAnk9XENtIf9r0jMT6wRZLx+7LXPzuk81n6cEY+fwJ9kalEHNRBbZ61+hihojPbp/kphNvrIb3YrBgCw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790047808; c=relaxed/relaxed;
	bh=JVaTzIde7NPFg+5GxlVh4R/HcbjO75tcYedJaU3w5wA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CTcwJ5SDVOrrtqE/P/DTKHY4pLKGOzfQiIhjpoRTCPOWUNr/og5i0PAi+GJf3ZYp/m98U79UCSN0EcSvpqAlJobYQGwQ8fm2QyvNNF6usZuQWtZEKPGjqgmPpFEHEG6eKilQDnkVVKNzPEzwGgMMCEpfaQWmcrKC7RXwEWP4dcxagYBWuREWLU30cvlWEApmUUfmSWQr5JEkValdYgCh9+QnTeBsIGlNkPf1Y1HWxv8H7CJiRqJZrcHNeb0Etp1g1Gzo8X9iyYAikX7o6L7kD1rN5TNnDqnoG5p1yHEGzAZUGZbVNO+8SpA/HfouXTpWim4sNLMgcvyImPh31ZSGUg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=clWZbK2Y; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=clWZbK2Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hplwH6pQWz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 13:30:07 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilg5+8Os1fSd5CQbzTqTm/6KUKYgBR+KlrkR/J9Aks0kzQSrNLnWHKmgAmaOlDWiTNVb5KUjHg420jRS6qRzx+ZVjZu8CBa38P/RlvIkN6VNGawjY2t7VA9LmiAiQ6Jg6ohJrUqIBLQSDom6jJE9b5A+JnazgEU+JWfIsTpwiDTqeiaYoe/UlHdZ5q6YraqspQt8Xx6+Tj1zIrTEXuF5ulBcaoy3AqZ5CAv5QF54Y+5FNal0c6BfMqFeueenNIi9xs8IOFVPkslaf1VkmqdtNQXb8ZpthvRP/fH1832Z9LwI8zI2JfcKjH844lBbPt2YIbiWIhJ/Ohm4tETek5mVxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVaTzIde7NPFg+5GxlVh4R/HcbjO75tcYedJaU3w5wA=;
 b=sovo/gW2gv4DyP8btlhRkaDqGSzsAoSx8YL1JgBBPAvJpPtBhl5f+xtCSqlZK6TKMypHDKPg/9/5YSnNOXcgVj4mT6ZsH2cJ6H8jzl7YTWFe5aXckLBDHbWvbWJnSlieOZkH9UjBi9yYHBZ2NYkN8x3worYp3QLBaNn5OMcOFP7VsYmN+n8MPuWfrK9/ZktnxbJsTqu5maEq2kUIkB2RofU9MIqeAsQZwuXggujAz/5sASLVNWPFYF9rR+0Ru8XWJ3qMOpoVIfGTBFgvYb2yB6ibrUVDdzptIbgQEQhtAbJD1KiivKdncjxwxuxBjfSMizrBLYOVAhQ8Cp8MUXrZcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVaTzIde7NPFg+5GxlVh4R/HcbjO75tcYedJaU3w5wA=;
 b=clWZbK2Y5meoxM7hSJm0t0YtaTak0lD0t+mkoJlNMev2+mrPTSStL1h3x+EWQN1YVxh72pemvGE81aXGsdvpz/h2Ij1A0sXIuavtAYv20jywi5HznJIX6jBswrvG1mOC3EqcbKRx6f1P0CU90CPoLuJRzkkfo1JyGhRGxzpYyx2gYKqLqlQdqN+SSybWHEt9MT8U/4Ji2plul4wTGSIMdro6NoxHnMDHORMC3oVwp1wZqejr5sXz52flOE0vLOsllh0eUjKDh0HvtEkFPYLX4WJZEsAjpm0YmmCR95QgnI+ztQPbRkZ7NLG9hiroP7ssxNOoxmcI+cD2ege6gBz9OQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:29:51 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 03:29:51 +0000
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
Subject: [RESEND PATCH v5 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
Date: Tue, 22 Sep 2026 11:34:24 +0800
Message-Id: <20260922033428.1690822-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0248.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::11) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|GV1PR04MB10941:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fa8809-51eb-4d27-5173-08df1859c31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|921020|3023799007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	BmeI9DLe3CYffnDzxqwuQ2p7FyHs2X5Hw1zGtt8LVcDr6Q5bR+KMqFu43zLxkUnwdNKgfli3F83Sv7bvG3GNh18bmQr6Y/3SBm/sn6T0CsqkO04OOcAY8nrUNl0IhZxhudy4FTgbnkpN/ZGxW143NOJqelLYQIhVp+20BxWrjV8ZHHUjeJDm9h2MLRXTLtYPx6t+j/FI8r3rvT3OriPGG+sBUOBy4gxA60VNmc1ola6KDiYECoWtPQavzMeGmVBzkj84jLGAyhjipa7ua4TyiYOAyUsDbpq/1clEF2Tmy+KM+phZOPVJBkONnQKqAmomIKiZoqaI6CnK0+Hg8D9vsrtGEu3icvXvvh8N6y193AwbX3KS4CqmT7dKr3UQi16elTBhm1ESYqemOoEK8+q4ZsHJYV0EIEGSno920BDamgL+p1ljbQ3VjOQ7+RJ/RQ4hiCXfkZB38yUGr/HwBNqwzJjvaFjNNOtCzbetByWvFLFfn4hcNLZDlqdHyF8hUrI6Ab32Oq2mEkS+z881ScNMI2efcOrmJ1gnmNEVu6fTnXd7QhvbVGHDghXzpDtb/ANuIhceNAQLtGgDCXgnvpr2dNc9m+9g4Le3fs/ayVFTVQImzyFo7tKcwyG1wmQXWBK35UKvbD18a4KCwZMFPBpimbV/F7RZZUyNjMKn5IYJtrQdHggVyJxJWM0nntykgQroAsxIhT1OqPgnJQkuZy0kaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(921020)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9eBmusT9aq1fh31gcoJBInBFDsWzIuLV+hRpqxhabprwHKv/qKOQdv8N747C?=
 =?us-ascii?Q?8fi5raZNVJj5GdTV0OHz/MktqM1JIhvgFCAAntr9P875V9HiDWgPo3KpC/7k?=
 =?us-ascii?Q?ank0X2d/mmBSaeGKWKBzrE/kuLoXJwRYaQVO8VjOEPlyX0V6MqRiQ88JAPxV?=
 =?us-ascii?Q?wM2pfjA1O+Iiw8MMCOre5tsMTQyZIyNXBlNFrgbxS9lw51Ehc34eV0m9fzUE?=
 =?us-ascii?Q?FA/xyksiXBseHvl3D9z0CW/Fen5LU/tMFJWRvIBlIMfoOOGiXEJrhkA13C1u?=
 =?us-ascii?Q?Vzg3lPjsJBh2QSV7NS3ZwTzZ46mDUnsIwVvEIwFF6hwiVeXDg4mErOtXgCRz?=
 =?us-ascii?Q?BTGOjLcT2Yr5goPSLcAAokW5RtcXNjLAI+geGhrUUnP6ZD7D8kX6Al/IgI6P?=
 =?us-ascii?Q?zmwsd4STdl0+fA4Av8f4BRSda5Oy6gqC1CQF3maaxMdTDo7op3m/WVIfKaEy?=
 =?us-ascii?Q?uqIYQ5WU6qKIO2b+DUc57ib0IArREQwkY3FUGUKhnnKIkVj9EdkjcrAShRsc?=
 =?us-ascii?Q?/Cl8GPJ5GFJmJbUYUHNNOyWLXb0QeH68nq/J+opZv0O2rFeAUpW6DSIb7gl+?=
 =?us-ascii?Q?f5smh3Wk8/aRpISgGtn5UTimdzXEq8q578mVADlHrf2Eos+H0nL2yfCjt3ft?=
 =?us-ascii?Q?U6tTEoGue8vq79WeqXPBK+AoZm2H9xprtwfHbTmncSnPG8dPSgIdwtOOBkg1?=
 =?us-ascii?Q?KFswQsyzdnM6ozrfzHl1peuuvZKWghvWkIHvGP8AMM5I2rayyPy2pGBYYryw?=
 =?us-ascii?Q?fJf2KTrXzOyLN9IxNwwtSg6eAme64UnaM4dAsUktae2fSZKx68tTt+R17izF?=
 =?us-ascii?Q?2vXDUiFbUrVE2DvsvKegdC3vQ+8Fozi0E0pVXCz620YA0LO9Uez0UTYA9uFy?=
 =?us-ascii?Q?w5GJMvXn/RWF0dhBwHMhdx7YaBfjU5Fojs9doyS2vvXraUUroHE3WwjPMRvs?=
 =?us-ascii?Q?MhZ+j09mKUb5F2nG9xwcBfKwXIO7SshR86N/cHGHOAnZZcyugvgc2zfTc2X+?=
 =?us-ascii?Q?gPIAHHkpMzCH0o65sQEH3lcRCPeUD2PQlcgBicBa26nOSHJ8309iAGWLBz3A?=
 =?us-ascii?Q?tq3PH5SoEcOJuGEHSH6dfuTKq8WrF01fvKWFhI16CspAxSyvEpX970CObY2e?=
 =?us-ascii?Q?vGqnjoer23vBuukPJ3EaymBzBjR2ZXdr64rsMzv4a3z2UCvtOZHaWtTAZstU?=
 =?us-ascii?Q?gNpgDIfCBcLEXJoQCbfpiq691eeQcE+QekQf10fgWQRCd8pjciGiET1eHqRr?=
 =?us-ascii?Q?a196qdHgPyrLkD5jUpod2w3E3sSBPTjG/ZO233huMcyvkfb7upuOx4ytHEbR?=
 =?us-ascii?Q?WoeHT8NlrxvZitZs7jup+65H5LQAViuS3GWtxco3eawsZyMyXTLAMZ9tCd3d?=
 =?us-ascii?Q?RizWaK2pIzOUi64QiQFoP4tvVYhnSA9OFZF+vJMBQpIkE7FLTDgogQLfnhl8?=
 =?us-ascii?Q?DmK7FWJDCB9OecYB9bhs0eBT+JLOGMO7yBOgX4/mYvJAhVgcBjsaOW4hMuAk?=
 =?us-ascii?Q?N7uD9tO3UJ4Bi/DUdMBrUZEU2CZ+HYcf/NgB+qGab0Eqfo3sHWWYE6gjgHns?=
 =?us-ascii?Q?PwIU+9HpN79ThP3XtLYN+w//BEz/4wBIJljanlRCDkMuJ/vAw9e+WewR8iFn?=
 =?us-ascii?Q?wyRfM0xyitvEq0NO4CZCndxZlZeRAliWg9IBx3HAtmuR6cFqcphQEe0EDIZ9?=
 =?us-ascii?Q?Ae+p/5TsdyG+LzIo2YQSvpG8oF+iyMnf9wGJQ0QN7b3I6CvZu82RM1WWQaT+?=
 =?us-ascii?Q?O73yR7PYYkUvoS5qXk53Yr63ni2ZphjQ1yKxVn3JvhFOCLQXZYMC?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fa8809-51eb-4d27-5173-08df1859c31e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:29:51.5827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: atxNRPtJc16ncpWvD3YpZSWS38NOoGkvjKMc9ruB4i6s37Q26WdOL1xeSjJrMSp+NXeg2YP7B7U6oxyVgy5GdKW3lguCryPCotevsFt2XPylasFlDzTFVlE/+24mOPh/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

From: Shengjiu Wang <shengjiu.wang@nxp.com>

All i.MX ASRC variants (imx35 through imx952) support up to three
conversion pairs (A, B, C). The existing binding exposed only a single
generic audio-graph port, which cannot represent independent conversion
paths when multiple pairs are in use simultaneously.

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
 .../bindings/sound/fsl,imx-asrc.yaml          | 43 +++++++++++++++++--
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
index cd69bad107c7..67d2826eef3f 100644
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
         };
     };
-- 
2.34.1


