Return-Path: <SRS0=8Wjn=G5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF31C433E6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Jan 2021 10:30:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63CD323108
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Jan 2021 10:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63CD323108
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (unknown [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DQ30p5PpczDqdt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Jan 2021 21:30:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=aculab.com (client-ip=185.58.86.151;
 helo=eu-smtp-delivery-151.mimecast.com; envelope-from=david.laight@aculab.com;
 receiver=<UNKNOWN>)
Received: from eu-smtp-delivery-151.mimecast.com
 (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DQ2xv4dfYzDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2021 21:28:17 +1100 (AEDT)
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-103-0STilh9oPG2ZWsVCMifh3A-1; Tue, 26 Jan 2021 10:28:09 +0000
X-MC-Unique: 0STilh9oPG2ZWsVCMifh3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 26 Jan 2021 10:28:09 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000; 
 Tue, 26 Jan 2021 10:28:09 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Michael Ellerman <mpe@ellerman.id.au>, "msuchanek@suse.de"
 <msuchanek@suse.de>, Paul Mackerras <paulus@samba.org>
Subject: RE: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
Thread-Topic: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
Thread-Index: AQHW8807JGe39joh3kmpEKEvm5M8jao5syyQ
Date: Tue, 26 Jan 2021 10:28:09 +0000
Message-ID: <d9993f034db848d1afeffa322373b811@AcuMS.aculab.com>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
 <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
 <1611656343.yaxha7r2q4.astroid@bobo.none>
In-Reply-To: <1611656343.yaxha7r2q4.astroid@bobo.none>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

RnJvbTogTmljaG9sYXMgUGlnZ2luDQo+IFNlbnQ6IDI2IEphbnVhcnkgMjAyMSAxMDoyMQ0KPiAN
Cj4gRXhjZXJwdHMgZnJvbSBDaHJpc3RvcGhlIExlcm95J3MgbWVzc2FnZSBvZiBKYW51YXJ5IDI2
LCAyMDIxIDEyOjQ4IGFtOg0KPiA+IHN5c2NhbGxfNjQuYyB3aWxsIGJlIHJldXNlZCBhbG1vc3Qg
YXMgaXMgZm9yIFBQQzMyLg0KPiA+DQo+ID4gUmVuYW1lIGl0IHN5c2NhbGwuYw0KPiANCj4gQ291
bGQgeW91IHJlbmFtZSBpdCB0byBpbnRlcnJ1cHQuYyBpbnN0ZWFkPyBBIHN5c3RlbSBjYWxsIGlz
IGFuDQo+IGludGVycnVwdCwgYW5kIHRoZSBmaWxlIG5vdyBhbHNvIGhhcyBjb2RlIHRvIHJldHVy
biBmcm9tIG90aGVyDQo+IGludGVycnVwdHMgYXMgd2VsbCwgYW5kIGl0IG1hdGNoZXMgdGhlIG5l
dyBhc20vaW50ZXJydXB0LmggZnJvbQ0KPiB0aGUgaW50ZXJydXB0cyBzZXJpZXMuDQoNCkhtbW0u
Li4uDQoNClRoYXQgbWlnaHQgbWFrZSBpdCBoYXJkZXIgZm9yIHNvbWVvbmUgbG9va2luZyBmb3Ig
dGhlIHN5c3RlbSBjYWxsDQplbnRyeSBjb2RlIHRvIGZpbmQgaXQuDQoNCkluIHNvbWUgc2Vuc2Ug
aW50ZXJydXB0cyBhcmUgdGhlIHNpbXBsZXIgY2FzZS4NCg0KRXNwZWNpYWxseSB3aGVuIGNvbXBh
cmluZyB3aXRoIG90aGVyIGFyY2hpdGVjdHVyZXMgd2hpY2ggaGF2ZQ0Kc3BlY2lhbCBpbnN0cnVj
dGlvbnMgZm9yIHN5c2NhbGwgZW50cnkuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

