Return-Path: <linuxppc-dev+bounces-28500-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 903E1C9832A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:19:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvKzn6TKHz30Vs;
	Wed, 30 Sep 2026 00:19:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790691541;
	cv=pass; b=bCc1cB2O/f5Rg0swMYzUZL4RvrCjmaxLZyy+WvZ91LkLSp0loknyOeLwlPuaH6FaZvjTm5Qyq2A2KHOQGQSTbPwh3dPlLGMMt0PPOhC2ZTeilITdAyLjkNp9Rc5TaYFcoEZGAGqZLasbJdzMXoLLxuJSv/15w7mwX+QeXenWIHufUdPA5BvqdtrzZl7oWihrXLgXY/wa1t32U/sVuSxeBijAVnl/KMvzr5s4P497i3hhD/MXPUx5s4P4rz+1y55NSv7enHhxHmvFObUgUA10y57GrI70NmEbMoK4B8yM4ndmVkspwnGDhJ3GtDyDOnl6cAorxSg4+hvPyPBIcWL00Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790691541; c=relaxed/relaxed;
	bh=UMV1FfdRHsRoeMm2J6yXRtxaSHYboNQkQpa3FGg3n/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FIRDvQr8ryusilAezTmJGPMzZcpzg9YchM8Py6zbPeGn6LgQw+B6R/FzfgVxQBITCYDsjiKulJ/jsHhbxpP4xu9oAqJMO7VCNBEhMwkuHcWjEqPqPERkxiXe43G+eaQKE8CO9OiFnfc1BHsyp0t/qIUzGiSh0R1eQBN7SjNtn8bDe5YJuIt1RRwuyw/Dh6mTJeX4jw+uc5L0dyw+yTDlzQnz1fdlHLUlQtZjKpd+TeaInufLIzOY7+AFKMrR/OVvjbUn6f8fobpaytLZE/FtVyNs0TTe5zC4w1VHg6Xv+8auBOU5rJ9UHCcgxqL0e9BtSNtQaZMl3JijgIT+PvyuUQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Y21YzqYM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Y21YzqYM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvKzm0p4bz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 00:18:59 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGMrX5iBbXv/UvGpw93QVUTxYboSicS3pkxBuLq8moBy7U5iDLf7IB1TeHsMH+MuPA4c5MTfqNgBrfdsQZqrKtGU2yDXhxisgrbONU8IVw5MeBzTv3iDxUcw/QniruX+tdaS5CnrhVeDN/s0Ev+sUpzObWMlunp9Vh9fOk3OEN47D40AGtNSJ38NWoMQPWWKoLWz4CEetzQ6qHbm7T1sUzW2hGslxVchptZI1au8MKYuFEnCOxUqInxIbfBs2+5Qfhu7TX9gj6U4CuNLk8QXndpYth4tIwI5tbZvcycFtp1J8PKGqk9C45Te2pE7zUtzsVE3yG0Yavt3sWeQLXZWhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMV1FfdRHsRoeMm2J6yXRtxaSHYboNQkQpa3FGg3n/s=;
 b=FxjvTlO0WLbA+nmi8ZGMPdrog0UGACAlbXkOEXa+vf9DxEgKyXzDvwa6RH5Kjcg1tKK17Zx8C5zR9ImjwPnC6fXJXd4jHt5FvPKmMjYcUQM6EjqEzaLVlocvCtfmgkvxTSSk8AMiOGThHrUsszLyDxQ9UGmQf6AB8WcVlxqL+ejyjvueyg0DHoe+oFFswISX1zD+Ak0RwPVCyOhYDTBxFfSx98xSmq7UOZmqYS4CiTyof4HnCjzG9B0nY4hOVZjZhJIumrMSPOTabEp7pwZfXmMuNkzlOR//T8s+Tc3Bbq1V98UNi0ZfXqDjyQ0RaKHwrsUVgHD/JYsQgvREnPPXow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMV1FfdRHsRoeMm2J6yXRtxaSHYboNQkQpa3FGg3n/s=;
 b=Y21YzqYM0kr7SZs8UVpNZR4pYy4cyAZKYz6yKjqxAlX+d/NCkiHpFcIBUrHIzpDx3T6QI/cwTTObtGlolmO25Is3fvTrXGwvxmaFFswHTGZjpFiy5TokMTMPluZ4aKUWB84OHsMYn3lOMBf3BCHaxqHKJ26Nt9qTx1jjlq6LGGyMnEFTF3wsQezZ71b0WeKw302uTcuc2h2DLhSzfWURA/qvTOWQA9yTsNwNWthBoxL7Rs7cxumV2842vsmYbs6gPIs8TTYscXszL9u7/SYunKzSKoMDZXItS3DpB5D3jRNgdDDhalDkr6NbSIUlkeMux15ChtQ8C1EyOJhEl1UslQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by GV2PR04MB11190.eurprd04.prod.outlook.com
 (2603:10a6:150:278::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 14:18:28 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 14:18:28 +0000
Date: Tue, 29 Sep 2026 17:18:25 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH] bus: fsl-mc: drop the fwnode links of the dpmacs nodes
Message-ID: <3a553y2sqfdojurk22sp2h26yhsfwlvu6i5kcrbvgwwz6pqb3r@tohay33gdzli>
References: <20260928-for-upstream-fsl-mc-dpmac-fwnode-links-v1-1-b8976244b38b@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-for-upstream-fsl-mc-dpmac-fwnode-links-v1-1-b8976244b38b@free.fr>
X-ClientProxiedBy: AS4P195CA0039.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::15) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|GV2PR04MB11190:EE_
X-MS-Office365-Filtering-Correlation-Id: 36021e3c-3367-42f6-3ef5-08df1e34886a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|376014|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info:
	WM1XXSoGufQHC0Nj1JrM1DsuK5dHirK9Z2xOdEZnnk40Zw9Wns0KCbwbUwqDI1G5VTtLS6uOMj2syMhcs0rMqlGLAPodqzzM/olX/Fylc7ELKDyWcMy0bmejwY3wuG89YWZht9tj5r678Df2pIv+WZji9Bu2Kq98zXfdJag9KOm6/bOiGt+XeeWydlXrLSRiHRwVxpvDewGqA6MHnFy3zvw1/XE7KhP7YUbBYB5EXakFGWHu8a00N6YwQhFSfaFCNGhdOvaFO7t6QmYuZ5YJo0SnWD/W05R3L5qWc9sFwmVPjTh0wLaXtymFbAbHkV19DUS1vdwbUh4uHZBz0Cjh8Z6GVRi+bjWE87nfzNRI9LYAzFZIvuqfzCLqqP50WiRLULGEavSzjHrkGuY3Y0E42ncK0vNqXSBAoNfj1GtbVQl74HgjTeFM40PiW0vVBdPH6lIh5Eo1HQD3oJnZ5tqfwlgNqO6yQc81jTREwja0kBmjs7eb/vdB8qfq391MfxJB/PGZRBtZMZG5Gdvu8lLG3/O/9OG4bI0DkmCQLKgcL2C1mUNlQfNsb+vBB4kBCO6767PXL/liElnDxcscqtR59Z9QJVfUqDMlMBN2qGjRmpfcaWrdbe0m8SLlvUHsGLmdXkh59HKu/6VkUCOaIs8wOWjNrTQmpUZ3b9N+TsqURv7SijHaaqBp2xnIJrVVMfilvjtukkN7mGUOe+IyhHl+h6i+0zbzn07qdUz19YgWQX76EnkeyS+sYVghe+z2qkj6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(15866825006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TEjD4NxM/AJ1Z6zN/9Zt5+gbzc+dbbW8ea429SwfWgOSC9ckTxTMBAaCf2BA?=
 =?us-ascii?Q?sdDnSypWLzYx/9YeQo0aDmuZstodVjfCge1Pg49JmYkaYf+20pWgPZxJAwOb?=
 =?us-ascii?Q?hsHda6mjjds6BDNXRTfq0FfDsAd1+h5kV5iQmnoqBi3OqiDGZ9TQzwXIdzcd?=
 =?us-ascii?Q?QcnRT1c9VoXpteZTT17bkkUGbmUqWD/TP9mhzqdwLdp1txZhBc5IHH7/YKMW?=
 =?us-ascii?Q?IDht5KZjqqEjA07ekAFWrytnBsYtudqAPKmFz3xsJLDmt5DjsvQ/Ky36MDm6?=
 =?us-ascii?Q?7X+cdP55vIXKyQdYeFk7q/fRVO/EOMHT/FtM+NWPhVo9nYBuzvReWGjcumLu?=
 =?us-ascii?Q?A44YRBYcWJvkJE+5fYfr+Z1nD7MYpAHEuREiqcY7EM2/uhGojk8Cwp7Ev32j?=
 =?us-ascii?Q?ypH35Kbsv0D4VV2/KAGleHtPnmomjw/zdnpYLPNYdW0/UZeutPiJttD3ikEi?=
 =?us-ascii?Q?MTXrPXp5cfdZXxsqd89phmjPNZc8v1jNvbNonhYYaktNCyvbMGufD4hllLNo?=
 =?us-ascii?Q?hUSOYrw+5zzKaq5roBc7S3A/DuaaAlv6b4/KHyozjqq6TnLNneT5DlmtWBMb?=
 =?us-ascii?Q?/IT/1S/tWpKnQVRMepgsuFSGG+CYLhGP/N05I7AnfgeEs/Sf8T2iwNAmiWKm?=
 =?us-ascii?Q?yv78boStbxTXZFgV2OxTfF9M78bA2P0WsnMNp8flo0g6L9he6IVOCEwxHKa8?=
 =?us-ascii?Q?cJ7IN5/SsfKBR/6ob31caZMbN0ef6ys1HeyTkwxVQwG7zCuzVKU251bMGaXK?=
 =?us-ascii?Q?QtbdwvloyNFFsX+Wido9qnQnUBYfo+AfEelsXGBmkWbnUpfzptcp30TDemHO?=
 =?us-ascii?Q?ni2ckAKYisCyflyqcUvdaMcDwoI0IsO6iJSOYpX8bNQo4/HTO8a2yWdEUWuH?=
 =?us-ascii?Q?4GxTxZ6nWmlomFN4X2tuq9DMre8xKmvbfR2PbQ/4CyKEp3UTxYU+Fn7xB99w?=
 =?us-ascii?Q?/+jS39TF+vWC1ZMcRzxcLpUs1BFGQFvCP3rgYbxuod1EAcXq8ZxiMJZabld/?=
 =?us-ascii?Q?/AkJGYZRhV8jgljqePHyvF0UTa5lriH9V5m3KfTUADmNnzCUNln7EZOWUE5A?=
 =?us-ascii?Q?6yuhZvlhJATM4TtG+RLkvpNcEm8kdMmXEOm09ra1u3X4QvXp9tiQsXeXgnuu?=
 =?us-ascii?Q?KM6gRYcP6fhztD9R8dOdnS/+w+QdKwAZmu2QMzW+Jw4TBq72e7cAyB6g0Z1m?=
 =?us-ascii?Q?CnuJtMbUcMqRnuD20VgXuj6VJIX/WJ/6kAkU70j0Iipod9gRd5vGBnkB0pGj?=
 =?us-ascii?Q?7VPs5ZVV1Z4WNjWgN11N5cr3XEKDz1FG/iQu/f/0Ltg9nVhjwObb8x3fW4TJ?=
 =?us-ascii?Q?ZHvNJdJtp8rlWpbV6ZrCaoB1FU2TOcHqs1IUyyTEvpLRCuHoCFFvu1TTj4ur?=
 =?us-ascii?Q?QMFXdgkGjO36KZxREdAWITzrMg3+coq2gF54oJwh7Z1LwxDNv/5PsFvEiGsy?=
 =?us-ascii?Q?Vz7rcDZBwsFzdNDas8KycZExn6uP6JbYszm3drX52nld6SrH0W4XZoOc1Rtt?=
 =?us-ascii?Q?Jph9px/IflcvtuWsANHBT2aHupPyRroBPAKores2xjT464iFMPsVnKqLjI0A?=
 =?us-ascii?Q?fPbn0s+FEyOYClYOcmJbsQ19iUVh016RnItMjGMGOoYBVXJAKpIfFoLnAcrX?=
 =?us-ascii?Q?eS/7I0Q5aEn39n+zQNsYMgolP71WiT4OXgefSeJA8JDDwSvr7YBQ++NXulbF?=
 =?us-ascii?Q?lSYIKgH9chonZ1HDBn1ParPkoymDDjwr4xNrMjiIQVvPlhFr8JoPidwIRJbf?=
 =?us-ascii?Q?R5tflJo8LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36021e3c-3367-42f6-3ef5-08df1e34886a
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 14:18:28.6352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on5+itnv6JR7Y3ubA9drP5OS2foM5o6h/2IAje16i1YGTosK3pBw5rGSbcziw+5LLtCcy3qj5WjbbBcGpDhV3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11190

On Mon, Sep 28, 2026 at 03:52:07PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> A DPMAC node under dpmacs/ is never the fwnode of any device:
>   the fsl-mc bus creates dpmac.N objects without one,
>   then dpaa2-mac finds its node in dpmacs/ at connect time.
> 
> fw_devlink therefore attaches the supplier links of those nodes (phys, ...)
> to the nearest ancestor device, the fsl-mc bus, as SYNC_STATE_ONLY proxies.
> 
> device_link_add() refuses such a link once the consumer has probed, and
> fw_devlink logs the refusal as an error.
> 
> On an LX2160A board with 4x25G DPMACs for which phys = <&serdes_1 N>,
> the Serdes PHY binds after the bus and then at every boot it shows:
> 
>   fsl_mc_bus 80c000000.fsl-mc: Failed to create device link (0x180) with supplier 1ea0000.phy for /soc/fsl-mc@80c000000/dpmacs/ethernet@3
> 
> once per port!
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Tested-by: Ioana Ciornei <ioana.ciornei@nxp.com> # LX2160ARDB

