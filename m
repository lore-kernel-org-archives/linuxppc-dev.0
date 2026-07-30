Return-Path: <linuxppc-dev+bounces-25066-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57309C54FD2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jul 2026 06:03:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9dsb3bC3z2xnp;
	Thu, 30 Jul 2026 16:02:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785391379;
	cv=pass; b=A7YfH9aNwOaWhbVDt0xYLrp8jCCSu8xkl72niPH9h3ppvmr9j2MbWLW65iNx8SNAOR1PPkgWCurkcZSyxozh+l77RW0g1VI6VoGZeXjIln5nMsNR/LegW8vb80K9hGiQMgeC0wLlvHGNaf9f0oqGcPbTneYXOPsnZa1GNzwuTROW71bBLii20ev5tyN/JDuK3Lr60lNRo5GW8fZVza7whR93tet7VFX8lT8BbzoloiE6Hk5Tx9fddGwlA7BCJ1flJxrw6i6t08VcDtYTd3NPLWhqV4EfqFtz8LZwvEsjo0vuRCewjzff84ueZUzqzHb6eI0h46tO8W9Y6ZzAeqmA7w==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785391379; c=relaxed/relaxed;
	bh=Kx6t2gqDHz+RZFwDv4WEcq9Wo4N056WBXp1D5iumRIM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A15emR8j7/odU4YgY9W5qGCdB6iGSiEWX+hq2h2aNixuGfJHpfs2wUS5ZVqvOgJGqBL9PMFlg3wSpznFYIG+Cg0VY/qGVbZ0EqEGKHexHvTfPGgz89kUKHAnZ/olDQtkbn4JTw5tJc1BCPHGkND1tAW1NEacg4IPGL/Zyr61dD1P6HUGwEwDKrJu77QJx/9WwAg0ZGrFB+cgMhgqfPq6+WiuQzgxPsTWIebHQoGHu2NbE5tDrdUZpqVuxgWb0Ru6G4tpScT8uPUM0nvBkn8qMnddWMK6wLpBlTO6SnwtjfKvKe0xw4AZR9h1pSUYzdcKW7MOf4fzvYVQSqzAoMzqbw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=lBnzGQHP; dkim-atps=neutral; spf=pass (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org) smtp.mailfrom=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.a=rsa-sha256 header.s=selector1 header.b=lBnzGQHP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs-soprasteria.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=christophe.leroy2@cs-soprasteria.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9dsV2qhTz2xF8
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2026 16:02:53 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kg09BUli5V4YiMFA1p64PntrLtDcI862XpijAOZ5KTzWXBvbkSsa4fIZDjPBG70iu4g7gR/IJfM7wNSx42copAMRPchaFNJ/zBmqICxLE/sr7AcHK5OiqF/ZjS32vCv/9+XgOM0rIld+Gvn//K6XLt6zarirTCnZ7O6lH9iz0eV7MDtgRCB1QcwAUiO/HQ+iI2CcaiOIH7KV62ElC2SrS1OUEKtL+v/OI1oHsd/DzIN7Svott98WYKJL4FjYz90dO26tiyLs+IIMVxv4MZVuzsVpvwsbweJljrWkR2oY6byhgtC5P2dDQp1ZX4je+d+Uh1CA9ow9gq9nstLxrtu9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kx6t2gqDHz+RZFwDv4WEcq9Wo4N056WBXp1D5iumRIM=;
 b=jtHvZA/f/4wpV0hehM0+LvJut5dYHZLmrf85gl5D4bIYq2uGvEs1dr7Jx85NfaD2eLcO5yQUVymcWyGiXVvDLHdLcOh48yCaluBK/3DQwnKlAYKt7BFGcrxDuI7KAsCIDsPMJenstxJsxBMFj6o7bqbq1P3ciaoE9X64ACJbXvybXeD3Q7AIdogHEqp4j4uA3TlmdPwEysLvia6PAThTnSW6H9Aq+INKKBru3TUR1Q8rdC+rm3gb9hKOijflBVWqlrBbN9nahRYkFA5/He9LLbCgFaCobbXnmFgbLaaqR7yLVIkuu9XOUv9r7+evjFHLWkLSqnJ3cDnOhOdXhFIFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kx6t2gqDHz+RZFwDv4WEcq9Wo4N056WBXp1D5iumRIM=;
 b=lBnzGQHPb0J+hL6x5+A18xTI7WBH4XTmWX2Jrr/SGNfGqmzaO8BbxWonoNYtevBqvWTLwP3V8Y9mGc1OHErFvt14nHVo5fjzWyS+XVEOhSAWZRx8Hj3fE63BhoiPGtCe7nHc0ZGl6BH293A2lnpKUR0VRo/IrwFkuP5Em5uAATnKEUPi0VOlXEOUNDHjQTlTpdopB5LzAoM+DZwt5byauWDYdUiAk2Y89d24Zn/iMhDanka/2d5RvIv1GpH7AdTJ8WXNtmKu34SN+49nzdQXnSHj/5goKrblipLwvEWJjpIy+0zMiGaS78Nca3zzwmbBcYbuEhFG2c2bds1WPehAOg==
