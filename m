Return-Path: <linuxppc-dev+bounces-20268-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB45FF8877
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Apr 2026 09:59:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g5CSL0Nygz3048;
	Wed, 29 Apr 2026 19:58:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777456738;
	cv=pass; b=lPggNepefP9qJ8aNHOPuW4gPlXohtZk5Lco4IGxL7GDrOk2qtUIFhSEyKK1lErCF5JQGeegEozbdLSp8HclKyCDb6aISErjTNnIxDo6QEjOZhElyAuQp1FnxVRdsq7ecPdLyaJkGmvO0x1bG2RtqDuu1otJGR8Pr63SGm/8DrZRUH/KmNymVT44mzWYMsbhuexbdaMr79LrcoYEcSDu94Sk6Ve79CH87T3ODx0U9HXiDDJegEWAk8Ou0ebuFgePYQ1/wbx+FYuDukXC0VRPo0uIi0+76iHfy7g79gC6hpF3dcPFOl+TVkoibWfHEqFYx5G/6zBpbCJh0w4cvLY57dw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777456738; c=relaxed/relaxed;
	bh=t0Qx/JKN7UCYKtrFKJOHk4u2zJLqGN6fxPhI9K+8mX0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAURmaLrY0+xHcCavq6fSK6cNTdaOSLIPkREO3DyO6Z0UgLXov5YQhjSbBBXW63tV9EhiKd5CYzcwW7t9ALLB1Ux6dSZbQlYtPyCq3gFQTxWwpH0zOVDxn3u2QQgMNdCpPeuAhH1mldBQGiPE1Xnm9tjhjCx7S4RCTQezc+4y44iGx4Y2wd1Vor1tvQNVaruezzWmD6bJWDbP1BYuBe3z5TroCjyzwdaO6lU2osiNvtRNgTSyFfUFymeEakn5TUVSjXI3cVIW2BGPc+aw0/lencu6ILTbAKtMWbxUHJkH3O0FeytnXIKvz2o7er2EGGWptvdcX/nsyqp5x1vBNPuzQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GlPuKi3x; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=GlPuKi3x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::3; helo=du2pr03cu002.outbound.protection.outlook.com; envelope-from=shengjiu.wang@nxp.com; receiver=lists.ozlabs.org)
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g5CSK2F4cz2yyy
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2026 19:58:57 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA4nUr/ph4QUs7AVr1M4qN4KAyIYwq23tSrMAPUTAGBv8p+PZnj8g300lJiTjfTulebe5Rde0oCEeDTIZfKoDIMCuqtB+CVPOs+QD9frneUaGwrs7u5fnibRII50P5ifqLFjocy8O4qkfkctfel1bEDjOMswKb78atr3QUL3GW0FR8/Skf8rK5kT4zv+ZtAiKaLCrzwv1yKytv6wclHyUhDQ7FyJ/ym90dQvTGk0aFl11pF0iXyu8EhnSVE50ApGvjm+c7m4Avb+Btkr2EYOG715gWAq58J0OAmg8aVlqN75oNDc9IFZJpETWxTqxFXuIJUbkBNPtErDLrE6vHyUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t0Qx/JKN7UCYKtrFKJOHk4u2zJLqGN6fxPhI9K+8mX0=;
 b=wNqiNYtcSfVVVqBJIJyaE5in/W/2j21sxBswD8J4EiDKVlVBhXYa+CXCBfRE67Pn9y+ye9WtBa+LJJERu6FYAOXD4UNwo5OGMNQJUvZczaNwikYbRW9dx1tm0eBFOAB/XJ4uximwkGNjQhApMOYyQDQigRqwAfNVzC4v3LVHyLibySD5mQ+kt71zcdLuih+BmX/JtSs0GIKp3tXZAB1g3my+m9HNDV0uNMj9IXcFHE2uaFfaboFRx2Wd7uF1r5iovIhNlm3npmT3qVZ+1/W9xHJTafvNQpfCvlwG6/tn5XaYIvkKnGuUFdng5/JsxoVaH+Xa/wiuvqRnxXCzlmMKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t0Qx/JKN7UCYKtrFKJOHk4u2zJLqGN6fxPhI9K+8mX0=;
 b=GlPuKi3x/68JVOoaEANKnr97hBvhMG0sqh+vGYevVwCr9JYx08zdO4wyOuFetoEYZfZVvbcNdGTwXknJbRqOtxJ7iTv5jfP+qWndd0EbSDe8AyIGHkwo0p5w3o/aF9rCkqW8AN0hPn1L699Ht0QQz4XgZd2VjTbaodRydUTWXgZT8lToc/1H2QhZgaHZBVs5CQhV7YSx0CuJtEfI0853tT3sq6Rfpe7sSY/6BTHLk1lVE4DHjFMjaZW+U+pFaQL08Yfo3NSvIPahzvGnSwRKr5Wm5ojeMszNasoeoUrNuqCgRqkV8fqImwdVDpK2X2VLXp5OEoBp6plNh3mh/0X9LA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8269.eurprd04.prod.outlook.com (2603:10a6:102:1c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.19; Wed, 29 Apr
 2026 09:58:50 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 09:58:50 +0000
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
Subject: [PATCH v2 5/5] ASoC: fsl-asoc-card: reduce WM8904 PLL ratio to meet frequency limit
Date: Wed, 29 Apr 2026 18:00:27 +0800
Message-Id: <20260429100028.2739711-6-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
References: <20260429100028.2739711-1-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
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
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8269:EE_
X-MS-Office365-Filtering-Correlation-Id: 68b85a09-15b9-4349-f0c4-08dea5d5e98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|7416014|1800799024|56012099003|22082099003|18002099003|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	Ll+egqkJjs+4totX7qTYygz4sAxodZPoF6gQOolZAapW/Pmp345Y2rftBrmxZGJTgEiuDj5g9dB/JgllX90R5ZET+wE7597Z9jf23ODHq5/n3xedcIv+fNpw+2UWm5ojY6sxJaLMNeLpSEZ8mkwrKce8cEmmZSSQJZJnig80/dlyGwAY7blWpGIWe99wHOM9wbkWSFgWvWv3sbO9FJfjrIXeIlvC4Pe4CFgYM08cxvJ7/Zari3wBabXExRNNMP6n9bXDdvf0EaN3A3o0MiL8y8LhdGXGNW3oPnu1ze5mmhA76EpqTq10uRqb2Txw8JNAnS68edCkNgzXTZauFXYAFv8/k6L/QTI40nNOi/zPW50sBOuqIal+wrN2wrJmyHaIsfbXgy7rvBpa2y8R1wto+u21p3rwJv8leQj4+1C+MMvC5wVF+As+aR1HEhdOCmUyKIRUfb5ZhQqtUTRsy5ugfkDuOUvbld6R1iDVqFJ2TefBQ9Bzyq5hbF2LKw8PB9IL7MH/Lt6Hc2qpSqRgrNiO5he39G20S0G0x7ceuJLQozC0K2VIIUCPgC5okfKC0symwiqUvUWYz9YOmzVQ69beclBbZhHt9zZuybKT9k6L37LhO11NyyPHj7MAg99+9W+md0r/BAPwRbsGAoBEsZYDIhB43uWNNdlpjXSGDNDotr/nVx4rWO9CwrkgY855eDkrI8SlOS6CmBo1U+PkVz81Yak4KMcvhKpjjm3bik727YWOixY/ChWFHTLh9qOWtkaR9U76pT8FCK01+yYwyNDzCv7Ik9UlOgPaKe2m3RDVb7PXx/8T3KQA6pcKtHgy5CiA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(7416014)(1800799024)(56012099003)(22082099003)(18002099003)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OC9Gdnkva3VxYjJQMEMrWXZYcUdhNHkvZVhHL0ZJOUM2bFZBZUV4aHNoRlUx?=
 =?utf-8?B?VXMzZ1NSMGIyVnc4NisrNnQ0TDFYVStkNkQvQ01XcHJGQVd6c0lDckhmV3FG?=
 =?utf-8?B?RmRVSE5XZENEZ3RlMmJtRGZ3V01LdWpIV3V2N0lFOG9nWWVrVzRwMTRoSU5v?=
 =?utf-8?B?KzNoeEs2YXZsaWhXNjhxb1AyTHYzRTAxT2phM0VFUVNQZmZWbDZqZzF5OElq?=
 =?utf-8?B?WFZ1MWE1dE54bkV5U2lDeiszalI3M2puU1p0OXRpNmhLeS9meWx0c0hMSlZ4?=
 =?utf-8?B?M3IvYjhRY1djRGZCL283dEQ0NUJHNUgxWGxCUlBlR29ZcXZBL1J1SzIwanMx?=
 =?utf-8?B?ZmdIcEJ5ZjBQRTF3cm1BZGNPY09za0lzZnJUVGw4bmNEdUZvZGNNeDN5MW5j?=
 =?utf-8?B?QWRhc1MzbzNzak1lK3pZZm0zUnVZb0RtVXVROWkxSEtxUW1JcC81dk1ub0Vq?=
 =?utf-8?B?NHdSb3NVTDVRdnJrVTlVaG4xK2JabE9jcUlOQWlvcnNRYnErbkJVYVVVa1Fl?=
 =?utf-8?B?M05vNnRJam4yZzBUVjUvZGRzNzJmeVpqSjYwL204TS9IemV6L3FkYzA2eDVj?=
 =?utf-8?B?Wk15RkJuTllSSjVNcmJFL2ZneXd2eUkxS1lyMUlOK3M2S0RxTWhjaGhZQlh4?=
 =?utf-8?B?ZUVPdVhTZjFOSWpxWWVlS0N5TEE0WjJ5cXZqYmF4SHBnMUpjcDNkMFJkNEZR?=
 =?utf-8?B?TlcxWWFhRVY2SHVUUUZDSkp0Vm1rejIrSW9oeWM1MlVMRklDSjA0cm5BaDFs?=
 =?utf-8?B?ZnFSTFpmNXJ0SUxGM2lxWTRCMjE0NGVpUmxqUnVBSVdCRWQxUVhxek9GZitP?=
 =?utf-8?B?M3AzYUZQYklEZmsydm45dkNBQndKcWY0c21VaFZiRk5IVnc2dTZSY1ZyaTl5?=
 =?utf-8?B?VzRQTHpqSnNxNXZrdmZqTGx2YjQycmdZS1c3eGlheFh2eHVlMTdDdW9mbTRv?=
 =?utf-8?B?U1REYkFxeUFQQnlFUWIzK0V0bng3WXJ1QmxXNTFNTFhKZUlVTlVwenRpMGc2?=
 =?utf-8?B?dEZoVkwyVUd0SUFBeFA0d0Z6NlNqVDBDUjdDcTFDZ2hyQmlZK1ZGZDUzeFJI?=
 =?utf-8?B?NlhRcFFOT0R1bnFoT1dDU2NncGFnMGwycmRweXdzWit1akxSWlJuL2ZjdDFF?=
 =?utf-8?B?RWR1NUdxNDlpMGtIdzNhMDZvT2Rod0ViOTZVa3Nvcjk5YWN6c0VqTFFVMUxF?=
 =?utf-8?B?dEE5VUJadHlSUVFjWHBiMytpR3lZeGxGT1JGUG83ZkRKQlpSQjN2ZkpNM1Ex?=
 =?utf-8?B?cjVoYUN2cnpGWjd6OFhIR2lUUVBWUFpqYUIzS3dQMEVFZjRIbzMxejlZaXlO?=
 =?utf-8?B?L0grbHVTOU5adCtTdENkdGFSbURHQk9hWGtYS0F5WUhPYVNHT0lFcnVhek0z?=
 =?utf-8?B?N1lTYW9iUlJSejF0OExmVTEyeUM4ZE84dXRGcStuQkhqQUxSOGp4aVkxVmcv?=
 =?utf-8?B?NSsyVGxtcU1CaFg1SFhZRW1URnlLYlRpeEJGeDBoOEdVV2xzRXVTRDAveVVO?=
 =?utf-8?B?YTVkaCtQcDBWcHUraDFCNzZvdDJESmZvVm5MRjNMQzZRbUU2ZnppYWM4ZjlD?=
 =?utf-8?B?eWhuTWdvNW5NSVpwUXZzbXU2S0YvMzRab1ZqUzZ5dEJNSXNxZTF1N1Y4Z0xF?=
 =?utf-8?B?NTI5R1g4QkZQVGsrNWExL29ta0tod0FKNlVNSHpVQ3gyY3hibFVsTDJvM041?=
 =?utf-8?B?V2NrM0xaajI4T2ZoUHBRL2dvWEVHZ0hKVG1kUXdmWHBpbnZpUDJreVlzMVJL?=
 =?utf-8?B?UmdMbVpSQ2J1czBFUHZjeDF6Z0xKdkVLOEpjMm1WOHdYc0JBYmQ0WHBOWHlV?=
 =?utf-8?B?RFNEWHhFeEVTSmNqNGtkMTk3em55NGFQcTluUHY5bkVXR2tJV2haK0pmZGV3?=
 =?utf-8?B?YmZoemdEQ3M3aUN2UlRHYThBdzNzc2hRMHViYkVjNGxJRGVuMWhJaTE0YmJP?=
 =?utf-8?B?NjMrekE2UTRxUkhFV3BjcUphTEIrT2JaYktzcW51ZzBOSVE0ZFArN25UWXBT?=
 =?utf-8?B?bWxBVjNqRVpUN2FzMjRyaGZXNFRsZ0lTK2lONUE2c3V1cUlDdFJqSHBjUDI1?=
 =?utf-8?B?ZkZQOEhUNUQ3ZE5oQ3FzL09KNEhBREYwcTlwM1FXbzRjd2ZFSGlFUjRNa3Vo?=
 =?utf-8?B?U2NpN1FIZzREb3hMbCs3U2lzUjN0SEpSWmhYV3JrTmRXcnp3S0RBOWJGT1BK?=
 =?utf-8?B?UkpLaGNrMjN1azBIVENIZjlxL3JOZHVlSjZSUEVlMTNiN1l6VGdSSmFqd3hQ?=
 =?utf-8?B?Q2l3SXBiYjg5dmdnMkJwb1lDWGF0OHJ3Q2FCVldPMlA5RXhkUHp5NXNaQXc5?=
 =?utf-8?B?K0JDai9wREtJcWZEekMzd0FGZmVhNGhxSlBWUFJjUUJXYm1xSWQwQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68b85a09-15b9-4349-f0c4-08dea5d5e98a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 09:58:49.9406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iM1fd8q2Oj90H07XPcIeNShPU8UfoslYVpNYVSoM3wPk/WFDdURstqh70yv0xjTii/ME0osIq8sTE9NRTle2rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8269

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
index 44083d15f6e5..709543308fe9 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -75,6 +75,9 @@ static const struct snd_pcm_hw_constraint_list cs42888_channel_constraints = {
  * @mclk_id: MCLK (or main clock) id for set_sysclk()
  * @fll_id: FLL (or secordary clock) id for set_sysclk()
  * @pll_id: PLL id for set_pll()
+ * @pll_ratio_s24: PLL output ratio for S24_LE format (PLL_freq = sample_rate × ratio)
+ *                 Default is 384, but some codecs (e.g., WM8904) require lower values
+ *                 to stay within PLL frequency limits
  */
 struct codec_priv {
 	struct clk *mclk;
@@ -83,6 +86,7 @@ struct codec_priv {
 	u32 mclk_id;
 	int fll_id;
 	int pll_id;
+	int pll_ratio_s24;
 };
 
 /**
@@ -255,7 +259,7 @@ static int fsl_asoc_card_hw_params(struct snd_pcm_substream *substream,
 
 		if (codec_priv->pll_id >= 0 && codec_priv->fll_id >= 0) {
 			if (priv->sample_format == SNDRV_PCM_FORMAT_S24_LE)
-				pll_out = priv->sample_rate * 384;
+				pll_out = priv->sample_rate * codec_priv->pll_ratio_s24;
 			else
 				pll_out = priv->sample_rate * 256;
 
@@ -815,6 +819,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 	for (codec_idx = 0; codec_idx < 2; codec_idx++) {
 		priv->codec_priv[codec_idx].fll_id = -1;
 		priv->codec_priv[codec_idx].pll_id = -1;
+		priv->codec_priv[codec_idx].pll_ratio_s24 = 384;
 	}
 
 	/* Diversify the card configurations */
@@ -935,6 +940,7 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->codec_priv[0].mclk_id = WM8904_FLL_MCLK;
 		priv->codec_priv[0].fll_id = WM8904_CLK_FLL;
 		priv->codec_priv[0].pll_id = WM8904_FLL_MCLK;
+		priv->codec_priv[0].pll_ratio_s24 = 192;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-spdif")) {
 		ret = fsl_asoc_card_spdif_init(codec_np, cpu_np, codec_dai_name, priv);
-- 
2.34.1


