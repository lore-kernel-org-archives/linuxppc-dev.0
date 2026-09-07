Return-Path: <linuxppc-dev+bounces-26673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECADC79F9E
	for <linuxppc-dev@archiver.kernel.org>; Mon,  7 Sep 2026 12:41:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hdmss11tCz2xk7;
	Mon, 07 Sep 2026 22:41:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788784913;
	cv=pass; b=PEK0jDDaLcgtedQrhDV7mW//o4+MKQh5SzzvpnV7vi7azX6yImngC5r92qIN88qmgiUFzdUS3U3C9h/gvJlXrx0GklzLjP/I/1myiJdOx+DgAqGdMvhmmCM5NTXaWf2SUubdUZ661OOx5/HFLI3ArKb09iz1mEqIW+ReGH61McKctd8nmunG04i0CWMEFXuuuHtfWb0Bk19e4w/ev03WWx9nN4CUokA574kvNU1mK80Vv1UqphY9Ap6jlh35z2Wn8SZPWelm7p4mgWOaFGgtd0z8MBY/LXOq31zQEaTk16dc0Jwm+pmDt2ns2T75Blt+HlGvOsZL+Uuuxrl9cdd/mA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788784913; c=relaxed/relaxed;
	bh=/K8LDZYOUHw7Ya5sEO7TlPa2yHbZMv+H/IYUFcNLtkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fhnjbB5AP6AXUaqsa2LmbQi/tf8UnXCgD+oNInzSfnWtwEpjJCuxuej73FSfN4Ayq9xZbMz1RSFrNqNpx0oJxuWEju5hg00IkTWutdaf0X0aN/ePE2AWEKpcK7XKkTdqZLBvY5UlRV+pctk1LTEitmx7qPp5193Dicarq6N6msaNWAo+6ZuG+jEauPzJIS5PKemsCO74+3vqq0a+iGrh+rIWfUoWc5JvQg/OskVuJWTStzZ0kvH/t25JWy67IRGJB/rFkpHqc20rjComTDHgRbY/hooGMIsMIZ/1nGqWMsTCziQSzq3VYltBLQNFqUPmH8e5NviOVumJ+nIC1hJ/Pw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nTvfwZSu; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=nTvfwZSu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hdmsq4GgYz2xLf
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Sep 2026 22:41:50 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPrA2wKLGHY3+O0z/TKvn+YPLP9PxWski3HctRHGFrpR3u+rRyhN22v1x90s/1oF4kvWCGVVaJnw5Yvdy1/vYZZvPcXkIIYoovR0TwNasLSlxnsgTzGJD8hkst5a79JjKG+oPxtJbHS1+/ZhrExZRUOo92eFEEUAOG3Fm75xSOnjQUW+7arC5oWDVD1DrDtxYPf4YB4HY9L3hKz7lJYMHh03d1aZjs5UGKq605eWKR1Z6HsD1WTMxtQMQ87Uh5BzuFtZQ2dLAl5cfBEI3DFlP76LuaLBdlLjT6ZBaopNEvaJ+nei9TnGDNL1MtQua3bIJiwwVZxfx+auzM0asthcrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/K8LDZYOUHw7Ya5sEO7TlPa2yHbZMv+H/IYUFcNLtkg=;
 b=Fo18Mu4uv+sSnF9ziXlYH0ZO1gJ/XhOD/cRnZY7chSJ3Ww7y57D0EjWAlbuH8pp1/h+RWc2Gzl+gZgmIy5xMTd4b0B3z7cO7Gd8AZapCIk4YLHPNW6jPDbs5fEUVA/WqDgpVDcHg3MaN5C5MrAx0GjfKNyiKANZESfX0uwtsaP4AOypSzmzynedLe9aVCCMlCfRr8ZGtZSfvjGNUD57bgVKPgua4Hj+7/RWwcikFjcNJLtGXYJBYMtQq0S+htN3xX/OW7Qm9uHFIwbL96cfZCGUHVLu11S8IC6ywwRGP/OJUWmDCO61DKsG+W0GzHulyx3zF8/+mH9EkgluLa6gTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/K8LDZYOUHw7Ya5sEO7TlPa2yHbZMv+H/IYUFcNLtkg=;
 b=nTvfwZSuW9UEBtxSiw8EdM7d1Y/6+WAFdWlQSRPK9kf+RnCqpOKAdZcSVGZooypmiY5e9k0/XY50eJQCj6OOykMX2nqfSQrryNpAm1PhmUzWi/aR0oH3uwGSkguNjllqMTqR1bdRXNKM14XveHAB5ioaAQsif1mdJLH6g0d/P7MDiABIkW4eUFCu9CgCl4Wgd9ezUFfD7Hmy5zUyQ1FwzMfK9BVq7V6wGE3rC4aAtt+MVlE7HUadp5JGu5Q7E+sHY9Ztlm9uKI7vhdhrNbkMRuL9SCqFazj+3jNe1tDPVZ7H4CE+tU7jVMWMFRwVe+do87GW47fGEL40M29uU13ysw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PA4PR04MB7583.eurprd04.prod.outlook.com
 (2603:10a6:102:e2::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:41:25 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%3]) with mapi id 15.21.0382.012; Mon, 7 Sep 2026
 12:41:25 +0000
