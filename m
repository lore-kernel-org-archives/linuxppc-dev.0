Return-Path: <linuxppc-dev+bounces-29673-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A23CCCF2D4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Oct 2026 03:00:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j7Kzc6DXSz2y32;
	Mon, 19 Oct 2026 14:00:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c20f::7" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792378828;
	cv=pass; b=CLdE3TJkOc6ijL2zwHg2MOSJQVaoITMmN63EKH2+R1xEmF30GGYeDMH/VdLMI0at7+XDlneiE+Lq3bwKMfZIIeeu7+DpsPPnKzquhLpuQStKEtexdAbmKAZm3uebZLA1c3Dwrvd9Bq61QmwWnFJu9pxfMf/+3imCijcM+o9ZZscH4VG/pPtP0JAR9pVTRnYMreQQnnFhakEjs92fH88BXzaIv7oynHASmo1IJyZBrelEVkLMxcaTMXnRASbt9N1IBBLsuaO7oBbYoWMFFTxPSJjcFum4KIPy0YnBXmRUijTKCU88GU+xAgIxG6ip8w49I8IObCQ2/Mr3SiMglyeAmQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792378828; c=relaxed/relaxed;
	bh=H826vY5YSKTACsvFq59wSp7laBxPXljNVS30li1slI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HqNu6Hzj/d8QTDSH57zKDwu+g2jRvfGZu1ju8xIG5kWrcoOzNO8vz1s8IIpaBH5E6fNrpGsHqCfugfF9KuD0/D+FYqrG2GQRTvgd+X/vKL1prMlxIn0q/MbuFXP8Gkq8AVW+CUmGNmDKxGHLs8G1lUQiveIT+eu/BNWZlZ/NAJb2Qi+VsEJZu+hkeR2Etqw+1BKtTVd2uAREQSgIaR5KHpZWUo+nWgoPLTD64JwD9DASAO9I1qD3HXBH5Xsvff0xWr7MXbGY/1ZObaRj0P+2AO98YB4tp9a3XDkeqTPLEJiaOwXp+7RYsKiFA7AlLb8Yaqjtt7awTNVl1FuujZsa4g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Zg6dTv5H; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=Zg6dTv5H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c20f::7; helo=osppr02cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazlp170130007.outbound.protection.outlook.com [IPv6:2a01:111:f403:c20f::7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j7Kzb0Ct0z2xgv
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2026 14:00:25 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAfxtZ+o7v+ox/CmVJmWBb3Gv08txLBF0yArQuKlggTISQQwa1qwApYYRaGXhwrd6W6k2LfMn+rRoHVn/7KmPt9NYWzaUMBgJUjMK+ebO8NyHa6tNi7tPnRqTJoJNpaErudEsNM4TiaXjD/90rfVdyPBkQ9ayYvgeOcxAMhyfkSpjLfl0xTAjC/0iywt5199zwJtMeajH4D2bz2lYjeE7QMF9r2xc8z02YO1zSJ9h9aVHtR9O6Ljlb4fwaRW67KKRpLJI0UEF8EZP0vMSzMcuItFDKdCxnGUOUr7DYYEO5lAAm45FfESMu0lflMUTF8/ejsjT9Vtndb2nURacsUdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H826vY5YSKTACsvFq59wSp7laBxPXljNVS30li1slI0=;
 b=eFr27xJWZbo0phPNB85aoVcD9KsqWB5+VxudtMwpuo1cKFnieES6Z6xpGM3ObrLRwsgo07jm8YpYNv/VY7t3ZxRqEaEps75mjbXnto0QuBJQHzgYXACggoNocWKfY449/GjEYvmzolibkcdkF1tz1NO5y5ykGgDddaBIOX657Q8QOVh5XUh9kJSPWYhrBrN30wOzK3oQnjmKFFjhhFD1qv6Q02bWK1vEQtLkGXsTTuspttnGRLrr/XpHSeyiaWwjvudvJf1CripkOyLVjOaKn0w348uX78tOSxA6egEunInBxFHLGIvTj+jzP+MZ2cyaHAqGuwOqp65LaRsWTLy/Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H826vY5YSKTACsvFq59wSp7laBxPXljNVS30li1slI0=;
 b=Zg6dTv5HLEA0qVpOTBaE6PzfNUxXSbhX7tsfmBLzkYjCfP+Mw9qt3B2Uw0/fPzTSH36sMfZBA54b1O9WAJoNNwO7OZYz+uCnV+nCTc0qZg8WmNSh8RQQGWR3KY4Bb5HNMaCjdflrHs2UgHYI34a9rgh0SY/y/pBJzonX2YH0E4CCE6KyZGX3RUoE1NET24a/aZtK2SeuyR6cqBTdT5OZmjiiT8El/nBSv8iCka2REVFmwqZE1v1MCne3lQmqhRdtNZB5GAMoO20Uw+mK9TY4a5710nXt8kxUSi+Kqw4qEHW5APGZBHfbBzR65JrSUWGJMbhqvf1ZjH6tQT5yJ9LxLQ==
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 02:59:55 +0000
Received: from AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680]) by AS4PR04MB9338.eurprd04.prod.outlook.com
 ([fe80::7c4c:9c56:8552:f680%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 02:59:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Marek Vasut <marex@nabladev.com>, "Frank Li (OSS)" <frank.li@oss.nxp.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, "Christophe Leroy (CS GROUP)"
	<chleroy@kernel.org>, "David S. Miller" <davem@davemloft.net>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Clark Wang <xiaoning.wang@nxp.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Conor Dooley <conor+dt@kernel.org>, Eric Dumazet
	<edumazet@kernel.org>, Frank Li <frank.li@nxp.com>, Jakub Kicinski
	<kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
	"UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: RE: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from
 DT
Thread-Topic: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable
 from DT
Thread-Index: AQHdXaVPTB8CJdKLoUewahs8NUD/ZLcAl7OAgABoBfCAAP9vgIACLV7Q
Date: Mon, 19 Oct 2026 02:59:55 +0000
Message-ID:
 <AS4PR04MB933821150913BDCF35C4827F88982@AS4PR04MB9338.eurprd04.prod.outlook.com>
References: <20261016193344.115518-1-marex@nabladev.com>
 <20261016193344.115518-2-marex@nabladev.com> <atKDNdxl0w65s8yQ@SMW015318>
 <DB9PR04MB933217F7ADCB6223A44DACA7889A2@DB9PR04MB9332.eurprd04.prod.outlook.com>
 <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
In-Reply-To: <661412ff-3942-4d1c-be6f-1ef6c54620fd@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9338:EE_|DBAPR04MB7285:EE_
x-ms-office365-filtering-correlation-id: daf015f2-04c2-4de3-dd56-08df2d8d0db0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|19092799006|38070700021|11063799006|4143699003|56012099006|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 nC6wKL7iMei+A7t4Gp2AVXlepVKuB3j3W5E8vEx8gD31Wl7x8Pq4TS45HyQEpnWepN89uMm1wBJ9IOnUN+MeZZ2lGJuQ/Vg4cBXN1UaCXqRyEUKtdI0DKX8TmRzJQYU3n0fQjIwrK7cYLOX1qCuyq8xm81n6RnEyjGs19vtXJCPeo7TSPUShZTYpY98qiwuW/+uYafqetamxdBi0DbdMI4bKs1t87uQWOmDqvQ/C0QTdUpVlfK7r+EucPSKR/TK3ZP3oKho7VJUTXXMjtqdIjM0D+VNTvsiyIOiS+aBYeNOOuBiuUv8nUP1l/3UQFJcM+OefsmUZa60ZYbrkcluDDNfh4yVP1rgp9e61e4O/ZpSNRe8noB87xxp+uj8oYJ7EAHcggtD9e0CYsLQl3Elg2I8yGQScnh0EQQTIYvAIN5X9sb+XWgyad0xjAu4ZOmjB7ttwQyReznMMUKeTGO20xbPbgH90uA1C7BEelBh1e2M7LZ3eJGiub3JBcX4t5E0E0jjKdRyB1SObavO32jQFYjhlid80cVmQ+SZ/isYJbunX0reHMSC5ghWn0NDhcKz0f0rIvF2hOWMHGTdCaV30efQGsc3UXuv57UM7yHAMBanKljJi3nZv8VgUQ6AexmktHsBI36PRqvzhjbRMQ/VCcVa0WEVrUY3IpV1MfQCBA2Cowqstg/XpgogF47/r/LG6Yk+PtvJC4AhHRmIzfX/mr5DrRnoNffn7BLdTl1Yvtac=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9338.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(19092799006)(38070700021)(11063799006)(4143699003)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHpLZEtYOFNkMnNyK0hIUTdKWWkzU2JQR0hFcnZsMHUvQlNQbDJQYWh5TFhh?=
 =?utf-8?B?NFpmZ2tNYU5WOEZsVStDeTNxUVE0ODZMNUJ6VGhSbWN2QVRHbGNKMHQ0QmJz?=
 =?utf-8?B?a2xINlNJQmdOU2JqYWRXem1VTmpDSko1dTlsc3Q2T2pwV1k1QjQzM0JXUzgv?=
 =?utf-8?B?YnI4ZmNkaWZwM0FXdlpWWDJKcDhpVHpjME9ybmZPZ3NCNmk4N25mS255QTk1?=
 =?utf-8?B?ODlQaVM0OS9ueTYvSmNFbDNnZDV5c1UyTWFzRnJqYi9tRW1GN0daOWJxR1RH?=
 =?utf-8?B?cXdTN082YTJPOGYyRjQ2RUR1TXFMNWVIcHcwNGt0Q2VxTVJ6LzZGRnY5M044?=
 =?utf-8?B?VjlnYWJqZkx5YVNIZkhoTS9tTnc1MGRYcUJ2bUdZL3MwWU9zSUpVNU9UT2d5?=
 =?utf-8?B?ME5DZU05SlkxeWF4V25XMzI5RWRnZXhKWmZlUHBzUWhOSlpTNVJsZ3prR0t4?=
 =?utf-8?B?L0lBOGZNTERLc3d1S3pPUUFET1Q0UWhuV0M0cDQ3dmNGUmhBY252K2htc0t1?=
 =?utf-8?B?UWI0ZUtrT1kya0laY1psSFlmV3VBdmlLcGdLY1h5ajdXMkw5dFl4WGl0ZVAr?=
 =?utf-8?B?bjNNVnNFajJrZVFub0tndEN5MVJxekF0bWhVcU1rM1VHSXZaRjFOUnFDMEkw?=
 =?utf-8?B?bUhPYzlzTFB1dzBsN0xlVXp4YU5DNmVDVWk2d3ZraGh6bDdtMGhQQm5xL3cw?=
 =?utf-8?B?YTNOTExlZ2E4dngwMGZwcHV2Vlp6ZnNkM2FBN1E2TGVvcjVNaTdEdHQ5ck9D?=
 =?utf-8?B?WFhPcW9BbFJDWUVpN3AxVGxVeWp2ZVhHNkZZVUluRkYzYVc5b0hycEo3ems5?=
 =?utf-8?B?N2VoOE05MFlxK2l2TWllZkI0Skhac0dVMkhkS3FVd2M4Nld2UjFmQjFPTGZa?=
 =?utf-8?B?VExWNGpzQkR2UlNWbGJYSVpwOWpPOUVIRlVwOVdPSHFuQnl0KzVpcVQ2ZjFk?=
 =?utf-8?B?anVUOWx6L05maHNzemhWcFJ6M1h0MVRVUUpvV1d6aTlkMXJEL1cxMnhIYW1l?=
 =?utf-8?B?OUpWNVNxclNuZmlWcENrK1JzdXJsQlJMQWJIZjJiTTJOVHFxNC94TTlGcE9x?=
 =?utf-8?B?WE9nNmo5cDBJcE1XaS80SlkzWDNWWUJjanhEYk9KZkJucnNIU2NEMjBBQ240?=
 =?utf-8?B?cXlOaHphaDBvWlBTOVpZSGJ4STFhenF1ZmpibjhHN2tZbDQwZ3ordWZlNmhj?=
 =?utf-8?B?dS9kbk5RTHRMN0c1bnhiSHlHQ0N4ZnVRMldyTnNLbFZiYUFuYVdNWjlKUjhG?=
 =?utf-8?B?L3FxbFpnMVVmR3V4WTgxQ1E0T3pqZUowcG1VM1NxQy9OMUNWL1pZVDVhUHlC?=
 =?utf-8?B?c3B0TnVXbXJydmFsNFN1TExVS0VhaFhaYzFJa3NuK3JLTlhlbDJkMnVyWE5w?=
 =?utf-8?B?Q3NSWjhhM3Q1alIzTTgwREFUUHVpcDFGdjJlZjB4V3VFUFluQ2pQUmw0a1By?=
 =?utf-8?B?MVFJODRRenVSY2ZxeUZaQU16cnloa2pBZHlnQ2NVeksyTTlBUmtpd1pBbGdo?=
 =?utf-8?B?WjJ1WTJWOWp5cW5wOWxuT2drRFc4YXhScFQ1RlFIVTM2TTFxRjdxMGRUYUxD?=
 =?utf-8?B?SHZSVkxjYk1pcWV4b3pXMVpCWFNZZlNhVDByMnJ1aUlXL1phandNL244WTNU?=
 =?utf-8?B?N0swaldwZGpMOFF0SWN2WWFnY290WHZvNUVvNHB6czY2N2xkNjU4SkNZQWc1?=
 =?utf-8?B?aWd0Tm5YK1ZLd0p4ZUNodE40Wlc1bUhsWUtGMmJ6NDlPSHRJd2ROR3ZFUW92?=
 =?utf-8?B?L0JWR3B1UVlwZmsxek1HYmUxZHp2a081ekJQTDZTdkZNTER2OGszY1BYdHZp?=
 =?utf-8?B?eFRuSGhnUWZBeGxzd085LzdKTGl4V1Z2SnhaaWQ2WFVldmpFTFg0MExSbitX?=
 =?utf-8?B?RXdpK3FseXJmRm8wbWpSWXZXY3VQMlFVWVB0Y0lMd1RpYkdkVzJuTm1TMS9T?=
 =?utf-8?B?WEwyUkx4dEx0TmhxMysyQ0lEK011R3BudXBsdFhjd09GLytLSFNkQStVTGNU?=
 =?utf-8?B?VWVCK1RNOWRCTjlPV2pQajY4ak4rdHptNXRnSXhVZHVLWnlLUGUrQVN1dWQw?=
 =?utf-8?B?b2t2YXp0V05JaXc4cm1JUEdkbDNxeWFGbjVKZ20rS3BmMmc0QTIyRlJ6Rng3?=
 =?utf-8?B?QUVHbm5pdzRyU253TnJNL2x6dTNWMXFSbXcyT1BTRmNvVHhvR1JPdmtZM3dk?=
 =?utf-8?B?N29UN1k3K0pUQVdKOEZUYW00R3VoTzhFRWg0azd2Y2xiQUtjelEzR1czTWpu?=
 =?utf-8?B?M291NHhtM3JpMThLRThkdkxwaTUreTZLSVlEdURxS2FEK3liSWtKZ0N5ZGln?=
 =?utf-8?Q?mv0FpTRL1O62MYG6xE?=
Content-Type: text/plain; charset="utf-8"
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
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9338.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf015f2-04c2-4de3-dd56-08df2d8d0db0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 02:59:55.2966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AoLip3OtQe7IbUrHZY9I5QofQnjd8YF9V2KjQ/EFA+LHuS+/4FgJgpOmDYaO+lFkfkEjlBncOIBCVHk6SgJJMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

PiA+Pj4gK2ludCBlbmV0Y19tZGlvX3VwZGF0ZV9tZGNfZGl2KHN0cnVjdCBtaWlfYnVzICpidXMp
IHsNCj4gPj4+ICsJc3RydWN0IGVuZXRjX21kaW9fcHJpdiAqbWRpb19wcml2ID0gYnVzLT5wcml2
Ow0KPiA+Pj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBidXMtPnBhcmVudDsNCj4gPj4+ICsJc3Ry
dWN0IGNsayAqZW5ldF9jbGs7DQo+ID4+PiArCXUzMiBkaXYsIG1kY19mcmVxOw0KPiA+Pj4gKw0K
PiA+Pj4gKwlpZiAoZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgImNsb2NrLWZyZXF1ZW5j
eSIsICZtZGNfZnJlcSkpDQo+ID4+PiArCQlyZXR1cm4gMDsNCj4gPj4+ICsNCj4gPj4+ICsJZW5l
dF9jbGsgPSBkZXZtX2Nsa19nZXQoZGV2LCBOVUxMKTsNCj4gPj4+ICsJaWYgKElTX0VSUihlbmV0
X2NsaykpDQo+ID4+PiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIFBUUl9FUlIoZW5ldF9j
bGspLA0KPiA+Pj4gKwkJCQkgICAgICJJbnB1dCBjbG9jayB1bmtub3duLCBub3QgY2hhbmdpbmcg
TURDDQo+ID4+IGZyZXF1ZW5jeVxuIik7DQo+ID4+DQo+ID4+IGJpbmRpbmcgc2FpZCBjbG9jayBp
cyBvcHRpb25hbC4gSWYgcmV0dXJuIGZhaWx1cmUgaGVyZSwgaXQgd2lsbCBibG9jaw0KPiA+PiBl
eGlzdGluZyBkdHMsIHdoaWNoIGhhdmUgbm90IGNsb2NrIHByb3BlcnR5Lg0KPiA+Pg0KPiA+DQo+
ID4gRm9yIEVNRElPIGRldmljZSwgdGhlIGNsb2NrcyBwcm9wZXJ0eSBpcyBub3QgYWRkZWQgdG8N
Cj4gPiBmc2wsZW5ldGMtbWRpby55YW1sLCBJIHN1cHBvc2UgdGhpcyBwcm9wZXJ0eSBzaG91bGQg
YmUgYWRkZWQgdG8gdGhlDQo+ID4gZHQtYmluZGluZyBkb2MgaWYgdGhlIGNsb2NrIGlzIHJlYWxs
eSBuZWVkZWQgaGVyZS4NCj4gDQo+IElzbid0IHRoaXMgd2hhdCAxLzIgaW4gdGhpcyBzZXJpZXMg
ZG9lcyA/IChtYXliZSBJIG1pc3VuZGVyc3Rvb2QgdGhpcw0KPiBwYXJhZ3JhcGgpDQoNClNvcnJ5
LCBteSBlbWFpbCBmaWx0ZXJlZCBvdXQgdGhlIDEvMiBwYXRjaCwgc28gSSBtaXNzZWQgaXQuDQoN
Cj4gDQo+ID4gRm9yIEVORVRDIGRldmljZSwgd2UgYWxyZWFkeSBoYXZlIGEgJ3JlZicgY2xvY2sg
aW4gdGhlIGVuZXRjIG5vZGUsIHNvDQo+ID4gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCkgbWF5IGdl
dCB0aGUgJ3JlZicgY2xvY2sgcmF0aGVyIHRoYW4gdGhlIHN5c3RlbQ0KPiA+IGNsb2NrIG9mIE5F
VEMuDQo+IFNob3VsZG4ndCB0aGUgY2xvY2sgYmUgZGVzY3JpYmVkIGluIHRoZSBNRElPIERUIG5v
ZGUgPw0KDQpUaGUgZW5ldGNfbWRpb19yZWFkXyogYW5kIGVuZXRjX21kaW9fd3JpdGVfKiBpbnRl
cmZhY2VzIGFyZSBub3Qgb25seQ0KdXNlZCBieSBFTURJTyBkZXZpY2VzLCB0aGUgRU5FVENzIGFu
ZCBORVRDIHN3aXRjaGVzIGFsc28gdXNlIHRoZW0uDQpORVRDIHN3aXRjaGVzIGFuZCBFTkVUQ3Mg
Y2FuIGFjY2VzcyBleHRlcm5hbCBQSFlzIG9yIGludGVybmFsIFBDUy9TZXJkZXMNCnRocm91Z2gg
dGhlaXIgb3duIHBvcnQgTURJTyByZWdpc3RlcnMsIGluc3RlYWQgb2YgdGhyb3VnaCBFTURJTyBk
ZXZpY2VzLg0KDQpZb3VyIGZpcnN0IHBhdGNoIG9ubHkgbW9kaWZpZWQgdGhlIEVNRElPIGJpbmRp
bmctZG9jLCBub3QgdGhlIEVORVRDIGFuZA0Kc3dpdGNoIGJpbmRpbmctZG9jLg0KDQo=

