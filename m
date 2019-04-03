Return-Path: <SRS0=3bX/=SF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F0CC4360F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:40:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C15B42075E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 04:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="JePS7iW6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15B42075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Ytfp47TGzDqQv
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 15:40:18 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Ytd61p5RzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 15:38:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="JePS7iW6";
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44Ytd60sL3z8tDC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 15:38:50 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44Ytd60H6Qz9sSN; Wed,  3 Apr 2019 15:38:50 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=infinera.com
 (client-ip=40.107.68.58; helo=nam04-bn3-obe.outbound.protection.outlook.com;
 envelope-from=joakim.tjernlund@infinera.com; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=infinera.com
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=infinera.com header.i=@infinera.com header.b="JePS7iW6";
 dkim-atps=neutral
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680058.outbound.protection.outlook.com [40.107.68.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44Ytd35l5fz9sSD
 for <linuxppc-dev@ozlabs.org>; Wed,  3 Apr 2019 15:38:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wooItdAv5vYiBRicaJzAAuoRxmRAqhHWiRGlrcDJnG0=;
 b=JePS7iW6F7rrTJoHp90iyus1IwQJZuR7+NZahQBy7qFaAdE+1IFMGQP+JQ5ZZl0JWLUEcu6bv3nglYEPRGeWj2s1BxvuN3cb7RvEK3qBbG2xMvfimqQ64OuDAiqsQGcwNp6C5rN9QPAFza1hGeQZs1oR+pCPOXfIzvphoCcFZ58=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (20.179.78.205) by
 BN8PR10MB3185.namprd10.prod.outlook.com (20.179.137.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Wed, 3 Apr 2019 04:38:42 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::18aa:cf18:b8d3:d77f%5]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 04:38:42 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "mpe@ellerman.id.au" <mpe@ellerman.id.au>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>, "gregkh@linuxfoundation.org"
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
Thread-Topic: [PATCH stable v4.14 13/32] powerpc/fsl: Add barrier_nospec
 implementation for NXP PowerPC Book3E
Thread-Index: AQHU5iX/fml8VT6UTEqawEqVHaOCaKYiysYAgAWhHACAAAoygIABLQkAgAA+0IA=
Date: Wed, 3 Apr 2019 04:38:42 +0000
Message-ID: <3f6773c33a1788bb289476ec3b2f96fafb2ca447.camel@infinera.com>
References: <20190329112620.14489-1-mpe@ellerman.id.au>
 <20190329112620.14489-14-mpe@ellerman.id.au>
 <763028d666042f5642104b42aaa416c2867baa31.camel@infinera.com>
 <87imvxorn7.fsf@concordia.ellerman.id.au>
 <b4501def553a2352a4f219637245d3bbcaf9700d.camel@infinera.com>
 <87zhp729jz.fsf@concordia.ellerman.id.au>
In-Reply-To: <87zhp729jz.fsf@concordia.ellerman.id.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Joakim.Tjernlund@infinera.com; 
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b66d6753-0170-423f-b6bc-08d6b7ee404f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:BN8PR10MB3185; 
x-ms-traffictypediagnostic: BN8PR10MB3185:
x-microsoft-antispam-prvs: <BN8PR10MB3185A10B781CF689D9B7ED85F4570@BN8PR10MB3185.namprd10.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(93886005)(3846002)(14454004)(6486002)(4744005)(25786009)(2906002)(316002)(186003)(256004)(5660300002)(54906003)(6506007)(110136005)(76176011)(71200400001)(71190400001)(26005)(102836004)(99286004)(4326008)(2501003)(36756003)(105586002)(6116002)(11346002)(118296001)(6246003)(476003)(2616005)(81156014)(229853002)(68736007)(106356001)(8936002)(81166006)(8676002)(86362001)(305945005)(53936002)(97736004)(2201001)(6512007)(6436002)(72206003)(66066001)(478600001)(446003)(486006)(7736002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR10MB3185;
 H:BN8PR10MB3540.namprd10.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: infinera.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Hx2PzW43DPsGQUghJD9BZLCd8rpGnWOUbP5YLYVtUIWEAgNMp62ljSCoWTnc6pYQ6euE1UtgX4LnprjZSnziejqYWri03CTbX0cswRI0Be0mMNxvf+ssq/5/uCkw9F871mPgWBX8eH6wmMO0AETY4ROJnn+hb+iWMusV37a4yJhgtHYfjOSnCRKw5ayqI029euc2svWrjltkPG8TA3HCiRuWmNsjkz7wNri+LHOTLyL2RvD+jVyaX25YEI7wLB2zxs6+d8PNuo/6cPTI99ME/Y5MabbM5y4roNxpMNW/nAyZSEGYgAipd5HAwcNV7o7n76agao8xAcL8Px8oeoCk443oa5MENw3zcw4DvZx87R98LQDC4i5sn26ABkXLi9CdrA6ffuyIUIeY2nxVKUg2jjqoPb4qNKmeriVHf1KfIXI=
Content-Type: text/plain; charset="utf-8"
Content-ID: <89F38A0C7F0B3349BFDCA2BA3D77DA22@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b66d6753-0170-423f-b6bc-08d6b7ee404f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 04:38:42.6667 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3185
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

T24gV2VkLCAyMDE5LTA0LTAzIGF0IDExOjUzICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiANCj4gSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb20+
IHdyaXRlczoNCj4gPiBPbiBUdWUsIDIwMTktMDQtMDIgYXQgMTc6MTkgKzExMDAsIE1pY2hhZWwg
RWxsZXJtYW4gd3JvdGU6DQo+ID4gPiBKb2FraW0gVGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5k
QGluZmluZXJhLmNvbT4gd3JpdGVzOg0KPiAuLi4NCj4gPiA+ID4gQ2FuIEkgY29tcGlsZSBpdCBh
d2F5Pw0KPiA+ID4gDQo+ID4gPiBZb3UgY2FuJ3QgYWN0dWFsbHksIGJ1dCB5b3UgY2FuIGRpc2Fi
bGUgaXQgYXQgcnVudGltZSB3aXRoDQo+ID4gPiAibm9zcGVjdHJlX3YxIiBvbiB0aGUga2VybmVs
IGNvbW1hbmQgbGluZS4NCj4gPiA+IA0KPiA+ID4gV2UgY291bGQgbWFrZSBpdCBhIHVzZXIgc2Vs
ZWN0YWJsZSBjb21waWxlIHRpbWUgb3B0aW9uIGlmIHlvdSByZWFsbHkNCj4gPiA+IHdhbnQgaXQg
dG8gYmUuDQo+ID4gDQo+ID4gSSB0aGluayB5ZXMuIENvbnNpZGVyaW5nIHRoYXQgdGhlc2UgcGF0
Y2hlcyBhcmUgZmFpcmx5IHVudGVzdGVkIGFuZCB0aGUgaW1wYWN0DQo+ID4gaW4gdGhlIHdpbGQg
dW5rbm93bi4gUmVxdWlyaW5nIHN5c3RlbXMgdG8gY2hhbmdlIHRoZWlyIGJvb3QgY29uZmlnIG92
ZXIgbmlnaHQgaXMNCj4gPiB0b28gZmFzdC4NCj4gDQo+IE9LLiBKdXN0IHRvIGJlIGNsZWFyLCB5
b3UncmUgYWN0dWFsbHkgdXNpbmcgNC4xNCBvbiBhbiBOWFAgYm9hcmQgYW5kDQo+IHdvdWxkIGFj
dHVhbGx5IHVzZSB0aGlzIG9wdGlvbj8gSSBkb24ndCB3YW50IHRvIGFkZCBhbm90aGVyIG9wdGlv
biBqdXN0DQo+IGZvciBhIHRoZW9yZXRpY2FsIHVzZSBjYXNlLg0KDQpDb3JyZWN0LCB3ZSB1c2Ug
NC4xNCBvbiBzZXZlcmFsIGN1c3RvbSBib2FyZHMgdXNpbmcgTlhQIENQVXMgYW5kIHdvdWxkIGFw
cHJlY2lhdGUNCmlmIEkgY291bGQgY29udHJvbCBzcGVjdHJlIHdpdGggYSBidWlsZCBzd2l0Y2gu
DQoNClRoYW5rcyBhIGxvdCENCiAgICAgICAgICAgICAgIEpvY2tlDQo=
