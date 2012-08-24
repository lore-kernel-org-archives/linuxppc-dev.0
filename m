Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 359EE2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2012 12:34:46 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V9] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Fri, 24 Aug 2012 02:34:36 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A6F548@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1345714301-13027-1-git-send-email-B38951@freescale.com>
 <5036C7AE.9020500@freescale.com>
In-Reply-To: <5036C7AE.9020500@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjQsIDIwMTIgODoxNiBBTQ0KPiBUbzogSmlhIEhv
bmd0YW8tQjM4OTUxDQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgZ2FsYWtA
a2VybmVsLmNyYXNoaW5nLm9yZzsgTGkgWWFuZy0NCj4gUjU4NDcyOyBXb29kIFNjb3R0LUIwNzQy
MQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFY5XSBwb3dlcnBjL2ZzbC1wY2k6IFVuaWZ5IHBjaS9w
Y2llIGluaXRpYWxpemF0aW9uDQo+IGNvZGUNCj4gDQo+IE9uIDA4LzIzLzIwMTIgMDQ6MzEgQU0s
IEppYSBIb25ndGFvIHdyb3RlOg0KPiA+ICtzdGF0aWMgdm9pZCBtcGM4NXh4X2Nkc19wY2lfYXNz
aWduX3ByaW1hcnkodm9pZCkNCj4gPiArew0KPiA+ICsjaWZkZWYgQ09ORklHX1BDSQ0KPiA+ICsJ
c3RydWN0IGRldmljZV9ub2RlICpucDsNCj4gPiArDQo+ID4gKwlpZiAoZnNsX3BjaV9wcmltYXJ5
KQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKwkvKg0KPiA+ICsJICogTVBDODV4eF9DRFMg
aGFzIElTQSBicmlkZ2UgYnV0IHVuZm9ydHVuYXRlbHkgdGhlcmUgaXMgbm8NCj4gPiArCSAqIGlz
YSBub2RlIGluIGRldmljZSB0cmVlLiBXZSBub3cgbG9va2luZyBmb3IgaTgyNTkgbm9kZSBhcw0K
PiA+ICsJICogYSB0ZW1wb3Jhcnkgd29ya2Fyb3VuZCBmb3Igc3VjaCBhIGJyb2tlbiBkZXZpY2Ug
dHJlZS4NCj4gPiArCSAqIFRoaXMgY2FuIGdvIGF3YXkgb25jZSB0aGUgZGV2aWNlIHRyZWUgaXMg
dXBkYXRlZC4NCj4gPiArCSAqLw0KPiANCj4gSXQgY2Fubm90IGdvIGF3YXkgb25jZSB0aGUgZGV2
aWNlIHRyZWUgaXMgdXBkYXRlZCwgYmVjYXVzZSB3ZSBtYWludGFpbg0KPiBzdXBwb3J0IGZvciBv
bGQgZGV2aWNlIHRyZWVzIHdpdGhpbiByZWFzb24uICBJdCdzIG5vdCBsaWtlIHRoaXMgaXMgY29y
ZQ0KPiBrZXJuZWwgY29kZTsgdGhlIGNvc3Qgb2YgaGF2aW5nIHRoaXMgY29tcGF0aWJpbGl0eSBo
ZXJlIGlzIG1pbmltYWwsIGV2ZW4NCj4gaWYgdGhlIGRldmljZSB0cmVlcyB3ZSdyZSBzdGF5aW5n
IGNvbXBhdGlibGUgd2l0aCBhcmUgdGVjaG5pY2FsbHkgYnJva2VuLg0KPiBDb21wYXJlIHRoYXQg
dG8gY3VzdG9tZXIgc3VwcG9ydCBlZmZvcnQgaWYgdGhpcyBicmVha3Mgc29tZW9uZSdzIGN1c3Rv
bQ0KPiBib2FyZCB3aXRoIGEgZm9ya2VkIGRldmljZSB0cmVlLCBvciBpZiB1cGdyYWRpbmcgdGhl
IGRldmljZSB0cmVlIGJyZWFrcw0KPiBzb21lb25lJ3Mgb2xkIFUtQm9vdC4NCj4gDQo+IC1TY290
dA0KDQoNCkhvdyBhYm91dCBjaGFuZ2luZyB0aGUgY29tbWVudHMgdG8gdGhpczoNCg0KLyoNCiAq
IE1QQzg1eHhfQ0RTIGhhcyBJU0EgYnJpZGdlIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZXJlIGlzIG5v
DQogKiBpc2Egbm9kZSBpbiBkZXZpY2UgdHJlZS4gV2Ugbm93IGxvb2tpbmcgZm9yIGk4MjU5IG5v
ZGUgYXMNCiAqIGEgd29ya2Fyb3VuZCBmb3Igc3VjaCBhIGJyb2tlbiBkZXZpY2UgdHJlZS4gVGhp
cyByb3V0aW5lDQogKiBpcyBmb3IgY29tcGx5aW5nIHRvIGFsbCBkZXZpY2UgdHJlZXMuDQogKi8N
Cg0KQW5kIGFueSBvdGhlciBjb21tZW50cz8NCg0KVGhhbmtzLg0KLUhvbmd0YW8uDQo=
