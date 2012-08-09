Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2EC432C008B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2012 20:32:17 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 5/6] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Thu, 9 Aug 2012 10:32:10 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A51F73@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-5-git-send-email-B38951@freescale.com>
 <946C76FC-1F2E-4F09-919F-D5769D29E1A4@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A29E98@039-SN1MPN1-002.039d.mgd.msft.net>
 <BAB2AC7D-90D8-473A-83A0-59BD6F730E62@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01A48CF7@039-SN1MPN1-002.039d.mgd.msft.net>
 <50213597.5080600@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A51933@039-SN1MPN1-002.039d.mgd.msft.net>
 <1C95474C-B59D-4635-8FA9-B76165E177CD@kernel.crashing.org>
 <5022D44E.8040102@freescale.com>
In-Reply-To: <5022D44E.8040102@freescale.com>
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
MjENCj4gU2VudDogVGh1cnNkYXksIEF1Z3VzdCAwOSwgMjAxMiA1OjA0IEFNDQo+IFRvOiBLdW1h
ciBHYWxhDQo+IENjOiBKaWEgSG9uZ3Rhby1CMzg5NTE7IFdvb2QgU2NvdHQtQjA3NDIxOyBsaW51
eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gTGkgWWFuZy1SNTg0NzINCj4gU3ViamVjdDog
UmU6IFtQQVRDSCA1LzZdIHBvd2VycGMvZnNsLXBjaTogQWRkIHBjaSBpbmJvdW5kL291dGJvdW5k
IFBNDQo+IHN1cHBvcnQNCj4gDQo+IE9uIDA4LzA4LzIwMTIgMDc6NDYgQU0sIEt1bWFyIEdhbGEg
d3JvdGU6DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBPbiBKdWwgMjQsIDIwMTIsIGF0IDU6MjAgQU0s
IEppYSBIb25ndGFvIHdyb3RlOg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4+IFBvd2VyIHN1cHBseSBm
b3IgUENJIGluYm91bmQvb3V0Ym91bmQgd2luZG93IHJlZ2lzdGVycyBpcyBvZmYNCj4gPj4+Pj4+
Pj4gd2hlbg0KPiA+Pj4+Pj4+IHN5c3RlbQ0KPiA+Pj4+Pj4+PiBnbyB0byBkZWVwLXNsZWVwIHN0
YXRlLiBXZSBzYXZlIHRoZSB2YWx1ZXMgb2YgcmVnaXN0ZXJzIGJlZm9yZQ0KPiA+Pj4+Pj4+PiBz
dXNwZW5kIGFuZCByZXN0b3JlIHRvIHJlZ2lzdGVycyBhZnRlciByZXN1bWUuDQo+ID4+Pj4+Pj4+
DQo+ID4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEppYW5nIFl1dGFuZyA8YjE0ODk4QGZyZWVzY2Fs
ZS5jb20+DQo+ID4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEppYSBIb25ndGFvIDxCMzg5NTFAZnJl
ZXNjYWxlLmNvbT4NCj4gPj4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogTGkgWWFuZyA8bGVvbGlAZnJl
ZXNjYWxlLmNvbT4NCj4gPj4+Pj4+Pj4gLS0tDQo+ID4+Pj4+Pj4+IGFyY2gvcG93ZXJwYy9pbmNs
dWRlL2FzbS9wY2ktYnJpZGdlLmggfCAgICAyICstDQo+ID4+Pj4+Pj4+IGFyY2gvcG93ZXJwYy9z
eXNkZXYvZnNsX3BjaS5jICAgICAgICAgfCAgMTIxDQo+ID4+Pj4+Pj4gKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4+Pj4+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgMTIyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb25zKC0pDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBSZW1pbmQgbWUg
d2h5IHdlIG5lZWQgdG8gc2F2ZS9yZXN0b3JlIFBDSSBBVE1Vcywgd2h5IG5vdCBqdXN0DQo+ID4+
Pj4+Pj4gcmUtcGFyc2UgdGhlIGRldmljZSB0cmVlIHRvIHJlc3RvcmU/DQo+ID4+Pj4+Pj4NCj4g
Pj4+Pj4+PiAtIGsNCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTYXZlL3Jlc3RvcmUgaXMgdGhlIG1vcmUg
ZWZmaWNpZW50IHdheS4gTGF0ZW5jeSBvZiBzbGVlcC93YWtldXANCj4gPj4+Pj4+IGlzIG9uZSBv
ZiBtb3N0IGltcG9ydGFudCBmZWF0dXJlcyBpbiBwb3dlciBtYW5hZ2VtZW50Lg0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IC1Ib25ndGFvLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGRvbid0IHRoaW5rIHRoZSB0
aW1lIGl0IHRha2VzIHRvIHJ1biB0aHJvdWdoIHNldHVwX3BjaV9hdG11KCkgaXMNCj4gPj4+Pj4g
dGhhdCBsb25nIGNvbXBhcmVkIHRvIGZzbF9wY2lfcmVzdW1lKCkuDQo+ID4+Pj4+DQo+ID4+Pj4+
IEFsc28sIGRvbid0IHlvdSBuZWVkIHRvIHNldHVwIFBDSUNDU1JCQVIgYW5kIGRvIHNldHVwX3Bj
aV9jbWQoKSBvbg0KPiA+Pj4gcmVzdW1lPw0KPiA+Pj4+Pg0KPiA+Pj4+PiAtIGsNCj4gPj4+Pg0K
PiA+Pj4+IEhpIEt1bWFyLA0KPiA+Pj4+IEkgZGlkIHNvbWUgdGVzdHMgb24gUDEwMjJEUyBhbmQg
Zm91bmQgb3V0IHRoYXQgUENJX0NNRCBhbmQNCj4gPj4+PiBQQ0lDU1JCQVIgaXMgbm90IGxvc3Qg
d2hlbiBzeXN0ZW0gaW4gZGVlcCBzbGVlcC4gV2UgZG9uJ3QgbmVlZCB0bw0KPiBzYXZlIGl0Lg0K
PiANCj4gSG93IGRvIHlvdSBrbm93IHlvdSdyZSBub3QganVzdCBnZXR0aW5nIGx1Y2t5PyAgTWF5
YmUgaXQgb25seSBzdXJ2aXZlcw0KPiBkZWVwIHNsZWVwIHVwIHRvIGEgY2VydGFpbiBkdXJhdGlv
biwgb3IgdW5kZXIgb3RoZXIgc3BlY2lmaWMNCj4gY2lyY3Vtc3RhbmNlcy4NCg0KSSB0ZXN0ZWQg
Zm9yIG1vcmUgdGhhbiAxMCBtaW5zIGluIGRlZXAgc2xlZXAgYW5kIHRoZSByZXN1bHQgaXMgdGhl
IHNhbWUuDQoNCj4gDQo+IENhbiB5b3UgZmluZCBhbnl3aGVyZSB0aGF0IGRvY3VtZW50cyB3aGF0
IHN0YXRlIHdpbGwgYmUgcmV0YWluZWQgZHVyaW5nDQo+IGRlZXAgc2xlZXAsIG9yIGFzayBhbiBh
cHByb3ByaWF0ZSBoYXJkd2FyZSBkZXNpZ25lcj8NCj4gDQo+IC1TY290dA0KDQpJIGFncmVlIHdp
dGggeW91IHRoYXQgd2Ugc2hvdWxkIGZpbmQgb3V0IHdoYXQgc3RhdGUgd2lsbCBiZSByZXRhaW5l
ZCBkdXJpbmcNCmRlZXAgc2xlZXAuIEJ1dCBQMTAyMiBSTSBkb2MgaGFzIGxpbWl0ZWQgaW5mb3Jt
YXRpb24gZm9yIHRoaXMuIElmIEkgY2FuIGdldA0KbW9yZSBpbmZvcm1hdGlvbiBmcm9tIGhhcmR3
YXJlIGRlc2lnbmVyIHRoYXQgd2lsbCBiZSBnb29kLg0K
