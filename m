Return-Path: <linuxppc-dev+bounces-26905-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49435C79FB8
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 08:57:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfvnb5zp7z2ytx;
	Wed, 09 Sep 2026 18:57:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788944227;
	cv=pass; b=J/lhQgyNAHw/xOPct6QFqA5IYH2DOTt5uxZJ4wBcs6cmwY/sx/SJADSnfC5yTrwwBo82G7AkPZHeBsAC7kSw4U/6UsbKrew9kf2rEf6Jl8Drq5+ngk9TfpLMg8by9wkGq/etNYkh+OoSraE6eJ4kb8C6KnyiwTc0zcz4VDP+OT1vXQbz1rOY2Mc/s/hYjWJ3Dv6ZMSkXCaI3I1Htd9zCRIS+fQHvVx2KbZplEZc1SKk9Lyw3feWkGNGH4O8Gdqo72p5sJRqOHzleFnSfOUl898zREXbBC/lYSBhb6mQ4k0S1Y7cZcaFmMhcb2o1R3it8wWG5kwLU9HlDWCCD36b9VQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788944227; c=relaxed/relaxed;
	bh=sGZwkLXnuY4+/QwJcLfdSxe/Big0L54fZ395euLjrVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YND3LXCDHkSXu+j7/aDinH+SK6OmO5jDVFBIS0BrR1BHMUmulskBJxjgTT0YKTD7q70eHGH2ZSvcjX8IblBlPEleqOD6SpHXAqEcX7JkP4pVbJHr4galeOOWG4jSvVodguQ2n+yzY6j4DGKuBz/HOUMYdy0qgjzTV2qA57W0591Rp0sK8Qx1oWgAa9zITAMQ+iTYFIgp3j1ji2RVw55na2WbHU1mqBGm9BKI8h1aHvBpEPZGj8p5cLXm/MNsZdd65U8k8ndhUtFISHXIl+KPkyO3QkGQm0Fq48JT5U7TVp75klIln/VnpuJi3XH87MrARe4tGyWTHpPzrs+Wbcv2MA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=duUZWElS; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=duUZWElS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfvnZ0hTyz2yln
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 18:57:05 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2oeNDmUg+Q+gQNBp2H9T9QbM8YA+dPsdCSlUuXxpii4hT2LkiA1f6iWX8S7pe7VYji/Ec7nP6ORbCxR2rINXWAjqcMlvM6+1bIM6ijDU/CP7ku0OUjfmz1ij6Qfp27DG+/woXRX3cGRN30QdFSfTfhXqnrNAjepzmy8y7MLgdfzx/HDtkkR3EP3/Hjy7CAIXwZDIjNSQQzCqjmv7kLWx5QsviY+LvTRlXlUc5usd2GxkTKJSHhdQTL1mAQVF9nh1E7Jx6WNXkjHepX+m0t6sMeaQkqw64C88i96far9bPrRhkYglkUaFRc+N6R0JWLRPwmP3LpYJpV2lb0k7CjhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGZwkLXnuY4+/QwJcLfdSxe/Big0L54fZ395euLjrVI=;
 b=JVV6I4cFc7DGXlJoIYto0iu7T0zAx5JBMfEYMIzw9m4uiBZiWzcjV1d49knIC6HMsbfplqufbEkHl5olBm2PkOs0Vkc+Yysrh92Iatq9r5m2UXmurnaTDrEjTMn2fyCnKbWmElvVlZaHQEyMCyTeMOhWUU4eVfMFOIzqj7/fzSnpR3NV/RA72T6gMrMmJwu6oNLNrB2O+kBH6nW4e28y4y2K2+MrKNFPmWqTLMvn1iKfdEU6VNSbl/fszstS3bZ2r/QvBmeu5tv6uqNPBn3/eLtf4HtJJZxhtzBmINCM9D/J6Xu3kKXt1qFnbwo4Ct+41N40zinZBgxefMw3S8FtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGZwkLXnuY4+/QwJcLfdSxe/Big0L54fZ395euLjrVI=;
 b=duUZWElSQzP1ci48xAHs18LdIO7QO6IGjjrcnbLHBCZypevYjd5C13kozUP36SBkVvJEI3+HgvRzy0Kqwcwl2eh7JJMoUK6FYWC28vfi08VKB99ajAisikK9xbg0VQhsnQXz6psspimEc0lhjBoEsBY97uQZGGOlEobg6ComB4tH2iyfZY+cTDcZYJrMmYjBO+issmnegyzgMQy691RJW8FdVIwXH5eRkXKaHzwjpiOl+FxZLs9CY3sIuACX1eplKTQcEMmNLaPd/VTrafgcU/dSNI3mFGvA+2smLhNooEBY0WpJMe0j4D17ukldpamE/Q/vya3lUJfFgIlc4yDCZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by AM8PR04MB7266.eurprd04.prod.outlook.com
 (2603:10a6:20b:1d6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 08:56:40 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Wed, 9 Sep 2026
 08:56:40 +0000
Date: Wed, 9 Sep 2026 11:56:35 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH] bus: fsl-mc: register the object drivers after
 misc_class exists