Received: from AS8PR07MB7960.eurprd07.prod.outlook.com (2603:10a6:20b:396::20)
 by GVUPR07MB11802.eurprd07.prod.outlook.com (2603:10a6:150:32c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.7; Thu, 30 Jul
 2026 06:02:28 +0000
Received: from AS8PR07MB7960.eurprd07.prod.outlook.com
 ([fe80::2c24:b25f:5c9b:6db6]) by AS8PR07MB7960.eurprd07.prod.outlook.com
 ([fe80::2c24:b25f:5c9b:6db6%4]) with mapi id 15.21.0292.005; Thu, 30 Jul 2026
 06:02:28 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Link Mauve <linkmauve@linkmauve.fr>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Madhavan Srinivasan <maddy@linux.ibm.com>, techflashYT
	<officialTechflashYT@gmail.com>, Ash Logan <ash@heyquark.com>,
	=?utf-8?B?Sm9uYXRoYW4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>, Michael
 Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] powerpc/sstep: Consistently use one define to check
 arch bit width
Thread-Topic: [PATCH 1/2] powerpc/sstep: Consistently use one define to check
 arch bit width
Thread-Index: AQHdH5vdw3T+OtabRUK7W5AsZT0TkLaFkseA
Date: Thu, 30 Jul 2026 06:02:28 +0000
Message-ID: <390c3f0d-4d10-47d1-a7f3-f90b7d1bc140@cs-soprasteria.com>
References: <20260729204958.755143-1-linkmauve@linkmauve.fr>
 <20260729204958.755143-2-linkmauve@linkmauve.fr>
