Return-Path: <linuxppc-dev+bounces-19009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDB810D14A3
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 11:24:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkpnP1bk3z2xpt;
	Mon, 30 Mar 2026 22:24:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774869897;
	cv=pass; b=NrZZqZ+X+W3Xn8E/vk+wLZoMny+0DLtjQAaWXiiOXjqVyBRapHCuf8jaMUsBjTP0SRaJC+jMc3ATj2zXabfWXTqP4G2d6gHa59sKv4ny4cI7Qr8USfBiLnj6Z8Pdm39qSmFibYPcOoyrLqUVWsdQjgkhWn5mWIS/K2pQ+5DldvCsPDuBIB8Se6rExFu19/AaQTZN+90lIMPD+noSLleGPDHUfA/7ueaHXXATLFiYvDqvNSkHFYcEaTNZVQ5WodqkTC7S+1vLsBwQUJ/ReJeGAJE+KNMoNiD0V+vHRkL7JI1qxnRGm1uC1FGhgm2jgC4lL9nFP9d6j9ndwBsm+UGJcQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774869897; c=relaxed/relaxed;
	bh=Qf4wkRTdPZuKpR0yap138NjWx3pOMv++n0Q7EwzWGUs=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=j1QEBhyMzO4CI+NfJW4m0chwOZcwL6SXCJP34VacdknyxH9zvxJkTNwlsTEL3mY3yD1KSEzaLB75f5FPp89ku8pfL2rFFweNzN64QoRMs60SGU3Fl9LzkPR1Mqf6zkXROVRc2K65nTc5LL5F3w6eriZTK7gxrxUndta+bEJXW+VhUY46hb1FR0vQq5SwVtjPUHDUJvhQrkWG9YsZUeGWy1NJKc4AmN1ph05EpannOyoZUeAaES4i2Zy4NkljM2q1z7/WOjkRBUaxeSeWDHJtqha+ahbIDdGBjcgZVtubXxrd+ZHNJnSaAIErgqHXeaXiBP6WXJrpdpaUJ8oxS9cLdQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TXOFqHG+; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TXOFqHG+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkpnM1QR8z2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 22:24:54 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f/rn5c33e4lBvpDqPXFzuktum7fJZILM1GNMx1/QPF+kkgOQGak8vUfHt9O5W62BqGBOyAZoaILOlZQYT3xwALIYXeqYE8KIZ7ttjHzHUFE0i/D6Whn5byS2e2JQ8X5UesIKpFkEnjeTMKhf4wWJG3NK+kPIq+iHCtmQ+95teiWT1NDjY6iDcbOd9eZd1eMvsLwrXo774cS0DEbrQ3aCdLKO/TY4J654C+thblmwF1R/ycbTk3DgRvb7Whh/uyB60100OMG+NQcob33ehsWY12C8leqStnmnXaYSVF1EqxVncpoRryd6ZOLcbBRmycTZwddDIVRq8f3eHKzoJ8X7uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qf4wkRTdPZuKpR0yap138NjWx3pOMv++n0Q7EwzWGUs=;
 b=e6wJKeGq5Zg69SIi0V9Z3lVCLf12ikI9K7s/+M55Wd3g5tOgX1rrlWzbKyz4hjKj3B8fFOMB51gicqbmn8TI8rOfCpiIhBCojDRPfxJiyTCJAA9p84htCmpDNe+FnUXWxOpJUPb9hu8UWSEnee4xmT2OrYZlKjEFVouAkyJGKdDjI8XeFSAKsraW0HhBKO+OpXERxwxrIWqYnpyrFqSzRKS7o/Jw0at/rKVZkXVbQIK+9bm+8tRW1BrTCU1ItRT+lU5evt4rmpVnKBAvBNM4mZ7CPg7tR8eAFOIYciTaB13T8m4SObiyG9yx2aBPtKv3ITB+xIaqcFwvoGyKhh/AuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qf4wkRTdPZuKpR0yap138NjWx3pOMv++n0Q7EwzWGUs=;
 b=TXOFqHG+gYDWYs482/SCgUC0TrRA8D31AnvB8RrlXkeNGVAVHpX8iMJritLopQ1FhdsLw4hXZOa5AXRpBGMISY6CrpO5yPvNg/Yqt3UFoeo28CcDTECJniwFCdWFdh8cVcGeHLJY36zn3QsCzFAsiiNE35yn3Dltj/zbdH4f4EajJzjHnTQOgEhUNCpSwFKf25nttFv7kHTl2XdjN2BgI1RetRJ1mnmAnmwnVlS1Hl+rwLhBKjiVhrXu1XkB3JeNl/2AS1+e2TXoAY4Js/4NmatA4DeIm9GRLGOyjiQRm3qRdN3L2wCHiI2v/HWVS86DI9rzBvNPivh8XxtIzgElig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 11:24:29 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 11:24:29 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] ASoC: fsl: fix mixer-test failures
