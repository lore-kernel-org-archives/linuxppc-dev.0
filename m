Return-Path: <linuxppc-dev+bounces-24641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8853C44532
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2026 11:01:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4rt206QVz2ydn;
	Wed, 22 Jul 2026 21:01:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784718105;
	cv=pass; b=OB/z1eOot/gvNxJ/jruc7TDzsTDk1FZ3ibPHS5Mbz7JbjqiZDPBry0mFydKJjU0U2jljsB8voD/wv2Yj0B0f+JZNBT+l1aG3Y7tpRAKM5V1MGYq+uvrHa5TPDCt9VO22hl771AVBKD+/6CCRA4tzqtlrF4nJI2wTfy7hLj5YAkAF7cXyERe/5YQBZLs6feKgALbX6bMsPUi7AoMW1jYD+uJQQvXJ23xbqQLBuPw+x7N026Vy5wM3/lUZxhzGMxueTVNRSIZIxIeJSOz6Vu+8N36FoIcryIUPr8SIvVtccSOZDG532BajlOQHIzQI1Qs1DR0sAjRfth7l8PmIQzh4iA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784718105; c=relaxed/relaxed;
	bh=sVMK55xDG6B3zAQsQTMbDzUHCdtkVL0JfcOKf5RzWhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e7rfonLRZj1Y0gbjKDSysdbrKNEDb0HXpQ0lB1f3/WpT+ZXErQhNTE4hz51hBDxG9k3+1kR/tr24qWVNaDMmkKsMP5fIePWVq4FU7Par5TUtVMyXKRmII471DBMaZatIbW8ZsadL2rfFvOZrkAlUASAzaCa+DzU9d9nI7cG3zcAZka5zjKyfw9MyZBz9Yb2KOqANChobQZoTdZLnpMIxNbO8gRnCFYbTr30WD2aMJUOYX8/V2fFqvR8pvd4cPv2Ol7o15dmwQI0aoTtgVIv+J9FuP4Dl2gKlQM2rJbVfdfd0mWjg4ZEvnEwyv7dLhnD/ufJMLiF9uDbISfRMO3lh3A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OL4Fjnxl; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=OL4Fjnxl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4rsz6yMTz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2026 21:01:43 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/SwW2TRg4R9d8wzAvRo++VQ8QjihDBEefCLWeMiDCCQ+t1hxcgH9BFOE3RbvtP1KW6wqRkiIoj0xQwbfuvyW3qkgzAfP/ZtVMJWyD3t7uncOyY0O/a1YKZAR9EjfRoSgDoxPVojtX1HoJ/mIR0QqUylKs9C4kyixPWMjRE1xxuX7KXn/f395IICkgTYev6yEEJpFsft5MYtH/+EcKrcOVkTsVVA8aDEjNfuZlGCvxX3ffQunl6u3vWtnpFKxVDyl2Vhv9ykvNT1Uqvsc1eHWqVl1Ob4v/Vrg5SyFZSDORGWdFJfoccp43IX47q3JWznyVf7phgToEX92kvA+UWCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sVMK55xDG6B3zAQsQTMbDzUHCdtkVL0JfcOKf5RzWhk=;
 b=W1xmZDkmy8j67iRDxxsOgM+hS0b4uow9EsR3tj1CECZ3lrxH8IyRq0XH+2wjnX7VCXpz7B8bPuLMVrRsp9V65tkuhgGh+JkzaDNvEhLZrmltthCOTg+eeA7YpSjM7S2w/CpLKoi8gHzXc09T1vlf4C4zfb9kLSQxymF9LKuTWfwxQkQdOPGhXuzHXpGiW3Mjs6ZZ/RC7fXaMBcLBSaX8RJBZc+A8Va5DvuCpgn+Cz7g+eH5Yeh0VhkGlhGHcq3hAaabPtsDyN/WCAp0UyaSSorPvqCK6MTkSN4KKfiyPfUWzvDxwhD8fAUcEW2/94g3nnorT25MIZ2UCxrFz9cjchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sVMK55xDG6B3zAQsQTMbDzUHCdtkVL0JfcOKf5RzWhk=;
 b=OL4Fjnxl6Xed7JK2NKozlSckAOBj9GS1VZW7bBYEw7Rxr9xC0r5lZQFMoKVZ53FWWE/q0YK9s6UhwfiBm9gWa76f7D5RQluFfRb99jL0VOA//s5f6ClGwgwAYjLWNslC+55Lo+12ouayN3l7MbVwOu2BB0VkxzyN3IqY7nEU5i6y6jvLL4ITrs/wnOEdeQ4UFPknE1/T40vDSsh9eWN/IiJaq0RLa42WpXN3ezhAheCBj4uokd8kYMcXmjTlwQp0O+zJylysTWkWCOch1lrandOlXJX/+M011Fkm8vAMOWPLFGdRmGtXvLSvOlWpGpMopV8ZeThxfUmzICUeGwg/iw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VI0PR04MB10805.eurprd04.prod.outlook.com
 (2603:10a6:800:25f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 11:01:18 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 11:01:16 +0000
Date: Wed, 22 Jul 2026 14:01:12 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Tanjeff Moos <tanjeff.moos@westermo.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Michael Walle <mwalle@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 phy-next 8/9] soc: fsl: guts: implement the RCW
 override procedure