In-Reply-To: <20260729204958.755143-2-linkmauve@linkmauve.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7960:EE_|GVUPR07MB11802:EE_
x-ms-office365-filtering-correlation-id: bf0ccee1-d40e-4050-6610-08deee0022bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10070799003|3023799007|38070700021|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 EcT9410WSI17B9C1AcWijh7RumgOn23yJoRm+96DuPXtsDiVSV+Yx9/KAet9CDoHzZ2AGwA4QQSJvgRLdm/eh5ck/DzkccAGwXLIfOTXuBkKGzZQbutwiCE2xTPC8JMULOz/ej/uHDo8BQlcXRPZXEz1GEIp+F5/bcYy2xkU8waXvZAWO9DML2HDzOSTPOWeVyI5tbG9q6LbjdLZ7VvnWmqv6qanxpLRT6Kr2ZbV6j9a4FvAAaLBJ2kKM18O/wJ2UeKxobbn40n6ETNI0YT5sZx+wgQ/cv+J8fGLtwM2/x9AqzTUR3vSseRtpgTqa2wCgFNSt2xBSS27UtGlfdKKeN63iadfxKzvlEFUghdBLk5Dy/3er+brfMxPgtxkZBpVYlBdNzZFFs1TAQ92vkf7/qmQaHhsJvlqmd5r1NBN972DswvclwPJhSAff/T3QR5ufDKyfpqpMRd8JGQQhOv8GiyTWYN7qSlScPvWixvVHUPvW4O+/2zUQZXFf7s6C8C3t6noqK+75GUazQF/YkVrYrFoyRJhUkL4EEHaL2gpagncpkBanSFbUCCIPsLZBsU6wIdQQ+dh1IgxqxdfYzXGfGZN+PRyoBWPpWEuUtq9xszmRigHFuRKVSxgidRAPu7TO98F2EpYyYJZHk2qMWyU+mKMI5o0Eik0xBM/2oTzW01YwxPYPvY93Zz/v6Yv8mjOMpp5sK+WccribfmHKpaypgCARaHc2vrqC5EBQTAJHEQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7960.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10070799003)(3023799007)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUtHaFd4UFJXSWFQdERnek9rSS9maVJaeENGTk91L0ZPNG1IRFF6VFc4QmFr?=
 =?utf-8?B?TjZzKzRYaW5UNjVIYUpDUTJYNDRGR08rK0hlckdsMkhRM0JwcVU4cnJmdmxK?=
 =?utf-8?B?NUptQmsvOFpVNU1SU3VGVUVNb0VheUFEQTlyYWtnb2NjTExmRzYvR204S1p4?=
 =?utf-8?B?cEI2UGhJTXJXQUwvcmlVN3cvaEtEb2svUm0xRGpPMzVEQ3kyd2FSSFhoRGF1?=
 =?utf-8?B?THZhaFRKbUJBUVFsampoaHh0SG0wS2MyRS9kakY0K1plMk1zS011a0VCdHJN?=
 =?utf-8?B?K0h4QWlPRUQyd3JVek1IK0xRY1oyMEpuT2RMWGpwWUllc0pWZGNicWVpVzFl?=
 =?utf-8?B?TzUxUjBLcmRKYWN2dTJ2SjNDb2ZpREN4Y0VIQnhoK2dodjdENU5IbmtjTjZi?=
 =?utf-8?B?cktmT3ora3NwM2orSFNJRzgyc1cwVEkyaFg5Y0daZlFicngzMXdyU3NDdlho?=
 =?utf-8?B?MXpiVE9CWjlWQmJXaHRIbzFLajdNRENNVzljZStWeW1IWnhXSkZOZ1BFem02?=
 =?utf-8?B?OEhJYlhsTEo1WEJQZEl0dUhmUVNFOFRXaGVqQ1V2N3VySHRFRXRVOStLc3gy?=
 =?utf-8?B?bU1HblZ5WHJDdDljaUdFK3VjSUtMbkRXYi8zY0xsdVhjR2tSRjhrb24wSDJ6?=
 =?utf-8?B?VE95UEZjcnUwZXoyYVJ4YXB5NWRWb2I4eEE4V1llc3lFRHpTOUlVdHlwTUd5?=
 =?utf-8?B?TnNlT2ozTS9uRTNJZlkvTnhTZytWak02akVJZXQ2ZUlnN0VnWUJkUTlaQkh1?=
 =?utf-8?B?dlB0WWRpeUtIR29iZFhIdktuOS9MMWphUG1rVDZqQ3lVZk9IeXErSzJXYkZT?=
 =?utf-8?B?N3ZLRzY2L1V0TmRwcC80SVAvTThhK2R0azcvK29ML05GaHVOem9wZHFaUmxU?=
 =?utf-8?B?TTJVYlJKa2NXN3FOTC9sSUFHalZsQkJjU0xxYmxhRVVtaVliemlVNlYwZzJ4?=
 =?utf-8?B?L0QwdUV5Mzc1dU93OE5mcEpEMnM1aVl5QXVpTmxZdEh1RExjbHNVc0NNLzdG?=
 =?utf-8?B?VmZ0aTMwZHJueDNsdG5xVlZNRVgyYkpqeGMwSE9SUExTbmp0bUNxTG8zVEs5?=
 =?utf-8?B?bVhubVFlRlV5Q0pBaTVkWkpBQ2pqTGxpcUZSWlQweEwyUVB3WE5vWGZkS0hH?=
 =?utf-8?B?UE5wMVNzZXdXVnc4b212VG1UM0M4Wm9Rak5XOCtvWEJ0RDlyUVNvd29Wa0E4?=
 =?utf-8?B?T2lnV3pjdkRMVEYrME1DUjFFWlIrOTRlbHZ6L25qbVhOQUFpelcvcnZqeXM0?=
 =?utf-8?B?Q1FOckdxQlk3UVk3WlZsdkM0bDMySjQ4ZUNDUmV5UlpXTDBkQmYzRitOYzVM?=
 =?utf-8?B?QVVzd3NoaW5WaEIzN0JkUW5YdkdEbkZyR3ZCR24vZnZGTURFN1Vyc0h4SHFR?=
 =?utf-8?B?WkZpdFpUTW9wQThndTNCWDhWQUNUL3ZtUWdmdlZRZnN0aUtUQS9DeWlwN2I4?=
 =?utf-8?B?RnBiT09leS84UlZNSXNRaVVTQnQ2TUZRYmlBSCtCRGFPaEw3RlRpZXpMMFc1?=
 =?utf-8?B?c0Q0MXpoeitNeHBrR2xXanlMTUYyR0gvdzFXVnM1a2tKMTJwTFh1cmVYemhN?=
 =?utf-8?B?TXJDRENTR01hNVFoTkU4emNzY2x3R2dqSnZDNmlkKy9NNFpvM3YxMms4bWI2?=
 =?utf-8?B?WDZlZW4vV1dOd3lFOUVNQ0ppMXcveG54YTFrYkpLVnlxTEd1YmxCK016ay9V?=
 =?utf-8?B?OFlCVUx1eWVGSy93NXczQUl6dmVqb05WaWN3bm5QVHMrQVl6aGFkOFRpdEJj?=
 =?utf-8?B?VStRdHdFYXdKcmxGdkJqVFAzbVU1bWpHSkJCYk9sSUhWNE9UNGFsS0NxVFRS?=
 =?utf-8?B?MjJrVDFTRlA5SFQxNzlGN2pJOFF3TGRwZmJwZnhndWwwWXhUcXBHYlJhVmJq?=
 =?utf-8?B?YmxXTW5iNnpXOUwvYkczeUdsUXhhcExnRGxSd09vMytGcmNUM1RMc05pTVUr?=
 =?utf-8?B?azVodTVka0V0K3k1S29NNVgrYXhxa3NyZEc2V2V1T3dNQlREeWJFYW9SaGVF?=
 =?utf-8?B?Ti9yOGwxdGFrOXJOeHRvYnZXODZzMDIvdDlJZmljMmliTmtaL3dWbWF6SHo0?=
 =?utf-8?B?S2xGSVdhUXgvZmorY1g3dE9sUkRnUDNNL0RVa01BMkVTY1YxUU5EbldtS2JD?=
 =?utf-8?B?NXFJN3ZuNDdCZXA3UHVGREMwZjlEQU10VnFnNEt4bFdEczVJdkhSQ3Y1RzVn?=
 =?utf-8?B?bTFnbExIU0Y4TTZ3VUdjcjRhNUo4UEhoZmcwZER4ZndDM2ZtUFRDRHJKOGpT?=
 =?utf-8?B?MXY2bldSSzM1TDRQbVk3Yk9Ub3BEdndLbkJ6SUpoaW0xR0ZzNXE3TUpGWG5r?=
 =?utf-8?B?RFdvWUovaHh5ckd4RklnUDZtY2Ztbnh6c0JBMHZTVFlUQjI5ZU5HOFA4U1pU?=
 =?utf-8?Q?f/LuaNaGQQwqr/qstcR03HV1i3CTKAfwlNBRSrAPW+e2V?=
