Return-Path: <linuxppc-dev+bounces-20074-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E884FE5205
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:37:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28X22nF4z30MY;
	Fri, 24 Apr 2026 20:36:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026994;
	cv=pass; b=AvrYBMsAaE0iKdNXX4vXt8Hjd8j0mvx3+VNIkli3D9RF9zUj1UJHplkEvg6a2jSL6cX3Ozo4P6o4ZK5FQCSu/Ec1uYxZjc5DTntlmMBNCcCVNvL8y/sitmeGzZudgh8zE4JVsJHu+g5L0ZpjRz5uKBP3gvnX118az3Km9rpWW4w5PqVYVWJpxzMIylgj43RxHWZbLmOaPBzsQo1CdhFZTnUArDaH/hdwMtiCe/3TfV+H3tQV/lZFdrCAweAw59Dh2lOsyGQ30tp3rWy7EWQRiUjght4U8mwFclLtO8K8s+6zERdHk+3Edtgucd1JQ+Io8OZYH6H/L7Ekx6b5eZ7/7Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026994; c=relaxed/relaxed;
	bh=0lXyWnPUwTTuHVdRZXPoVY7xyXaFfRGVrcqMV/3RSr8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ojrMLc9vUtGs2k983tcfAUc6rqsDGamC4/srUfz/GP5EuEW6m7yLBt0K4AHru7tjKuqPTPilbnFkWraR7wPjqVTC3ehQ1ahH7c27do3utoUJ6O0cw8vkTDcihru9Hoqphau5kalj/9ZUnZm0y50czLSME1HoW3Z0Q2Y5A/ZY+/FH/hoANWo9IgPrMX0XAS+Hv8N2SUAyudE8lLFGoF8hohg2cVaEiEogx3onwKAv7zklSkEfN6OUY7UYrFSlEMlCIM1Q24t3VRI+JlYIKVorlE+wP2rP7ak/POqPiqOU1xvjUO9H6SnqvgLSH4iQaruAeTMfKechKou80gpsRKKOwQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WET7iEdI; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=WET7iEdI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28X14VvZz30Jc
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kj60mUx/cG/hFJxyR+UmqIEQne1yh6Cfqh7wdyWFSaC5n1xpglHYCtxODFc6gCZewvh9+SbkpBBuT190aHPbckndf4D4IURURrMuggnclMtNnPxLjXQ7npW2D5cGGA2xFEza8TF9mKltQG7UCr74rcyl3Ar2+M+ORgjAtRo5iBxkWLkmgaml4UC7n7N49QQziT9YSxfeWdT+WScBZ7Q7UvKQrnEB2xkSC8BtZoYPXXzFkTi28/QuHoXh6q1FcWZqLVa7QIMSCJ0+jdCp8mEfp/mDGYNZZh64wOtniddPeL00MM9xS90rZXb5RzdGXMvXZwU4zkE8bwdKy/btOcc+qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lXyWnPUwTTuHVdRZXPoVY7xyXaFfRGVrcqMV/3RSr8=;
 b=ZeNlyiC4uPjeFlPFhePHXewY1sWrpO5D2BxQLQC2xpLQLVnRZwdA1LlhYL7UbfwmRjrUHdM682JqPlfipAyjqFS9KPDamlw6QiBv+cQt9WZ4hB0aQoSE7t27SuKrvuGob/I8we/40aOPhFLnHynTgVJNmm1q/rGItRgapq3C0iihm1eiyceQA5bPo6CZQcVdeemrzYxcbzvvkpm7TG4cDY9vOhWfK4ZufdJ6vFlQUENYU7fO+xJomrQLC5h8TRUvyq2k7ggYPQBWv1daj4lajNxfxfwEuEzH7VL2wvWYGYVYVmmRc2H6KaH1LYUPgtfCnk0hu2xYbT0iJsQ/SmjCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lXyWnPUwTTuHVdRZXPoVY7xyXaFfRGVrcqMV/3RSr8=;
 b=WET7iEdIvwO1AD5T9I7IEY7i587N4xXZolBlijZ4Y8h37ljtZv6IjaSlW4qGYq7QpdQMTot7UHLpb3C7OeYqJHfWU+s7HOI8pftwnS8nMfKitHw58ngQ/1/8Vfg1D3AOnnLb2zcQOhmbUzndPZ3rZrYeS/6BhxLzYelsRmm0iVxH9hK/dGRGcd6EV/AgwnP0QqgJjdgZtgsOIei98K4swuZIDvv4v/6C3HinFiXEbKjxUT86KBqgGndBBE6wTRW5uvvK5moBvVHT7idCu2WJ3Ucj4RSmZPbAMGZ3DxxmWfSFdGKQdi12sQTiKca01JLUT6HrvFHmI6JfFEg8gRUKTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 10:36:18 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:36:18 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit
