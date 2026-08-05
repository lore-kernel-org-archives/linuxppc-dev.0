Return-Path: <linuxppc-dev+bounces-25448-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC08BC55174
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Aug 2026 17:06:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hFcJm02Rcz2ygL;
	Thu, 06 Aug 2026 03:06:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785949607;
	cv=pass; b=jRLdisdEsqJQmCZxCHO3CGbcNCEgToIjL9abW5RZ8R5qkPgca4EsWJeBz4o2fJkmPxaEB8qpY1X99lEVdUkaQs13r4wK711O1EVMLnlO9naGGuUlOOKUrP3AryCODNjm+V6l3RzGMmgXM0N9lkURL3/ls1c0PIfLm+hUM24dTLNgHYvaMFeSO7BakoVEIycTlYyj7i5i2wT6pqJoUp4XV6400+c9UDCQgoQb3yB3g8M8tA1OyRQd1slEe9UNAOmi+HwHd/LQdjkE9z+qlxHFcAq1k5xDD14Tg4hZXtjJnThQLWhr10rBWcWtF4MKfCqqzcQTL/SYW3zfB8UecqBEIw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785949607; c=relaxed/relaxed;
	bh=ywyXEIwWxG+qAZwRuspdGRjEEFimti+ky1oQFF9/aW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oDOCi5ERa/waHrqooM4/mgWKToe9Iqg7KIJimGgIvFopg6hhfDDhmhqmyF28Sn/Fh51+oEeHMmzFD3Z40mNpnZwI5wXWLM24ikwihCYJ07cUfl8OTFqdFrfhAteMy9chfInvKDrbaX7d1ehJr0CcHBE58q6siVDpFaIH0NFnoFhMiuhkEEnfqbhsw+/qPSdAH3QsGJTMGFGbrQo9SCe+X6J8WG+pKiKF8Z2dXpM8t8ikcKrzsSHG6+1+Ts0vMhgPAi3OZ/6z7dGqDhRsVDdOMbQ0UytUR8CXmNrHy7e9CG+2bZPtKM8A2PHSkFeSi6cNxBi2qDVCf+xRRo5yC2vSog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RdSseoVe; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=RdSseoVe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c201::3; helo=as8pr04cu009.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hFcJk3kxqz2yLY
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Aug 2026 03:06:46 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GldxGlMkEDM/6Xh/5dZxJAGgn4EKcwFbDQ/q5kbHWOAQ9YjFlNN5XMGqQblATszsFpfXOwKiOedS6BDmtYr7lRW5DufIyUB3ceKAENmUjxFP7a9wD5r8LxVZkZqV41wwa4lryK5C4H6eBbPUmtWHuxFErOO0+7eJMx9Js/bHtvRJYZH377hOz0s+vlIBZ9EPZ6UeiuGu135IJh50Cl4vrVDmCcEdcqK2+bf3Dg4NXgyeVj1+Zc37QeVjAIplbruL/GXHHd289cAbDY+nBilRFMtWuUvFuDPsK+QiDx9Vkj8nYW0PeTwvl522c65SF8gDMPkdj0PRFArH+TvGvdeTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywyXEIwWxG+qAZwRuspdGRjEEFimti+ky1oQFF9/aW4=;
 b=B618j5kOxVuQK5wTOxy89iped5aUWytsxtRwtz5BTJRKrs0EBW8z0t7R+7pzaICz0yrQDhATDpVtbnZzD9zMHHNEVMWAaP3Kyr2PodrzmCcO1nnn/rIQrxWM5Aqt7XBZRmGY/VTSoM04N/H/OEU4xE5Hlq2rkdwxb4viuiADRbIp3ULFzphMZ+Rc37ZOkt+XNSfnVoAMjWlA2oJULR1/qdY+pkN9vclw78o7TCF8Sl/ohzGqYD2DQg6fjr4O9iwPgBODsDAkyHjLx2NtP18FmPG3lnie4AQfc+ulybVtqW/u5zOQNWD6+Eu4df4NI+RtMiK+W7S0rp9DDzRG/kychw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywyXEIwWxG+qAZwRuspdGRjEEFimti+ky1oQFF9/aW4=;
 b=RdSseoVekO3CNA6vBXDt1u0EPDwjUEgt/LgzMCZkn+C4H2vPvWzg2VTQO9BvSQka8P/Zuqgmii0COGBRR3U8hzStjIqizD9zf1mTMHnTBHEgw0GXj2pKI9fMtLM+vFXwl/MYsS8ZINzD5OK7a4BtQ/cfsCosmvD3kNKlptEhSDNizeX4HWw6TPvGfPBNWaQTl4j7o9AMjeR0KuZZo5mP7QCiLOrbGDgWUsYNopY5HcRZhBfDrj+3adEPv2rrFfVe1dPRtqS2XULouEYDli1z5M2hjPjwn+ABv4jPG1Zv+VoxLbkbhg9Anu85P5+KuPF0LsEaUVqC4mrNTAydoIQUqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10442.eurprd04.prod.outlook.com (2603:10a6:102:44a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 17:06:21 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0292.018; Wed, 5 Aug 2026
 17:06:21 +0000
Date: Wed, 5 Aug 2026 12:06:10 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>
Cc: shengjiu.wang@oss.nxp.com, lgirdwood@gmail.com, broonie@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	Frank.Li@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, shawnguo@kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Xiubo.Lee@gmail.com,
	nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
	linuxppc-dev@lists.ozlabs.org,
	Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v3 1/5] ASoC: dt-bindings: fsl,imx-asrc: update port
 binding to support multiple paths
