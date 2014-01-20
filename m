Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 30A0B2C0079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 17:03:50 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
Date: Mon, 20 Jan 2014 06:03:36 +0000
Message-ID: <6f81ef13c25744b685b99a3fbb304f1b@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
 <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
 <1389842249.24905.196.camel@snotra.buserror.net>
In-Reply-To: <1389842249.24905.196.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "chenhui.zhao@freescale.com" <chenhui.zhao@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gV2hhdCBpcyB0aGVyZSB0aGF0IGlzIHNwZWNmaWMgdG8gYSBwYXJ0aWN1bGFyIGNvcmUg
dHlwZSB0aGF0IGNhbid0IGJlDQo+IGhhbmRsZWQNCj4gPiA+IGZyb20gQyBjb2RlPw0KPiA+ID4N
Cj4gPg0KPiA+IEluIHRoZSBjb250ZXh0IG9mIHRoZSBjYWxsaW5nLCBtYXliZSBub3QgaW4gQyBl
bnZpcm9ubWVudC4oRGVlcCBzbGVlcCB3aXRob3V0DQo+ID4gQyBlbnZpcm9ubWVudCB3aGVuIGNh
bGxpbmcgdGhvc2UgaW50ZXJmYWNlcykNCj4gDQo+IENvdWxkIHlvdSBwcm92aWRlIGEgY29uY3Jl
dGUgZXhhbXBsZT8NCj4gDQoNCjopDQpEZWVwIHNsZWVwLCB0aGUgcGF0Y2hlcyB3aWxsIGNvbWVz
IG91dCBzb29uLg0KDQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4gKwkgKiBOZWVkIHRvIHNhdmUgZmxv
YXQtcG9pbnQgcmVnaXN0ZXJzIGlmIE1TUltGUF0gPSAxLg0KPiA+ID4gPiArCSAqLw0KPiA+ID4g
PiArCW1mbXNyCXIxMg0KPiA+ID4gPiArCWFuZGkuCXIxMiwgcjEyLCBNU1JfRlANCj4gPiA+ID4g
KwliZXEJMWYNCj4gPiA+ID4gKwlkb19zcl9mcHJfcmVncyhzYXZlKQ0KPiA+ID4NCj4gPiA+IEMg
Y29kZSBzaG91bGQgaGF2ZSBhbHJlYWR5IGVuc3VyZWQgdGhhdCBNU1JbRlBdIGlzIG5vdCAxIChh
bmQgdGh1cyB0aGUgRlANCj4gPiA+IGNvbnRleHQgaGFzIGJlZW4gc2F2ZWQpLg0KPiA+ID4NCj4g
Pg0KPiA+IFllcywgcmlnaHQuIEJ1dCBJIG1lYW4gaWYgdGhlIEZQIHN0aWxsIHVzZSBpbiBjb3Jl
IHNhdmUgZmxvdywgd2UgbmVlZCB0byBzYXZlDQo+IGl0Lg0KPiA+IEluIHRoaXMgcHJvY2Vzcywg
aSBkb24ndCBjYXJlIHdoYXQgb3RoZXIgY29kZSBkbywgd2UgbmVlZCB0byBmb2N1cyBvbiBub3QN
Cj4gbG9zaW5nDQo+ID4gdmFsdWFibGUgZGF0YS4NCj4gDQo+IEl0IGlzIG5vdCBhbGxvd2VkIHRv
IHVzZSBGUCBhdCB0aGF0IHBvaW50Lg0KPiANCklmIE1TUltGUF0gbm90IGFjdGl2ZSwgdGhhdCBp
cyBGUCBub3QgYWxsb3dlZCB0byB1c2UuDQpCdXQgaGVyZSBpcyBhIG5vcm1hbCBqdWRnbWVudCwg
aWYgTVNSW0ZQXSBpcyBhY3RpdmUsIHRoaXMgbWVhbnMgdGhhdCB0aGUgZmxvYXRpbmcNCnBvaW50
IG1vZHVsZSBpcyBiZWluZyB1c2VkLiBJIG9mZmVyIGlzIGEgZnVuY3Rpb24gb2YgdGhlIGludGVy
ZmFjZSwgd2UgZG9uJ3Qga25vdw0Kd2hlcmUgaXMgdGhlIGZ1bmN0aW9uIHdpbGwgYmUgY2FsbGVk
LiBKdXN0IGJlY2F1c2Ugd2UgY2FsbCB0aGlzIGZ1bmN0aW9uIGluIHRoZQ0KY29udGV4dCBvZiB1
bmNlcnRhaW50eSwgd2UgbmVlZCB0aGlzIGp1ZGdtZW50IHRvIGVuc3VyZSB0aGF0IG5vIGRhdGEg
aXMgbG9zdC4NCg0KVGhhbmtzLA0KLURvbmdzaGVuZw0K
