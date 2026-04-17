Return-Path: <linuxppc-dev+bounces-19831-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C7F4368E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 11:04:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxsTd620Cz2xpt;
	Fri, 17 Apr 2026 21:04:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776423877;
	cv=pass; b=O30H3Kg0kNUmAFD/TaFgLPGOCdVMnQJgaoEnYA0DdQvGDNqJ9dJvKYbtH6WGbUL9NPQnG73dit6y/6wcrX1m3ZifhTR5cYjsavfoorc8nuJCwzLsfMchxt8wNf9Hnn/Nk6tK3mPf+0WgQBdCmbnSK4MPg8aQGttWnBB36HPMah32WMj8nqV/uUCdUWtoG0ObeB0W8+s4yZkQCkaggBQCoJaT022WRlbhLM2J0rfPs42SgCs2iRVpDlyawcUEfucIfEFcO3+0AiMfkpPzupoZEUlKDwFFi0E8B3/40/YCcoyKE7ZHYTro1mK4ftxD6tHcJynl1RbAYAg4w3LrQVXIwQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776423877; c=relaxed/relaxed;
	bh=72hmBQUvpLc/UbycA1q7D42OYX5f5EfjgKhmTPW/TLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UvnsGwk5J4XRWhpQ/cX5Qj/9iDgkS8riHT6pvIbEFvb9fpv17GxMbFPYzVVfI4QTUi7yVBkDVmbunVBiHKdHSGwQLs0qZxTltrv6Ij3YxLTJ9WpvLou1ShEnvyPGv4VByl1G6YKdAFwgNpduqVIPv2s5daFqTu5nUotbluOzLo6K4/EZeMaNWoSdu1o7dbmK4dJWA6SkljMXYY2Y7aLvc6MYXh8eWQmScWGEMD4/8aw2O5T96AHGA5qB6XpDKmi2QRcgUMCkzKRXekKRSSKpGjPv0corv3MVMTjP7Sa7NtrsClYT7UzQpqhLsgIQe0rT6l7zbAqRC7rNXCzz1+UIBg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gH6w9Pql; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gH6w9Pql;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxsTb2qK7z2xfX
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 21:04:34 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tr5i9IlbKHlg3GY8ZG4ey+lfE8wxz2tzUitK2IBZFXSwHzUMUuSOS4uI1YBs0p1uSmQmrhYWr6PPita7xuMW19gFn4pzG2P97cUEwq8A3dh6XVkBEX1fm9r0H8P4Z1sXQJHThJ6ypJh+TMV05+rCy3pFYMdp9kq492v8pPtxMSIwqsxwTHLcy/Dr2DBfa6yI1jkbK764xGmxZCj+/4IZha+myiUIV1W6ht9BUuNq/tUB1eKkILKw8wO2Fl0LS8s3Lc+w0JQ7DRXkLLgF80QZyR0ik5T0FDhWMIj5hbqd6vIF29vf5N4WRl+On7FJJdB3UJbbw2d9uzRcP3jCoCm20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72hmBQUvpLc/UbycA1q7D42OYX5f5EfjgKhmTPW/TLQ=;
 b=nLhuEbgCaanPrcisdbHa7UIaXIXIZlsP8c6m7w4z/Xq9S3+J6gcPDr65VF7lpPmgboWRJhcAQHYfMDvAV9PO7NONRX7KzY+5+f6NpEIJvrPwb0Pfo4+XUVqLVit4HBcv4XyLx9/MAvkC5aWL3N5IbwIDA6sRWx+QOZ80WDksG3wXnXPIsXSAeeEMKBd0LJGlepHJ0ZZtO12EeFhMulTzcfYtO0OM3e2msATCwL3Mmea4j4I5qk7KhX1iZCC2lcGKbNED44Ln0VPjMGPtIGSJ6Y9kdD6yTVbocruxSXvodFwGQWiFP/d6W6jA4oAtefti3gwIxcTF9k+gUMCIu03y0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72hmBQUvpLc/UbycA1q7D42OYX5f5EfjgKhmTPW/TLQ=;
 b=gH6w9Pql4r+qYsUtYpb8jLg9wqc1CLIM9VsB5ShKjsQuMx0Ht6g1UQfa9TDabwKFDkuObVNoFYON6bQDZgLXMJHw+IhwPQhA4kosgowX5a+xROK0LNGVROYHom2rMakDLmwLfltX9tNoGq2g0UswUd/CEVd2xIkA7vwgK9cTevM1Vn4uH/gzCXgvI7QuyzyY9KcaJgWg4qiD3Adr2ZJWNWWseIb2zfFaQbRvSoau/R5MF/jD+zvSe6zd1bI2h9s6SHxo0ybLgXgbGcMjYd61cOPWyCZGCWCt/ccnQvM9PaEGqgUTR49cqEC7WjyMf/RdWmiCaxBoBwSRAOT/7uoExA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB8484.eurprd04.prod.outlook.com (2603:10a6:20b:34c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 11:04:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.023; Fri, 17 Apr 2026
 11:04:06 +0000
Date: Fri, 17 Apr 2026 07:03:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
	nicoleotsuka@gmail.com, s.hauer@pengutronix.de,
	kernel@pengutronix.de, shumingf@realtek.com,
	rander.wang@linux.intel.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] ASoC: dapm: Fix widget lookup with prefixed names
 across DAPM contexts
