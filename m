Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F7BD1A0BC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Dec 2014 13:42:07 +1100 (AEDT)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: RE: [PATCH] powerpc/smp: Fix Non-boot cpus cannot be bring up.
Date: Tue, 23 Dec 2014 02:41:59 +0000
Message-ID: <BN1PR03MB1889A560297773EE7E2342B9D570@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1419230320-37558-1-git-send-email-dongsheng.wang@freescale.com>
 <1419296441.30550.3.camel@ellerman.id.au>
In-Reply-To: <1419296441.30550.3.camel@ellerman.id.au>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "anton@samba.org" <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBFbGxlcm1h
biBbbWFpbHRvOm1wZUBlbGxlcm1hbi5pZC5hdV0NCj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIg
MjMsIDIwMTQgOTowMSBBTQ0KPiBUbzogV2FuZyBEb25nc2hlbmctQjQwNTM0DQo+IENjOiBiZW5o
QGtlcm5lbC5jcmFzaGluZy5vcmc7IFdvb2QgU2NvdHQtQjA3NDIxOyBhbnRvbkBzYW1iYS5vcmc7
IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
XSBwb3dlcnBjL3NtcDogRml4IE5vbi1ib290IGNwdXMgY2Fubm90IGJlIGJyaW5nIHVwLg0KPiAN
Cj4gT24gTW9uLCAyMDE0LTEyLTIyIGF0IDE0OjM4ICswODAwLCBEb25nc2hlbmcgV2FuZyB3cm90
ZToNCj4gPiBGcm9tOiBXYW5nIERvbmdzaGVuZyA8ZG9uZ3NoZW5nLndhbmdAZnJlZXNjYWxlLmNv
bT4NCj4gPg0KPiA+IEtlcm5lbCBjYW5ub3QgYnJpbmcgdXAgTm9uLWJvb3QgY3B1cyBhbHdheXMg
Z2V0ICJQcm9jZXNzb3IgeHggaXMgc3R1Y2siLg0KPiA+IHRoaXMgaXNzdWUgYnJpbmcgYnkgaHR0
cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzQxODkxMi8gKHBvd2VycGM6DQo+ID4gU2Vj
b25kYXJ5IENQVXMgbXVzdCBzZXQgY3B1X2NhbGxpbl9tYXAgYWZ0ZXIgc2V0dGluZyBhY3RpdmUg
YW5kDQo+ID4gb25saW5lKSBXZSBuZWVkIHRvIHRha2UgdGltZWJhc2UgYWZ0ZXIgYm9vdHVwIGNw
dSBnaXZlIHRoZSB0aW1lYmFzZSBmaXJzdGx5Lg0KPiA+DQo+ID4gV2hlbiBzdGFydF9zZWNvbmRh
cnksIG5vbi1ib290IGNwdXMgc2V0IGNwdV9jYWxsaW5fbWFwIGZvciBib290IGNwdQ0KPiA+IGFm
dGVyIHRoYXQgYm9vdCBjcHUgd2lsbCBnaXZlIHRoZSB0aW1lYmFzZSBmb3Igbm9uLWJvb3QgY3B1
LiBPdGhlcndpc2UNCj4gPiBub24tYm9vdCBjcHVzIHdpbGwgZmFsbCBpbiBkZWFkIGxvb3AgdG8g
d2FpdGluZyBib290dXAgY3B1IHRvIGdpdmUNCj4gPiBpbWViYXNlLg0KPiANCj4gUmlnaHQuDQo+
IA0KPiBIb3dldmVyLCBkb2Vzbid0IHRoaXMgaW50cm9kdWNlIHRoZSBwb3NzaWJpbGl0eSB0aGF0
IHRoZSBzZWNvbmRhcnkgY3B1IGlzIHVwIGFuZA0KPiBtYXJrZWQgb25saW5lIGJ1dCBoYXMgYW4g
dW5zeW5jaHJvbmlzZWQgY2xvY2s/DQo+IA0KWWVzLCByaWdodC4gQnV0IEZyZWVzY2FsZSBwbGF0
Zm9ybSBib290LWNwdSB3aWxsIGZyZWV6ZSB0aGUgVEIgdW50aWwgc2Vjb25kYXJ5IGNwdQ0KdGFr
ZSB0aGUgdGltZSBiYXNlLCBzbyB0aGUgY2xvY2sgaXMgc3luY2hyb25pemVkLg0KDQpGb3IgZ2Vu
ZXJpYyBQb3dlclBDIG1heWJlIGhhcyB0aGlzIGlzc3VlLiBTbyBmb3Igc2FmZSBJIHRoaW5rIHdl
IG5lZWQgdG8gc2V0IGNwdSBvbmxpbmUNCmFmdGVyIHN5bmNocm9uaXplZCBjbG9jay4NCg0KSSB3
aWxsIHVwZGF0ZSBteSBwYXRjaCBpZiB5b3UgYWdyZWUgdGhpcyB3YXkuDQorICAgICAgIGlmIChz
bXBfb3BzLT50YWtlX3RpbWViYXNlKQ0KKyAgICAgICAgICAgICAgIHNtcF9vcHMtPnRha2VfdGlt
ZWJhc2UoKTsNCisgICAgICAgc2Vjb25kYXJ5X2NwdV90aW1lX2luaXQoKTsNCisNCk1vdmUgc2V0
X2NwdV9vbmxpbmUgdG8gaGVyZS4NCisgICAgICAgc2V0X2NwdV9vbmxpbmUoY3B1LCB0cnVlKTsN
Cg0KUmVnYXJkcywNCi1Eb25nc2hlbmcNCg==