Date: Fri, 24 Apr 2026 18:38:06 +0800
Message-Id: <20260424103806.2276780-6-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
References: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:178::15) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: 509c1c58-5af3-403d-b27c-08dea1ed51c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|38350700014|921020|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lpDHNOeZ/FyZ4ZEzzSzfTWtRP0IWltZ1J+wG2QArW0qcCilb0d3eBLfJQeM1stvvdSs+sCM8VYwJ/oioBHKk7DMHHn4mCjT5GNOnOWmQu9ZtwwD62qNSNQKOltgXG5FAcUUk3og9WdQv9lD2s3xi1Q2bixZb8pkU/kDSSswO/BTUYicVV4tMrNEc0ztrq1B4zlm+FrrFuHbPSDaj+tY7528Z5q7FtMSfEHFzoRQVkLukD0zJzCV28lRqd1iHTHfZjPmsQPnGZZ6ES1gNlzIfdLifgErjI/lVq9+l2C5TuxbwjNZlchKD+4+QRDqQbXZP06Z1UCNchl9vF+ZuB0NzdlMtK4tfAvxEUUgm+B1wkgSd50VUXobIhLX3hFdXFg0lWIKWfzpdLTznBn9Q41tw5UN5oBuwzCUYLlj9InL1LtNzf7ukj2xqiRvSCvbU34B0JgP+vYHH7D1bJPlV68m82c9xPNzUpftLVA7I1BGH4/cXQfJ2sk5o75ozEt1G9c2U1u6Kem7OCKfQTCTpSuoYhyoAJk7UFDkNWc+HHDT+8Kc40u/8ZMruLPZfsfLtMHdZi72sTsOGjZtiTatxDZmgOxfx8rD6Y64Ft5Tm4DCX+YOK0hgZULxavN4H/J3K3hzLRv0O4HzUIPed4KJ3TcSxkj7OmpjoqDm09oWYyenimHLTpiGPruqVj1sdYtqwHytzACyHFrbZ6p/ugnm82X4+V2ZP2yRxuzmd8cuN3rRcrKNpJPVIm6kMKJwp1+5V2L7ZUV7kLpBNA/SwefLPBk6uqOPPwwdb+D29YYR9W239PncNkuu5N68zzaW/WpUNHpQy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDFrTlQ4UmJQK2hCalM4aHNLQURpMUFOTWFvY21NVzJ3cHlYV2ljU3hjbmMv?=
 =?utf-8?B?ZXFVTkR2d1lFdzJHbDg5OHplZmczbkVZTzJsbDlNNGlSclBDNldEVE5BYXlo?=
 =?utf-8?B?bzB6YzFZdjJwelJzdEg3N1lUemZ2c1lQaHUwdWlScDhiSjhYUll5WEx0ZmZH?=
 =?utf-8?B?dXVwV1c3aU1zOEMzVVNyei9senlOK1RKTjBaRmEyMXgyeFBSU0xRU25Tb2kv?=
 =?utf-8?B?OGxiMElvTTRMOFB4M0k3OXNLOG9xUmVMQ29aYnZTQjFmR1hRM3B5U1JnNnI2?=
 =?utf-8?B?U1gvYXdQT3IyZ0g0V0h2ZDBhR3VrbjRSdGRFcGRhTDU5M1hKRzJkaWYvUHFW?=
 =?utf-8?B?QWNnMGpuUUtrQk84Y2I1RDJoSllTaW1lUUdMT1FNb2JHTVdsWm1VcGxEMXBM?=
 =?utf-8?B?ZnlEdjk4M1ZmaXJQWEwyNHZkamNGdEZrMGh5eHNGRkcyMnpIbCtJOCtMV2tv?=
 =?utf-8?B?MkcxTHNWL3J5SUFQN3UyQjVZTXEvdUMyenJjR2xyaTRkMVlJY0pLSWU4RU8z?=
 =?utf-8?B?dGNzaXR5UTY2NDFVcEhjQzVSTmU5bWE5aWZkbVhqYUlvdWtKU3lGK0F2OVpM?=
 =?utf-8?B?ZGE1WVpKckxIVFRLU0d5ZDVNRzAwWWNVdnByVTFKRlRpMFlMbzZ0cUpDeDhL?=
 =?utf-8?B?NnJMaE5sVm5yNFBpTDVyU2ExRTIrUG16V0l4d1E4aXdJOGFYUTJIYTFjTzNN?=
 =?utf-8?B?Q2JpUysrQ045RWhLK3lweGZCK3Q4ZjN1aVRlZUZCd1R2RTk3OWU4TGtmem96?=
 =?utf-8?B?SnQwMUxDV3NtdXdFWktFelFKNHBCcTVTSkxKdUMzbXZPWVdYUHhCRFZXek5Z?=
 =?utf-8?B?OGxlUkQ0TG1MaHBHTlF0TDVNWTBWeURaN3JyZnlOTitOdXR4ZnprY0l6K3hW?=
 =?utf-8?B?Ry81azRZVlFmSHlTQUlOaFlmUWNZSzJkWlJSM2lJc1dRd1ZKU2VQeDBnM3VC?=
 =?utf-8?B?WFZkWjM0SGQwRWFEenJPWGJXQWtsenN2VldTS3lZbXZXcU9lek9odWt1TjVQ?=
 =?utf-8?B?Y01RS1NDQXBPWkF3b2JzM201d3llOGxyTVg4aVY5RkpNM0FXUTQxOXBlSlN0?=
 =?utf-8?B?ZG5UeFlPSDVRNHJjeFVuR0FCOG9oV0hVK2M2UUpURjNMekdFejN5Z29sN0Ir?=
 =?utf-8?B?QWtJTzJBbW00aTY1cnRXajNEUHd6eW9IR3NYSXd3L3k5OFdVMWg3MDRjOE9G?=
 =?utf-8?B?Q0NjbUplU2ZhcWtUZ09FOG1acUQrbmR5NHBDbmdkM1k2djFNS3FUbDJxcmcx?=
 =?utf-8?B?UGpzUTZYdEc2Z0Z5Q240d1kwQ2tONUo3Y1pwYUdDRnV0dlJoYW0zSTBDUXkr?=
 =?utf-8?B?QUQ2c1B5c2Fwci95YlR6OG1DdEs5MjFibnRDTmdSQXNKMGFnN3k3bUJ3MjlD?=
 =?utf-8?B?blMrQzRSUGc3Z2dmWDNYbDJnai9OSnZ3UkZUL3JMellhelpPZjlGeTZQOCs4?=
 =?utf-8?B?dDA1cG52TW5XdGZsR1MwY0dRbU1IQWtMcDBLeEg2aUllY0s2TVM2VUlvc2l3?=
 =?utf-8?B?dVdBTTZRd1h0VElXaGI0dlROeG92bWl5OGRNTTdHZ0xHenFwSXR5TGpKZXd4?=
 =?utf-8?B?K0pFKytkNFBOMmlDbVRIUTVVSzh1TnVpT1lFZUpoN3hjMkJWV1VtQ1V0bWp0?=
 =?utf-8?B?amF6bGpNcjdsTjVNRzBlaHo1QzlJK2dRT1BrS1d1MDhuMDRCSmFma1JTaVVh?=
 =?utf-8?B?Qzl4ck5BUnVEQ1JWMzNZdFNSRnRZWDZVV1Z6OVZ4czVXR1A1aTdCTkZNZ0lL?=
 =?utf-8?B?WFdHcU8vWU41U2dVZ2hCck4vanMrT3IzZ2VHbjQzSy9rdkpuK3pjMDVNTnlO?=
 =?utf-8?B?QjJQNWdVQUpUSGlpZ0tRbitNQUV0MFhjL0ZycGhBYmVLSmg1M2tkOFZhQjJV?=
 =?utf-8?B?WWNJcHJEQllnOFVpR1ZQS3lhUVVCNkZMMzVNOGFta3lXUUczSTdITzVTeWVh?=
 =?utf-8?B?Q2M0Q24rM3QyamE3eGEwVUdnZ2VtOVErL0w1cFNyT2FpRHQrZnlWN25JQitF?=
 =?utf-8?B?TFlQQ3FpUWs2S2luNFJUbnZHb1BSQXNqTWVUUUp4clJ4NkNCVVczZ29hMVVF?=
 =?utf-8?B?VjAvNGNzQmY4Q0lNbGlPZFNNUVl2MzB5S2ZRV08zdWV6TC92VlV4YjFkeDJJ?=
 =?utf-8?B?MU5taldZZ0ZGQStsUkE0bVJWTDNIT2w1UTBvYWI3MFhNK0pmVFpUcjdjR2Rj?=
 =?utf-8?B?YUJtRERUOFhGbjExdmFFQkdicEUrVXYyRmt3N3JZVStia1lRTGlCdHo0Q3JO?=
 =?utf-8?B?Y3hxK0p4RUFZMStlSk95bzl3Tk1Ob3RNcWQ3UWkvanEwaDBVODZzNVRkaUpo?=
 =?utf-8?B?UjdUTitpbGlLTkw3dmxqcVRHNzFIbDFOZFVISDZBa3hXbTNwOFpkdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509c1c58-5af3-403d-b27c-08dea1ed51c4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:36:18.6600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb7hHEdPCwdKD08Y9Txmie/WDGUb86JiS/VxQirTmbq7w+4GwTWWj0re9X9GU8TaIm5AATDLJiytcFYT6YJZoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

