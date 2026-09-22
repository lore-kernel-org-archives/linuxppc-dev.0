Return-Path: <linuxppc-dev+bounces-27882-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8556C982F1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 22 Sep 2026 03:30:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hplwL0Fz5z30TQ;
	Tue, 22 Sep 2026 13:30:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790047809;
	cv=pass; b=FC66/dIvYrrz3JxcuvQv8PpG6S9zNPtF+y+Yc6Dbu7iG8Pbf6OA4RrIkjU1SoXxx695KthVb2MhzhqYEN56BQjEV7v1Vxb6KAZ7EjbQGV/DiXr5lY5BdQH6+/xPRo0gDqEW3iQty1YvEfTb9mKAVm7SqDdeDi18yINaEe8VWxfA5cMCGHm0RXKB/0sDbzAWWLSV+Q7jKVhnXqDdluZpg/GRV0yFiCUP9yWH+pmmA+tgpHPnHkVprofwTf9d5ki5MQ4p9oufXCXYUo3SXoLSPYkBNcD2wRTqev6FNU9seySU3DmZAE+l4YFnG52mLg2DdyRlweGBv+AolKtv3q8jTOQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790047809; c=relaxed/relaxed;
	bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BY4V9NbpJJ+poPqn4mqDdy8qpRSC0+gGE8LHVxW4ZFEkMnG4ktVEOp+HWzgOhjU1bqYJtYN49oWtGqp1bmydwwVDPk7agrA7Ps11XKkio0mEir49N2EF3xiFXYsW0EjHaB+UnvBWs6ktuBpj6QTuzzmNCcdIPXjXwhuxYWARhB8SDUf3c0NsbjEiNvfk/uco8J8jU/lrG/pnd24VgCA8rleydkdHwT4d0uobm+5CLUCj32EhsyzJfRZ6hmpd1oU/p2kPj1gsoVXR3mdGS+LFd1VrP2NTMUaUdzVleOyUs71uJO55T0OW39JCz4GWLOWinPsSBJpkb04byAXqiiWFXA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rcPLnEju; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=rcPLnEju;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=shengjiu.wang@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hplwK1GxHz30Pn
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2026 13:30:09 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WekZXmetjC0gr/SbRlf9Lr0gHeU1VI3a4RlSHe4sejTc24tL8T0ugZGsOBqzJ8yRc4dmccNPaNjcJhuK92Fw3suU/D6WeUGyPYu3mPpah0Ewqlt4mH9r8bdFz3Y0I1CRZLTxvg+y779lzEzIvXA47HhKt/SSfu2oAyZFEd+IOHZzf07Hk3myh1O189FXLf7PYj+yfqV5Lop0QBTbwYk4MKp8JA6CyUzApsRdBcVW5qOlsLaAvnP65AuFvDqioiLsYi0k+N4sLUPDT8Xh75guPSUmQ1M9N4oSzdgm1dORy7dVAVUCGogFuDInzfJdT5L6IydvpxYMMnvbtJSBd+kxGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
 b=UHmaY7OFiCNKlxclI3oFX++nKEck3l42QC7RT7ow7pOt8tlhXR+PXwZBL5ya//dAyDCsXHC+JZWdmhbZWJnlguIoVj6TH0L5WwevJ/mbqANX2VbExk6+NJfPYa8WKwwANQs67nkfHz1793he0tIiQYafAHHUAOcWcY5F2N26hN5nDrotS5/i5aciE/P6yzg3V1w67hsqdPzkdKxE0ogeXLBOI2dqaYSYFiFLZOIK7Vy9nalTHmJYWr0GnaDaiNvdaWp8k9bmR9fadxysSuYq81J/CES5wz1IFG7aZPWwBDClZklLrIZgul324zLk0RWTnBGu4KvoGWpfRGt/WF3grQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqoslq9+UXKbgYbbpzruPuNUbkPeE6MWTCD6fTdZ6rk=;
 b=rcPLnEjupkPOqSoZg26MNdWyw/NchDsuW0DGr8dY/yJWDOAdwFmKsxI0FKbXlYEK7860IgjKsPEDmGMWKFeEPM5AhB5F88cPtcZuorKgF+Pvun4voZEBwocqBdCAPilGQ7uBkmNRtN+km7KCLD4pRC9sd6H8KKsEdfCi/4uksaimWP7VP3dgAsIXuK7y4t5BpJiHUSc8F9GXx4QG7coLvGArclcXc+mcjut3+N5r0JHka6GpOiD62dQnpgHSc8dG3NfidpxbS1/XVM3eJiSsqSCyaKM4cd/ecqotgG7Tp07dsqKcNqyVTzAv5D/OckOudAUUgEtgHJpt1QRr2jy+IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17)
 by GV1PR04MB10941.eurprd04.prod.outlook.com (2603:10a6:150:201::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 03:29:59 +0000
Received: from PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa]) by PAXPR04MB9351.eurprd04.prod.outlook.com
 ([fe80::1058:a430:52c1:5aa%6]) with mapi id 15.21.0428.011; Tue, 22 Sep 2026
 03:29:59 +0000
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
Cc: Shengjiu Wang <shengjiu.wang@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [RESEND PATCH v5 2/5] ASoC: dt-bindings: fsl,easrc: add ports binding for multiple conversion paths
Date: Tue, 22 Sep 2026 11:34:25 +0800
Message-Id: <20260922033428.1690822-3-shengjiu.wang@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0361.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:219::7) To PAXPR04MB9351.eurprd04.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 3a827790-41ab-480b-86d4-08df1859c7de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|19092799006|366016|23010399003|921020|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AbzE0HZCH2Qc+yxau/lzsDN1HCFo1/kUETJVW37EBQdMTNh+2uMv3bJhKah6fwCQLig6DjE84ztC1P5SL+4Bmt4EiwhiVCcMYk/g4D8wSx4+yXBQXTnGmffZk8oVKarJg0U/Y9U+PHHhfhc/zJVKIX39WR4cOa5sFpbfN51ZuFhyWYQadXqisAWyZlUxX2AD1Yf6SEOgWhDlMWPLbVMBcGp0WNQm8wUmdFI9UfYCtt/uVdlFN0/hV7I5KUkeFNRFP4vmKgGuumpdRTe+bzL+uBfudfz8WR8jogAby4XH8fPljPJLVHk2NIqNQKWP7OK4BUYf8UQlYLvE4yXi0gJcauRawFDIl16G6uitDj7uN7P0Fe+N+tXe0eNUc75E1A3YWiO6KqZlRjcKNu7eCdCSpSH0FlpqnqEwd99t2xtf0OI4DSjk/KtNoQab4ZhmoX7yLAU6A3CxsQe2NmYXy3C3I64mpkul92/V529TD2pVTFbjJsdMFmGALz8RWp8jv/tdmvPgoFcRuo4UNs/Dfwt6TR4Jsc5hD23Mfy9WffWlejLDFoElAaYjp7cLi/mCnrh4Yz7rFUUSB1Bv4dNAl/HiQHA2LRh6zHkFj2D18pWiQNT/H+ttjKM8j3GWotoCekqGPVr/ioRo1amS5lnbHPBErT+KY68ihudfdZiptmtIPVfyAjSQyyl28DJ6jdqpKYEyXUM1iu+H/LmqWWkVAQ0hLw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9351.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(19092799006)(366016)(23010399003)(921020)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9/KOZAmVA4tO0+7MWfInZOPY+fYdsrrgZgJwDT2tsuE8J61E4cmz/vCKNf6?=
 =?us-ascii?Q?KnmXTfHftu/zDV2EXMY5VTf+0RPbKuVi92o97OoDgeXXnf1UjG2kXVitpEGW?=
 =?us-ascii?Q?TML5kp/JN0dtZmVUxMY5gpJG3PgR9s3ZRmIxLt9L1jMpITTviKxuytfwW23G?=
 =?us-ascii?Q?V3zGz29dxPC2zTSYstKrjfhK8f1/ysV3OUtBb2+qfWWdd1hIxN7UHdL0MKkL?=
 =?us-ascii?Q?8KrRQPRKk+9JGkfyuE+eUjt5xbhoKTRAbR+eIppxFKvKyTk6XJsY6Uw1E5WY?=
 =?us-ascii?Q?f4QEs5iBe7AWC/HhaLDJjTQfa81R/vt6VMTpM21aNhHaYfAAp6aRUuvf/3xC?=
 =?us-ascii?Q?vPoIrcrrq0l2Fr9u+RY3+TBmDij10nxJ3wCjVS2cYy6Y+IfI9FOr/yRs0a9h?=
 =?us-ascii?Q?WAmV1uMQBmVJYN79rJb1JdFvJomrgkdfwdD2ItjcjuWwmZ03k5FYxmsdIwGO?=
 =?us-ascii?Q?qXzBrLzR+5bIhT5DQ2dLSK6Y3MhbiePE7zpGoJHDiOmj97h2eE0MIPaaBANu?=
 =?us-ascii?Q?cW7xxsgTLHWjnDDMk/UYXy8s9JQhRKqPJEXYUvH61L1s60Opg6VV51r5rWEb?=
 =?us-ascii?Q?grM1kVJ0NhMjjPDhvm1AKo4bQH+EF+9e0+9AzQQsMEzUMwZZUY3zEXnztpIr?=
 =?us-ascii?Q?oeVOmi4bsoaxrEI+Xd7AnOopy+vzirMaKDPLwj2ttstQgkBYXvbSGtTP3wW5?=
 =?us-ascii?Q?8EAYb3COIHliexZJ5yzu5Uu9/Rp31s0rnH7aPJjjpeYK9TG1KPOED7yUYxtb?=
 =?us-ascii?Q?d3MwCI4AgLH9FFBgOJeZnA+sqHcd9i4aUqVJfo7kBIdc1HtiDW7MI/mxKgnT?=
 =?us-ascii?Q?MogrbHkGKbpBALEozmR2qEh15NR6dMBmgepYowmxrACadh/+WB/U3bju3nJu?=
 =?us-ascii?Q?xp+xnitgnXIP5P4LNq5c5h6ArKY/e8JH3QgfG3heWHbHDelK1tT7Eihr1Ph0?=
 =?us-ascii?Q?BBuyxwasIstRX7MJUgMydRmD/GY5EhB4Ls4MxHEAeYnk9vL07vUQepYPQHVV?=
 =?us-ascii?Q?NBQsx0obeWg0EotP4wTzPGI7Amorb5mXRrIYNNKRp2keycOtSyw0IibupeSz?=
 =?us-ascii?Q?fK99GTe3C+mnVKwCW42PwC/Bn4DSp+Uk1K1vpPEOdMk5yni0jUv3TPgxsPV1?=
 =?us-ascii?Q?BmPJsMJ+xJ+N5nA5rWT+DKzy11qF8xbEJ/DRr5Znv7fB1kDBpp1AF2Val9tQ?=
 =?us-ascii?Q?KqW9oNdKqSmYvXKIxz5SZ/8SZ+ve+PbWKQgWRC/lwipi2BmjDlscztKrZh6w?=
 =?us-ascii?Q?5gIqgcWTb5S5WTyvPZlBUWzHOl9oS3Zdtc7Hy8ylDm+557rpHK8fPuUw6XTe?=
 =?us-ascii?Q?L4t9s0rt+plrS/ZNWoudHWayP+nlCUe8hkdknrjELB2tIlIpNf/TnI5GWITf?=
 =?us-ascii?Q?35DW3YmQD2LjjlvK1OhW9FK4SpopV1VwrUnX5K7+HhWOETdT6QEmnUsNzFVp?=
 =?us-ascii?Q?KyqCcvPh94jl897dxpa8mQyTtYPq+aWIXkcipQynZuo+4KU+i8Q/4Y97mx3j?=
 =?us-ascii?Q?Hl1aaiEif6tFOa/HhrgBfrgUwj7emY0uZXkOWEAdQOeZjgguPzVg35UEWJxj?=
 =?us-ascii?Q?+diedU5pHNaR8EjOZfmvunmHyxST5Kc1jci2io3GvGzeE1gdyvPHFyiJk2h9?=
 =?us-ascii?Q?JL47gucJAeTTmohibIboZ+5LFMfEZ/djCCboal2yoH1kk6sh5ei7GRjqsmcJ?=
 =?us-ascii?Q?ZF2XDhqyKcOJSylMZLkuShW4NWGuXc03pOmGBnk0lNej/RgUq2SUqbP4J3pc?=
 =?us-ascii?Q?xCusIYvuvdn+ya0e7lW/8eK4/UipynSVVOJ9IR02+gs1kybh69kq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a827790-41ab-480b-86d4-08df1859c7de
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9351.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 03:29:59.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OqWwiBI6XsL3OOKNV8UGUoGpmzTP9Hyy6bZYZrlaa+y9G9AJ9JdWUnFks728ovxVbc4WUHcvF9kvypEPXEDSGGdhhHhXK09vSGEWyShrjtOYhQYPa4Az6U2oR6hixH2d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10941