x-ms-exchange-antispam-messagedata-1: 5fJAWQJbN/PMf2w2DD2uABg5gHxzmgozcJA=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E636800F99CD4429068DA5A1AA6843C@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
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
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7960.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0ccee1-d40e-4050-6610-08deee0022bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2026 06:02:28.3360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1cyECzdfMxU9OUnpmfXQjw5NqGZbNkFTe7l413ZKelSKnDHvZtGggi2i5rY0c2P367CL31Znci0bjDIubhYClBh7sAbafQCSbzAdPKARVie3KV0l8jLKyrBN2kIm2wQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVUPR07MB11802
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AS8PR07MB7960.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 2a01:e0a:511:aad0:9f10:86ad:5cd0:9703
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: GVUPR07MB11802.eurprd07.prod.outlook.com

DQoNCkxlIDI5LzA3LzIwMjYgw6AgMjI6NDksIExpbmsgTWF1dmUgYSDDqWNyaXTCoDoNCj4gUHJl
dmlvdXNseSwgYm90aCBDT05GSUdfUFBDNjQgYW5kIF9fcG93ZXJwYzY0X18gd2VyZSBiZWluZyB1
c2VkIHRvIGNoZWNrDQo+IHdoZXRoZXIgd2Ugd2VyZSBvbiAzMi1iaXQgb3Igb24gNjQtYml0IFBv
d2VyUEMsIHNvbWV0aW1lcyBpbiBhIHNpbmdsZQ0KPiBmdW5jdGlvbi4NCj4gDQo+IEkgcGlja2Vk
IF9fcG93ZXJwYzY0X18gc2luY2UgaXQgd2FzIHVzZWQgc2l4IHRpbWVzIGFzIG11Y2ggYXMNCj4g
Q09ORklHX1BQQzY0IGluIHRoaXMgZmlsZSwgYnV0IGNvdWxkIGJlIGNvbnZpbmNlZCB0byB1c2Ug
dGhlIG90aGVyIG9uZQ0KPiBpZiB0aGVyZSBpcyBhbnkgcmVhc29uIHRvIHByZWZlciBpdC4NCg0K
V2VsbCwgd2UgdGVuZCB0byB1c2UgdGhlIG90aGVyIGFzIG11Y2ggYXMgcG9zc2libGU6DQoNCiQg
Z2l0IGdyZXAgLXcgLWUgIiNpZmRlZiBDT05GSUdfUFBDNjQiIC1lICJkZWZpbmVkKENPTkZJR19Q
UEM2NCkiIHwgd2MgLWwNCjM2OA0KJCBnaXQgZ3JlcCAtdyAtZSAiI2lmZGVmIF9fcG93ZXJwYzY0
X18iICB8IHdjIC1sDQoxMTgNCg0KQWxsdGhvdWdoIGluIG1vc3QgY2FzZXMgeW91IGNhbiB1c2Ug
b25lIG9yIHRoZSBvdGhlciwgdGhleSBkb24ndCBtZWFuIA0KdGhlIHNhbWUuDQoNCkNPTkZJR19Q
UEM2NCBtZWFucyB5b3UgYXJlIGJ1aWxkaW5nIGEgNjQgYml0IGtlcm5lbC4NCl9fcG93ZXJwYzY0
X18gbWVhbnMgeW91IGFyZSBidWlsZGluZyA2NCBiaXQgY29kZS4NCg0KSW4gYSA2NCBiaXQga2Vy
bmVsIHlvdSBjYW4gaGF2ZSAzMiBiaXQgY29kZSwgZm9yIGluc3RhbmNlIHRoZSB2ZHNvMzIuDQoN
CklmIHlvdSBsb29rIGludG8gaW5jbHVkZS9hc20vZmVhdHVyZS1maXh1cHMuaCBmb3IgaW5zdGFu
Y2UgeW91IGhhdmUgOg0KDQojaWYgZGVmaW5lZChDT05GSUdfUFBDNjQpICYmICFkZWZpbmVkKF9f
cG93ZXJwYzY0X18pDQovKiA2NCBiaXRzIGtlcm5lbCwgMzIgYml0cyBjb2RlIChpZS4gdmRzbzMy
KSAqLw0KI2RlZmluZSBGVFJfRU5UUllfTE9ORwkJLjhieXRlDQojZGVmaW5lIEZUUl9FTlRSWV9P
RkZTRVQJLmxvbmcgMHhmZmZmZmZmZjsgLmxvbmcNCiNlbGlmIGRlZmluZWQoQ09ORklHX1BQQzY0
KQ0KI2RlZmluZSBGVFJfRU5UUllfTE9ORwkJLjhieXRlDQojZGVmaW5lIEZUUl9FTlRSWV9PRkZT
RVQJLjhieXRlDQojZWxzZQ0KI2RlZmluZSBGVFJfRU5UUllfTE9ORwkJLmxvbmcNCiNkZWZpbmUg
RlRSX0VOVFJZX09GRlNFVAkubG9uZw0KI2VuZGlmDQoNClVubGVzcyB5b3UgYXJlIGEgZ29vZCBy
ZWFzb24gdG8gdXNlIF9fcG93ZXJwYzY0X18gaXQgaXMgb2Z0ZW4gYmV0dGVyIHRvIA0KdXNlIENP
TkZJR19QUEM2NA0KDQpDaHJpc3RvcGhlDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IExpbmsgTWF1
dmUgPGxpbmttYXV2ZUBsaW5rbWF1dmUuZnI+DQo+IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9saWIv
c3N0ZXAuYyB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNl
cnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJw
Yy9saWIvc3N0ZXAuYyBiL2FyY2gvcG93ZXJwYy9saWIvc3N0ZXAuYw0KPiBpbmRleCBmMGQ2YWE2
NTdjMWEuLjU5N2EwZDg0MWZlOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2xpYi9zc3Rl
cC5jDQo+ICsrKyBiL2FyY2gvcG93ZXJwYy9saWIvc3N0ZXAuYw0KPiBAQCAtMTUsNyArMTUsNyBA
QA0KPiAgICNpbmNsdWRlIDxhc20vY3B1dGFibGUuaD4NCj4gICAjaW5jbHVkZSA8YXNtL2Rpc2Fz
c2VtYmxlLmg+DQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX1BQQzY0DQo+ICsjaWZkZWYgX19wb3dl
cnBjNjRfXw0KPiAgIC8qIEJpdHMgaW4gU1JSMSB0aGF0IGFyZSBjb3BpZWQgZnJvbSBNU1IgKi8N
Cj4gICAjZGVmaW5lIE1TUl9NQVNLCTB4ZmZmZmZmZmY4N2MwZmZmZlVMDQo+ICAgI2Vsc2UNCj4g
QEAgLTEyNTYsNyArMTI1Niw3IEBAIHN0YXRpYyBub2twcm9iZV9pbmxpbmUgdm9pZCBkb19wb3Bj
bnQoY29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ICAgCW9wLT52YWwgPSBvdXQ7CS8qIHBv
cGNudGQgKi8NCj4gICB9DQo+ICAgDQo+IC0jaWZkZWYgQ09ORklHX1BQQzY0DQo+ICsjaWZkZWYg
X19wb3dlcnBjNjRfXw0KPiAgIHN0YXRpYyBub2twcm9iZV9pbmxpbmUgdm9pZCBkb19icGVybWQo
Y29uc3Qgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ICAgCQkJCSAgICAgIHN0cnVjdCBpbnN0cnVj
dGlvbl9vcCAqb3AsDQo+ICAgCQkJCSAgICAgIHVuc2lnbmVkIGxvbmcgdjEsIHVuc2lnbmVkIGxv
bmcgdjIpDQo+IEBAIC0xMjczLDcgKzEyNzMsNyBAQCBzdGF0aWMgbm9rcHJvYmVfaW5saW5lIHZv
aWQgZG9fYnBlcm1kKGNvbnN0IHN0cnVjdCBwdF9yZWdzICpyZWdzLA0KPiAgIAl9DQo+ICAgCW9w
LT52YWwgPSBwZXJtOw0KPiAgIH0NCj4gLSNlbmRpZiAvKiBDT05GSUdfUFBDNjQgKi8NCj4gKyNl
bmRpZiAvKiBfX3Bvd2VycGM2NF9fICovDQo+ICAgLyoNCj4gICAgKiBUaGUgc2l6ZSBwYXJhbWV0
ZXIgYWRqdXN0cyB0aGUgZXF1aXZhbGVudCBwcnR5IGluc3RydWN0aW9uLg0KPiAgICAqIHBydHl3
ID0gMzIsIHBydHlkID0gNjQNCj4gQEAgLTEzNDAsNyArMTM0MCw3IEBAIHN0YXRpYyBub2twcm9i
ZV9pbmxpbmUgaW50IHRyYXBfY29tcGFyZShsb25nIHYxLCBsb25nIHYyKQ0KPiAgIGludCBhbmFs
eXNlX2luc3RyKHN0cnVjdCBpbnN0cnVjdGlvbl9vcCAqb3AsIGNvbnN0IHN0cnVjdCBwdF9yZWdz
ICpyZWdzLA0KPiAgIAkJICBwcGNfaW5zdF90IGluc3RyKQ0KPiAgIHsNCj4gLSNpZmRlZiBDT05G
SUdfUFBDNjQNCj4gKyNpZmRlZiBfX3Bvd2VycGM2NF9fDQo+ICAgCXVuc2lnbmVkIGludCBzdWZm
aXhvcGNvZGUsIHByZWZpeHR5cGUsIHByZWZpeF9yOw0KPiAgICNlbmRpZg0KPiAgIAl1bnNpZ25l
ZCBpbnQgb3Bjb2RlLCByYSwgcmIsIHJjLCByZCwgc3ByLCB1Ow0KPiBAQCAtMTczOSw3ICsxNzM5
LDcgQEAgaW50IGFuYWx5c2VfaW5zdHIoc3RydWN0IGluc3RydWN0aW9uX29wICpvcCwgY29uc3Qg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MsDQo+ICAgCQkJb3AtPnJlZyA9IHJkOw0KPiAgIAkJCW9wLT52
YWwgPSAweGZmZmZmZmZmICYgfihNU1JfTUUgfCBNU1JfTEUpOw0KPiAgIAkJCXJldHVybiAwOw0K
PiAtI2lmZGVmIENPTkZJR19QUEM2NA0KPiArI2lmZGVmIF9fcG93ZXJwYzY0X18NCj4gICAJCWNh
c2UgMTc4OgkvKiBtdG1zcmQgKi8NCj4gICAJCQlpZiAodXNlcl9tb2RlKHJlZ3MpKQ0KPiAgIAkJ
CQlnb3RvIHByaXY7DQo+IEBAIC0yMDU0LDcgKzIwNTQsNyBAQCBpbnQgYW5hbHlzZV9pbnN0cihz
dHJ1Y3QgaW5zdHJ1Y3Rpb25fb3AgKm9wLCBjb25zdCBzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4g
ICAJCWNhc2UgMTg2OgkvKiBwcnR5ZCAqLw0KPiAgIAkJCWRvX3BydHkocmVncywgb3AsIHJlZ3Mt
PmdwcltyZF0sIDY0KTsNCj4gICAJCQlnb3RvIGxvZ2ljYWxfZG9uZV9ub2NjOw0KPiAtI2lmZGVm
IENPTkZJR19QUEM2NA0KPiArI2lmZGVmIF9fcG93ZXJwYzY0X18NCj4gICAJCWNhc2UgMjUyOgkv
KiBicGVybWQgKi8NCj4gICAJCQlkb19icGVybWQocmVncywgb3AsIHJlZ3MtPmdwcltyZF0sIHJl
Z3MtPmdwcltyYl0pOw0KPiAgIAkJCWdvdG8gbG9naWNhbF9kb25lX25vY2M7DQo+IEBAIC0yMDgy
LDcgKzIwODIsNyBAQCBpbnQgYW5hbHlzZV9pbnN0cihzdHJ1Y3QgaW5zdHJ1Y3Rpb25fb3AgKm9w
LCBjb25zdCBzdHJ1Y3QgcHRfcmVncyAqcmVncywNCj4gICAJCWNhc2UgNDc2OgkvKiBuYW5kICov
DQo+ICAgCQkJb3AtPnZhbCA9IH4ocmVncy0+Z3ByW3JkXSAmIHJlZ3MtPmdwcltyYl0pOw0KPiAg
IAkJCWdvdG8gbG9naWNhbF9kb25lOw0KPiAtI2lmZGVmIENPTkZJR19QUEM2NA0KPiArI2lmZGVm
IF9fcG93ZXJwYzY0X18NCj4gICAJCWNhc2UgNTA2OgkvKiBwb3BjbnRkICovDQo+ICAgCQkJZG9f
cG9wY250KHJlZ3MsIG9wLCByZWdzLT5ncHJbcmRdLCA2NCk7DQo+ICAgCQkJZ290byBsb2dpY2Fs
X2RvbmVfbm9jYzsNCj4gQEAgLTMyNDcsNyArMzI0Nyw3IEBAIHZvaWQgZW11bGF0ZV91cGRhdGVf
cmVncyhzdHJ1Y3QgcHRfcmVncyAqcmVncywgc3RydWN0IGluc3RydWN0aW9uX29wICpvcCkNCj4g
ICAJCWNhc2UgQkFSUklFUl9FSUVJTzoNCj4gICAJCQllaWVpbygpOw0KPiAgIAkJCWJyZWFrOw0K
PiAtI2lmZGVmIENPTkZJR19QUEM2NA0KPiArI2lmZGVmIF9fcG93ZXJwYzY0X18NCj4gICAJCWNh
c2UgQkFSUklFUl9MV1NZTkM6DQo+ICAgCQkJYXNtIHZvbGF0aWxlKCJsd3N5bmMiIDogOiA6ICJt
ZW1vcnkiKTsNCj4gICAJCQlicmVhazsNCg0K

