Return-Path: <B40534@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3CD52C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2012 12:06:42 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 2/2] powerpc/mpic: add global timer support
Date: Tue, 14 Aug 2012 02:06:32 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259DB19B8@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1344578081-8095-1-git-send-email-Dongsheng.wang@freescale.com>
 <5025639F.4070203@freescale.com>
 <ABB05CD9C9F68C46A5CEDC7F15439259DB147E@039-SN2MPN1-022.039d.mgd.msft.net>
 <5029300F.60600@freescale.com>
In-Reply-To: <5029300F.60600@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Gala Kumar-B11780 <B11780@freescale.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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
MjENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDE0LCAyMDEyIDEyOjQ5IEFNDQo+IFRvOiBXYW5n
IERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBiZW5oQGtlcm5lbC5j
cmFzaGluZy5vcmc7IHBhdWx1c0BzYW1iYS5vcmc7DQo+IGxpbnV4cHBjLWRldkBsaXN0cy5vemxh
YnMub3JnOyBHYWxhIEt1bWFyLUIxMTc4MDsgTGkgWWFuZy1SNTg0NzINCj4gU3ViamVjdDogUmU6
IFtQQVRDSCB2MiAyLzJdIHBvd2VycGMvbXBpYzogYWRkIGdsb2JhbCB0aW1lciBzdXBwb3J0DQo+
IA0KPiBPbiAwOC8xMy8yMDEyIDEyOjUzIEFNLCBXYW5nIERvbmdzaGVuZy1CNDA1MzQgd3JvdGU6
DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBX
b29kIFNjb3R0LUIwNzQyMQ0KPiA+PiBTZW50OiBTYXR1cmRheSwgQXVndXN0IDExLCAyMDEyIDM6
NDAgQU0NCj4gPj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiA+PiBDYzogYmVuaEBrZXJu
ZWwuY3Jhc2hpbmcub3JnOyBwYXVsdXNAc2FtYmEub3JnOyBsaW51eHBwYy0NCj4gPj4gZGV2QGxp
c3RzLm96bGFicy5vcmc7IEdhbGEgS3VtYXItQjExNzgwOyBMaSBZYW5nLVI1ODQ3Mg0KPiA+PiBT
dWJqZWN0OiBSZTogW1BBVENIIHYyIDIvMl0gcG93ZXJwYy9tcGljOiBhZGQgZ2xvYmFsIHRpbWVy
IHN1cHBvcnQNCj4gPj4NCj4gPj4gT24gMDgvMTAvMjAxMiAxMjo1NCBBTSwgRG9uZ3NoZW5nLndh
bmdAZnJlZXNjYWxlLmNvbSB3cm90ZToNCj4gPj4+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCBtcGljX3RpbWVyX2lkc1tdID0gew0KPiA+Pj4gKwl7IC5jb21wYXRpYmxlID0gIm9w
ZW4tcGljLGdsb2JhbC10aW1lciIsIH0sDQo+ID4+PiArCXsgLmNvbXBhdGlibGUgPSAiZnNsLGds
b2JhbC10aW1lciIsIH0sDQo+ID4+PiArCXt9LA0KPiA+Pj4gK307DQo+ID4+PiArDQo+ID4+PiAr
c3RhdGljIGludCBfX2luaXQgbXBpY190aW1lcl9pbml0KHZvaWQpIHsNCj4gPj4+ICsJc3RydWN0
IGRldmljZV9ub2RlICpucCA9IE5VTEw7DQo+ID4+PiArDQo+ID4+PiArCWZvcl9lYWNoX25vZGVf
YnlfdHlwZShucCwgIm9wZW4tcGljIikNCj4gPj4+ICsJCWlmIChvZl9tYXRjaF9ub2RlKG1waWNf
dGltZXJfaWRzLCBucCkpDQo+ID4+PiArCQkJZ3JvdXBfaW5pdChucCk7DQo+ID4+PiArDQo+ID4+
PiArCWlmIChsaXN0X2VtcHR5KCZncm91cF9saXN0KSkNCj4gPj4+ICsJCXJldHVybiAtRU5PREVW
Ow0KPiA+Pj4gKw0KPiA+Pj4gKwlyZXR1cm4gMDsNCj4gPj4+ICt9DQo+ID4+PiArYXJjaF9pbml0
Y2FsbChtcGljX3RpbWVyX2luaXQpOw0KPiA+Pg0KPiA+PiBPaCwgYW5kIGRvbid0IHByb2JlIGJ5
IGRldmljZV90eXBlLg0KPiA+Pg0KPiA+IFtXYW5nIERvbmdzaGVuZ10gZmluZS4gZm9yX2VhY2hf
bm9kZV9ieV9uYW1lLg0KPiANCj4gTm8uICBQcm9iZSBieSBjb21wYXRpYmxlIG9ubHkuDQo+IA0K
W1dhbmcgRG9uZ3NoZW5nXSBJIGxvb2tlZCBkZXZpY2V0cmVlJ3MgQVBJLiANCg0KCWZvcl9lYWNo
X21hdGNoaW5nX25vZGUobnAsIG1waWNfdGltZXJfaWRzKSBsb29rcyBiZXR0ZXIuIFRoYW5rcy4N
CiAgICAgICAgICAgICAgICAgICAgICAgIA0KDQo+IC1TY290dA0KDQo=
