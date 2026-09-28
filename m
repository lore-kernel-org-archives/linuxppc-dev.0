Return-Path: <linuxppc-dev+bounces-28371-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4A9C9833E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Sep 2026 06:07:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4htW7N3Cp5z30Vd;
	Mon, 28 Sep 2026 16:07:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790575664;
	cv=pass; b=PF7fozmHwfFysQ1mDTmhbLoArnKIAsvnxROeoiuzztOeS4f+DmzEqhE3HJ2LRjnfGMbWUBWUTdr/IIHu3b3p484zEj/b76xOAHj0/0G98vCrOF7yXCIghPflXW/FMzTGuts2v2ETm62BoiMGzjYnNNZektTaOaR25cnd7it1MlsY+6IF/KLnE1yrvr4LG8gPIGMj6yjebFGqh9YVrS/FOsLfnhkGKK/C0dmL0K63hMC6QLdYf3XPHavt4LMGeTwXWYF19jtj4GIVhdKw4LLC7k2sCO2C2rfh0FJTnUo00XiYm8SDgXUXLcqb3b8dG8PwMEspcfEffTAf45CypaY9og==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790575664; c=relaxed/relaxed;
	bh=zY0WZeyO1kebHyQe6c/XcDvaaPBI3LiIS6/cFDeN54I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I1n/0VsTKGU6PMCaZr4RWVZGC3ZlPl0XXb+KNE+Zm7vRRWK2gf8FIwDPbV0F7RjShOn5z5wFDY/WoesX7rAcY27u/81MLomDjgKBlguIZ/5Of8X8DytJmHo2XpbLXF+dEFzMRB4iCglkPpZsNDZIy6OhcFDoBsR75xj6+QYGmfG14ry/lOrRj7+fBwknzkKo6oYHEb3pWVuXXe4mKK6JZgs4vGJTX9sR1q3B9E8iaRtnXn0gl87X5au/m98SvPDeKA2beMFI0FrKUDUjIcwW3YAhb2r9PgEJcJrHr8y18wmIzOWFeMQL1GK74NUmhMo19qDyX4SN72ONVB/spbQMKg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=knAYF6ww; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=knAYF6ww;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4htW7L5Cq6z30Vs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Sep 2026 16:07:42 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4ZmHfKPq8+KrFTG9JQVgNxCQf/CKTHw6FgYRQVshljVn89Dujcl/sk7jgI20vbRs32UflDRwa2YUsQ1oZpRDDDlA4KHw3mXnG0mOxq38J8KLgUaexxGUWwDfqcJrZeXVJsEQk77g/k/m4PsuxJbn/nf72JxfJVugjO46umOiWvjbKuN6NFWKZ60Z3atXNVmMBksJEzFmT5bsYr7chHZTbF6VcUm3NrhIl3oybbgLXe6+DpyD85rnOWQu+bwTsXMAZuoaE02OCKxoFDjt3mGnrp/K61LvLIek6Ur05aF1ZzTLg51FwBFxUW39+5yOWnbmPMCIMSWV0yJG2QqIJDVfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY0WZeyO1kebHyQe6c/XcDvaaPBI3LiIS6/cFDeN54I=;
 b=ggD6LXxsNhTT2kcsbLiVkbyeMJdBYVzzYffNRuveEQPSGPByEGhYpCJMh1SEV5AnuBXpt4VE67j1tFFUA/9s/pZBKZlSkgzHsDHnQ5anUE3S2kcLewWW0YBScKBYv+wd2XOH3vVkJ40ZnLW3jA9ZRBm+sFHQ5Vs2kUiVgME6o+9aKoQksYPWfDedN69euGFLj2nAvAzGpiDFVUJ0aInFmioPcz+CltgTfqrtFWo17YEqbP7ScdjFx53RI8uZ/mIusHqEA9n3xaFoKTVrCXdQEjZPU1eEXwfrdbIphGWD3RFRXj8wopmOWaBZ8p/f0aKvBTZJeJQwua0JUoMaKk/YOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY0WZeyO1kebHyQe6c/XcDvaaPBI3LiIS6/cFDeN54I=;
 b=knAYF6wwuGSAXCE0uFWvdiJIPvbIavpKFsnOl0LpmB7psQLeO2sXZD+dyDiOcHCMmOXdRHhm4mTGLjf9Af/NGhL/DqRg5MC7G8/oEeogGB4zlHY9sP9ptjYq5satXVa0zq/HwY5+HFZJ2WpCb3kry4Dc4zm3plMEHf+7JsGchRg2RdczaWcj5BBHvscYQofgEC+YKJp1jUAnU6O8e4W46GgUCV1m40YBEq2c3WoenYR86okzukVPE1KRQ3GG0//c1rTKt85sMQTD9P/ou72QTGG86BcrILU81OfblcWmpS5iG2IG4iebUzRgR8P/QPGrFe3GfguCj+JQDETVUgJQ9g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by PA1PR04MB10721.eurprd04.prod.outlook.com (2603:10a6:102:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 06:07:22 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 06:07:22 +0000
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
Subject: [PATCH v6 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
Date: Mon, 28 Sep 2026 14:11:45 +0800
Message-Id: <20260928061149.1844121-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
References: <20260928061149.1844121-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1cf::8) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|PA1PR04MB10721:EE_
X-MS-Office365-Filtering-Correlation-Id: 649567bd-1f13-47a5-79d7-08df1d26c2db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|23010399003|921020|3023799007|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HY1YEhxLutHCmWjOZpWcEizgPVCXMjzaaGbAvAZ18FyvtOVfRu8s3DQw7tsFZQ5loxbiAqjf40+8n+hW/Xx7Acr5sL+JgRCat3lWtOaps33jJivCzsH4zRpbMTvTBOu/QrJ7rexHsx5zeU94yjAI5+d3sBdIHgBuBQAmEvTjWtujdcjrGgDTBV4qGF9WEAxTaMJiKnlyPqDPhaMXtmqedofnSlIuEAFeDdksWNgjgFOXM4sgb+e0XaA/wXrwJqhPKyDhtinqb2edioeU7c/as645RL4DuWlv4Hh3x6hBvv86JU5YF5kEjNYwhS6XESFvv9Q6LALnnK9FJEX1/PliSjdDA8C4SPbxoHJzHf00ZAjmRTrNKFTEBMHJGYDPpSXP+mORP5F9mef5P/oUi6GbD452LTEkOwv4X43+0rrebtrws0aiGnRine5uH1jEg3SrCUQX6rNpFnkpQHgu73iUVfDHRJwUr0GkrmSbTUMtVNAGyg38urS/XFPK/mVUHrBFAIaKHyQpMLKvbUuqStVjmfboIf137nJuHOqzkN2hINsrlKOlpa128vTunt4Zcl1v7E3Ufj9zc0ySgkpLHGu/8Rb14v/B6bRLPFTX1gnQ4LfzMp444tYYR80yMMSvXvv7VyNgauzZaCV3ejbaAVYOTy7xp0XdSbeNGOoF+d437nTHAhm1zk6kqbfHveF7mb87TUqCCuIaT3QmKkHln4CrSA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(23010399003)(921020)(3023799007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TivJ/HYE/b1nBqF2dMEa7VEsnfKQRaTJQTJqWtftUWxiCXuYI1hzqgOv+Hpi?=
 =?us-ascii?Q?+8bH0HFzYxo1BsLJAfljjrs4sleJX2MIODPKAMria39YX1M1dl60wmCPM/0r?=
 =?us-ascii?Q?Vph8AHW3HzatfCeQPMdL3jTBlMIGz6UmBUsnm5hGryuoHlNkjBz4mW/+0fHN?=
 =?us-ascii?Q?CGtulxNxwvLxtuwDDmTv5PWjxrhxYGV3O3uP63TkjgihgsisLU6D9h94Zjt6?=
 =?us-ascii?Q?5LZ0Ibgl8gdHv8kjlk5+rO0sPSZ9h8RRlX/nA5ov4/Uva8OEvEqjtYC7wk6a?=
 =?us-ascii?Q?KQtAiLurAGstz+qf4/1LXov9ttpU91ryWaGbC78/nVVeUmIZgc+js/D2SKsX?=
 =?us-ascii?Q?UcW5k40avFE1eEtKLXR/gaaFn1rq79lNla3IMSOSR96+793zBQwecve7/Z/+?=
 =?us-ascii?Q?JRHMlIg2g+NLFySzRpRGTlDbD9vMq8nxYlSj40Cd1Cn8vvyIR9u9Jm1IJIkv?=
 =?us-ascii?Q?K658saVg45lrVl2H8YAWUlAzcF5A2squy3UuOvUohbVguuThwno2b0gpnnKy?=
 =?us-ascii?Q?0O5UVOxpsonTVHnusKlR4UySC45zBcdRe0ua+rm/5BGWjUVXSai5Pb6/mBru?=
 =?us-ascii?Q?OJMIABUHDimIVnPxSkqNvCXhds2frhTAUKHoCEDLx/RjQUyyAtxuqxYBc/7n?=
 =?us-ascii?Q?qT9BmBkDUfsQ3xBlmaGPmTH8tuQBM2SkP3H7j48MrJnOz45sYAjcutV2F2Jt?=
 =?us-ascii?Q?/ovqFjbNti5fir7cFxQQ9oLXFlU92gzsrr3/P65d1nlPCYPtc9NVgzwW2j5Y?=
 =?us-ascii?Q?L9cHHWvR9WHquI6VnzsFioinfvzBZKKVZmPokNk1bTgRZVMYgoMFKxHS4J0F?=
 =?us-ascii?Q?RdgGWuKs8HmrXNG/V9db8ua29reqa+jXBMkqMhByWU0puOCPvOpfLo3BzUZx?=
 =?us-ascii?Q?2Ig1iEQrEhOH0lwrkg/5t2b3ACTzt6uRGpBzyI6WP+LrZyduwWlBrESBHgrH?=
 =?us-ascii?Q?s1vXnt+oWq+N7jyjY/XA1oQvMDTK28wMUdDnB7I3uCVsuTofTwTHt8ZsTpl+?=
 =?us-ascii?Q?ehTuKO9xSCp71wznYUrdJ/SmSa514L9EvYLREAKkKS9Pp8MzEQTzCPZiG51Y?=
 =?us-ascii?Q?vvlGUYPTgmB9HAwmGWqdBDWz1WDZ4cSveiRWUh09SklKYK4ym6K34mT449Vf?=
 =?us-ascii?Q?RxbzopkiVnqIHz3GBaxTlTRolMwszRhjaonePgNVQKeG1ehihtv0Eb3zT3SF?=
 =?us-ascii?Q?TTiQX7aVeKmMlu4rUQ1wDEC0xqSyLVdlzSk6asaaQJtjY9utEa7TfkhOv6+G?=
 =?us-ascii?Q?liISNVLShWH3lQNEoQQmVMoasjLX3YZ8ntMBICQqSIr2KnaVjkdPI0bue8lD?=
 =?us-ascii?Q?OKAOnbDBSKWs2PQanT0h8s76iOVWoVgdZkAPd78APmBCuF9XF4htYKYF2wVz?=
 =?us-ascii?Q?Acu1Tx0l0UQQuDbvCamV1MvZpOxt5rWyp3s8jzzUZKUlVnd4JCj3MEMUs6/g?=
 =?us-ascii?Q?RvCmd/uHhuTiFUpUoHaK8cXPq8pMVZ0U1TlcEj02H7d+qY+Z2AGhgNDAk5UH?=
 =?us-ascii?Q?6bBaegRnJxjg7Hy2zgMBvUuxDe6r6e9V+Az8Rpqwrh8Q0qxQ/RKybJUminF3?=
 =?us-ascii?Q?kfEwfu5JCfAwEucld433mHYYzcSJU4j1s3k6H7aj42GqcI5ugRzoEyovF5wn?=
 =?us-ascii?Q?4LeO804WUbkKTZ5YEq/qcAyp2CE0q0ylbuyM6uxu2YcD5k1qwF/yxZFrwJ9k?=
 =?us-ascii?Q?xcowZ/LBPLPD5mXfzWVvcT5NB/tscZlZOdEPJry67B7d0pF9bDsVyoW/8TLo?=
 =?us-ascii?Q?AKFvVY/oPM3yJaMnQj9P8oJYCtRiHXVWJV/onfE2i6NNHU/KTGiF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649567bd-1f13-47a5-79d7-08df1d26c2db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 06:07:22.7505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBwu38mNOV2bvRaoqm7TgZKfU79IluD8U77YuVJ9B5DLUlAA2tRFIololqnQ+HY8h4DXtQQlW9zW3OQDburm9vvauQB7Zd0ik23+7q6/AQBGOMJSQ+wwZuPI8+aju/ch
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10721

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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


