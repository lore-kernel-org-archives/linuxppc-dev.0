Return-Path: <linuxppc-dev+bounces-24888-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F66C531D0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 12:08:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7y776fsHz2yhD;
	Mon, 27 Jul 2026 22:08:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785154131;
	cv=pass; b=YB5pPJSdGqWqJoQB3PNwrxOJNXvWKc1AjFL1RdE76lrhIwuwTBtYmZ8c0RxL+2UB0+4eCeiOQVL0XdZP4Fs92Jkx+7eMynK9YOU5IepkMMxr3q0fGz3+TJHks6JzvQjbGzLbn6+evp1idBjWxqInW229syZbydD2x0RSCJyRvjD9BnIZkDCED8X//D/XqPcUpmnRjBbbTo0iyVBC/XyS2M2I8GWgm9IIQMa+jKJCOBM6dIvJU/OE12AbGSsSsJI00MNlZ4kfNfjfalAN/aDNF7kNvMd2xHgHrPC377pIiyYN6vyjBtHcHw7aQdqSEzHvcv6YwUZzl5Kyb9TbjJS1yw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785154131; c=relaxed/relaxed;
	bh=Lb0teh3xE/5kZ1beqNNXIxZU6GywGaUGIQF9+ol4SuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M5hrXsNSxVxZ3jGt+0MWvIvxP1veB9JfD4lWL4dIpSsUk00DDen57Y5AO4sxz0ZVtinrLLxoPU/p3NNVIsCXM7WEeqMS7TUQapX67A2nUlUs4r0gZMnXUY8bSCv6hCH9odIbhq6SeuTAhHj/TuXVIOrp85e4XmX7iumlwJZIqigsOv472o6+xw6rvV6wWrA/QHV7vHCDzaNk/qRo9B4lv+GWWCr5wxrtYzSYgjwPLeZ5MVY/97PVISXwNQfQkJEtf85q6dQ4k2lQCM/5hOjcIYiBxNh0qm9cb1AXHvcndkygxQgVNp5U1GYBTtLth5SWvLONbbU1hLi1i1GB3SLnIQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TRyjrpLM; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TRyjrpLM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=ioana.ciornei@nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7y762W37z2yRl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 22:08:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cd2dFPU7pyRkGA0JsfKqPGxWFEX6dOs8Nrdpp0HjwfbrUXXIxOymLkBh5c6rlPksEJLeBvDSplkPikLC1/qRRhQRkRdXHlAE5mD89xMuWa1MtnCzEOPZcLIvTafDxW+Shr4Q7HvJrjSX9chxWBzeTShJ5WO9u4do32YQ/xy9m3JxvJ/ezTPMoSUOCqNsWOWs34lhqXSWtAumPpXRsm+gWFKugPUUJSa9TRPyyqa7oNk28cBl0nMSTmc1lpfFExW+JMcZrmI61Q3g0Y02aiumIA88+QkT7fgZ2nB+F1G3c5SRhQKQSTbz1bKzzRTIPIO1VgaIi+3F4u5EbYYh77SBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lb0teh3xE/5kZ1beqNNXIxZU6GywGaUGIQF9+ol4SuU=;
 b=F8ioVMLI6Gi6jVFVcfDjxGQF/GL7OIQUmVR3wU9M/fgEaiGxpf8a4TRkB9LsWWTi67xlDzOfdVYZK44MikCuobZf8OUAaliUPpcJgs7hOOCbnYfTN62TO//glSFhBlul7QLQME7myjkXAH2EMVHn4lTC5du35gAIavtR7DW8yxVx/KP9OATqHt8/zl8dhZRSblX6EIkE2gr/35WDKdKicYBpuvcyaf/fKayMRwpX6PIxAWMIsOQRkzxiDjT2wzJcuYTNn8UPfvge6y2/n1205m0ykuPzo+V1QgSGr5hpTcd8dV6Aki7rEq0mZeNhiYUldsIBJLFrxRB9pcsjM9PVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb0teh3xE/5kZ1beqNNXIxZU6GywGaUGIQF9+ol4SuU=;
 b=TRyjrpLMlH+4/Z2FOBKsRZnxh/g7xz+Hf7USXCPQ2U4Dvm/fjqhk/vOb3hyn6Pf8jiWLhdNaCTbp8zdKLCdZEGymTWC1zPlaLU/uRLjUriEMMhpy6kPpBNmypN8U+ahTPdguA7oDoubcd8CjUisTJpP6/yxokO7Qia2FaZirF3HKi5oNbDClk+UcRqcb+CKAYyPGn7WqzZcQ7Iep+mobiBzXP16O1hG3r7lmwhFycXw05+KN3laJI1ckcn6leyt4dZvRzkdDxdeRF3FoxH7ZvE+0nm9pFr+UqWFMnZ0pYatA6vgPB1GTxUT+4UHgc1YCA7A8YppVxngk9bwhPbwT4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 (2603:10a6:150:319::13) by DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:08:21 +0000
