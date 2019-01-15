Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABDEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 03:22:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E1FB20645
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 03:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UrT1FD+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1FB20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dwcV0p2wzDqY6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 14:22:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nxp.com
 (client-ip=40.107.4.83; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=bharat.bhushan@nxp.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=nxp.com header.i=@nxp.com header.b="UrT1FD+E"; 
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40083.outbound.protection.outlook.com [40.107.4.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dwZc6hdMzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 14:20:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orcUbwCy7jIjhrYydPW+aabw2XI6AP6PQf7mbli6b5o=;
 b=UrT1FD+Ey0vLzpW+tKYT3qF6nsMpjPeX66tM2N0Q6kXwoE1J4zJmgQKXJnFsDhv8lRkC6j2mgbjsdVi+GDYdLvYeS3MizGA5ONRpKue41yH1mmflmWjL+Pqn1eYmNVhQg3j/5ce7mONiwF/6ZjT1oInr7nFqDqG4ayZsmyoLsNE=
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (20.177.49.14) by
 VI1PR04MB5677.eurprd04.prod.outlook.com (20.178.126.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.14; Tue, 15 Jan 2019 03:20:13 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::a13c:ebf5:6fb5:8c7]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::a13c:ebf5:6fb5:8c7%2]) with mapi id 15.20.1516.019; Tue, 15 Jan 2019
 03:20:13 +0000
From: Bharat Bhushan <bharat.bhushan@nxp.com>
To: Leo Li <leoyang.li@nxp.com>
Subject: RE: [PATCH] soc: fsl: dpio: fix cpu range check
Thread-Topic: [PATCH] soc: fsl: dpio: fix cpu range check
Thread-Index: AQHUq8eyjXksS82nRkmGUg0ZzKV3DqWvI94AgACF3YA=
Date: Tue, 15 Jan 2019 03:20:13 +0000
Message-ID: <VI1PR04MB4845D340471C4E447A0427479A810@VI1PR04MB4845.eurprd04.prod.outlook.com>
References: <20190114050237.32140-1-Bharat.Bhushan@nxp.com>
 <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
In-Reply-To: <CADRPPNRXgR_c+7tT9nv5QVBsHxm662T0sYwAhHS1PO=O9SC5Tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharat.bhushan@nxp.com; 
x-originating-ip: [14.143.254.130]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR04MB5677;
 6:c93kYnH8gz0UNBerx4TER8dyg8no9F0POH3WK3UTeayPVAUKtkYNd+2T4urS1FH+nDbiWKhZKAS7S01ZeajENW99c+usNuCzG4Jj5Ki5Y7KgBmfyUm0y40oc1E+9Tu/LhyV30D/KYWK53RU+IfpuBwpD1SlvbuV51bRfHKduMJNdYWZIMZNt/P4/M8mYHwDJB24QeqwK79yokhMaLjyaOamv1Z5/xIIxreJ80X987/Cya4lYA3mkTFb8UuWI1HiHndklxCC5ZZuwpflAWmuGH6oyidGIXgCNrP9u5rkx+s/7+DCP2mCvvjQ5T48yrpyJjF0COXN+S+ILizt9IxHr6sKa2OATp4uL/RaP0wKD7YSQYprTHM6007RFfoGbqRZGocZldgAfz5N2naAtRlbNWdJbqBweg+pbGlGPkHXMmlRrfoMaCKpOjYC7mZOetwjXI8gdns48i4K6rbqvh9PwhA==;
 5:HbLfGb1+XD5wIoGFWn/r6GapeI/C2L8uNTez15f3wNwWDhINZVkfSe2q556Zc/iIZHd8E+0W0ZCWz+y9YogA9Zxy+72uDCkQZ8PiSOFxDTattBGJsYKw2Ou08/7V+blvue2291qbBzaPVoWk8N4NL1AtI4dnG5x+zol6lSc7bY9vCB1GszmZw0xHPrdSlbsT7+91MxqjaO/dxcdB4BSHJQ==;
 7:JFFb7f/WJPQycuLSyalFB4H0ZnuEjKTmBYkAkeyanoq6tYUMjqsGBpeAaHdnsV97LzMTlOzry1VzWRtXUvLWnDaaX6MkcyldHIgkKulQ8HqeU7IVDiBFEfRWlpKs5KCrA3vetBMpdKYwQsTRNt6TUw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 5e8d073e-d7cd-408d-4e98-08d67a985d48
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600109)(711020)(4618075)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
 SRVR:VI1PR04MB5677; 
