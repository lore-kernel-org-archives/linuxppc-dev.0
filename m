Return-Path: <linuxppc-dev+bounces-28031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5628DC98302
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 15:09:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqgNM2cxhz2yqw;
	Thu, 24 Sep 2026 01:09:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790176147;
	cv=pass; b=IoFDnFk5ugIWhyRBK4KSnRSsj2CAq4zobSr30NA61auRjUYlgTQkJl4nfXW+Vl2yDONfq289Ih/2Ov9PLfxQK7BEGKyHGM7wxxMjJehZ6HUYbX5ADGyuBS1eisWMKjxcXsMq/av3eKDqOgOypjeSXzNZZfR3C2PAPz/KK+UAnHqpEbgaKsrtGaFFCGk9FKHobL6qGygxEmdZEJef6rSQ/SRyw5Zj+4lAMYw8/RcHKN2hxEJc2dvPrc1J/WSd/yDxiyN5Z1kt39cdgOEftL0CdOTxtI6Jir+1a+NR/mdeoJ7H44IL/cNmvwVMoRQI35P5NS7EaI/ANg0TEZp50rgIiw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790176147; c=relaxed/relaxed;
	bh=elBhrpslL5Ps9jJgKzLQtJhwo/p61Ei6ZDK29RqE4lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YSwSI2APe9BXGaBQDxOlRKHlEzfuH4FzKaHNmvIM7mpp8K4/3yQnV1S5NvQ8G5fHmgcIhzum5Yl2xQvZQzwApLmsZsoquvWsUzY9HQLH7S/B323AGxcmP76CYOOSDS/Z6+xmaklaeb5bEq3m5mYWXbPqcbeWW0l5ZfYDANnRjHfl6tSN00TRVur9zc1EVRetg975hhU9e0eeygqdLx8r5q6Ch48peKObSEKtBjIS2RqXfkg+GUG1Lh0WEzo63iCtowi2G0zcMTOyM1DjJ5vZ1+28yGcVAIMP4O4BTKao/hdUevDlOKCSvbsYmq8L/52F6dHMX9xk8OBO51wHlwqdKQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=baYoY0tr; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=baYoY0tr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqgNK22DHz2yqq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 01:09:04 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DN8lD8ahpxWtWeIBwlBh30QwbUpEggTIe64Y8Rs51ihEQfY+0ThiTRQWVWEMkdwrj2oNf2p/nFSTBybHHtZMpmyqlhq8Yyd0CxTwsACdWBegrTHbrPu0tk5QqK0y5IZvdblyxaba416tPnjCEtxOhHzj795kZlZe6L7B+LuxDkjjEOYAYacRVBpXwsrHUX3P2Wey1LMWUY/uU61RAvoDFS7Xxe4hJe+rgqEyqBV2efI0hPbvx/eko507G9F95cGqqXxay+nBV+Ll8f7kRC1B1/LS+YVWUBKuUi9XsnFdjvxvntJNzwKqgDr4Abmpdn77Yl1bUSinM6eWQTV2LjuWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elBhrpslL5Ps9jJgKzLQtJhwo/p61Ei6ZDK29RqE4lc=;
 b=W28bJSOwFAnY54H2BX0GpPHWY9RVmU2rhLe7yTxCE78ocSxB3I6WDXSWisRQK4tE54fHsNPUlvCR2TqX3woq35qv+KfKzfuswQKKKODYv2KK4Kv6m/TmqRbv0asLD8ZqRUM5KCuV1YygpOgvwHrvjTuPUoduk604vrekb73oFtX0Co9uV7KAcgyKqe0ySBq3cINK3KUZd+33xEuzF0W8l1c6N/+pEIh+XcFsH/Tc83z2BWXwjvbJPKllCL8Gs7z3qQFpXkB7jGHyCQdLHHNq7PY2xnQQ0RGBWxEjXxzUwp+wxZqMlLV2S50Y++3GYopxC6qlnJvFZaN+GeR/Es8vOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elBhrpslL5Ps9jJgKzLQtJhwo/p61Ei6ZDK29RqE4lc=;
 b=baYoY0trKRg9sdyMdlTReLEJWHydzUG1Tfpq4slPOlyMJzjryC/uch6bMltrUEsF+9G42ecjWH3m9RO40OfYrcxy3vYEeQmEZZB3A4WtkGnOqFQ0NEEbye7KXndaIrIWdHCE+h3HWrBagI/DyJEgHkK/V6Wt33UPaUOslOISwJf/33+ainWHCFfocRmEBuc3mNA2lac/ehylRbFy8uY6ETAyI084ppv7fp7OBnB0UJV81ft4VHdyC6n18O+w2j1EYlDx96CI34guhZ0N3RzII19CQvr00nSrUucQnJnaJQeFn+6VDil3MR1t32g2rBsj3ajuheAClTiPVo00Kfm2BA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by MI3PR04MB12657.eurprd04.prod.outlook.com (2603:10a6:290:81::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Wed, 23 Sep
 2026 15:08:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 15:08:39 +0000
Date: Wed, 23 Sep 2026 10:08:27 -0500
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
Subject: Re: [RESEND PATCH v5 1/5] ASoC: dt-bindings: fsl,imx-asrc: update
 port binding to support multiple paths
Message-ID: <arPra2x4OcFbTKq2@SMW015318>
References: <20260922033428.1690822-1-shengjiu.wang@oss.nxp.com>
 <20260922033428.1690822-2-shengjiu.wang@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922033428.1690822-2-shengjiu.wang@oss.nxp.com>
X-ClientProxiedBy: PH7P223CA0008.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::6) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|MI3PR04MB12657:EE_
X-MS-Office365-Filtering-Correlation-Id: eea24b70-cd5c-4e09-6c8d-08df19848bfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|19092799006|7416014|376014|10067099003|56012099006|3023799007|4143699003|6133799003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	EO8tI73wRtmFbEJz1I55JFvuC/oFv906lSCEGPoMEB27BJPYqT7gLZVeewfutSdCtgW8aNbxSTxgLTyf4E+lGs7Uz7UQELmG/rc/9QoF9RHiNq/ti/tyc3aAJlVKRxG33a7M6ddDyYclFxMq6naOHm67uXn+Gh8NsGo0Z6+MWmXHITfRX/Elt6r0tvG7AVJmHD+4SPqhldgDVdxN1BZnuG+nXUdndvyDRJxUX9eefCh2OP5n8QULmQTF6AcL/7zyAuqhTTkxZC6OFO/Md73uOVwmF3aht+n81/afKwMflohHrCg9xqYMsZtEcPM8k0kSkf3mq4BFyYcNc0GFltdkUzHl/LqW2dan7qcwRLgOwmrBa0EP124ETBvs9nYkIZJTmn14xsKikvqcmIE/lw859Z06ByWqLMzc2FfyFE0sKIjpF/AjOUyHnMyUyBTCa5HCFbdLO6ui9+c1j+iq1YlzWfl5A0VbWs5aBalkWjoIg4gR8OE9RELQW2c+ciG6RbHcQTFgp9lcApZwo04/BBdeECP/ChyrQgoRemJMm2nAE5oAo3ZOYhDu7RvCRE4JZOF9lnf9SB2y4qJcNNeYbwPBS/f9i4HhnbvXXHHLGLBPgxBdoFFhLlj5Dwm3awUqI3x6L9vF1J3YIrqn9wYeGP8abvSXC8b8Tm9pyDj5HtwFNdA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(19092799006)(7416014)(376014)(10067099003)(56012099006)(3023799007)(4143699003)(6133799003)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57w5/ZPCn49+NPV2/gzE+e3jXMtk+nVTXS3ZCuA6ZdYzZQGO3pB6JlmKYJJi?=
 =?us-ascii?Q?ZYG5wontZqcb3v5yGmCnV9m0+uvQrXx2K9s0uJ0l7LtYp+2J+F7j1qVBg6tG?=
 =?us-ascii?Q?ScOtU/ZczxNCDWJ6pr8InD216jd/XwG8dDHQVcNWcKSYiFuDyX7dBobOqPF4?=
 =?us-ascii?Q?nuGKq+30fauD+mYo84tmz9ohxfNclh8FcXfdqRp93FJGHDP3cJ0E+jK54gQY?=
 =?us-ascii?Q?+oIHBhxUJ/qMAlIsKqzYak+If0zNe/UKfZgwbHaXa07GE6McpqSl49jMED6q?=
 =?us-ascii?Q?Rn3cLXMlXyBg5owsjejztLsXn/159CLUIeQXbVpQle2/6njw5vsLdJ3H0sFV?=
 =?us-ascii?Q?FDdWA1ma2Ildh0CJXGvrdgPEbeNQq6Qk9ljdrJeQbP/g7VugwMMEOxRj6pz5?=
 =?us-ascii?Q?8/dOkiIy18ECmc7RBHbKyme3gYkqwHKZtu60XCnqMx8fU3K5ewhKhx5lDAjG?=
 =?us-ascii?Q?bhGfPJZg1p8SZPsDlFLMCpL3JHhXOlivUkIQ8h+wfiai0n9T1uwwGUTH1O+8?=
 =?us-ascii?Q?/+nmvXgvTgP0u7m80G9oSqxin+jAOxbndaqg3zn/97n8w8VajB3RqReXsVOv?=
 =?us-ascii?Q?KxCh1fbU8m7x7ZvToXVqRYMDYojeA5oIrirU0CSChC1rU9xBKr2OgSaRkXE5?=
 =?us-ascii?Q?HkJyJUtVz17t/3YRwP38OKhpTe0rJihmOATJTnHl3VnbUQ47zqCuyoaWRFiI?=
 =?us-ascii?Q?gSEhZv2tbYLEb9Qo9xn+zTNQnPKhSPiZaIDLSPK/xB3CJQI5nd5KJNm+0g2n?=
 =?us-ascii?Q?D9ZzuG2D6FiQff+eyb9dOeyr+S/meqU0w0TIadnAwv/prpSinoE5HfEabbCn?=
 =?us-ascii?Q?1/6CqXhX13P5a0jq5U0O6pBEo/IzTSiPQAfC6BRyL4SUbli4E+wLHUZxMbd9?=
 =?us-ascii?Q?1AVMrBeqSMNc22q8dbsAgTWPY8OqyoJByq8TD3O6s730VP6X1XUeyYGICzc5?=
 =?us-ascii?Q?xyqCwAaZwy1rQJI9/ks+61IR7FXh9yVchfTEoPaG0zcacxBx77VEfiwPxWu8?=
 =?us-ascii?Q?pTiOs3acgtTFyZ+n+/l5Sc12vXF3eXngnhBA79JrkpTwP+StmOp0AR+d5BZX?=
 =?us-ascii?Q?14ZMhYC9WfXQnHSdkg1uwovz7TVDIV9/IS/7sd06yOQoL4iDx91e/pdjrb/n?=
 =?us-ascii?Q?+otB/9jinHJgUTE5Nr5xTvzS+mRdbYPrbovinrroPOMiQLMpRIv5JVm6QgaK?=
 =?us-ascii?Q?2UFCUva4YV5sPcbS5uErh9lhimUKfFAOUNM9hJV4ZyT/vk1iUjhHydJa30Gd?=
 =?us-ascii?Q?Uyaj397wGjLtOmS/3ha5f6uOKzmc/oTko5D+UGBfjKkARk7QbDf7RxONidub?=
 =?us-ascii?Q?hz8weFJc6ux7lhQqDDFv78cnyXemt7kP3gtM/B201wGwS6xFzme8m8uljfSM?=
 =?us-ascii?Q?vhheojhjH6WLYIVL3I8r7Etd2D/NGD/obrZ0GRHhbAGCRVCL4gtkY3Lgn6My?=
 =?us-ascii?Q?lHLjpX4iSY9nPYX6jW08IhDCdXCSakWqPFbZR3D2dIdd36aqg78N2G348xx9?=
 =?us-ascii?Q?NwbzC10+VwW2It2m9BCCy3Ie0mwk08bSIuiDCElSSsVIrmDQoaEx9lylLcIF?=
 =?us-ascii?Q?PU1iTpTmMTqfEX7lZ9wFUNGUK5K3dY0pa7i9goAfUA0jlrHL4bCXD36AaoYE?=
 =?us-ascii?Q?QIZYo8qtVc4U3eDqpJ2o/qdn76bEbBKJ0QMoBOpJwbb3DC2A4JZ/x/VETBhR?=
 =?us-ascii?Q?dG9qeCRZA3ti6+KIh5V35uVtpy7E+mlJKixaeQyexKMLFbzhxO2tDuyoSBZP?=
 =?us-ascii?Q?JkghVrezFiBXbT7xHVD8Kaj8413CwZQhtYBUVOJ+NBh6Y4Ve+2oa?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea24b70-cd5c-4e09-6c8d-08df19848bfe
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:08:38.8966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MDqy4awaI15i/agsQAFeY5R6qxHgxo4zm4H0Y/iHO4Mq8Mgql4dGTWwaSFEGLeOtE45xuIzbSdVdqPM3tyn1U5kWzp8VG36+WRngiohwTrH7LApolhEpxWFK2Nk9/Qul
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR04MB12657

On Tue, Sep 22, 2026 at 11:34:24AM +0800, shengjiu.wang@oss.nxp.com wrote:
> From: Shengjiu Wang <shengjiu.wang@nxp.com>
>
> All i.MX ASRC variants (imx35 through imx952) support up to three
> conversion pairs (A, B, C). The existing binding exposed only a single
> generic audio-graph port, which cannot represent independent conversion
> paths when multiple pairs are in use simultaneously.
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
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  .../bindings/sound/fsl,imx-asrc.yaml          | 43 +++++++++++++++++--
>  1 file changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> index cd69bad107c7..67d2826eef3f 100644
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
>          };
>      };
> --
> 2.34.1
>
>

