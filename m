Return-Path: <linuxppc-dev+bounces-22512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4970FCD98CF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Jun 2026 16:33:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbp9b4n3cz3bpP;
	Fri, 12 Jun 2026 02:33:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c207::3" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781195603;
	cv=pass; b=bTO7orJE8SfOMnw2oSoX/MziTNus4vU0KRq/CTcVYt0u33CzgFVO6avUpJ9y8CR7+oZKfg7+oXYVm18gmQnyykZPdfh6M6pDZiabIENHRqilhmNDGCpxS0hx1Zoieb7kizeU00191TlYIm5YRPi3h+qxpa2izdq+UbxB/8pZU8HDlRCBMZqhaY+PZWqkidnyAsB5c2yIDpuX/j6YxfqhedvoKPZbg74eKx2r1SJXXacktgAtV+SB5CWtQhGmXFTWSY9+cL6KSagLDckNW5Y5MdatCnJKBp5bJUZ6VVDseqCUqe+rbRMbLR1VK/H2RCeRjpzeBJwTVX4RxQuuH3xJWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781195603; c=relaxed/relaxed;
	bh=nOUhqPlkgp8ctaPY65HpjcEhB0toKDx17yH4pD8u19A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TniIH5Ry4ytxngniUQBEjRXoS6zwQBlrXNOhADmTXKgcBwI8pIuQh6E2isu6de6DfH6zDx3sfINFlbbazc8NMciHPYwtkI22pUk3ik56ZTU/Ob/IytwUrZhrsae3fyAEm7Ag+miCrihS5s+Jtw/6CkLdT0ZCTUFosJb/xyhnymbJIh6AvWy9DB2hxaLLqPXZWbXhrV0rlsgvG7fUHlEGszcORsRaqNPDK4N9FgtV7gsBpUCNX4xrhjMHBoAwZrKbcYQ80KPUFaaX7KT6vgSwvojYGBv7pCEZjZoDlqObtOdZUW9ydbaJ7oWo03mKbKmiia7dy9BtxuE9/U5xlDatpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com; dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KNsgshoh; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=oss.nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KNsgshoh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=oss.nxp.com (client-ip=2a01:111:f403:c207::3; helo=mrwpr03cu001.outbound.protection.outlook.com; envelope-from=frank.li@oss.nxp.com; receiver=lists.ozlabs.org)
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazlp170110003.outbound.protection.outlook.com [IPv6:2a01:111:f403:c207::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbp9Z44bdz2y8h
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 02:33:21 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sn8bUlPpe0ECTLZpXtaGn4qWwXdHEgT4bPcFOjUw2mmxTpuajw4n6CPMaGN59q51Lb3xgYVQlIE+azNwAf/MeOG5eAaKz5q7pyweWcfRv6u/00PMX4IzgtQBv84DFlFIVvgyga55/jvMJWvKAoxW4Rgy7x2rnLvrfQTT8adkhcjBjd8p4IPYk11cslLBOstND2nu8HfhX0RVkqfgzVenfnhNnOltI0frFLdNLqdRcl4nGCFQDDZIhzQwhl7b3bcidte7h2hIt5V6cufRFMkmiYKA61nyKywn3ZGvwYvSlPzfX1x3nREJ4Lx893/s4XsHId/mg9RyLPkjdQOsQ7sDHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nOUhqPlkgp8ctaPY65HpjcEhB0toKDx17yH4pD8u19A=;
 b=CqCTyjreQupyXwUCiUTbjDy4A9Q1r61r37l018U2QSAqYkRR29E/nY9WPDMqilzXBT7KsLzMzeHHJO3V+ZV3D9PBH8ZEymQj1/V5I942bYNYlpwtybVcg30usckmc4ckoJui9mrWiizZ8BdS1cRy0bT3TyGdljoWf221fBaCN2yGuXCbZGp73hozp7/uX2b6outjn/TFmoxyR0gM/B+O8XNZn6p/zg+XSRODZlboiVJm2IgI0EAmEpcxR6dO3lt2sEsELQVMP28cN3tyHdbtC/Ba3C+T4CBP0vU43sQneQf3grwWnvzZlmSu687ZmWmghOmzgEzElo83y0lWWaLJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nOUhqPlkgp8ctaPY65HpjcEhB0toKDx17yH4pD8u19A=;
 b=KNsgshohi7P/VqDFsXVuhB+erOgi+UaXu/kixr926pd3Jz1a/IvNeYdPwWCLjOsvk2tKiXL2Z9YYDqMVrUVUjkmjrJZYTdWs3xwXP6A96yV8auTmPAoTnMkRZ79qWPbZYqW34PPcedAzzdd94EyErUeDVVZQ6IEE7MnXc7a7Yu+4Y+Q5YhWwDFs+RaAwXmRHVVPAw9fbbasUsT53owDx1+XHW4hxAVSorxg6ty8r7+huBTFImx2UCXlKo6sH+nug8OnM3nQWTpgrk6ezynNSHWUt7Ysb58v8aRck5ITYx90iHShZPgAUxgP6LvvZ7lzFisN+mF6REmi7L4OaLkofHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU4PR04MB10840.eurprd04.prod.outlook.com (2603:10a6:10:58a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.17; Thu, 11 Jun
 2026 16:32:57 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0092.016; Thu, 11 Jun 2026
 16:32:57 +0000
Date: Thu, 11 Jun 2026 12:32:50 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Zhang Wei <zw@zh-kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:FREESCALE DMA DRIVER" <linuxppc-dev@lists.ozlabs.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>
Subject: Re: [PATCHv4 11/15] dmaengine: fsldma: convert channel allocation to
 devm_kzalloc()
Message-ID: <airjMsF-YPGSt3-S@lizhi-Precision-Tower-5810>
References: <20260611035245.13439-1-rosenp@gmail.com>
 <20260611035245.13439-12-rosenp@gmail.com>
 <airV8Wm3yyY4hTQP@lizhi-Precision-Tower-5810>
 <CAKxU2N9QNMo9u0s_MfYG8qfiWsHqwuB9ax_qbf6gbxA0syOiaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9QNMo9u0s_MfYG8qfiWsHqwuB9ax_qbf6gbxA0syOiaw@mail.gmail.com>
X-ClientProxiedBy: SA1PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::25) To GV2PR04MB11799.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU4PR04MB10840:EE_
X-MS-Office365-Filtering-Correlation-Id: 53642bae-bda4-4cb6-67d9-08dec7d7184d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|19092799006|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DYO4ByGHjGRFl8miJ8WbwqKml20XXDabKDkotxlNqqcXJTOzkp+7G4z5h7G+zmIAUnlSXcDCrxanxN8x41Bl1ls9gk2CiNcEl5tSRltrFgAfrRx4/DBlybl5ZEHeYnY+aENc3E8LO0zsKASRps26mPuJdiJhqqwbmapgtpZW484uU4lYChubEaxR51wMyYPF6Rn6PRWnwYe2h2Buz7kD9OM5BMhi0ZfYnJ2mr11M4b3Dh2t0bqCRj3DvaJHs9QBRmGzzL7P4FPHlw52NUVB1wu7QfyeCDn7dRemtlJG502WMThQv1v4vRYKXftu5QiHJCYZQ+5hWJvc+tWadMT7d8FwLhnbutcpLx+30jAi2m3SzeG7UKQG2qTo4+ilDSGdQXiC7b/kEyAVPY1MY75T9QwtJmjDMN9IgfKWYT2PhEwa+RQRQzQF7ttb5cdjlmpcy34x0N4pO/CzAVLNHC+eMwhMThq7p3b/NkxrYAqbIQj72T4e8OMjYlViv1eAXNvHlSDANWD76C04SL9kVNpJ8BTkJmDj80V7N27qfj/czfBiJBt/Va9xe/PIQB8HCc6oSKdKiPgq4OHH9efvDTzx8Xzw6IR2IuHkDuLMtkJ1phxnQyKq7B35/6bB2l6yDgW4ggqfVNiz1QQ+nHFqXcHniUClgF/HJImyrXULHoQ/MCQki/5x483wNO45iS6b6zVXm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(19092799006)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHFyNlVMRWpTOHp2SnpRN21Jck9IbnNFN2tFcmJMa05tUzF3cGdNVXZQZHRC?=
 =?utf-8?B?enJWMk1sS2tuVklFdTZ1SEVhREMzdjZITXNrU0QydG52NHVSaUI5YkJ4NEdm?=
 =?utf-8?B?MlI1SlYwV3IzSGl4d0Z0NnpQQTl3cGRmNTR1RkFlVktWaTAyNDBjQ2hTWFZz?=
 =?utf-8?B?R2d5WUtKNGNpRlM1YlBWUFJXVHY4R0dIQzRWSmZGMjVUYnE2YzYzQ3JQQUhM?=
 =?utf-8?B?UnFGUkRwaTFNNnlldW9Xb0llWjZXZ1h0azZlTDl0ZkRnc3ZWbkNDMkR2NUxL?=
 =?utf-8?B?TTBGQWhPaFZFS2dOL2dHbFQ1cEdDeHVXOXVaTXJpM1JwbXFtUWg5WTBPTnE0?=
 =?utf-8?B?NlVlWmk1bDJkYlBFNmxmUWlObjFFc3c4czU0SUNLTlppQnk5a2N3azVWMkZq?=
 =?utf-8?B?cHV0c3JjUDNXQ2NCU3ZJTXcrSVZ0NWRFWUhQRnhCV1JiaDNHbmthOXRvNDVp?=
 =?utf-8?B?amwyQUtYN2svZjEzcXVqaEpNcXdqZExja3ZsemYzZTF0VmNLSm95VmtQMVFK?=
 =?utf-8?B?SkFDSG93OWNRWUxQVXhWaWNNTGRKRDhzSXFwYktnTkN3bmQ0WmlJR1dYbVRT?=
 =?utf-8?B?ZmpMNWJqTkRvWGgyNFpUMVZLVkd5U3UxaHNjQmZya05HeEZOaTJDaEdLWTJS?=
 =?utf-8?B?a3ZzNlI4MFJNUC9MNzdSbnM5TmdEdVEydE8xeExSS0JVV1luaXk3MzJPYnVz?=
 =?utf-8?B?d0U3WlpyMWFoQlg0ZG9IZnUzVmpnRS8wNWl4SUtHKzVaZG1UWlNINXpNMFpr?=
 =?utf-8?B?dm81SFB3dmxSNlc2NjZzd0lQcVJCVUxIaWJGd1lHNUU5WmFNNVpFNStHb2lk?=
 =?utf-8?B?Z053d0dlTzRtL1Z4OFJlb3BId1pxN0JDblAva0ZjRmNxZU1VRWZhM2FrNDRC?=
 =?utf-8?B?YTFOa3Q0dFpabGg4V1I0R0diR0hlV3dSemNkN2pRUWNzYkxSaHVibmtBdDkv?=
 =?utf-8?B?UVIxaHVRUU9jVmhTU1NrZXowTFNRNkdzcTN3WU9WZzNJc1Frdjg4Z0VYUkF4?=
 =?utf-8?B?TElaUUpBSHFRVDJUUUE4YzNVNGh3U0JWb212ZTQrLytlMGc3ODVpTk1WZGlC?=
 =?utf-8?B?NlRNcGZ2TnJpQ25ieUtsaDJuVXdmSmdaUm5oUnlPSThiOHZJTEp1czZWbndo?=
 =?utf-8?B?d0R3OWZ4eVl5Mmk1blZuUjZsOUZSUTlLQjJjSzJVbms1VlZWNEVuRzNaNUdS?=
 =?utf-8?B?RHlEY0hGVXAyeTU3K3hFVTZ4OUgwYk5sRmdHS3VnNzJGTDk2cm1NdXcrTjJk?=
 =?utf-8?B?M0h6ZlFPdUlDZVRNeFpUci82V1hYQ2NiYXZnRWtsRjZ6Q0FvQXlodk1rNnR4?=
 =?utf-8?B?NEY3bVN2c3BvYjJTaFlpZ0VIYXZudE5yS3lUSHJWeHY2bTVBb3RMNEN4WW1Y?=
 =?utf-8?B?TFFSVEVpbW94T2lSRGcwa2taNTRuZlY5OUpmRVlVOWs4NVlncnRRZ0xEZ1Jj?=
 =?utf-8?B?WVZ5THBsSFJiTU1LK3JWQnl3Yzk1a0h2Q09kcXFNOEp1RmEvZTVYRUdzK0wv?=
 =?utf-8?B?SkVKYkhNcTNPZHJZVVBFeGo5UUI1Z0FEemhMVEwxTlh1NXVXZENpdnNyUHdI?=
 =?utf-8?B?TERWVktEUnhKVjExeVRUTEg3MHYzN3JhT2paRmFDSnplb2hjM1poQzUvZWJJ?=
 =?utf-8?B?dDlYMWoyZ3k1M3VBa3VUUTZUbGRBdFMzUm44WHUwa3pUWHJ6R0phNHdJWmxq?=
 =?utf-8?B?Um9SejZ4NEdHa2RTNFdpUWZ4T1ZFcVJiMTVzbUJXY0VtYndET0NFbzNmM0pD?=
 =?utf-8?B?cTBaY3FWN1FPMzdmcW1DT3IwMVFBZmszS1JTYUpIMysvcHZXeTE1djFtM2V2?=
 =?utf-8?B?N25ZdG42aGVSZytkb2xvQU51S2VrODdQTjlYUHlNMVUwQTlzUFpzSzEwMkpv?=
 =?utf-8?B?UXhZTUViZmRDSVdHZDI1KzVmYU9UcGEwbDJMbm5ydCttVW80ZjVoT0xwZnYz?=
 =?utf-8?B?amRHMmxzb3JiZ25KOG5VUG9nSlhJa1hSdzd1TVV5d3I4ZGVsdmFyZXM2L05n?=
 =?utf-8?B?Y2pFdi9KeWpHUGNkTzNhdW8xUk4wUktILzdCUnRMemoxbWhUWHpDdXVLbGo1?=
 =?utf-8?B?U2hNbW8xTDJiWmlBOE5kUkVsWUhpMWNXVjNhSGRhSUxjK2R5TGVBM0RLTDNh?=
 =?utf-8?B?L0lZNHN5eVlVRHdQbzUrL1NTaXJhamg5dHNWWGcwdW93ZExuWFdiUnNRY3ZP?=
 =?utf-8?B?VldxUHJzVnhqM0czSnlFSXRGY010UFdJRUlQazUyNWxTRkZjZmtSVWZZS3Zp?=
 =?utf-8?B?V3QwamtvNUZOSyszZ0hiQTdNYU94cWVkQTVsMlp0dTk0OFg1MjY2UWVsTytx?=
 =?utf-8?B?Nk9ocmE0dU5HdHFJSHYyZ1hJZW01eTdBRm1DUjQvZmIzQU56dElMcjJjYW94?=
 =?utf-8?Q?7GOREurJ6hut0coDiMZgvUuhAufA3wymXX/Xz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53642bae-bda4-4cb6-67d9-08dec7d7184d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 16:32:57.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oGN+ZfeOrh34GhCpcUh0kbVC7wOGAj9Kw77Hv2ewetJomBRu9rB3v4DjwFlk3BwxYZgMPnfiYzNHwD4Ww8aa1i8IEY7cfLfknGWOJS4IV5GgJo+VK07ZViiJ36jbVQan
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10840

On Thu, Jun 11, 2026 at 09:08:32AM -0700, Rosen Penev wrote:
> On Thu, Jun 11, 2026 at 8:36 AM Frank Li <Frank.li@oss.nxp.com> wrote:
> >
> > On Wed, Jun 10, 2026 at 08:52:41PM -0700, Rosen Penev wrote:
> > > Convert fsl_dma_chan_probe from kzalloc_obj() to devm_kzalloc(), tying
> > > the channel lifetime to the parent DMA device. Remove kfree(chan) in both
> > > the probe error path and the remove function.
> > >
> > > Assisted-by: opencode:big-pickle
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > ---
> >
> > If use flexible array, needn't allocate channel
> Not sure what you mean. A regular array avoids that as well.

Yes, consider only max 8 channel. Now the common method is

fsl
{
	....
	int chan_count;
	fsl_chan chan[] __count_by can_count;
}

scan children node to get total number

devm_kzalloc(..., struct_size(fsl, chan_count)) ...

Frank

> >
> > Frank
> >
> > >  drivers/dma/fsldma.c | 12 +++---------
> > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> > > index e4a3315a7d9d..0df09789187d 100644
> > > --- a/drivers/dma/fsldma.c
> > > +++ b/drivers/dma/fsldma.c
> > > @@ -1114,11 +1114,9 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
> > >       int err;
> > >
> > >       /* alloc channel */
> > > -     chan = kzalloc_obj(*chan);
> > > -     if (!chan) {
> > > -             err = -ENOMEM;
> > > -             goto out_return;
> > > -     }
> > > +     chan = devm_kzalloc(fdev->dev, sizeof(*chan), GFP_KERNEL);
> > > +     if (!chan)
> > > +             return -ENOMEM;
> > >
> > >       /* ioremap registers for use */
> > >       chan->regs = of_iomap(node, 0);
> > > @@ -1200,9 +1198,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
> > >
> > >  out_iounmap_regs:
> > >       iounmap(chan->regs);
> > > -out_free_chan:
> > > -     kfree(chan);
> > > -out_return:
> > >       return err;
> > >  }
> > >
> > > @@ -1215,7 +1210,6 @@ static void fsl_dma_chan_remove(struct fsldma_chan *chan)
> > >       tasklet_kill(&chan->tasklet);
> > >       list_del(&chan->common.device_node);
> > >       iounmap(chan->regs);
> > > -     kfree(chan);
> > >  }
> > >
> > >  static void fsldma_device_release(struct dma_device *dma_dev);
> > > --
> > > 2.54.0
> > >

