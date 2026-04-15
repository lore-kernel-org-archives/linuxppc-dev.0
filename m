Return-Path: <linuxppc-dev+bounces-19757-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC86FA0C46
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 08:21:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwYxr3wP9z3013;
	Wed, 15 Apr 2026 18:21:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20a::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776241264;
	cv=pass; b=ZRxezXIzefJkkDXiT+pobFd4BIDL2Yixr7VinaENCWPGZvY9AyUqorHf+PkKAXz0sAEDoDVUnReChf2mG6ry8iUb5adt4Ck7E65v4GOCkuZVb9frBMPJIog2POW4k/Tnhzck5aE3SUckFIOoroMhrwo1V0owZbsGAcJJspy7pQ/37LJkZBpavRXeu4TRoyOJliSCswnNjr6dRkeBV5nnRC4Jt3Fpj8LhXpOYv/+xrA8+g3+/1XjEv1THOu9UN82YTWFrbxPlaGgRlHCaLAGfqhjS3YMESdm7rYmrNd0Gug4s/z9AjWAjMLEaSoaLJSRn5DZW/juaJKW0w4se0ERuBg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776241264; c=relaxed/relaxed;
	bh=Lj4ow+POcv6qIcuPkA6csArudyjVdjzN2opgHF+HGKw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FvGonXBlIyiLiPvOccxTTiVi0EBPsFSJ9e0dUhbfuarchqUf95z8GUerjw2laDs/eFHmlQCoIWaiAuzEMZTYnaRyt6J/vKmaNJ+evNPSSyNJBF4r359lTks+smF0MectUhvbP/m1CujCitVp0pH3vQogyXsSdPbMJn+6ljQMCt6DaSfilzksF5J+wA7JlrzxDshKzAb5LkiNSKr8sqaHFCAgJQUiOko8anUPQbGxfmfjf4x6fctWPLRVcHu6Q4I1sFsoNV2a8KWpERstz7CPyjRb3tSjVMHfwUxzNff7MJH4er9IWrER5CfjgqK6hnDsbeFAIp2V7LoQVVp5Aw8PiQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QYmnUQx8; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=QYmnUQx8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20a::7; helo=pa4pr04cu001.outbound.protection.outlook.com; envelope-from=chancel.liu@nxp.com; receiver=lists.ozlabs.org)
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20a::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwYxq63Khz2yvL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 18:21:03 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FwNJG//nBM26R1UlEfC+fEt2TSTvW55GPuZCiTuZ2oJV+wmiO/SxmBYxJ5kAxYV0r2JzglwDTRAMjHhQui4G1lFYINw4T8j4oWN9Q87O81GJdSs4Y+dGL+LI6bcIM9G9lUW3svqBKfFqG4g9ENVFcMNrYjWb14WIcqO55levfBgCLmARS3HddhDCsFpCaKvUBSfjyB2mwcR4M9z6A7VTuw4m/U4qoNpq0FpcU/DxCS83brhtUGPz002dOzJ18YRtA1ckAgV+UWZRqfCUmOQ4i8xxdkqXjfyTJ1xK+ynMCWoZzF03td2sqaR7B8VshEX7Goz01/7UzoMiojwL5QSMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lj4ow+POcv6qIcuPkA6csArudyjVdjzN2opgHF+HGKw=;
 b=e0VjgC815kQUP/58Cjje4oyFS2i27wdlJdle7AxcEjFYJ/jTic8A0PbzwsbkeWI7LWpbWy3BsV4XYD/tdccMXBSI85e3UocuCT8uLeM96PyFYsK6KxI5FyKd9fDwq7CE+uQeOWsSogLFYXcdtdzFHIm7P1710cs9bw5pRV0MgE1i1oxD/e2DyFSIVNDvY9EPgUqoEWLRwWKw6brEipSe7OrLt8iVJaDr8RDVPFCfZVpAQk6G0hxlrfesNNylRlqBoGHWGbRz118ndVDXB+HumfIRWMpYJ1xqa8x67j7GrU4t7u8CJzgsMVYom+LQPnV3UMO9Dch/uds2QyDIsDJQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lj4ow+POcv6qIcuPkA6csArudyjVdjzN2opgHF+HGKw=;
 b=QYmnUQx8p+mWEMxCkGPOvyivRNP9hFV6/xNxTQmLume+tKi9LbxbTDX8BToNTgDYOhbd31RM9u7VcrgYroKIGxEcskP8k0BRZFWTzVYEa0mWtPkd/M8rwXnM+OTP8hO0B7CSZ10J/7QJ2f1+sjmdQHe/AN5o9yhL9Rln+eN9mvC/tQaNnie77uFn615GMWRKs2WBTUPUJ21xE34qB13JqKvDyJwHg+oSkk7qKpv1z40ezCz4gvQjpEbYRe3A9ZIkecPb2fPS7h3EDL/rqMntjk1Rm0pvd+mcNLW+HPTWoqXfT2BxjQFR+iDflfg4FNQk6MFnQCzTLjmT1iHwBGAc6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22)
 by DU2PR04MB8600.eurprd04.prod.outlook.com (2603:10a6:10:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 08:20:39 +0000
Received: from AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc]) by AM9PR04MB8353.eurprd04.prod.outlook.com
 ([fe80::46ae:f774:f04c:a1bc%5]) with mapi id 15.20.9769.016; Wed, 15 Apr 2026
 08:20:39 +0000
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
Subject: [PATCH v2 2/3] ASoC: soc-core: Add core support for ignoring suspend on selected DAPM widgets
Date: Wed, 15 Apr 2026 17:19:41 +0900
Message-ID: <20260415081942.4183108-3-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260415081942.4183108-1-chancel.liu@nxp.com>
References: <20260415081942.4183108-1-chancel.liu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AM9PR04MB8353:EE_|DU2PR04MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1918e796-6ec6-450f-7af2-08de9ac7e0b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|52116014|366016|18002099003|22082099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	VbMPzJixtTu/s7/IpEofYJf0/DOjvGaz7GeyNNd5NbCrxAEn6t7VGVHRcSmTOBOt1deHEH4+/DodoGX0hVMuuhyOT9KwPy4ayzABmSLcZSMA/7/Ldb8itXYsyHk3K8NN4TpM+c1KPwW4RZ3PKCYEhWp7+XBMf9hOQvV6JkR8P0R72d6qkwv15LZ9Egv0BueD6FtcYucJTl6PFrow1XlVG17JUTmxHVKorYq/ppJMQ7ONaDYkSI1TJT+EnciEnpVCkqtChOwJby1M/4fSvQ2yEQdIWQ3l2SdjOzwDkapTiWfvsb1qDQDkCYVv6oTVMX7mMhTiVgSBp3fgje7AHelDgWwrOSeCv34vPhqUPBIEDo4oCaLFO9D1Rl3z5t62i6f4Eu3ofvi4iQ2G5TZCswgcA8nb2rxH+Cj0a2h5rZaIIRxq27q26mZXDRkNmFKruo8JPOvEjPrugOROswuBK5Dz2cE3eG2Y8zZ/ibWVBEw6fNthUE2w2+/ftfXTIbjH9+B22Yxh73fFJ1ojRVMgs0ewClFK3kSfvu26lbEDxZcbss0bUk2lZUThbMAeiu6U6FXVvNgcOoZ0Nf741TyJv83rGFAc6YVRu+HhHVGZV2+tHu8wwIpvrWACCUqf/4ykMToH1A5/KzIIpe5kBtR2AX51EBpjGhAXamE05G5miQvViXqRNTyXkTXM4IcdVq8GSP///iuqiKoj3pWLerN7nHuqByapu7j/Zydd8v7DGUHvZMElufCXt6700v/FF35/9fPcjx/kSMyZ0cJkB2Yyjk9ZiPUpGky8CZh612V6A6SMnYESzeu3KTHaP1lsdjrYAMFx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8353.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(52116014)(366016)(18002099003)(22082099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FWKMuKvgiCPJw1gpZrzVWsQNxPcb/FS0O8yAmtIvxjcRJX7JTlf297JbJ0bx?=
 =?us-ascii?Q?SS3iptzNkBS7snmQF3/CiCQoPZcza/q9GSxKHTOxy7VFHhSSoZ9HAUw4iypZ?=
 =?us-ascii?Q?jtJXD6JO8RBnS8DxCc4n0H84M4IQAHCF5XPkQVE0LdTQhwt4PzeCpMSLcm3H?=
 =?us-ascii?Q?WoFXVuLxnGaIqVmBxN3tp2ocxVD2aD7CZnmZ811LLnDJbX0qrQRtZ/oNvTif?=
 =?us-ascii?Q?jo8oQN2RMK7ckfUX2vqdBYoMfUlh/GL/x2LlQVwjVqUKQxV0Ej4RS+rAF/DF?=
 =?us-ascii?Q?PwGwcqkntP9DksYTHtzfEhJepcwjkLr2g0NR6cId5MO6YNRx5T3iwRYGzwNj?=
 =?us-ascii?Q?8PGPWhIj8goDshIf3XZcOE8Nfec6yIyVBb1Uk3dIyTm+4wJJOQt1nfIiSMjz?=
 =?us-ascii?Q?4G3EUs8igopR0uM3+8tNF4h4Xe4z5Pk8KhJYYlZ87EUk2DZmt/1m+PDoHwfy?=
 =?us-ascii?Q?0fSV4Fx/ttahNv20bCvQmyMjTTkVjhnK9xA/g8sElLJ7FbZEvXaN+zVWBYPC?=
 =?us-ascii?Q?JG2zEkHdrphSb7Vdo7nK1E/jB+xJr6j0nQr1lZ0lDvL0OhxUFBdQFCYHX4WS?=
 =?us-ascii?Q?Mi14fz757FokC6SP6jjLEYe/M6AysqLRHLugLPwOsyf5EnhVokIxrc0iMxWy?=
 =?us-ascii?Q?dKox3K5mNhN1IJFbzYsjnzR10yt2Wm9Y3MtWwJM7OGwxuz4aU3nngmHdRfY/?=
 =?us-ascii?Q?2kHd6bpxkvmgLAUiJ5tjm9s3YM2s7f1aSqpqc1oetG64H6xFAyc6IockzuoM?=
 =?us-ascii?Q?xbGl4nOPyKgzpDntH+YmyREJ5/1FUDC/GkZkU0NxpD6nBvUXLVcQOpqcgteU?=
 =?us-ascii?Q?0vGJMqBZVRtBg60+VSCgLxlatlZLwGcYC3Qy9bIyDs/kcInTWa3jGJTRdq6P?=
 =?us-ascii?Q?/1CEiKePQf0C6OkyAKaDSR+D1r0sQUPojP8F5gZp8DzKilpqzQGopXQLQHxt?=
 =?us-ascii?Q?Ue5rwzmjVtNxpeyitYxuTkBaeNA0yKLT1YVtTEGIxb7/7pTr0Czr40HasmuY?=
 =?us-ascii?Q?R/LHZbj/vGjeBZLlEJliEbYVhLMxy1sxC993mGEaBW++QkDR7e5GHZ/zu431?=
 =?us-ascii?Q?BPR7CxNQ29oO35D8iuKKP35IuDjCIdKMvt8YQi4KR/AqAAxflcwQy232gRNa?=
 =?us-ascii?Q?umY17jVR5V8ueIj2R3GiG/zwm5J2FdBWqNcUiEICchVgcPcNqjy3HJbS2otm?=
 =?us-ascii?Q?66jmDCYPKJnDg8KA5OftD626IQDPanzBpo+S20l677NzMHVexWENluWgR5jp?=
 =?us-ascii?Q?tBBa3QnuUgWY9pO+5qy0dMnUEL3wWD0PPhGufmwkkEku2FUc2Rx8mxpCeS/G?=
 =?us-ascii?Q?M1mfYbO2ZZskyjLzS2WkERP4yeNU/gC3RRwWgy+2Pv6IgkJB/r5BwsDyaOxp?=
 =?us-ascii?Q?SHTjfu6YS/YmV/W/xbpAxrT2+cjJ8Z8eUx39Yui+dMc8OyiUU0eC2kPwxAgz?=
 =?us-ascii?Q?6YCc/kAbR//W6AZCWK/n/C5jm2U7OKXSSRgzsvjQb4MKeoxPSGMqMRNfEoqv?=
 =?us-ascii?Q?ElFTF+e1ujgS3FEkBSEqU/vSo/j24YQMhuoR2cPGodw6V4BeFYChdMytHOft?=
 =?us-ascii?Q?vlAbz8vAT85fRQ5IeOH7k3k2bp4sY0/YS/qVkgpR/3IYIOmFgeaDYXFYjUJ6?=
 =?us-ascii?Q?vPrJZ79xyBNZRnkzGqnkOqgKQMKiNh0RFoo78XKRsJcV5guyTqaf8KAosp5F?=
 =?us-ascii?Q?+iFrcQsDbqgUuUvbzS9+pySVyQULqSoCsSB8mgeCVky0QD39puLeiw6BMS3w?=
 =?us-ascii?Q?hgBSXNmHWQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1918e796-6ec6-450f-7af2-08de9ac7e0b5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8353.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 08:20:39.3418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1lG8+Ebfde0jGJOcwTG+UUpwblyNsbUHXDidS4FemYhxEskN8u9jjmB3eBYMgXYvllga15Znw4mi2CXCIsO0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8600

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

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 include/sound/soc-dapm.h |  1 +
 include/sound/soc.h      |  5 +++++
 sound/soc/soc-core.c     | 43 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/soc-dapm.c     | 30 ++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 4f8fb7622a13..39c290e0eb7f 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -636,6 +636,7 @@ int snd_soc_dapm_new_dai_widgets(struct snd_soc_dapm_context *dapm, struct snd_s
 void snd_soc_dapm_free_widget(struct snd_soc_dapm_widget *w);
 int snd_soc_dapm_link_dai_widgets(struct snd_soc_card *card);
 void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card);
