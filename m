Return-Path: <yangbo.lu@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0118.outbound.protection.outlook.com [157.56.111.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79C191A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 18:04:08 +1000 (AEST)
From: Lu Y.B. <yangbo.lu@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-mmc
 <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-esdhc: add workaround for T4240
 incorrect HOSTVER value
Date: Wed, 26 Aug 2015 07:49:52 +0000
Message-ID: <BY1PR0301MB119219D4C4E53A73216BCF53F2600@BY1PR0301MB1192.namprd03.prod.outlook.com>
References: <1437471937-34218-1-git-send-email-yangbo.lu@freescale.com>
 <CAPDyKFpf6Ayw28dmbHhLJ8HSOSie60sUjaAnK7qqONHsRN4BDA@mail.gmail.com>
 <1437791242.2993.268.camel@freescale.com>
 <CAPDyKFp8ZStYVaFm8tjPL190dqV6vCE+oT706M=6wVCckWesLw@mail.gmail.com>
 <1438012638.2993.289.camel@freescale.com>
In-Reply-To: <1438012638.2993.289.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gPiA+IEZvciBUNDI0MC1SMS4wLVIyLjAsIHRoZSBIT1NUVkVSIHJlZ2lzdGVyIGhhcyBp
bmNvcnJjZXQgdmVuZGVyDQo+ID4gPiA+ID4gdmVyc2lvbiB2YWx1ZSBhbmQgc2RoYyBzcGVjIHZl
cnNpb24gdmFsdWUuIFRoaXMgd2lsbCBicmVhayBkb3duDQo+ID4gPiA+ID4gdGhlIEFETUEgZGF0
YSB0cmFuc2Zlci4gU28gYWRkIHdvcmthcm91bmQgdG8gZ2V0IHJpZ2h0IHZhbHVlDQo+ID4gPiA+
ID4gVlZOPTB4MTMsIFNWTiA9IDB4MS4NCj4gPiA+ID4NCj4gPiA+ID4gU28gVDQyNDAtUjEuMC1S
Mi4wIGlzIHRoZSB2ZXJzaW9uIG9mIHRoZSBjb250cm9sbGVyLCByaWdodD8NCj4gPiA+ID4NCj4g
PiA+ID4gSWYgSSB1bmRlcnN0YW5kIGNvcnJlY3QgeW91IGFyZSBjaGVja2luZyB3aGF0IENQVS9T
b0MgeW91IGFyZQ0KPiA+ID4gPiBydW5uaW5nIG9uLCB0byBmaWd1cmUgb3V0IHdoaWNoIGNvbnRy
b2xsZXIgdmVyc2lvbiB5b3UgYXJlIHVzaW5nLA0KPiA+ID4gPiBhcyB0aGF0IGNhbid0IGJlIGZl
dGNoZWQgKHRydXN0ZWQpIGZyb20gdGhlIHJlZ2lzdGVycyBvZiB0aGUgZXNkaGMNCj4gPiA+ID4g
Y29udHJvbGxlciBpdHNlbGYhPw0KPiA+ID4gPg0KPiA+ID4gPiBJbnN0ZWFkLCB5b3UgY291bGQg
ZGVhbCB3aXRoIHRoaXMgZGlyZWN0bHkgaW4gdGhlIERUUyBmaWxlcy4gSQ0KPiA+ID4gPiBhc3N1
bWUgeW91IGhhdmUgc29tZSBEVFMgZmlsZSBmb3IgZWFjaCBTb0MvYm9hcmQgdmFyaWFudCwgcmln
aHQ/DQo+ID4gPg0KPiA+ID4gTm8sIHdlIGRvIG5vdCBoYXZlIGEgc2VwYXJhdGUgRFRTIGZpbGUg
Zm9yIGVhY2ggcmV2aXNpb24gb2YgYW4gU29DDQo+ID4gPiAtLSBhbmQgaWYgd2UgZGlkLCB3ZSdk
IGNvbnN0YW50bHkgaGF2ZSBwZW9wbGUgdXNpbmcgdGhlIHdyb25nIG9uZS4NCj4gPiA+DQo+ID4g
PiA+IEluIHByaW5jaXBsZSwgaW4geW91ciBEVFMgZmlsZSBzcGVjaWZpYyBmb3IgdGhlIGJvYXJk
L1NvQyB0aGF0DQo+ID4gPiA+IGhvbGRzIHRoZSBUNDI0MC1SMS4wLVIyLjAgdmVyc2lvbiBvZiB0
aGUgY29udHJvbGxlciwgc2hvdWxkIGFkZCBhDQo+ID4gPiA+IHNwZWNpZmljIGVzZGhjIERUIHBy
b3BlcnR5IHRvIGluZGljYXRlIHRoaXMgZXJyYXRhLg0KPiA+ID4NCj4gPiA+IE5vLCBiZWNhdXNl
IChpbiBhZGRpdGlvbiB0byB0aGUgYWJvdmUgaXNzdWUgYWJvdXQgY2hpcCByZXZpc2lvbnMpDQo+
ID4gPiB0aGUgZGV2aWNlIHRyZWUgaXMgc3RhYmxlIEFCSSBhbmQgZXJyYXRhIGFyZSBvZnRlbiBk
aXNjb3ZlcmVkIGFmdGVyDQo+ID4gPiBkZXZpY2UgdHJlZXMgYXJlIGRlcGxveWVkLg0KPiA+DQo+
ID4gRmFpciBlbm91Z2guIFRoZW4gd2hhdCBpcyB5b3VyIHN1Z2dlc3Rpb24gZm9yIHRoZSBzb2x1
dGlvbiBoZXJlPw0KPiANCj4gQXMgSSBzYWlkIGluIG15IGNvbW1lbnQgb24gcGF0Y2ggMi8zLCBy
ZWFkIFNWUiBmcm9tIHRoZSBkZXZpY2UtDQo+IGNvbmZpZy9ndXRzIE1NSU8gYmxvY2ssIHdoaWNo
IHdvcmtzIG9uIGJvdGggUFBDIGFuZCBBUk0uDQo+IA0KPiAtU2NvdHQNCg0KVGhhbmtzLCBTY290
dC4NCkkgY2hlY2tlZCB0aGUgZGV2aWNlIG5vZGVzIG9mIGRldmljZS1jb25maWcvZ3V0cywgZmlu
ZGluZyBhbGwgdGhlIHBsYXRmb3JtcyBoYXMgbm90IGEgdW5pZm9ybSBjb21wYXRpYmxlIG5hbWUu
DQpDb3VsZCBJIGFkZCBhIGNvbXBhdGlibGUgbmFtZSBjYWxsZWQgImZzbCwgZGNmZyIoImZzbCwg
Z3V0cyIgaWYgdXNpbmcgZ3V0cykgZm9yIFBvd2VyUEMgUCBzZXJpZXMsIFQgc2VyaWVzLCBCIHNl
cmllcyBib2FyZHMsIHNvIHRoYXQgSSBjb3VsZCBnZXQgdGhpcyBkZXZpY2Ugbm9kZSBieSBjb21w
YXRpYmxlIHdpdGhvdXQga25vd2luZyBwbGF0Zm9ybT8gDQoNCk9yIERvIHlvdSBrbm93IHRoZXJl
IGlzIGFub3RoZXIgbWV0aG9kIHRvIGdldCB0aGlzIGRldmljZSBub2RlIGluIGNvZGUgZWFzaWx5
IHdpdGhvdXQga25vd2luZyBwbGF0Zm9ybT8NCg0KQmVzdCByZWdhcmRzLA0KWWFuZ2JvIEx1DQoN
Cg0KDQoNCg0KDQoNCg==