Message-ID: <anNtgkZYhoWsSRr6@SMW015318>
References: <20260804100218.49587-1-shengjiu.wang@oss.nxp.com>
 <20260804100218.49587-2-shengjiu.wang@oss.nxp.com>
 <anH5i7y3JkB1moee@SMW015318>
 <CAA+D8ANCoc5qOUvTQPRNkvrfqAY3n6x_fbfUveP8Sfv+SL1NVw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA+D8ANCoc5qOUvTQPRNkvrfqAY3n6x_fbfUveP8Sfv+SL1NVw@mail.gmail.com>
X-ClientProxiedBy: PH7PR17CA0015.namprd17.prod.outlook.com
 (2603:10b6:510:324::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10442:EE_
X-MS-Office365-Filtering-Correlation-Id: f4e3eaf5-a267-4bb6-224e-08def313df63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	WQeKr76JRykxd6Qqf+SvZur07Oo7DBtYrgczBd/WJBrZBVQEJG8LllW16LJdsPNEQe3/Oin/Z97Jct6TWwcl+f9sGkdWvCUS1ImHBdZ4cS9zD9//qynUC/wK3WFHzYCuHZsfPD/ns5aOW54k8euzB4yvFYG+pD+5jgloPPgF1DvMdob2oRd4wolX8xXpV9ebk+nJfyPOHn5QR8p0kr23dJzOdN+vyo6pVBOIg7l1It6dxba+wjs4BJDzyaVjyYeG8jUrZRamevtcSN5lpx9mztcP78jUltUlHPAO2IAU9JYHdMOhiqM95jVPeahgcH/TFp64OHsEM7ffSB0j4UwI3NyXGaUarFhNFHpiEZYt2FH4dsiydz2Cx1NoOelT5YZxe6w6dFhK/zhQiLfLncC0BsynIjtPf2tibmwUKI8FQLid5anijQz8MNR2OsZMVlqx/0BsV36hFmraLlosujxeiZ95ITe+ccZ760L5Mv+KRK7+jah6edOD2XK9/Qy7/44SyVIXtIvt5CWa51X+Ymv3Qsi8M4/bdqMFZzoM6QecE4SxG5THc7N9vdMNpVfHaTvJ2YrOFsmy6H4rIZXP4ecqinbcwhRKch6uqNSZVufUBH+X3/s4bKzD6mQYqPSJjSNGcXnOq54JQrdX7uFNaF5cneAoXmVH64+OoM7riraXS24=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0JDcHZ5S1gvbnBQS2t0aXJkaTQrRzAxS2sxT2hTOUQ3OWRINzZpSTZ4Wno0?=
 =?utf-8?B?SlNoSnhkQ0xtZ0tUQmZwMTN0ZkVzYkVkUTRWQmVTNTV6L3BOYzV5djRVaW5r?=
 =?utf-8?B?b0tQajdnRHlOczBsejJrc0Z0NERDUmpjNXNHU3ltUzlFSjJQOXFaMEY3dFRo?=
 =?utf-8?B?S2hCNmhQdHprdDYwcXRHa2tDR1M4VURxTTFJVmZCMjlUZWEzU3k3MWJVSzZL?=
 =?utf-8?B?M2xtODRXdkc2VndGdHRUSjg2WVZkYUhMMkRNcCs0bFVXb05ZUWR6M2hRQnls?=
 =?utf-8?B?cnRiRk93N2lzTkNkWHhpc1ZUOXFxZWMrblJBWUZaK3lvRVMxZXJTRnZqNGlR?=
 =?utf-8?B?ZWQ0bWNqbDBqWTkyY1EwWGVjY0hsVEpHRnd5NHh3dVc3VGd3N3NIOFZhTHJp?=
 =?utf-8?B?b1VIUHk1VmEvTExONkZkODNiem41WHMzUHFaN05JY0dsbEZkaFduOGk3L2JD?=
 =?utf-8?B?TmlpQTNwZCtYU0N4SGVIODJLRnVOMFVqNVRKYU5Xc0ZZSTVjYTk4aTJJZDU5?=
 =?utf-8?B?UkpPSUxySkt5MUNvRWJidStJYWEreTBKczZjeUNBNTdZSGtNQ0R5YXhkUUk0?=
 =?utf-8?B?Nmsvdm5XK2twNFJkRktscnNoQXpDdFJNTEpVMkc0VlFnT1ZvRDI4ZE4xeUNG?=
 =?utf-8?B?RDVXb2F4LzQxcjBCMExIZEpDUWIyQ1J4TmtxTSt0VDRCZkIrR3lJUS9WYkJV?=
 =?utf-8?B?SURyanBGU1VlVVl2RjNldE41UTZUYUZlTjVvZjJqZjQ4VXM4RG1LZjVQRXI2?=
 =?utf-8?B?c2Q0citoMkNZZ2FBNEVaN1RYZkQ4YlMxSkF5RTNMSTU3WjQ3blZZRHRYa1ZX?=
 =?utf-8?B?dzJtRTkzMnpMU3F2SmR1ZmZLYjZiWXpLV1ptV0Q1eEdJY1Z3TTFwQUN4RmpS?=
 =?utf-8?B?d2lUT3lPK2VndTZMLzZPM1ZQMVFDbmQyUW05c0E3RitvL2ZaMVVCQWp0ZVEx?=
 =?utf-8?B?ZXVDcGtObVNyWkVNSGJuK0J4MkJUcWJNeG1LODQvWlhsOGZUZkxDTHFQS2da?=
 =?utf-8?B?UlF4LzhNTk90QVp1UE9ZRXBGRDJoUXl5ZHFpSENqNzVMUVJrUG5sVVUxNFEx?=
 =?utf-8?B?WllaU2VKcTJES01SWkVmamh1eDBUbG04TDNFM20rQTdsK2trUUhseHI4Y3dk?=
 =?utf-8?B?elNHU2UwOGwySVVpd21vMHVJK0JlRG81RmNOdHRxSkFhUDNsT1B3Y0NSY0lH?=
 =?utf-8?B?VEUvN2hYajJENVBZcytGdWtZTXVGY0VycEFvanJyTGJBbFNGcWlqVk9Hdnp6?=
 =?utf-8?B?VDgrR1ovdWNlbFN2T1pXTGNQRWN2Y09ZTmNiLzU4c1FwMTlFUk90V0EvSGdX?=
 =?utf-8?B?SG1LZDV2L0Rqa0k4bzNxckxQaS9QV1d4eDkrYmc3L0Jub2p1SHNCOWM1c1Fw?=
 =?utf-8?B?OGMvL1BDZFlxajFOZWhFZXVqbE5zdlFndi83VzhWKzRvWFNwTldZclFZOEVR?=
 =?utf-8?B?NU5FS2RwVDRjbWlhbE1VUmxFQlJhYWJoQVJ1TDV3WTB0WWhYVHF2QmltemFL?=
 =?utf-8?B?WmkvTUZBMmFaeFBFQXAvUTllRWd3czQ4NTlyNC80UVRQQWhwUjJIZHl6Z0tw?=
 =?utf-8?B?bXplbUVKTnNnSGxOT1NOZis0QXRRRWxkTEtKS2YzUUNRVzQrQmpsMHQ3ZUkv?=
 =?utf-8?B?SXd3UWppU0VDSFpMSXpaRlRnYXlTcFhxQVI3NDVtc28wNGFQL3h1RmtEREZo?=
 =?utf-8?B?VUVvTUN2Wkt6S3F2N3o1V1NXaXUzYkk5ZlJ6OEU4a3Q4RERvN25FQnU1dWNn?=
 =?utf-8?B?V25rKzBWdVQ2V3p6cjJzS1FCeXl5VzduenZKZjNReExEUExHUnEwb1N2a0g1?=
 =?utf-8?B?Qm9vdTZSQWtMWXUyRGdCcVV3Z2plMi84VU5zZVNGa1htc3pNL1FHNkpCWW5W?=
 =?utf-8?B?dDFmeVJyVGtZWHpJTmxuajVKbjJOQ1RuWUtBMzU0QUh0aURrZ1o3ejBOWE1I?=
 =?utf-8?B?YlBqeU9iRUh3OFpSRzZkaSs2UFF6SmVucjFGK0pKcy94QUVITm50ZGdTUVdM?=
 =?utf-8?B?dk5LTzVHaTZHRDdUais2V0JJVjJIUThGeTcxa2ljNDNVVnFMQjc0RkFITUlP?=
 =?utf-8?B?QkpLSFVZaGszMXZzTnRHOHdUMVkzRnJuQ0Z1ZGNxZFpOUUY4cG4yM3RiZ1N1?=
 =?utf-8?B?WlREQkJUYWFqWG5aQzgvbFpKL1hRQ2Y1U2RnQmxGWVgzMUg4K0JaY2NuQWxL?=
 =?utf-8?B?RldiSlp3d2hnUHBtUnlDL2tUOUZTNXhxSGJUZEtaL0plaUY5dCtXOGF3SCt0?=
 =?utf-8?B?NVphNU0xMHhkRGZ6S1Q2bHBlWk9NUDdyV0pFZlpUQ2tQVEhSTFpzZGd5cEpG?=
 =?utf-8?B?NFB4UGxMeGpSNFZGK20yZGcyNUduWDVwVytwd0dvbmhJMSs5U29WRzdpdGJz?=
 =?utf-8?Q?uAUxjaOVqV/tcPcYo4s+Iki8WVY+k4MwWyyi1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4e3eaf5-a267-4bb6-224e-08def313df63
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 17:06:21.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HfT7TMcoRYsiEvRx4Qazn5JfwCpxVU3t3QDN0aZIssOeVyLRTGuj1ksyZ9oZtHr24hpQRMfRG87J/t5oYCjoGYzB574SesahY3Q4PqvqBwAuNfWdQ+iNvEIvtarNW+IM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10442

On Wed, Aug 05, 2026 at 02:57:59PM +0800, Shengjiu Wang wrote:
> On Tue, Aug 4, 2026 at 10:39 PM Frank Li <Frank.li@oss.nxp.com> wrote:
> >
> > On Tue, Aug 04, 2026 at 06:02:14PM +0800, shengjiu.wang@oss.nxp.com wrote:
> > > From: Shengjiu Wang <shengjiu.wang@nxp.com>
> > >
> > > The i.MX ASRC hardware supports up to three conversion pairs (A, B, C).
> > > The existing binding exposed only a single generic audio-graph port,
> > > which cannot represent independent conversion paths when multiple pairs
> > > are in use simultaneously.
> > >
> > > Add a ports container that enumerates up to three sub-ports, each
> > > representing an independent conversion path:
> > >   port@0 -- conversion path 0
> > >   port@1 -- conversion path 1
> > >   port@2 -- conversion path 2
> > >
> > > Each sub-port references audio-graph-port.yaml as before. Hardware pairs
> > > are allocated dynamically at stream open time; each active stream
> > > direction (playback or capture) on a port consumes one hardware pair.
> > >
> > > For backwards compatibility, keep the old single port property but mark
> > > it deprecated. A schema constraint (not: required: [port, ports]) ensures
> > > that both forms cannot be used at the same time. The binding example is
> > > updated to show the preferred ports form.
> > >
> > > No existing upstream DTS file for fsl,imx-asrc uses the previously
> > > documented single 'port' node, so this change does not break any
> > > in-tree device tree.
> >
> > if no existing upstream DTS file use it, you can direct replace with ports
>
> That is to avoid any downstream use of the 'port', so not directly replace it.

Does downstream strictly run DTB_CHECK ?

Frank

>
> best regards
> Shengjiu Wang
>
> >
> > Frank
> >
> > >
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > >  .../bindings/sound/fsl,imx-asrc.yaml          | 45 ++++++++++++++++---
> > >  1 file changed, 40 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > > index 608defc93c1e..67d2826eef3f 100644
> > > --- a/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > > +++ b/Documentation/devicetree/bindings/sound/fsl,imx-asrc.yaml
> > > @@ -78,9 +78,19 @@ properties:
> > >    power-domains:
> > >      maxItems: 1
> > >
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    patternProperties:
> > > +      "^port@[0-2]$":
> > > +        $ref: audio-graph-port.yaml#
> > > +        unevaluatedProperties: false
> > > +        description: port for an independent conversion path
> > > +
> > >    port:
> > >      $ref: audio-graph-port.yaml#
> > >      unevaluatedProperties: false
> > > +    deprecated: true
> > > +    description: deprecated, use ports instead
> > >
> > >    fsl,asrc-rate:
> > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > @@ -125,6 +135,10 @@ required:
> > >    - fsl,asrc-width
> > >
> > >  allOf:
> > > +  - not:
> > > +      required:
> > > +        - port
> > > +        - ports
> > >    - $ref: dai-common.yaml#
> > >    - if:
> > >        properties:
> > > @@ -180,11 +194,32 @@ examples:
> > >          fsl,asrc-rate = <48000>;
> > >          fsl,asrc-width = <16>;
> > >
> > > -        port {
> > > -            playback-only;
> > > +        ports {
> > > +            #address-cells = <1>;
> > > +            #size-cells = <0>;
> > > +
> > > +            port@0 {
> > > +                reg = <0>;
> > > +                playback-only;
> > > +                endpoint {
> > > +                    remote-endpoint = <&fe00_ep>;
> > > +                };
> > > +            };
> > > +
> > > +            port@1 {
> > > +                reg = <1>;
> > > +                capture-only;
> > > +                endpoint {
> > > +                    remote-endpoint = <&fe01_ep>;
> > > +                };
> > > +            };
> > >
> > > -            asrc_endpoint: endpoint {
> > > -                remote-endpoint = <&fe00_ep>;
> > > +            port@2 {
> > > +                reg = <2>;
> > > +                capture-only;
> > > +                endpoint {
> > > +                    remote-endpoint = <&fe02_ep>;
> > > +                };
> > >              };
> > > -       };
> > > +        };
> > >      };
> > > --
> > > 2.34.1
> > >
> > >

