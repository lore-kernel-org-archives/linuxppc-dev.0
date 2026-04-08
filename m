Return-Path: <linuxppc-dev+bounces-19494-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EF2FD5F79
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Apr 2026 11:16:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4frL9f06xWz2yC9;
	Wed, 08 Apr 2026 21:16:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c201::1" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775646997;
	cv=pass; b=IOe4dSrmbnAAwmKqUGBfV8TkslbV7MAE9n3RhFOb0ihx8UmPH/D7y79iZQ0oEPQiOgtHc+zfsMev6aeUQ9aBD+TKqBLGn9rexPep5C/bFwPR7vPfvnAf+4bj9J03rSMrxZihsHV2KJ7w0f8bGRfRdfg5yZIW90CVTQ8P/EW2prJop7mNHKDTrFctkcyy+d++E9kklcqYKmL3e5p9zCRWmaJ0nc/380fnXR1KKmXvf5Rx+gcReuPESSMmsoDnG0xvdaLoPOicum1nJ51QxuLMQ3EcTYNcY9SmnAFQ1xSEZSZBjZq11k/wvyJ9u83v8jiVx88pdEsZgv/Ox8yoc0k1GQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775646997; c=relaxed/relaxed;
	bh=aqtck+zZ+lEFHJoX4aKn5eeZexI5+R1m9wWKFeKGBsw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BvGqxk/SnXben1Tuawe9aZJ6zrgk2ldh5G/i3OpX2aeQiAm787yyHoivz1b48/2aASfZpPGiwgc5ZGDL+vUW8L9tLrVbN5Iksa8rwtcw3T3f+PuPP8bpfZGj82t1pVx6JX2ZAwQe9Wk3q+Biffa5BR/CzYCUgIXJp+YVjtfMS1Bt3yeDdj9fhERKo5Q29VqaqepHmQZq7rYBCXW9wwCb0zAG5bN2tcnmTce2G0ic7iv0IX2A0io9l7x5sooCGxFhnyFUVysSxJ3/87kwRWiy5xJz/BausD8VKniKvCIKaRuEEbH524myBchptFblWqZqdF3aaCXTv6kQm0c/SHtPzg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jQ7JgEfy; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=jQ7JgEfy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c201::1; helo=am0pr83cu005.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazlp170100001.outbound.protection.outlook.com [IPv6:2a01:111:f403:c201::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4frL9d1jNrz2xc8
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Apr 2026 21:16:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYtcHcKIUPIMSGKZ4jWS4l3AtdYF0yHiwOxeifRfbcwTXjy/YF6rMVbo0IoBoqsY43ej3sNwtLZOcfdLHb0UJ6Lk/akucezQPvaXLcPCyZ0YFd9+2cLkSRDoII6Ddo5AjRs+2b//oFIWbu409M0AS3eggdLGSXfF6OB8pRQQtnd27uacyCSqjOdQUgmOyDdBx6nY5YMPgZM+ud0nQEuSCPoFF/L45KFbD0iupbSaT0BFG/EoEqa73hoz8moMOqVVI+d5/Z+Y72Lcp8qVLhbmUOXVTBbtlgPH1MqvVsSuZrax8iqRQXV1XqreVvNx26e/b9/Jt+wNjtgD89t2ijzaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqtck+zZ+lEFHJoX4aKn5eeZexI5+R1m9wWKFeKGBsw=;
 b=t2GeeJNWCeXjumeX0afwpN5iMOyoMgKupPi7TLeAQKSWEGijab+NqVRkqz974M3205v8pviyG2B8ZUOJYKoz8EIL8zapSxPQJ/r4CXggGrWamW38YG0N8Ko/2sDAsVPMb09nMjC1eyAkWAvoko5kx71qvlAodY/8bgzi70nJGk4MLPAtwwUYE33zYAR6rSrwY+Fan0bA4uXUmcaZC5V5kEbV974W/Km74o2T8szkAwf9hzJPFOT+SJJ77SBTkztnEjdfzMrSN/JnNaQe8dhpsF5QygZSpQ0M15Ga5tsDpc1LbzBUpBqnUkYR5AUGpg0ZNdKMs6VghVylyw2BhuYzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqtck+zZ+lEFHJoX4aKn5eeZexI5+R1m9wWKFeKGBsw=;
 b=jQ7JgEfy1eO0tlNURAvBu/sK1r//5OI6+Sn3Bl3nQwTIbNKKyx1uWxt9n299GXncHvH8n7UzMPg6zyhB3bIhentXu2sxL6DW5dY67qBgWvXpc4iQje6L+3cN0vO1LgqxsV1XVv5akXMAbkfIEq5YaTtwluiezCMjFQ38bKFaeViSnqIdwd9f2BEU4bUu/Npc6plhfq85SLvnBa4F6ykSfOoMR0m/j0UljsqMrRZS9L0eJUzEPQ4TaXn/FBh1BVP/hh9alUSOZgOycMcDHcW12DegQWSnvci8xfXVDI/nrA9d+2dQBdv+y55Fb0V94L9Ri7vL3EmReIgpYj3CGsq51Q==
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com (2603:10a6:20b:1dc::8)
 by PAXPR04MB8320.eurprd04.prod.outlook.com (2603:10a6:102:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 8 Apr
 2026 11:16:12 +0000
Received: from AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc]) by AM8PR04MB7284.eurprd04.prod.outlook.com
 ([fe80::9cd6:51bd:82b:98dc%5]) with mapi id 15.20.9769.014; Wed, 8 Apr 2026
 11:16:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "andrew@lunn.ch" <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: RE: [PATCH v4 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Thread-Topic: [PATCH v4 net-next 13/14] net: dsa: netc: initialize buffer bool
 table and implement flow-control
Thread-Index: AQHcwQG4QCnFejnRL06UOkxCpeAcULXMjVaAgAiBCeA=
Date: Wed, 8 Apr 2026 11:16:12 +0000
Message-ID:
 <AM8PR04MB72846E7828F202B28931AA23885BA@AM8PR04MB7284.eurprd04.prod.outlook.com>
References: <20260331113025.1566878-14-wei.fang@nxp.com>
 <20260403011745.1795759-1-kuba@kernel.org>
In-Reply-To: <20260403011745.1795759-1-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR04MB7284:EE_|PAXPR04MB8320:EE_
x-ms-office365-filtering-correlation-id: d91f2a68-f53b-423d-eebd-08de95603e34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 ik6mOpXBOhXZxmI8mdjkmZ2y5s8WjN96HLJZbpNSeEUKSlj0Jc0QxAhdKy5WeLk1LTKhDInSAggMq67+yBPjl3oIOIUE47sOOkHfznYQOI4AEPnc0fPwiP/CZjBpKmb9teVreGB9EshT7MB91qw3uUtlyK43hprpk69qhDNhHtxua1qsilyBEJk3Q0hS3sMlezp20bIMBILdeRRGDTHhGg+0eXBGa/sJu1PYfo65hi9axHo297oqytWoBB/CK0A0XdzhRfcAvp5GYp8+vi6wtAPvDwyFoSp25ZQMq9ybByxf88YACO2ZK8UjpqUSW2DqSPJe1LhN7kEoHUIXBkFWgNdykxvO84cDW8LXJ72jv9sxDxFbz3whS+M4u1OzBUaLdaf0ZY12WUQsXU91xzIXQWy7Z0Tg3oUA1Duc0v0+WqjR0kIQ207Fop9j/w+7zgeEVoToLLgrhTZCi+PCQgDykZVpRgCBdWnZsH25BBU0CUcLYMc+KXYQwoVJHFl11LC9DwUQk4NbzvnmGQT+nt0uvQu/djF1LbTiocJmM21tlXWI9bAmk+npTl0WIC3kfhxkvyXyLE7cGFJPtXnRU4McP2Ya5LzIfqWxW6mfG3MqtQ8SBIxsI2YgYhmfs59whqary14t99/Y9nio5HHakY4HKHL3SZdTbqVawZvjdAR1fXkAGAm/FqQCagitYmLwwD+cl4QRGZvQZSP5mYJ/lMxNw2Pa/Ehn1+SWNZJj4Hq6xuVRedVcBeIPDWKH+67bHZEbiYqHdd5xLno3czGFQ1ktH3MiNZoy1KE5jQY2modWxe4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7284.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1l1NVlGRVlRMVhrN0VkQkkvVy9VRDlPUy9DWjk1M1dHMWFTc2licUMwOU5z?=
 =?utf-8?B?alR5eG5lYndQQmpwak44emx0N0FYRkNKRXlJZWVvQWtiTHp2S0VWVE5ZVDRj?=
 =?utf-8?B?OTFEN2ExZDBJQXVRRkt5N2tSS3V3RW45bHo4dWNhM2tBOTNQZlhMRERXcE1m?=
 =?utf-8?B?U2FEU2hCbGt5amNRUmp3czE1SDNQQTg2ZXdTQ2hidjhVQTNUbjNXZEFQb1Jv?=
 =?utf-8?B?bzg2aTNhamdsa0tnVEt1T2QxOHhtQmFWK3ZWdkJNekV3a2NnYnc5Vng0TmJI?=
 =?utf-8?B?U0l2R25EaXg3Q3RIaWhCTm9ybEhnWGdhUXAzR1FNMzhnejN0R0xENmdzTkpW?=
 =?utf-8?B?dlBCc1dBM2hRZEpaV2pzbW9Za1dZd1ZiNmtPbmw1REJYbVN5Vy9JclozYUlQ?=
 =?utf-8?B?YzNJbXcwTDhZNXZyK1dZU2kxUDlkK3ljOWpMZ2RCMHF6dkJGSHRyTityZlds?=
 =?utf-8?B?d2w5SzVnTG9udDA3bVRPODgvajZZN3ZBQ3ZFNU1WT2trWUZ1bnFCYWRzRS9l?=
 =?utf-8?B?dUVhdE10RW5zaXpEeUF1cGl5cEhweEx5WUVNK2RnazVJK1JVM0o1d2lPSVRS?=
 =?utf-8?B?Z2t2Z3hoVmxFeDAydWNzYjJ4WjN3TVg4dU9Wa0RRMlhKakxKUnlqS1BsVDhn?=
 =?utf-8?B?N1A5ZlZqSWduek4wWUJmZ3duZXRQNExUR2dMSFYzN281NFp6WS84ZFhPVTk2?=
 =?utf-8?B?VUVLUUxaN0k4TXBTMWdWUjVkTXZIT0IrUWlXS0U5T09vQng3UUdzbEtRL2lR?=
 =?utf-8?B?czdnRWZZTU1Edjlsc2NNWmNURW1laCtuUjJsZkVFakhpVk5aOVU2enVFa3Yw?=
 =?utf-8?B?NDAweiszN3l2QlFUVkZoVWdWblFXQjUxV1hnY25WeXdYdzRWdmxmTEtmc3ly?=
 =?utf-8?B?amtWWnN1aDV5a1pURFQ1UnVSTFoxdXdiYWlkMmdITm82QVkzTEhxaXROV3Fl?=
 =?utf-8?B?cFVNTjl3a24vL2tVbW1jRHdlY0VrQVZsYTZ2TU5yQThkaUR4ZmdzWXI2L1ky?=
 =?utf-8?B?akp0bDI4d0RsVVZYZmI0U01uKzJXcWl5emEwUXpvbE45T1RucmxGc3VHK2pr?=
 =?utf-8?B?N1VINkdVRHVSbW1LbGpOU1liN0tBNVQ3LzQrdHBWM00ySVVLenk2cERpRXBJ?=
 =?utf-8?B?TDdZcS9sUnFlbFU5ckh1VG1ITnhzQmRJaUl4QXJZQlFwK0RzZWZQRTJCNk9M?=
 =?utf-8?B?UExFcTA1NlJZVHV2RnFUWEFBVWZEdThXMzBKRitIZGpPcnVvK3lxSFpyTkpV?=
 =?utf-8?B?NFZVeU4xSERZT2pVc0EySnVNTEV2b2FQS2gyOFQ0dWh2dFdSa09zRGVnbUJU?=
 =?utf-8?B?enJMT3dMeGpBU2VBbEh1QWNBMkl3M3hmYTZsTW1mc3h3cjZJdW15TmllUGFZ?=
 =?utf-8?B?bUhmTW1XZ3J6aW5NZXBYU1R3SXhQMXRGb3AzTmRFdWxkN2VOM3FySkZaaHdh?=
 =?utf-8?B?UmUwK2N0elgwWEoxc2c1MmtvZ2w4cVBybkFzNXc5bmN3YTMxOTJtTm5wRXlw?=
 =?utf-8?B?RDBGdnFWUlFUUnc0RXU5c3ZlK3N6bHlxTVFCWjlYZmVRek5aajZEOG14ZG9E?=
 =?utf-8?B?RFRKbmZUUHo0aU5hc05teGVJbTdlUVFBVWxyUWh4SE9aaWpEUjd4MHVmemMv?=
 =?utf-8?B?Vi9SdWhKYjZRUU5ia2xlSGhxOFRNdXlIdFdQOGpaWUJBdG5WcjJJcmFiWk9r?=
 =?utf-8?B?VVRVYW9PMGlMK0R1TFhSRGFJcy8vSFlKTzlMQUlwci9UdzlwcUpEZTM1YTFa?=
 =?utf-8?B?NTBVTXhtQUIrSUYvZTJVbkIrQ3M1M2dtbGhEa3NvTjFreWFhV0liQmhMVFg5?=
 =?utf-8?B?SUQ2cFRTTjlHbzBTclJ4TmtVME0wamlBR001TUFJTlhrcjNGVEZyQUlMamVP?=
 =?utf-8?B?VG5FcGdjdE1jU0pNT3FXZ2NuamJ2MVlMMnltVjRNVXVYOVpacHVVZHpLeG5h?=
 =?utf-8?B?WC9aVTlmOVVhRVVlNWFydVk4TlNFNUI1dTRHZ1dsd3lJU1BLbzN6VXpMbUd5?=
 =?utf-8?B?ZjYveFhRQkRZYUtaREorNXFoYklma0YyV2NhbFBOY3lPTEdmdmM4dm1aYnlM?=
 =?utf-8?B?SEJHUjVKUCs0eTdZcTJJeTBQNytlelVHbmFkZWVsamJRSm9Ud0g2Y0ZGM3Q3?=
 =?utf-8?B?aXhnTVdIQlR6cUw3YWdhS0lCOUJlNFYxd1BWT0hTeXlFdUVNdVk3bGwvc2Vm?=
 =?utf-8?B?MUFEVk9mTG9xVGtpeFhPUEs3S0NqaWpoampUUnpwdTg1T0gxeGdKMjExcTBI?=
 =?utf-8?B?eU5XQXlkbDVsU1JSV3FWK1Eya1RSZ29KU0R1cFRpQmdycVJIb0NtcmpQRkxk?=
 =?utf-8?Q?nVGgaeL9+KjwckaL3r?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7284.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91f2a68-f53b-423d-eebd-08de95603e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2026 11:16:12.5997
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BX3zTdGAIKl0Cid+C91DJqqa8Y1ql6TCshydfYCQvYF4Ggv0+AiZYysVQgLLze6MoPs4A9oROrjQxfHqfkBJGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8320

PiA+ICtzdGF0aWMgdTMyIG5ldGNfZ2V0X2J1ZmZlcl9wb29sX251bShzdHJ1Y3QgbmV0Y19zd2l0
Y2ggKnByaXYpDQo+ID4gK3sNCj4gPiArCS8qIFRoZSBCUENBUFIgcmVnaXN0ZXIgaXMgYSByZWFk
IG9ubHkgcmVnaXN0ZXIsIHRoZSBoYXJkd2FyZQ0KPiA+ICsJICogZ3VhcmFudGVlcyB0aGF0IHRo
ZSBCUENBUFJfTlVNX0JQIGZpZWxkIHdpbGwgbm90IGJlIDAuDQo+ID4gKwkgKi8NCj4gPiArCXJl
dHVybiBuZXRjX2Jhc2VfcmQoJnByaXYtPnJlZ3MsIE5FVENfQlBDQVBSKSAmIEJQQ0FQUl9OVU1f
QlA7DQo+ID4gK30NCj4gWyAuLi4gXQ0KPiA+ICtzdGF0aWMgdm9pZCBuZXRjX2lwdl90b19idWZm
ZXJfcG9vbF9tYXBwaW5nKHN0cnVjdCBuZXRjX3N3aXRjaCAqcHJpdikNCj4gPiArew0KPiA+ICsJ
aW50IGJwX3Blcl9wb3J0ID0gcHJpdi0+bnVtX2JwIC8gcHJpdi0+aW5mby0+bnVtX3BvcnRzOw0K
PiA+ICsJaW50IHEgPSBORVRDX0lQVl9OVU0gLyBicF9wZXJfcG9ydDsNCj4gPiArCWludCByID0g
TkVUQ19JUFZfTlVNICUgYnBfcGVyX3BvcnQ7DQo+IA0KPiBJZiB0aGUgaGFyZHdhcmUgcmVnaXN0
ZXIgcmVhZCBpbiBuZXRjX2dldF9idWZmZXJfcG9vbF9udW0oKSByZXR1cm5zIGEgdmFsdWUNCj4g
c21hbGxlciB0aGFuIHByaXYtPmluZm8tPm51bV9wb3J0cyAoZm9yIGluc3RhbmNlLCBkdXJpbmcg
YSBidXMgZXJyb3Igb3INCj4gcmVzZXQgc3RhdGUpLCBicF9wZXJfcG9ydCB3aWxsIGV2YWx1YXRl
IHRvIDAuDQo+IA0KPiBDYW4gdGhpcyBsZWFkIHRvIGEgZGl2aXNpb24gYnkgemVybyBwYW5pYyBo
ZXJlPw0KPiANCj4gU2hvdWxkIHByaXYtPm51bV9icCBiZSB2YWxpZGF0ZWQgYWdhaW5zdCB0aGUg
bnVtYmVyIG9mIHBvcnRzIGJlZm9yZQ0KPiBwZXJmb3JtaW5nIHRoaXMgY2FsY3VsYXRpb24gdG8g
ZW5zdXJlIHRoZSBkcml2ZXIgZmFpbHMgZ3JhY2VmdWxseSBpZiB0aGUNCj4gaGFyZHdhcmUgcmV0
dXJucyBhbiB1bmV4cGVjdGVkIHZhbHVlPw0KDQpJZiB0aGUgaGFyZHdhcmUgaXMgc28gdW5zdGFi
bGUgYW5kIHByb25lIHRvIHN1Y2ggbWFsZnVuY3Rpb25zLCB0aGF0IHdvdWxkDQpiZSB0ZXJyaWJs
ZSwgYnV0IEkgYmVsaWV2ZSBpdCB3b24ndC4gVGhlIEFJIOKAi+KAi3JldmlldyBpcyBiZWluZyBh
IGJpdCB0b28gbml0cGlja3kuDQpBbnl3YXksIEkgd2lsbCBsbCBhZGQgdGhpcyBjaGVjayB0byBh
dm9pZCBBSSByZXZpZXcgd2FybmluZ3MuDQoNCg==

