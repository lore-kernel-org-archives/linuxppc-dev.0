Return-Path: <linuxppc-dev+bounces-26761-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FB7C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 08:17:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfGy15BSZz2yql;
	Tue, 08 Sep 2026 18:17:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788855433;
	cv=pass; b=PnWXQbAncoFVbryVaCibTnOsC84DESmtDw4DHO3b+QlbTMv35EpZJya5jCp6uEYCslUtuBW4oxPwGMmekizfpcx/CROmd3SqddZSEYRtrngKBnqjQneP/gJIwYcYOvdGc2pK0XrwnZ1oiWI6H/Aag736IXXUzi+6MAmBv3DtEc5tTxjTGK/bzHa0rWMMkSNPcj7kLgjWaKh49qLs87ogW7up4mGCF3+98L1hushRC2vck4fH0UiFbWAOpj/89xCr75OrUbOaBUQQmIiv4heA9rytZdzh7Th076N1wPgTz7g/LggciMQVBuM4rW2BDB8X3R8Wc62+TzBctgi55SHQJw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788855433; c=relaxed/relaxed;
	bh=zbMxHx/hKjFHExArHmHqCcNbBKMeihZvIVXfauvJXiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1aRkbLdpjnyfMjp/HazAJzw9HoVWL7Fm29UEHL5nxWRQRwrVgY8MoeJoNCgceE5S1CfJ2CzeBhjN8hvRKa3kjQFGdJhox33O3Ca59bNjrgAcAVxx+ykxgqC+YTu2L5P6FpY4qRvRCoCERbsp3S5v8qrcQo4O8i6Q3wKeRDoNm+Sl0/XCo5tPttIB3Z3VNu4LCjuP/TjaCcANNBmG9uKo4QMQQpWhjl0ThCqkMaUMZazATB6xqR2Cf5JJIrKovSaDL/O6sh8FX7cW4GlfUriErUrYKRaEljq3c5zkoa2Bzq8t5DVgYytS9tDm8kGfJ8i53EVZT/pjW9lEJY7dioQXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DBdCYiVE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DBdCYiVE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfGy10Qyhz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 18:17:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP8HVwF7UZTrljj8cllLEU4ziOzGVQTxG//DmZQwXYW3sT0J9SwObDIpJecQmT03hKgVdY5kViaeCdlZbly3sBC/aD7ccUpnFm6RrnV4wQfwM1lEtSocIDJ4tufrPAlmgfm9GHQPDXys9bVsA6jedIO5i9g+QgYsGY37NXh08aP9DC97mYvjWRLplvpwYqbbChDcwUnjFbueKqk9dZ+Bybqd2b6hI6bJRVHfTe+f/wG1Fk4MCQ1GWQ7BQix3JkdY8k4/i58SdkbGX1hBKb4jX0DGH2kyl18tcIwQT/vTJ+JgQm3/rRA+oodTsDzdpY7m8EIhzkDPJaUsZWjLIHwU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbMxHx/hKjFHExArHmHqCcNbBKMeihZvIVXfauvJXiU=;
 b=rRzU0Yxb0tdB++0/u83FcmEjhi2tnEIy7dsVGewH3hJxPQmI/bWAvDx7O0ZMl0hBcRyyv2BklU83iYPpem1Am8hW5CAoGuu0XNVI5tTD+nn0ihl2Uj0FT6qckgEa5fuQwjS/Jk0UTjsAI1xkxwhvbsgHvwQVy6ZgqOkwnv1lR+UA/ibgRJpvPeWyaIxB2rwXTls6arTBImB3ZoftAFl5WpEpa0mSc/Pr3/JRy8VAOCIHcfJi+Ser62s0pC+yF3M8dKrSEKlycNZdZ7oNX8UvAHgMuX7SvgDhmFJ5KE48wOFhCJbf6Z59fnZmY28EfkbjQHHkjSek8LyeQLddqvd+Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbMxHx/hKjFHExArHmHqCcNbBKMeihZvIVXfauvJXiU=;
 b=DBdCYiVEVqyckEXZA1H+esPYO3UrE5EHMcEEcU66ORp2h9XksZJNuJla7Kiscaf13yqpFFdNJJcU1j2oUfHASM+bpb6C5mLzwHeboEsyW87qk17QTtm7yMqOaI4M2/YH/Pfn9J6Ahulp9HTwdSxKX3bIjyCDCs2cCsYdRAUar5j0yXwYgHVPI7xWaZ0bhF6QeMcgKJ+QwtJ1vEd1f7HvD6FnyyRscg8Rrc8GV72GOav+PV/5+ol/MMublAFjOoUWgX9MiJRwd9yOi5tjZMgIsXBAesr0/FhqW4yd+jNfi8Wb3iRr3hJwvJHCxUNht3FBuWoQiRji8mOi+ocOZuNl9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by VI0PR04MB754002.eurprd04.prod.outlook.com (2603:10a6:800:364::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 08:16:53 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 08:16:53 +0000
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
Subject: [PATCH v5 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port binding to support multiple paths
Date: Tue,  8 Sep 2026 16:21:36 +0800
Message-Id: <20260908082140.1316872-2-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
References: <20260908082140.1316872-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::7) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9351:EE_|VI0PR04MB754002:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c05393f-bb02-4231-c7c9-08df0d818a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|7416014|366016|1800799024|376014|10067099003|6133799003|3023799007|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	a0I48lKeydaiibJQPRBS0De8dFuRWH+ODBUhJrEW2Z5z5TNSbSWUafcqKTfgrSmwpi74Ch7cq/P8MxEUMGxpKy04c1UG2tMojRT420hdzMav1O5MWPp27VDAu7n8xSwwaRbc9WSoFZPt0034LBinwOEAy/mpWMWDQd93isPMJQ6/+rh6Cjtsj3Z/iQbh7QfKIBpxdSPn1Y5QeJv4cfJyT+Gs3nmvOa3KTofiuoK9qxmjuEjjih7wxbyFMYvlTfX70wy/bBxiyL0HDC/k1yNcJiqHDaxO/7s7QFY+Xmgasvm/2Y20S0v3cbfitVJmNVMGz2GcaefasHQeQXf/fHa/QZwCkPpS/rGBuKS3wtK56BglEgK8p9WmCp3VJwOgJBn3AofVXtqGxOpaH1N/KcuM4/QvhcbWVpbciIBAcDqABdPXHVhZ9tsq2tHJY4FdkAUJyEV37Z4muv8Fl+mz4SXqnUOtt66MdynobBdrmaHTA6nTaGBojgxFw0CFMPaJqTFq1fZ3hjnz4L7upK4gpGgpP3OJY50aCtTuReFHdYposCcmxvQ/Fod2XYIL3xEM+nOjsAzTDDoHJ5H4AW2tWDTH4sfV5fWCUXENtlxpqMp3+jiDAxgKVilTz7tC7uz8DjcEr1AIM7bL5yRL0zEwRczSgdPNy8ozLXu6pijQ3u+lbyzuffnMcXY+SPh2e4cYkZ34UDPNuWTmULh66AutAiX+Dw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?knRwynbRAIb17JNiCptnDuSgTPm4TRl51z3WJK28ZbQsL23/wooH31S99X+4?=
 =?us-ascii?Q?Dek/ul61zmeiDxHpfD5AfMCH5rLzp5bNcMXmESuBgIQLdGCFHtAKl/KZOv+n?=
 =?us-ascii?Q?GkzwNUJB4EGkFZIQYADR0qaFUy1fuYMPXH3bNNHZtycXNuWrK+/Kz6IRtpZY?=
 =?us-ascii?Q?DKWdD95vS0KkgCi1hHs4g3LPUgd9itfMRvj3nFXl+LzYU8dhaUiHoODlDHZu?=
 =?us-ascii?Q?VtfSOD22NqEOeskEb3iWj+/4VUte3GQIi4Ooa7q20gERrfdpBtXsxGiN6ECX?=
 =?us-ascii?Q?Ss67mtw4kV9w5Dpb35Z7oulG6h3w5g+gHZ7kngOR9fKGqgo4Kse7R2x5Ji3Y?=
 =?us-ascii?Q?Dka53opvWDBQ+oey3VQvHBrI/P59xw6Q3vpNafJYpAMt55vaFUKhFFzObuAY?=
 =?us-ascii?Q?6HRxNPAUXCTYONaq+HcfGyG83uiKSzReIuAn+vDd7Hs64ROonIId/k30DbJl?=
 =?us-ascii?Q?++nNQ/SVqcX44bXcGuL8HJy02Wj0LWt3bx1vPEdGXvlrSLgB/20PA6BoGxCM?=
 =?us-ascii?Q?lGQc/7MRgCbutBwDCVJSW2hJMns5nQViSC5++ULpMwb4sJ+T+lOKPemj8wJ3?=
 =?us-ascii?Q?XCPQ7wO02OJz6ClyBsA33cyDzguQuulBS4dGAB01ZexmGy0RIOn+IjdYndQZ?=
 =?us-ascii?Q?cMQ+Ckhv8qILelIcFwq9vEJ0mOkrN8fW91Qs1hc0P++t4OxqgQkVumMCGJJO?=
 =?us-ascii?Q?QtJXue095bVOQrMgXj/VDYcHc0lSicljI9JMVt84spdLWoDMc3rkBo+4DfI6?=
 =?us-ascii?Q?FkqVls/J91RN/hfiEaFGpo2vxVik14W8E6LzkB5+Bkd+5svYy1Y3GekhhJtq?=
 =?us-ascii?Q?ElYUmRf+DAUwsM+j3iS+5P5bWf37hqiYmIbWT2IPrpvKDbOisCV4/RsIQ2ON?=
 =?us-ascii?Q?Z6Q2dT2z04utgxo+sAYiWUgGcV6ZlcRRk0CvYHwsoc4XH1AI/IOVhxUCSPh5?=
 =?us-ascii?Q?TCCzkyeQV4+2fanFbQO6HDu4GCDTaweaaI4Awl/fUcvcRq/1og+6V1m1T1PT?=
 =?us-ascii?Q?P3bihARNwXUBmhCr+M30i8TdAEa+/ZL5PbKDEh9LCLdJcBOQvaJssey54e0k?=
 =?us-ascii?Q?iqPcKanSoDSzqU0XCCKT6ezcBMPtSDxsd2z+euCZEYwNSEcwE4LnbaAd+YBW?=
 =?us-ascii?Q?/+rSZ7H0XxA3tJVJ6n2uU8xgCx1Bk4dS6/l3ESypiqMRDgiLWb53eLIsVqr5?=
 =?us-ascii?Q?NJsYkfqbbY+MN5ujJda8n9EoYrnBG420hQpZlhkGnVrkwx+FZlBlb3T8zSn+?=
 =?us-ascii?Q?X1ki1+ZY9irXO2ub0bugtAiTieOdQSwy0WjS9Z+Jpuzz60MecfUX6I67+7gc?=
 =?us-ascii?Q?kFX05yUs0xnc71Dq0p4HFkwPRK4a/xiupxejonNBvMQtSaC6w4FV5kmTQrPK?=
 =?us-ascii?Q?z6/FL5ru6sBYmqCxiTtcenxVTnpg8nvXRcj/J0CaS+I7JaklLKC9Y6+BR94b?=
 =?us-ascii?Q?JHtHUrsiCwiMk404vunQzmJuDfgttuiGTOv3NLYA62M/5xxC/qwAFEHFGxeM?=
 =?us-ascii?Q?rlBdsZcLzt297FRenLs2GwCKqV/cmqfADCNO4hrLrwnrzFDjN7jFzfFe8cnx?=
 =?us-ascii?Q?0fn3hdk1+B/USj2RBPY/UDI2I11FLNmIT2lV5ah15tmzyeao6gNG/OzxWEgl?=
 =?us-ascii?Q?WUcVSGUbpNO2I1AnhofbzUsm3XSZAdQ7wYLh36wXR27xDm5ZairuFXxOHw9B?=
 =?us-ascii?Q?cDQoqQ2vhgPy51g5oCwU6ffEkRDuZNq8bsAmCrIyTd6yv3tuo2HSULOwwo50?=
 =?us-ascii?Q?Nw8hlQowXyE+Lin1cFV79ZkPjhmISCLKkQrv7RIrsv03HDKMtHgD?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c05393f-bb02-4231-c7c9-08df0d818a87
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 08:16:53.7310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pf46cWLYD9SXiul5FMt9sYxm7fC9xPtrLhNB9030SIYlcpPiy+v7YQohuZ/R8bsipVMamSdwXufMy1/+N0FDIWsh04/bcoSlSWspyPmghBnBxOkJ+93pDQvfbUyDfVs+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB754002

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


