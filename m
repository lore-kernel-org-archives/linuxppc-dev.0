Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65BEC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 03:11:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB57E21738
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 03:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qM1wL396"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB57E21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4442g62xTNzDqDW
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:10:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.6.67; helo=eur04-db3-obe.outbound.protection.outlook.com;
 envelope-from=xiaowei.bao@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="qM1wL396"; 
 dkim-atps=neutral
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4442d51N0fzDqDQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Feb 2019 14:09:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpMcntVegek4M9OKqOf1PfZpiUECk/yTjS34twzxTp0=;
 b=qM1wL396iIhfxf21I7VBCBMhO+sr68HBTfCWp7LD+w9Dvq9rben8D4VrJtQcgb7WAaS4gHHXvMJzyYX9USDFC8QbkL7sO0VPlmMne83wopasJ1gpH/utfNY98EauT1KASC4MGOeGZl3EphO/3oPG6D14Gr85VU+IQ7L2F7X0ffE=
Received: from HE1PR04MB3306.eurprd04.prod.outlook.com (10.171.196.161) by
 HE1PR04MB1611.eurprd04.prod.outlook.com (10.164.48.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Wed, 20 Feb 2019 03:09:01 +0000
Received: from HE1PR04MB3306.eurprd04.prod.outlook.com
 ([fe80::44a4:803d:fc3d:7c98]) by HE1PR04MB3306.eurprd04.prod.outlook.com
 ([fe80::44a4:803d:fc3d:7c98%3]) with mapi id 15.20.1622.018; Wed, 20 Feb 2019
 03:09:01 +0000
From: Xiaowei Bao <xiaowei.bao@nxp.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCHv6 3/4] pci: layerscape: Add the EP mode support.
Thread-Topic: [PATCHv6 3/4] pci: layerscape: Add the EP mode support.
Thread-Index: AQHUsh00Gw2tbfNoe0K3WDzxJMy4MaXnJ+2AgAEELvA=
Date: Wed, 20 Feb 2019 03:09:01 +0000
Message-ID: <HE1PR04MB3306890D5A1656EC818521A2F57D0@HE1PR04MB3306.eurprd04.prod.outlook.com>
References: <20190122063328.25228-1-xiaowei.bao@nxp.com>
 <20190122063328.25228-3-xiaowei.bao@nxp.com>
 <20190219112721.GA15442@e107981-ln.cambridge.arm.com>
