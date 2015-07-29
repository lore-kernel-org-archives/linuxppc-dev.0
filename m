Return-Path: <B48286@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0113.outbound.protection.outlook.com [157.56.110.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A41401A08D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 12:48:51 +1000 (AEST)
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, Hu Vincent
 <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH] powerpc/fsl-pci: fix pcie range issue for some P1/P2
 boards
Date: Wed, 29 Jul 2015 02:34:32 +0000
Message-ID: <CY1PR0301MB0780D3C72FF1F86DE25345CE8B8C0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1437559704-13332-1-git-send-email-B48286@freescale.com>
 <1437792504.2993.280.camel@freescale.com>
In-Reply-To: <1437792504.2993.280.camel@freescale.com>
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

SGkgU2NvdHQgYW5kIGFsbCwNCg0KUGxlYXNlIGlnbm9yZSB0aGlzIHBhdGNoIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6
IDIwMTXlubQ35pyIMjXml6UgMTA6NDgNCj4gVG86IEhvdSBaaGlxaWFuZy1CNDgyODYNCj4gQ2M6
IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc7
DQo+IHBhdWx1c0BzYW1iYS5vcmc7IG1wZUBlbGxlcm1hbi5pZC5hdTsgSHUgTWluZ2thaS1CMjEy
ODQNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcG93ZXJwYy9mc2wtcGNpOiBmaXggcGNpZSByYW5n
ZSBpc3N1ZSBmb3Igc29tZSBQMS9QMg0KPiBib2FyZHMNCj4gDQo+IE9uIFdlZCwgMjAxNS0wNy0y
MiBhdCAxODowOCArMDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiANCj4gPiBGcm9tOiBIb3Ug
WmhpcWlhbmcgPEI0ODI4NkBmcmVlc2NhbGUuY29tPg0KPiANCj4gWW91IENDZWQgdGhpcyB0bw0K
PiBiMjEyODRAZnJlZXNjYWxlLmNvbS4gwqBXaG8gaXMgdGhhdD8gwqBJdCB3b3VsZCBiZSBuaWNl
IHRvIHVzZSAiZnJpZW5kbHkiDQo+IGUtbWFpbCBhZGRyZXNzZXMsIGJ1dCBhdCBsZWFzdCBpbmNs
dWRlIHRoZSBuYW1lIGFsb25nIHdpdGggdGhlIGUtbWFpbA0KPiBhZGRyZXNzLg0KPiANCj4gSSBz
dWdnZXN0IENDaW5nIHRoZSBwZW9wbGUgd2hvIGFkZGVkIHRoZXNlIGRldmljZSB0cmVlcy4NCj4g
DQo+ID4gSW1wYWN0IGJvYXJkIGxpc3Q6DQo+ID4gUDEwMjBNQkctUEMuIFAxMDIyRFMsIFAyMDIw
UkRCDQo+ID4gQWxsIGFib3ZlIGJvYXJkcyBoYXZlIGl0cyBQQ0lFIG1lbW9yeSByYW5nZSBsZXNz
IHRoYW4gMHhiZmZmX2ZmZmYsDQo+IA0KPiBJZiB5b3UgbWVhbiB0aGF0IHRoZSBwaHlzaWNhbCBh
ZGRyZXNzIG9mIHRoZSBtZW1vcnkgcmVnaW9uIGlzIDw9DQo+IDB4YmZmZl9mZmZmLCBJIGRvbid0
IHNlZSB0aGUgcmVsZXZhbmNlLg0KPg0KPiA+IGJ1dCBpbiBkdHMgaXRzIGJvdW5kYXJ5IHZhbHVl
IHdhcyAweGUwMDAwMDAwLiBCb3RoIG9mIHRoZW0gd2FzIG1hcGVkDQo+ID4gdG8gdGhlIHNhbWUg
Ym91bmRhcnkgMHhlMDAwMDAwMCB3aGljaCB3YXMgT3ZlcmxhcHBlZCBhbmQgY3Jvc3NlZC4NCj4g
DQo+IEJ5ICJib3VuZGFyeSIgZG8geW91IG1lYW4gdGhlIFBDSWUgYnVzIGFkZHJlc3M/ICBXaHkg
aXMgaXQgYSBwcm9ibGVtIGZvcg0KPiB0aGVzZSBpbmRlcGVuZGVudCBQQ0llIHJvb3QgY29tcGxl
eGVzIHRvIGhhdmUgdGhlIHNhbWUgUENJZSBidXMgYWRkcmVzc2VzPw0KPg0KDQpZZXMsIHlvdSdy
ZSByaWdodC4gSXQgaXNuJ3QgYW4gaXNzdWUgdXNpbmcgdGhlIHNhbWUgUENJZSBidXMgYWRkcmVz
c2VzLiANCiANCj4gPiAgQ3B1IHdpbGwgYWNjZXNzIHRoZSBpbGxpY2l0IG1lbWVyeSBhZGRyIGFu
ZCBkZXRlY3QgZXJyb3IgdGhlbiBsZWFkIHRvDQo+ID4gY3B1IHN0YWxsLiAgU28gdXBkYXRlIGR0
cyBmb3IgdGhlc2UgYm9hcmRzLg0KPiANCj4gV2hhdCBpcyBpbGxpY2l0IGFib3V0IGl0Pw0KPiAN
Cj4gV2h5IGlzbid0IHRoZSBwcm9ibGVtIHNlZW4gaW4gdGhlIDM2LWJpdCBkZXZpY2UgdHJlZXMs
IHdoaWNoIGRvIHRoZSBzYW1lDQo+IHRoaW5nPw0KPiANCj4gLVNjb3R0DQoNClRoYW5rcywNClpo
aXFpYW5nDQo=
