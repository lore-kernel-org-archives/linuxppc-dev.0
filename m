Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C58C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:20:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ADC82086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yv/bOq9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADC82086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444fqR2lgkzDqNB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 14:20:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.87; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="Yv/bOq9Y"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60087.outbound.protection.outlook.com [40.107.6.87])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444fnk1lSDzDq7k
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 14:18:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bF8O07vI1w08O8TMA4dXKJmIRraxNgSDk3hGCXectU=;
 b=Yv/bOq9YTVeDzda+eq2/tnlf0rZuzBrqChfbdRxmUK3Q9yd9d0gCBMbNnCSEf+VbVs6xhR1Th2tjyXfWLkZWqP1eQdVLtp/yubYT7CwMeUql5CUKt72F1xbPaYXwBYiH4Akouwg/h8qIkEA4SnxWdxK3XrjlEDI2NShk5sGv6ek=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3025.eurprd04.prod.outlook.com (10.173.254.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Thu, 21 Feb 2019 03:18:40 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::d77:91ed:e5b1:81ee]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::d77:91ed:e5b1:81ee%5]) with mapi id 15.20.1643.014; Thu, 21 Feb 2019
 03:18:40 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCHv6 3/4] pci: layerscape: Add the EP mode support.
Thread-Topic: [PATCHv6 3/4] pci: layerscape: Add the EP mode support.
Thread-Index: AQHUsh00Gw2tbfNoe0K3WDzxJMy4MaXnJ+2AgAEELvCAAHd9AIABH5VA
Date: Thu, 21 Feb 2019 03:18:40 +0000
Message-ID: <AM5PR04MB329923904668287A2832A7D3F57E0@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190122063328.25228-1-xiaowei.bao@nxp.com>
 <20190122063328.25228-3-xiaowei.bao@nxp.com>
 <20190219112721.GA15442@e107981-ln.cambridge.arm.com>
 <HE1PR04MB3306890D5A1656EC818521A2F57D0@HE1PR04MB3306.eurprd04.prod.outlook.com>
 <20190220100614.GA27057@red-moon>
