Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D35C62C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 08:33:40 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf
 <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 12/17] PowerPC: booke64: Add DO_KVM
 kernel hooks
Date: Fri, 6 Jul 2012 22:33:31 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15CDE6@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-13-git-send-email-mihai.caraman@freescale.com>
 <1B2CBB56-7180-4A73-8E51-6538A725F710@suse.de>
 <1341440735.16808.42.camel@pasglop>
In-Reply-To: <1341440735.16808.42.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IFttYWlsdG86YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnXQ0KPiBTZW50OiBUaHVyc2RheSwg
SnVseSAwNSwgMjAxMiAxOjI2IEFNDQo+IFRvOiBBbGV4YW5kZXIgR3JhZg0KPiBDYzogQ2FyYW1h
biBNaWhhaSBDbGF1ZGl1LUIwMjAwODsgPGt2bS1wcGNAdmdlci5rZXJuZWwub3JnPjsgS1ZNIGxp
c3Q7DQo+IGxpbnV4cHBjLWRldjsgcWVtdS1wcGNAbm9uZ251Lm9yZyBMaXN0DQo+IFN1YmplY3Q6
IFJlOiBbUWVtdS1wcGNdIFtSRkMgUEFUQ0ggMTIvMTddIFBvd2VyUEM6IGJvb2tlNjQ6IEFkZCBE
T19LVk0NCj4ga2VybmVsIGhvb2tzDQo+IA0KPiBPbiBXZWQsIDIwMTItMDctMDQgYXQgMTY6Mjkg
KzAyMDAsIEFsZXhhbmRlciBHcmFmIHdyb3RlOg0KPiANCj4gPiA+ICsjaWZkZWYgQ09ORklHX0tW
TV9CT09LRV9IVg0KPiA+ID4gKyNkZWZpbmUgS1ZNX0JPT0tFX0hWX01GU1BSKHJlZywgc3ByKQkJ
CQlcDQo+ID4gPiArCUJFR0lOX0ZUUl9TRUNUSU9OCQkJCQlcDQo+ID4gPiArCQltZnNwcglyZWcs
IHNwcjsJCQkgIAlcDQo+ID4gPiArCUVORF9GVFJfU0VDVElPTl9JRlNFVChDUFVfRlRSX0VNQl9I
VikNCj4gPiA+ICsjZWxzZQ0KPiA+ID4gKyNkZWZpbmUgS1ZNX0JPT0tFX0hWX01GU1BSKHJlZywg
c3ByKQ0KPiA+ID4gKyNlbmRpZg0KPiA+DQo+ID4gQmxla3MgLSB0aGlzIGlzIHVnbHkuIERvIHdl
IHJlYWxseSBuZWVkIHRvIG9wZW4tY29kZSB0aGUgI2lmZGVmIGhlcmU/DQo+ID4gQ2FuJ3QgdGhl
IGZlYXR1cmUgc2VjdGlvbiBjb2RlIGRldGVybWluZSB0aGF0IHRoZSBmZWF0dXJlIGlzIGRpc2Fi
bGVkDQo+ID4gYW5kIGp1c3QgYWx3YXlzIG5vdCBpbmNsdWRlIHRoZSBjb2RlPw0KPiANCj4gWW91
IGNhbid0IGJ1dCBpbiBhbnkgY2FzZSBJIGRvbid0IHNlZSB0aGUgcG9pbnQgb2YgdGhlIGNvbmRp
dGlvbmFsIGhlcmUsDQo+IHdlJ2xsIGV2ZW50dWFsbHkgaGF2ZSB0byBsb2FkIHNycjEgbm8gPyBX
ZSBjYW4gbW92ZSB0aGUgbG9hZCB1cCB0byBoZXJlDQo+IGluIGFsbCBjYXNlcyBvciBjYW4ndCB3
ZSA/IA0KDQpJIGxpa2UgdGhlIGlkZWEsIGJ1dCB0aGVyZSBpcyBhIHByb2JsZW0gd2l0aCBhZGRp
dGlvbiBtYWNyb3Mgd2hpY2ggbWF5IGNsb2JiZXINCnIxMSBhbmQgUFJPTE9HX0FERElUSU9OX01B
U0tBQkxFX0dFTiBpcyBzdWNoIGEgY2FzZS4NCg0KPiBJZiByZWFsbHkgbm90LCB3ZSBjb3VsZCBo
YXZlIGl0IGluc2lkZSBET19LVk0gYW5kIGJlIGRvbmUgd2l0aCBpdCBubyA/DQoNCjMyLWJpdCBl
eGNlcHRpb24gcHJvbG9nIGxvYWRzIHNycjEgdW5jb25kaXRpb25hbGx5LCBhcyBBbGV4IGFuZCBT
Y290dCBtZW50aW9uZWQNCmVhcmxpZXIsIHNvIHdlIHdpbGwgYmUgc3Vib3B0aW1hbCBmb3IgdGhp
cyBjYXNlLg0KDQotTWlrZQ0K
