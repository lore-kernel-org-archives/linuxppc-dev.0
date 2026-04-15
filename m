Return-Path: <linuxppc-dev+bounces-19756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B254DFA0C48
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 08:21:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwYxn10mCz2yvY;
	Wed, 15 Apr 2026 18:21:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776241261;
	cv=pass; b=exvuKwKFojKIXRov58m9lhBVSBzv7C6zvAtsTbbShWBPi2oEe+VEQELNmkqsO1JQj6/7j4+78BbPXX701ecJxpMD1MsyBg0yRPgOToGymaBiIRVAXhpqaMPDc8akIKtJ5FljR7m6SzXKiK1Cuc5yOqSS+5LJ3RVC0pttS0zjoiQe+QvBL8x0h1peZnimbbjiF3lhfjeEiUTOMXx3DI4PgDl6qnKWv6X1xWmk2gdo1uDsVjrDWQmo5qBArMt/mXYTJELPkiRC5ZIyJ0KvnZkrl7VR+6ZtPj3w2Vlq4ShF8qiVct58QGpQwHkY2WPxWX/nLx5KBbwmT1FxXQbzGV9KaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776241261; c=relaxed/relaxed;
	bh=FmyGCIFU9jNUyV+NQWKpLVWxYjUojqsTXBcQvNYermM=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R3Qcd9yPu/4zsGrxmvyLZjFKN9X3/xhcRdr8p4xquLqfaAkVzzyVB9+dGsmdKG4csyAypyBWKZwk8wbGWxPnbgp4uxTJvPfe9EiP4yEN1/JE1v5fI8Fu3jGp7wRPJCu5+i4/rAjp1wakoYdtS/0KYHzVAdEtCdbuVu00fX97wJFKzXTXiMQKVmImNFRHf8oxowHDXP0RGwjzW/cXCqDaxZgbX0oQ7py3piBx4YoO3QM5wi3boPsGs9T0e1m/j5O4vc2+1J9xx+qqiCQs1F6Lkh3y4X1+aV9WSI+OImq8saD3s0bdLJ1IkZUgS6xNs6R4Ynxrts61Xn6oMyHbS7aPDQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=H4VepC0s; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=H4VepC0s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwYxl4DD0z2yvL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 18:20:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtBH/T8vF/qJLmDvOyiBnDs5W9+US26Lt2NeNzmkbl6MClNJ7xXSVqT++YQ1fFqsDnb6T+i7mlYU/A0ALFD9r4QhH/NPBmsiJin0SoSrWUj+CSt5wUq/Jl9SiadfyuAu2TEcPxH0MX69yPSlPLhvYxogNvEOKiC5/vZQiP4WdWwznz8+MDpVaRWnAjfDv1xT4cRLleDsK5E4uiVNi0xWgxkuvuxvj9AAEV9U/AbciKka2gBgAw3wPc2RdHHngiZR5K10q/lB6kbX7Jb1wj0YBkz49jogIdoLnHIKMYm57wNRmcJh1T5lmUZF1Hi7vZ/2Ay0YC66DRla1JS6y5XbLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FmyGCIFU9jNUyV+NQWKpLVWxYjUojqsTXBcQvNYermM=;
 b=est6Uv3Jo3ZtYOnujeMcsfnAygyCuQ81zfdCLHrCHjLLLgwrvF0/Ww30ElK0qzyzaLgJDHu8sm7FfwO9i2xZB+JDRe7fO5TkB6hFqDC83S8Uz1daP+rXSlRMvhEzrySYFBYnOVAsZXBTS+hXumoJrdgSzAB4T7C/0CZncHHwjUzGMpDiVY+6ecpT7VZ8BV5omf9SKKnEVWQWlMJiZQy3l+O+7wRJ6fU77USaTSlTb0Rxo7iB4ShklWWBfzguWIMlI6aa2GeW7MmT9dkNq5WM44ZW8/5TY3mveXaRkpgXIMpL1hygaEiDz2yIBq7Tk3F8sKe9CZfZew+5kVInIsrpVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmyGCIFU9jNUyV+NQWKpLVWxYjUojqsTXBcQvNYermM=;
 b=H4VepC0ssvPxlROV5DhucN7RPPsxVg+hB6euUx/mmwl6FQ9zJeQPnRAZX6SXCFeYbhc+hFZzNYCdEcTpkftKgy0m6ThHKp4qDqsQpdZsuRzXoqXF9GxwKCPILsI1+FlrdZkWxuKCc+t//b6crE7u7MS9J8eqD7nk16guSa73kG190WWucysuKeaFIk5KEK2YLJF5+NB9QM5NF2H5iKeGYoPD2IMzZJ24MWQjncPS8eDtyqX+Jll7ms7+u9niN4zfOe9KcT60rxSwgjuUDK9AW38nGK2m8W6IICqUn1TZYtbw5GPpmDeknQcfqxD2k/xWn10vfG249aykSrdTWB1jxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DU4PR04MB10530.eurprd04.prod.outlook.com (2603:10a6:10:55a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 08:20:29 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Wed, 15 Apr 2026
 08:20:27 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	shumingf@realtek.com,
	rander.wang@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
