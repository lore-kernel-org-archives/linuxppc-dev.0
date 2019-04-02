Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF31C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 07:05:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84384206BA
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 07:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="pIO22P0I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84384206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YKwY2CBDzDqF7
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:05:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44YKkT4bbDzDqLd
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:56:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="pIO22P0I";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44YKkT01wMz8sw2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2019 17:56:32 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44YKkS5TpPz9sTX; Tue,  2 Apr 2019 17:56:32 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.68.65; helo=nam04-bn3-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="pIO22P0I";
 dkim-atps=neutral
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44YKkR2pMZz9sTQ
 for <linuxppc-dev@ozlabs.org>; Tue,  2 Apr 2019 17:56:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJiMKEPsWm77YSwrZFpMYtv5n2D4amYB9bAyr9nMtIs=;
 b=pIO22P0IdQFyLu6IP3tyfEk3Ys/Po3mnDVyH7tw1fMLBmk6c5DO8xS+rQIjvXdleUevxc4jt2J1zGgDlbD59l3Gp3EPErfFrPUDhcpVRzBTPZMERJuoY+v+ByQnec8eaEAn6oGItSOBFXvJ5tppE2sIplqqzFol9/AKYOx1gfjw=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3569.namprd10.prod.outlook.com (20.179.79.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Tue, 2 Apr 2019 06:56:27 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1750.017; Tue, 2 Apr 2019
 06:56:27 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
Thread-Topic: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
Thread-Index: AQHU5iX/fml8VT6UTEqawEqVHaOCaKYiysYAgAWhHACAAAoygA==
Date: Tue, 2 Apr 2019 06:56:27 +0000
Message-ID: <b4501def553a2352a4f219637245d3bbcaf9700d.camel@infinera.com>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
 <20190329112620.14489-14-mpe@ellerman.id.au>
 <763028d666042f5642104b42aaa416c2867baa31.camel@infinera.com>
 <87imvxorn7.fsf@concordia.ellerman.id.au>
In-Reply-To: <87imvxorn7.fsf@concordia.ellerman.id.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc0914a8-119e-4588-3aee-08d6b73853d8
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);
 SRVR:BN8PR10MB3569; 