In-Reply-To: <20190219112721.GA15442@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82dab31a-3d6f-440a-d307-08d696e0c348
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:HE1PR04MB1611; 
x-ms-traffictypediagnostic: HE1PR04MB1611:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtIRTFQUjA0TUIxNjExOzIzOk5iRmI4ZVpPZGJsQ0FScDl6dGkvNHF3VTBh?=
 =?gb2312?B?cWpId3ltdmYrYXNwYVJTRFA0QzhPNGdjZlJMQ016MUVFZHU4YW4xOTZDMnJQ?=
 =?gb2312?B?M0xsQ3dvUVRSdGNTb3daY2NQRGxxTTA2empSbERoanduYUNZK2pQWms0OU9k?=
 =?gb2312?B?K1N1Q2x4STVyYnlwekV6RHlhOUN0SitPWWxzVnVpallnS2lhVnFZcUVDQkx1?=
 =?gb2312?B?TGdpcmI5WnQ1RVl6Z1NLWk9IOUhTZThBWjhvYldQT3EvSENHVU44S1l0SHg0?=
 =?gb2312?B?YXR6MTFvK1ZOQk5QK0F3SFRtK2ZycjNkT3FjejNJcnN5cEM0L0tmWEVxVE9t?=
 =?gb2312?B?K0I3L09oZ0w2SGhzU3ZFUTRLRlVKbjNMd2FBNkZ5ekl0Vk1PZTlrblVzRk5h?=
 =?gb2312?B?UHBhQ1FZN0Y5M1JpMmVsZTNkWHhnTSsxNk13dTA1NnBXM0diMlQ4WEpHSDdu?=
 =?gb2312?B?eEZkNTNlbzh5ZTJmODNCa0U2eExhK0kwK1FDTVVBR2wyTk1FcVNLQVI2TGZI?=
 =?gb2312?B?VXNFNXhhcmFQbjNmYnA0K3pKbTg4NWVhQ2p5TjIvYld1Q1ZXT0dRb0Q2bUhl?=
 =?gb2312?B?QTkvSXZlVnp5clVkai94c0NtcE4wNG5pdURJVVlxRzNJVHc1aTZGL2JtTjFB?=
 =?gb2312?B?M3BiSlpVTzJUM1RRU2tpQk9kelBPYTZ2bVd5c0N3ZlIwbmhLN250cG9ucE1Q?=
 =?gb2312?B?d3drYkhzQ0dZa3dpREtQd0RrQkw4Z0ttMXRhMmpUQmhBUEY0MGphRk5Pbmdm?=
 =?gb2312?B?WDF1OTVCNjhRVWhqc1E5cmFGM3Bsdkc0WURmbHp2ZUtST1FUTWVRaWRzY0ky?=
 =?gb2312?B?cmxmNUV5dCtPT3o2SVN0ZlpDQnFVMThxNTg1WkdFYlduOXl0TDkyd0NmQklp?=
 =?gb2312?B?eVlyUXRqQmQrcmkrVTBVTmJUUVZVM2FWc2Y5SlBqQWw1TGpHNXNBV01Fb1d4?=
 =?gb2312?B?a0VkdnBVeTI3OG9LaTdkRW5zd2FGVXZDMDJZTGpMOEhyMDJqTzdCNHFSaUk5?=
 =?gb2312?B?QmxXcXplRnpkS09NclBTQkJMZldoNlRyT2dFUkkwZHRMUGxOZFVSem9CVTVH?=
 =?gb2312?B?OXhUcjNQck1nNHpoam1GYlVJMk4rY1JyNDVuQ29sdU5TKzhJSzNOSHJwNER3?=
 =?gb2312?B?UUNyZkJNZnlYcDY3MVZkcmlodmJQYlY4ci9KV2RIY3c3VmdKODd6SUcyWkll?=
 =?gb2312?B?M2FCcVFDSTJ0eFVCQXRpYjNhd1ZxSnN4MG5VTm5CMy91WE1mZUQ0S3lTNlpJ?=
 =?gb2312?B?MlIyWG0rUXQxRlp6VW55ZEl0dTRBV2lwVWVUaXMwQkZMZ3R4Y3ZUWmdaNDYx?=
 =?gb2312?B?cWtMczVhL0djR09seHJKQ3phZGVqRHlqMU5waVFhSTUxWU9wSWFOek1RQjZ4?=
 =?gb2312?B?Z0tUcFRtMUhnbzl0eVU2SVZSYTF4VEZhTXh1aGkza01Lak1xRmp4Nkp5eHFy?=
 =?gb2312?B?QnNxVlh3Skk4NTY3Sy8vM3pJSmgyU0d1WlVzVEVUaC9PTGI1VlBJdnluTG9o?=
 =?gb2312?B?TTF4Tk90RTVZdkJpelRNRXNhTE8wR0k3UzVqY2pkWTVnOVp2bG9yWUd5dUxN?=
 =?gb2312?B?YUdYYzh0SGJiUS8va3M3R2pjU21ZL05nbFBsU29jcHFmRnZWd2ZwNkRvakd2?=
 =?gb2312?B?NEcvLzBlK3pSRTRwcTlhOWtKZlI5eUtaTE03c0c0dUJMQ0swdTcrSy9QNGNR?=
 =?gb2312?B?d2lKcGtBUXRLZ0Q1MkVjRVZLRFJWcGJSRmhoZEhZRWk0eXRFajJPV0FEYUhO?=
 =?gb2312?B?MU5GUDFBa1c1azVvYVBhV1BKRlJMU1hnOUxFZ0dYS2xnYW9qRUVoQldPZXRs?=
 =?gb2312?B?T0U4ejhZK1lwcW9GU083cVZoait0dm5kNDl5RWl2ai9nRURIcnF6blA3ODhF?=
 =?gb2312?B?dklicXRCNk9kcFpQVW5QN0RHTVpydm1WbmtlU2ROem94bW9ENzhRNWhOTTRL?=
 =?gb2312?B?U3FhcnBXMGZ5TDNYNEhiZkgwdk1JVE81dmFSd1NlQU9QYW9VeGdSMDM4NWxP?=
 =?gb2312?Q?Bgo11p?=