Date: Wed, 15 Apr 2026 17:19:39 +0900
Message-ID: <20260415081942.4183108-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0029.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:114::6) To AM9PR04MB8353.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ef::22)
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|DU4PR04MB10530:EE_
X-MS-Office365-Filtering-Correlation-Id: d771fb2c-a55b-41c7-e601-08de9ac7d9b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|1800799024|366016|38350700014|921020|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DN0bZWbcwGiPxMEqNxK5sUx9bEVkqkvNSIMMG6Ia7lulSmyQBOLC6bppJrumpaD4FFj/cNNGp/aYAFSuY6vsoJL+2G/GOqkqsl5PA3xdhvyHOTSpJf5LJ0ZmBPiU8BqXvXA4NwbHCqIGGbqUl8iPwmq2b5rlSldP467s/r522Jt1CUoAMj8Blo46ZRM7eo1cntDBCoC6d2VWn4qtCbKzkotziCM4oSA1wrMHiSlyRmlhnJLLhgqJQsScpH5Ehxg5EO40npbxC0uSCH0mCORrjCIq8sCM1Ibz6wJ2lOWpXn7mfVBTkri3zC/LOBn7qqHcydeSqToLTIcx5qgIVaRdg8xPPLOVu6aPDSFaXreHMhQzkJJ+/YrcCSf1fJ6T9VkvWHo4qTV7iiT3PCzkQGCjoF4uJ1ZY14yvgMNkowENEPECvM8mLV3wmccTU+pKON0AOFTpvVpFO2fAZwsU6Urhu1H6DrREPrbpkBavH3Co24e/rni2Gf8gs0R0TAhaH/isSV1BgzoS8UD1QkQWn5sSHp+ntjhEB/vK3xbdMHRme254nm2wL4AGVgwRA+CIRvmUU7EWKIwmpcDCIIKNm0XU5ztlEHP8Xb8GaF4KQL7bLwAqzTHyB+CKqPg+qQPQVLmGxHXbCzYA4FmJ8k+9SCu+wSrDaa7jB/VKB5H8EYdx7muSFo44SVTQOFTAl+MFufAmCjKQlZn1t8t9LnZunvaT6/5o7M5LzMFDaYvK8utfOoQjMChJwTPzjH+I63TiQRi6IDojDJhj79rS/+qsDcl/VRFTup4Esv8hXApmhjQurArLjimr/WNSEGIgNlowiOrD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014)(921020)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uV4ihnKeKPSkx9FNZdoJ/xmo/VMP7d2vDj8OgRIWGYfWPxMPrymHqzu0AZSM?=
 =?us-ascii?Q?2jfPm93YE4z+1ngcLhhczChP9MjpaACaWUZxOlRAU+TYvbFTx7Tfp0HjtVtM?=
 =?us-ascii?Q?BPmq+tCYz6wOVzRGmEEYYMbRstGtHz6r9Im3PSB3Y3Tx7ZzKO7rsAp+T7m+v?=
 =?us-ascii?Q?8kJTJa5Bu0NqVUN2edC8pN+x8bdwGVq1ovHhZOVZoy8lQJKCVELJolRe2A2c?=
 =?us-ascii?Q?iDcLm8RhZRvEvzvWGDPkW996xPTTUmr9G/ewiI/Wm4ee49CgRskkhiyALTU9?=
 =?us-ascii?Q?3G9jYpH7JS8cmtAWWltNoY6EgBMHQR90tcE81LN/1ijWLgZoK9WYKn/Rc5FK?=
 =?us-ascii?Q?hgIaCFzfR8587qujSGxZoyYxIm5V8/sScAe23JSdVNMA89k8Maq0+lzPDfUF?=
 =?us-ascii?Q?E4niVz8rC7zqxAij86ep35aP4TKnxg+h9nJliBZjibT2x19HkCC4PXAP9BhH?=
 =?us-ascii?Q?Jq12VTXaXeZb8Sck+4RDQE8PeYZiRtluZ6m9f0NJjD012PD4qG3Obh67Ucye?=
 =?us-ascii?Q?13+L/7b25pChpUiHRZMXBUkcQQc0NvFTWpwU/hMiF38j/zpZ+pawDpfhTBD8?=
 =?us-ascii?Q?Y0V98ACt42Wg6uUzp81gYUFAszB/AXvfD+JI/aRuh9zOwtqg0ZD9M+v8qZXP?=
 =?us-ascii?Q?FSbsQqEyrUNRJaJ45xR46OfjQ/4RVco9RxPHbNjzn204KC9zdx2bcnls1EMt?=
 =?us-ascii?Q?P5kif7X+iM0wURX1cVHRZikmX9IRxKq+jG4hHqQh5m+GUyTAUw2qDNXaW6f1?=
 =?us-ascii?Q?B2ZUO2Ge8zjN9ohFk3zO554KmKT2nCijsgyeHmn9QhcoRaMzJkZjN1m3KF1A?=
 =?us-ascii?Q?xIl3KNdgv8AL6vDvjzt9CcRP3DBDNDvzPN5ohpkpb3oOZoEJ/PmG1Vs2eVUq?=
 =?us-ascii?Q?b0cTBIhzLWkA+VloOC36L6TlN3LMTccLtW9YNKIETeFOt/ZQhMdmAa+TiCzo?=
 =?us-ascii?Q?aCy0bu+PhOBPk4yl/jWwpJTrBDvn3i2vTK0oD/FHAmZ9lN2lJcfHEc6kL/xY?=
 =?us-ascii?Q?cNewEh5yVuar7f9+BwGtY2s176Ei4ODY58X0iqthVJcZRmaeR34t4B0L8Qmv?=
 =?us-ascii?Q?kkHs9N4PH4xUn+650ntI/nmuqVtvBYBpBN/+PxRCUvtxY/JxIGHCrAsDJDwH?=
 =?us-ascii?Q?TD25qm6f597/+yHvle5lE7fb43B3z0RNDv/ikT3uJck62NEMGgq59yGVllpI?=
 =?us-ascii?Q?IObQC9R/1Tqrero6bQp96Fbrunr9E93xefsAFp2ZE0hjZ0F3q+I+UI3UOLBz?=
 =?us-ascii?Q?2z8m978GD53mA3rrPajYsK52tFVISqDLW3vyyWnYJy6OnlBFpTDi6B6SBLZd?=
 =?us-ascii?Q?tmay7XGpBFUaFfQbw3YFk2f/cmw00f40PcHoTQS8lVUKdJ5k+p7I1fQGOt6E?=
 =?us-ascii?Q?cfbMSHcr4Gl7cUVNFe+LqN9tHSHg5cb5fKdWktkHBLBeSywLVNdx6epopSUJ?=
 =?us-ascii?Q?O4HzC2FJvxicbtNiPbMgcBIzQs3wV1b/WwAOsbHyceXwvqGaDOUSgKcRzIMB?=
 =?us-ascii?Q?PqBl9Nxj2ZMjuDjQtNwQc0eAmct2LSoYypVTDAHTSAnWwTidFDDZ7AW7htVB?=
 =?us-ascii?Q?bVZBHDgMkMnB8HPLY9RNQoAELNF8W2mMU1ASsBQ9p709rLu46DvpiY8m0uXq?=
 =?us-ascii?Q?kffQTYDlexnN+uil9+N2GbrrfHP0J+IpwN2NnMAy6DvCZMwk5D9pAEZwybSO?=
 =?us-ascii?Q?9L69GwWz71Mmd5oqPoy9jVcpogtUiwk4NtioPLU8nXtL0VsngZfoGAyPpOSF?=
 =?us-ascii?Q?ZQO8YFT8vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d771fb2c-a55b-41c7-e601-08de9ac7d9b7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:20:27.6143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fNW28cmItBx0ca+pYgaa+uKkaQTb4YLM5RTFOEtONAxZuvPzZ4O3Ipx9zUSOLJvMAP7/VXuWmaeXroPwifukEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10530

