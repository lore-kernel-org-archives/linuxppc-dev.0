Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20543C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:33:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50DB8206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 06:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="az5EtLXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50DB8206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449fl42L12zDqRN
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 17:33:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=2a01:111:f400:fe02::605;
 helo=eur01-db5-obe.outbound.protection.outlook.com;
 envelope-from=shengjiu.wang@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="az5EtLXK"; 
 dkim-atps=neutral
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449fjB05WMzDqQL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 17:32:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN/KdaWSK4Kj6rhLFWnbs9YTlfukYKL5YZQdUUteisw=;
 b=az5EtLXKegYdaBw7xaFQnoNJ6/NydxvRC9N574+4k4xfLiA5WBS/wlOPh0Ope5gW4bwUz9lgrOL78WG6CzYLIjuJb7OynXJ8+pg08vxcwVZNAb/kzay6vjhSOw9INwSeOjz3sLYGuw7TknrbxgB9QrW482Zh2BBek41KQWw4eDI=
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) by
 VI1PR0402MB3392.eurprd04.prod.outlook.com (52.134.1.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Fri, 1 Mar 2019 06:32:05 +0000
Received: from VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22]) by VI1PR0402MB3392.eurprd04.prod.outlook.com
 ([fe80::407:6e30:6a9d:2a22%3]) with mapi id 15.20.1643.022; Fri, 1 Mar 2019
 06:32:05 +0000