From: Shengjiu Wang <shengjiu.wang@nxp.com>

The i.MX EASRC hardware supports up to four conversion contexts
(A, B, C, D). Add a ports container property to the binding to allow
each independent conversion path to be represented as an individual
audio-graph port:

  port@0 -- conversion path 0
  port@1 -- conversion path 1
  port@2 -- conversion path 2
  port@3 -- conversion path 3

Each sub-port references audio-graph-port.yaml and follows the standard
audio-graph binding conventions. Contexts are allocated dynamically at
stream open time; each active stream direction (playback or capture) on
a port consumes one hardware context.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/sound/fsl,easrc.yaml  | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
index d5727f8bfb0b..a53ec4f6f1c0 100644
--- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
@@ -55,6 +55,14 @@ properties:
       - const: imx/easrc/easrc-imx8mn.bin
     description: The coefficient table for the filters
 
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    patternProperties:
+      "^port@[0-3]$":
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+        description: port for an independent conversion path
+
   fsl,asrc-rate:
     $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 8000
@@ -106,4 +114,41 @@ examples:
         firmware-name = "imx/easrc/easrc-imx8mn.bin";
         fsl,asrc-rate = <8000>;
         fsl,asrc-format = <2>;
+
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
+                playback-only;
+                endpoint {
+                    remote-endpoint = <&fe01_ep>;
+                };
+            };
+
+            port@2 {
+                reg = <2>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe02_ep>;
+                };
+            };
+
+            port@3 {
+                reg = <3>;
+                capture-only;
+                endpoint {
+                    remote-endpoint = <&fe03_ep>;
+                };
+            };
+        };
     };
-- 
2.34.1