Date: Mon, 30 Mar 2026 19:25:44 +0800
Message-Id: <20260330112555.3637002-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0009.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA1PR04MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: 17087423-38d4-494c-f1e5-08de8e4ee856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|7416014|52116014|376014|366016|56012099003|18002099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	S18pvEz4W5nU/5Bqd1yjvFY3SGcp8CtrGXrSosGXbHgONsr3KOoDLbfdVYSoccmt5GU/wxObOrW8Uf3EC7BNG3TeIrCeZK33eWZnh1cTw/6P3HFgmwUWrvyvK/DcPLTWys36APLgoAIqo0ooQ1YPKrs6BoFMTea0rFzBB3rKGIwwVlWSIREun+7unBmMpt3xnl4ljoE4eR0us/Jax2ayKvkfxaQeDKIafx4eJk6VwCuuJU8nheLWR0AnloAYiZT8evCChfkNeJ2r9rVB4IFIDzh+xjFKgT3ihj+p2+C1LCML+tdlZn4mCRR11fKi2xx6b0fKXHRSb1yRZgKA5O2UtK/tJo2jks4ZrT0GeVxxJcrJ6cjKgOLlNu4frVuWNjBPjJn7zNvi+M0XGpmjHCZBKrZ60NB7TO5+n7ZGo8UcMdNRC4QO7u8NV8m9/XVnIMOwNPtEN99chQSlmJftVQNI9qYialVe8N21B1aWtgq7cVT7/1TNDPH09YuvEnt5CaHUExLqBLntKlOIwrJm+ctQ91YXZPahGd42Gr//Mj5Q02lFUZkJgBNhYokMjY0mY4OSXyg8SpCc4QB+sCBdbGVtapRg/ll+VErDfhIMnWhZl2mcjJp7oNbb8N1ixUfbxUCj9sL1gZXDwGuKC2JzoVX0UF1SrjMAFT/xskxs51ZVHKR90Y7aUh68ljhSHHNGgcrh3yT0qgosY4VVfSFPXnWJDNIE9P6rZjOyPC9wWRXR4qIVw/HSiHLGge7cb/nFSVBeBMHlKI5n3GyDgAaZgkgNZZ6UkEiE0IZRhcM5v8I9URVVzdnk3X8oG2/b1F12pBjL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(7416014)(52116014)(376014)(366016)(56012099003)(18002099003)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kCHogqfM3jjODRWd7jt8KeJPQiXtk9uR13xe3HWtdLYVtqIeqFXYwsXY7laH?=
 =?us-ascii?Q?Sh/MPH+J35jg19mDc0EHQJVlpC+giuv0QOXOvYYiOzlGVlhho8G3qXxAO5Jw?=
 =?us-ascii?Q?YQKUcpOQ9OrAdcpk/M0Ox8TOtMxlBKaZc68COuqshWZ3qngjruuBSAV6E9nC?=
 =?us-ascii?Q?0aT++ztNjB/sRz0EfTlYQYBFMRrh73vYmMafsJ5Zv5I8V5SV2NJi5KqNyzbS?=
 =?us-ascii?Q?vUA2EX6bUV65Vj/R5rSfvJs/ceydwI1HPLIzwFbOznmHi6CiDRg+ZEvXTudR?=
 =?us-ascii?Q?WK9B+BxdxsjISu8FMc1Jjf/LfL0W2FspURpZyeoZsAHkakyekFFUaRZBJAKY?=
 =?us-ascii?Q?joDR8siIhY4i+QP3CJeC7YIKrLLWUiTk8yqMAoefd81G6OVV6QCHGmB5Q+HL?=
 =?us-ascii?Q?7Noe1j5kYOZ2H9imXWiCEgbyQFep9bSQ2gRjLqeIwteX+UEcmFN1Eh2gV72k?=
 =?us-ascii?Q?SKSLsM9m9BRmQ53xb6FcOZ9ydsyMZtBYMYqwHq1BrzyDrB+QUMERDDNgov2p?=
 =?us-ascii?Q?mfKBMvdbMyzsAm0wYXY58j90tYojBFyczYeRHfe0l+Yd1hcJ46kI0cXQjeFO?=
 =?us-ascii?Q?6EVDIv3cgza8b3V0T7n1y4MAqMij+dAMA0HT0d8AtD4FdHbyLyPveO/4LbNE?=
 =?us-ascii?Q?qSpnaO41b/wlbQCxRwXs2nxQMUEKgiiHdWwzNEqg1wyN8/4XJBSFNoF+kUwl?=
 =?us-ascii?Q?6edkDk7g7NTLqCU7bRsCI4Im2Efuan7YWLYIrMRZU6yCofVD7LzhMyCk/6Yo?=
 =?us-ascii?Q?MUKjraNOgPT5Df1Ae5j9bTqaorHbAoX97IKEwXOwgr0zT3FQSPZNPKJAyfoc?=
 =?us-ascii?Q?jUbzE7ctNsJhVvk24EraF92uGuXuKaskGU08VjEzDvldF5jObgI2W30UIeHy?=
 =?us-ascii?Q?171txD17pori72our/VfpLBR9rrmHl6zgCD++gdo0mx+KleRENnjrTS/qo3d?=
 =?us-ascii?Q?7mtYvFOd/QO+DlH21Zi8iVQD0QwBDxyRiR6uaTDRcKuQ/ADH2tnuEzdgDmIe?=
 =?us-ascii?Q?BU+PiKVJFYv0nuKk9Ok4dEKK/IOeHmJCW08QUBeWQHSk7iaphEtt7SfXe8Fp?=
 =?us-ascii?Q?2gyXhrYl35hxiDHS0xjUYV0Ob8C7i3hZbLKkEW0P35T+ePDVqI0r25GShaIB?=
 =?us-ascii?Q?tEjZ9Nmg7cAWnZlssgfLlQ1h0AWflIhL7+C86iq826IssCG08umKJU4Fw8IR?=
 =?us-ascii?Q?DzCh2gHttWgxt1Umwh2CkXYe2mFhbqtqqX1Oa/qBkG0pBDSfBJ3OIg1z7p6O?=
 =?us-ascii?Q?n0MzZhQMSnOh9kw8PHmgBUym923cCBY2aW/b44NAC5Bbi5piN8gXOQFOqLCV?=
 =?us-ascii?Q?Swz868aR+Ou+fZkuEo4tf7ja7n8LdVy19UaJILdp/qL96sZlNLIOjUxf6yV0?=
 =?us-ascii?Q?/9JL2jtY+xdwYvMbMCd8i/2+oh+t+/+be81TsDuqS4YhdDGfDfJ/MFEomC7b?=
 =?us-ascii?Q?iLeNc33lScpUHZjxIgMaKCmgLR4tVVAwekS8XqkhVgnx95e0OQNG3zv/LcHH?=
 =?us-ascii?Q?ckJACne8TK51+PPSee1uurCYhv+d38AtLadRYz3k4FxlF0Sbt/F6tJHjgJaZ?=
 =?us-ascii?Q?jSZWMaUUN8Ql1SZO7Mm5eFgoK9ZH7SlZ98EBR/LTDBipRqx4jTfByDNoyMZH?=
 =?us-ascii?Q?hwcAVEuDkiceQDkl1Zzux667ShMKaNF4rNNIXnmEfvFFJ3aUL5fPF3BSXmCS?=
 =?us-ascii?Q?ypkdMPsg1XE4JDMV729Cl6rx4E4MnuNiytJaS+utcJos2PEPt205QEViwExL?=
 =?us-ascii?Q?s44SF9Wvhg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17087423-38d4-494c-f1e5-08de8e4ee856
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 11:24:29.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RANgqVMHNsUY6h/YZzL8ZTVWksOY6v4DBDS+M7dp7N000KOp5eWlOHQhExeFVeYz9CITkIqQhbVuzTld1H52rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

