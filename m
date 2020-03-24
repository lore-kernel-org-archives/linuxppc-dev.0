Return-Path: <SRS0=VpCV=5J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD9EC54FCF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 20:08:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9A220409
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2020 20:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="u5P74aun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9A220409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48n2Pw0z07zDqRF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 25 Mar 2020 07:08:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=alliedtelesis.co.nz (client-ip=202.36.163.20;
 helo=gate2.alliedtelesis.co.nz;
 envelope-from=chris.packham@alliedtelesis.co.nz; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz
 header.a=rsa-sha256 header.s=mail181024 header.b=u5P74aun; 
 dkim-atps=neutral
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [202.36.163.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48n2Ml5TFQzDqkj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2020 07:06:59 +1100 (AEDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EBB9E80237;
 Wed, 25 Mar 2020 09:06:56 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
 s=mail181024; t=1585080416;
 bh=9WZO0YII+yE1jpC1rDt5VNtWaDHFbuem8lhAdXMMyGs=;
 h=From:To:CC:Subject:Date:References:In-Reply-To;
 b=u5P74aunSnA1vulQx557yJbviS1KV6wOdFBxlNbAtiYtqGIXoJJlX6nGY7Zd6bvVL
 0HapXq5PG7pFE7nZFQqiS0VGSZqR4tq63A3ZcaPA7tjXdTuScAceuCXB+IzL+MSVvs
 5tBHR+sr1xUL+zxFTGPeXnNFC6X3S82oqdIy6z2cQ1pkMnA68sW0MIg6AzxJ1dJzLI
 S6o61ACUsJbN4uIb6eBJFGrpye2Ekq0/uGFxfjXHwhmn4pbFnvP4mkK+Rec7yffroE
 JsIzzE/lcGwSBl15Hllgp4FhvgRSek4W3iS3Q1P3lpmmDOxXgx31c+HXCczeGT4rWk
 0+ExFWim3YkJg==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by
 mmarshal3.atlnz.lc with Trustwave SEG (v7, 5, 8, 10121)
 id <B5e7a68610000>; Wed, 25 Mar 2020 09:06:57 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 25 Mar 2020 09:06:56 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Wed, 25 Mar 2020 09:06:56 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "cai@lca.pw" <cai@lca.pw>
Subject: Re: Argh, can't find dcache properties !
Thread-Topic: Argh, can't find dcache properties !
Thread-Index: AQHWALpiXt3RJnRHvUCUrPyClavMpahWU00AgAEA2QA=
Date: Tue, 24 Mar 2020 20:06:56 +0000
Message-ID: <876a5938fbad9d9e176e5f22f12e6b472d0dc4f7.camel@alliedtelesis.co.nz>
References: <be8c123a90f6d1664a902b6ad6c754b9f3d9e567.camel@alliedtelesis.co.nz>
 <87tv2exst1.fsf@mpe.ellerman.id.au>
In-Reply-To: <87tv2exst1.fsf@mpe.ellerman.id.au>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.14.96]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF071371F606CD40ADC6A9539C5E1070@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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
Cc: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

T24gVHVlLCAyMDIwLTAzLTI0IGF0IDE1OjQ3ICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPiBDaHJpcyBQYWNraGFtIDxDaHJpcy5QYWNraGFtQGFsbGllZHRlbGVzaXMuY28ubno+IHdy
aXRlczoNCj4gPiBIaSBBbGwsDQo+ID4gDQo+ID4gSnVzdCBib290aW5nIHVwIHY1LjUuMTEgb24g
YSBGcmVlc2NhbGUgVDIwODBSREIgYW5kIEknbSBzZWVpbmcgdGhlDQo+ID4gZm9sbG93aW5nIG1l
c2FnZS4NCj4gPiANCj4gPiBrZXJuLndhcm5pbmcgbGludXhib3gga2VybmVsOiBBcmdoLCBjYW4n
dCBmaW5kIGRjYWNoZSBwcm9wZXJ0aWVzICENCj4gPiBrZXJuLndhcm5pbmcgbGludXhib3gga2Vy
bmVsOiBBcmdoLCBjYW4ndCBmaW5kIGljYWNoZSBwcm9wZXJ0aWVzICENCj4gPiANCj4gPiBUaGlz
IHdhcyBjaGFuZ2VkIGZyb20gREJHKCkgdG8gcHJfd2FybigpIGluIGNvbW1pdCAzYjkxNzZlOWE4
NzQNCj4gPiAoInBvd2VycGMvc2V0dXBfNjQ6IGZpeCAtV2VtcHR5LWJvZHkgd2FybmluZ3MiKSBi
dXQgdGhlIG1lc3NhZ2UNCj4gPiBzZWVtcw0KPiA+IHRvIGJlIG11Y2ggb2xkZXIgdGhhbiB0aGF0
LiBTbyBpdCdzIHByb2JhYmx5IGJlZW4gYW4gaXNzdWUgb24gdGhlDQo+ID4gVDIwODANCj4gPiAo
YW5kIG90aGVyIFFvcklRIFNvQ3MpIGZvciBhIHdoaWxlLg0KPiANCj4gVGhhdCdzIGFuIGU2NTAw
IEkgdGhpbms/IFNvIDY0LWJpdCBCb29rM0UuDQo+IA0KDQpZZXMgdGhhdCdzIGNvcnJlY3QuDQoN
Cj4gWW91J2xsIGJlIGdldHRpbmcgdGhlIGRlZmF1bHQgdmFsdWVzLCB3aGljaCBpcyA2NCBieXRl
cyBzbyBJIGd1ZXNzDQo+IHRoYXQNCj4gd29ya3MgaW4gcHJhY3RpY2UuDQo+IA0KPiA+IExvb2tp
bmcgYXQgdGhlIGNvZGUgdGhlIHQyMDh4IGRvZXNuJ3Qgc3BlY2lmaXkgYW55IG9mIHRoZSBkLWNh
Y2hlLQ0KPiA+IHNpemUvaS1jYWNoZS1zaXplIHByb3BlcnRpZXMuIFNob3VsZCBJIGFkZCB0aGVt
IHRvIHNpbGVuY2UgdGhlDQo+ID4gd2FybmluZw0KPiA+IG9yIHN3aXRjaCBpdCB0byBwcl9kZWJ1
ZygpL3ByX2luZm8oKT8NCj4gDQo+IFllYWggaWRlYWxseSB5b3UnZCBhZGQgdGhlbSB0byB0aGUg
ZGV2aWNlIHRyZWUocykgZm9yIHRob3NlIGJvYXJkcy4NCj4gDQoNCkkgdGhpbmsgdGhlIGluZm8g
SSBuZWVkIGlzIGluIHRoZSBibG9jayBkaWFncmFtWzBdLiBJJ2xsIHdoaXAgdXANCmEgcGF0Y2gu
DQoNCi0tDQpbMV0gLSBodHRwczovL3d3dy5ueHAuY29tL3Byb2R1Y3RzL3Byb2Nlc3NvcnMtYW5k
LW1pY3JvY29udHJvbGxlcnMvcG93ZXItYXJjaGl0ZWN0dXJlL3FvcmlxLWNvbW11bmljYXRpb24t
cHJvY2Vzc29ycy90LXNlcmllcy9xb3JpcS10MjA4MC1hbmQtdDIwODEtbXVsdGljb3JlLWNvbW11
bmljYXRpb25zLXByb2Nlc3NvcnM6VDIwODANCg==
