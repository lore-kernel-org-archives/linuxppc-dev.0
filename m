Return-Path: <linuxppc-dev+bounces-29249-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7D8CA9ED1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 09:56:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3CWy5Y1lz3c47;
	Mon, 12 Oct 2026 20:55:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791798942;
	cv=pass; b=KWvj8CQBa42rpYN49/Kf648bpierWep7bZNvxAfaZdl2f/3Bm3JS72qn0CEVwhTuB2z6zXSOt+byHD9FDEATwvrTyFRAmkIRnue4KXutw7P1IE3JezLFdb/NZioU68UJF220g3Y2q4cSRXfd1tSh1O36K7jQ/WgVb9bXrE2UMA6auWjDuLlifZhmKgvl6QAa1tQTE+UcyghRDV6doVj1SCC0SUitshJhkoviVKT7I8iXvIgxQek2GOIEtm9fRLhGNnpDfLbGrT+onF/PH3qaojCbl6CX9fO/RFFLPicy52ZmR+tJlzItwZhZT8h6k7ap5voWcM69kO/SKvUkyB1zAg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791798942; c=relaxed/relaxed;
	bh=+0gN/BB7FY0AEmijSPXT0P+5ziIH558yKgQ4pIyaaGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OY5GqbaOpFRbJs0QEHvgwdYNewDrKH6dAO9LPVKCtBjyt42AtJRIT7RDbHtBAnsm43sXd/SDbnK9Dv2xzGP01skZgBWwnoVbrNtFH/iQvnFDY+Fk/yVkcFhPOb2jO5Zwm+Ssnh07I0tpxgA9wTyOMoAS5v6KZfD5eFtg5TiB0CU3EPTOI1trMLBZI4qWQiiftyAkRJt93AIIiXvSOyZhlm2FTLnn65sCYPMYe20Ew2yqVzhmYQCYRu6AJNIyrSECrsBx1SH+iGaU1s5iCJA55EgzcK9D/vLLG1DmJScyWzw3SBDUv1ZkCECxpvs/FrXAefzSPiTjnUPbGe4xz2QLMA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LuO2EBVq; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=LuO2EBVq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3CWy06lMz3c3W
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2026 20:55:41 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTNYmJR+aB+KiC6NaRiCC6iMSbEj/2B/jdfHHUWZQOfYiBx+Nr1jhVdGW9eKn2TFKJAfu3rV+kgKpqND9G6DtIUmDgNYh+rVv0zzawzcougoxl6YdHUzvCPgntrPohPz5wmit++hh4YzRD9iyNYu2NnXVMe9rB9tVzLhxhzTWEo0ob+FAkLXudaHL0NLzhd/POttgLMpNVKwZvhhF6LjpefUuXHBTnd111+8oixWkYAkrcq+3RsZQ63dn+Ef1gj/6OC0dOO5YAQxZsG3Gicyud+YvUEFp2EuGmDSWDgTEIpME0Bv1wzLpu6ixEohw1GwT9/0VIzNg3qa0O7EjM7Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+0gN/BB7FY0AEmijSPXT0P+5ziIH558yKgQ4pIyaaGY=;
 b=X2dGo31A0GEr6DKNaPwQYeYxwr/IyapMvCGSFmRlQlZe2zYIAMGEhHRNcEf6K22szOvNS08+yofsstOAgHWq/XQVFCYpRm6/kL1GbUbeu4leC8fxRRSCUejV32jxXrxZHzElY2BnWwUMql6BvOSzxWc7FYuVIkhZ0tTPVletg/lrb3asShh+/9mvERaIMYmiX4ZkwwjRErH2XCBZr394Zz0NuTiewVRmbMFH/LukJZrEJOa+OFI/zicINaJ3Tp6dUIN1Gflb4b9NzB8/yTYfL+eT/TCNRA4/NZ+i7aMdQ1ZsFyDh/5k1d27TtjR+0OW+aDkjXZybVzX31GNjLmX83Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0gN/BB7FY0AEmijSPXT0P+5ziIH558yKgQ4pIyaaGY=;
 b=LuO2EBVqrrBWuGPn+FvcMeduSenPaP1H2CszCSDChY5tTLR++wOGL9JJkmiaDTSZwCD9euYOrarT3pa4/d6PC00zvDFWEjrwoZKM04L1Pl/HTVov2e9SzT0ks/++Jhcy1evF/9fCHMxC7KB+8sbMHcwmiYVZNnCZ3Tz6ocLMqNXNsoIW2aqLwjLn6HYYRTy6R1u39iJPrjBVSS/rHdj5D/U5XVTUwmffZAgjDMRtd1syjzM9VUAKS0MgjkHwCQPnVGkpnBzjIEtGuXRT0FYP9EnLT2eaUsuZlvFGLspamkvkefddqMk6l3Y4egbJjItCOXOrgSj9xyTegPxTf+RxSA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 09:55:38 +0000