In-Reply-To: <20190220100614.GA27057@red-moon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21c57d38-abfc-4d37-38a3-08d697ab4730
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:AM5PR04MB3025; 
x-ms-traffictypediagnostic: AM5PR04MB3025:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtBTTVQUjA0TUIzMDI1OzIzOmZkcDcvWDh3MngwL3pzVlo1QVkyODIxY0Uy?=
 =?utf-8?B?bysrSDAxbmQ2Y1VmZnErY0pGVkV0b212cmZDZ0orSjhwaThjQWUxdk4wSmx2?=
 =?utf-8?B?TnJRcldGQlFCL1E3bEJxbkFIeS9zS1FGYWlWcGcvT1BwT0VBenVLMjRFK1h6?=
 =?utf-8?B?ekdNYlhkbjkrbkxSZjhKeW51K3V1eDdqLzhXaVJQRlk2UFdQdWw0TXpZSGtQ?=
 =?utf-8?B?VDVwV3ZlRUU5RitKR3NiMmkvRmNLZTRobGlTNWFDdXFLOUlLcDU3OVArNlFy?=
 =?utf-8?B?VS9OK0F4US96RHFrVmk5dXU1T3YzUGo0elh0R3hSL0RUQjJxVzhmbkpldlRt?=
 =?utf-8?B?NjZpbmo0UGtkNUlNMGZqaWJlS2k4QkVEZUJzeFN0R1h2UVdlMkhVeCsrZHV6?=
 =?utf-8?B?bE4vTE5RVndGaWdZSk1YUVVMSG03Y2gxMTYzYWJUeDVrcE40M0w2U09Ldlkr?=
 =?utf-8?B?VHRKbGtIZ1RTWTMyNXg1bGFWdlBManJ6ek9aUW1CTDRXc0VKZzJkQkV1K21p?=
 =?utf-8?B?WUk1Nmp1bllhVXNvQkIxSnVJem45MHUwdVFrbEJBZkpzVTZ1N3JxeDM1Sksy?=
 =?utf-8?B?MXpkbVgvV0lDNlR6WDNHOC94QzdMdDY0NzJqK2tNR09qWWtlMEp5VC9DN09O?=
 =?utf-8?B?RzA4ZHZQS2dUOFRIUzdZbW1LMlVwRDdrM0R3VE8xK1dUWmYyU2lhbTV1QkFx?=
 =?utf-8?B?M2pmT0lOaFZCbUlERWZIcTBmd1JqV2VmVEV1ZEdYVFhWM09rUnp5azNwZURT?=
 =?utf-8?B?UFVlcVFiWGoxWW9hQXVjNWdmVVk3Z2RDbnlKWDBMV0hua09BN2VyekNwVVF1?=
 =?utf-8?B?NHNJSENLa2pMV3NwYlNSSVZQOCtQQjBZK0hHUGF0SWRkRGw0SHlyQnBuUG40?=
 =?utf-8?B?SnBTRThzZTlKdlNpeno3UnhheXVPQmxRQ21wUWYzbmtqcER5T2ZCc3hra2Qz?=
 =?utf-8?B?eEwreWVtYWhmbUswb0hBdXVWZnhtYzJmL040aE1GUHdXcXZmaDVTT3BsR2w4?=
 =?utf-8?B?TUQvNHRNQmwzbE55dlhwUnZpUWVnNkxYdzBmTWlqVUkvOWZaRzh1TnhiRlIx?=
 =?utf-8?B?cjVYck5xaDNhMGJkekFmWTRhUXFaU1lNdi8zT2hXdmNTeExkNEVLUFVWTGxS?=
 =?utf-8?B?V21pL2tEaEFEc1g5SmNaM2Z2VXlTamVhS1BlV0xKUXpSb2ptZkNQOXhvMWpz?=
 =?utf-8?B?SUgxUjhFNnpKeUttQlVyMUJZK0gyQVBpaWRYK1RTejNMbit5MTVtUkVpWXJL?=
 =?utf-8?B?VkdOK0V2b2YzZUN6Q1dwNmQwSSsweUgzVGhDVzcwZW10NG8xdTFzYXBKR3NJ?=
 =?utf-8?B?dVJnNWltVXVlL3p3ZGVIWGZUeVk4MEVNdWhOVFdYZ29zcnhaREFQN3lUbHpy?=
 =?utf-8?B?NzlBa0hXSEl5UGZUNzVmWGN3VnRIWjYrT0JucEx4K1lkS1BxYk5JYzZxZ1By?=
 =?utf-8?B?eTJQVkJ1dXg0K1NKZE56SDZ2T29NUlNIOHFiWWtmWUUvRmVnMXFpUi9wR1VO?=
 =?utf-8?B?QStkSjZtbHFaMjJ2US9TUnhjNThpRE85cjczdEc2SUJHbkRiNmcvNXZFdjlh?=
 =?utf-8?B?ZVo4a2M4TnVYMmhyYWpwUjlVVTB5YWVweVpBbU1ZOU1DZzN6WkFuNytIRHJX?=
 =?utf-8?B?Y1laWnVBejJ4ZEZCMlZrSFAxdklhVXR3UTN6T0hOZDB5cmNPelZqUG9MM0tG?=
 =?utf-8?B?cCt1K2pWVFdiWVRjdTlMb1crSXBlVVFzeG9MdVlyQ0F0UlRGcXYwWjRJc3FY?=
 =?utf-8?B?WVdRTVJDV1V6dll4NUU2QVJ5b2xBRTFHZkRPKzdQbHdZSEJKVXBvN1BuTk9U?=
 =?utf-8?B?NVZYT0JxbzEzbWg2ODhwU051YW1USkMxUng3QThFcnhCUHI5VG5QV2xrOFNN?=
 =?utf-8?Q?VALOrv5Pbhg=3D?=