+int snd_soc_dapm_ignore_suspend_widgets(struct snd_soc_card *card);
 
 int snd_soc_dapm_update_dai(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5e3eb617d832..7d6fa79f48e3 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1057,10 +1057,14 @@ struct snd_soc_card {
 	int num_dapm_widgets;
 	const struct snd_soc_dapm_route *dapm_routes;
 	int num_dapm_routes;
+	const char **ignore_suspend_widgets;
+	int num_ignore_suspend_widgets;
 	const struct snd_soc_dapm_widget *of_dapm_widgets;
 	int num_of_dapm_widgets;
 	const struct snd_soc_dapm_route *of_dapm_routes;
 	int num_of_dapm_routes;
+	const char **of_ignore_suspend_widgets;
+	int num_of_ignore_suspend_widgets;
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
@@ -1339,6 +1343,7 @@ void snd_soc_of_parse_node_prefix(struct device_node *np,
 int snd_soc_of_parse_audio_routing(struct snd_soc_card *card,
 				   const char *propname);
 int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname);
+int snd_soc_of_parse_ignore_suspend_widgets(struct snd_soc_card *card, const char *propname);
 
 unsigned int snd_soc_daifmt_clock_provider_flipped(unsigned int dai_fmt);
 unsigned int snd_soc_daifmt_clock_provider_from_bitmap(unsigned int bit_frame);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 3fecf9fc903c..705181dae472 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2289,6 +2289,10 @@ static int snd_soc_bind_card(struct snd_soc_card *card)
 	if (ret < 0)
 		goto probe_end;
 
+	ret = snd_soc_dapm_ignore_suspend_widgets(card);
+	if (ret < 0)
+		goto probe_end;
+
 	snd_soc_dapm_new_widgets(card);
 	snd_soc_card_fixup_controls(card);
 
@@ -3294,6 +3298,45 @@ int snd_soc_of_parse_aux_devs(struct snd_soc_card *card, const char *propname)
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_parse_aux_devs);
 
+int snd_soc_of_parse_ignore_suspend_widgets(struct snd_soc_card *card,
+					    const char *propname)
+{
+	struct device_node *np = card->dev->of_node;
+	int num_widgets;
+	const char **widgets;
+	int i;
+
+	num_widgets = of_property_count_strings(np, propname);
+	if (num_widgets < 0) {
+		dev_err(card->dev,
+			"ASoC: Property '%s' does not exist\n", propname);
+		return -EINVAL;
+	}
+
+	widgets = devm_kcalloc(card->dev, num_widgets, sizeof(char *), GFP_KERNEL);
+	if (!widgets)
+		return -ENOMEM;
+
+	for (i = 0; i < num_widgets; i++) {
+		const char *name;
+		int ret = of_property_read_string_index(np, propname, i, &name);
+
+		if (ret) {
+			dev_err(card->dev,
+				"ASoC: Property '%s' could not be read: %d\n",
+				propname, ret);
+			return -EINVAL;
+		}
+		widgets[i] = name;
+	}
+
+	card->num_of_ignore_suspend_widgets = num_widgets;
+	card->of_ignore_suspend_widgets = widgets;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_parse_ignore_suspend_widgets);
+
 unsigned int snd_soc_daifmt_clock_provider_flipped(unsigned int dai_fmt)
 {
 	unsigned int inv_dai_fmt = dai_fmt & ~SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK;
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index c5b80d9ed64b..209f86b9add6 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -4595,6 +4595,36 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 	}
 }
 
