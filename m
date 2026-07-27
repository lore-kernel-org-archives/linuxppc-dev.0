Return-Path: <linuxppc-dev+bounces-24890-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86FB1C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 12:10:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7y8d07RVz2yhY;
	Mon, 27 Jul 2026 22:10:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785154208;
	cv=pass; b=AlIjftSLuDoF8toxPrJil8lUQ/ec9liTjtvPVhEsFYQK7T69jiH/GXjbxhvmfKawNWB0db2jjw7YGibA4vmHUwywUKcgC/hmc0na/v/P8k+QKVkhOesksmLcLThG81X18AgTT759L1Stwg9umRXWGFYI51E8MbIbbXOf7x0Xlh/vRjCPXRsTRvdBAxp9GWTVlJ94yMoeRWT+5S6ed05FkUSTH47QDlS8Wxl46IpCJmnvkXT62yjeSzH6Km50Ykh7DUGYHQRgz2DRWSIuTinV/GpLKv4g+U7dr48fGl6kgGTjmdcaWDQAbCt0pnNmT+Fk5npA+w4ScSrt1jeebqPcdA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785154208; c=relaxed/relaxed;
	bh=ySCFkkp1aBMyxERoiT38Z2zrgD6/KFFowfWTKGWryeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KzUYL5nOM2Gtz42Du+vlVku2e8KW34//boDP6aVQFyq5zXRRmdtma2huloNtlaA4uB8cvOS0kLmapUyO/gW2ddt9q5zdLXSG7IT4+8el+HFSLQN9J3HzKoaNqDnalLEx7NJMbM2m27XrkVdbmgWNz6y6YW3rjISIzcfdGp+k3vM0J5otHEuCoX4Atc0/j3Ja3ZxjjxTYoSBoO4SLoMtBP/d/K4pj8PMT20ms7OYHxnrqB2MBAHauCM178l/bormjAs1mmSuerfCeEqwSgPU7KoNJ4zyB12ian2Yhsv4+w2EJ/nkVBvLtrh9kngj33xgUdug3oC+cuTEJ0XW7EDlxgQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lsw2m7Rd; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=lsw2m7Rd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7y8c1hwqz2yhD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 22:10:08 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EXHrkptKOIov6shew8koGEhMsQvlgu3X+yls6+ZhmDv5O5uTyXuZiIL4XfWiHRgzFmG+H68pUyJAZmNxeD8Oi/WP2jktz27lytCZ73O8Oq0PALsIXD1JScuDmMJVK9utvvPi50ia9Fs5wMo8kMhSq7ndF552tVw5amc59HGRPuUZ0mqMktOXgPSMwaNi8hMA8bzVxUGDz3PB9rYGgoand3EG4UWybyg+rdyTq9luKeASL8CesqH7jLYnooRSiDm0kRWY/U8Pxcia8sy/BG2rwoGG9fWa5rAXuNU/n8p4O1U13lYnqt7TZto9MTZskzG1SYIsCNS2w4D2nN4dxdOVXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySCFkkp1aBMyxERoiT38Z2zrgD6/KFFowfWTKGWryeE=;
 b=TuUsiB4BoogV8Ak43IdxQ35OstRoOmbQDpp3dRYye3sZl9Gg8z5jow1M3C8x5YffcRKuvSNhIOCOIpOejssDWAs55KSQPlIi8hezrAsPkPJn7dZeYH8D53xah///NRm7DGrPhS1Gi2LMEEznTmD13Vv5SfmVXYEU6i431YLRLFKnwa3o2eNMAU7kNwFnbSoqPiU4qjDUJ40DlTH5LXTf722Rb6ae5FXveMcq534P7SYHk4FcxNruZ1tHUmGMYyla9at69muLLkoJ3K4W2qjUkQBtlCJX4Bniwy4PKZIhPUpM5BNXEoHdO8bfZcfp7Qe/KsEYeSwLfsUnCb8SsQAloQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySCFkkp1aBMyxERoiT38Z2zrgD6/KFFowfWTKGWryeE=;
 b=lsw2m7Rduq8+EKcAOR2vmplzvwO8P60r5bikx74GaeBKuk5cmG6SvXr9kNSK7763alPR0AD3/qDBnRHolSXSbTTM+CQCuhh3+Qx+1kPutr6cJgxSRqlBwTOzkEy41e37MYhtaMop7UqCXC5mmW8prpg3KjrtVVVmNOc6+THWEzlenkmI4nN6cNW7zGRJUZP2d2FkbPOmJEZn7g1CDYxxNuNWGl4kLinKwUrmfaeJHNGgw7TG0mbxyXfHj7kv6XE/smuJrbyYjU4bZc+TMzNNm5LzSGYskJdlnyqnuChj8akWVPXeHtwf1fHQObElC0ypa9D0wDe1j69GB/ZUWWL6SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by VE1PR04MB7453.eurprd04.prod.outlook.com
 (2603:10a6:800:1b0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:09:44 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:09:44 +0000
Date: Mon, 27 Jul 2026 15:09:40 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	Christophe Leroy <chleroy@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 2/2] soc: fsl: dpio: Use scope-based resource
 management in dpaa2_io_create()