Date: Mon, 7 Sep 2026 15:41:21 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: vjardin@free.fr
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable+noautosel@kernel.org
Subject: Re: [PATCH] bus: fsl-mc: register the object drivers after
 misc_class exists
Message-ID: <fmmf72ypmmooyxszz3l47xabdhvetowgvbmbjmvj6bumuh5onh@pntmny63urbg>
References: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901-for-upstream-fsl-mc-initcall-order-v1-1-36ffe48f767d@free.fr>
X-ClientProxiedBy: AS4P192CA0019.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::8) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PA4PR04MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e95249a-13d4-4232-320d-08df0cdd544c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|23010399003|366016|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	QqqntOa7tTc8zF4nFn67pneRvI+gCiNpUW72gYGE2396CGvg484LBIs/p34YAZneyXUh0/0Y/oF4QS4ZWehAVZafeLNo5cpsxC6Ya5e5Qo8YT4gwDgqkhpA+xKtIlv5gWAdQXe5X8YN76pga/jd7G2CJQtD6cmhKlW0LV2i341CfnWV2GURZKYXHgw1sLSWIx5XR2+FqKJ4YDVSUGLachekkuYUcQqVJsfWtIYesXGph0/QrC5KsqzMff7NRboR75YmytREKYaZk/Lo41RyUuF+5r5JpyVm9WyRc5QvYG1Eu9K0jLqc3tR/9ChvFKHFrOLw84KeucOiKZqejJmdeg+iiorQ2lzJrh66G+zJ3qbacygmpCuRT0vaJOW9pQnOqA0m8/Kw0Ve01BhWEe2fx8zxiSeCm67AsdKA9uSlzugtNF2QoYJWvOtdPcLKYUyivtWZVTXdj9OaJfyF22VFZMjX1mEisC6xsgLeQYkODoMWQRlnyeBj/4HEALSUmm+GeA72OMxydB6Tkqb9vWtDSFn+qNqP0n35Gwr4aw/0UeOJMM4RUES5OTmOMItPw9NJj8JZ50UjaLYvR25TRG0rOEKOGvO1x7aeJ05GapxGaELeIhdig+WjZeZFpKVZsO3qiZaRD7eyzDj6RlFuAjTNrmesKTlhc/bayWL2B/VdImLVRGFZu87cmoyZ/0pO88nSL2xyhGRtfxPA95NYmJIToiZsaRIKqXO3NZvc29I6uFSd8xhQ45n2QbgFmwJekbxj1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nu6qi5raqoqIZVpIcr2D1wir8B/wJVOkU0vhmJG8ZF4Xn5ohxcM1pfBOvOOR?=
 =?us-ascii?Q?EAxz9+RG6WwgEKUXFOSKkiNsngmpERr3lBGuRDTehYiYSerHuXEPZRzm2jIn?=
 =?us-ascii?Q?7wa1v7UoImpd+NQzBbLhdBALNjiy5bbI4beCzhF3ENKGbTD2alef3/9o51a2?=
 =?us-ascii?Q?x/RUSZCC2cOz/mPLYhxty/o4Ew7hRtZJtH1LOkxCL62IVtm/NjCds4zlZCRD?=
 =?us-ascii?Q?FDTZCuRz+x0ssoD6KbVKXWMx/hJQa5YtqNb03SXprlLCNjIZs8Uyp/Kqz2fg?=
 =?us-ascii?Q?OFgy7N7+2pOL+1l1UyUurYvTWXzdeM7nJ1dZlyUp55gtjNCtCOtenZ+2z7OF?=
 =?us-ascii?Q?ch49KvM4I7sSr9ljoU8FYpcXU0YSJStkaw91CEwwQndqxtI7gbyHP0BksGqq?=
 =?us-ascii?Q?ySuBmSHr7aVUccb4ab7wIUcjqZfJk/TziaFPfubKraOmYBNmW5URLA2tZgRU?=
 =?us-ascii?Q?Jyheh0D3Eo/qvJ5haBh4J0bDrMnmN4c0kjPUAU219HIaPLYpogrv6IjsFMig?=
 =?us-ascii?Q?lqlSsWsmtckz+gGHClvXnQUjp/TM0WRftwBD6nWwm1dMTuQu4UDS7oBeMbXM?=
 =?us-ascii?Q?tWlNgwp70I7AikWF1HR5ixSwR0cO1L0JKMF4DpTevh8agqYUzJfTs3mOhEqZ?=
 =?us-ascii?Q?MQYpFR+SKF85naIxXS2D6v+WrPHHTpGp3/WyQSvxIwKdiFfLXT9MHS9j0GrA?=
 =?us-ascii?Q?7dEw9kfAjnKn8NR4jakFzqCOErHrdFVM49oAOtrOTFtufXx9PI9xIX4/f9TJ?=
 =?us-ascii?Q?Ou6379j1KlimVhwqLFqX5UFWqAvY5aFJkaaVtbHD96veHCpnklSi6pabTFnx?=
 =?us-ascii?Q?jhbQN7sEpAo70wVcrlv9Od7afAG7QSB51oVO79Xz5utt9rMh9ADuHXVowCht?=
 =?us-ascii?Q?2f4kDDrgtylbMls3teP5j+OqlyyOFE5KJdfJqQYnfpsD3zt+AJVrJLAqg6UB?=
 =?us-ascii?Q?xiGcAaYOMYY6NJM4v9GDA0Ntq0YrhskUxQp1RybEbSuE6bHbPiU6t63rmzp/?=
 =?us-ascii?Q?dbia2yz4ZgwMjk54RgMbH5t3g6Eq7vU6TvNfvan77PjAOfcOjR/j1hYQqYyw?=
 =?us-ascii?Q?WoKXW1atUxRV+bNrmrkw5zmXqoyzYBImSy08pHANmKROnT6/HuDQllMo9VWE?=
 =?us-ascii?Q?Xvk1HIk//bF0s/T2vSGI642iQFPYaGbLgwcd3Ebc5oC9M7uYU6SCY4pnMHZu?=
 =?us-ascii?Q?2kiBWA9LsqkR5XB62VPf48XJR+WL4FIffaM34x9JhxYCqDYmWrvRTEiDB8QG?=
 =?us-ascii?Q?llDotdn3iZb7FxQAqkhxdQjZNBCyPjqWlvy/9NTfWD7PRe2AHDrRq8//RvP7?=
 =?us-ascii?Q?QUwnVFLyPl0utVmXJOZ4fCksk6MwCtXR4VkG6QFXIq2OjcASM0QUy8q38KSt?=
 =?us-ascii?Q?lAGxBICgY0+SYxMq1B8WhH9AR2CzPjnHiUoG/QU8oUU8oTILbBhCor01aztE?=
 =?us-ascii?Q?kReFPmvocSdy7IJOGl2+zZsiwtVECybGsFsXLZjIiyaouG9laQ/zdMrAJMDS?=
 =?us-ascii?Q?lNys4ppIieqWkChTyNOq2KIProthm3hghDMuC7fR9Vc+E4bBY9ENOlN7r4m2?=
 =?us-ascii?Q?5E8nkX0wZpUsTMT/L4W9ffgafIZkj7b6MkciZw7kKbTLfnQzz/K3Y5GVzSub?=
 =?us-ascii?Q?Yc+8sRDM6DFx3XSWJmZ09Nctvs/segmri1WERucnrwBDwH5xL+UHB6pB5nTc?=
 =?us-ascii?Q?NKnrKHQc5GRPeE51wip/cTdFfOGE1ZX1b25V4Z3pNg0a0HHfod/YZUTKYu33?=
 =?us-ascii?Q?4KBhXO1V4Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e95249a-13d4-4232-320d-08df0cdd544c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:41:25.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V99m/5C9iScC4VmybNk11Pui/Xe5X9COrd9lgfN5g2xJzxKEhszwjXcdTibvQGUQmawHHMZ04Uy4bekGPL67ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7583

On Tue, Sep 01, 2026 at 10:04:37PM +0200, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> Unbinding and re-binding the root DPRC fails with:
> 
>   sysfs: cannot create duplicate filename '/dev/char/10:256'
>     misc_register / fsl_mc_uapi_create_device_file /
>     dprc_setup / dprc_probe
> 

Do you mean that the above error messages are triggered by an unbind and
bind sequence like below?

$ echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/unbind
$ echo dprc.1 > /sys/bus/fsl-mc/drivers/fsl_mc_dprc/bind

I am asking this because I cannot seem to trigger it myself. There is a
misc_deregister() which should remove the char device upon unbinding the
root DPRC.

Ioana