Message-ID: <aeITn0SXl-wqgAyA@lizhi-Precision-Tower-5810>
References: <20260415081942.4183108-1-chancel.liu@nxp.com>
 <20260415081942.4183108-2-chancel.liu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415081942.4183108-2-chancel.liu@nxp.com>
X-ClientProxiedBy: SN7PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:806:127::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
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
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff3868b-4e8d-495f-8e1d-08de9c710adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|52116014|1800799024|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0ssAlu9w3CgRa99ztBuc7stTW4FqLCIN1eyGBYUa1lSvA+kV7AeIXSsIpFTVTeKhM+ktfsKblrnTff+dZ3E0p0noExLraVwYoO8fRBufheHmEkK9S8/CXz0fUDtz8wmd/+GgbGrRojt4bEw5p57qxMtq6weGeCeH9Nc1gAYn5BXDSOqz+yZzrKVFNvuLrbqMwT0BaAam6WgkZaWpOdiJtFjA0KVlHV7TQ1EyxrTjz0fYrokLZZzna9smYY04XXtqPH1zLXQGklWJofzEm/3/biaPAleGYn4Dd/Vw2ZF0tuKg5+fsZyyCN8CFLfPeK7Dn/3FUyUovDJkkKbo0kPA0DYF21vcsXzb/XMfIx5HojDmH+gXn6hzToZ4DGqrgYMym6yLLN5IQTMJ2wEQ0xU5zVq1XgvYALJyd3qZuPTpR9PqMpGmsNKAK4sjTLM9oXMVObVEECyUnHBt6J2CmOSr4zpSkrwYxSgqmC9u+Er/WVY4iGsetczbjh4xPo8ungA0C8ULoGweRbXKjJA6OAZ1ZuR1L4pj8PwSimn8g0v+f8owXmNFh3T996uRduxWr3qF8nZP/wo/pJKdFMXZKGTmBkV7ptwQDazIgxJD8GefyDPfsxWWXagvXTwwZcBj8N9uZyNue2b11/FfwGMW1QGTQ4QTIelixsQXbwSb8yNz1+gywR7BQc6D2fIHbtyzmFiMc0wFz3gC+wgbMQVa7p6QTo2D8qySo6SI6Qdz/5Y+NQgF/6LdXoHaA8sAgqxQ4n2k44CXYxvcgO5yPgKM6lQQX1/f4ElkC12x2Ez021CUaGB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(52116014)(1800799024)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ti0d7fqaL2GqBbjfCpg1T2zpgKPbdbpIGZaJ0tKOLc872GdZkSyDylaa9yuB?=
 =?us-ascii?Q?LddE4i5uuYcO+u0xzImQg26xdm12OTGJ4l4U9fzKUpAZIwRI/7JYgTbIjDfQ?=
 =?us-ascii?Q?MgU+SX4RGhxWD29FnOo7GDjGp7TGUBwHTAStMIByPlP4hPYYJMjbsfHIXFzh?=
 =?us-ascii?Q?IXia+i80MBC6/LrQ6z7IajfYsg+teAuxyAOp90et+cR9iv8ELlcC9+BNZDbN?=
 =?us-ascii?Q?wds+pcjFwT/d+ZoZTWGK+ByIPAf0HS35EgWJJfZdC58ZP+fkMyg9B2mUM0m7?=
 =?us-ascii?Q?da2ELKRedL9CegJB50/FjTrsMNcutSwAomoLW776Op770jJ8epBZc/9/qNBJ?=
 =?us-ascii?Q?kafiVeqc9Wi/NLMbfDYmREq7tg+MxgAiYpZ8AVWUZ343/sryJ54lnpJNH3Kr?=
 =?us-ascii?Q?hnQKnM7+pMYBMAi2UuXJyx89QKNiGmOkl6XRyFUFDY4vxZV5bxlbsOkzmVsP?=
 =?us-ascii?Q?CI+KW5S1Tk8n8tpt60Bacbviq2uLoqOuaTagCYu0thR23cJN9Zc4ERngP1Ui?=
 =?us-ascii?Q?qLteN4q4sdtWQJDEfAtRAjZFgQ5GdpguLLxEU0WOin0OjF0F3kNHL86FLySH?=
 =?us-ascii?Q?cC7+loZ34Uj3h+x2HiXqGYpvKDpgyX9W3eGhr8d7oeAhNuddXpB01sEA9t7z?=
 =?us-ascii?Q?xVodl1ij9NXG2w2jU3+jn110vYVGuf0HMLKbP0UGxEagyoBdX/4hkE2HQ2aE?=
 =?us-ascii?Q?syXGx5P7hIdCC11L6zDxXF/hbrB7cn57XygMpeDMtVCDzYuM64XHIfhMAKzK?=
 =?us-ascii?Q?t2Gq2Z9sBOLTB8cdnQJ7U8Z5GZT2/z/wq+D0e+2eC4I9K8/8gmhaPnYym2Jp?=
 =?us-ascii?Q?p8laDDeek51Lyq0wXqMJhSASgr0h3J/4e7FIMfjp5T3hTi63Gvqy7qvO6k/C?=
 =?us-ascii?Q?2a5Yq8o6+iWdOVjhADAxrafVTMaDjTi2b2/fbkYUlJhH83AsVe4jsfbfAvMU?=
 =?us-ascii?Q?SH3DO2kILc0Gxd+dS2zY8syjJiRAGJTPCxHh1vfJ7DmXI4XIcWXtQlSOeSgB?=
 =?us-ascii?Q?bu2oJgsy4Ij8u9wubCQ2eInYppRhAi7iWNzhQ0dGQx9PJDS4nLJSpiIUQ2Qf?=
 =?us-ascii?Q?U30W0sparAfvcZfQMHdrQ0TAIeAcQS4xkHCHord+6mrsEWfNSmoigPYxX6/7?=
 =?us-ascii?Q?kwCSHeM24N72erJpHUzgv12/H5wDYsZuUECoRurH2JZ+JHIfK1u/S8TYox//?=
 =?us-ascii?Q?wpoh/SLPEYl0YcQRBLvFDmELd9xby5lYvs8OXsrTSRrC4ot3lvc2gHmMVN25?=
 =?us-ascii?Q?XJblMZEZYKzI2DI6MvClLHVR65YZzYpidqIqbUNx5j1VdWfWxz9meRij0nP5?=
 =?us-ascii?Q?7LfP83+QLnsFOaiV89U3M4Ei7X5OEhGgDkzR4l2wxHA+P6HusUJSsDXNLhuJ?=
 =?us-ascii?Q?h7VdkB0qP61IRKDYv5D2xhIZJzecV7ltxdAhTGKd3G8IBTJrm5spMRDXlTPT?=
 =?us-ascii?Q?qgtJ9obz/JKhVfs04QAVCvMHfTy2PPAuah0RfWlSp7Rw+DiFQX75oNw0zZRl?=
 =?us-ascii?Q?iJkzSH1Bj02t7XPJSL1ibf2RPFO0xxhfhbyaJNXXO3RBYn0sLzTF/x7+54B+?=
 =?us-ascii?Q?70KgiADRVQGbPVZ7uKYDXINxa1pdStcqcoT90SIyKy5mjzPU/lSZTBsvkM0z?=
 =?us-ascii?Q?71dIDKb2U/AncpKBdcv8MXShyM1kPpBs665L7hv5oP4qQBvgKdkVpvCJ5oG3?=
 =?us-ascii?Q?8QmMOBOUKf+kihKojDyiyl6AjtZFC5q7AtLfqjeWvRDvFGb/NUWDnaNBCoaF?=
 =?us-ascii?Q?9HC6M6K2QA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff3868b-4e8d-495f-8e1d-08de9c710adb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 11:04:06.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V6DUupttLbV4xsB8lS4+C+/1AbvW23io4ZeiVbVu226/i2ZFgK4jLRCRulgm3Xre2FTVITJ1ibaac+i01gamEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8484