WM8904 has a 27 MHz PLL frequency limit. The current S24_LE PLL ratio
of 384 exceeds this at high sample rates (96 kHz × 384 = 36.864 MHz).

Reduce the ratio to 192 for WM8904, keeping PLL within limits at all
supported rates (96 kHz × 192 = 18.432 MHz).

Add codec-specific pll_ratio_s24 field, default 384, override to 192
for WM8904.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 36c789f15582..e72ce2fa9e9e 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -60,6 +60,9 @@ static const u32 cs42888_channels[] = {
  * @mclk_id: MCLK (or main clock) id for set_sysclk()
  * @fll_id: FLL (or secordary clock) id for set_sysclk()
  * @pll_id: PLL id for set_pll()
+ * @pll_ratio_s24: PLL output ratio for S24_LE format (PLL_freq = sample_rate × ratio)
+ *                 Default is 384, but some codecs (e.g., WM8904) require lower values
+ *                 to stay within PLL frequency limits
  */
 struct codec_priv {
 	struct clk *mclk;
@@ -68,6 +71,7 @@ struct codec_priv {
 	u32 mclk_id;
 	int fll_id;
 	int pll_id;
+	int pll_ratio_s24;
 };
 
 /**
@@ -242,7 +246,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 
 		if (codec_priv->pll_id >= 0 && codec_priv->fll_id >= 0) {
 			if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
-				pll_out = priv->sample_rate * 384;
+				pll_out = priv->sample_rate * codec_priv->pll_ratio_s24;
 			else
 				pll_out = priv->sample_rate * 256;
 
@@ -806,6 +810,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	for (codec_idx = 0; codec_idx < 2; codec_idx++) {
 		priv->codec_priv[codec_idx].fll_id = -1;
 		priv->codec_priv[codec_idx].pll_id = -1;
+		priv->codec_priv[codec_idx].pll_ratio_s24 = 384;
 	}
 
 	/* Diversify the card configurations */
@@ -912,6 +917,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv[0].mclk_id = WM8904_FLL_MCLK;
 		priv->codec_priv[0].fll_id = WM8904_CLK_FLL;
 		priv->codec_priv[0].pll_id = WM8904_FLL_MCLK;
+		priv->codec_priv[0].pll_ratio_s24 = 192;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-spdif")) {
 		ret = fsl_asoc_card_spdif_init(codec_np, cpu_np, codec_dai_name, priv);
-- 
2.34.1