+int snd_soc_dapm_ignore_suspend_widgets(struct snd_soc_card *card)
+{
+	struct snd_soc_dapm_widget *w;
+	int i;
+
+	for (i = 0; i < card->num_ignore_suspend_widgets; i++) {
+		w = dapm_find_widget(snd_soc_card_to_dapm(card),
+				     card->ignore_suspend_widgets[i], true);
+		if (!w) {
+			dev_err(card->dev, "ASoC: DAPM unknown ignore suspend widget %s\n",
+				card->ignore_suspend_widgets[i]);
+			return -EINVAL;
+		}
+		w->ignore_suspend = 1;
+	}
+
+	for (i = 0; i < card->num_of_ignore_suspend_widgets; i++) {
+		w = dapm_find_widget(snd_soc_card_to_dapm(card),
+				     card->of_ignore_suspend_widgets[i], true);
+		if (!w) {
+			dev_err(card->dev, "ASoC: DAPM unknown ignore suspend widget %s\n",
+				card->of_ignore_suspend_widgets[i]);
+			return -EINVAL;
+		}
+		w->ignore_suspend = 1;
+	}
+
+	return 0;
+}
+
 static void dapm_stream_event(struct snd_soc_pcm_runtime *rtd, int stream, int event)
 {
 	struct snd_soc_dai *dai;
-- 
2.50.1