On Wed, Apr 15, 2026 at 05:19:40PM +0900, Chancel Liu wrote:

subject suggest change to

ASoC: dapm: Use snd_soc_dapm_widget_name_cmp() to fix widget lookup failures

Frank
> Currently dapm_find_widget() manually constructs a prefixed widget name
> based on the provided DAPM context and compares it using strcmp(). This
> happens to work in most cases because callers usually know which DAPM
> context the target widget belongs to and pass in the matching DAPM
> context.
>
> However, this assumption breaks when search_other_contexts is enabled.
> In such cases, callers may intentionally pass a different DAPM context,
> while searching for a widget that actually belongs to another DAPM
> context.
>
> For example, when searching for a "DAC" widget, the widget belongs to
> the codec DAPM and be registered with a codec prefix, while the caller
> passes card->dapm and intends to search across all DAPM contexts. The
> current implementation incorrectly applies the caller card DAPM causing
> the lookup to fail even though the widget exists on the card.
>
> Use snd_soc_dapm_widget_name_cmp() instead, which compares widget names
> using the widget's own DAPM context and prefix. It fixes widget lookup
> failures when searching across different DAPM contexts on the card.
>
> Fixes: ae4fc532244b ("ASoC: dapm: use component prefix when checking widget names")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> Assisted-by: Cody:Claude-3.5-Sonnet
> ---
>  sound/soc/soc-dapm.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index d6192204e613..c5b80d9ed64b 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -2906,20 +2906,9 @@ static struct snd_soc_dapm_widget *dapm_find_widget(
>  {
>  	struct snd_soc_dapm_widget *w;
>  	struct snd_soc_dapm_widget *fallback = NULL;
> -	char prefixed_pin[80];
> -	const char *pin_name;
> -	const char *prefix = dapm_prefix(dapm);
> -
> -	if (prefix) {
> -		snprintf(prefixed_pin, sizeof(prefixed_pin), "%s %s",
> -			 prefix, pin);
> -		pin_name = prefixed_pin;
> -	} else {
> -		pin_name = pin;
> -	}
>
>  	for_each_card_widgets(dapm->card, w) {
> -		if (!strcmp(w->name, pin_name)) {
> +		if (!snd_soc_dapm_widget_name_cmp(w, pin)) {
>  			if (w->dapm == dapm)
>  				return w;
>  			else
> --
> 2.50.1
>

