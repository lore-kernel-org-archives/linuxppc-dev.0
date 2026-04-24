Return-Path: <linuxppc-dev+bounces-20069-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB85FE5205
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 10:36:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g28Wt5fmVz2yhD;
	Fri, 24 Apr 2026 20:36:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::6" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777026986;
	cv=pass; b=Y7wInzMgvVzgUb5sQrfMUfTiwiE5QGnNsb1EGW9jkrkIo1oFsT/yjvVGi+nQChDZFAHi8RTyF2HohxOKUUQMrzYtq/lxjYHzOuR05JCW5LBBzfCZbooxTNJzgjQeWQ//KSvVHLCupW21ogqTEIB3a5gyNvUYu5UiiCuOgS0qd/dWY5WJbrvu6yEOZnF042kRqe81a9Lgqz6u81pwX9vD0FQE9REFKd39VdHZF+f8Ae5fV99rUB9es272Byrr348IoPMzcEo/98UlBUXMjf53H2O/w3cLJdvNlHgO48dOJihzoZM6003EdbYpjaWw02REnRC465RumdneJyYg3K/0hg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777026986; c=relaxed/relaxed;
	bh=N9rnxdscyXrArQLu/RfkR9AqJ3lTg3uyxcKOLiWS8u8=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hypw//E8Dl5sm9JPsUgr5DpdsZ12ggFEL6Gw1kgi2f/FmjMFO4q/Ses5pSb50hjryUU32ISi82hW1kJNyHoRCWLhrElYzeoXxrUlNttzUdIXbi7cJBRyapfkyt2dias1bwO6kKP+avV6BiRZ0U6i15M/8jeSMINjWr3sgRwx7msZCZAkHEEDsaVhkVxfl/qM9xSA90yfh+SnGX9XN5QB47id8yYEb18667oLHen2XFjzfpC46K6VD5nMmr6/SQMZVBt17IdVAqi294E4pPfqmCVeO56iWDAAAsqZatPiLv7DTuplYyta7rF2EjDJou8CUAhgFov8rwCtHluxyz8QPA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=C3nn3oue; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=C3nn3oue;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::6; helo=am0pr02cu008.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazlp170130006.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g28Wr46yHz2ybQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 20:36:24 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0XltIIylPsKzgQhvfWDqIjloFn3vUd1ybNnVyObKvGeMIoOxjUoCEUkvsm3B0W3pHXiSpA4wV27UCExPrAvr+UvSb8nQ1xPjtE1KJmqnDE1Z3n0uWlnrXPmkNJ+xiO185gAhXxu6q6JHDajL7VU0Tqs3jD97MRowE7Pc9A+04E1P4kP9Z1z+WMQn0u/mt3Huc16GgDFZM2t2aJL/JHcOZ4g66DfHXcZ9zzbTBK8sde16gYugvGegVF9Ev2RsDRGszKp6G4F8WS8+/aGNXDfhpHI9evWanSwSERTsuHo85BJn6ORdPJyYyp6ppCSqLJy/04dAozRnv9TcQHbGpfiMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9rnxdscyXrArQLu/RfkR9AqJ3lTg3uyxcKOLiWS8u8=;
 b=SQsV/4dkB3RUkDsCzd3LR9IP97sfDNwS+atKt/W05a054DmzC41uT/VSNHHYKKkqhCjEpHPfiUGVm0m9yLts8dWhCEprYj6EoPmrysJ3UaL3CwFonH93Je0sBg9skdD1aK8Q1NxcK4vcu1+gNGM6yvkNmdqNEIzMicd2y0cPCrJo7WPWcyMmyTx9xPPJUY2cIp6QyaTNg6bD4Pjmo3wxNuyZQBUslxlhYdDk/zQxJ10SXif+Tpot+0SSXlBs91O21fhTuaL2Nq8a1CnMWMO94rR/RtcssCdD+WZAh/nBP2eyLdUmzOxaC6HtTTFvDUVDH4/KCDi7vupqGxod8tCGkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9rnxdscyXrArQLu/RfkR9AqJ3lTg3uyxcKOLiWS8u8=;
 b=C3nn3oueS/Qa5yprW9tZ4PSNLOF886BDWYQjYSfWvtTcWeZhxFILzWbKVVNnSd7aP+VCMyk8DuDnk5Sx9NFsepf3RDuvXQ79WqptJV7GiaxhhRLblCZYoi4HnHfzgKKOFr5f2iAleEB7FQsaa+pHmfqXrnclKojfZZ5oqOC2Z0OJCE0zMtZpzi1RLZcZvMJ7h0xr5Tx/yprS3VUUIhB6WqtgsYDICsq7cgNRa3TZuf+l48zEFm7MoNBsgHlh6kz7kfuhJ1BW2ZVu9lrrl51wNSpsOePjOUbJnq+Dd9gz+AI9igU2q/2izV+ldos2ANgAAy6x6z3JiSlhwSdz/W17iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PA1PR04MB10698.eurprd04.prod.outlook.com (2603:10a6:102:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 10:36:00 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 10:35:59 +0000
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
Subject: [PATCH 0/5] ASoC: fsl-asoc-card: Add some improvements
Date: Fri, 24 Apr 2026 18:38:01 +0800
Message-Id: <20260424103806.2276780-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PA1PR04MB10698:EE_
X-MS-Office365-Filtering-Correlation-Id: e52a9524-53cf-47e1-8155-08dea1ed4670
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|19092799006|366016|921020|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xxBPHQaC71jcf0QQ/c4nd22J0OttnZYKRv1acQbKzJVZTOrMdQ6XTb8oYW8r6nPGTFzSy262ky9TJALY2eDhdmSzepnz/XERx6fzQGLbpqZErtho6WN2HQV0yvx3IhY08JDgJnSAjkJFo8S2nxb6pSHKLRed0Ert0XrZ4vDHxuyGPRfzohWEll8xMdj16TyUqz5Ek2lU82c/Z1b2cb3grKQ7smq9wIroWpGjtZDZae2WcnpQc4iyglgKY64fCX+s8QgoysXefG0D7Q53BQYxGyZRS2c9KgLtynnr1hPdYwJwsX5mw+5nKoQ5i3l9RLMpoRNB88ASoSt2iwiGggGa/CJFCzfjhKaL1fSwHs8vbWfGVr/Pvi7dB33jMxEKX6nGW8B+QFlck9PWTscXb6bMGlCQ9VKLWgLN0km+Y1f/+yeG2egOGYbZXCOey9x1VzYPAWg/MK/e07GgzTOBMeQbnKaglyez1hmftOHJbKZOJirqVYkmhose0C7Z5b7wEtQyLR9ODcIW3Cn41kCtGvh1hI/s3bwsu4J+GBxoWUoOgt+N2TmQ9lRzXQgs1xyXJQgUTrR6Dqt1X8Z7r5bHUiQvyARYL0dDz4oIw+Dg/qG6yG/rF4IGfnzzK6YL4cjd2jNErUlw1BHx7bv37I9w5eeismPORahqFRKaZ8mRNMKW1ZIpJLjaxBJAIHS1UJgpPQzs6ydijv4PF/jIIXsiuBShdq8eFZS3k6/JNxrhqIbRy7q3hf5XRYq9EosBoYVqTmvYFty8BGar27aIAoZoPEiHBEeugSwuOLtuc+cqUQwv64oSI302OtnBFhNEpDUZBs0d
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(19092799006)(366016)(921020)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVVWT1I4Z1QzeE14RTluSjl0YURLQ1dQNUt3YXB3RGdCN1ZFdmpjRGhjM1pP?=
 =?utf-8?B?Ni9LVmQzYmNZZnp3RkhvSml6UjkvVFZsRnNJc1FEZWVneFl1eDhYSXlaVzF5?=
 =?utf-8?B?VzVhdDdmY3B0K3NqUjFPZkpuQnlnKzFlTXZBcUZSZ3M4UVF2NFphdGw2UXkx?=
 =?utf-8?B?QTg0Vzk0c2lSRjJKUW5lcThackFPbnhCc2QwNjFqUnhkb2ZWcHllY0FGZjJR?=
 =?utf-8?B?TXg5LzFid1FUWFBta3lDSm5GMHZOZ0d0a1dONHNNRHpSR0NmYWRrcForSnR1?=
 =?utf-8?B?T2pwcUIxK1dXT1ZzV0cvVmpDakxnUDkvMC9nOElkeXEyZ1ZhUkxXTnlyb01Q?=
 =?utf-8?B?VmQwZTZSbUhTUXdrbk9DNS9DRlhaVmNUUnhPT0Vtd1J5S1JTekpYQ3owN3hS?=
 =?utf-8?B?ZDlZcGtmR0haaEJTZExlYVlvU3M2SDdkUDZBNnZ4SEl1TXFjNU93a1lCT2Iv?=
 =?utf-8?B?RkhkbTRzUEJCeGJaSktCaVpqZURXL3VPREExQ2paekhxWkdlVzNIb3A0L1Jw?=
 =?utf-8?B?MkE5TFZudU0vMXFIZkJWOEU0Mk1yU1IybEF4anlUOEhpTCs1TzB3c0F4RjM5?=
 =?utf-8?B?N29Ma1Q3VEd0cFJhUjFFbzlMNkdDSnEyNnI3dUpremRORit6SHlIaHpRSTlO?=
 =?utf-8?B?YnN3NmZacldSYTE0eUI3ZTNTOXdKMHU3azdVMFdPUVc0V1pDWFNjLytqU2Rp?=
 =?utf-8?B?TFNYWHlGa21yYzNQV2h2S2tQbm9oUFN5VkVzQy9ZT05BNXBSbzdDTW0yTUdN?=
 =?utf-8?B?ZmVleEtmejU4ZCtOVE1Gc2JRRjZoMnBDdk5EMEcramJJcDBHaVBRWHhsK1lo?=
 =?utf-8?B?Y0pzVnVHQXNPRUFSREkzM3JrUkM1cTNkcW9tWHg2cE10SGYvRzBKK0JXY3kz?=
 =?utf-8?B?eDMxbWIyWVE0alVaUkRhK3VVVXU5aEdLT3YrYmdyRmZxS0ZQamVPdENENHE5?=
 =?utf-8?B?d3I3T0FMQWJTVWUwZUhmRGVkTThiS1ZuTFJSOEllZ3ZZWC9HSXBjWlFNS2Zl?=
 =?utf-8?B?VlpqcThZQjByblB2TW1EYk04T1RPNkw4ayswUi85NXVESFgrQ2k4enpGMkl6?=
 =?utf-8?B?bmw3ekdqK0ppNUhKcEIxUjk5ZE42dmRXRGtRY0hUdGFsWkQvbjNGcjJaZWVl?=
 =?utf-8?B?TTJjd3NPOG1CSVJUaFo1OVhsb3g0RTU1TEVzQS9NV1JYUE14cHBORm5WcnJX?=
 =?utf-8?B?Zk83RHBBb1RsV0dzSG9kMVE2VVhKODFrMllaZUJKVHRwazBTaEx2blBBVXlh?=
 =?utf-8?B?N0huR1VWQmV6QUhWVmhzbElveitMMTZSc1pzcUh1S1BDSHNKSkpndDk2ck51?=
 =?utf-8?B?N2tacVJNMzY4cTBuMk01ZC8zWWhDTitxdE90VExNelBQb2R4YmR2Wk1WTXFW?=
 =?utf-8?B?K3pWN3Z4V3RKcDB2dTluOTFQQjZOSExHZ2c0aHNnRGVZUWpBOUVLdGNnSlFZ?=
 =?utf-8?B?cnNaUjNGOFhWOWxTY2JSb3Q1bjAwMmEwaHh4WFl3RmtDODFHZmxFZ2ZBdFFs?=
 =?utf-8?B?bTh3K0I1UTlnalNndGxBMnFDdFRiOVovcXZOUWlYZWl3bWhTZnYzUG52Ymh6?=
 =?utf-8?B?OWxxaG9UUkFMQ0xmMmxST2ZZSDNKem1RbkdEM3VtdjJVQ3JpSjB1RmRFdlUz?=
 =?utf-8?B?R1piNkliZTZ5TmQrMjdGeGJSMUhRckdpMXJFRWU2Y3FyN3lwUEcwQVNiSkFU?=
 =?utf-8?B?ZHVRdktQSmtUaWtDaFpnbVY1NENOdU5pdittMjg4Z3RoaFFDdFhZRFh1VG9T?=
 =?utf-8?B?VTBXS0ZWdFlJN21YZGFEMisvb1o5UGRVM0FtVHlLRDNYOFh2Vkd2Y2dPcnB5?=
 =?utf-8?B?SGdjeVFkUzh3Y0E2dEZFZ2FvRm9SUExUWmk5UW50WXRnMDRaajZVZnZySEx4?=
 =?utf-8?B?RkE4SXAxM0IyV1BucGs3eDh4SnhmSkt5TkFTcSs5ZkFENDE4alpzZGRGcCt6?=
 =?utf-8?B?K0l2S3piVkhEa1c5SkozTlJRbUV2Y0ZRb3FYVm1GWXdZTTNNeWx1V3hzdnRz?=
 =?utf-8?B?Rk9hN1ptWlRncTlDU1M4a05sTHFiQVU3QVRRVkV6U0U1VUtqN1VXbStLeWlP?=
 =?utf-8?B?Y1ppblZxY2JDeVFmdHVydE4xSlFuQjBDbjg5ZHRCL21uRFJFQWdnMGdjQ2FB?=
 =?utf-8?B?aWdOY0dWemJaYWp5NWpkcS9qT1dROXNZcTB2ekExdmRCQTh0Z0ZPYjNXY0pL?=
 =?utf-8?B?cWd0KzZuVHNyNUxzTHFGM1BWbU5xaWNnbjlDSzJxczl2K2IyQlBzRDhoc2N5?=
 =?utf-8?B?MzJvbmNnaThDeklMN1BzVUp1aXQ3bEtEMG42aXRkR0hUcFdQZENUUVcrWjZY?=
 =?utf-8?B?ZytJT3JaTnRab1RwazU5elp4b3REejF4dCsvOVl4a1R2M29WTWNIUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52a9524-53cf-47e1-8155-08dea1ed4670
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 10:35:59.7702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8QB8WT2c1kyfe3KcVkaBwCezR/d7Gxo3iOVRDP1/RoQ6V0dqCHanrJHUuGtjoh39SLY21vYB9UaRVuxfwpy2pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10698

This patch series addresses several issues in the Freescale Generic ASoC
Sound Card driver related to hardware limitations, DPCM path switching,
and codec-specific constraints.

The fsl-asoc-card driver provides a generic machine driver for i.MX SoCs,
supporting various codecs and optional ASRC (Asynchronous Sample Rate
Converter) for sample rate conversion. During testing several issues were
identified:

1. Missing channel constraint propagation in DPCM mode
2. DPCM path switching causing audio dropouts
3. Hardware channel alignment requirements
4. Clock generation limitations preventing certain audio formats
5. Codec-specific PLL frequency violations

Shengjiu Wang (5):
  ASoC: fsl-asoc-card: enable dpcm_merged_chan flag for ASRC frontend
  ASoC: fsl-asoc-card: enable ignore_pmdown_time for ASRC case
  ASoC: fsl-asoc-card: add channel and rate constraints for CS42888
  ASoC: fsl-asoc-card: exclude S20_3LE format due to clock limitations
  ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit

 sound/soc/fsl/fsl-asoc-card.c | 88 ++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

-- 
2.34.1