Some audio systems require specific DAPM widgets to remain powered
during system suspend. Introduce a generic and reusable mechanism in
the ASoC core to mark selected DAPM widgets as ignore_suspend.

The unified mechanism consists of two parts:
1. Parse and store the name list of widgets to ignore suspend in
struct snd_soc_card

The list of widgets can be provided either by the machine driver or
parsed from Device Tree. Different machines have different routing and
power requirements. Each machine can specify its own widgets to ignore
suspend through DT property. It enables flexible policy without hard
code. A new helper, snd_soc_of_parse_ignore_suspend_widgets() is added
for this purpose.

2. Apply ignore_suspend flags during snd_soc_bind_card()

After all components have been probed and all DAPM widgets have been
registered, snd_soc_bind_card() performs a unified lookup of the
configured widget names across all DAPM contexts of the card and marks
the matching widgets with ignore_suspend = 1.

Switch to use core ignore-suspend-widgets support for imx-rpmsg driver.

This v2 series is a rework of the previous "[PATCH] ASoC: imx-rpmsg:
Fix ignore-suspend-widgets only applied to codec DAPM".
Changes in v2:
- Rework to use a unified core mechanism instead of machine driver
specific code

Chancel Liu (3):
  ASoC: dapm: Fix widget lookup with prefixed names across DAPM contexts
  ASoC: soc-core: Add core support for ignoring suspend on selected DAPM
    widgets
  ASoC: fsl: imx-rpmsg: Switch to core ignore-suspend-widgets support

 include/sound/soc-dapm.h  |  1 +
 include/sound/soc.h       |  5 +++++
 sound/soc/fsl/imx-rpmsg.c | 26 ++++++++---------------
 sound/soc/soc-core.c      | 43 +++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c      | 43 ++++++++++++++++++++++++++++-----------
 5 files changed, 89 insertions(+), 29 deletions(-)

--
2.50.1