Received: from GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd]) by GVXPR04MB12290.eurprd04.prod.outlook.com
 ([fe80::1739:3404:2175:33dd%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:08:20 +0000
Date: Mon, 27 Jul 2026 15:08:17 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	Christophe Leroy <chleroy@kernel.org>, Roy Pledge <Roy.Pledge@nxp.com>, 
	LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2 1/2] soc: fsl: dpio: Use scope-based resource
 management in dpaa2_io_store_create()
Message-ID: <y2h44um2grcbecnpkck44cvudugha6df2itq2uy5y46whxjouh@yy2kebig3ia5>
References: <690827f2-e746-4378-bb7c-9948cd69dc15@web.de>
 <d95d2f4c-f3cf-44eb-b61b-79ba7891674d@kernel.org>
 <d2e5df25-c8b7-4ee6-8ebf-1725542baabd@web.de>
 <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6607bb4e-a747-4791-b93f-f82f26e4a334@web.de>
X-ClientProxiedBy: AM8P251CA0028.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::33) To GVXPR04MB12290.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GVXPR04MB12290:EE_|DU0PR04MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: faa2968f-8139-4538-ebf3-08deebd7c01f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|19092799006|366016|23010399003|56012099006|11063799006|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f2h/YIvCNoFxvoL6YeOENhWNtLS5J49efOyoVCxm7cgy89Xb+sWIXWQcLKFL31TsP618EAXCfmnr2wziDpjreSpXjneivgYjRd1oydoL70aL5xSH98HtAcqVvlsNtsc8IWjrZhqK3oeABpd1gT/Z97Hlg9U54Wk0mbtQa67MjsoAC/xd+QjrHYtrFEaxAv90yagyFj/x4aSBTMeg5FONmfMbRUsJ8O3Vm0B6dF6hqWPWcQeVhvSC2AnnqW1R1Aus0EuLZsDpP1/JRJTvVZaSLlqsZjrU0KTnAi9i4Ph55tnLs/wCvNlXXGpsrg9cr91YiFBx/fsBrdMYqo+Mr/fTYkOszoYppf9TORZJAZo4NztMDqPLUez3Ot0LW2uymRSZ71OePuxCqr9W/o+yRoXDxec/3rhz0oYreUlQxrWagZJXpXEnqwFg+GeatDq82+Ydv1EIWlAHcaMhoW6ltglNe5fUuAsC/VmaW9m6OkmpsSQ4Mg4wY7V73VOmsuPCBKJI0L0FaDe3bXh1dzZy7EP1GsJIPzb1Y2s5WcwO0ckEpDf5iSUUEFnBr+tKiOeG+ks/L401cx5vFr+BfE2rGSViB+gbWVi9JbbZpcDMRkjWZh3IO0awDjRGpkbM0ilXrSbf/oM5i0xcJYHLKM9C1jGMm1SPsQxWfjn9xpCq/uxX72Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12290.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUJnT0o5emM4VXdRbjJ5R2M3Sm5KaUEyRXhoYmtjcTgwMHFnaFN2Mkg1aGpm?=
 =?utf-8?B?Qm1XbjF0MHRSUjh3SEo5alZleFNza01saWR0aUJ6azg1bCttMDN5TzJkU2Nm?=
 =?utf-8?B?amVYckdwbnZqWE1TWGE2WDhzLzNTeG80a3owazc2STArRHJIQi9YT1M1VHYy?=
 =?utf-8?B?ZlduSE9Za3lyUXFCcFhrYmlyd0RmUUNYaEFPWVdlOXoyem9LckJ1aTIrdmE4?=
 =?utf-8?B?RVNVUE5yY21lN1lsMnFMUzdoeVNQalRzN0lYYk4vU3g5YzFJa3pXYlkrRjZh?=
 =?utf-8?B?em13TmxWcGsyN29IMEpOd2xvS0Q4QmJvWmlidWw4bFE2QmhXMi8wekN0VWM2?=
 =?utf-8?B?SExRelRGYmdOZjc1bGs1Y0lmRTlVUkVHRlF6UjN1OWRHekh4UTMxY05EcTV5?=
 =?utf-8?B?ek5JLzA3QkxKMjJiM1hIYTZUN3JnZlVENnNGcDFGZXVZeFRPRVVDU2liYTRo?=
 =?utf-8?B?ZlpzM1pRR24vUmVVVjVoVEJITTN0R1p4aC9uN1k4RGRaZGUyVzFmcURUbkpx?=
 =?utf-8?B?d2gyUlk1dXdMcWdEOGZ6SEFVNUcxREczK3BaRy9YNmRaa24xVk0wamszT2pV?=
 =?utf-8?B?NkthSEZ3N25aRDdzd04vTzhTZVRoY2pSL3Jxb1c3aFJ4OWRuZ3FFYmxiTk5w?=
 =?utf-8?B?dWkwUmdnMGNycytGd0Q2anFIYWh4QTFpdzA1Y2dVN1RFY1p3dVMvSEtPY055?=
 =?utf-8?B?RjY5WHVWeFlmSTBuaFV2TitRRXc4SzFXRzVBOUc2WVVTS3pudTB2eVJMdG9I?=
 =?utf-8?B?Q2Y5ZEVUTWlONXJTNXV2amlSeEtTZkc5Mjd4bmNaVlI5TjlCYjhRZThvRnc2?=
 =?utf-8?B?c3k4Q3kxbXErMi9aTmhxdE8yR0swdmVHODN5QWw1eFg2OEZLbmozZzBRdDJC?=
 =?utf-8?B?MXh4OEhETVNKbXkwUGd1WXFNdlBReDdDQVR5Z1pwMWF6UGZXbHlKdU5oWUor?=
 =?utf-8?B?UzlPdEwrREQ0eDVIVEp5Z2V0SGxNemsrL1F0dkxVaDVsSFVRZ2p6ZjdCclV5?=
 =?utf-8?B?V0h5YU15a3VUVU85ZnM1UUhVUFhsYkFHN2d6MW1YQkEzZlUyTkI0WmRFY3pr?=
 =?utf-8?B?ZTl6Q3gzSkVkc1J6aStEUmJoNTFMVmZDa2QvS2g4SVJwak53KzNtU1lXcEow?=
 =?utf-8?B?ZFJMV09qT0xJaTdaNThCaS9CazBOVllxYkl1cXZjMkFKMEZDSFlSUHVrd0JV?=
 =?utf-8?B?TlMvYWoyY1Vvbk1qWjI4KzBWRDV3bUlITHZDd1ppTmZENEcxd2VCWGJITlky?=
 =?utf-8?B?YnNWZVhlMHMxYWFaNWFIQUhUdnNKeXVaeVQvNzZuMkQ2ZnFRclFNOG5vRjk4?=
 =?utf-8?B?TEloVkNxN1ZnRkh5N0laSUdVeTRlZ0U4b2JRdnNHVVF0Lzd5eUVYNVBOUk9X?=
 =?utf-8?B?bnIvYUNCZWtLYytmcXd5Z1dhMU5IYXkzVVZvMkQydGRsdXk5SUY2cXBwREw1?=
 =?utf-8?B?UFF3RUtSQ09sZzA4UitXUFBLcEhhUXFqSElCSUdCS3h0ZStFVFI1Q1pqTVY3?=
 =?utf-8?B?VWZtb1p5QU9abXVkOGNjemlmTEZZa283V3JJSUExWWQ3TkRzQlhMMC8wVjd2?=
 =?utf-8?B?R0R5S1Vna1dDWERTK2YrdndvOUgzajY1ZHJUaFBDdzRFSE5RZWtaUG9sbHJO?=
 =?utf-8?B?MThQeDAycjN5cWZ5dlV2aGZLZStKemMxakVnd3VyaVpKSlRpeXRlaHNQNjlN?=
 =?utf-8?B?V1B1azZJSU9pWlNkNEF5Yjk3VjRrclNqMG5ibjQ5UzBBdk5XOWVyeGppRzEr?=
 =?utf-8?B?V1FINkRYZ0p1M2RobHJlUDNpeHpSYzA1TmVxNGlOdHBSRVcwV0QxR1FmSFgy?=
 =?utf-8?B?ZTVOcjR2SlJMNnJoWDE4c25vNDEvZnErM3JtL2FNNFo3NHdzdmRQSVVVQ0Rx?=
 =?utf-8?B?M0liZDJKL2VUbkNmeWdaaTQ2RE9RSDhyeGxZYXNKRW1xbWJMb2J4REJwY3Ew?=
 =?utf-8?B?ZTNWd2xqYTlKYUkyNXJ5ZzgzdURwSlM4UG1ROENhWGNUdWwwaGZtWDRLZUJa?=
 =?utf-8?B?Nmd5bjQ1cG4vYS9JM2FYcWlETVI4VDI5Zk00UTNIaUhZM3NqY2pPdHAvNEM5?=
 =?utf-8?B?Y1BEdUJlblZBOUZVQXN6VlRqQlJ4Sm5uZFVYQ0IyZlVQOUIxd1pvSUloVmVx?=
 =?utf-8?B?TFNTcHVqbTJLT1FqbHFjaWpSNzMvQUZvTXlTL2wveU51a0E0N0pwZ2pQOTd2?=
 =?utf-8?B?bXBjck5vVHB1V2Zsa3RlUk1zcFA5Vnhkb3lMbHU5VjZLaSt5OFArc3o0bUEx?=
 =?utf-8?B?ZTN0b3FQenhueS9SbkFXNFRFVW55TEdRSnlhTmdkeXJ2MmZYMWp6YzVEN0wz?=
 =?utf-8?B?bkh3bkZCM2FETGdUeGU1Snd3UnEzdkUvdkZ5MzJWWVdBZ0pEbGg4Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa2968f-8139-4538-ebf3-08deebd7c01f
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12290.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:08:20.8516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0Jo9jLc7aHwrFf1Tdn0wlHAjRpaIIpMHnJjQ20nDv0aF2xS09433nBquErIm3+nARV/Vx6zn7oVO0gJvIbLww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9563

On Mon, Jul 06, 2026 at 12:38:08PM +0200, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 6 Jul 2026 10:34:43 +0200
> 
> Scope-based resource management became supported for some
> programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
> See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
> Introduce __cleanup() based infrastructure").
> 
> * Thus use the attribute “__free(kfree)”.
> 
> * Reduce the scope for the local variable “ret”.

Please don't. Let all the variables be defined at the start of each
function.

> 
> * Omit two kfree() calls accordingly.
> 
> * Omit the local variable “size” (for another memory allocation).

Please remove this change, not related to the intention of the patch.

Ioana