x-ms-traffictypediagnostic: VI1PR04MB5677:
x-microsoft-antispam-prvs: <VI1PR04MB5677EE908D4250AA669F6D859A810@VI1PR04MB5677.eurprd04.prod.outlook.com>
x-forefront-prvs: 0918748D70
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(13464003)(199004)(7736002)(81166006)(39060400002)(97736004)(305945005)(8676002)(478600001)(66066001)(14454004)(26005)(186003)(6246003)(14444005)(81156014)(4326008)(6862004)(2906002)(44832011)(256004)(99286004)(86362001)(53936002)(6306002)(54906003)(9686003)(486006)(316002)(8936002)(7696005)(55016002)(229853002)(6636002)(446003)(105586002)(45080400002)(68736007)(106356001)(78486014)(11346002)(476003)(33656002)(76176011)(71190400001)(5660300001)(71200400001)(966005)(55236004)(6506007)(102836004)(53546011)(3846002)(25786009)(74316002)(6116002)(6436002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR04MB5677;
 H:VI1PR04MB4845.eurprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1wik/Lj1VnF84PW/5Siu3dpyu1FnjAsaaDnhDUsopQ53PeoPMvwevyKuC4eYLO/9OINuOzpf8H3dWgvq4A6X+8VT59sGhjZgzFEyEw/IL2JgRt3xjURv/9OrF/HTDbzNNAjq+Tm1XpylLTpgxIiq0RxMlgH3wIM74m1kcAByNIMX9ZKjuyCk0mzQL8EuhA0yXRAREZXc6xXLLodqTctncMa+8Sb5mwhehpCFgrF+oezrR1LsqoVVbaJQRpvdnrFuZaq3vIwCnY729CQ74TXf+2QAFdeV1dyFdNO3HfI6z9xGR599lIoeqi27Ywpbis0Ei+VbXeJd7X7j55PXaIUv8LJ25SZpznu2Bok/m1t/kcdJCSXU7aLazn1RR71VW2Jsz+Ad6NsYICNMHVA6dGbjaTw60gTSjpJrtnSOuj/hevQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8d073e-d7cd-408d-4e98-08d67a985d48
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2019 03:20:13.7203 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5677
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
Cc: Roy Pledge <roy.pledge@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "bharatb.yadav@gmail.com" <bharatb.yadav@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGkgWWFuZyA8bGVveWFu
Zy5saUBueHAuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDE1LCAyMDE5IDEyOjQ3IEFN
DQo+IFRvOiBCaGFyYXQgQmh1c2hhbiA8YmhhcmF0LmJodXNoYW5AbnhwLmNvbT4NCj4gQ2M6IFJv
eSBQbGVkZ2UgPHJveS5wbGVkZ2VAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7DQo+IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7DQo+IGJoYXJhdGIueWFkYXZAZ21haWwuY29tDQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0hdIHNvYzogZnNsOiBkcGlvOiBmaXggY3B1IHJhbmdlIGNoZWNrDQo+IA0KPiBP
biBTdW4sIEphbiAxMywgMjAxOSBhdCAxMToxMyBQTSBCaGFyYXQgQmh1c2hhbg0KPiA8YmhhcmF0
LmJodXNoYW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBjcHVfcG9zc2libGUoY3B1KSB3aWxs
IGFsd2F5cyByZXR1cm4gdHJ1ZSB3aGVuIGNwdSBwYXJhbWV0ZXIgaXMgZnJvbQ0KPiA+IGNwdW1h
c2tfbmV4dCgpLg0KPiA+IENoZWNrIGZvciBucl9jcHVfaWRzIHJhdGhlciB0aGFuICFjcHVfcG9z
c2libGUoY3B1KS4NCj4gDQo+IFRoZXJlIGlzIGFub3RoZXIgcGF0Y2ggcGVuZGluZyBtZXJnZSBz
ZWVtcyB0byBjb3ZlciB0aGlzIGlzc3VlIHRvby4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIGl0
IGRvZXNuJ3QuDQo+IA0KPiBodHRwczovL2VtZWEwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRs
b29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGbG9yDQo+IGUua2VybmVsLm9yZyUyRnBhdGNod29y
ayUyRnBhdGNoJTJGMTAyMDkwNSUyRiZhbXA7ZGF0YT0wMiU3QzAxJQ0KPiA3Q2JoYXJhdC5iaHVz
aGFuJTQwbnhwLmNvbSU3QzQ3YWY2ODYxYzNmODQwOTQ0MzRjMDhkNjdhNTRlMWM0JTdDNg0KPiA4
NmVhMWQzYmMyYjRjNmZhOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzY4MzA5MDIzMTQ0NDY2
NzcmYW1wDQo+IDtzZGF0YT13TFB1TUdvc1hPVDQ4R205SyUyRkJqbTFJUmJHUUVXUjREJTJGU3FS
dDBJMFh5RSUzRCZhDQo+IG1wO3Jlc2VydmVkPTANCg0KRGVzY3JpcHRpb24gYW5kIGludGVudGlv
biBvZiB0aGUgcGF0Y2ggd2FzIHRvIGZpeCBzb21lIG90aGVyIGlzc3VlIGJ1dCB0aGlzIGFsc28g
Zml4ZXMgdGhlIGNwdSByYW5nZSBjaGVjayBpc3N1ZSBpbiBteSBwYXRjaC4NCk15IHBhdGNoIGNh
biBiZSBpZ25vcmVkLg0KDQpUaGFua3MNCi1CaGFyYXQNCg0KPiANCj4gTGVvDQo+ID4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBCaGFyYXQgQmh1c2hhbiA8QmhhcmF0LkJodXNoYW5AbnhwLmNvbT4NCj4g
PiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYyB8IDIgKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYw0KPiA+IGIv
ZHJpdmVycy9zb2MvZnNsL2RwaW8vZHBpby1kcml2ZXIuYw0KPiA+IGluZGV4IGU1OGZjYzkwOTZl
OC4uZWIzNjlkZDllMGE3IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvc29jL2ZzbC9kcGlvL2Rw
aW8tZHJpdmVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9mc2wvZHBpby9kcGlvLWRyaXZlci5j
DQo+ID4gQEAgLTEzMyw3ICsxMzMsNyBAQCBzdGF0aWMgaW50IGRwYWEyX2RwaW9fcHJvYmUoc3Ry
dWN0IGZzbF9tY19kZXZpY2UNCj4gKmRwaW9fZGV2KQ0KPiA+ICAgICAgICAgZWxzZQ0KPiA+ICAg
ICAgICAgICAgICAgICBuZXh0X2NwdSA9IGNwdW1hc2tfbmV4dChuZXh0X2NwdSwgY3B1X29ubGlu
ZV9tYXNrKTsNCj4gPg0KPiA+IC0gICAgICAgaWYgKCFjcHVfcG9zc2libGUobmV4dF9jcHUpKSB7
DQo+ID4gKyAgICAgICBpZiAobmV4dF9jcHUgPj0gbnJfY3B1X2lkcykgew0KPiA+ICAgICAgICAg
ICAgICAgICBkZXZfZXJyKGRldiwgInByb2JlIGZhaWxlZC4gTnVtYmVyIG9mIERQSU9zIGV4Y2Vl
ZHMNCj4gTlJfQ1BVUy5cbiIpOw0KPiA+ICAgICAgICAgICAgICAgICBlcnIgPSAtRVJBTkdFOw0K
PiA+ICAgICAgICAgICAgICAgICBnb3RvIGVycl9hbGxvY2F0ZV9pcnFzOw0KPiA+IC0tDQo+ID4g
Mi4yMC4xDQo+ID4NCg==