Message-ID: <lzwhee46xmnhgr2vjwzuoe2ysmlqavhpyod5kn67avwockpzin@dq2pbhluryme>
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f47abd6e-9337-404c-a24f-39a9dd7454d2@web.de>
X-ClientProxiedBy: FR2P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::9) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|VE1PR04MB7453:EE_
X-MS-Office365-Filtering-Correlation-Id: 342c4d6a-7847-4089-44b7-08deebd7f1b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MjgCZyp9nP+/Byw8dee8lpClsIjGjDLJAour7bla8KGsbCP8OHcz6AnAWlAuvOZ6iwNOu7ufutqIb0eU8VquWRnCpHLNmRLJkkucTpnmXh8SkW1q3Lhv1+TFEH+htKgRNuOoQL9EBDQXh2gcLEd8qiCEC+mkS+cxY88uqbMfi0A1xYhtfmHXPYLo+IAaCVvhj67l6ydFWec0I6cgrqsy1MunfCHiLnkFGaAZzmLilGVjpn/o2dzcdEbF3nP0lDHRwqBey1iHh8YfPWpFOKndFtlR5Oil7p1+wAJi9rxpJ1rG8UcrTXf/HlzA07MN+cUZLUiF+wB7rHpAvdaUqheQYtha/63tLsJh4/3oFTXlyMwXxkAfw2P8k0aY5z2a61LPQVbmjqWZTq5K0oDwGp7lJPc49GUg+DNpFaRrmghYPPpE1Xa/3pV7UePqOWl7ufhYuSGXbd1/4HmvE+JdiHhN4LHqoIFA2tu/3GqDN0ADnAZeaXZom7EQSaJQyno+IJB9FokXtouMYHztGQB+PtSfoaqcGfyiiSZsYRjtuBgOK6rEY9fR7bM/BzNXLOyWiNUbGHMQpnAdj/E1HGG8ioONb//5xhX8sXb+pc1Go+ERVx2epj/22rubyPQZB1w/b5ZVIF+6DzPka3BNQRNgJAV5s9iIEwM1queqtJs43i/PlN8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWRoV3IrUWRZL3NTUkRxYVBzdEdHTWdPV1NzVnVTUWtwYzRBWUNkN1JiOFFr?=
 =?utf-8?B?Q0hMSEgrZkhjQ3hyWUpkRGZsMVI4NXI0TnU2QnVjVkhjWXNHV0FuOFVtVjcw?=
 =?utf-8?B?NVRMeVJ5SGZBeHY1SWZYc1dxekVlYVk4MEplYWgzcWJNeGNudVlkMy9xUnJF?=
 =?utf-8?B?d1hIdXN3Um54OWVBMFJuSFVKdXV4OGduRFRSVU5uZkhyZ3BPREt1Um5lUWRx?=
 =?utf-8?B?MVJBM0ZVTmJmVW5Ya0JwREZFN0hYZG1yVG9DbmFPbGJZVVZBTy95aHJEWGs4?=
 =?utf-8?B?a284b0doVkNzVDVlMk1ab2o3SzhaQTZjMmRqRkhLbk9hcDVkOTBmQlJzZGI2?=
 =?utf-8?B?Ulh4eEpYTWNSa3cvajdRTTgzTUw5dm9zTmFzN0FVcXNORHQ2a3lrR0RSV3g4?=
 =?utf-8?B?bVNzUUZvQXpUWWlFVGFNMjdkQlN4eEhyMU04ZENKUGpOYXFvY1J0OWVBSWk1?=
 =?utf-8?B?WHdJcWxGeDhzQ1dwaFNaeGlmYzY3Uk1QRWdsVWFYS29lWHdKbE9WNE41MEZp?=
 =?utf-8?B?QlBCU1N2L3ZUVjlJdWhna25nRXZRV0t3ZGJONm0zeHQxQjNaVGlTNXI1My9u?=
 =?utf-8?B?WGI4YUhLdmtWZUM0eDhsZllPNitFQ2FkWGZVaHVURXdBcTlvajZuU2RFK1NL?=
 =?utf-8?B?WEQxdGFXWFFYcmdybXhPTERUMUpRdTIwNVF2VmhTMDFXNzNmcmVldHlOa2ZJ?=
 =?utf-8?B?MU5xNndVSGZYckVZQnlTMlpMN2V1OU15MkVLdVc4WW53YnA0akY2aW1HRVh5?=
 =?utf-8?B?a2twZDNGeFM2Q0l3ZWlZbHBlNmovU3VmdElNdFdjbXM0YmFTNjZVOUIxbURw?=
 =?utf-8?B?Rm4xR3NNTFBoQUNFVUdDR0hid3ljUHlrdm42MjU0YTZMVUVaTWpnenF3ZFFX?=
 =?utf-8?B?MGZGWGxlOHNGR1BubjlOS3lYTHZvTkdVN0FLeFJGOENPOGxBRlVuK2xVa2xW?=
 =?utf-8?B?R0RoZXBXeVJacVdRQnpPUlZqZGxDcmpPU2VNbmxHVVphQVpHVmVGUFIvRVRz?=
 =?utf-8?B?cWRPMC9BQjh5UEdRVjVTY0E2WGN2b1d0SFJidmtDZUFGbkFpZHJVbzcydldp?=
 =?utf-8?B?UmZ5VG1ERTlzZExBRFRYb3AyVUMvSk5odUZDMVpsMUdCL0NUSXZzS3hhUWZB?=
 =?utf-8?B?R1dLMEs1eDU3TXlnWWhWYXN5WnhIbVNHNzgwODdOTHBaNzFEWEZSbU9MczN1?=
 =?utf-8?B?ODZrMzVoeGN1ODNSazVSOEpOM2dxQ29OK3h3TG5NUWVzdStpTnNwMjhYRFpz?=
 =?utf-8?B?OWt6ZkYzSnZ5MFNQeXVrOUFJRjV0cjUyMWIxb2JLVE9Ocjg5eFhhcnNHcC8y?=
 =?utf-8?B?RlZnV2swcXRLQ2hBL2s2b0dZaE5uWlhwK2hDTUVUVzhhVXhRMjdMUVVBYStl?=
 =?utf-8?B?cVZTcWdvcEMycjA2bzlHcVJDWXArL1ZPNlFieXNEVTlVWkFkSU9LZ3h3cmt4?=
 =?utf-8?B?b0g2eGN2NmtqZ050OFBleVpqTytNcHV0eTZUdkRDNys1NTArT1UzZE5MOU9t?=
 =?utf-8?B?WVNxQktVZjBWTFJrYUk4SG9oRGJHUXJrYWgxZTYvRzk0cGlUU0I3WUJSVnBQ?=
 =?utf-8?B?VlpIZ2NCdDNQQk9lL0ZUaDFTeHpHRU9sb0s4YlZjMmNOOUJuNERnY3hOczla?=
 =?utf-8?B?OThiTEFkNVNuYUR4TkI1VGtWR3M5YVJoME51UlZrMFYrQmp4SkxOeUU0eW1I?=
 =?utf-8?B?Y2xSSGFLUG81QjlmNFJReC8yTXhjcHR2OXRGbFYwNWxnWE9QL2MwdnJFbDR5?=
 =?utf-8?B?YXhWbytYaDV6aTcrTndFUmNFUlRnMWFYOC8vOWlSMTB5dy9HOXZyamFLWU5C?=
 =?utf-8?B?aVUycXBqUWc2anF0d2ZTb1Y4OUUxSTBHd1kzeG9KKzJKN3JBNjN4WSthREhC?=
 =?utf-8?B?eFhUUnJURENYc3dRekRSR3RTU1VRTE93cG9qanlSdGtoNFJlZHR3QVRuSVNv?=
 =?utf-8?B?VzlXVkhoV1dCTDNvdXJZUDZCaEpNdlJBNnViYUpWZjg5Z2Uwb043cFNMMkN5?=
 =?utf-8?B?QTc1b05YQXV1SENJKzh6TWx3WHpvbjdZL01LekVrK1NXeXRhUGpaejk1T29K?=
 =?utf-8?B?ZkZMRGF3L2ZDd2k4aFN2NmlnUU8zZ2kzaEZtdVloQmFJLzhQK1hvNkNIVExC?=
 =?utf-8?B?ZWVKNjdSbTlyZXVxRWJyQmNFWGRJVzRSZE5TMTUySG52SEcvRzdZWlY1dGU5?=
 =?utf-8?B?Qm1mTGx3L3QyK2tLQ0wrSnJWSWVFMzh1UWFBYmY2YWg4Qk1SVFprd2JFY2FL?=
 =?utf-8?B?ZVYrL0N5enEvUW1waDJFN0hUVmFBS3hUcEl3cTczSHhac1NzdWJkcjR6VXF1?=
 =?utf-8?B?eitYLzUxejBERFNQcEVIWHh6R3B6aWhqM1kxOXBGMHhBNzVuRCtFdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342c4d6a-7847-4089-44b7-08deebd7f1b0
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:09:43.9819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8qaiBsLNS2UrBFhYVOLCAa3/ho1Mu9GJzYljJlBcX6Ak78g7PAQb4dQ8iP4diuYgPSLJX+TOIZmdj/z0yx1C7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7453

On Mon, Jul 06, 2026 at 12:40:09PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 6 Jul 2026 11:18:39 +0200
> 
> Scope-based resource management became supported for some
> programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
> Introduce __cleanup() based infrastructure").
> 
> * Thus use the attribute “__free(kfree)”.
> 
> * Omit two kfree() calls accordingly.
> 
> * Reduce the scopes for the local variables “obj”
>   and “qman_256_cycles_per_ns”.

Remove these changes. All variables should be defined at the start of
the function, especially since there is no strong reason not to.

Ioana