x-ms-traffictypediagnostic: BN8PR10MB3569:
x-microsoft-antispam-prvs: <BN8PR10MB35693EE22DE32A08F045A693F4560@BN8PR10MB3569.namprd10.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(396003)(346002)(376002)(136003)(199004)(189003)(2906002)(97736004)(36756003)(66066001)(256004)(72206003)(102836004)(76176011)(6506007)(68736007)(14454004)(6486002)(6436002)(6116002)(3846002)(229853002)(71200400001)(71190400001)(478600001)(486006)(25786009)(106356001)(105586002)(53936002)(6512007)(2616005)(476003)(11346002)(446003)(2201001)(118296001)(86362001)(4326008)(8676002)(110136005)(6246003)(186003)(54906003)(316002)(26005)(5660300002)(81156014)(2501003)(93886005)(7736002)(81166006)(305945005)(99286004)(8936002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3569;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ens1IN+RjdkWHVfmMJ4onOPQXDPLmwi5Gkn9qqbDndBVjTk5dZc7AfloVttjeeZenYegnn0wxqOxtbKCl3Jpa6E8tc2bq45PEofidmwfPf3lfcVgZSBUVQccT3ysLCXUHDvc793gslSHv0OwyzLT8jnXUJJUNNb8EhDBTazNto87BumPcUk6IOHPH2T6qlgMcuNxRONQKSU+Mu4wtvMDgzKJuzdTSlFBT5vWp/ZOuJpAlAqkmB8NEZaAKSHKXRqX76ybRmwaTcZ60mUGFxOp0633Xrsyp2qCgqtXQQHLzoUbRTpgyDnABUrjEh/gzKN+Ovrm2o693XSQqVC8XbSYJt6OPM5rlKHY9hqbGr0Kf4+tiTL+keqAkSwMPMELVr/RjnEvMKReJas+8juGFte8N7/ClMnxJnNn3fZ1oS1KxTQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FF65110FFD3494BA27B12A51868F7C1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0914a8-119e-4588-3aee-08d6b73853d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 06:56:27.0664 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3569
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
Cc: "diana.craciun@nxp.com" <diana.craciun@nxp.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gVHVlLCAyMDE5LTA0LTAyIGF0IDE3OjE5ICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiANCj4gSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb20+
IHdyaXRlczoNCj4gPiBPbiBGcmksIDIwMTktMDMtMjkgYXQgMjI6MjYgKzExMDAsIE1pY2hhZWwg
RWxsZXJtYW4gd3JvdGU6DQo+ID4gPiBGcm9tOiBEaWFuYSBDcmFjaXVuIDxkaWFuYS5jcmFjaXVu
QG54cC5jb20+DQo+ID4gPiANCj4gPiA+IGNvbW1pdCBlYmNkMWJmYzMzYzdhOTBkZjk0MWRmNjhh
NmU1ZDQwMThjMDIyZmJhIHVwc3RyZWFtLg0KPiA+ID4gDQo+ID4gPiBJbXBsZW1lbnQgdGhlIGJh
cnJpZXJfbm9zcGVjIGFzIGEgaXN5bmM7c3luYyBpbnN0cnVjdGlvbiBzZXF1ZW5jZS4NCj4gPiA+
IFRoZSBpbXBsZW1lbnRhdGlvbiB1c2VzIHRoZSBpbmZyYXN0cnVjdHVyZSBidWlsdCBmb3IgQk9P
SzNTIDY0Lg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEaWFuYSBDcmFjaXVuIDxkaWFu
YS5jcmFjaXVuQG54cC5jb20+DQo+ID4gPiBbbXBlOiBTcGxpdCBvdXQgb2YgbGFyZ2VyIHBhdGNo
XQ0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlk
LmF1Pg0KPiA+IA0KPiA+IFdoYXQgaXMgdGhlIHBlcmZvcm1hbmMgaW1wYWN0IG9mIHRoZXNlIHNw
ZWN0cmUgZml4ZXM/DQo+IA0KPiBJJ3ZlIG5vdCBzZWVuIGFueSBudW1iZXJzIGZyb20gYW55b25l
Lg0KDQpUaGFua3MgZm9yIGdldHRpbmcgYmFjayB0byBtZS4NCg0KPiANCj4gSXQgd2lsbCBkZXBl
bmQgb24gdGhlIHdvcmtsb2FkLCBpdCdzIGNvcHkgdG8vZnJvbSB1c2VyIHRoYXQgaXMgbW9zdA0K
PiBsaWtlbHkgdG8gc2hvdyBhbiBpbXBhY3QuDQo+IA0KPiBXZSBoYXZlIGEgY29udGV4dCBzd2l0
Y2ggYmVuY2htYXJrIGluDQo+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL3Bvd2VycGMvYmVuY2ht
YXJrcy9jb250ZXh0X3N3aXRjaC5jLg0KPiANCj4gUnVubmluZyB0aGF0IHdpdGggIi0tbm8tdmVj
dG9yIC0tbm8tYWx0aXZlYyAtLW5vLWZwIC0tdGVzdD1waXBlIiBzaG93cw0KPiBhYm91dCBhIDIu
MyUgc2xvdyBkb3duIHZzIGJvb3Rpbmcgd2l0aCAibm9zcGVjdHJlX3YxIi4NCj4gDQo+ID4gQ2Fu
IEkgY29tcGlsZSBpdCBhd2F5Pw0KPiANCj4gWW91IGNhbid0IGFjdHVhbGx5LCBidXQgeW91IGNh
biBkaXNhYmxlIGl0IGF0IHJ1bnRpbWUgd2l0aA0KPiAibm9zcGVjdHJlX3YxIiBvbiB0aGUga2Vy
bmVsIGNvbW1hbmQgbGluZS4NCj4gDQo+IFdlIGNvdWxkIG1ha2UgaXQgYSB1c2VyIHNlbGVjdGFi
bGUgY29tcGlsZSB0aW1lIG9wdGlvbiBpZiB5b3UgcmVhbGx5DQo+IHdhbnQgaXQgdG8gYmUuDQoN
CkkgdGhpbmsgeWVzLiBDb25zaWRlcmluZyB0aGF0IHRoZXNlIHBhdGNoZXMgYXJlIGZhaXJseSB1
bnRlc3RlZCBhbmQgdGhlIGltcGFjdA0KaW4gdGhlIHdpbGQgdW5rbm93bi4gUmVxdWlyaW5nIHN5
c3RlbXMgdG8gY2hhbmdlIHRoZWlyIGJvb3QgY29uZmlnIG92ZXIgbmlnaHQgaXMNCnRvbyBmYXN0
Lg0KDQogSm9ja2UNCg0K