Received: from VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74]) by VE1PR04MB7216.eurprd04.prod.outlook.com
 ([fe80::a9a5:cf83:dbe8:1f74%6]) with mapi id 15.21.0496.018; Mon, 12 Oct 2026
 09:55:38 +0000
From: wei.fang@oss.nxp.com
To: xiaoning.wang@nxp.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	richardcochran@gmail.com,
	linusw@kernel.org
Cc: wei.fang@nxp.com,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 net-next 7/9] net: dsa: netc: enable ingress port filtering lookup by default
Date: Mon, 12 Oct 2026 17:59:22 +0800
Message-Id: <20261012095924.1129312-8-wei.fang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
References: <20261012095924.1129312-1-wei.fang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0336.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:222::14) To VE1PR04MB7216.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VE1PR04MB7216:EE_|VE1PR04MB7248:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb29c70-a028-44dd-18bb-08df2846f80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|19092799006|376014|7416014|10067099003|3023799007|261009223027099003|921020|11063799006|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	H/5cLzryN5R+esHWbOYk7aLYLbVQZbzu1JGyh5VbzisXLribInnvgHIFIKR4gcWJdsu6wzNwOF25i3psBGSHULATYq4x7mfK+IaZvXJRExTNARsyxr/WvdSwg3heX0LUD/sFTx7JQAaFFT4oK9aEeq6UkQA1tVY0hqIZUtBvfC1tcN3Mi7nC/6V3KmTJ5GzdRLB/oMqtXSD5YuOi23mgbEu87Fk+YvvWoMvCebJKUZUqZpBWUbwitUTo4YLeAqkSIHVeuuKdpw/AhQ8ZXSaCUoBToPT5z/QsAm73kuyXR4DjHGaPrvCPmO1bP+fLLMzPcEGkbN0oN/F1xLdpAEostVhelfclJSOAG28pmFf5h8tqT6B8RydJaARWwkTj8joI/uuwu8IaI5qt+j4YzxowOHI3NfriHq+vZ/1E2NnfulEzBkq5Q9RFizHX86dOUh2UP5ccVYcChTuUTNOdSYYiSBYQZqiZq8WsDaUjD/QcmvdqMzsrKcnMDR0OojQGXAEBkYl2EBPDICm0R1bljn6yYscpFcRWln/uvbD2j9J5K2tQOJ09d9/Zb9ynwwbhnGCoQSX8aSnw0WUi4ZMakpobIbB3499JnFSTPLMO92rw/pekY+/fFiVGgSfRnJDfyNwiQS7rQydcs+FAJxp0LNwmhRfdP12a6DOd3R+bU3Qx0lFIVdh/NPHAMCIdHUxkDuXEMK8wUQjVjmUwtu6sxrfp9Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7216.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(19092799006)(376014)(7416014)(10067099003)(3023799007)(261009223027099003)(921020)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+G6NTx2NGXrnSNfJFl8p9tHtCgicYHAz7wOnEKYGFcjHp4l3ToAl6Kd77m9s?=
 =?us-ascii?Q?Wm3NNY/szXc6pDE09Yxl7elD+DmmM3U76IYcKK3BlCXtZ2Sid5XR2IsCB9/8?=
 =?us-ascii?Q?5pgJ8Ji8FgJOS/b0nl+wHN1m/8tml/u+AC+WbdafLeZg+jDMRqaUcIITjLZN?=
 =?us-ascii?Q?JlzcMByVucVsYxLfG1G7Yh29Qb0xjiXPByede9pyIdwAlbVNLNdN1vpQiSMh?=
 =?us-ascii?Q?q1wKL4Dwp8EcoOx1W9cF3xN4apoSOuFF5j7xiLSqat5U4dVA0f3XcBUAKQUN?=
 =?us-ascii?Q?bCS0L9I/EQiI2EYxnYE40v4rQpcLofnkT8U0SNPwKVlGmIxsOT7kjpHeng1v?=
 =?us-ascii?Q?+pxhQ9uqSqTaf1nBJ6nQPmBRIf0KwsDVLmi2AwP1d9vTh4UYjIF819k1ybsk?=
 =?us-ascii?Q?s4AerkXiE9AidTR9wYFmn+PxszHVL9P6LxqUUgPSSHgJNDhfCW+TWBxRcVXv?=
 =?us-ascii?Q?1NlPRV8JjhGrgQBSruOFSbtTa7H1AGAuhFFwdGhyFDTI123n8KtdbnU9eZiV?=
 =?us-ascii?Q?U9ko3MsfGhhRrG97zJay/TPvLHPP+VjvW8FTzaViur9XY6nSBwLdRH7ClROq?=
 =?us-ascii?Q?BMsQUDrLU0KZWNdkr01oWkyOy6Y288FvHXhQMwsNJpNASGRPWuAbvvSvd5dI?=
 =?us-ascii?Q?VD/AojCaKQg4OSNT8fDg68W/mhI1xa+erAJKCa78LeecyHfwzpJvMAmmztHI?=
 =?us-ascii?Q?pEaL6d5qyuDao99DAfMmPMQOSzoaVKrcIAU3AjmDdxJuxBBvbtlTvU5aHzyg?=
 =?us-ascii?Q?WV6HvjrtkP+D4o4B2xVzO3gS1+sNufXWB7O2iah0hz+khuZxI1PFwFxa8BMm?=
 =?us-ascii?Q?PYuY6NIDADr0cPVQ/NkrYICcdzJFrBaSQkQEUB36iwptZndWXhWaQYEqwXtd?=
 =?us-ascii?Q?gRj10VqP++sM49UxZ0lhy3m44AY+Xmnh0UIn+PnhqaH7DyFHVfmHBWwCfUAr?=
 =?us-ascii?Q?hZCHLndBCwlHkGCBzIn2eL9mkDeRGP0cmQUAwWrGATfFUIPuE6f9AUm7Xd74?=
 =?us-ascii?Q?94biFEiTCDMK/t6EZaJ+dh1xXSyxGHqbEuXIqGekifg8fHUlL49e6qkPFsch?=
 =?us-ascii?Q?G0yAehSALn9hlWv3hp174tJu7RkQsf6qB8OlToNQAr+93p1+0SJGvmZr4rbg?=
 =?us-ascii?Q?m6dd3GegE5P7xzNp/z4Hm3Ap4McS3vImjsA/5xLllID/rBlLBvMXwlOPCLke?=
 =?us-ascii?Q?wDQfWVhQ6SEZyxWGMQDytb8Is3wawPGsmAfZTOcnDISrGwlLVC9hf/5nA/xo?=
 =?us-ascii?Q?ea3+qALBnsS1LuEYWmY+sMXhBdC/WqokdwnnuA+qPsnsoj8kKqIKikRlRfc5?=
 =?us-ascii?Q?j+tVD0Z8hCx+tJZQKEXEpbuBjvNES41aQd8QlKnro1ioEyJTmLPWd2QQvEs0?=
 =?us-ascii?Q?uKA7HdasSiXlX7YuBxb9FbrW3M0zlS9YF63+2oDGgF8vIoBmkqTaqAtRFFw5?=
 =?us-ascii?Q?tiBUVeX15Pmr3GmhBi6A5TVEXuKRQxbLa1LCgDyAOBosAdRbrVob89H8O4cU?=
 =?us-ascii?Q?9/KNlBuLOvAsRHogCWo0LguCVM2OedQPxJYq/nVyNaonqKdqtD9DzuTbUF6X?=
 =?us-ascii?Q?uX4gug/H8SkKzyz0jn3MWmu/C41ulb9VgY5ox1u49AyJUPmr1m+2WE0mimcZ?=
 =?us-ascii?Q?2pxnx57G9X4kbAcThghI4PZXLgTT+wxHshNEExlo4MyxbL70bs64hF823L0Z?=
 =?us-ascii?Q?f1bAdbDTFqBLGBkqTU2eK8emp6IsE2kaKPe3V98YYGDBPWb/VgITzFg5ZfIY?=
 =?us-ascii?Q?5ImvPPginL1KdxVawagPK9eWmnFCPfD6d+d6PJLSE5tqX7LxUaBg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb29c70-a028-44dd-18bb-08df2846f80b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7216.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 09:55:38.5500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TfrCgOhEe8uuac8nv4RxGu8Cnp68w80/o+W+obuMVJbMNIHcrWlR07Z9jFUNN1/TKBLxe6Hkl34sPFOsmy3lcXWz8HKcERRs4d6L6MNkUTVglAa9dAMg+Lnj5g2Ruuzn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

