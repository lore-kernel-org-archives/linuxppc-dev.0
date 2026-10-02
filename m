Return-Path: <linuxppc-dev+bounces-28739-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539CFCA5FC4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Oct 2026 09:51:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hx3vD6GzMz2yNj;
	Fri, 02 Oct 2026 19:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790934664;
	cv=pass; b=lqeE6Lv/AmaFNZxgr56n4wbX7ERGZfJRqapAAUWQ1P1p+D+Dqv6EYHkEu9WTvwYkTax4TZmLF3lITbdQRJdtUlSlJRTbnZxD4kFo5YIq8HRzDHXyfPLrqZ+i1m7CULn56pHZBIYJbVbbuLdCu8uThzA5TFOCy1x44tojR0lXJQNPpt6aKHQHtezthLSZ17npNGwhebhnljgMwM3CG7wmtixtidznqDBN6dBhNZ1HuzJ+Xf/FWghvXWtaNschc8/xJYh3zugJFygyKVyrNS4z8wnn3oQGqg9h70jhI5/BNX4CIJqCYSNq9zzJUWaRQtddzTSHrGYRiNzqcu/coSW+kw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790934664; c=relaxed/relaxed;
	bh=sHADC39lqrcMaTLEqqknp7KourxGxJr5fX4nnRPuLOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEzdYNFDrc7J1cDhjE4/KI/ZWWPAk+xvVN78G2W3aa55pI/sApwgIfbT0PP7xjD8FdOBsA3JmnWzLNf3CglxYhkBlWs1R2d4ugVpNUaQSIPS4OiwnX8mbKs+Y7KoBfssvVEbKOWCHGhNNBw7KhMwrW8uKxzVkE1JLzWH16YBHt34p6FNWeaCslqFhVRp60fwAm/SdmHiNlYkaSa6fkpLQbd1L6FkgSONAze+lWmln0DnrZ9Eu06VTxpaccmYanLcyIR6UhMrmatAKDLJ/0JgHhvkrXAMdc80N8Ka/MtTSZbj/hech0h2KbmItBxoBn51h43PRLx+ru2F1fO4eh2v9Q==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gN2kI3+h; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=gN2kI3+h;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hx3vB6JBlz2yDs
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Oct 2026 19:51:02 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pc7F08hZzi7X+stykGw+CC6FOPRkQCBZ92qOT55GP3gdnKBGIbzy5yRqWkPMNeCHjIwWv+QULaib3Qhi4+RrnTYNDREOqJ0jg33eEzKAbhQl/R7Bxi5zcdAyTmcI+mIWXM9n0a0RUy6HFW+hhqkPgUxUwBGblCKSggzzhtPpPN96I3nl7RIx+3eb444G3NTVMhFJXaUck5b2/bBWHne4pTIlqWh+FF7nTFXJAPhfPkBgIalFPxsJVU9Wmw6WmSxs0/dLAcUGP17V/Jl8a6+P9/NZbK5iwYzLCgFVVb/0AHPSyjuchSutZyDXB1XJi6hz1A9hyWf3Ko225upsTYIIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHADC39lqrcMaTLEqqknp7KourxGxJr5fX4nnRPuLOk=;
 b=wEVbt2t3GuO5BvgygTgeOi67vXMivZRDXKDHiDWLHLnuGAFaCzjHtmCxb8GmN7ILOBkeJPgHPdx6YGZ16YBbZQrMfNDf2SBur2O7uMztjVrKeHOAvXl1FlQIT+PJgsUvi7hIgUsHRTjReoDJCJ1Fqk2Q5YkuFykgYS5Xsn4jX75NEqY5XSP94/esqHMtOVm/ZzatrIH+qr8HT7E4qnS7OlKft7jfrPhNHOLM40CLVbx70ujE1KuVBpuWZ2kopKQd3NkeM6oLHlGepml3wNOIC5t5KrMT2g+p/eeTZVII4pN88VylsON05UIe6ZG0Wvhn8EVB5KhkHNTdJ4z7qu2Mog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHADC39lqrcMaTLEqqknp7KourxGxJr5fX4nnRPuLOk=;
 b=gN2kI3+hNUKS8SP3+nl7DYp20soRufWpU4mRCHsJYCj4QpFmxcsskqP9uosqNChEekeyzCKiArW/YulZGTvYzkfLpz+5AAZcy2b9iFnCQfiRMkH8tqW3k3UH4BSfQ0A5Ntm1vYgwE9erfj3pjY5FJuegDDEDg7Tve2Z8sKSqQDbCQCVcdgKcGR1ZErY0/opXyPkdzut8ZeojJE2NGtPdiNpanJFzBugPyYFag0L4XynqdxfyH0y0pwhK0eoAKtFz65ihbF3gIMcmsqjNVoMwyNgCLV71zP1w+xJI1hkzrYLvq8OY+if0ZvBpFod8HG9XEGYvZucYeBh2p7XGtysF7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by DU4PR04MB11860.eurprd04.prod.outlook.com
 (2603:10a6:10:628::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 09:50:37 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 09:50:37 +0000
Date: Fri, 2 Oct 2026 12:50:34 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: jaidevshastri@vt.edu
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: fsl: dpio: publish the dpaa2_io object only after
 it is initialised
Message-ID: <j3lhj2h24hj3fibdufbp4awdetlw224nhrdcf7zh66vbkvrbzo@y4g3guhauod3>
References: <20260921-mb-dpio-v1-1-9e24539059c1@vt.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-mb-dpio-v1-1-9e24539059c1@vt.edu>
X-ClientProxiedBy: FR0P281CA0242.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::12) To MI9PR04MB019273.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|DU4PR04MB11860:EE_
X-MS-Office365-Filtering-Correlation-Id: f2edf6d5-4dd4-483c-9774-08df206a9c86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|366016|56012099006|22082099003|18002099003|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	r1WNQrki4ItuBSpLKOIvC20DiUESYYdD8VxekLFj5NMcAq2MHyOv398rT635QhBpARwg5B0Nm+ex9PxMxlkWzRsVsI5YrWzLxr5Zm6Y9X9XgK4zSLN30EnaKtbeNTzT1+QgQSWl5vhrLAXsYK9pbXFIphRwaeEjkVREtDzLCVXntIcLjmriJAFsoSab2sm/DYal3kSQrveMic9KH+Z7WXKlfq6Ro/qvJYptZHXjEvQYgiWI6TKXpnXiyScLwTR7Ghr8BFBb3bXQBaxDe1ZwhtOmeSD2+YbGTZ8Y6SrZXcIHJK+5raIdxeCDBZnIBNgsvl1FMzANd9uMw/HQ2wKRZG2t6U4sIk/qIvcbJHuijRwuaYCnNaKFy7klKau+7kFAIKN6c9uUKtD04izbRHUfXpYG+57UsIebEmQ95I85P5U87aWbt+aFj2EPCuLuRlvp7fsiYPmNRK0bHBntIJMlIBUpn/Ns448PjSyDYS56WWjRUj1aXEZNt3JCcXLngAcs8ctp6mhmxkfLf+LIfpWGHZXHAHXu6T3bfc2DJ7wGM2DMgIvlYCc0C+VmgaubUKZzUVU40I4FjOX9pfZVkIvwjriyiDRk7OrJfjGoyt8kgxn78d4G1r10hiZ7lgNvGAvgIMzDsGhNEp6HYg5lQL2fKpiqmeXF3wTZdpafWP9tAUoI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z72xluCDOgpCiSbWe6I9oIKDLcq+14Wmfkz4IaVfBIaJAHUbb2ycR41+pON4?=
 =?us-ascii?Q?qmFhFENpApZkmMKIi+gG0VTFo1T2+89MzwvbZq2WI6aA2huEulvWTPb/C5my?=
 =?us-ascii?Q?vsbY43TPc0/GENW+7ITFdJ4Z2c5z4dnHnv65uWBNVUDeJ0DZJ+66t9jl93iT?=
 =?us-ascii?Q?o3clvSvxNq+Z8WahaOzDlLUVGHttPjHld7L4wk+jq81bLXnx0IbUkiMAg4qU?=
 =?us-ascii?Q?QxHAF0s6SAsIewacGunsGdfiHAbXQwth3lnJO8nlByaW5xCAl3sHVWH9U+AS?=
 =?us-ascii?Q?f30O40QJy2BL3RCrlnTuO0ueLTwwfl6SIpAWzBuZrnJhrWHALY9/6aa+qBfw?=
 =?us-ascii?Q?okAMgfk2cpb1PEcbkxn7FWU0YqUPbNiJyOGZabi/sOhpvLwetrcr313GjU/k?=
 =?us-ascii?Q?1diPSgl1tbefUDhDp/M0PuOw+tRP9zvcZJPIhwc2A5XKv6G9k+WN7jKwvWe3?=
 =?us-ascii?Q?hHi8l+UepcU6QC3E2mIhHCzsGkClg58kKFaSIZV+1XcP+fV4Ap1RymvFLcmD?=
 =?us-ascii?Q?ZIAdPTkrGtElfqbH0eXt5W/HBypg+tFHlrbR2Gi96Lf80HdRW8eukiP4UOHQ?=
 =?us-ascii?Q?zhz8JzGK+4cWLZtP08rljm7Knz2mIRErFRyHnhHmjqoeRLAyyT0N3YkE6aOi?=
 =?us-ascii?Q?W9dkhs8AxuaoucRP+AiMX1bemD/6pPySA5vCJUx+wJtGpcFM86BDpDVVwb9K?=
 =?us-ascii?Q?NcxHTa/Lxw8hoSlERVMP9xLCaNqfyC2f/RrXfPZywgVnvfZDWZ5920QDtJQ0?=
 =?us-ascii?Q?NLluWaxo20x/Bxg1EIWVb83V0ptSIJQWQPhZr94vyRNEpkZ+127tJglYSReU?=
 =?us-ascii?Q?4bhFIWuePe4A2IihL4sqECb0hBk+b54ozjL/77jQgHu55OdqqavXYXxJuuOn?=
 =?us-ascii?Q?HCLmE+s3IbH2uooYNmq6nRyQo6fR34Rfuj5O8lEYllF829vgpgjOCB0UAds3?=
 =?us-ascii?Q?tDBWO/DPi3oahcKc3NE0IYX1MDXukHXnSeC+kwi5piWqEl/+jeC3sY32y1IG?=
 =?us-ascii?Q?Gy+TNhygsbhcqMGC1GWfMaaGXVkcttNuUEt4Jy8DEcgzxiPgyh7BV27dkaLT?=
 =?us-ascii?Q?noyJRprA+dNT2la75o/AuvX5Y5ngeoE9VfIr4G53Uxb2D1SRxs1rC9JkdZoG?=
 =?us-ascii?Q?CLzU8thsMfNHxuyV0RUsAB5Mo9vZOMcAtBOC+kTdKIMqlaMYO9r7vhsjdUTb?=
 =?us-ascii?Q?5Yc6yrjRB83BeM2f+8uipQxyvXzVqZ0gpXll/HqMD1Z7lZi8hDvByiLN5daH?=
 =?us-ascii?Q?M30dPWZWVGuNY2O1noodAxcY9VYBWj/5quhurvco22cBaZ15Dmsnayy2D9Uw?=
 =?us-ascii?Q?BB4M8H7m+52bRwJARCsNWfaWHkfo0q40sDBZIKyGcY5ht1mt7QYX1+Ir1GsU?=
 =?us-ascii?Q?JGw1gAyKy7y2ZurdTavCscoCYezGVqF0xWbO0P4uTbuJQaEGR5rRdBkCxVsF?=
 =?us-ascii?Q?ZTG8Ca5FZIRewEVbQhqoVrl9KMe040iki/uUN4OfVGnQ9dV/QSrqK9KgnU+5?=
 =?us-ascii?Q?eMaImvubvZACKaqZNb6d4gjEqXxIY8iTyOk4c3Qt6BhWb+ngkrzC+l9sn4Pq?=
 =?us-ascii?Q?FBTcPgjruXJ49/2xvvejScmZky6Rz/yH4uSM2Q+1MMQ783Ytn1ar2+8YZUPJ?=
 =?us-ascii?Q?eyDZ2QmIbnMnCCsgS8ldH8Z3b5NbW7H8FbC0V4ZCYT3e5MVdFt80xvwjHEy2?=
 =?us-ascii?Q?WWfkzHehm0jmmA96Cbt7JNvS0ushsHSm6R192dBM5ofumTr6N+fCDT8+nFoW?=
 =?us-ascii?Q?FZeDo5sw7g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2edf6d5-4dd4-483c-9774-08df206a9c86
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 09:50:37.5233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHYRFRuJjuVYpjW4nM2MIw/M1ToJiOynfsex6KtbfjO7nmbiz0SKbSU4PKm95dW1dvBSESvuitKYzsSxJ0mkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11860