Message-ID: <xumth3wb3bvui6ywrithgazf6fombn42hisikprtywkbuexypn@kugdqyce226c>
References: <20260721231603.67865-1-vladimir.oltean@nxp.com>
 <20260721231603.67865-9-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721231603.67865-9-vladimir.oltean@nxp.com>
X-ClientProxiedBy: FR4P281CA0398.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::16) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ac55c5-a0cc-4f4b-031f-08dee7e08d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|7416014|376014|18002099003|22082099003|4143699003|3023799007|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	gPhVywYvXAD6cxc/nEnVAwOIneunXOWblsvzWXrgxIigLsyTmVs+Pcde2Q1LxZ8wbo3v8UX125tZg95i7HRibOxt7iSPqtssAaFsEGF5ns5+URsHnXyZacmtuzaiCyW+nu6OTJHDs20fXgEdT5F/j+iuTgN6Q2sRl9lOjVJaL2ZTj2GkdItE3l26zx6wWShYzl1VYNSs2ZU7ce5TgoAQdxpaXkjhVT/XdcPDBugNc9Op+Yld1ts7r4zwPxEfq0ogQG4ZU6GZ36oNBE1DxTowMYDa+RF2JiHDZ2WlUQCa4p0rFe9N03w6KbXcqYQf4WloNnyxY1cfQFrYRvXoWm8i1X4c6wTpqRJ3qwBMW6DwW4LfkP93CH5UVrDmBIE7LVxQdHLO0eo74im9wOnz6a4wOUZnn+nHlxGYWyqV3u/B3mkAzENL2zkzz5jUG2vP9UjJ9vN2LNdVQml3PwKr1SJaY8pwWuebFfGyh80DR6JWs60j0r5XODBwyeSGp5vVdcMVyN+tYGAQw/P6OJHejI/akuIl7AV16fiM4KkDWCjghOPNhekzNWRY2P5e+niXWeQtTCQ4/ebAC6LJajiOLDqvfwHWY/bzQlDuQhPnOARkIrzgH/wd0yQgKDIQpbTuOscfprVd8eWEkl80HvBuHMnYGQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(3023799007)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1i5me2SzcPvYHupJr5lL7hv7F+asRuH8H/zUJWxna7FIaw0sRcBEsSy0t28N?=
 =?us-ascii?Q?hZsb75u3kXNrq5rAxSWEVFQmqsrMjv6tJoQm4b8FeNsS+rp26HhmqMlVXc0C?=
 =?us-ascii?Q?3X63xa6oWAMv3B4mpPJX4fjPG0grd19SabfxPVL0+5xNEs+nNHjN3XUdEXy5?=
 =?us-ascii?Q?r7CVeEOBVedwVb/lbyRVklVFWAXENOmaBmJ0S4bixvbzHQAqEBvbXJWM0fqe?=
 =?us-ascii?Q?xzVJEck3rJPkiFeAYHkuNHthHw/Gnddfm6ExxUaPTOsw0/PHbWQiKmUY8eoW?=
 =?us-ascii?Q?H9SNj1Xkosms/s3OD3slmehN0MqW+e96wPmPXYqvzVxlKdSvQv2JbZQ7XvgU?=
 =?us-ascii?Q?L4GC0+3059bCm6Tj6VDodnFBsCUl/tMrk1wHUg6Mn6bXMYD2s+dZo9OVGiEi?=
 =?us-ascii?Q?fVCpicI3myiwoKuj/OA+ruMDjJBLgmHLAPxaPX5udP3KyO72NDDGbwb9tYTP?=
 =?us-ascii?Q?BSpR2KoTkXqIDE8TKHhOAY5hGzci2S+dRcyc/C0xcjpLkqIi9TN1t3cgXvZl?=
 =?us-ascii?Q?0LKeuIopB2CbdDcgx0eluU7/Y9JOQn31E4RiQQ1ysdFdfE+I9C0E9CcpWi8W?=
 =?us-ascii?Q?NN3YyvmRh1ItK0k3hgVCAKUwYPmc718gC3kwUs0PvjS2NOqy0IUoPj/nGUf1?=
 =?us-ascii?Q?0tghR6C1WFpaDCYerPNrnpp+YxWj8XmRWxWqM8C+72qqdnwsTi6M0guuLvuX?=
 =?us-ascii?Q?Xch0FdSa0ClxEOYlcYjXFbwGxno9S9UpoTHnwAEHgl5LYal8WsCXY8yhRlV9?=
 =?us-ascii?Q?ceShFol1Z6jX9gdzXEkgqe5Mr46CEve1U4XCZdCx8fuGahecXkQ9e08b9rzw?=
 =?us-ascii?Q?44FDU4uERf6JBDCL1DecCViyfo9jvMfAlqe8kAuiRZQr5QDrTAHhc3vsznly?=
 =?us-ascii?Q?A9gtJulSoNzhEuYfjZVkHbZP7Do83821vvmT8VfC/gJkoRrx2PQ9KWnAfqCo?=
 =?us-ascii?Q?vQ5j3n9bIIp2lIoUXc2+U0T1IdtVyQ8TtFeXa3AqQllvwAjab4in9JPOjZ8Q?=
 =?us-ascii?Q?tMgYyxwP112x2RXv7TyNuV+IqtEIVdrh/R/yfaVl59FMiZMtZ1TwZtAmP1bw?=
 =?us-ascii?Q?6iKzAlhmgdeZ4vcKeL4bhBB0Yr4twobZQTp/2BjZiDOULlUhUXrxxZ5fEgE/?=
 =?us-ascii?Q?3sGP2RLpnkJql7dFKiT1payYvUh8ttarx6RQ9yCuoqq4TIcVLP2snfkLs37x?=
 =?us-ascii?Q?1RdaBgDQ8uXOCJMLmuluNPKKklGUJgPwVW2ZaVth3uibtd5QvBajYj+tS5KH?=
 =?us-ascii?Q?mYKJcn3YSdFxluD+5xGE9J6S7vqUue1blWVsQlYZ9G57Iznsxf9X2wLlq7Ki?=
 =?us-ascii?Q?a6UhELgsbB3LtvCIGtK40P6tMqxXxRHkspKQ57a2f0JbP8zVA2XkeikqgPKk?=
 =?us-ascii?Q?DD86wSuRyHeFfxmddsHOBbzSCvbSPr6NBfR6IolrcVnoxDZsftxIduNHmI29?=
 =?us-ascii?Q?nI+KhbORfmWvvZ7tAWMsFC3+sqGhdMRjLmQ3fijOFs9TkwueIAI01OKRrsHW?=
 =?us-ascii?Q?gzzvjO9U3+uodHyWXnWAtP4YoMw5H/G8wij99TH2PnMqAXf6YI+u4oNpqQGj?=
 =?us-ascii?Q?LQSPFrD+i6T5/9zA5+3zLe+XUvn7IjgM975m4GOSWjk7v9HIokHAbOUQZkH/?=
 =?us-ascii?Q?drpHss8Hf2ZUDatPljWf8AUDO/GXRR0xtDdvofEusQUZFN5xhG4zj+E2YMyB?=
 =?us-ascii?Q?eTInKlIaqzZGK+rap5mIIrhBoReM3ObOrjHuFlzu9LoNvMAwng+6snTMo3AJ?=
 =?us-ascii?Q?V3ifIL9tqw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ac55c5-a0cc-4f4b-031f-08dee7e08d5e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 11:01:16.4864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1i7dCdyiGJ+Qxw/f+Xv8fFr4Oo6m9qilIi4vWB2xVHcyQO4Q0L7SuBdkwm9HdrJ8JFTfRFvRaebq+8TKW5VF9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

On Wed, Jul 22, 2026 at 02:16:02AM +0300, Vladimir Oltean wrote:
> Add support for the RCW override procedure which enables runtime
> reconfiguration of the protocol running on a SerDes lane. The procedure
> is done through the DCFG DCSR space which now can be defined as the
> second memory region of the guts DT node.
> Support is added on the following SoCs: LS1046A, LS1088A, LS2088A.
> 
> The procedure is exported to the "client" driver - the Lynx10G SerDes
> PHY driver - through the following functions:
> - fsl_guts_lane_validate() used to validate that changing the protocol
>   on a specific lane is supported.
> - fsl_guts_lane_set_mode() which can be used to request the RCW
>   procedure be executed for a specific lane.
> 
> Since the RCW override procedure is different depending on the SoC, the
> private fsl_soc_data structure is updated with two new per SoC callbacks
> (.serdes_get_rcw_override() and .serdes_init_rcwcr()) which get used
> from the generic fsl_guts_lane_set_mode() function. These two callbacks
> hide all the SoC specific register offsets, masks and values so that the
> _set_mode() procedure is straightforward.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