From: Wei Fang <wei.fang@nxp.com>

The ingress port filtering lookup function involves performing a lookup
against the ingress port filter table (IPFT). If the frame matches an
entry, subsequent frame processing functions will perform corresponding
operations based on the parameters specified in that entry. If no entry
matches the frame, the frame is allowed in, and passed to the next frame
processing function.

In the future, the IPFT will be used to filter PTP frames and support tc
flower. Tracking in software whether any IPFT entry exists for a port in
order to decide whether to enable the ingress port filtering lookup would
increase code complexity unnecessarily. Since enabling the lookup when
the IPFT is empty has no effect on RX frames, enable the ingress port
filtering lookup unconditionally during driver initialization to simplify
code logic.

The only concern is that when deleting an IPFT entry fails, the hardware
will continue filtering RX frames based on that entry. However, we have
no choice. We cannot disable ingress port filter lookup because this
would deactivate other IPFT entries, which is obviously not what we want.
Moreover, deletion failures are almost impossible under normal
circumstances, and we don't need to be bothered by this minor issue.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/dsa/netc/netc_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/netc/netc_main.c b/drivers/net/dsa/netc/netc_main.c
index 09154781df7a..1a7103fe1e34 100644
--- a/drivers/net/dsa/netc/netc_main.c
+++ b/drivers/net/dsa/netc/netc_main.c
@@ -618,6 +618,12 @@ static void netc_port_fixed_config(struct netc_port *np)
 	netc_port_rmw(np, NETC_PCR, PCR_L2DOSE | PCR_L3DOSE,
 		      PCR_L2DOSE | PCR_L3DOSE);
 
+	/* Enable ingress port filter table lookup, if no match is found,
+	 * the frame is allowed and passed to the next frame processing
+	 * function.
+	 */
+	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
+
 	/* Set the quanta value of TX PAUSE frame */
 	netc_mac_port_wr(np, NETC_PM_PAUSE_QUANTA(0), NETC_PAUSE_QUANTA);
 
@@ -1836,8 +1842,6 @@ static int netc_port_add_host_flood_rule(struct netc_port *np,
 	np->uc = uc;
 	np->mc = mc;
 	np->ipft_hf_eid = host_flood->entry_id;
-	/* Enable ingress port filter table lookup */
-	netc_port_wr(np, NETC_PIPFCR, PIPFCR_EN);
 
 free_host_flood:
 	kfree(host_flood);
@@ -1861,7 +1865,6 @@ static int netc_port_remove_host_flood(struct netc_port *np)
 	np->ipft_hf_eid = NTMP_NULL_ENTRY_ID;
 	np->uc = false;
 	np->mc = false;
-	netc_port_wr(np, NETC_PIPFCR, 0);
 
 	return 0;
 }
-- 
2.34.1


