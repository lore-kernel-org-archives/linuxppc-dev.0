Return-Path: <SRS0=rwjh=CN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF612C433E2
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 21:03:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CA120709
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Sep 2020 21:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CA120709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bjqrf66tVzDqgZ
	for <linuxppc-dev@archiver.kernel.org>; Sat,  5 Sep 2020 07:02:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aculab.com (client-ip=185.58.86.151;
 helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bjqph68rwzDql9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Sep 2020 07:01:15 +1000 (AEST)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-259-YWysdasQNmmHPaKEedcGPw-1; Fri, 04 Sep 2020 22:01:07 +0100
X-MC-Unique: YWysdasQNmmHPaKEedcGPw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 4 Sep 2020 22:01:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Fri, 4 Sep 2020 22:01:06 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexey Dobriyan' <adobriyan@gmail.com>, Ingo Molnar <mingo@kernel.org>
Subject: RE: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Topic: remove the last set_fs() in common code, and remove it for x86
 and powerpc v3
Thread-Index: AQHWguUCiBf1LDvZDEmt0ea9xeMo3alY9jkQ
Date: Fri, 4 Sep 2020 21:01:06 +0000
Message-ID: <63f3c9342a784a0890b3b641a71a8aa1@AcuMS.aculab.com>
References: <20200903142242.925828-1-hch@lst.de>
 <20200904060024.GA2779810@gmail.com>
 <20200904175823.GA500051@localhost.localdomain>
In-Reply-To: <20200904175823.GA500051@localhost.localdomain>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Content-Language: en-US
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
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Kees Cook <keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Luis
 Chamberlain <mcgrof@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDA0IFNlcHRlbWJlciAyMDIwIDE4OjU4DQo+
IA0KPiBPbiBGcmksIFNlcCAwNCwgMjAyMCBhdCAwODowMDoyNEFNICswMjAwLCBJbmdvIE1vbG5h
ciB3cm90ZToNCj4gPiAqIENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPiB3cm90ZToNCj4g
PiA+IHRoaXMgc2VyaWVzIHJlbW92ZXMgdGhlIGxhc3Qgc2V0X2ZzKCkgdXNlZCB0byBmb3JjZSBh
IGtlcm5lbCBhZGRyZXNzDQo+ID4gPiBzcGFjZSBmb3IgdGhlIHVhY2Nlc3MgY29kZSBpbiB0aGUg
a2VybmVsIHJlYWQvd3JpdGUvc3BsaWNlIGNvZGUsIGFuZCB0aGVuDQo+ID4gPiBzdG9wcyBpbXBs
ZW1lbnRpbmcgdGhlIGFkZHJlc3Mgc3BhY2Ugb3ZlcnJpZGVzIGVudGlyZWx5IGZvciB4ODYgYW5k
DQo+ID4gPiBwb3dlcnBjLg0KPiA+DQo+ID4gQ29vbCEgRm9yIHRoZSB4ODYgYml0czoNCj4gPg0K
PiA+ICAgQWNrZWQtYnk6IEluZ28gTW9sbmFyIDxtaW5nb0BrZXJuZWwub3JnPg0KPiANCj4gc2V0
X2ZzKCkgaXMgb2xkZXIgdGhhbiBzb21lIGtlcm5lbCBoYWNrZXJzIQ0KPiANCj4gCSQgY2QgbGlu
dXgtMC4xMS8NCj4gCSQgZmluZCAuIC10eXBlIGYgLW5hbWUgJyouaCcgfCB4YXJncyBncmVwIC1l
IHNldF9mcyAtdyAtbiAtQTMNCj4gCS4vaW5jbHVkZS9hc20vc2VnbWVudC5oOjYxOmV4dGVybiBp
bmxpbmUgdm9pZCBzZXRfZnModW5zaWduZWQgbG9uZyB2YWwpDQo+IAkuL2luY2x1ZGUvYXNtL3Nl
Z21lbnQuaC02Mi17DQo+IAkuL2luY2x1ZGUvYXNtL3NlZ21lbnQuaC02My0gICAgIF9fYXNtX18o
Im1vdiAlMCwlJWZzIjo6ImEiICgodW5zaWduZWQgc2hvcnQpIHZhbCkpOw0KPiAJLi9pbmNsdWRl
L2FzbS9zZWdtZW50LmgtNjQtfQ0KDQpXaGF0IGlzIHRoaXMgc3RyYW5nZSAlZnMgcmVnaXN0ZXIg
eW91IGFyZSB0YWxraW5nIGFib3V0Lg0KRmlndXJlIDItNCBvbmx5IGhhcyBDUywgRFMsIFNTIGFu
ZCBFUy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