Fix mixer-test failures. Mostly the issues are that event is not
generated in put operation.

Shengjiu Wang (11):
  ASoC: fsl_micfil: Add access property for "VAD Detected"
  ASoC: fsl_micfil: Fix event generation in hwvad_put_enable()
  ASoC: fsl_micfil: Fix event generation in hwvad_put_init_mode()
  ASoC: fsl_micfil: Fix event generation in micfil_range_set()
  ASoC: fsl_micfil: Fix event generation in
    micfil_put_dc_remover_state()
  ASoC: fsl_micfil: Fix event generation in micfil_quality_set()
  ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_arc_mode_put()
  ASoC: fsl_xcvr: Fix event generation in fsl_xcvr_mode_put()
  ASoC: fsl_easrc: Check the variable range in
    fsl_easrc_iec958_put_bits()
  ASoC: fsl_easrc: Fix value type in fsl_easrc_iec958_get_bits()
  ASoC: fsl_easrc: Change the type for iec958 channel status controls

 sound/soc/fsl/fsl_easrc.c  | 113 +++++++++++++++++++++++++------------
 sound/soc/fsl/fsl_micfil.c |  72 +++++++++++++++++++----
 sound/soc/fsl/fsl_xcvr.c   |  22 ++++++--
 3 files changed, 158 insertions(+), 49 deletions(-)

-- 
2.34.1


