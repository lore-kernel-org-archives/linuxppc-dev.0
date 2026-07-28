Return-Path: <linuxppc-dev+bounces-24925-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA5AC53219
	for <linuxppc-dev@archiver.kernel.org>; Tue, 28 Jul 2026 10:41:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h8X7n2g7Hz2xyk;
	Tue, 28 Jul 2026 20:41:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785235285;
	cv=pass; b=fLB7hUweiys1tj5wB+K/KwJ7gSC25yCeVECbT9s1Nc5MQCZOUEN4wHIqmdntGU32l/7tSn7nulpvf5FNChWl8utH0rWtlXt3oHLWSk313l3xELbJSpfgzwRwkQCI4huha3ZuAjcevTd4CXuuOYLeX92gPAWdii5ciN1t2aVqs9TL2UC9L852M4qGMukmPaNSbdmhrmOYK61pEpFT6xot5Z5GOxO9EpKMCGGHofy8AtrUEZMbTqTr1oAi54mpyoupJQ+r2W6p2fjneNZtfNsIGCplKQNtpTpb3camPg79bi3m47Ia/cmJ+nDTBjzzMsPsKz3+V6DQX5O4lLAYIdBVCw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785235285; c=relaxed/relaxed;
	bh=2CFET9bx8VYvxD6zECUj33yuCKcX8kmz+sLCdec1naI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NOstrbdSv4Rzqqsf+v54njhwqRhtrTo5/1NQqq2gxNGKJf8g9cwNow/o3YSWh3JHX8n3o6EvJAhcahiLRZO5jp9UVch2XNjLYS2/30uD/TLzDhmflXvSjtKNGC7zSZbFoxsOoovUgktDoGtlpnosTldkSGRiswmOa4SxI3GCR5Aj3rogF4zXMfwYZ8YCGYV8sUpEOCVYZvhdVPIztRFBtV0EugOMx9XaZkXg5EegLnPbd5nvpofpeLFfrbF+asAeKeyL1uMKzNjeGj4jnMrAgKXTJoMHuRochyhg/RRG21HXTfwlCld7OP6qvFZhIe/NTbNX+NNQN25BAdUJecE3+A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AkbQs+9E; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=AkbQs+9E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::1; helo=db3pr0202cu003.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h8X7l28YHz2xlQ
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2026 20:41:22 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ViDzRNP4YdK6YY7D6rvVvHEn03D5J5Zkx7mvQWrxtT/O0wYXVxbg/v2WK2GKR8uQxeutxGMBkLVoOgJbFoJMxlriLfDrtFpPQcIqeH0ahXwe1pjZSvCVprubfxaDK+m7yAgOLjLEIZ2BrEDTE0Eb5WBa29GmoDquhAsD0Y2+msVgM3a1aas4qXe7bJfRvcxTvWJjih0iE+MXNwW01dDzDNwqIXh7M55jmCeLD9PLYn1BNi4EtUwwUOzSeX4Va6ujRoK46oveGTCIKvEuEEklfBk/cHjjAqvLbey4dUXM/ysmiJYxpglszRxTz754s/hsyD1Ey+q7cK3AaklkDhb6Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CFET9bx8VYvxD6zECUj33yuCKcX8kmz+sLCdec1naI=;
 b=DDzPv5Pn7mvvry+3i3m2ZkLsBmIiETG2YF1woK57GS566UtJ/BaFPfAK8MkBfBLAQZZNr81k2lESnsfkr9s262t3AqLRfa88UNWpXP4MQFAPA+rjJxBvvl1EgqgWy3VMsq30mghzxpHx7VH41rUiTYui2x23H2lBoOEGQlvmejXzEUzYGB0xC/Lj9bUH/YyyyIWSocEpJe8h5KIa+yUja4g6N1NjWlNPy4GbPm+nz2+EL2iKO6egAMTaVW0AVFaCauf3QMe9yQAzCPnbQ0pYSOgPALCPUR92BOcD+fkD/NNcrsxTcbTQihE1IfIaeEzTeGvh81qmi1IQOkWUmDnZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CFET9bx8VYvxD6zECUj33yuCKcX8kmz+sLCdec1naI=;
 b=AkbQs+9EfhFON5HdLWIDaYFCl0rRO4h/75FtxNDcRmPJfA+pF30VpS/Omn58f8MvJHBxFV0jV0SVLvu+WKpI9oMciMKQin4eWTfvb4PBpfcmKGek5LTBacobtnG0IEuW1xq7hUJNOlQIMum1Gb14UxcwHRT8Bd68021gQr+M6Aafz2z1todnX3zXuF3SANuPMfc4z61EBaEsEzm2tqqYRyCvzhc+xa3WyQQUCP1rWwUtPHVzV964v3RpEA8n8lavvg4AZMUkZlhtqRD227h3l1CZVaKiu3iG9u1p9YWlbOfhgS3d1peIXKOu6D9/Mk+j6CUs/ZqOXq11Aqwu56kr6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AMDPR04MB11680.eurprd04.prod.outlook.com
 (2603:10a6:20b:71a::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 10:40:53 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 10:40:53 +0000
Date: Tue, 28 Jul 2026 13:40:49 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	Christophe Leroy <chleroy@kernel.org>, Dan Carpenter <error27@gmail.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, Peter Zijlstra <peterz@infradead.org>, 
	Roy Pledge <Roy.Pledge@nxp.com>, Steven Rostedt <rostedt@goodmis.org>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [v2 1/2] soc: fsl: dpio: Use scope-based resource management in
 dpaa2_io_store_create()
Message-ID: <6woig227u5snmdsrjfuw7gfcf3vk5iwaap4yf7ow6b6s3pba7z@yg4vmdoaak3h>
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
 <y2h44um2grcbecnpkck44cvudugha6df2itq2uy5y46whxjouh@yy2kebig3ia5>
 <802ea627-4bae-4267-b1fa-7da2499f2ab6@web.de>
 <55dkpjlibtfurmrrzxzznq6e3dhxvo76rsrjnokkaquwktl74r@omft73n4kp52>
 <3588f06e-7d11-4e94-b141-008e676bb28b@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3588f06e-7d11-4e94-b141-008e676bb28b@web.de>
X-ClientProxiedBy: AS4P195CA0023.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::14) To GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13)
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AMDPR04MB11680:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b122f3-2ff9-4c93-a6cb-08deec94b2ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|19092799006|366016|23010399003|5023799004|11063799006|4143699003|10067099003|6133799003|56012099006|4133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iAN7bi/qSTVzxmctI+GQRK1Xlx3CRu/EGGISUPKOrKc+yb0y/v6uRQ3ZWKi+XqcKi1gVQoymnW0p6hHQ1D78U3bggA9v/hwZyXIZQAnLGg5yrHRNtfm8QAq008XvLnrRxhrc3tbZfu1BgWhaPV/nTfPfOiJdsHhbani5pECeGJBdzQMlkRbHPQnb/u0gARZwT7fk5qTrDy4ChxkE0+TVREppWt/UL8sCEyuwx3AFxdWT6VpZk1QJPHAsQ6BCVXR9FA19ujeKwhLFb1SQlu8uxwTfBiJkx+wseO2MpfXA3aDNhK/goYMQ1WKAHhpg8LiscADoBya4QZVQkfKBy2HVzSVoxF+qR55llvb4pJE6j48MylyeZSwDbvYEmNQU0pYxB7kJwHmBSxnBzKe/RDIrDJkj2uMpRhpi/TDD0OuF6eo+5QuJjRNP4pzTfws9O72hlcke/lmvXFsq+PXqBLZKYtjbLeDtv9rCkf1gaOVhih/Aa+/SPR5dj3WIBnRNxKnmThfGYrDzG5Z8J1gOAwWv5Seuh3wsdZ/pwP2nwTxJbqN1kWakox1t64OnsyLnd/dBr1SpHT89PhpHRuYuRKWYSew/JzG8K3002HM5GTDAdtm0pVo2azxcVc5iUfwxu0Rpm+FUURW2nAEptomPelJYH+/kZQWTU7fxhb3SXlMsAEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(19092799006)(366016)(23010399003)(5023799004)(11063799006)(4143699003)(10067099003)(6133799003)(56012099006)(4133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TeHkRmMarQUzBgvj9gxwDiLV8TF6DS1ySIenM7BKAiVxbFiJLcELXYkTc5ku?=
 =?us-ascii?Q?w0NbkIUa284kZutpqe08Xlcktxw6iTlPgejE/WVVpbhRylvXEr0bnkJOvfQx?=
 =?us-ascii?Q?0QmtUflY7nQRGEKGFckNzQ7LmWpkMo+CNPdhLBz0ioAPF47tACxdlOKPASNp?=
 =?us-ascii?Q?HN2av4lf1jEuSHbuGT+IOAcsN1yU5xaVtTVIrjx5z3TzKGYgQKeOAFHwjhhI?=
 =?us-ascii?Q?pXToNy0PFD2CsVXHpxkbqHJC7HbVEWSxG0O240R4YT/Jnqq6bt1tmRgsYMKA?=
 =?us-ascii?Q?InycMFveeOWCySs0hI/RUD2r/R8qLhYZZ0G6GDnKWrgECYf2cLj7uoTQLdUU?=
 =?us-ascii?Q?N3S4k1hAGbyvHQrk3Kx854xNAabQGv5uMkqMNHaqSu5s9EXkatn/Xg4GXt50?=
 =?us-ascii?Q?e4WUI/iztDk4n5r21vpL/a7BkhGBsElWi5VwOJ4FU16JkU8LIPo4Y0KUJjF3?=
 =?us-ascii?Q?q1b11hyPALD/Oj2+aFGbzen5ML9SpCqrF7gMboyEXKbLj5gYVq4WTGN+AlSp?=
 =?us-ascii?Q?al0nWnAqsVEzvs5lME1VfXD64pZsaf81PL2TT2SUXzqbnViPBI6lYB3x7yvi?=
 =?us-ascii?Q?6y9Yx4fom5ij4hpnScOvYBuXjO2VFUQyMg5cGT7Ah5au7wJYyGyx69bbfCTw?=
 =?us-ascii?Q?P4PN7tuzwMpN0tVTnc0pr3yEq8Qw7+raK0jMe4wFfGD/TPGESv4NJNWmHSHa?=
 =?us-ascii?Q?KE9fXKsm0Ks8Nh/uOquafAeE0R9Cmvl2iydqNc61vGKgAxsQr1NaMXLexNHB?=
 =?us-ascii?Q?nOyEdvyxZMAWMQlDALux4yYyjwGIeUHTumm+mlDob3FiVUszAwFF5qaeCY+y?=
 =?us-ascii?Q?1DP+eSiNs7/8cDYxjiHTsugL56I5vfwEAIRMa90BtZb2Kdm2UWPuhIuKaEjZ?=
 =?us-ascii?Q?yS64ROm9E4349YYVf1pxAr4qX9r/ehxq2quKGXj0vgV7H29Rk5uabkxzY0sm?=
 =?us-ascii?Q?NoCmYXcV92qOeHLSz1lbsLJ0547f3K9vvdqdpWeCbD10cAe1mRwwgBc0XWkL?=
 =?us-ascii?Q?iKpI03hen4EQwPcH5x5AEnoeCEM1/9C2Zsb6sXn/JoFESf+bheT8L+9MoPII?=
 =?us-ascii?Q?U/kx/JkOuj/HjsE5WdlVOmHVVJabDEiyAf+tzB4vu5EZSeNnHdurQ98Ax+JJ?=
 =?us-ascii?Q?pL3tpITVZgtmII/X8nbjUiWjkn7OS/pXJ9kqooP9csI7VumEWmgBbfYvCItU?=
 =?us-ascii?Q?upXQZ9M6I3XkM8rtR14sNrATD/ZGLNVJJa7w8NoZwCecPoVDGPtxsuu7T687?=
 =?us-ascii?Q?N0X9YtDjbyj4OLpH6XNt3+3oYtSazxk0GUbYgAEKHWiWCqru0A+dXWxLdYDW?=
 =?us-ascii?Q?dJb9O6oBLea0Ymkdnx85FcNikgGsQR1PbfH2Gip+kAbt3tJLGDAOaycyx5FG?=
 =?us-ascii?Q?D18+ejuT2BK87pKszeuUmOjdI4CQmctEUL7yOffR9VhEsnndUTlNMAhOKCOp?=
 =?us-ascii?Q?F83N6+3hSBPbxW5wZJoz1VCgCsUZdjoalo46dkZBwMg+dumevnR/HYDtINp/?=
 =?us-ascii?Q?viceWI0aaJ4Qeu2/2s1kJ/2wToJYmrvSLOuaqiKRlHfTPdnyYp3ODZzZ8mMv?=
 =?us-ascii?Q?ssjwx+jqrYfMX+yNnO0ofV0STi52hxablbLRTaEOmhtw4lB6/ORVwjTtX4U7?=
 =?us-ascii?Q?pg+Hl8YcCvJvMq9K9zzi1jFK40euFYlwAfwhnWCj2o/OesHd/m5tIKLVtyc9?=
 =?us-ascii?Q?77ynx7ZTyQIfYN2YPocosFfCjNMXGkz3QmNBcinv2r+ShTcKrI0wDOeB3iaz?=
 =?us-ascii?Q?fsUL4DjrjQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b122f3-2ff9-4c93-a6cb-08deec94b2ca
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 10:40:53.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmS9ENU7AngzaNu+SZaD+mB04GgQV9dw6Ra9167MOFECbn1yVAuQSP15o1jTqEpBOKcEwtihvmQQZG78dK3SHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11680

On Tue, Jul 28, 2026 at 08:55:38AM +0200, Markus Elfring wrote:
> >> https://elixir.bootlin.com/linux/v7.2-rc4/source/include/linux/cleanup.h#L142-L146
> > 
> > The context for the recommendation linked by you is (also from
> > cleanup.h):
> > 
> > 	 * "When multiple variables in the same scope have cleanup attributes,
> > 	 * at exit from the scope their associated cleanup functions are run in
> > 	 * reverse order of definition (last defined, first cleanup)."
> > 	 *
> > 	 * When the unwind order matters it requires that variables be defined
> > 	 * mid-function scope rather than at the top of the file.  Take the
> > 	 * following example and notice the bug highlighted by "!!"::
> > 
> > Which is not the case of these simple functions which only need a kfree.
> How will development concerns evolve further also according to previous clarification attempts?
> 
> Clarifying confusion of our variable placement rules caused by cleanup.h
> https://lore.kernel.org/ksummit/CAHk-=whPZoi03ZwphxiW6cuWPtC3nyKYS8_BThgztCdgPWP1WA@mail.gmail.com/
> https://lkml.org/lkml/2025/11/18/1766

My preference still stands and I do not think they contradict the views
expressed in the above links:
- Variables which do not have anything to do with cleanup.h should still
  be defined at the start of the function. This is the case of the
  qman_256_cycles_per_ns which you moved in 2/2 without any motive.
- In the case of a variable used with __free, if it can be done, I
  prefer to see the definition and initialization done at the start of
  the function.
  For example:

	struct dpaa2_io *obj __free(kfree) = kmalloc_obj(*obj);
	u32 qman_256_cycles_per_ns;

	if (!obj)
		return NULL;


I am not going to engage past this message.

Ioana

