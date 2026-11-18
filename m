Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E356606A31C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Nov 2026 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CHh5dVJd
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jV0r96G32z2xSl;
	Wed, 18 Nov 2026 23:13:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c202::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795004025;
	cv=pass; b=LzDX6JFxGG9IHKpeM/pvixSjUXqovX/jFUc5mZyLWKSV5O19dp7UHRP26Eey1wX1w79/YTRicV+Bw+enLOz3imDhKJcO/QXmZn2yK4AKNqyCBVqsnhJgTJH0O/Wh6pNsiVvYAHy6EVFDsb32rgPnv2aP1xJ5Z9jbVP3GOUophSRSnqnQoxbQj+PU7FeQWBsfgmJ5gQSkIFdUyAlUFUIofJA305KO5vTjYvOEpXbBhhTue1tc+0PWx5XcmJ6SGTLKEYqMZ7LBKsEsQ5hNZCxazSPottIg5DIYWsU6M2NlldHBrJ0cUhwx4o5LUnvLmdglUOtkVjpKiO/3GBiqpKoeqw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795004025; c=relaxed/relaxed;
	bh=z28/3KkpTvEeBHjUVk8FecLw7uLCCRF/Nu8OQ4Yo4EA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jiM2FeO04XR7apYUmgWiu0VGBxRkSoD61sOX/4HTA5VRke64M4aNs7AiwLffp6OVLcFzLfAerTcurxnJtywnhJa4KNNGpcNubLgqDWF2vcuzq8Rc/IXd/Sg7HQw8i7Nosr7R8qb4Fs3rExC0qy56+J9dtgGY8PMSNLY5laaMxC1atGqKn517E33qvsvh5Q/FqBdebj3RPjpPkYY6MYLvymLN0pGVIuHx45bWMOdnBe27aRxpoNfQxGOrOVrNTrXq72+BDBmVq/mGj4EjdSkJuECIhKKlqICyACidBbvA8q72dNRXm5DuU4nSh9zgspmR/TFOP4DMxSNrR7SdbegO/w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CHh5dVJd; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=CHh5dVJd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c202::7; helo=gvxpr05cu001.outbound.protection.outlook.com; envelope-from=vladimir.oltean@nxp.com; receiver=lists.ozlabs.org)
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c202::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jV0r85xDVz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 23:13:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWbJK0Dyv2SSamtmawP5p1fDaB8sPRy7RSDKgkwdtJ4L8rCAP6SXeQUbjPlAh/svT/K4iGKk831nXyhBJZWQlyT7zLNiB08+2qGJ0vAUBu3iY02qzMiHEhiB674YTJx2zmUHKVi3gwy81SL7RtdSbbBZB/77s4/QdkQGtUd8uOPZohzwf74FL58/9BCNTz+yfuSVhGTSbWxJFj6LwLI/4cjHy0BosVReSpFn7Wgq1TSewNzN9qLteUUuIDiHlkORbVCdNihVskEbM9rl1mmR5I+b+Dkv/S6zoW/xChGCzQB6GzrkSNSu7JyQHuH4XvIo1vfkG15cmVltNxgX4ohlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z28/3KkpTvEeBHjUVk8FecLw7uLCCRF/Nu8OQ4Yo4EA=;
 b=FjSYx9ueLVvDWMxe7oNSiSbSfr/kinoRWf083HDNNopHZd1gjOKibPjq1hPXweas0Mb0tAdKRrl/1GJ98ZpyehObnh71fG94G3rzaeTfKzmtZ/BjYq6T314W0JtyshsPhyfTOpI7FUHnb6qmE9VoKM2FBr+eJ44In4nVwu6mYisreRNjFaMRgX61V+EGpYfM/SVbmmh8l1DplXATLhU4KrqAPfXEWpFw5BruW9xx74S3vLQBBcBuYYa3ZvAKZ0u2M+V3CZYiDqTSIMRrvx/adCqzUUclolcw5xOQISA1HtO9tIFTqKz/heeZmQ14MMMYXrSgFkzOC/1K8PPvTwrsGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z28/3KkpTvEeBHjUVk8FecLw7uLCCRF/Nu8OQ4Yo4EA=;
 b=CHh5dVJdn3XK//YnbdpY8Im1pd5pExHKlFnB7EnCeW6VcoxNoEwfYgP3mq3P6Wa8Gh5Bws5ekvsxhYiJ1n1UJiuB0jRi8Yi+wyF703k8Ky9AOv3Xpok0McmTQ+Nk/XoMLSZWAIIPCXBHQ2NQcy3p8Be1YOq1qIPiXSKlf7x/0Vji6T6s+eVRj3BN6dT7POEBYn5T+fKifwExLW+ATHbo1HL0tN+Zxr8STXfLcyWUfy9QDOdEE4QWjV6u2xFDToCcX10tv9xE8pGhwsxDHOqvyLClGscjiw/miAHY+AtBzfDrTW2Wdu8ApJTHW9aB4Pym8e2Xzi3MmroLEO2Xs1P98A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 12:13:18 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 12:13:18 +0000
