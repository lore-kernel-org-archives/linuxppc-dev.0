Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0155.outbound.protection.outlook.com [207.46.163.155])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AD9E12C0092
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 14:30:11 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/3] powerpc/85xx: Provide two functions to save/restore
 the core registers
Date: Wed, 15 Jan 2014 03:30:02 +0000
Message-ID: <a11e0d7b3b954aa68483513340043452@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389686397-46555-1-git-send-email-dongsheng.wang@freescale.com>
 <1389686397-46555-2-git-send-email-dongsheng.wang@freescale.com>
 <1389743456.24905.143.camel@snotra.buserror.net>
In-Reply-To: <1389743456.24905.143.camel@snotra.buserror.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBKYW51YXJ5IDE1LCAyMDE0IDc6NTEgQU0NCj4gVG86IFdh
bmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBaaGFv
IENoZW5odWktQjM1MzM2OyBhbnRvbkBlbm9tc2cub3JnOyBsaW51eHBwYy0NCj4gZGV2QGxpc3Rz
Lm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzNdIHBvd2VycGMvODV4eDogUHJv
dmlkZSB0d28gZnVuY3Rpb25zIHRvIHNhdmUvcmVzdG9yZSB0aGUNCj4gY29yZSByZWdpc3RlcnMN
Cj4gDQo+IE9uIFR1ZSwgMjAxNC0wMS0xNCBhdCAxNTo1OSArMDgwMCwgRG9uZ3NoZW5nIFdhbmcg
d3JvdGU6DQo+ID4gRnJvbTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53YW5nQGZyZWVzY2Fs
ZS5jb20+DQo+ID4NCj4gPiBBZGQgZnNsX2NwdV9zdGF0ZV9zYXZlL2ZzbF9jcHVfc3RhdGVfcmVz
dG9yZSBmdW5jdGlvbnMsIHVzZWQgZm9yIGRlZXANCj4gPiBzbGVlcCBhbmQgaGliZXJuYXRpb24g
dG8gc2F2ZS9yZXN0b3JlIGNvcmUgcmVnaXN0ZXJzLiBXZSBhYnN0cmFjdCBvdXQNCj4gPiBzYXZl
L3Jlc3RvcmUgY29kZSBmb3IgdXNlIGluIHZhcmlvdXMgbW9kdWxlcywgdG8gbWFrZSB0aGVtIGRv
bid0IG5lZWQNCj4gPiB0byBtYWludGFpbi4NCj4gPg0KPiA+IEN1cnJlbnRseSBzdXBwb3J0ZWQg
cHJvY2Vzc29ycyB0eXBlIGFyZSBFNjUwMCwgRTU1MDAsIEU1MDBNQywgRTUwMHYyDQo+ID4gYW5k
IEU1MDB2MS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgRG9uZ3NoZW5nIDxkb25nc2hl
bmcud2FuZ0BmcmVlc2NhbGUuY29tPg0KPiANCj4gV2hhdCBpcyB0aGVyZSB0aGF0IGlzIHNwZWNm
aWMgdG8gYSBwYXJ0aWN1bGFyIGNvcmUgdHlwZSB0aGF0IGNhbid0IGJlIGhhbmRsZWQNCj4gZnJv
bSBDIGNvZGU/DQo+IA0KDQpJbiB0aGUgY29udGV4dCBvZiB0aGUgY2FsbGluZywgbWF5YmUgbm90
IGluIEMgZW52aXJvbm1lbnQuKERlZXAgc2xlZXAgd2l0aG91dA0KQyBlbnZpcm9ubWVudCB3aGVu
IGNhbGxpbmcgdGhvc2UgaW50ZXJmYWNlcykNCg0KPiA+ICsJLyoNCj4gPiArCSAqIE5lZWQgdG8g
c2F2ZSBmbG9hdC1wb2ludCByZWdpc3RlcnMgaWYgTVNSW0ZQXSA9IDEuDQo+ID4gKwkgKi8NCj4g
PiArCW1mbXNyCXIxMg0KPiA+ICsJYW5kaS4JcjEyLCByMTIsIE1TUl9GUA0KPiA+ICsJYmVxCTFm
DQo+ID4gKwlkb19zcl9mcHJfcmVncyhzYXZlKQ0KPiANCj4gQyBjb2RlIHNob3VsZCBoYXZlIGFs
cmVhZHkgZW5zdXJlZCB0aGF0IE1TUltGUF0gaXMgbm90IDEgKGFuZCB0aHVzIHRoZSBGUA0KPiBj
b250ZXh0IGhhcyBiZWVuIHNhdmVkKS4NCj4gDQoNClllcywgcmlnaHQuIEJ1dCBJIG1lYW4gaWYg
dGhlIEZQIHN0aWxsIHVzZSBpbiBjb3JlIHNhdmUgZmxvdywgd2UgbmVlZCB0byBzYXZlIGl0Lg0K
SW4gdGhpcyBwcm9jZXNzLCBpIGRvbid0IGNhcmUgd2hhdCBvdGhlciBjb2RlIGRvLCB3ZSBuZWVk
IHRvIGZvY3VzIG9uIG5vdCBsb3NpbmcNCnZhbHVhYmxlIGRhdGEuDQoNCj4gPiArLyoNCj4gPiAr
ICogcjMgPSB0aGUgdmlydHVhbCBhZGRyZXNzIG9mIGJ1ZmZlcg0KPiA+ICsgKiByNCA9IHN1c3Bl
bmQgdHlwZSwgMC1CQVNFX1NBVkUsIDEtQUxMX1NBVkUNCj4gDQo+ICNkZWZpbmUgdGhlc2UgbWFn
aWMgbnVtYmVycywgYW5kIGRlZmluZSB3aGF0IGlzIG1lYW50IGJ5ICJiYXNlIHNhdmUiDQo+IHZl
cnN1cyAiYWxsIHNhdmUiLg0KDQpPaywgdGhhbmtzLg0KDQotRG9uZ3NoZW5nDQoNCg==
