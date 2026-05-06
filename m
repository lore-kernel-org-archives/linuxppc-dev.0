Return-Path: <linuxppc-dev+bounces-20502-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9C8CD342C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2026 07:06:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g9RJK4MWcz2xdh;
	Wed, 06 May 2026 17:06:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a01:111:f403:c200::5" arc.chain=microsoft.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1778051201;
	cv=pass; b=ZFLPaBLvS0qEHwvQZ1ZgpmWR6AHmtc3j09SXZM/YasKGo6trxNFELx33F0wqklJKm1HQpe0QDNZACjrd+mg+WcU6lMGAB1ao6CvB6O3YHBd9BDmXUZFKRtbEXGtx48sLJ3S4CuxE0LmeZTGYUOMkJubifb92YqZkDJ/zbO6812Aq9XHLm135HSiJvC5dx5fNT3JHW+qn7X0sX1MmCNZxWRXXOrZVfuJ2vAaJENHEQAvTHIRel8XGepDJAoZ+L/uuejZGUTjFRHiyY0Mpu0PKS9Jr5CsleNAtEPqGB3gtCdwqnj1LgKf7gi6G91l5YG39EMHUxvGZZQPfVy6Uhu5uiw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1778051201; c=relaxed/relaxed;
	bh=NXic7DHtMH70C98OTHNdqdzTb6Y0Ifmthcx1ja9CGV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PuM/TJGnBGv49C0XlqupfXJJ0ZWvpEc3fp7I7c1u+F9lkgQKrB1J2bJ132fRHEbpmopXTWoIbgGk+rty03aw0seuEElxHBBP5Rgu6ZAhMpdtFGbisYFWjHKel3TOeDczaFOj1lifCgpEtXI2ArFXbxthrKttEYvTyklSyJjTsjZAhIScVGpuTqIOtCYc6iO4XgFagVpmHCWIKcs8dj3eEhC+Lfh7cq2Z3onBmQYae1/i55nnTPTSKxvXwVvm6zPTbJMXrHVnjeOw9W25AF1Z94Fk0x5sjyW9Bvok+m7aTroNjr9IFkBNBOLqNIWIT1HjRFdlJ3hYEEGyBKeZT1AcSA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com; dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MYPeH8eE; dkim-atps=neutral; spf=permerror (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org) smtp.mailfrom=nxp.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=MYPeH8eE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=permerror (SPF Permanent Error: Void lookup limit of 2 exceeded) smtp.mailfrom=nxp.com (client-ip=2a01:111:f403:c200::5; helo=duzpr83cu001.outbound.protection.outlook.com; envelope-from=wei.fang@nxp.com; receiver=lists.ozlabs.org)
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazlp170120005.outbound.protection.outlook.com [IPv6:2a01:111:f403:c200::5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g9RJJ2szvz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 May 2026 17:06:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqhPsl4oZqByI7kQ4l2Nek6d8o0UdIsWBu2pseoHRXP7/yIoxNBNz7FPCvXLdASzLkwmKa+KaED18OAc226nuI8WbVni2NOP+dKkhVYElOy0XPFPzaCWZwZuW3tt1CZ7E/q2xb/g/RpuAhknTyv1nOut8QJRXgLyGu+qi7bjXfV4J/aVXvm5uiAwajSA7xsumEjHkAomawmczw4ayDo+Ml7CSFtBIVOnthJBopt7vdA/ggujcoEwHu9Cky8GS+yho54aNpnDm8kiwQayMzyAh+XZ9UkO7zd6cOVhh9mVW1QYFj1V37mUGNINLs3jbcXGkkYlKAYkfDLy1C8s82vadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXic7DHtMH70C98OTHNdqdzTb6Y0Ifmthcx1ja9CGV0=;
 b=Dlpus0FwjmDFuvFhlwGehRRySazw5Y5qaW0lrBr0IpRWGMZcHqlAlDyjcB5aspcge1wDV+G16LR2lWefqb2GB+bCLAALQL4VhtKNQXWXonERUdG1bZD5Rt5CnQmD1ctDEhL8hM6BPabtYR4Vh6POQliHw/JHkXKAAla6j9Qym+1neopcwRKCCJcN7MBQNiTIEHDjhBUzng+wiV7MfEa4fWW7Bp5X7IhGCtfFjfutigqz2GeChcOMWlQnPINX6gZGdTGrXd/CEVgqgxiJ+6KN2nhPU/NCyJFvNq4pMyN381YPNoWjUaXNAEQ9NKEH4t0mScLFd8r3LTpS21HcpRcktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXic7DHtMH70C98OTHNdqdzTb6Y0Ifmthcx1ja9CGV0=;
 b=MYPeH8eEyjYgM3LyP3aPeSetEBHaV7OBubMtLgCFoPkRa5WJ4cDnK7mMJ300kKBuIbEEU2MScWS/fZW+cbZc4Dmt9xpEqF7ZZw0zF+uaZcct+SnJAdH1gfwzjgz+DgPQY5cR8R7eh3XmxIE41AVfvfBD4ux+/5s368IknXnXbCEroc0nzSNiFbqWjuHAp9/NM2W0vJPr9/sq7LhQnLP3yNvIZ9SUiwWU1rCGPLfW0M0gvZX4WUeZHddUaZDWmIJTfxP3V4Y6W8AgpKKS9vEbo0NvaikjOWoaNG18et696HVXIP1uDLPUp/xXawqe7eJ9zQl31TEBMGH0UCwwM161Og==
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB8068.eurprd04.prod.outlook.com (2603:10a6:20b:3b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 6 May
 2026 07:06:15 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 07:06:15 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, Frank
 Li <frank.li@nxp.com>, "chleroy@kernel.org" <chleroy@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>
Subject: RE: [PATCH v5 net-next 15/15] net: dsa: netc: add support for ethtool
 private statistics
Thread-Topic: [PATCH v5 net-next 15/15] net: dsa: netc: add support for
 ethtool private statistics
Thread-Index: AQHc2EvvKHBCmE+B9U+MrelUmBkfarX/NsOAgAFevYA=
Date: Wed, 6 May 2026 07:06:14 +0000
Message-ID:
 <DBBPR04MB75005341C32C4798BA08D503883F2@DBBPR04MB7500.eurprd04.prod.outlook.com>
References: <20260430024945.3413973-1-wei.fang@nxp.com>
 <20260430024945.3413973-16-wei.fang@nxp.com>
 <37382811-ba47-4432-9911-6c39acea4f86@redhat.com>
In-Reply-To: <37382811-ba47-4432-9911-6c39acea4f86@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7500:EE_|AM9PR04MB8068:EE_
x-ms-office365-filtering-correlation-id: aa0bcaba-2ac4-45e4-6033-08deab3df67d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 rnE+BO0nIswEtT0siWV4vpDrE6lLtQkdww8Vpw9H8qt5n95NVxw52yO3Xl6MtHJwGBVv4I9NQ9fHWGf2dFVHErjzL/ABiV0NltI0NM+nG3aDZrjIm9mxN78fgt96lgCpyX/J4trnwajMPnGZXtC96gaYmJLZbI4vuXmQsrQTEHSBTbHcoHyuyTcqH6sxo4svH70Co0/kTJih+7TzIo7DadKcs6NH0JfrZYFUZyjPXDvquAbdd5P+a0Hm9RVvVPDxvAR8+abb+UdEDCKbsjPSokEwKBrQWpZNjiWxXHCi22VwM5r3HCGihjA/l1fjPxUSehmBqEmtPKzu5XJ+WDyNvUQvbxFmutrlYddGIpsN4kThqSeiTB3LN+fH/vf+b99njWOrSZMI586bbAjI4//pZk+Xr7AuGdopnCOJWM2usJXwPdgY5fBY619RzYcVdLMC888MbdGK0/V4tDMQ4KXiwB97vNZGeN9HrwS+/Y+A5pfDjFeJpLAP124/QyVyb8TdzjLMi1Tp7J7IQJxe9tOpW0MWM8gMLFRcmqQnx5jk9HmOzIxgT28pUa/QHNr5gjX23LpDPYSW6Nq0ZbtbPU6E9nIyDbgZ3r+G6plo5ZzFPgWfWp7PGnCQAuWSZN0awJjeHH1tz8ssG0S7XUaL0FcdPdDn4DJ/nZSQe1cGda4u/iYj2lNJR+slp16xMHgdcK53QlLCnVeS8CZz2aQ9WuQCY8fpZVVPyx7IsO6M/vpaqtaq7v7/2VfP1MkC1MpmMQ1g
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3YzU3Vrc0diT0hNdE1uWUpoWThhc1hKSmVNc29HdFlBQ00wUklCWXFBSFo2?=
 =?utf-8?B?MWdLNU1KRHV0ZndCd0RLTC94WHhpRjlLNG5hS3BZaVRmOVlXR3JhSHRYaWht?=
 =?utf-8?B?UmZwV2ZmYjgxNHN3RUQ0dDBkZjg0ZXA5U1JqZTl5dTg5eWZyYjVtVkZYUUow?=
 =?utf-8?B?R0M5Q0FDZStPU3RmUVlyQXJ3YzUzWFhyOU8vTzdWUVZuaGlnMWlxTnpnYU5n?=
 =?utf-8?B?TFVyQ0IwbFYrWU84V1dBWWZON1FzTVpIM3JXeUJTSmgyWFJmd3doM3JqVEE2?=
 =?utf-8?B?N3J0bFBTeXUyelE0d3ZLYzRjZTJvcFNvaW80NGJyL3JNQ3pGNU90UEN5VFRl?=
 =?utf-8?B?MDQrU1JOVmFWWXY1Mk1qTEgzeHl0bEFtd3JDMXgzdmJ3enFaTWdCZUlCMFds?=
 =?utf-8?B?YU5BQVllWUg2T0tBQkFJNURvK3M4c0ZGN0lsYXZoU0FKd3JJZjlQVG8vNGtW?=
 =?utf-8?B?TWlvQ2ViVm1DRCtjbUIyRVlDZXJ1dFBFL2hVWEtkMDROYTNvQzJxRXd1Z0d0?=
 =?utf-8?B?QTFCNUpBZ0gzYld4UDlES1FrVURXTWs3cTFBZVVEekpUNmJoQkxFUGpkZE41?=
 =?utf-8?B?ZTJuMUc2UlNHRkFEcG1oWkdNajk1dk5PY3NqUTVYQWxHQlB0WFhmbEVuZ2o4?=
 =?utf-8?B?SEhDblRnRUZnZ1huVDZGenRMYWY0TTR5OWl6S3F5VTUxNk83cktFTWthMEpF?=
 =?utf-8?B?U1JOby84WWFQQVgwbHFMSmRSSDJiYjkyTHErTktOaUVkd2JLOElJdHVpZkdq?=
 =?utf-8?B?c2lBa0ZLY0ZTUlhZMU92TFYzTTh5V0JObXR0bXR4UHVNVlR1YnJLc1VHQ09N?=
 =?utf-8?B?WTlzUGFJOGZhbE1NVDFMcU54dWxlT3c2RHlLK2taTEpiOFFhaUtxYUNlSlR3?=
 =?utf-8?B?ZklpdkxnS0drbmw2OUdveXMrblB5OHZhanI1ODMva3FEZ1dFd2NMcHFQVVJv?=
 =?utf-8?B?YXRPSFV6RUU1Qi9ZdmcraC9qUkdhRW9tK0QrRmxNT3RzeGlxM25GWFRndzNT?=
 =?utf-8?B?S2R2SzhBWW9BancrbWlBRktyODh6QTViSjd1akVGeGN6blQxeTdrZlRLNXFh?=
 =?utf-8?B?OXNRN2M5S29BZnBhYkJJVVlYTTBQV2ZZWXBMNTVzUW9ZZ2wwZ1JvMGR0eEZZ?=
 =?utf-8?B?N2NXNDFsbUhWdjBiWHJibXdmeTRuTDBmZjNTOWhocnJDd0hISjJZU0FHbmZI?=
 =?utf-8?B?ZnlKTXZvclNTb1dOY2tRT2xpbnFidVkzU05tMDI1VXVkays2cXEybHdpS0Ew?=
 =?utf-8?B?dTFTYkozRjlIR3QwMTBtMzlac3VuaGNvaUN6dVplK1RwV0UvOW5mNEZWU3hp?=
 =?utf-8?B?ZVI2R1lrNWU0bnBKUXJGamExZ3VNdDBtZlkyd1lqbG9IQzJlTW84clQ3a2N1?=
 =?utf-8?B?cUQ5eGRMOXhDT0pNVVFPSmZiSmNQRVhialJEZ0FzWlVBYVUyOFBQUFQwcldv?=
 =?utf-8?B?TGYyWkxoNm8vNVVIZUw4eGxyZGFPRno5SEpPY0I5SUg4R0pBejN5dWdOSlhz?=
 =?utf-8?B?MGlLelBrQStoZ2I5UGdYZDZDbTF0UkxJQTJHaktZUFBMV3JwL0kyeGh0MExw?=
 =?utf-8?B?Sy9zdFhUL0tjVDR0SlVQRm8zYWFBMks0Mjkwb2ZKUjJJWkJHb0MrZWJLS3ZB?=
 =?utf-8?B?R0FReHVySTlRNmJUWFFvMm9nZVRyblUvWmxoUnJqQWVFUllBT2xkalRDakd5?=
 =?utf-8?B?dkZRZFlKY0NNUDQ5c0Erd3lHa3hIZERheUN6cGdkenRkZ1lyOHEzRC95cElu?=
 =?utf-8?B?SUtUa0ticSs4K1VnTVlMUkNsZHl4c21ndjR1SzFiWmpIVWtKWGxZNGNtL2lw?=
 =?utf-8?B?TVJMQWUrM1IySXQ5RHJKanZ2MEs0dVYxMHRoQVc5c2pyODBSRjNXQ3lKaEFG?=
 =?utf-8?B?Ky9kOE9JZXIrb3hxWU5kdGR4Y2QvalJqNFlVRjlDQ3h4N0NWWDFlamVFNW9X?=
 =?utf-8?B?Uk9HQ1lOUmRVOWxuak1mZlRteElhdTZNNzhEdFNoTGZObWFVb3g1VGxUTUFI?=
 =?utf-8?B?WFdhckVnSEowS1pmeFZuem1LM3Nzb2JiZ0ZTUVVBdVd2TVpuQmU4a2xnYjRU?=
 =?utf-8?B?dCtZZlJvc0N5SWU4anNsd0l1bkVUYkpwd1FnYkpMWTlEN1ZxSmdhMm1SQ1E4?=
 =?utf-8?B?TmZsZjMwM3hGQk9POHhMdFlHQmY4NFpkYVNDMDlvRjRYc2dFZVdRMTZZbFZZ?=
 =?utf-8?B?OXo1dHcvWXRWVFQ5M00wekoveDlMQlMyaUQ2bnBsWjJ0VS9xNEJHdHRBV044?=
 =?utf-8?B?MXk4Vi9sa1QzWVU3MGNxdVdvRFhBSHo1N2FFR3pKbW9zK0xxcmJPN3VOcUd2?=
 =?utf-8?Q?OMfvW60YqIGz5XM7D1?=
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
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa0bcaba-2ac4-45e4-6033-08deab3df67d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 07:06:14.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASd/N0xioz2IyjxVRo+/3IFcPITw0P0IdNrWV5QEfaLp71mLM47dZryinWDDuLPKspCFqaRsa+PymoP/gFi8iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8068

PiBPbiA0LzMwLzI2IDQ6NDkgQU0sIFdlaSBGYW5nIHdyb3RlOg0KPiA+IEltcGxlbWVudCB0aGUg
ZXRodG9vbCBwcml2YXRlIHN0YXRpc3RpY3MgaW50ZXJmYWNlIHRvIGV4cG9zZSBhZGRpdGlvbmFs
DQo+ID4gcG9ydC1sZXZlbCBhbmQgTUFDLWxldmVsIGNvdW50ZXJzIHRoYXQgYXJlIG5vdCBjb3Zl
cmVkIGJ5IHRoZSBzdGFuZGFyZA0KPiA+IElFRUUgODAyLjMgc3RhdGlzdGljcy4gVGhlIHBNQUMg
Y291bnRlcnMgYXJlIG9ubHkgcmVwb3J0ZWQgd2hlbiB0aGUgcG9ydA0KPiA+IHN1cHBvcnRzIEZy
YW1lIFByZWVtcHRpb24gKDgwMi4xUWJ1LzgwMi4zYnIpLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0
L2RzYS9uZXRjL25ldGNfZXRodG9vbC5jICAgfCAxMDcNCj4gKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gPiAgZHJpdmVycy9uZXQvZHNhL25ldGMvbmV0Y19tYWluLmMgICAgICB8ICAgMyAr
DQo+ID4gIGRyaXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfc3dpdGNoLmggICAgfCAgIDkgKysrDQo+
ID4gIGRyaXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfc3dpdGNoX2h3LmggfCAgNTggKysrKysrKysr
KysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAxNzcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfZXRodG9vbC5jDQo+IGIvZHJp
dmVycy9uZXQvZHNhL25ldGMvbmV0Y19ldGh0b29sLmMNCj4gPiBpbmRleCBhYzg5NDBiNWE4NWMu
LjhkMDRkYjUzNDM0NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbmV0Yy9uZXRj
X2V0aHRvb2wuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9uZXRjL25ldGNfZXRodG9vbC5j
DQo+ID4gQEAgLTE5LDYgKzE5LDU2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZXRodG9vbF9ybW9u
X2hpc3RfcmFuZ2UNCj4gbmV0Y19ybW9uX3Jhbmdlc1tdID0gew0KPiA+ICAJeyB9DQo+ID4gIH07
DQo+ID4NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBuZXRjX3BvcnRfc3RhdCBuZXRjX3BvcnRf
Y291bnRlcnNbXSA9IHsNCj4gPiArCXsgTkVUQ19QVEdTTEFDUiwJInBvcnQgZ2F0ZSBsYXRlIGFy
cml2YWwgZnJhbWVzIiB9LA0KPiA+ICsJeyBORVRDX1BTREZUQ1IsCSJwb3J0IFNERiB0cmFuc21p
dCBmcmFtZXMiIH0sDQo+ID4gKwl7IE5FVENfUFNERkREQ1IsCSJwb3J0IFNERiBkcm9wIGR1cGxp
Y2F0ZSBmcmFtZXMiIH0sDQo+ID4gKwl7IE5FVENfUFJYRENSLAkJInBvcnQgcnggZGlzY2FyZCBm
cmFtZXMiIH0sDQo+ID4gKwl7IE5FVENfUFJYRENSUlIsCSJwb3J0IHJ4IGRpc2NhcmQgcmVhZC1y
ZXNldCIgfSwNCj4gPiArCXsgTkVUQ19QUlhEQ1JSMCwJInBvcnQgcnggZGlzY2FyZCByZWFzb24g
MCIgfSwNCj4gPiArCXsgTkVUQ19QUlhEQ1JSMSwJInBvcnQgcnggZGlzY2FyZCByZWFzb24gMSIg
fSwNCj4gPiArCXsgTkVUQ19QVFhEQ1IsCQkicG9ydCB0eCBkaXNjYXJkIGZyYW1lcyIgfSwNCj4g
PiArCXsgTkVUQ19QVFhEQ1JSUiwJInBvcnQgdHggZGlzY2FyZCByZWFkLXJlc2V0IiB9LA0KPiA+
ICsJeyBORVRDX1BUWERDUlIwLAkicG9ydCB0eCBkaXNjYXJkIHJlYXNvbiAwIiB9LA0KPiA+ICsJ
eyBORVRDX1BUWERDUlIxLAkicG9ydCB0eCBkaXNjYXJkIHJlYXNvbiAxIiB9LA0KPiA+ICsJeyBO
RVRDX0JQRENSLAkJImJyaWRnZSBwb3J0IGRpc2NhcmQgZnJhbWVzIiB9LA0KPiA+ICsJeyBORVRD
X0JQRENSUlIsCSJicmlkZ2UgcG9ydCBkaXNjYXJkIHJlYWQtcmVzZXQiIH0sDQo+ID4gKwl7IE5F
VENfQlBEQ1JSMCwJImJyaWRnZSBwb3J0IGRpc2NhcmQgcmVhc29uIDAiIH0sDQo+ID4gKwl7IE5F
VENfQlBEQ1JSMSwJImJyaWRnZSBwb3J0IGRpc2NhcmQgcmVhc29uIDEiIH0sDQo+ID4gK307DQo+
ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG5ldGNfcG9ydF9zdGF0IG5ldGNfZW1hY19j
b3VudGVyc1tdID0gew0KPiA+ICsJeyBORVRDX1BNX1JPQ1QoMCksCSJlTUFDIHJ4IG9jdGV0cyIg
fSwNCj4gPiArCXsgTkVUQ19QTV9SVkxBTigwKSwJImVNQUMgcnggVkxBTiBmcmFtZXMiIH0sDQo+
ID4gKwl7IE5FVENfUE1fUkVSUigwKSwJImVNQUMgcnggZnJhbWUgZXJyb3JzIiB9LA0KPiA+ICsJ
eyBORVRDX1BNX1JVQ0EoMCksCSJlTUFDIHJ4IHVuaWNhc3QgZnJhbWVzIiB9LA0KPiA+ICsJeyBO
RVRDX1BNX1JEUlAoMCksCSJlTUFDIHJ4IGRyb3BwZWQgcGFja2V0cyIgfSwNCj4gPiArCXsgTkVU
Q19QTV9SUEtUKDApLAkiZU1BQyByeCBwYWNrZXRzIiB9LA0KPiA+ICsJeyBORVRDX1BNX1RPQ1Qo
MCksCSJlTUFDIHR4IG9jdGV0cyIgfSwNCj4gPiArCXsgTkVUQ19QTV9UVkxBTigwKSwJImVNQUMg
dHggVkxBTiBmcmFtZXMiIH0sDQo+ID4gKwl7IE5FVENfUE1fVEZDUygwKSwJImVNQUMgdHggRkNT
IGVycm9ycyIgfSwNCj4gPiArCXsgTkVUQ19QTV9UVUNBKDApLAkiZU1BQyB0eCB1bmljYXN0IGZy
YW1lcyIgfSwNCj4gPiArCXsgTkVUQ19QTV9UUEtUKDApLAkiZU1BQyB0eCBwYWNrZXRzIiB9LA0K
PiA+ICsJeyBORVRDX1BNX1RVTkQoMCksCSJlTUFDIHR4IHVuZGVyc2l6ZWQgcGFja2V0cyIgfSwN
Cj4gPiArCXsgTkVUQ19QTV9USU9DVCgwKSwJImVNQUMgdHggaW52YWxpZCBvY3RldHMiIH0sDQo+
ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG5ldGNfcG9ydF9zdGF0IG5l
dGNfcG1hY19jb3VudGVyc1tdID0gew0KPiA+ICsJeyBORVRDX1BNX1JPQ1QoMSksCSJwTUFDIHJ4
IG9jdGV0cyIgfSwNCj4gPiArCXsgTkVUQ19QTV9SVkxBTigxKSwJInBNQUMgcnggVkxBTiBmcmFt
ZXMiIH0sDQo+ID4gKwl7IE5FVENfUE1fUkVSUigxKSwJInBNQUMgcnggZnJhbWUgZXJyb3JzIiB9
LA0KPiA+ICsJeyBORVRDX1BNX1JVQ0EoMSksCSJwTUFDIHJ4IHVuaWNhc3QgZnJhbWVzIiB9LA0K
PiA+ICsJeyBORVRDX1BNX1JEUlAoMSksCSJwTUFDIHJ4IGRyb3BwZWQgcGFja2V0cyIgfSwNCj4g
PiArCXsgTkVUQ19QTV9SUEtUKDEpLAkicE1BQyByeCBwYWNrZXRzIiB9LA0KPiA+ICsJeyBORVRD
X1BNX1RPQ1QoMSksCSJwTUFDIHR4IG9jdGV0cyIgfSwNCj4gPiArCXsgTkVUQ19QTV9UVkxBTigx
KSwJInBNQUMgdHggVkxBTiBmcmFtZXMiIH0sDQo+ID4gKwl7IE5FVENfUE1fVEZDUygxKSwJInBN
QUMgdHggRkNTIGVycm9ycyIgfSwNCj4gPiArCXsgTkVUQ19QTV9UVUNBKDEpLAkicE1BQyB0eCB1
bmljYXN0IGZyYW1lcyIgfSwNCj4gPiArCXsgTkVUQ19QTV9UUEtUKDEpLAkicE1BQyB0eCBwYWNr
ZXRzIiB9LA0KPiA+ICsJeyBORVRDX1BNX1RVTkQoMSksCSJwTUFDIHR4IHVuZGVyc2l6ZWQgcGFj
a2V0cyIgfSwNCj4gPiArCXsgTkVUQ19QTV9USU9DVCgxKSwJInBNQUMgdHggaW52YWxpZCBvY3Rl
dHMiIH0sDQo+ID4gK307DQo+IA0KPiBTYXNoaWtvIHNheXM6DQo+IA0KPiBBcmUgdGhlc2Ugc3Rh
bmRhcmQgTUFDIGFuZCBpbnRlcmZhY2Ugc3RhdGlzdGljcyBiZWluZyBkdXBsaWNhdGVkIGluIHRo
ZQ0KPiBkcml2ZXItcHJpdmF0ZSBldGh0b29sIHN0cmluZ3M/DQo+IFRoZSBuZXR3b3JraW5nIHN1
YnN5c3RlbSBndWlkZWxpbmVzIGluZGljYXRlIHRoYXQgc3RhdGlzdGljcyB3aGljaCBoYXZlDQo+
IGEgc3RhbmRhcmQgdUFQSSBtdXN0IG5vdCBiZSBkdXBsaWNhdGVkIGluIGV0aHRvb2wgLVMuIFN0
YW5kYXJkDQo+IGludGVyZmFjZXMgbGlrZSBzdHJ1Y3QgcnRubF9saW5rX3N0YXRzNjQgb3Igc3Ry
dWN0IGV0aHRvb2xfZXRoX21hY19zdGF0cw0KPiBhbHJlYWR5IGV4aXN0IGZvciBjb3VudGVycyBz
dWNoIGFzIHJ4IG9jdGV0cywgcnggcGFja2V0cywgZHJvcHBlZA0KPiBwYWNrZXRzLCBhbmQgRkNT
IGVycm9ycy4NCj4gQ291bGQgdGhlc2UgbWV0cmljcyBiZSBleHBvc2VkIHRocm91Z2ggdGhlIHN0
YW5kYXJkaXplZCBpbnRlcmZhY2VzDQo+IHJhdGhlciB0aGFuIGFkZGluZyB0aGVtIHRvIHRoZSBw
cml2YXRlIHN0cmluZyBzZXRzPw0KPiANCg0KSSBkb24ndCB0aGluayBpdCBpcyBhbiBpc3N1ZS4g
Rm9yIHRoZSBORVRDIHN3aXRjaCwgaXRzIHBvcnRzIHN1cHBvcnQgcHJlZW1wdGlvbiwNCnNvIGVh
Y2ggcG9ydCBoYXMgdHdvIE1BQ3MgKGV4cHJlc3MgTUFDIGFuZCBwcmVlbXB0aXZlIE1BQykuIFRo
ZSBkcml2ZXItDQpwcml2YXRlIHN0YXRpc3RpY3MgY2FuIGhlbHAgdXNlcnMgb2J0YWluIHN0YXRp
c3RpY3MgZm9yIGVhY2ggTUFDLCBqdXN0IGxpa2UgdGhlDQpzdGFuZGFyZCBzdGF0aXN0aWNzIG9m
IGV0aHRvb2wuIEhvd2V2ZXIsIHJ0bmxfbGlua19zdGF0czY0IHJldHJpZXZlcyB0aGUgY29tYmlu
ZWQNCnN0YXRpc3RpY3Mgb2YgdGhlIHR3byBNQUNzLg0KDQpJbiBhZGRpdGlvbiwgZXRodG9vbF9l
dGhfbWFjX3N0YXRzIG9ubHkgaGFzIHRoZSBGQ1MgZXJyb3IgY291bnRlciBmb3IgUlgsDQpub3Qg
VFguIHdoYXQgSSBhZGRlZCB0byBkcml2ZXItcHJpdmF0ZSB3YXMgVFgncyBGQ1MgZXJyb3IgY291
bnRlci4NCg0K

