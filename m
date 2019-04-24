Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFAEC10F11
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 11:12:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4280D2084F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 11:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="nHKXxWrB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4280D2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44pyMK5jKDzDqVb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 21:12:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=mellanox.com
 (client-ip=40.107.4.49; helo=eur03-db5-obe.outbound.protection.outlook.com;
 envelope-from=jgg@mellanox.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=mellanox.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=Mellanox.com header.i=@Mellanox.com header.b="nHKXxWrB";
 dkim-atps=neutral
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (mail-eopbgr40049.outbound.protection.outlook.com [40.107.4.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44pyKN5SJqzDqLG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 21:10:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPEiu42rgo6AAkZPM/0toMixmUc0zuDGTMqtvHqDWnY=;
 b=nHKXxWrBy84W+McNcwKrMITv1pI7V13DiFxt8aRGPzVhYzAthrvK1F0AOf+7y5Ha3FFHnvT/FhLvl/9OUPmhHHg90NYvAmw4WJDBL88hIyQuD/k2OVWPjn5UcCLY9V8IjRnh0yiMvVCA0RCGvU2VdVezIZEPxb/R89AxyQFGNvs=
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com (10.171.182.144) by
 VI1PR05MB5229.eurprd05.prod.outlook.com (20.178.12.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.18; Wed, 24 Apr 2019 11:10:25 +0000
Received: from VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044]) by VI1PR05MB4141.eurprd05.prod.outlook.com
 ([fe80::711b:c0d6:eece:f044%5]) with mapi id 15.20.1835.010; Wed, 24 Apr 2019
 11:10:25 +0000
From: Jason Gunthorpe <jgg@mellanox.com>
To: Daniel Jordan <daniel.m.jordan@oracle.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, 
 Christoph Lameter <cl@linux.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
Thread-Topic: [PATCH 5/6] powerpc/mmu: drop mmap_sem now that locked_vm is
 atomic
Thread-Index: AQHU+kOniVAZZpNOp0ONWbu0yPpKu6ZLKBIA
Date: Wed, 24 Apr 2019 11:10:24 +0000
Message-ID: <20190424111018.GA16077@mellanox.com>
References: <20190402204158.27582-1-daniel.m.jordan@oracle.com>
 <20190402204158.27582-6-daniel.m.jordan@oracle.com>
 <964bd5b0-f1e5-7bf0-5c58-18e75c550841@c-s.fr>
 <20190403164002.hued52o4mga4yprw@ca-dmjordan1.us.oracle.com>
 <20190424021544.ygqa4hvwbyb6nuxp@linux-r8p5>
In-Reply-To: <20190424021544.ygqa4hvwbyb6nuxp@linux-r8p5>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YQXPR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::19) To VI1PR05MB4141.eurprd05.prod.outlook.com
 (2603:10a6:803:4d::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [156.34.49.251]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63bba6c3-5097-4877-7923-08d6c8a572eb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);
 SRVR:VI1PR05MB5229; 
x-ms-traffictypediagnostic: VI1PR05MB5229:
x-microsoft-antispam-prvs: <VI1PR05MB5229D9FD8B261989270574DBCF3C0@VI1PR05MB5229.eurprd05.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(6116002)(3846002)(11346002)(486006)(6506007)(81156014)(476003)(81166006)(110136005)(8936002)(316002)(8676002)(97736004)(66066001)(186003)(2616005)(7736002)(33656002)(446003)(386003)(76176011)(102836004)(5660300002)(26005)(2501003)(305945005)(14454004)(66556008)(36756003)(66446008)(2201001)(6486002)(6436002)(478600001)(71200400001)(229853002)(6512007)(99286004)(25786009)(64756008)(53936002)(256004)(14444005)(86362001)(66574012)(93886005)(52116002)(6246003)(1076003)(66946007)(71190400001)(66476007)(73956011)(68736007)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR05MB5229;
 H:VI1PR05MB4141.eurprd05.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e44iCNVsn7lwiLfBWGPu9SQGqnQC2MKTJE98tHmglzlPpe+tP530yvBkc07F00kylak2nzNGsALS8RuBZZ3q6BK5dP6U63jPvS9e7HwZts4Gyg3+60HePaabcUiG1BYQFXfD/fOWrrKnG8EhntUZssJ17ADV1KBUiCm8UG8L/gsQNZ9YTyF6oUMxT2SOPxrLhHCexJhxAuPyIK6jLHeNcORYev3/6fMvbcGaLbJIwrAeXis+Lo0PI4fQJMWSkNw/C3pV1ZvVfC5kC1C4eZHgHOseRFpl6/erTjajZq6I1NKIvax0+wi12m/Ft8CfVAgm1SL7QkqW8r5Sj/yFt4nXaQ9azUuHvcZ3mdV1woyfLiZx6IJwgf4DxTIp4czZ2UHV7h2ZPZMghNhMXFPUtrLoIXvUfM+jHyqCe5NMHP60pU8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15126D875D7F04E8A1DFEE8CAACE598@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63bba6c3-5097-4877-7923-08d6c8a572eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 11:10:25.2484 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5229
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gVHVlLCBBcHIgMjMsIDIwMTkgYXQgMDc6MTU6NDRQTSAtMDcwMCwgRGF2aWRsb2hyIEJ1ZXNv
IHdyb3RlOg0KPiBPbiBXZWQsIDAzIEFwciAyMDE5LCBEYW5pZWwgSm9yZGFuIHdyb3RlOg0KPiAN
Cj4gPiBPbiBXZWQsIEFwciAwMywgMjAxOSBhdCAwNjo1ODo0NUFNICswMjAwLCBDaHJpc3RvcGhl
IExlcm95IHdyb3RlOg0KPiA+ID4gTGUgMDIvMDQvMjAxOSDDoCAyMjo0MSwgRGFuaWVsIEpvcmRh
biBhIMOpY3JpdMKgOg0KPiA+ID4gPiBXaXRoIGxvY2tlZF92bSBub3cgYW4gYXRvbWljLCB0aGVy
ZSBpcyBubyBuZWVkIHRvIHRha2UgbW1hcF9zZW0gYXMNCj4gPiA+ID4gd3JpdGVyLiAgRGVsZXRl
IGFuZCByZWZhY3RvciBhY2NvcmRpbmdseS4NCj4gPiA+IA0KPiA+ID4gQ291bGQgeW91IHBsZWFz
ZSBkZXRhaWwgdGhlIGNoYW5nZSA/DQo+ID4gDQo+ID4gT2ssIEknbGwgYmUgbW9yZSBzcGVjaWZp
YyBpbiB0aGUgbmV4dCB2ZXJzaW9uLCB1c2luZyBzb21lIG9mIHlvdXIgbGFuZ3VhZ2UgaW4NCj4g
PiBmYWN0LiAgOikNCj4gPiANCj4gPiA+IEl0IGxvb2tzIGxpa2UgdGhpcyBpcyBub3QgdGhlIG9u
bHkNCj4gPiA+IGNoYW5nZS4gSSdtIHdvbmRlcmluZyB3aGF0IHRoZSBjb25zZXF1ZW5jZXMgYXJl
Lg0KPiA+ID4gDQo+ID4gPiBCZWZvcmUgd2UgZGlkOg0KPiA+ID4gLSBsb2NrDQo+ID4gPiAtIGNh
bGN1bGF0ZSBmdXR1cmUgdmFsdWUNCj4gPiA+IC0gY2hlY2sgdGhlIGZ1dHVyZSB2YWx1ZSBpcyBh
Y2NlcHRhYmxlDQo+ID4gPiAtIHVwZGF0ZSB2YWx1ZSBpZiBmdXR1cmUgdmFsdWUgYWNjZXB0YWJs
ZQ0KPiA+ID4gLSByZXR1cm4gZXJyb3IgaWYgZnV0dXJlIHZhbHVlIG5vbiBhY2NlcHRhYmxlDQo+
ID4gPiAtIHVubG9jaw0KPiA+ID4gDQo+ID4gPiBOb3cgd2UgZG86DQo+ID4gPiAtIGF0b21pYyB1
cGRhdGUgd2l0aCBmdXR1cmUgKHBvc3NpYmx5IHRvbyBoaWdoKSB2YWx1ZQ0KPiA+ID4gLSBjaGVj
ayB0aGUgbmV3IHZhbHVlIGlzIGFjY2VwdGFibGUNCj4gPiA+IC0gYXRvbWljIHVwZGF0ZSBiYWNr
IHdpdGggb2xkZXIgdmFsdWUgaWYgbmV3IHZhbHVlIG5vdCBhY2NlcHRhYmxlIGFuZCByZXR1cm4N
Cj4gPiA+IGVycm9yDQo+ID4gPiANCj4gPiA+IFNvIGlmIGEgY29uY3VycmVudCBhY3Rpb24gd2Fu
dHMgdG8gaW5jcmVhc2UgbG9ja2VkX3ZtIHdpdGggYW4gYWNjZXB0YWJsZQ0KPiA+ID4gc3RlcCB3
aGlsZSBhbm90aGVyIG9uZSBoYXMgdGVtcG9yYXJpbHkgc2V0IGl0IHRvbyBoaWdoLCBpdCB3aWxs
IG5vdyBmYWlsLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHdlIHNob3VsZCBrZWVwIHRoZSBwcmV2
aW91cyBhcHByb2FjaCBhbmQgZG8gYSBjbXB4Y2hnIGFmdGVyDQo+ID4gPiB2YWxpZGF0aW5nIHRo
ZSBuZXcgdmFsdWUuDQo+IA0KPiBXb3VsZG4ndCB0aGUgY21weGNoZyBhbHRlcm5hdGl2ZSBhbHNv
IGJlIGV4cG9zZWQgdGhlIGxvY2tlZF92bSBjaGFuZ2luZyBiZXR3ZWVuDQo+IHZhbGlkYXRpbmcg
dGhlIG5ldyB2YWx1ZSBhbmQgdGhlIGNtcHhjaGcoKSBhbmQgd2UnZCBib2d1c2x5IGZhaWwgZXZl
biB3aGVuIHRoZXJlDQo+IGlzIHN0aWxsIGp1c3QgYmVjYXVzZSB0aGUgdmFsdWUgY2hhbmdlZCAo
SSdtIGFzc3VtaW5nIHdlIGRvbid0IGhvbGQgYW55IGxvY2tzLA0KPiBvdGhlcndpc2UgYWxsIHRo
aXMgaXMgcG9pbnRsZXNzKS4NCj4gDQo+ICAgY3VycmVudF9sb2NrZWQgPSBhdG9taWNfcmVhZCgm
bW0tPmxvY2tlZF92bSk7DQo+ICAgbmV3X2xvY2tlZCA9IGN1cnJlbnRfbG9ja2VkICsgbnBhZ2Vz
Ow0KPiAgIGlmIChuZXdfbG9ja2VkIDwgbG9ja19saW1pdCkNCj4gICAgICBpZiAoY21weGNoZygm
bW0tPmxvY2tlZF92bSwgY3VycmVudF9sb2NrZWQsIG5ld19sb2NrZWQpID09IGN1cnJlbnRfbG9j
a2VkKQ0KPiAgICAgIAkgLyogRU5PTUVNICovDQoNCldlbGwgaXQgbmVlZHMgYSBsb29wLi4NCg0K
YWdhaW46DQogICBjdXJyZW50X2xvY2tlZCA9IGF0b21pY19yZWFkKCZtbS0+bG9ja2VkX3ZtKTsN
CiAgIG5ld19sb2NrZWQgPSBjdXJyZW50X2xvY2tlZCArIG5wYWdlczsNCiAgIGlmIChuZXdfbG9j
a2VkIDwgbG9ja19saW1pdCkNCiAgICAgIGlmIChjbXB4Y2hnKCZtbS0+bG9ja2VkX3ZtLCBjdXJy
ZW50X2xvY2tlZCwgbmV3X2xvY2tlZCkgIT0gY3VycmVudF9sb2NrZWQpDQogICAgICAgICAgICBn
b3RvIGFnYWluOw0KDQpTbyBpdCB3b24ndCBoYXZlIGJvZ3VzIGZhaWx1cmVzIGFzIHRoZXJlIGlz
IG5vIHVud2luZCBhZnRlcg0KZXJyb3IuIEJhc2ljYWxseSB0aGlzIGlzIGEgbG9hZCBsb2NrZWQv
c3RvcmUgY29uZGl0aW9uYWwgc3R5bGUgb2YNCmxvY2tpbmcgcGF0dGVybi4NCg0KPiA+IFRoYXQn
cyBhIGdvb2QgaWRlYSwgYW5kIGVzcGVjaWFsbHkgd29ydGggZG9pbmcgY29uc2lkZXJpbmcgdGhh
dCBhbiBhcmJpdHJhcnkNCj4gPiBudW1iZXIgb2YgdGhyZWFkcyB0aGF0IGNoYXJnZSBhIGxvdyBh
bW91bnQgb2YgbG9ja2VkX3ZtIGNhbiBmYWlsIGp1c3QgYmVjYXVzZQ0KPiA+IG9uZSB0aHJlYWQg
Y2hhcmdlcyBsb3RzIG9mIGl0Lg0KPiANCj4gWWVhaCBidXQgdGhlIHdpbmRvdyBmb3IgdGhpcyBp
cyBxdWl0ZSBzbWFsbCwgSSBkb3VidCBpdCB3b3VsZCBiZSBhIHJlYWwgaXNzdWUuDQo+IA0KPiBX
aGF0IGlmIGJlZm9yZSBkb2luZyB0aGUgYXRvbWljX2FkZF9yZXR1cm4oKSwgd2UgZmlyc3QgZGlk
IHRoZSByYWN5IG5ld19sb2NrZWQNCj4gY2hlY2sgZm9yIEVOT01FTSwgdGhlbiBkbyB0aGUgc3Bl
Y3VsYXRpdmUgYWRkIGFuZCBjbGVhbnVwLCBpZiBuZWNlc3NhcnkuIFRoaXMNCj4gd291bGQgZnVy
dGhlciByZWR1Y2UgdGhlIHNjb3BlIG9mIHRoZSB3aW5kb3cgd2hlcmUgZmFsc2UgRU5PTUVNIGNh
biBvY2N1ci4NCj4gDQo+ID4gcGlubmVkX3ZtIGFwcGVhcnMgdG8gYmUgYnJva2VuIHRoZSBzYW1l
IHdheSwgc28gSSBjYW4gZml4IGl0IHRvbyB1bmxlc3Mgc29tZW9uZQ0KPiA+IGJlYXRzIG1lIHRv
IGl0Lg0KPiANCj4gVGhpcyBzaG91bGQgbm90IGJlIGEgc3VycHJpc2UgZm9yIHRoZSByZG1hIGZv
bGtzLiBDYydpbmcgSmFzb24gbm9uZXRoZWxlc3MuDQoNCkkgdGhpbmsgd2UgYWNjZXB0ZWQgdGhp
cyB0aW55IHJhY2UgYXMgYSBzaWRlIGVmZmVjdCBvZiByZW1vdmluZyB0aGUNCmxvY2ssIHdoaWNo
IHdhcyB2ZXJ5IGJlbmVmaWNpYWwuIFJlYWxseSB0aGUgdGltZSB3aW5kb3cgYmV0d2VlbiB0aGUN
CmF0b21pYyBmYWlsaW5nIGFuZCB1bndpbmQgaXMgdmVyeSBzbWFsbCwgYW5kIHRoZXJlIGFyZSBl
bm91Z2ggb3RoZXINCndheXMgYSBob3N0aWxlIHVzZXIgY291bGQgRE9TIGxvY2tlZF92bSB0aGF0
IEkgZG9uJ3QgdGhpbmsgaXQgcmVhbGx5DQptYXR0ZXJzIGluIHByYWN0aWNlLi4NCg0KSG93ZXZl
ciwgdGhlIGNtcHhjaGcgc2VlbXMgYmV0dGVyLCBzbyBhIGhlbHBlciB0byBpbXBsZW1lbnQgdGhh
dCB3b3VsZA0KcHJvYmFibHkgYmUgdGhlIGJlc3QgdGhpbmcgdG8gZG8uDQoNCkphc29uDQo=
