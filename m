Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3531A1A1A1E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 19:27:49 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiaobo
 Xie" <X.Xie@freescale.com>
Subject: RE: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
Date: Thu, 4 Jun 2015 09:27:39 +0000
Message-ID: <SN1PR0301MB1550B0B2F863A80559FE8B6B9BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
 <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
 <1433398423.3415.34.camel@freescale.com>
In-Reply-To: <1433398423.3415.34.camel@freescale.com>
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

T24gVGh1LCAyMDE1LTA2LTA0IGF0IDI6MTRQTSwgV29vZCBTY290dCB3cm90ZToNCg0KDQo+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNl
bnQ6IFRodXJzZGF5LCBKdW5lIDA0LCAyMDE1IDI6MTQgUE0NCj4gVG86IFpoYW8gUWlhbmctQjQ1
NDc1DQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgWGllIFhpYW9iby1SNjMw
NjENCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHJoZWFwOiBtb3ZlIHJoZWFwLmMgZnJvbSBh
cmNoL3Bvd2VycGMvbGliLyB0bw0KPiBsaWIvDQo+IA0KPiBPbiBUaHUsIDIwMTUtMDYtMDQgYXQg
MDA6NTYgLTA1MDAsIFpoYW8gUWlhbmctQjQ1NDc1IHdyb3RlOg0KPiA+IE9uIFRodSwgMjAxNS0w
NS0yOCBhdCAxOjM3QU0gKzA4MDAsIFdvb2QgU2NvdHQgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDI4LCAyMDE1IDE6MzcgQU0NCj4gPiA+IFRvOiBa
aGFvIFFpYW5nLUI0NTQ3NQ0KPiA+ID4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3Jn
OyBXb29kIFNjb3R0LUIwNzQyMTsgWGllIFhpYW9iby0NCj4gPiA+IFI2MzA2MQ0KPiA+ID4gU3Vi
amVjdDogUmU6IFtQQVRDSCAyLzJdIHJoZWFwOiBtb3ZlIHJoZWFwLmMgZnJvbSBhcmNoL3Bvd2Vy
cGMvbGliLw0KPiA+ID4gdG8gbGliLw0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgMjAxNS0wNS0yNyBh
dCAxNzoxMiArMDgwMCwgWmhhbyBRaWFuZyB3cm90ZToNCj4gPiA+ID4gcWUgbmVlZCB0byB1c2Ug
dGhlIHJoZWFwLCBzbyBtb3ZlIGl0IHRvIHB1YmxpYyBkaXJlY3RvcnkuDQo+ID4gPg0KPiA+ID4g
WW91J3ZlIGJlZW4gcHJldmlvdXNseSBhc2tlZCB0byB1c2UgbGliL2dlbmFsbG9jLmMgcmF0aGVy
IHRoYW4NCj4gPiA+IGludHJvZHVjZSBkdXBsaWNhdGUgZnVuY3Rpb25hbGl0eSBpbnRvIC9saWIu
ICBOQUNLLg0KPiA+DQo+ID4gQ2FuJ3QgdXNlIGxpYi9nZW5hbGxvYy5jIGluc3RlYWQgb2Ygcmhl
YXAuYy4NCj4gPiBRZSBuZWVkIHRvIGFsbG9jIG11cmFtIG9mIHFlLCBub3QgRElNTS4NCj4gDQo+
IGxpYi9nZW5hbGxvYy5oIGlzIG5vdCBmb3IgYWxsb2NhdGluZyBtYWluIG1lbW9yeS4gIEl0IGlz
IGZvciBhbGxvY2F0aW5nDQo+IHNwZWNpYWwgcmVnaW9ucy4gIEl0IGlzIHNlcnZpbmcgdGhlIHNh
bWUgcHVycG9zZSBhcyByaGVhcC4NCg0KSSBuZWVkIHRvIHVzZSB0aGUgZnVuYyAicmhfYWxsb2Nf
YWxpZ24iLCB3aGF0IGl0IHRoZSBzaW1pbGFyIGZ1bmM/DQpJIGp1c3QgZmluZCBhIGZ1bmMgImdl
bl9wb29sX2ZpcnN0X2ZpdF9vcmRlcl9hbGlnbiIuDQoNCj4gDQo+IC1TY290dA0KDQo=