From: "S.j. Wang" <shengjiu.wang@nxp.com>
To: Matt Flax <flatmax@flatmax.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Subject: RE: [alsa-devel] [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Topic: [alsa-devel] [PATCH] ASoC: cs42xx8: Remove S32_LE in format list
Thread-Index: AQHUzypa4n8NriEugUOXybmAqJXINqX2NlEAgAAD5gCAABfc4A==
Date: Fri, 1 Mar 2019 06:32:05 +0000
Message-ID: <VI1PR0402MB3392CCF09FE75CE856C6174EE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
References: <1551333389-22791-1-git-send-email-shengjiu.wang@nxp.com>
 <20190301045041.GA5064@Asurada>
 <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
In-Reply-To: <5c60b8c7-cb85-dec8-0358-6773251d3f2c@flatmax.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f3ca274-cd90-47b2-9408-08d69e0f9f28
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR0402MB3392; 
x-ms-traffictypediagnostic: VI1PR0402MB3392:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0MDJNQjMzOTI7MjM6cXdRT3BMVG5SOU9JeXJWU0hCcnhDNFZX?=
 =?utf-8?B?WENiYzIxNmFXcFJlWmNJR1U1aXIrdGRoQkVaM0FYSVJ6N3hFK2RHSmpuL0Nj?=
 =?utf-8?B?WjBaV1QySVJ2K2ErMmluOWE3SE1jMmFNdHBvRWxlMTZGc2lremxWMnp3bmQz?=
 =?utf-8?B?T0R4M3l0NDRUaWV4NHVNRkI4d2FpSjcwMnU0YU9kQklPZitQK0s3cld5L3RQ?=
 =?utf-8?B?VldzK0NyQ1JRVldsUzcySGZrdVd2MEpxWHN1YlJkZjhGVklFeWwxU0lYV29k?=
 =?utf-8?B?bDlhOGpsbVJLSTdjdnBmM1lkT1ZiVHBiRm1ZUUNxenRqNVRadnJEZkFtRTFX?=
 =?utf-8?B?YUhTQmZSK0VGb1Z3TUxJUHdZSHBQOFhpcXBJTEl2RXdiVjlHeWNadEpCK2dV?=
 =?utf-8?B?Uk5tZHlob0VTbXBzSEVyMTcwdllJVHNPNFM4ajI4S3dFNEhaaWtHaGxLTjh0?=
 =?utf-8?B?QTU2aWkvU2RWNHRuRktmb1NXNUpsdFZ4VjVoSUhROEJjNys2MnJ5WCtnYUtG?=
 =?utf-8?B?NTl5M3Rnc2R5OXlrYk84ZTJsV0ZTNnBCOEEyZGhuUVE5ak8rdEwzUjVjR2FQ?=
 =?utf-8?B?NHFEZlhtTlgwYXphZ3ZLN0gzdG41WDd0TG1ZRkZmc0RoMkNtRCtMUVJaNlg0?=
 =?utf-8?B?L1k3Si9xZTFxSHJUY2xxTkV4WHB3OUY0dGtFcnNUSXR4M09WMWQySUJwOXRh?=
 =?utf-8?B?UlpLT3h2d0lJRmtGK3EzOGFRZEhMcWRkQ1AvbGdPbmwrOE9MN1dkRVErRHZz?=
 =?utf-8?B?Q1hCS0lzREkxTzNoRENJcjR5VDRYR0UwRmpzdWpadlFGMUcrTDdwcTczRHdM?=
 =?utf-8?B?MVpkNnNFVE9oU0E2WEVLcWtJbS9tSFF2dk1rUGtZdzNCVFhlZjJSdGpDY2Ns?=
 =?utf-8?B?K1BwMjN1RFRGalhrT2RlSnhYcnlsdWU5L05qd044MGVEZGcyR01ZK3krR3Bh?=
 =?utf-8?B?TGE1MFhlNENWWlB5TnZ1eVltTUUvc3g0UXJPYkVmZDBYS1BoTlVFVDlvUE5T?=
 =?utf-8?B?Umg5bFJkcDhZUmxKQkZPTDhab2szWXRWQ1hmUDEwZjUvNEFNdmFxK3NoZUV2?=
 =?utf-8?B?cFFSbVNpK0h0c3hoWVhYcTZUN09hQW96dnZVMzk4YlJmQnRaRzJIM29jRzBF?=
 =?utf-8?B?TGhJbURjOHppRHBDWjJ1VUg4N2haKzFLR29TQmNLWEdrVXRzMnVheXFORG9O?=
 =?utf-8?B?cGEydGdYWGpBQm5JRVRiamsvOVIwMnBsWlREbE8rbjFLNEdjYVEreTNQazVY?=
 =?utf-8?B?SzhJbGVEdm05OFdoMDZvUTZra1JQYkROYlJGcStiTy8ra2toS3RXNWZFTUls?=
 =?utf-8?B?QTBtYXIxS0JQRERxdkVFUWFyenhsWk83TDJ2QUFkakV0NDhKUXhHV0dzaXlY?=
 =?utf-8?B?N3B0VTN4S2U1VS9TUWliUUwyRE1LczRJU0pZa05Vc2JiRVNhanUwVXptenZl?=
 =?utf-8?B?K20rUzM3YWhPd1lWY1BFcEV5UStNVlNoVEg5dGtDWEJVTFJxanl6NXhEeWdQ?=
 =?utf-8?B?b0RRMFZESWdKMVBPWjRWM2JkY2dwcktvMVJFeHpJT1I3TWJzVlBJVFRZVm1h?=
 =?utf-8?B?SGxxUXEwRFM1dnF0UHp0M2k1cHJ1T1N3OEt5NmR4Y2dKL3c4YU4zbmV2ZTJI?=
 =?utf-8?B?d1czRjdsRFpQTmgzWVZtWkRadXBSVTdEejZqNGV1K3g4MVdmc3VvSm9ua2Rn?=
 =?utf-8?B?K1dqWWlGNHJndlIxVGdhdUlIdmJTVlN0OFRzYjlYT2hqQ1FjUGcvWkQySG0w?=
 =?utf-8?B?NnZqRmNnZUUrQ0xiak9IamJRPT0=?=
x-microsoft-antispam-prvs: <VI1PR0402MB33921B1A029736D68AF7ACFDE3760@VI1PR0402MB3392.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(366004)(39860400002)(136003)(396003)(376002)(199004)(189003)(6306002)(55016002)(81166006)(256004)(97736004)(186003)(7696005)(33656002)(9686003)(26005)(106356001)(105586002)(76176011)(6246003)(8676002)(2906002)(6506007)(53546011)(81156014)(53936002)(66066001)(102836004)(8936002)(74316002)(99286004)(110136005)(54906003)(14454004)(966005)(478600001)(45080400002)(3846002)(6116002)(316002)(229853002)(486006)(305945005)(86362001)(6436002)(4326008)(7736002)(476003)(68736007)(52536013)(11346002)(71190400001)(71200400001)(446003)(25786009)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0402MB3392;
 H:VI1PR0402MB3392.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7D+bo4tRztxd3cQ6KJRV/ZMLtpoIxWLdcljB4TgjNvL3FoQ1PHfHrbqxrTCN8/b8btNicWE89aHN3P2a/ZuP/xFYCAZYLvuDu2oxMuRjTSctyWuueTo4k3V5v91iVh86ZM5W13ZxwN28ys1UM2A9cCUTzBSfnM7MUZO1bARzhzlDH/nelXiIApWQlLK5GP8FHCdzIsPfNIKXuY0xuY2nO0hZj1WewwIrTJZKhEFaoXPYDuxDwvDOPg3xcPgJPkCBUr958XXE8/vpSsuMZMBUoZO9amh9Qi/P3+nXDp6jBg56esaiMaFPBfAAmktecjE18UVLCCe76H6Dl0t9R8KaIKW4fOzGq23kfCGR8+SDAUvG/fxFKTwKeBiLc7+I6lPzZOMjMaClXG1oo6VgiFci94fzXpSyYs47UjOw9paFI4M=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3ca274-cd90-47b2-9408-08d69e0f9f28
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 06:32:05.0357 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3392
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "timur@kernel.org" <timur@kernel.org>,
 "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gDQo+IEl0IHdvdWxkIGJlIGEgbWlzdGFrZSB0byByZW1vdmUgUzMyX0xFIGZyb20gdGhl
IGZvcm1hdCBsaXN0Lg0KPiANCj4gSWYgeW91IHJlbW92ZWQgdGhhdCwgdGhlbiB3ZSB3b3VsZG4n
dCBiZSBhYmxlIHRvIGRvIDMyIGJpdCBuYXRpdmUgcGxheWJhY2sNCj4gLSBpdCB3b3VsZCBmb3Jj
ZSB1c2VycyB0byBnbyB0aHJvdWdoIGFuIEFMU0EgcGx1Z2luLg0KPiANCj4gSWYgeW91IGxvb2sg
YXQgdGhlIGNzNDI0NDggZGF0YSBzaGVldCBmb3IgZXhhbXBsZSwgdGhlIEkyUyBhbmQgVERNIGJ1
cw0KPiB1c2VzIGEgMzIgYml0IHdvcmQgc2l6ZS4gRm9yIHRoYXQgcmVhc29uLCBuYXRpdmUgUzMy
X0xFIGZvcm1hdCBpcyBoYW5kbGVkIGJ5DQo+IHRoZSBjb2RlYy4gV2hpbGUgdGhlIGNvZGVjIG9u
bHkgdXNlcyB0aGUgMjQgTVNCcywgdGhlIEkyUyBidXMgaXMgMzIgYml0Lg0KDQpUaGlzIGNhc2Ug
aXMgY292ZXJlZCBieSBTMjRfTEUgSSB0aGluay4gIFRoZSBTMzJfTEUgbWVhbnMgdGhlIGRhdGEg
aXMgMzJiaXQgYW5kIHNsb3Qgd2lkdGgNCklzIDMyYml0LCB0aGlzIGlzIG5vdCBpbiBkYXRhIHNo
ZWV0Lg0KDQpCZXN0IHJlZ2FyZHMNCldhbmcgc2hlbmdqaXUNCj4gDQo+IE1hdHQNCj4gDQo+IE9u
IDEvMy8xOSAzOjUwIHBtLCBOaWNvbGluIENoZW4gd3JvdGU6DQo+ID4gSGkgU2hlbmdqaXUsDQo+
ID4NCj4gPiBPbiBUaHUsIEZlYiAyOCwgMjAxOSBhdCAwNTo1NjozMUFNICswMDAwLCBTLmouIFdh
bmcgd3JvdGU6DQo+ID4+IGNzNDJ4eDggaXMgYSAyNC1iaXQgQS9EIGFuZCAyNC1iaXQgRC9BIGRl
dmljZSwgc28gdGhlIFMzMl9MRSBzaG91bGQNCj4gPj4gbm90IGJlIGluIHRoZSBzdXBwb3J0ZWQg
Zm9ybWF0IGxpc3QuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFNoZW5naml1IFdhbmcgPHNo
ZW5naml1LndhbmdAbnhwLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgc291bmQvc29jL2NvZGVjcy9j
czQyeHg4LmMgfCAzICstLQ0KPiA+IFRoaXMgaXMgZm9yIGNzNDJ4eDggY29kZWMgZHJpdmVyLCBi
dXQgaXRzIG1haW50YWluZXJzIGFyZW4ndCBzZWVtbHkgaW4NCj4gPiBUby9DYyBsaXN0LiBQbGVh
c2UgcnVuIC4vc2NyaXB0cy9nZXRfbWFpbnRhaW5lci5wbCBmb3IgaXQgYW5kIHJlc2VuZC4NCj4g
PiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IEFs
c2EtZGV2ZWwgbWFpbGluZyBsaXN0DQo+ID4gQWxzYS1kZXZlbEBhbHNhLXByb2plY3Qub3JnDQo+
ID4NCj4gaHR0cHM6Ly9lbWVhMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3Vy
bD1odHRwcyUzQSUyRiUyRm1hDQo+IGkNCj4gPiBsbWFuLmFsc2EtcHJvamVjdC5vcmclMkZtYWls
bWFuJTJGbGlzdGluZm8lMkZhbHNhLQ0KPiBkZXZlbCZhbXA7ZGF0YT0wMiU3Qw0KPiA+DQo+IDAx
JTdDc2hlbmdqaXUud2FuZyU0MG54cC5jb20lN0NlNTY4NmQ3MmJkNzg0M2M1OTYyNTA4ZDY5ZTAz
NzBhNA0KPiAlN0M2ODZlDQo+ID4NCj4gYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAl
N0MxJTdDNjM2ODcwMTM0OTc1NjIzMTIzJmFtcDsNCj4gc2RhdGE9UnINCj4gPg0KPiBZd2ZDNFkz
eHNzRUQlMkZ6UnVtJTJGWEFCR0pUSHZScll3blJOZ1VMN3UybFUlM0QmYW1wO3Jlc2VydmVkDQo+
ID0wDQo=
