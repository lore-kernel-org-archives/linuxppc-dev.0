Return-Path: <linuxppc-dev+bounces-25380-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35AB0C5518F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Aug 2026 14:39:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDx5c1S1Gz2yH5;
	Wed, 05 Aug 2026 00:39:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785854388;
	cv=pass; b=T6tAOsCKCf8wE9gJ3DV1qZD48ymRyqceiPWoQWPawhW6uWwj0JZ0uJqIeZlXAarafWAvV6RLmHhojiCKyYAkybMhSzl3Dq76xEe0Te/fGnINb9r3YcQP64B+fVJWO9Ie5VIRorSWG4YlQWNil0MohqlZ+fZanFoP1Bd5i+id3OhRU8DFPE9XI4m8jU+bFl+mnh+Wxwm13WcFpIwC9etjiJBKDTt/EcU62SwfwzDRfpOd7sSkrwHTeCkVsFy1OxZYGHwMDEPIU6Z6GGDSGNlWNG0sap/xVR2bIRckHEAaKrAW7EQyFxSWA8spuUYXo89K47+pzNMImJjU/htplOw5CQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785854388; c=relaxed/relaxed;
	bh=cESI95mvePvxrGSEPKfFi7vea/hMGW0SduSBTzWn2qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fq0eRs6F56MtYaNr/PWVI6n3w32yKWkwSyqLuv+rGnlRtAPe3HvetfbAzO/I9hPmyT2t3UzN+85bGvP7ShlWJX42I60It6xzprQBlo1oNj3HJETcxjnAK8xwaNNPeIxG99p/u3mcTIjJAwyDeOTZ8xG84CCgjMdrx0gpIVXoRfoUrsyOdzbXviXJM995yYvNSRqnz3qm1dkO/WUppEXrpyrcyzUba3dGYGePqX0DxPbDOyLkg4wLY39OrfSj7bJcVeeTfc5clb/cTxj7slSOILon/wkCkJGyQDEZqcWVN7qnlc3Gbu98t7QdKkHbwFPqiEVpOcgqskSuA830GQ6+iw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PnsABwm/; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=PnsABwm/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDx5Z5JMMz2xyk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2026 00:39:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mUz/ecYynRkfienF22vwIrpCvY89WnzOxgNi4mL6ykfv1cK+6GHI88dkowbyWNu+E724Hb52ACTqJ+UehcdlEcGH7wkxhBq2lvmJKV730WYdmzc8QIpBIsTPs5BncBQ3TCi0SPULFZW95JgXRkdi5ZbGBJJcP+R+40Zg+JDKb/XPso7PO7fyPOtc1+7tbrB0SYfe9NkCPuRBwisq/dvOqHuSL5KMB/W1FpNo7wtl1+v26uom6VRLFnj/IuyeMfBEn5ovWvVPXt0KZrCeNxh3B2cHG/SDA9LxCAybP9Y0seaKfR3FaOyFy0mVLMvM+H6YPahyOizyJX3wk08hzR2xIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cESI95mvePvxrGSEPKfFi7vea/hMGW0SduSBTzWn2qI=;
 b=i1wRWzZ9A5vAI4icJocCDvujJSlQQFeRx67EdtkUksdbz8ON5bhwKPqtrBhfP9ox1jAwUHccBg1mDxXsKgtEbUblfN4HJBKxadjkwGAkdVUwX5bQrZL7NE5lQnE81vMOM9Xr39NggpBwdT5/g6v4NZKA4kUKx4Cy2UrK8HSsmM/chmd6xJtlOEETF+buPCvErFVtBs5TGpJyps2gwjhA7DF5W6ivqJwnPgUtRtjDGh1W+Fv1pXLeh4gV14kDnPlgc+QLQe9WoXCl9pJJq+9yoLtOQ06xUmUXiNZWg0QXLfPuVG2OWPbBTFEnipV/YlXsH84Wuyh1K0jQNH2C7lXHWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cESI95mvePvxrGSEPKfFi7vea/hMGW0SduSBTzWn2qI=;
 b=PnsABwm/nd4dpiyzgz65reLlhwiBiIv94841X/ajAYMT884p3OJ+ZPsMxj9ReN058ISMj4ua5oWtIFuGU0UlketN+EU+oSZ+OgPDFyS9xEDiyR4VaN1C+VYiOaSb4iQl8AsDDnrpC38FFMr+gon9KlhxpQ19DFaZSe6L6x3dN8WjryjylGwbV2XYGyveCKc7VR6zniLjW/0Xyx1nOBv7XqpYfQJN/wr8Q/HADjCUsiS0y5RHxFSc8G7jpCNnorCgItlF5TDOfcsY3qOdk5pxwObMm0sxSJ5ETkihG/RzCLFKSX5kpy30hXg05LipIpMDHmRCpzYz2Ma80+8830k/wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10920.eurprd04.prod.outlook.com (2603:10a6:150:208::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 14:39:19 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 14:39:19 +0000
Date: Tue, 4 Aug 2026 09:39:07 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: shengjiu.wang@oss.nxp.com
Cc: lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	shawnguo@kernel.org, linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <anH5i7y3JkB1moee@SMW015318>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: PH8PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10920:EE_
X-MS-Office365-Filtering-Correlation-Id: 773bbcf0-35e1-4931-b47a-08def2362aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|23010399003|18002099003|22082099003|3023799007|6133799003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VMZbXrlzgkmH968TEjq6Ik7gvfcPHv8ye7z4D8O9HFwfKdruKgcAdMV20AJsRoMmPrXwTQ8xVEkZym6ALiad+3EReQD+/mR8nIU8OhPo0jeBSAMbSdx0pcqJO3xKbBUevGcg1oKxMj1wM6jkmw07FTgiYZJTOMNT8OaQsWQzG/9314jyfl0IF+bjUNaxogPcyCe3SycjqyziLwpILVljBrZbKCUlFkgeoQyyt+60CcW+1bXCEw4ebyFHILNQf60lpT/35iRcDpSZ+yXfK2FbQeWp4nuvinser0rZ0Px6cWryenXaIwFQKoBF+Ra3v3s6Euv9ix1dgzAyDYUp6CT96N7az7N4etJPh2XZCcI7SVlTfvNFek8wzxOgtOKiALQdxCf5Sd1p8Psx9rh17XOlYEjFd72w43DaFh4qkwmnj7/TUwhZYPwpQanvEWGZZrvTYULEjKw7fgANVYfVp42B+6auzwfbZ2mlCD4GevDxQGakd/oPuBYRaVfomhMdtx3cbkG/xflcmlsHtdsaJx1SJL9ToiUojvPHNZlKu6fmC4YiAH8P/F+1HrbsR27QrtORYoZzFGhxNAWrNlpROJW/HNUEtYIuKnXGU2yiCWlRXbJkmQQSNuT8XyACA6G30KGPbpJ2mUT0JsLU+M3evVTgThvZaSkWR2nQ3A7FUvGJx2Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(23010399003)(18002099003)(22082099003)(3023799007)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4h70BE7z3qWVz+P2kBaoyLgP0s3tqhdrtcM+O86ayv6KKVtT9Lj9emmJAygs?=
 =?us-ascii?Q?iywT1/tXhUVnxTQdEirBjroPH7ujRoB1vr6DzPwXiH/UiTFGE0myTEfIpLib?=
 =?us-ascii?Q?SzX+AmS/bGJ8udoiFGyf46bVGlkazWZ7KFoYLH35DOG207fwrTNoj8iTmhSU?=
 =?us-ascii?Q?8LB81fERvpHIiHlT1GdePMmIxcx/DwAb6067ZlDocQ/BYnOOfQBd5SDJWbAE?=
 =?us-ascii?Q?JUejRQiQ7GfYekQez80diGRaH0MJlToF+z2lUesgnwSvtlR9RE5yE6B0zo6y?=
 =?us-ascii?Q?Z2oNm2uEgXoa9k9XsuwxloZBTTl2vOQ3fwsQC7rmvEeDrB0NM1I5Wk4UzCRU?=
 =?us-ascii?Q?FtetttCKt+0dWQvJNaTNqQooLvlbfoUDwyOGnR91DE5AUH4XlojKPTf+3jqp?=
 =?us-ascii?Q?QP4WjYbzW4Hn3HDfHxANSBR1wGuPh+qcPWnLYxiht3c0xlU0tMPmc+61nJAQ?=
 =?us-ascii?Q?47tj36NMlzPytvesaM954ef2AvewBU4B4PCkwGCig6oTP23dgyckuVDl33yU?=
 =?us-ascii?Q?meK1MXImtuVfhKk5aoKRKUyhe+DeZ6n6pnX16iRIUzRY7KBvmyUW8IgIXJVN?=
 =?us-ascii?Q?oHasq7Ke2VdCYasTEmexgJ2V4uzdCLhMWCGekSYx6TOVSSUQHvsq/ApJ2ad+?=
 =?us-ascii?Q?zEAuVvLOkkTTZm0borvpMCtPTK8HKle8eRNNWzEwJ+Iy1K8+iIYAY/MYzEfi?=
 =?us-ascii?Q?tWkEmKd4C6i7z4tV8MT3OMx/mPbjqisC7m/HoImFpSpWv1iaqxMy8dMWcgDJ?=
 =?us-ascii?Q?0RPWv7WDdSAdcxTPbch3d4N7eWGfw8ex2me0AqS6+Z0nUEUh4IE1LvjjC5a6?=
 =?us-ascii?Q?ZHfigb2C4huxGdUlLd2R+lCygi3nieW/psThDatEpZH3zfQxuivIAFn2OO1e?=
 =?us-ascii?Q?arQQnDhD9LJ7+JB97tKl9SCCtBfG9SyavVDLOoyL0Aj230S83wzkdge1cDwp?=
 =?us-ascii?Q?Cl4RkpupNqC4IeZ6lgugl+n/xDeeznB394v8qZIGEo8r56WmrBb9uJmOJXhl?=
 =?us-ascii?Q?kxunst3ka9tY9uv+ha4eZIjLASNXHFeeUJI/iAEyCBXZGBXoLa+W7W0AgNh5?=
 =?us-ascii?Q?Yhh5tuzik/MIVIMZRlxBgF5VUs+h5i1Vwd+uxXVmkazEQCjCqLnJPYXbo7t3?=
 =?us-ascii?Q?rWUMyUMIEQ58fw7mEzr6QTMPjLye7u9Jqk4b/1X/rCt7Fus5ANRgn/+Meh0d?=
 =?us-ascii?Q?EN7SHykQ0m+ZNji1VP1dVRrH1yeZDVmqEXA3RuQzfrEvGsogwycgt5kcp7a3?=
 =?us-ascii?Q?a+cQ/RDBCP9VgIO41SaFEggZJJb5OfiTyCYP+RJVdmIVMqTbSnr0m6cQKOxM?=
 =?us-ascii?Q?t8UBC+CBnpuL9jgFW47HMiudTk5KftcaYYfDvrTFq1Q4ItZz52nPoQee4sIK?=
 =?us-ascii?Q?fOTKGDRBGaNuk0OQ/D2DuewaALAoBa3thi+zerLav4eytmsiTPDc93ytKSD3?=
 =?us-ascii?Q?FCckHYz6+1gxmCGNaMxRy82r3yWfo1Jj15sbqsZVXVKUHGp4FxeLHjigsZTZ?=
 =?us-ascii?Q?bh/nBsDmOxtPhO3hVZZHd5u7F+tFkKxmbgXJOLkjAcHY4Hxe4qXMrZymNFMZ?=
 =?us-ascii?Q?mR6czZMwuF9Vj71hIisWJNsibjr+FkF0kDYhTHxEqOochWfYCXFX/SS7pK7R?=
 =?us-ascii?Q?PkGKYUdOJBykS9BNjDoGnROVg8uAmgk4nJm4FcDHRYmf3f6iSwFC2s4qGyQk?=
 =?us-ascii?Q?qirSeaE9xZahuQuRpuGLpiS7/8oyTjE6FbSfdYJULC5rtFmOusA+h5RtCBxO?=
 =?us-ascii?Q?vH5Uvxp5Hy/EkXbqkXwP1rRd4JRYfMuc0hkIRFDvCavcsOql0696?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 773bbcf0-35e1-4931-b47a-08def2362aa4
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 14:39:19.4136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t+Mw6A5QPwshinu1AgGuOgHyu71FsDSHcn7K6UmLng003PhRV9ZWujLBsSJpJlfuJSpcJYqI4jCiw1bwsDPD9z8odnyvZVOOYppmOd38T2uzAIAqXy7F4lQNKwzeb35z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10920

On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> The existing binding exposed only a single generic audio-graph port,
> which cannot represent independent conversion paths when multiple pairs
> are in use simultaneously.
>
> Add a ports container that enumerates up to three sub-ports, each
> representing an independent conversion path:
>   port@0 -- conversion path 0
>   port@1 -- conversion path 1
>   port@2 -- conversion path 2
>
> Each sub-port references audio-graph-port.yaml as before. Hardware pairs
> are allocated dynamically at stream open time; each active stream
> direction (playback or capture) on a port consumes one hardware pair.
>
> For backwards compatibility, keep the old single port property but mark
> it deprecated. A schema constraint (not: required: [port, ports]) ensures
> that both forms cannot be used at the same time. The binding example is
> updated to show the preferred ports form.
>
> No existing upstream DTS file for fsl,imx-asrc uses the previously
> documented single 'port' node, so this change does not break any
> in-tree device tree.

if no existing upstream DTS file use it, you can direct replace with ports

Frank

>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/fsl,imx-asrc.yaml          | 45 ++++++++++++++++---
>  1 file changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> index 608defc93c1e..67d2826eef3f 100644
> --- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> @@ -78,9 +78,19 @@ properties:
>    power-domains:
>      maxItems: 1
>
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    patternProperties:
> +      "^port@[0-2]$":
> +        $ref: audio-graph-port.yaml#
> +        unevaluatedProperties: false
> +        description: port for an independent conversion path
> +
>    port:
>      $ref: audio-graph-port.yaml#
>      unevaluatedProperties: false
> +    deprecated: true
> +    description: deprecated, use ports instead
>
>    fsl,asrc-rate:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -125,6 +135,10 @@ required:
>    - fsl,asrc-width
>
>  allOf:
> +  - not:
> +      required:
> +        - port
> +        - ports
>    - $ref: dai-common.yaml#
>    - if:
>        properties:
> @@ -180,11 +194,32 @@ examples:
>          fsl,asrc-rate = <48000>;
>          fsl,asrc-width = <16>;
>
> -        port {
> -            playback-only;
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                reg = <0>;
> +                playback-only;
> +                endpoint {
> +                    remote-endpoint = <&fe00_ep>;
> +                };
> +            };
> +
> +            port@1 {
> +                reg = <1>;
> +                capture-only;
> +                endpoint {
> +                    remote-endpoint = <&fe01_ep>;
> +                };
> +            };
>
> -            asrc_endpoint: endpoint {
> -                remote-endpoint = <&fe00_ep>;
> +            port@2 {
> +                reg = <2>;
> +                capture-only;
> +                endpoint {
> +                    remote-endpoint = <&fe02_ep>;
> +                };
>              };
> -       };
> +        };
>      };
> --
> 2.34.1
>
>

