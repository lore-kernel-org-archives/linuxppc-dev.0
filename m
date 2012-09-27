Return-Path: <r58472@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 881992C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 02:27:47 +1000 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][V4] powerpc/fsl-pci: Add pci inbound/outbound PM support
Date: Thu, 27 Sep 2012 16:27:32 +0000
Message-ID: <867C679D-6CA3-4F02-9864-E7E8A62BD6BF@freescale.com>
References: <1347934234-18223-1-git-send-email-B38951@freescale.com>
 <86ADF4ED-B84C-4560-8781-D9FA4486D854@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA35A@039-SN1MPN1-002.039d.mgd.msft.net>
 <36119932-E4BF-4DF6-8D33-C9A832883272@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AAA4E8@039-SN1MPN1-002.039d.mgd.msft.net>
 <8086D08B-62B7-4838-8DB6-0F6158DE581A@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB4A6F@039-SN1MPN1-004.039d.mgd.msft.net>
 <94F013E7935FF44C83EBE7784D62AD3F09432A5F@039-SN2MPN1-021.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01AB6AE7@039-SN1MPN1-004.039d.mgd.msft.net>
 <95B12FA1-EC53-4632-8DFB-64109668BA9C@kernel.crashing.org>
 <412C8208B4A0464FA894C5F0C278CD5D01AB8317@039-SN1MPN1-004.039d.mgd.msft.net>
 <412C8208B4A0464FA894C5F0C278CD5D01AC2B34@039-SN1MPN1-004.039d.mgd.msft.net>
 <30C76F52-4022-459D-8B84-876B1A572ABE@kernel.crashing.org>
 <CADRPPNQga4J26oDacT-fGMZiecE2KLsLh2DBEErtQ9_gJSwgpA@mail.gmail.com>,
 <587B44DE-F710-4AF0-AB0B-A48FEEE29509@kernel.crashing.org>
In-Reply-To: <587B44DE-F710-4AF0-AB0B-A48FEEE29509@kernel.crashing.org>
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Jia Hongtao-B38951 <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQrU2iBTZXAgMjgsIDIwMTKjrDA6MDejrCJLdW1hciBHYWxhIiA8Z2FsYWtAa2VybmVsLmNyYXNo
aW5nLm9yZz4g0LS1wKO6DQoNCj4+Pj4gSGkgS3VtYXIsDQo+Pj4+IEkgaGF2ZSBhbHJlYWR5IHNl
bnQgdGhlIGxvZy4NCj4+Pj4gRG8geW91IGhhdmUgYW55IGNvbW1lbnQgb24gaXQ/DQo+Pj4+IA0K
Pj4+PiBUaGFua3MuDQo+Pj4+IC0gSG9uZ3Rhby4NCj4+Pj4gDQo+Pj4gDQo+Pj4gSG9uZ3RhbywN
Cj4+PiANCj4+PiBZb3UgbWVudGlvbmVkOg0KPj4+IA0KPj4+PiBJIHRlc3RlZCB0aGUgcmUtcGFy
c2luZyB3YXkgYnkgdXNpbmcgc2V0dXBfcGNpX2F0bXUoKSB3aGVuIHJlc3VtZS4NCj4+Pj4gQW5k
IEkgZm91bmQgb3V0IHRoYXQgcmUtcGFyc2luZyB3aWxsICpjaGFuZ2UqIG91dGJvdW5kIElPDQo+
Pj4+IHRyYW5zbGF0aW9uIGFkZHJlc3MgcmVnaXRzdGVyLg0KPj4+IA0KPj4+IFdoYXQgZG8gdGhl
IHZhbHVlcyBsb29rIGxpa2UgaW4gYm90aCBBVE1VIHJlZ2lzdGVycyBhbmQgaW9fcmVzb3VyY2Ug
aWYgeW91IHJlcGFyc2U/DQo+PiANCj4+IEkgdGhpbmsgSG9uZ3RhbyBtZW50aW9uZWQgaW4gcHJl
dmlvdXMgZW1haWwgYXMgZm9sbG93cywgdGhlIEFUTVUNCj4+IHJlZ2lzdGVycyBhcmUgaW5saW5l
IHdpdGggdGhlIGlvX3Jlc291cmNlIGFkZHJlc3MuDQo+IA0KPiBJIHdhcyB1bmRlciB0aGF0IHRo
ZSBpbXByZXNzaW9uIHRoYXQgd2FzIHRoZSBub3JtYWwgYm9vdCBjYXNlLCBub3QgdGhlIHZhbHVl
cyBmcm9tIGFmdGVyIHdha2V1cC4NCg0KSXQgaXMgZm9yIHRoZSBub3JtYWwgYm9vdC4gIEJ1dCBy
ZS1wYXJzZSB3aWxsIHVzZSB0aGUgaW8gcmVzb3VyY2UgYWZ0ZXIgcGljIHNjYW4gdG8gaW5pdGlh
bGl6ZSBhdG11LiAgSW5zdGVhZCwgdGhlIG9yaWdpbmFsIGF0bXUgaXMgaW5pdGlhbGl6ZWQgdXNl
IHRoZSBpbyByZXNvdXJjZSBiZWZvcmUgdGhlIHNjYW4uDQoNCkxlbw0KPiANCj4gLSBrDQo+IA0K
Pj4+PiBTaW5jZSBwb3RhciBpcyBzZXQgYnkgb3V0X2JlMzIoJnBjaS0+cG93W2pdLnBvdGFyLCAo
aG9zZS0NCj4+Pj4gaW9fcmVzb3VyY2Uuc3RhcnQgPj4gMTIpOw0KPj4+PiBJIHByb3ZpZGUgdGhl
IHJlc3VsdCBvZiBob3NlLT5pb19yZXNvdXJjZS5zdGFydCA+PiAxMiBhcyBmb2xsb3dzOg0KPj4+
PiANCj4+Pj4gcGNpZUBmZmUwOTAwMDoNCj4+Pj4gYmVmb3JlIHBjaSBzY2FuOiBpb19yZXNvdXJj
ZS5zdGFydCA+PiAxMjogMA0KPj4+PiBhZnRlciBwY2kgc2NhbiA6IGlvX3Jlc291cmNlLnN0YXJ0
ID4+IDEyOiBmZjdlZA0KPj4+PiANCj4+Pj4gcGNpZUBmZmUwYTAwMDoNCj4+Pj4gYmVmb3JlIHBj
aSBzY2FuOiBpb19yZXNvdXJjZS5zdGFydCA+PiAxMjogMA0KPj4+PiBhZnRlciBwY2kgc2NhbiA6
IGlvX3Jlc291cmNlLnN0YXJ0ID4+IDEyOiBmZjdkYg0KPj4+PiANCj4+Pj4gcGNpZUBmZmUwYjAw
MDoNCj4+Pj4gYmVmb3JlIHBjaSBzY2FuOiBpb19yZXNvdXJjZS5zdGFydCA+PiAxMjogMA0KPj4+
PiBhZnRlciBwY2kgc2NhbiA6IGlvX3Jlc291cmNlLnN0YXJ0ID4+IDEyOiBmZjdjOQ0KPj4+PiAN
Cj4+Pj4gTm90ZSB0aGF0IEkgdGVzdGVkIG9uIFAxMDIyRFMuDQo+IA0KPiANCg==
