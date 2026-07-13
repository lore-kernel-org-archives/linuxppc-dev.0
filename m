Return-Path: <linuxppc-dev+bounces-24110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5E9C44501
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Jul 2026 11:09:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gzKSr3tSlz2yMm;
	Mon, 13 Jul 2026 21:09:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=fail smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783940956;
	cv=fail; b=k12KqpOE7Q+5mfiwyc2kfApeMeZOZkEy5Ia98AQUYgLjNnC36Vq9Bmd17Po6V41LYa2oUoXhJRP4zsWl29kaH2yksaqH/qoSySa+Xf0VnBy4w0870C6wYrEGpQBxLV0n3sLbolX/xTlICCKdTmXs4P4YKxEU0IRQRUksAZqh6DNedTabRH+5Z+6ezusH5dB9GUUT8O1xRbdWhUBYqbSRhqHn4cQn2DpQuryUJfHfxhpvfQIJspsuvv5R23P0+nVvYnz/77ZtrYBiR21T8x/0EkMrfmFned6VqEvAkZfXeGxtsECrfWLLLsHu78i8USfGggmqfVREDrVgogRRD/gTQw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783940956; c=relaxed/relaxed;
	bh=oh2Z7i7v6Y9UrNiQQ8G3N1MWN2EvAcTP1ysqfGnnN2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IpG7siql50kIDVsQEpZAeWwd5zuZPAr0KfCMXNNRoySHfbbOqiQemuLjvpuB/rG/AooBccK/CQ24yWsLpJ0deLAs0L90GMxk93ZfPd0mWPL2yVMs8inKswZ1AyaCHZq666kPqV9Rl/alzbPu4t71Cv72TTpOvPFwxYucFrYq02h6B8g5qMbZcC67xtml4u6zXFE5Ab/rINF7KCleOVbxMAWm4qWn3GBE2QZyQdUqsJzitz2gOu02O8T4Kbs7oJVJWbz7majdOkEgVPhTwThwcUrYhPVRBakaP7aLXxUBTWhPE5Si2ZnY9RBIYIxblo1+8BdWEm/bYcP+K1F13CeAGQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com; dkim=fail (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I2CqXhR3 reason="signature verification failed"; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=I2CqXhR3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gzKSp2c6kz2y1F
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jul 2026 21:09:13 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZxntUCkhcZO0HtPovXvsE27WjHl26dwH65L0bq1X46Im6v/d7P3nJXklMdKkBBNXVMDsS1ShdxG3wQtjiBLeVDV3QGuDYTAI+3d5ERTqQKge8xvnuRjtEbCkcLhbTe8qGv4QABbPpvIO0hyS0lDll63Z19gUmQfpatNoOgphCLxO1l7e4ZCsVmVYpluCHlsTVHqgfNNkKz3agmxsywGFf5W4ZWD/XikQwdtFVWcNErtxVDQpJXa0plUq/42Th/9Ifpb9hPG1Y+cEcmIC4fm3l3dBG1dY7XjCfbcn5RZkF26+pLmJZnr1MEbp1vedjXfZubOdhT968e0vZGgMLaeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZqZd/0gAEqbKFycYSg/76QIkKOWux91Y+SIQ0FPqU6k=;
 b=UfyxW5wlwo4N5GK3TY3nbHgkxkE+EyfAPWFyIsjTmIIiLmIlgQOMmULfWhDHxtnBLQMa7HDGmQbFdSTnxH0NWiTlOI2d5rkgfyNiEEPBvizXC5slghBFFxYbAm0VZHBSeG/CVqo+n5FjV8nV8Rpw3S6f/djNi+JXr++Z5See/zf7dE827luc6ar31oLsJtfHpCnFMcQnA8rhdK8OCNDw9NskQb0YozLm9PhSwuLCJkLYeypmiMaOpvLYcKKimtW4UNyEbYWyR9QZvQN851nteYtVKNjXhWj1PJdCj1cKtBXhRlro5zEWkKujtP2mjfz9iF0oOvbA/Pc3KL7H6macMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZqZd/0gAEqbKFycYSg/76QIkKOWux91Y+SIQ0FPqU6k=;
 b=I2CqXhR3UlccKK+Ev3qH4NCZNw4A0rDZ8CmWUA2rlsILWEl2ymvnzdc5k0YqKzdKW+Qqkbw7VussgBkov6Y6ldyOPpTDF0ov0KZdr3y4b3bRjRWJ3lpVOfxYGCrmbXHBgHNjL7atlLsa7A4EG8HRW1x1OMmaNnJ7gmOk8VCDalIO7bafKyWvBerltqV6+k+M2m18n5GLeDOJxV2E9VY1N0G37kdL76qP9vZ74SgJY3BXUBB+976z5LAAlOwZFSsjQmez0HJLDfdD+BRMq94nskSZrPRb76cT9cbR+Tt9OaWHZS+2uNl0BY0UUT/qeQguIV8/lYwOkbGDuV/o+Jnv2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by PAXPR04MB9005.eurprd04.prod.outlook.com
 (2603:10a6:102:210::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:08:47 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0181.014; Mon, 13 Jul 2026
 11:08:46 +0000
Date: Mon, 13 Jul 2026 14:08:42 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: david.laight.linux@gmail.com, Kees Cook <kees@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH next] drivers/bus/fsl-mc: Use strscpy() to copy strings
 into arrays
Message-ID: <xwsinrysbg6vqtvj7mbgn7ywtgojkwpozbhkalpyrq6qnmzrhe@losn7mdkeynd>
References: <20260608095500.2567-1-david.laight.linux@gmail.com>
 <dbd95f4c-cef3-4f7f-8619-375fe37c8852@kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbd95f4c-cef3-4f7f-8619-375fe37c8852@kernel.org>
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|PAXPR04MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a9b5560-ccd1-48f9-78b2-08dee0cf1bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	gs59xyxh4+kDxPKfvkE5MdHQYQGNtDQliYNHOv4I4Pc/M6emxfZ5pSRbKOpm8Hv1vCUuSSU3aUrWhPX8HEwLqmpW5DIyIfnk9qlQPo4AFF+GH0QVxDHV5Sq2DTg+KzPBRsw4USMgYtJ7rQU3P97XRqIMIefaRC5Y1BKDRSjWwK/zxayLzBv79YgExWSMLlLOUFNnP8gnjQjMbZhNlo5XUzsOA+AG3BaScSIG84T48kKVs+TBLq3L8rNvqEO3woXJpqVp/1wM9mnPS5DJ+BeC6sKORKPhahgPv6wYAp525LTR94H0HY+xnZKRvBBg5XDT9gArSndfcAcnTvVWKFA2hiBStDsc1yBx1jjwB6m/qvggdKU+2HuWqlbIHTPi57TUMi1vk7i9TCDt/LJao9pU/Fp8RsD2z9YVhEMC5vFsQGHjeXTkv2m2PLYKEiYTOpPPlRSn7vxgdbTJ0NzYlP8OFyfCX5cQ3XYPj4Wj9IMyUsk9o/88MX6YLbuxE3caEq75BFi31gEZiQbtqiMfRK0CaQS/y/Uy+uTipYocWEL3ErbIyPrT/d1ebvHAjBUP5z2dStDW/qzsb8cCWSTIoIjM1bwiH7mmQpEWgO/FQKt11BPZl2qjgFXrwCb1wfXX1R607klbhZFl5X1v0jMhCGvv3E2rK28+Pht+y7DaubPLWu4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?QYV9U/yMbdBOn5PAFoTdijUy2qXhrr65Ck+ibBqk0woQTzbWmkOxPsvnSz?=
 =?iso-8859-1?Q?fXnBZd/PX8fILI6F+3MOfx2dstbw3QoIThB7rf8tetMXE7m2oCIKo0xSJT?=
 =?iso-8859-1?Q?fy9b5CaBO+IDry7uazt6Msu4XDIMc83Ht/yBVsdx8PYC1uWy4Qx9+oM3tX?=
 =?iso-8859-1?Q?17oMe3Y4rqpZfmW2W8fdh8rZQV7SRQb0obVpVG9NrkZn51JXhPxBP7Ph/T?=
 =?iso-8859-1?Q?8okzzkkVMQOHrF9jaNZHk0PDr0UaCS9tplxskUfdBrOQ3c13m/cGkF4ohq?=
 =?iso-8859-1?Q?WnNdTor0DiYT/lzIwsOAsY/6DIYMa5/dqzS9mcgA317oA3Jc2vhT23BDJx?=
 =?iso-8859-1?Q?sVsf0UNz6vM/b2USxcfvQ/zes04IA/T9Sedy7qYqgxeV+uJ+yk43ijmQ5l?=
 =?iso-8859-1?Q?eahHoJP6Eiy3lHjUuCZFkqpsmrMEBxyxW5sqnoEtgBshr2TnbmIyvxu4Bw?=
 =?iso-8859-1?Q?fy9bhnbBR7XoEDOvt1CqAB12ureWfVUeAN0C4Yck4WqugCVxeW5pi8sYUo?=
 =?iso-8859-1?Q?pE4J7XGr9YF+f9t0OxG94nnmcMb/zZ3Jb7QSOJZTWcx5jh5E1kIemKVo47?=
 =?iso-8859-1?Q?NKcmwN+JGRdbUcuFTkiTiaN51dvZd/O8J13mTKo4lqcYvWkkQ1Z1FZq6IZ?=
 =?iso-8859-1?Q?qB5btpKGQIsTFSbRGC53hzdsiL7CSoxf/hEETVncMFYitUHI4MlGEmelcu?=
 =?iso-8859-1?Q?PcVD+STh9GDAhSjfHKPGYjPyv5cKSyt4Aptby7VUbwBwsWlnuDMBAoIiJF?=
 =?iso-8859-1?Q?Q37Qbp1UD7H8FBXw2kXLbMKDEsATwwpV3DZtp2U/4HqtQUpcADsNxiqci/?=
 =?iso-8859-1?Q?QH6SctJCN3xGDac4nB3qpwSGRBPX3oUflHhAsu43a9L42B0rDpA3NhFMdU?=
 =?iso-8859-1?Q?RdFh44ERuJ5VQcaMvDolPane2SAqrpC4e4yuarRQpje2g3UNTrc0LiAfao?=
 =?iso-8859-1?Q?UrKN+HS7m3iQa9n42FSxLNco/GA9wuzVQ5jmuUsvsTsIShsg9zqSarNoIY?=
 =?iso-8859-1?Q?15GQ7wNkNmfVhR5siEoCUbabUun+tunye+SRDK0hVvbp4b7skZvyijkLsd?=
 =?iso-8859-1?Q?9rxgo2kIo2LSIofeNkWGe3LJfFIHfRbdvTXGbUPDY5jUCN/PB1vAoMXrPx?=
 =?iso-8859-1?Q?eOzNegMMwFKzCnxNHaFX2n3oiwtb7ZjqLrSXZhWkUBbb8fZfKGVzNqK1K9?=
 =?iso-8859-1?Q?Y0iOUh8xmHwSi4WxuO6qF0trfgrf0hNRIYeRZZ1xXr+SD75lYXk3BAc6A9?=
 =?iso-8859-1?Q?acJOU4MUENKpqCXuNldnAJGo3vDaSJO7v1FXCaZVsFzESp8D6NAUHnq23l?=
 =?iso-8859-1?Q?z9hf+Bu94AGaPAlwAsKen7hH8SNY4lZVdcSfmtIK3x7xxKq8wConvTsMsO?=
 =?iso-8859-1?Q?lGtMgAk5F8VITfRUtVBKCIA+UQI2ntqERgfXt6qYvEuI8CDpmPGjhqgXcL?=
 =?iso-8859-1?Q?s8F2pSk/cib4XezDdQxus+N3GgjfB3XIYwMN1FpucpNWr4IhpHTQPPVZWx?=
 =?iso-8859-1?Q?wWYzha4WWLUWcr82taTr4wJReLlEalZ3qicTLy4FZIeOy1zuQDaeSQI90Z?=
 =?iso-8859-1?Q?HAlqFXt8xDecszo7maudwtC+auI7unp0ryBNO5+oBpcA/XxmvmxCgfcXTg?=
 =?iso-8859-1?Q?HaGwtLrBJyK8EKqyjMVkLmsBjFReEti+XP+JAqtqWMkVZohRS1E/Gj3o57?=
 =?iso-8859-1?Q?4aO+QkVpMycq7FQj6vaG867xBe/HmdNL/oYiwXPkFC4wZ4qmCklMwQtKOW?=
 =?iso-8859-1?Q?OLXSy0R5vPloAugg8w51s5FrFTOMzSZYpMVcnV1O0cC7TfzS9Lbf7KWPN4?=
 =?iso-8859-1?Q?jpScAEwzMw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9b5560-ccd1-48f9-78b2-08dee0cf1bf7
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:08:46.6869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXf/z5JOUbPLqpPro7u2KUYf+UTffOEpzBOZ+oCbQ3k7L0gSO0sf3A9z4829eQjOsQQOmSVzbta2m6rPu5ECqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9005

On Sat, Jul 04, 2026 at 11:10:18AM +0200, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 08/06/2026 à 11:54, david.laight.linux@gmail.com a écrit :
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > Replacing strcpy() with strscpy() ensures than overflow of the target
> > buffer cannot happen.
> > 
> > Signed-off-by: David Laight <david.laight.linux@gmail.com>
> > ---
> > This is one of a group of patches that remove potentially unbounded
> > strcpy() calls.
> > 
> > They are mostly replaced by strscpy() or, when strlen() has just been
> > called, with memcpy() (usually including the '\0').
> > 
> > Calls with copy string literals into arrays are left unchanged.
> > They are safe and easily detected as such.
> > 
> > The changes were made by getting the compiler to detect the calls and
> > then fixing the code by hand.
> > 
> > Note that all the changes are only compile tested.
> > 
> > Some Makefiles were changed to allow files to contain strcpy().
> > As well as 'difficult to fix' files, this included 'show' functions
> > as they really need to use sysfs_emit() or seq_printf().
> > 
> > All the patches are being sent individually to avoid very long cc lists.
> > Apologies for the terse commit messages and likely unexpected tags.
> > (There are about 100 patches in total.)
> > 
> >   drivers/bus/fsl-mc/fsl-mc-bus.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Do you expect this patch to go via individual trees or will you apply them
> all together in a given tree ?
> 
> Ioana, as usual I can take it via soc/fsl/ with your Ack.

Yes, you can take the patch through soc/fsl.

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