Message-ID: <ihh2hdeove5tj37mk53htlyzwfnnn4tzufumzcnkza6kkr5yoc@rs2ojo5lod6q>
References: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
 <fmmf72ypmmooyxszz3l47xabdhvetowgvbmbjmvj6bumuh5onh@pntmny63urbg>
 <ap7mmR_4QV0k88dK@L30177.local>
 <dvnnk7fnk57x7gf4mc25codec62xtpbe4v7omhjguqxd25ssmu@pqqjwe5xif4q>
 <aqA1FKnhAA6iIuyH@L10892.iliad.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqA1FKnhAA6iIuyH@L10892.iliad.local>
X-ClientProxiedBy: AS4P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::9) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|AM8PR04MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 437c819d-d6a0-44cc-d10d-08df0e504392
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|10067099003|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006|41080700001;
X-Microsoft-Antispam-Message-Info:
	3I8JSJMlNS38RHrfWX9mQLsmL6JZUlRnpaDNwwnM+xqKvpn4zXDj4/e80Ye72RxcbmqYXedpL7O5xztnOsmKag0/KynVCiM5BONaI1I2LQptlFK1Uxf417+74QyfX2/+shRaY4AuFHOlvlS3GI2cFfk0Iwd5tGFB+DzXBHtw3E8f1uhlThD88cWt2EfQopea1rf0YGUilLG1zWsEsB9IRl8fID7x8GVsNvj3NconRWYlKqsEzPq20NZDe85l5zch39av0bxAk3pq//9LRV5W1LMqRgLLPHorXiXy6p4qLp84jgmkWmoQPRHZi+xHWYw0eYK1ZJJq5TP0N0MH9MoTJEJ9XmsJvEiDxD2hHp/Nw6AAQPpVBJPjcu/f8YaPaI44R3IpE49n9SIivJZwoLN/mLCJLhS8629iq39YJrXKRvvZMSlZ8ncp4vXVEfhW3r8hwKEFmNfIVAJ4gX2J6hIWJP6BxDcCy09uhv0HGLKTWLl+ePteZWpX5PLzhlEge5XrRWfaGVDYqnIOGTYOr/FlgRSsV7oUsL7KIxyTW8uxlhWniDorza1uhxkjH7+3yvLNWoff+GO7AYsxzb8KUQcjHkV9C/J6cKf2uiX9T3N85v7o0Ix9zsy6Om6nLv4WPzyEaMpVpnwJyxSqRAfZmsFXCaKAMlbDPx205BLPeSDU1pnxH/xNBhgbkw+1sfqjzEnx56zRMaaNHWE33JKkfIECcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(10067099003)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X14nL7tNU4S5v9kiH6NZ6wo6/gSfyiS6YwQD2hR7ZaWDZqe3JO/yYjn/c7Iz?=
 =?us-ascii?Q?2B90vyYvC05DOh6Lvw41B3ASltakvEvmI7QGaj8920oyjYhYKcMCwRcIgPx6?=
 =?us-ascii?Q?77vxE0cL9JXEI12sc0TP/eB1KM7Y1tQLG1jnFVUN2sbmJkBUbmxscq+RScwg?=
 =?us-ascii?Q?yJAqSI61ecn+Gqq5Gt8nyyoVkoKnu+wHjc3jmPfr6XbwSriXqXWwfrNoj7Sv?=
 =?us-ascii?Q?ZjEfye38uEgYf3JVnyeNUkMAKgcCJzrKiOL8WvABCs/knAO3f6Tr9ZJfDVwj?=
 =?us-ascii?Q?w702Eoyh+QxoMDUxT5zuSuZYHYPCNHe7VklLi3ifNUdQK4ykDR8hvuP6YW8L?=
 =?us-ascii?Q?F3CW+XE9B31HYSKaUl9NXHYkArgTlMlIbOEDCS9JwXbSGTNfiVeRTtsLBcNA?=
 =?us-ascii?Q?ZHmOjeXRupZDZk5WlowBiUb+hYYVvJxYsJnKzOZcD+s9FRRn5nFcSCCn7r85?=
 =?us-ascii?Q?70zP6Siw7z4DjjPs+ut0iUyV3taOxz1AJB521N2hl5tcVFvlsr51l0qlDGrr?=
 =?us-ascii?Q?P8Awjvwe+0Sv6oFSL0X+J5mWz5tWccbxUGJKLs7X4AlrJ6zzBU0OCFTJ8RBN?=
 =?us-ascii?Q?vxuHkwsE+fo71B5Qhm0VZji86lFOonkk8IB3+bSYMFV/6QKvMTCUqr79xKH3?=
 =?us-ascii?Q?eHGK8P542cisyJpBGbot2xHkj0AEMvE3kHHHViRHgs+MYOQNWi4aoa1uw0u1?=
 =?us-ascii?Q?i61Z2ngw1cKDThj7IEwcF0RhC2Bs9x09XF1WB72Jz8lEjEZemnVlBohZUasT?=
 =?us-ascii?Q?E0Md4MhxJYyUFE5/KptYbAIVG9pxi+lscL3RXqfkRDcOMkNq5zzldq1sbB/Z?=
 =?us-ascii?Q?ljGXIJUG2rKGx79EVe/5KeXEDm4Alnlro1mdafUKMW7QHYLUEbUtviIvDXnX?=
 =?us-ascii?Q?fnHB7KhAS+iQ+7lkLv5pOfwTOfMphwiQX6yoAR1VdbfBusLqEnZAwhiorDNf?=
 =?us-ascii?Q?07ZfwGz2TOfGAHwDhZOj1odccLgXtyYqbLeLRSjEGPWzbXOxfd/pFbolNrAi?=
 =?us-ascii?Q?W7oWot1mgeknOcgM3rkyH5htTMVeb02FHpanZzFS5ukUJLgfdQB61nGXgd2z?=
 =?us-ascii?Q?dnwaek+XQFcJVC62iPafxsAyclyfT2M0qP6FK6riq+iJxAKF9+16PlwY6jMU?=
 =?us-ascii?Q?FU7d0409YkMXKgZjAA8IUhLT6VPFUl4TVXEM3vmaQSzIwd5qRC8SLxzIgCnk?=
 =?us-ascii?Q?Kx3/cMfxLQZocJYffVwjeGoQrhkuyUpS1iHESDKh9Do31ljXWHuDZsQ4j3eA?=
 =?us-ascii?Q?TJisOFbT4DhosBjkrfChS8siZkHJZyOPKfMAhUnQjZp9hNu272zZAeRT5OA4?=
 =?us-ascii?Q?DU6zXVBLJung64ZXBNgiW+x91f6YOStJFOjuz+e6d0PcVfKRzu1t5xeUGIcJ?=
 =?us-ascii?Q?rdDqj25/h+70gA0PsnIFHcNhJvH6kKMk/SDeBwbm4LvD7owgi/pK9Rk6MONZ?=
 =?us-ascii?Q?jkCJ9cTl+nhNBW2asCoSAehdtA6zLrjhxUdTNqbCy4jGVzL/HD0xAW8k+CFr?=
 =?us-ascii?Q?NA2k0iLqKZS7orKzyKUK1j9vLCC9YTdzIq+dYFvXsIqzZAYpctK+ddkshWZ/?=
 =?us-ascii?Q?HiCVhyEv8MumovxfFhMNycjzPj5dyqsq3biHPLtt5UgYpSy9TMnyw3z3MpMI?=
 =?us-ascii?Q?7xC+lRSW1QJj1xTUKgKwpNtI9lv2S3xxCLt+Pl8Eq89Fdi3Wo903/H8GAQHf?=
 =?us-ascii?Q?UzdKAYlr2S68E8ZF97ALnyBH+EJ1J2KgCnrjD1BorYlTAugpQBQO4fCU7uOi?=
 =?us-ascii?Q?kq0XccgOvg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 437c819d-d6a0-44cc-d10d-08df0e504392
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 08:56:40.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T0IQEassZoZz6/AzuUDGGe9bjihmd/cZ1kroqU+dA+GIpWF1/0NRu1/jkDmE5pKKwYA+4I03GiQaa9I4CkDwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7266

