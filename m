Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E2442C0170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 12:53:24 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/2] powerpc/85xx: add hardware automatically enter
 altivec idle state
Date: Mon, 19 Aug 2013 02:53:16 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F154392590101E5A5@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1376637789-27330-1-git-send-email-dongsheng.wang@freescale.com>
 <83499AB5-DCE7-407D-AEC1-B2493D1D38BE@kernel.crashing.org>
 <1376671853.31636.252.camel@snotra.buserror.net>
In-Reply-To: <1376671853.31636.252.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IFNhdHVyZGF5LCBBdWd1c3QgMTcs
IDIwMTMgMTI6NTEgQU0NCj4gVG86IEt1bWFyIEdhbGENCj4gQ2M6IFdhbmcgRG9uZ3NoZW5nLUI0
MDUzNDsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCAxLzJdIHBvd2VycGMvODV4eDogYWRkIGhhcmR3YXJlIGF1dG9tYXRpY2FsbHkgZW50ZXINCj4g
YWx0aXZlYyBpZGxlIHN0YXRlDQo+IA0KPiBPbiBGcmksIDIwMTMtMDgtMTYgYXQgMDY6MDIgLTA1
MDAsIEt1bWFyIEdhbGEgd3JvdGU6DQo+ID4gT24gQXVnIDE2LCAyMDEzLCBhdCAyOjIzIEFNLCBE
b25nc2hlbmcgV2FuZyB3cm90ZToNCj4gPg0KPiA+ID4gRnJvbTogV2FuZyBEb25nc2hlbmcgPGRv
bmdzaGVuZy53YW5nQGZyZWVzY2FsZS5jb20+DQo+ID4gPg0KPiA+ID4gRWFjaCBjb3JlJ3MgQWx0
aVZlYyB1bml0IG1heSBiZSBwbGFjZWQgaW50byBhIHBvd2VyIHNhdmluZ3MgbW9kZQ0KPiA+ID4g
YnkgdHVybmluZyBvZmYgcG93ZXIgdG8gdGhlIHVuaXQuIENvcmUgaGFyZHdhcmUgd2lsbCBhdXRv
bWF0aWNhbGx5DQo+ID4gPiBwb3dlciBkb3duIHRoZSBBbHRpVmVjIHVuaXQgYWZ0ZXIgbm8gQWx0
aVZlYyBpbnN0cnVjdGlvbnMgaGF2ZQ0KPiA+ID4gZXhlY3V0ZWQgaW4gTiBjeWNsZXMuIFRoZSBB
bHRpVmVjIHBvd2VyLWNvbnRyb2wgaXMgdHJpZ2dlcmVkIGJ5DQo+IGhhcmR3YXJlLg0KPiA+ID4N
Cj4gPiA+IFNpZ25lZC1vZmYtYnk6IFdhbmcgRG9uZ3NoZW5nIDxkb25nc2hlbmcud2FuZ0BmcmVl
c2NhbGUuY29tPg0KPiA+DQo+ID4gV2h5IHRyZWF0IHRoaXMgYXMgYSBpZGxlIEhXIGdvdmVybm9y
IHZzIGp1c3Qgc29tZSBvbmUgdGltZSBzZXR1cCBhdA0KPiBib290IG9mIHRoZSB0aW1lIGRlbGF5
Pw0KPiANCj4gSXQgaXMgYmVpbmcgZG9uZSBhcyBvbmUtdGltZSBzZXR1cCwgZGVzcGl0ZSB0aGUg
ZnVuY3Rpb24gbmFtZS4NCj4gDQo+IE1heWJlIGl0IHNob3VsZCBiZSBtb3ZlZCBpbnRvIF9fc2V0
dXAvcmVzdG9yZV9jcHVfZTY1MDAgKEJUVywgd2UgcmVhbGx5DQo+IHNob3VsZCByZWZhY3RvciB0
aG9zZSB0byByZWR1Y2UgZHVwbGljYXRpb24pIHdpdGggdGhlIHRpbWViYXNlIGJpdA0KPiBudW1i
ZXIgaGFyZGNvZGVkIHJhdGhlciB0aGFuIGEgdGltZSBpbiB1cy4NCj4gDQpUaGUgZnJlcXVlbmN5
IG9mIHRoZSBkaWZmZXJlbnQgcGxhdGZvcm1zIHRpbWViYXNlIGlzIG5vdCB0aGUgc2FtZS4NCklm
IHdlIHVzZSBpdCwgd2UgbmVlZCB0byBzZXQgZGlmZmVyZW50IHRpbWViYXNlIGJpdCBvbiBlYWNo
IHBsYXRmb3JtLg0KVGhhdCBpcyB3aHkgSSBkaWQgbm90IHB1dCB0aGUgY29kZSBpbiBfX3NldHVw
L3Jlc3RvcmVfY3B1X2U2NTAwLCBJIG5lZWQNCnVzZSB0Yl90aWNrc19wZXJfdXNlYyB0byBnZXQg
dGltZWJhc2UgYml0LiBTbyB3ZSBvbmx5IG5lZWQgdG8gc2V0IGEgdGltZQ0KZm9yIGVhY2ggcGxh
dGZvcm0sIGFuZCBub3Qgc2V0IGRpZmZlcmVudCB0aW1lYmFzZSBiaXQuDQoNCj4gQXMgZm9yIHRo
ZSBQVlIgY2hlY2ssIHRoZSB1cHN0cmVhbSBrZXJuZWwgZG9lc24ndCBuZWVkIHRvIGNhcmUgYWJv
dXQNCj4gcmV2MSwgc28ga25vd2luZyBpdCdzIGFuIGU2NTAwIGlzIGdvb2QgZW5vdWdoLg0KPiAN
CkJ1dCBBbHRpVmVjIGlkbGUgJiBQVzIwIGNhbm5vdCB3b3JrIG9uIHJldjEgcGxhdGZvcm0uDQpX
ZSBkaWRuJ3QgaGF2ZSB0byBkZWFsIHdpdGggaXQ/DQoNCi1kb25nc2hlbmcNCg==
