Return-Path: <B38951@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2516A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 19:03:30 +1000 (EST)
Received: from mail145-ch1 (localhost [127.0.0.1])	by
 mail145-ch1-R.bigfish.com (Postfix) with ESMTP id BAEA080620	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 09:03:24 +0000 (UTC)
Received: from CH1EHSMHS007.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail145-ch1.bigfish.com (Postfix) with ESMTP id
 460253E0065	for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2012 09:03:09
 +0000 (UTC)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Li Yang-R58472
 <r58472@freescale.com>
Subject: RE: [PATCH V5 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Wed, 8 Aug 2012 09:03:04 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A518E4@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343988851-884-1-git-send-email-B38951@freescale.com>
 <1343988851-884-4-git-send-email-B38951@freescale.com>
 <501BFC0E.6070708@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A36D0A@039-SN1MPN1-002.039d.mgd.msft.net>
 <501FDE40.1060906@freescale.com>
 <CADRPPNTqnEt3xE8Et1cbK=GwfemgA3-dF7aH2cTNppCddKJ6DA@mail.gmail.com>
 <50213342.8020600@freescale.com>
In-Reply-To: <50213342.8020600@freescale.com>
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
MjENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDA3LCAyMDEyIDExOjI1IFBNDQo+IFRvOiBMaSBZ
YW5nLVI1ODQ3Mg0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnOyBMaSBZYW5nLVI1ODQ3MjsgSmlhDQo+IEhvbmd0YW8tQjM4OTUxDQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjUgMy8zXSBwb3dlcnBjL2ZzbC1wY2k6IFVuaWZ5IHBjaS9wY2llDQo+
IGluaXRpYWxpemF0aW9uIGNvZGUNCj4gDQo+IE9uIDA4LzA2LzIwMTIgMTE6MjAgUE0sIExpIFlh
bmcgd3JvdGU6DQo+ID4gT24gTW9uLCBBdWcgNiwgMjAxMiBhdCAxMTowOSBQTSwgU2NvdHQgV29v
ZCA8c2NvdHR3b29kQGZyZWVzY2FsZS5jb20+DQo+IHdyb3RlOg0KPiA+PiBPbiAwOC8wNS8yMDEy
IDEwOjA3IFBNLCBKaWEgSG9uZ3Rhby1CMzg5NTEgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+Pj4+IEZyb206IFdvb2QgU2NvdHQtQjA3
NDIxDQo+ID4+Pj4gU2VudDogU2F0dXJkYXksIEF1Z3VzdCAwNCwgMjAxMiAxMjoyOCBBTQ0KPiA+
Pj4+IFRvOiBKaWEgSG9uZ3Rhby1CMzg5NTENCj4gPj4+PiBDYzogbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5vcmc7IExpDQo+ID4+Pj4gWWFuZy0g
UjU4NDcyOyBXb29kIFNjb3R0LUIwNzQyMQ0KPiA+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjUg
My8zXSBwb3dlcnBjL2ZzbC1wY2k6IFVuaWZ5IHBjaS9wY2llDQo+ID4+Pj4gaW5pdGlhbGl6YXRp
b24gY29kZQ0KPiA+Pj4+DQo+ID4+Pj4gQXMgSSBleHBsYWluZWQgYmVmb3JlLCB0aGlzIGhhcyB0
byBiZSBkb25lIGdsb2JhbGx5LCBub3QgZnJvbSB0aGUNCj4gPj4+PiBwcm9iZSBmdW5jdGlvbiwg
c28gd2UgY2FuIGFzc2lnbiBhIGRlZmF1bHQgcHJpbWFyeSBidXMgaWYgdGhlcmUNCj4gaXNuJ3Qg
YW55IElTQS4NCj4gPj4+PiAgVGhlcmUgYXJlIGJ1Z3MgaW4gdGhlIExpbnV4IFBQQyBQQ0kgY29k
ZSByZWxhdGluZyB0byBub3QgaGF2aW5nDQo+ID4+Pj4gYW55IHByaW1hcnkgYnVzLg0KPiA+Pj4+
DQo+ID4+Pj4gLVNjb3R0DQo+ID4+Pg0KPiA+Pj4gSW4gbXkgd2F5IG9mIHNlYXJjaGluZyBJU0Eg
eW91IGNhbiBhbHNvIGFzc2lnbiBhIGRlZmF1bHQgcHJpbWFyeSBidXMNCj4gPj4+IGluIGJvYXJk
IHNwZWNpZmljIGZpbGVzLg0KPiA+Pg0KPiA+PiBUaGF0IHdhcyBtZWFudCBmb3Igd2hlbiB0aGUg
Ym9hcmQgZmlsZSBoYWQgYW4gYWx0ZXJuYXRlIHdheSBvZg0KPiA+PiBzZWFyY2hpbmcgZm9yIHRo
ZSBwcmltYXJ5IGJ1cyAoZS5nLiBsb29rIGZvciBpODI1OSksIG5vdCBhcyBhDQo+ID4+IHJlcGxh
Y2VtZW50IGZvciB0aGUgbWVjaGFuaXNtIHRoYXQgZ3VhcmFudGVlcyB0aGVyZSdzIGEgcHJpbWFy
eSBidXMuDQo+ID4+DQo+ID4+IFlvdSBhcmUgY2F1c2luZyBhIHJlZ3Jlc3Npb24gaW4gdGhlIHFl
bXVfZTUwMC5jIHBsYXRmb3JtLg0KPiA+DQo+ID4gQ2FuIHdlIGZpeCB0aGUgcWVtdSBkZXZpY2Ug
dHJlZSB0byBhZGRyZXNzIHRoZSBwcm9ibGVtIGlmIHdlIGRvIG1ha2UNCj4gPiBpdCBhIHJ1bGUg
dG8gdXNlIHRoZSBJU0Egbm9kZSB0byBpbmRpY2F0ZSB0aGUgcHJpbWFyeSBidXM/DQo+IA0KPiBO
by4gIFRoZXJlIGlzIG5vIElTQSwgYW5kIHdlJ3JlIG5vdCBnb2luZyB0byBsaWUgYW5kIHNheSB0
aGVyZSBpcy4NCg0KQnV0IHdlIGNhbiBhc3NpZ24gYSBkZWZhdWx0IHByaW1hcnkgZm9yIHFlbXUu
DQoNCj4gDQo+IEkgcmVhbGx5IGRvbid0IHVuZGVyc3RhbmQgd2hhdCB0aGUgcHJvYmxlbSBpcyB3
aXRoIGxlYXZpbmcgdGhlIHByaW1hcnkNCj4gZGV0ZWN0aW9uIGNvZGUgYXMgZ2xvYmFsLiAgRWl0
aGVyIGZpeCB0aGUgYnVncyBzbyB3ZSBkb24ndCBuZWVkIGEgcHJpbWFyeSwNCj4gb3IgYWNjZXB0
IHNvbWUgImltcHVyaXR5IiBpbiB0aGUgd29ya2Fyb3VuZC4NCj4gDQo+IC1TY290dA0KDQpHbG9i
YWwgZGV0ZWN0aW9uIGZvciBwcmltYXJ5IGlzIG9rIGJ1dCB3ZSB0aGluayBvdXIgd2F5IGlzIGRl
ZXBlciB1bmlmaWVkLg0KDQpJcyB0aGVyZSBhbnkgcHJvYmxlbSB0byBmaXggdGhlIGJ1Z3M/DQpJ
IHJlYWxseSBkb24ndCB1bmRlcnN0YW5kIHdoeSB3ZSBoYXZlIHRvIG5lZWQgYSBwcmltYXJ5IGJ1
cy4NCg0KLUhvbmd0YW8uDQoNCg0K