Date: Wed, 18 Nov 2026 14:13:13 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: vjardin@free.fr
Cc: Dong Aisheng <aisheng.dong@nxp.com>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP S32 Linux Team <s32@nxp.com>, 
	Linus Walleij <linusw@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v8 6/6] arm64: dts: lx2160a: note that i2c6 and i2c7
 share their pad mux
Message-ID: <av2WS49A11W04Ocf@lxl00025.wbi.nxp.com>
References: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
 <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-0-d01bc837593e@free.fr>
 <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-6-d01bc837593e@free.fr>
 <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-6-d01bc837593e@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-6-d01bc837593e@free.fr>
 <20261118-for-upstream-lx2160a-rcw-pinmux-v1-v8-6-d01bc837593e@free.fr>
X-ClientProxiedBy: AS8PR04CA0088.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::33) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: 5503656e-4bc9-47e9-e650-08df456d545c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|1800799024|7416014|376014|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|10067099003|41080700001|15866825006;
X-Microsoft-Antispam-Message-Info:
	apqIe2vob/lJGnItJ6o9s29D7BQ1SKyLqjxbyD5j/L+EKJLRvwDp9ELGOt5RAm1uoePPAbKZq4Vau29+cQhpk6MlOu6yp2IbutmP0/B0Hgd/WLailBLe/XNHjoivi+MgU6dTcgUPfNEbJ0aFW5TXaPnnBU4sn1ca6P3Jmdb0YVoOvwekLo2rrHLR3R2X+o5hV7M7Y77sofu7tGiwYtTbCre2VRaWOjncs6e743oHvEM0bGAYDgc/O9PNAnYYelp3T9BGSoHfTykPzaRFEvunkGUYcd6CTMooGuCdFoND2T3c62zf9WjOEEqz4JfITnby9CHWdzPKNUfYahdSYf6iDWYooIWeeSpy8bJpOrxi2JJpff58z7oQfeXVZL5EjTM4SRAhEMgDbGdd1RSLwKcgzGEQmNl6yq9fya+EZgkbviMP9ee+UUZT667rKC7L09JKrlsipZNRZjONE9k5cwNgyL/Gh04zFV3hKfiot5JdJCJakIHKgTLuzxHRiV700ZXQFKghCiyeHUklASkmknZwJWQgXZYMlJiKUKZkW2Kl5R6lY1D0P6pk4tOKXf6bECVhfxs9R/MeNnYBL3SUzxK1zVfBZyVqOA+rsG4td4uVZxFEl4gP+5P4PfQqUvwaEndzndifX0s687Aoyyps3zDCk2SBMXk9RbLOQCdGrSyR7LqE3H+ZREy8WjpwtbmQxGQcmkqH8UN6DWU3+iiWPLOnmg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(10067099003)(41080700001)(15866825006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BWIAav1FYSyaVMCVfqgahl1oDtpKqQeBn137WFYU6/LGEOoG05fJA09vN5zZ?=
 =?us-ascii?Q?czV+Ot2bd8X4+IQR7OhQ6xbWP75107dWGOY1V48zAk5bqzPytKIK25w2C2M/?=
 =?us-ascii?Q?NYycNQ8ihEFuc1AfE0Qp9IZw3hTINHd9EQ+jWSQJCh828OUf3p+W7G9z2Xmz?=
 =?us-ascii?Q?s12uIXty/DHGcQe88zN6ZMwsf8b+nM70UX+/j2dJu5y+Vm3z5i+l0wXBnSgp?=
 =?us-ascii?Q?AU9V0PMhgcO3z/uKNjWrgjCN5UKdPnghNqIcp5lL27zfL7yGHJpE7hSQU2hF?=
 =?us-ascii?Q?1l/8wZcB8mMl6s78TR73i06+TIjUFu6efN0doiOYF7IinEFaA45zQMsQpCWj?=
 =?us-ascii?Q?WdZPZvZpgrenCW/imnTM1H8lliX+WEKuX25DGrnp8A25gIJ6jjRXZtIwCnIz?=
 =?us-ascii?Q?I+fL43gpLa580i20h0SIfCk4mRrte78iHCtEFiy0tgv/R8B80BEDSdtY7VQ3?=
 =?us-ascii?Q?nPoUcBaIJyXzayC1xDgz7yTpCVn74HSEGK5l9y0CK89CW+NVGx2srKVWb7WO?=
 =?us-ascii?Q?QtkTH7M2FvH3uToIbl1rOD0eajPvrhmfbGYPeQ753Gf5ClJi9aYZ0TzAc56y?=
 =?us-ascii?Q?tncotx0OQiGhXivO3U50KhcsfHdH00fkEJr6GDkzlnTKZhvnvvAI8amOZY/c?=
 =?us-ascii?Q?7g9pfckXkKnV9P18+IUYf3/8bGivIsY9f126gEGgjkcnsT1oLWnGowNev1Do?=
 =?us-ascii?Q?dAk2teMV3TvsvNyP4XamvTtYzg2lNYwKvCQH9AT/O2r29atIKXZ2U8cZEZuc?=
 =?us-ascii?Q?2pE9FXrYk6WD9ITw8RxpRRG5iIfJdzkjKogE6h77ke4hkjK2+LhjWV0pNln0?=
 =?us-ascii?Q?iFRr4SYpKkoplLzjO70kVapi3AtZMd3sXvFQSWxZgl+NvaKDGosb3GgyZhIZ?=
 =?us-ascii?Q?pioaksRttW+DxsOMBOZP8c59QsePfjVEaqHFk1yK38TeW7bRlhVmJgeufeNv?=
 =?us-ascii?Q?zZxlAApdH/XZPuXADx0HJU4OT0gFuvhD7EmabU7von5cYpomlKzU82WDKqar?=
 =?us-ascii?Q?ivYn2JawkQaCoULk1aY2qI2J6SG/qIZILSulTl8znPTrjTOA51WKVk9s9qcx?=
 =?us-ascii?Q?RVnfvwLhaaqe8C6mF6RpDIQhTkes4Xc2gWKx2EN3rXwJ899HEQHOfw7BK66v?=
 =?us-ascii?Q?WGTE1cMrYkhvIHrRSzfjjrC1OPJny2SzUF7lq9xiBnN1qnYkT+4Q7Nf7DXhf?=
 =?us-ascii?Q?9ges9Ji9Yfy3ozbUlaKVmpVS6JNNMvl41a2hq7j/HR/kuMVrlEp3eLFbDURz?=
 =?us-ascii?Q?8kv8jsA/IAS3075TyOFPGLyl7FMhIxwZGbxuayv33o+nL/+sDKvjtG9MFcAp?=
 =?us-ascii?Q?Mj/Sq/hblDizcV9kJpk4vIG1jpDvnlcP9m81vvRj0UbfIu/vSuJAr6cXuglJ?=
 =?us-ascii?Q?fxFyVrP23aG2QGESFf864wEyBwOl+TjA7ExRufMon3nvsYUFL111KGZkFS2y?=
 =?us-ascii?Q?XtO49QZIxzgMdE6RJOYu3bdGWVVAEdaD96A3u3YzXHxvcZyF3yUp6ewB6XeA?=
 =?us-ascii?Q?09G4NSB9XJK0Fk+SQJvOYRduEXz/ftzKRTtXsCXlbnv5yt0cnswmDzP4LsWN?=
 =?us-ascii?Q?ckGbhDYFRkTSzTfSE8vNUGJ6NZcjRpEKp/UnQ6gpar/7NWX7taHGQMIU4/Hq?=
 =?us-ascii?Q?0Ht9ovpKvr12PRUnif/COJara6spHFBJzojpJcLeLPm0vXEmVsDP9TsDVk2A?=
 =?us-ascii?Q?knd5Dl0udS+oBSDRW3hYItivckb2aXbODl5wya782zsY2Z74dIdDG8fWCmT6?=
 =?us-ascii?Q?+A0NfHDxPQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5503656e-4bc9-47e9-e650-08df456d545c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 12:13:18.1062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKFD3kreGiFlwkv27uHG9H/0IMw6/TVOHL7c6OoWuqWxFbVoQV718Mz0YFOOJLVGmPsgAnbhd5HUYfM/ipvmVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 12:00:20PM +0100, Vincent Jardin via B4 Relay wrote:
> From: Vincent Jardin <vjardin@free.fr>
> 
> IIC7 and IIC8, the i2c6 and i2c7 nodes, exist only on the SDHC2_DAT[7:4]
> pads, and one RCW field, SDHC2_DAT74_PMUX, muxes all four of them:
>  - 0b010 gives both buses
>  - 0b001 gives GPIO2[18:15]
> 
> Both nodes point at the same two pin states of that field. A board that
> enables one of the two buses gets a working bus recovery from them, so
> they stay in the SoC dtsi.
> 
> A board that enables both cannot use them: the pinctrl core gives the
> field to the first controller and the second one fails to probe, and
> the bus recovery of one would switch the pads of the other one to GPIO
> too. Say so above each node.
> 
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Link: https://lore.kernel.org/all/avzGrorxOg2GmYOl@lxl00025.wbi.nxp.com/
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