On Mon, Sep 21, 2026 at 08:50:07PM -0400, Jaidev Shastri via B4 Relay wrote:
> [You don't often get email from devnull+jaidevshastri.vt.edu@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> dpaa2_io_create() adds the new object to dpio_list and dpio_by_cpu[]
> under dpio_list_lock, but service_select_by_cpu() reads dpio_by_cpu[]
> without the lock on behalf of dpaa2_io_service_select() and
> dpaa2_io_service_register().
> 
> obj->dev is assigned after the lock is dropped, so a reader can pick the
> object up and pass a NULL supplier to device_link_add(), which fails
> with -EINVAL and fails the consumer's probe. The publication is a plain
> store, so a reader that does not take the lock is also not ordered
> against the stores that set obj->swp, the notification list and the
> object's spinlocks.
> 
> dpaa2-eth probes from the deferred probe worker and retries whenever
> another device binds, so it runs while the remaining DPIO objects are
> still being created on multi-core LS2 and LX2 parts.
> 
> Finish the object before publishing it and store dpio_by_cpu[] with
> smp_store_release(), paired with smp_load_acquire() in
> service_select_by_cpu(). service_select() takes the lock and is
> unchanged.
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>

Could you please amend the commit message so that you incorporate
Jaidev's feedback and submit a v2?

With that,

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