On Tue, Sep 08, 2026 at 06:17:24PM +0200, Vincent Jardin wrote:
> Hi Ioana,
> 
> > I am indeed in the case in which the uapi support is builtin but the
> > dprc.1 probing is deferred, thus it will get executed after misc_init()
> > had a chance to run.
> > 
> > The deferral happens because of_dma_configure_id() returns EPROBE_DEFER
> > since it waits for arm-ssmu to probe. How did you get past this
> > deferral?
> 
> I think I isolated the difference: I guess you have smmu enabled while I
> did disable it. I checked and when smmu is enabled back, the issue does
> not show up anymore. But it is not my goal.

I am not trying to convince you that the patch is not necessary, I am
just trying to identify the scope of the issue correctly.

> 
> I do have with my dts,
>         &smmu {
>                 status = "disabled";
>         };
> 
> for the mc to load, you need:
>         fsl_mc: fsl-mc@80c000000 {
>                 compatible = "fsl,qoriq-mc";
>                 ...
>                 iommu-map = <0 &smmu 0 0>;
>                 dma-coherent;
>         };
> 
> it seems due to,
> of_dma_configure_id() -> of_iommu_configure() ends up with "no IOMMU" and
> it returns 0 instead of -EPROBE_DEFER.
> 
> So the root DPRC, populated at arch_initcall_sync, probes now
> synchronously, before misc_init() registers misc_class at subsys_initcall
> and so dprc.1 is created classless. (I hope I did not miss something).

With smmu disabled from the DT, I can now reproduce the problem.

Thanks!

