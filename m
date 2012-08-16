Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7EE522C0086
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 13:37:16 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH V7 1/3] powerpc/pci: Make sure ISA IO base is not zero
Date: Thu, 16 Aug 2012 03:37:08 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A54CFA@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-2-git-send-email-B38951@freescale.com>
 <502BDC6B.4090800@freescale.com> <1345066379.11596.1.camel@pasglop>
 <502C1B64.8050505@freescale.com> <1345070575.11751.8.camel@pasglop>
In-Reply-To: <1345070575.11751.8.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogVGh1cnNk
YXksIEF1Z3VzdCAxNiwgMjAxMiA2OjQzIEFNDQo+IFRvOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiBD
YzogSmlhIEhvbmd0YW8tQjM4OTUxOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4g
Z2FsYWtAa2VybmVsLmNyYXNoaW5nLm9yZzsgTGkgWWFuZy1SNTg0NzI7IFdvb2QgU2NvdHQtQjA3
NDIxDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjcgMS8zXSBwb3dlcnBjL3BjaTogTWFrZSBzdXJl
IElTQSBJTyBiYXNlIGlzIG5vdA0KPiB6ZXJvDQo+IA0KPiBPbiBXZWQsIDIwMTItMDgtMTUgYXQg
MTY6NTcgLTA1MDAsIFNjb3R0IFdvb2Qgd3JvdGU6DQo+ID4gSXMgdGhlcmUgbm8gbGFzdGluZyBy
ZW1uYW50IG9mIHRoYXQgdGVtcG9yYXJ5IHdyb25nIGlzYV9pb19iYXNlPyAgV2UNCj4gPiB3b24n
dCBoYXZlIEkvTyByZXNvdXJjZXMgdGhhdCB3ZXJlIGNhbGN1bGF0ZWQgcmVsYXRpdmUgdG8gdGhh
dCwgd2hpY2gNCj4gPiBzdG9wIHdvcmtpbmcgb25jZSBpc2FfaW9fYmFzZSBjaGFuZ2VzPyAgT3Ig
ZG9lcyB0aGF0IGhhcHBlbiBsYXRlciwNCj4gPiBhZnRlciB0aGlzIGZ1bmN0aW9uIGhhcyBiZWVu
IGNhbGxlZCBvbiBhbGwgYnVzZXMgKGFuZCB3b3VsZCB0aGF0DQo+ID4gY29udGludWUgdG8gYmUg
dGhlIGNhc2UgaWYgd2UgY2hhbmdlIHRoZSBQQ0kgYnVzIHRvIGEgcGxhdGZvcm0gZGV2aWNlKT8N
Cj4gDQo+IElmIHlvdSBjb250aW51ZSBjcmVhdGluZyB5b3VyIFBDSSBidXNzZXMgYWxsIGF0IG9u
Y2UgZWFybHkgb24geW91J2xsIGJlDQo+IGZpbmUuIFRoZSBwbGF0Zm9ybSBkZXZpY2UgYnVzaW5l
c3MgaXMgZ29pbmcgdG8gYnJlYWsgdGhhdCAoYW5kIG90aGVyDQo+IHRoaW5ncyBhcyB3ZWxsIGJ0
dywgc3VjaCBhcyBwY2lfZmluYWxfZml4dXApLg0KDQpJIGhhdmUgYWxyZWFkeSBkb25lIHNvbWUg
aW52ZXN0aWdhdGlvbiBhbmQgdGhlIHNlcXVlbmNlIG9mIGZpeHVwIChpbmNsdWRpbmcNCmVhcmx5
LCBoZWFkZXIsIGZpbmFsKSB3aWxsIG5vdCBiZSBjaGFuZ2VkIGluIHBsYXRmb3JtIGRyaXZlci4N
Cg0KV2UgcmVnaXN0ZXIgYW5kIGluaXQgUENJIGNvbnRyb2xsZXJzIGFzIHBsYXRmb3JtIGRldmlj
ZXMgYXQgYXJjaF9pbml0Y2FsbA0Kc3RhZ2UgYW5kIFBDSSBzY2FubmluZyAocGNpYmlvc19pbml0
KSBpcyBhdCBzdWJzeXNfaW5pdGNhbGwgc3RhZ2UgaW4gd2hpY2gNCmVhcmx5IGFuZCBoZWFkZXIg
Zml4dXAgd2lsbCBiZSBkb25lIGluIHJpZ2h0IHNlcXVlbmNlLiBUaGUgZmluYWwgZml4dXAgd2ls
bA0KYmUgc3RhcnQgYXQgcm9vdGZzX2luaXRjYWxsIHN0YWdlIHdoaWNoIGlzIGxhdGVyIHRoYW4g
ZWFybHkgYW5kIGhlYWRlciBmaXh1cC4NCg0KLSBIb25ndGFvLg0KDQo+IA0KPiBNYXliZSBpdCdz
IHRpbWUgdG8gY29udGVtcGxhdGUgZG9pbmcgc29tZXRoaW5nIG1vcmUgbGlrZSBwcGM2NCBhbmQN
Cj4gcmVzZXJ2ZSBhIHBpZWNlIG9mIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSAoSSBrbm93IHRoZXJl
IGlzbid0IG11Y2gsIHNvDQo+IG1ha2UgaXQgNjRrIHBlciBidXMgbWF4KSBhbmQganVzdCBtYXAg
dGhlIGJ1c3NlcyBpbiB0aGVyZSB3aXRoIHRoZSBmaXJzdA0KPiA2NGsgYmVpbmcgcmVzZXJ2ZWQg
Zm9yIHRoZSBJU0Egc3R1ZmYgaWYgaXQgZXhpc3RzID8NCj4gDQo+IENoZWVycywNCj4gQmVuLg0K
PiANCj4gDQoNCg==