x-microsoft-antispam-prvs: <AM5PR04MB30250742D598968CC891C1FBF57E0@AM5PR04MB3025.eurprd04.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(189003)(199004)(13464003)(256004)(68736007)(11346002)(8936002)(446003)(26005)(186003)(54906003)(99286004)(316002)(8676002)(966005)(53546011)(7696005)(44832011)(476003)(486006)(5660300002)(9686003)(6306002)(14444005)(14454004)(74316002)(229853002)(97736004)(76176011)(102836004)(55016002)(6436002)(2906002)(86362001)(7736002)(33656002)(305945005)(7416002)(105586002)(6116002)(45080400002)(6506007)(478600001)(106356001)(93886005)(25786009)(81156014)(4326008)(71190400001)(53936002)(66066001)(81166006)(6916009)(71200400001)(3846002)(6246003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM5PR04MB3025;
 H:AM5PR04MB3299.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: n+gFzxUelyv5KnbtaDTv+6YVN7nmKOGmtyC+dsAYPyA8JVuBwnUS12OlT+U/7sFww0cB15+jNtaN1SFCkw49/sbqivloxyJEdhdlJvRfPJVnoMYsFzutPv6QiWMkGZF/CnogF2vq4FR0TWm5XAE3G9qQkj3V2+EicqKb97+HAEU+HbjiuckwVslZ5AwUEeFB85eSeQsuMMNPQLGAdXMcyqP3WZZri/4lvtqPQzHFAyXA0LEZ+p6fGcWo/hy2IOjg2tPyeewBGxJ+S91L59CYClnTZIHnRVrw23tPRFtmHvZHTiG9p7Bv0DfBLx1mjGB4Yd8w3VydPLI490w3jzjPwvFmg6mX+3R5CUCCiO7t9fZM7Co3tO69tiASD5gftoS3YO+AKy2D4FXybj+dSy2Q4iS7S7tK8vs000Ajq+3DtIw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c57d38-abfc-4d37-38a3-08d697ab4730
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 03:18:40.7707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3025
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, Roy Zang <roy.zang@nxp.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kishon@ti.com" <kishon@ti.com>, "M.h. Lian" <minghuan.lian@nxp.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "cyrille.pitchen@free-electrons.com" <cyrille.pitchen@free-electrons.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "pombredanne@nexb.com" <pombredanne@nexb.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
 Mingkai Hu <mingkai.hu@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4gDQpTZW50OiAyMDE55bm0MuaciDIw5pelIDE4OjA2
DQpUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQpDYzogYmhlbGdhYXNAZ29v
Z2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25n
dW9Aa2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNob25AdGkuY29t
OyBhcm5kQGFybmRiLmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBMaWFuIDxt
aW5naHVhbi5saWFuQG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBS
b3kgWmFuZyA8cm95LnphbmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7
IGN5cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5lQG5leGIuY29t
OyBzaGF3bi5saW5Acm9jay1jaGlwcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIdjYgMy80XSBwY2k6IGxheWVyc2NhcGU6IEFk
ZCB0aGUgRVAgbW9kZSBzdXBwb3J0Lg0KDQpPbiBXZWQsIEZlYiAyMCwgMjAxOSBhdCAwMzowOTow
MUFNICswMDAwLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lA
YXJtLmNvbT4NCj4gU2VudDogMjAxOeW5tDLmnIgxOeaXpSAxOToyNw0KPiBUbzogWGlhb3dlaSBC
YW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+IENjOiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyANCj4gc2hhd25ndW9Aa2VybmVs
Lm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNob25AdGkuY29tOyANCj4gYXJu
ZEBhcm5kYi5kZTsgZ3JlZ2toQGxpbnV4Zm91bmRhdGlvbi5vcmc7IE0uaC4gTGlhbiANCj4gPG1p
bmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IFJv
eSBaYW5nIA0KPiA8cm95LnphbmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5v
cmc7IA0KPiBjeXJpbGxlLnBpdGNoZW5AZnJlZS1lbGVjdHJvbnMuY29tOyBwb21icmVkYW5uZUBu
ZXhiLmNvbTsgDQo+IHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbTsgbGludXgtcGNpQHZnZXIua2Vy
bmVsLm9yZzsgDQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyANCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBs
aW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjYgMy80
XSBwY2k6IGxheWVyc2NhcGU6IEFkZCB0aGUgRVAgbW9kZSBzdXBwb3J0Lg0KPiANCj4gT24gVHVl
LCBKYW4gMjIsIDIwMTkgYXQgMDI6MzM6MjdQTSArMDgwMCwgWGlhb3dlaSBCYW8gd3JvdGU6DQo+
ID4gQWRkIHRoZSBQQ0llIEVQIG1vZGUgc3VwcG9ydCBmb3IgbGF5ZXJzY2FwZSBwbGF0Zm9ybS4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBaaGlxaWFuZyBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPg0K
PiA+IC0tLQ0KPiA+IGRlcGVuZHMgb246IA0KPiA+IGh0dHBzOi8vZW1lYTAxLnNhZmVsaW5rcy5w
cm90ZWN0aW9uLm91dGxvb2suY29tLz91cmw9aHR0cHMlM0ElMkYlMkZwDQo+ID4gYXQgDQo+ID4g
Y2h3b3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgtcGNpJTJGbGlzdCUyRiUzRnNlcmll
cyUzRDY2MTc3JmENCj4gPiBtcCANCj4gPiA7ZGF0YT0wMiU3QzAxJTdDeGlhb3dlaS5iYW8lNDBu
eHAuY29tJTdDNmY4NzcyYmE0N2M3NGQ4ZWUwYWEwOGQ2OTY1ZA0KPiA+IDNlIA0KPiA+IGI0JTdD
Njg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjg2MTcyNDU3MjYx
MTE5MyZhDQo+ID4gbXANCj4gPiA7c2RhdGE9YjNBY2owZnU3Yzl2U29IZTlWemVBa0VNYk1rcHlm
WVBzWHRmNmZBOEZsayUzRCZhbXA7cmVzZXJ2ZWQ9MA0KPiA+IA0KPiA+IHYyOg0KPiA+ICAtIHJl
bW92ZSB0aGUgRVAgbW9kZSBjaGVjayBmdW5jdGlvbi4NCj4gPiB2MzoNCj4gPiAgLSBtb2RpZiB0
aGUgcmV0dXJuIHZhbHVlIHdoZW4gZW50ZXIgZGVmYXVsdCBjYXNlLg0KPiA+IHY0Og0KPiA+ICAt
IG5vIGNoYW5nZS4NCj4gPiB2NToNCj4gPiAgLSBubyBjaGFuZ2UuDQo+ID4gdjY6DQo+ID4gIC0g
bW9kaWZ5IHRoZSBjb2RlIGJhc2Ugb24gdGhlIHN1Ym1pdCBwYXRjaCBvZiB0aGUgRVAgZnJhbWV3
b3JrLg0KPiANCj4gQ2FuIEkgYXBwbHkgdGhpcyBzZXJpZXMgdG8gbXkgcGNpL2VuZHBvaW50IGJy
YW5jaCAod2hlcmUgSSBxdWV1ZWQgS2lzaG9uJ3MgRVAgZmVhdHVyZXMgcmV3b3JrIHBhdGNoZXMp
ID8gQ2FuIHlvdSBjaGVjayBwbGVhc2UgPw0KPiBbWGlhb3dlaSBCYW9dIG9mIGNvdXJzZSwgaW4g
bXkgcGF0Y2gsIEkgZm91bmQgYSBjb21waWxlIHdhcm5pbmcsIGJ1dCANCj4gdGhpcyBzZXJpZXMg
cGF0Y2ggaGF2ZSBhcHByb3ZlZCBieSB5b3UsIEkgZG9uJ3Qga25vdyBob3cgdG8gZG8sIHRoZSAN
Cj4gY29tcGlsZSB3YXJuaW5nOiAiIHN0cnVjdCBwY2lfZXBjICplcGMgPSBlcC0+ZXBjOyIgaW4g
DQo+ICJsc19wY2llX2VwX2luaXQiIGZ1bmN0aW9uLCBJIGFtIHNvIHNvcnJ5LCBjb3VsZCB5b3Ug
aGVscCBtZSByZW1vdmUgDQo+IHRoaXMgY29kZSwgdGhhbmtzIGEgbG90Lg0KDQpJZiB5b3Ugd2Fu
dCBtZSB0byBhcHBseSB5b3VyIHBhdGNoZXMgeW91IG5lZWQgdG8gcmViYXNlIHRoZW0gYWdhaW5z
dCBteSBwY2kvZW5kcG9pbnQgYnJhbmNoIGFuZCBtYWtlIHN1cmUgdGhlIGNvZGUgaXMgY29ycmVj
dCwgSSBoYXZlIGFwcGxpZWQgeW91ciBwcmV2aW91cyBzZXJpZXMgYnV0IGFzIHlvdSBrbm93IGl0
IGZhaWxlZCBiZWNhdXNlIGl0IGRlcGVuZHMgb24gS2lzaG9uJ3MgY2xlYW4tdXAgc2VyaWVzLg0K
DQpTbyByZWJhc2UgeW91ciBjb2RlIGFnYWluc3QgbXkgcGNpL2VuZHBvaW50IGJyYW5jaCwgbWFr
ZSBzdXJlIGl0IGNvbXBpbGVzIHdpdGggbm8gd2FybmluZ3MsIHRlc3QgaXQgYW5kIHNlbmQgYSB2
Ny4NCltYaWFvd2VpIEJhb10gSGkgTG9yZW56bywgSSBoYXZlIGNvbXBsZXRlZCB0aGUgdGVzdCB3
aXRoIG15IHY3IHBhdGNoIGluIHBjaS9lbmRwb2ludCBicmFuY2gsIGZpeCB1cCB0aGUgY29tcGls
ZSB3YXJuaW5nIGlzc3VlLCBJIHdpbGwgc2VuZCB0aGUgdjcgcGF0Y2ggbGF0ZXIuIFRoYW5rcyBh
IGxvdC4gDQoNClRoYW5rcywNCkxvcmVuem8NCg0KPiBUaGFua3MsDQo+IExvcmVuem8NCj4gDQo+
ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlICAgICAgICAgICAgfCAgICAy
ICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMg
fCAgMTU3DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdl
ZCwgMTU4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb25zKC0pICBjcmVhdGUgbW9kZQ0KPiA+IDEw
MDY0NCBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1lcC5jDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+
ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0KPiA+IGluZGV4IDdiY2Rj
ZGYuLmI1ZjNiODMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
TWFrZWZpbGUNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZQ0K
PiA+IEBAIC04LDcgKzgsNyBAQCBvYmotJChDT05GSUdfUENJX0VYWU5PUykgKz0gcGNpLWV4eW5v
cy5vDQo+ID4gIG9iai0kKENPTkZJR19QQ0lfSU1YNikgKz0gcGNpLWlteDYubw0KPiA+ICBvYmot
JChDT05GSUdfUENJRV9TUEVBUjEzWFgpICs9IHBjaWUtc3BlYXIxM3h4Lm8NCj4gPiAgb2JqLSQo
Q09ORklHX1BDSV9LRVlTVE9ORSkgKz0gcGNpLWtleXN0b25lLm8NCj4gPiAtb2JqLSQoQ09ORklH
X1BDSV9MQVlFUlNDQVBFKSArPSBwY2ktbGF5ZXJzY2FwZS5vDQo+ID4gK29iai0kKENPTkZJR19Q
Q0lfTEFZRVJTQ0FQRSkgKz0gcGNpLWxheWVyc2NhcGUubyANCj4gPiArcGNpLWxheWVyc2NhcGUt
ZXAubw0KPiA+ICBvYmotJChDT05GSUdfUENJRV9RQ09NKSArPSBwY2llLXFjb20ubw0KPiA+ICBv
YmotJChDT05GSUdfUENJRV9BUk1BREFfOEspICs9IHBjaWUtYXJtYWRhOGsubw0KPiA+ICBvYmot
JChDT05GSUdfUENJRV9BUlRQRUM2KSArPSBwY2llLWFydHBlYzYubyBkaWZmIC0tZ2l0IA0KPiA+
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiA+IGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiA+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uZGRjMmRiYg0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2Fw
ZS1lcC5jDQo+ID4gQEAgLTAsMCArMSwxNTcgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4gPiArLyoNCj4gPiArICogUENJZSBjb250cm9sbGVyIEVQIGRyaXZl
ciBmb3IgRnJlZXNjYWxlIExheWVyc2NhcGUgU29Dcw0KPiA+ICsgKg0KPiA+ICsgKiBDb3B5cmln
aHQgKEMpIDIwMTggTlhQIFNlbWljb25kdWN0b3IuDQo+ID4gKyAqDQo+ID4gKyAqIEF1dGhvcjog
WGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+ICAqLw0KPiA+ICsNCj4gPiArI2luY2x1
ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvb2ZfcGNpLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9y
bS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvcGNpLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L3Jlc291cmNlLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVkZSAicGNp
ZS1kZXNpZ253YXJlLmgiDQo+ID4gKw0KPiA+ICsjZGVmaW5lIFBDSUVfREJJMl9PRkZTRVQJCTB4
MTAwMAkvKiBEQkkyIGJhc2UgYWRkcmVzcyovDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgbHNfcGNpZV9l
cCB7DQo+ID4gKwlzdHJ1Y3QgZHdfcGNpZQkJKnBjaTsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNk
ZWZpbmUgdG9fbHNfcGNpZV9lcCh4KQlkZXZfZ2V0X2RydmRhdGEoKHgpLT5kZXYpDQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IGxzX3BjaWVfZXN0YWJsaXNoX2xpbmsoc3RydWN0IGR3X3BjaWUgKnBj
aSkgew0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBz
dHJ1Y3QgZHdfcGNpZV9vcHMgbHNfcGNpZV9lcF9vcHMgPSB7DQo+ID4gKwkuc3RhcnRfbGluayA9
IGxzX3BjaWVfZXN0YWJsaXNoX2xpbmssIH07DQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3Ry
dWN0IG9mX2RldmljZV9pZCBsc19wY2llX2VwX29mX21hdGNoW10gPSB7DQo+ID4gKwl7IC5jb21w
YXRpYmxlID0gImZzbCxscy1wY2llLWVwIix9LA0KPiA+ICsJeyB9LA0KPiA+ICt9Ow0KPiA+ICsN
Cj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzIGxzX3BjaWVfZXBjX2Zl
YXR1cmVzID0gew0KPiA+ICsJLmxpbmt1cF9ub3RpZmllciA9IGZhbHNlLA0KPiA+ICsJLm1zaV9j
YXBhYmxlID0gdHJ1ZSwNCj4gPiArCS5tc2l4X2NhcGFibGUgPSBmYWxzZSwNCj4gPiArfTsNCj4g
PiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2VwY19mZWF0dXJlcyogDQo+ID4gK2xz
X3BjaWVfZXBfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBkd19wY2llX2VwICplcCkgew0KPiA+ICsJcmV0
dXJuICZsc19wY2llX2VwY19mZWF0dXJlczsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZv
aWQgbHNfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkgew0KPiA+ICsJc3RydWN0
IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7DQo+ID4gKwlzdHJ1Y3QgcGNp
X2VwYyAqZXBjID0gZXAtPmVwYzsNCj4gPiArCWVudW0gcGNpX2Jhcm5vIGJhcjsNCj4gPiArDQo+
ID4gKwlmb3IgKGJhciA9IEJBUl8wOyBiYXIgPD0gQkFSXzU7IGJhcisrKQ0KPiA+ICsJCWR3X3Bj
aWVfZXBfcmVzZXRfYmFyKHBjaSwgYmFyKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGlu
dCBsc19wY2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8s
DQo+ID4gKwkJCQkgIGVudW0gcGNpX2VwY19pcnFfdHlwZSB0eXBlLCB1MTYgaW50ZXJydXB0X251
bSkgew0KPiA+ICsJc3RydWN0IGR3X3BjaWUgKnBjaSA9IHRvX2R3X3BjaWVfZnJvbV9lcChlcCk7
DQo+ID4gKw0KPiA+ICsJc3dpdGNoICh0eXBlKSB7DQo+ID4gKwljYXNlIFBDSV9FUENfSVJRX0xF
R0FDWToNCj4gPiArCQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVwLCBmdW5j
X25vKTsNCj4gPiArCWNhc2UgUENJX0VQQ19JUlFfTVNJOg0KPiA+ICsJCXJldHVybiBkd19wY2ll
X2VwX3JhaXNlX21zaV9pcnEoZXAsIGZ1bmNfbm8sIGludGVycnVwdF9udW0pOw0KPiA+ICsJY2Fz
ZSBQQ0lfRVBDX0lSUV9NU0lYOg0KPiA+ICsJCXJldHVybiBkd19wY2llX2VwX3JhaXNlX21zaXhf
aXJxKGVwLCBmdW5jX25vLCBpbnRlcnJ1cHRfbnVtKTsNCj4gPiArCWRlZmF1bHQ6DQo+ID4gKwkJ
ZGV2X2VycihwY2ktPmRldiwgIlVOS05PV04gSVJRIHR5cGVcbiIpOw0KPiA+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiA+ICsJfQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IGR3X3Bj
aWVfZXBfb3BzIHBjaWVfZXBfb3BzID0gew0KPiA+ICsJLmVwX2luaXQgPSBsc19wY2llX2VwX2lu
aXQsDQo+ID4gKwkucmFpc2VfaXJxID0gbHNfcGNpZV9lcF9yYWlzZV9pcnEsDQo+ID4gKwkuZ2V0
X2ZlYXR1cmVzID0gbHNfcGNpZV9lcF9nZXRfZmVhdHVyZXMsIH07DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IF9faW5pdCBsc19hZGRfcGNpZV9lcChzdHJ1Y3QgbHNfcGNpZV9lcCAqcGNpZSwNCj4g
PiArCQkJCQlzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgZHdfcGNpZSAqcGNpID0gcGNpZS0+cGNpOw0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0g
cGNpLT5kZXY7DQo+ID4gKwlzdHJ1Y3QgZHdfcGNpZV9lcCAqZXA7DQo+ID4gKwlzdHJ1Y3QgcmVz
b3VyY2UgKnJlczsNCj4gPiArCWludCByZXQ7DQo+ID4gKw0KPiA+ICsJZXAgPSAmcGNpLT5lcDsN
Cj4gPiArCWVwLT5vcHMgPSAmcGNpZV9lcF9vcHM7DQo+ID4gKw0KPiA+ICsJcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2LCBJT1JFU09VUkNFX01FTSwgImFkZHJfc3BhY2Ui
KTsNCj4gPiArCWlmICghcmVzKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ICsNCj4gPiAr
CWVwLT5waHlzX2Jhc2UgPSByZXMtPnN0YXJ0Ow0KPiA+ICsJZXAtPmFkZHJfc2l6ZSA9IHJlc291
cmNlX3NpemUocmVzKTsNCj4gPiArDQo+ID4gKwlyZXQgPSBkd19wY2llX2VwX2luaXQoZXApOw0K
PiA+ICsJaWYgKHJldCkgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGluaXRpYWxp
emUgZW5kcG9pbnRcbiIpOw0KPiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgX19pbml0IGxzX3Bj
aWVfZXBfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0
IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBkd19wY2llICpwY2k7DQo+
ID4gKwlzdHJ1Y3QgbHNfcGNpZV9lcCAqcGNpZTsNCj4gPiArCXN0cnVjdCByZXNvdXJjZSAqZGJp
X2Jhc2U7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCXBjaWUgPSBkZXZtX2t6YWxsb2Mo
ZGV2LCBzaXplb2YoKnBjaWUpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcGNpZSkNCj4gPiAr
CQlyZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlwY2kgPSBkZXZtX2t6YWxsb2MoZGV2LCBz
aXplb2YoKnBjaSksIEdGUF9LRVJORUwpOw0KPiA+ICsJaWYgKCFwY2kpDQo+ID4gKwkJcmV0dXJu
IC1FTk9NRU07DQo+ID4gKw0KPiA+ICsJZGJpX2Jhc2UgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Vf
YnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAicmVncyIpOw0KPiA+ICsJcGNpLT5kYmlfYmFz
ZSA9IGRldm1fcGNpX3JlbWFwX2NmZ19yZXNvdXJjZShkZXYsIGRiaV9iYXNlKTsNCj4gPiArCWlm
IChJU19FUlIocGNpLT5kYmlfYmFzZSkpDQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIocGNpLT5kYmlf
YmFzZSk7DQo+ID4gKw0KPiA+ICsJcGNpLT5kYmlfYmFzZTIgPSBwY2ktPmRiaV9iYXNlICsgUENJ
RV9EQkkyX09GRlNFVDsNCj4gPiArCXBjaS0+ZGV2ID0gZGV2Ow0KPiA+ICsJcGNpLT5vcHMgPSAm
bHNfcGNpZV9lcF9vcHM7DQo+ID4gKwlwY2llLT5wY2kgPSBwY2k7DQo+ID4gKw0KPiA+ICsJcGxh
dGZvcm1fc2V0X2RydmRhdGEocGRldiwgcGNpZSk7DQo+ID4gKw0KPiA+ICsJcmV0ID0gbHNfYWRk
X3BjaWVfZXAocGNpZSwgcGRldik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIHJldDsNCj4gPiArfQ0K
PiA+ICsNCj4gPiArc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbHNfcGNpZV9lcF9kcml2
ZXIgPSB7DQo+ID4gKwkuZHJpdmVyID0gew0KPiA+ICsJCS5uYW1lID0gImxheWVyc2NhcGUtcGNp
ZS1lcCIsDQo+ID4gKwkJLm9mX21hdGNoX3RhYmxlID0gbHNfcGNpZV9lcF9vZl9tYXRjaCwNCj4g
PiArCQkuc3VwcHJlc3NfYmluZF9hdHRycyA9IHRydWUsDQo+ID4gKwl9LA0KPiA+ICt9Ow0KPiA+
ICtidWlsdGluX3BsYXRmb3JtX2RyaXZlcl9wcm9iZShsc19wY2llX2VwX2RyaXZlciwgbHNfcGNp
ZV9lcF9wcm9iZSk7DQo+ID4gLS0NCj4gPiAxLjcuMQ0KPiA+IA0K