x-microsoft-antispam-prvs: <HE1PR04MB1611F26EE4EC31324D0401F9F57D0@HE1PR04MB1611.eurprd04.prod.outlook.com>
x-forefront-prvs: 0954EE4910
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(979002)(136003)(366004)(376002)(39860400002)(346002)(396003)(13464003)(199004)(189003)(26005)(6306002)(99286004)(76176011)(9686003)(53936002)(3846002)(71190400001)(102836004)(71200400001)(6346003)(7416002)(97736004)(6116002)(68736007)(6506007)(53546011)(81166006)(305945005)(81156014)(186003)(54906003)(25786009)(316002)(33656002)(105586002)(6246003)(55016002)(66066001)(7696005)(6916009)(6436002)(7736002)(106356001)(2906002)(86362001)(966005)(44832011)(8676002)(486006)(8936002)(5660300002)(4326008)(14454004)(74316002)(478600001)(446003)(11346002)(45080400002)(256004)(14444005)(476003)(229853002)(969003)(989001)(999001)(1009001)(1019001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:HE1PR04MB1611;
 H:HE1PR04MB3306.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dcT4lU2uFWgFQ7qt/VESAdN2yAAK6vseCRdLegTIsRI3B6a2XyE9XTbcQq1ApPA0gNFxAU4kqqwYffzNlHNpHsGXUV44bfocAevP3pf5evr5RBU42FV1kRc4hC90QCONZCHsmILXQVBGQrGEIPhfy2MaZVp3RE1E7elxAeYR1OSCEJv+jDxB7fWdhUifqME1kQRy+WKLMm5j6Xs2yNYtWIDulFrgZvEwbjYxMW2W4eNdlmiR1hIDrWSLj/DRSeQjcp/tqGzUTTmB3Uw3a3ec1j8UYVmBdQhOwZDVhrLfjahlMfU8/dipbaptqlgj7o4kmIvNXzSs2Xm3cODDk66+S8SErmug/DyoX4nI66Fwl+i76Oeb96UL9CUz8CG+OwntAh6KiBSHzN0KuHFU6qP5qAYJi61E4fgiyb4W/y75AqU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82dab31a-3d6f-440a-d307-08d696e0c348
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2019 03:09:01.0853 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1611
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
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4gDQpTZW50OiAyMDE5xOoy1MIxOcjVIDE5OjI3DQpU
bzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQpDYzogYmhlbGdhYXNAZ29vZ2xl
LmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9A
a2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+OyBraXNob25AdGkuY29tOyBh
cm5kQGFybmRiLmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgTS5oLiBMaWFuIDxtaW5n
aHVhbi5saWFuQG54cC5jb20+OyBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kg
WmFuZyA8cm95LnphbmdAbnhwLmNvbT47IGtzdGV3YXJ0QGxpbnV4Zm91bmRhdGlvbi5vcmc7IGN5
cmlsbGUucGl0Y2hlbkBmcmVlLWVsZWN0cm9ucy5jb207IHBvbWJyZWRhbm5lQG5leGIuY29tOyBz
aGF3bi5saW5Acm9jay1jaGlwcy5jb207IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxh
YnMub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIdjYgMy80XSBwY2k6IGxheWVyc2NhcGU6IEFkZCB0
aGUgRVAgbW9kZSBzdXBwb3J0Lg0KDQpPbiBUdWUsIEphbiAyMiwgMjAxOSBhdCAwMjozMzoyN1BN
ICswODAwLCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gQWRkIHRoZSBQQ0llIEVQIG1vZGUgc3VwcG9y
dCBmb3IgbGF5ZXJzY2FwZSBwbGF0Zm9ybS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkg
QmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8
bWluZ2h1YW4ubGlhbkBueHAuY29tPg0KPiBSZXZpZXdlZC1ieTogWmhpcWlhbmcgSG91IDx6aGlx
aWFuZy5ob3VAbnhwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkg
PGtpc2hvbkB0aS5jb20+DQo+IC0tLQ0KPiBkZXBlbmRzIG9uOiANCj4gaHR0cHM6Ly9lbWVhMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRnBhdA0K
PiBjaHdvcmsua2VybmVsLm9yZyUyRnByb2plY3QlMkZsaW51eC1wY2klMkZsaXN0JTJGJTNGc2Vy
aWVzJTNENjYxNzcmYW1wDQo+IDtkYXRhPTAyJTdDMDElN0N4aWFvd2VpLmJhbyU0MG54cC5jb20l
N0M2Zjg3NzJiYTQ3Yzc0ZDhlZTBhYTA4ZDY5NjVkM2UNCj4gYjQlN0M2ODZlYTFkM2JjMmI0YzZm
YTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM2ODYxNzI0NTcyNjExMTkzJmFtcA0KPiA7c2Rh
dGE9YjNBY2owZnU3Yzl2U29IZTlWemVBa0VNYk1rcHlmWVBzWHRmNmZBOEZsayUzRCZhbXA7cmVz
ZXJ2ZWQ9MA0KPiANCj4gdjI6DQo+ICAtIHJlbW92ZSB0aGUgRVAgbW9kZSBjaGVjayBmdW5jdGlv
bi4NCj4gdjM6DQo+ICAtIG1vZGlmIHRoZSByZXR1cm4gdmFsdWUgd2hlbiBlbnRlciBkZWZhdWx0
IGNhc2UuDQo+IHY0Og0KPiAgLSBubyBjaGFuZ2UuDQo+IHY1Og0KPiAgLSBubyBjaGFuZ2UuDQo+
IHY2Og0KPiAgLSBtb2RpZnkgdGhlIGNvZGUgYmFzZSBvbiB0aGUgc3VibWl0IHBhdGNoIG9mIHRo
ZSBFUCBmcmFtZXdvcmsuDQoNCkNhbiBJIGFwcGx5IHRoaXMgc2VyaWVzIHRvIG15IHBjaS9lbmRw
b2ludCBicmFuY2ggKHdoZXJlIEkgcXVldWVkIEtpc2hvbidzIEVQIGZlYXR1cmVzIHJld29yayBw
YXRjaGVzKSA/IENhbiB5b3UgY2hlY2sgcGxlYXNlID8NCltYaWFvd2VpIEJhb10gb2YgY291cnNl
LCBpbiBteSBwYXRjaCwgSSBmb3VuZCBhIGNvbXBpbGUgd2FybmluZywgYnV0IHRoaXMgc2VyaWVz
IHBhdGNoIGhhdmUgYXBwcm92ZWQgYnkgeW91LCBJIGRvbid0IGtub3cgaG93IHRvIGRvLCB0aGUg
Y29tcGlsZSB3YXJuaW5nOiAiIHN0cnVjdCBwY2lfZXBjICplcGMgPSBlcC0+ZXBjOyIgaW4gImxz
X3BjaWVfZXBfaW5pdCIgZnVuY3Rpb24sIEkgYW0gc28gc29ycnksIGNvdWxkIHlvdSBoZWxwIG1l
IHJlbW92ZSB0aGlzIGNvZGUsIHRoYW5rcyBhIGxvdC4NCg0KVGhhbmtzLA0KTG9yZW56bw0KDQo+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9NYWtlZmlsZSAgICAgICAgICAgIHwgICAgMiAr
LQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYyB8ICAx
NTcgDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNTgg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIA0KPiAxMDA2NDQgZHJp
dmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUtZXAuYw0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlIA0KPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+IGluZGV4IDdiY2RjZGYuLmI1ZjNiODMgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL01ha2VmaWxlDQo+IEBAIC04LDcgKzgsNyBAQCBv
YmotJChDT05GSUdfUENJX0VYWU5PUykgKz0gcGNpLWV4eW5vcy5vDQo+ICBvYmotJChDT05GSUdf
UENJX0lNWDYpICs9IHBjaS1pbXg2Lm8NCj4gIG9iai0kKENPTkZJR19QQ0lFX1NQRUFSMTNYWCkg
Kz0gcGNpZS1zcGVhcjEzeHgubw0KPiAgb2JqLSQoQ09ORklHX1BDSV9LRVlTVE9ORSkgKz0gcGNp
LWtleXN0b25lLm8NCj4gLW9iai0kKENPTkZJR19QQ0lfTEFZRVJTQ0FQRSkgKz0gcGNpLWxheWVy
c2NhcGUubw0KPiArb2JqLSQoQ09ORklHX1BDSV9MQVlFUlNDQVBFKSArPSBwY2ktbGF5ZXJzY2Fw
ZS5vIHBjaS1sYXllcnNjYXBlLWVwLm8NCj4gIG9iai0kKENPTkZJR19QQ0lFX1FDT00pICs9IHBj
aWUtcWNvbS5vDQo+ICBvYmotJChDT05GSUdfUENJRV9BUk1BREFfOEspICs9IHBjaWUtYXJtYWRh
OGsubw0KPiAgb2JqLSQoQ09ORklHX1BDSUVfQVJUUEVDNikgKz0gcGNpZS1hcnRwZWM2Lm8gZGlm
ZiAtLWdpdCANCj4gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktbGF5ZXJzY2FwZS1l
cC5jIA0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNjYXBlLWVwLmMN
Cj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMC4uZGRjMmRiYg0KPiAtLS0g
L2Rldi9udWxsDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1sYXllcnNj
YXBlLWVwLmMNCj4gQEAgLTAsMCArMSwxNTcgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlm
aWVyOiBHUEwtMi4wDQo+ICsvKg0KPiArICogUENJZSBjb250cm9sbGVyIEVQIGRyaXZlciBmb3Ig
RnJlZXNjYWxlIExheWVyc2NhcGUgU29Dcw0KPiArICoNCj4gKyAqIENvcHlyaWdodCAoQykgMjAx
OCBOWFAgU2VtaWNvbmR1Y3Rvci4NCj4gKyAqDQo+ICsgKiBBdXRob3I6IFhpYW93ZWkgQmFvIDx4
aWFvd2VpLmJhb0BueHAuY29tPiAgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5o
Pg0KPiArI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9wY2ku
aD4NCj4gKyNpbmNsdWRlIDxsaW51eC9vZl9wbGF0Zm9ybS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4
L29mX2FkZHJlc3MuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4gKyNpbmNsdWRlIDxs
aW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZXNvdXJjZS5oPg0K
PiArDQo+ICsjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+ICsNCj4gKyNkZWZpbmUgUENJ
RV9EQkkyX09GRlNFVAkJMHgxMDAwCS8qIERCSTIgYmFzZSBhZGRyZXNzKi8NCj4gKw0KPiArc3Ry
dWN0IGxzX3BjaWVfZXAgew0KPiArCXN0cnVjdCBkd19wY2llCQkqcGNpOw0KPiArfTsNCj4gKw0K
PiArI2RlZmluZSB0b19sc19wY2llX2VwKHgpCWRldl9nZXRfZHJ2ZGF0YSgoeCktPmRldikNCj4g
Kw0KPiArc3RhdGljIGludCBsc19wY2llX2VzdGFibGlzaF9saW5rKHN0cnVjdCBkd19wY2llICpw
Y2kpIHsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBk
d19wY2llX29wcyBsc19wY2llX2VwX29wcyA9IHsNCj4gKwkuc3RhcnRfbGluayA9IGxzX3BjaWVf
ZXN0YWJsaXNoX2xpbmssIH07DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIGxzX3BjaWVfZXBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImZzbCxs
cy1wY2llLWVwIix9LA0KPiArCXsgfSwNCj4gK307DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgcGNpX2VwY19mZWF0dXJlcyBsc19wY2llX2VwY19mZWF0dXJlcyA9IHsNCj4gKwkubGlua3Vw
X25vdGlmaWVyID0gZmFsc2UsDQo+ICsJLm1zaV9jYXBhYmxlID0gdHJ1ZSwNCj4gKwkubXNpeF9j
YXBhYmxlID0gZmFsc2UsDQo+ICt9Ow0KPiArDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9l
cGNfZmVhdHVyZXMqIGxzX3BjaWVfZXBfZ2V0X2ZlYXR1cmVzKHN0cnVjdCANCj4gK2R3X3BjaWVf
ZXAgKmVwKSB7DQo+ICsJcmV0dXJuICZsc19wY2llX2VwY19mZWF0dXJlczsNCj4gK30NCj4gKw0K
PiArc3RhdGljIHZvaWQgbHNfcGNpZV9lcF9pbml0KHN0cnVjdCBkd19wY2llX2VwICplcCkgew0K
PiArCXN0cnVjdCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fZXAoZXApOw0KPiArCXN0
cnVjdCBwY2lfZXBjICplcGMgPSBlcC0+ZXBjOw0KPiArCWVudW0gcGNpX2Jhcm5vIGJhcjsNCj4g
Kw0KPiArCWZvciAoYmFyID0gQkFSXzA7IGJhciA8PSBCQVJfNTsgYmFyKyspDQo+ICsJCWR3X3Bj
aWVfZXBfcmVzZXRfYmFyKHBjaSwgYmFyKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBsc19w
Y2llX2VwX3JhaXNlX2lycShzdHJ1Y3QgZHdfcGNpZV9lcCAqZXAsIHU4IGZ1bmNfbm8sDQo+ICsJ
CQkJICBlbnVtIHBjaV9lcGNfaXJxX3R5cGUgdHlwZSwgdTE2IGludGVycnVwdF9udW0pIHsNCj4g
KwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0gdG9fZHdfcGNpZV9mcm9tX2VwKGVwKTsNCj4gKw0KPiAr
CXN3aXRjaCAodHlwZSkgew0KPiArCWNhc2UgUENJX0VQQ19JUlFfTEVHQUNZOg0KPiArCQlyZXR1
cm4gZHdfcGNpZV9lcF9yYWlzZV9sZWdhY3lfaXJxKGVwLCBmdW5jX25vKTsNCj4gKwljYXNlIFBD
SV9FUENfSVJRX01TSToNCj4gKwkJcmV0dXJuIGR3X3BjaWVfZXBfcmFpc2VfbXNpX2lycShlcCwg
ZnVuY19ubywgaW50ZXJydXB0X251bSk7DQo+ICsJY2FzZSBQQ0lfRVBDX0lSUV9NU0lYOg0KPiAr
CQlyZXR1cm4gZHdfcGNpZV9lcF9yYWlzZV9tc2l4X2lycShlcCwgZnVuY19ubywgaW50ZXJydXB0
X251bSk7DQo+ICsJZGVmYXVsdDoNCj4gKwkJZGV2X2VycihwY2ktPmRldiwgIlVOS05PV04gSVJR
IHR5cGVcbiIpOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICt9DQo+ICsNCj4gK3N0
YXRpYyBzdHJ1Y3QgZHdfcGNpZV9lcF9vcHMgcGNpZV9lcF9vcHMgPSB7DQo+ICsJLmVwX2luaXQg
PSBsc19wY2llX2VwX2luaXQsDQo+ICsJLnJhaXNlX2lycSA9IGxzX3BjaWVfZXBfcmFpc2VfaXJx
LA0KPiArCS5nZXRfZmVhdHVyZXMgPSBsc19wY2llX2VwX2dldF9mZWF0dXJlcywgfTsNCj4gKw0K
PiArc3RhdGljIGludCBfX2luaXQgbHNfYWRkX3BjaWVfZXAoc3RydWN0IGxzX3BjaWVfZXAgKnBj
aWUsDQo+ICsJCQkJCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICt7DQo+ICsJc3Ry
dWN0IGR3X3BjaWUgKnBjaSA9IHBjaWUtPnBjaTsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBw
Y2ktPmRldjsNCj4gKwlzdHJ1Y3QgZHdfcGNpZV9lcCAqZXA7DQo+ICsJc3RydWN0IHJlc291cmNl
ICpyZXM7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCWVwID0gJnBjaS0+ZXA7DQo+ICsJZXAtPm9w
cyA9ICZwY2llX2VwX29wczsNCj4gKw0KPiArCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9i
eW5hbWUocGRldiwgSU9SRVNPVVJDRV9NRU0sICJhZGRyX3NwYWNlIik7DQo+ICsJaWYgKCFyZXMp
DQo+ICsJCXJldHVybiAtRUlOVkFMOw0KPiArDQo+ICsJZXAtPnBoeXNfYmFzZSA9IHJlcy0+c3Rh
cnQ7DQo+ICsJZXAtPmFkZHJfc2l6ZSA9IHJlc291cmNlX3NpemUocmVzKTsNCj4gKw0KPiArCXJl
dCA9IGR3X3BjaWVfZXBfaW5pdChlcCk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKGRl
diwgImZhaWxlZCB0byBpbml0aWFsaXplIGVuZHBvaW50XG4iKTsNCj4gKwkJcmV0dXJuIHJldDsN
Cj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0KPiArc3RhdGljIGludCBfX2lu
aXQgbHNfcGNpZV9lcF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KSB7DQo+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNp
Ow0KPiArCXN0cnVjdCBsc19wY2llX2VwICpwY2llOw0KPiArCXN0cnVjdCByZXNvdXJjZSAqZGJp
X2Jhc2U7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXBjaWUgPSBkZXZtX2t6YWxsb2MoZGV2LCBz
aXplb2YoKnBjaWUpLCBHRlBfS0VSTkVMKTsNCj4gKwlpZiAoIXBjaWUpDQo+ICsJCXJldHVybiAt
RU5PTUVNOw0KPiArDQo+ICsJcGNpID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwY2kpLCBH
RlBfS0VSTkVMKTsNCj4gKwlpZiAoIXBjaSkNCj4gKwkJcmV0dXJuIC1FTk9NRU07DQo+ICsNCj4g
KwlkYmlfYmFzZSA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwgSU9SRVNPVVJD
RV9NRU0sICJyZWdzIik7DQo+ICsJcGNpLT5kYmlfYmFzZSA9IGRldm1fcGNpX3JlbWFwX2NmZ19y
ZXNvdXJjZShkZXYsIGRiaV9iYXNlKTsNCj4gKwlpZiAoSVNfRVJSKHBjaS0+ZGJpX2Jhc2UpKQ0K
PiArCQlyZXR1cm4gUFRSX0VSUihwY2ktPmRiaV9iYXNlKTsNCj4gKw0KPiArCXBjaS0+ZGJpX2Jh
c2UyID0gcGNpLT5kYmlfYmFzZSArIFBDSUVfREJJMl9PRkZTRVQ7DQo+ICsJcGNpLT5kZXYgPSBk
ZXY7DQo+ICsJcGNpLT5vcHMgPSAmbHNfcGNpZV9lcF9vcHM7DQo+ICsJcGNpZS0+cGNpID0gcGNp
Ow0KPiArDQo+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcGNpZSk7DQo+ICsNCj4gKwly
ZXQgPSBsc19hZGRfcGNpZV9lcChwY2llLCBwZGV2KTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+
ICt9DQo+ICsNCj4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIGxzX3BjaWVfZXBfZHJp
dmVyID0gew0KPiArCS5kcml2ZXIgPSB7DQo+ICsJCS5uYW1lID0gImxheWVyc2NhcGUtcGNpZS1l
cCIsDQo+ICsJCS5vZl9tYXRjaF90YWJsZSA9IGxzX3BjaWVfZXBfb2ZfbWF0Y2gsDQo+ICsJCS5z
dXBwcmVzc19iaW5kX2F0dHJzID0gdHJ1ZSwNCj4gKwl9LA0KPiArfTsNCj4gK2J1aWx0aW5fcGxh
dGZvcm1fZHJpdmVyX3Byb2JlKGxzX3BjaWVfZXBfZHJpdmVyLCBsc19wY2llX2VwX3Byb2JlKTsN
Cj4gLS0NCj4gMS43LjENCj4gDQo=
