Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 817952C007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2012 13:27:23 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V8] powerpc/fsl-pci: Unify pci/pcie initialization code
Date: Tue, 21 Aug 2012 03:27:12 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A56A80@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1345457161-4731-1-git-send-email-B38951@freescale.com>
 <5032B455.3080607@freescale.com> <5032DCC8.1040005@freescale.com>
In-Reply-To: <5032DCC8.1040005@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bradley Hughes <bhughes@silicontkx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgQXVndXN0IDIxLCAyMDEyIDg6NTcgQU0NCj4gVG86IEppYSBI
b25ndGFvLUIzODk1MQ0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IEJyYWRs
ZXkgSHVnaGVzDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjhdIHBvd2VycGMvZnNsLXBjaTogVW5p
ZnkgcGNpL3BjaWUgaW5pdGlhbGl6YXRpb24NCj4gY29kZQ0KPiANCj4gT24gMDgvMjAvMjAxMiAw
NTowNCBQTSwgU2NvdHQgV29vZCB3cm90ZToNCj4gPiBPbiAwOC8yMC8yMDEyIDA1OjA2IEFNLCBK
aWEgSG9uZ3RhbyB3cm90ZToNCj4gPj4gQEAgLTg0MiwzOCArODM5LDYwIEBAIHZvaWQgX19kZXZp
bml0IGZzbF9wY2lfaW5pdCh2b2lkKQ0KPiA+PiAgCQkJbm9kZSA9IGZzbF9wY2lfcHJpbWFyeTsN
Cj4gPj4NCj4gPj4gIAkJCWlmIChvZl9tYXRjaF9ub2RlKHBjaV9pZHMsIG5vZGUpKQ0KPiA+PiAt
CQkJCWJyZWFrOw0KPiA+PiArCQkJCXJldHVybjsNCj4gPj4gIAkJfQ0KPiA+PiAtCX0NCj4gPj4N
Cj4gPj4gLQlub2RlID0gTlVMTDsNCj4gPj4gLQlmb3JfZWFjaF9ub2RlX2J5X3R5cGUobm9kZSwg
InBjaSIpIHsNCj4gPj4gLQkJaWYgKG9mX21hdGNoX25vZGUocGNpX2lkcywgbm9kZSkpIHsNCj4g
Pj4gKwkJbm9kZSA9IG9mX2ZpbmRfbm9kZV9ieV90eXBlKE5VTEwsICJwY2kiKTsNCj4gPj4gKwkJ
aWYgKG9mX21hdGNoX25vZGUocGNpX2lkcywgbm9kZSkpDQo+ID4+DQo+ID4NCj4gPiBXaGF0IGlm
IHRoZSBub2RlIHJldHVybmVkIGRvZXNuJ3QgbWF0Y2g/ICBJZiB5b3UncmUgY2hlY2tpbmcgZm9y
IHRoaXMsDQo+ID4gaGFuZGxlIHRoZSBlbHNlLWNhc2UgKGV2ZW4gaWYganVzdCB3aXRoIGFuIGVy
cm9yIG1lc3NhZ2UpLg0KPiANCj4gT3IganVzdCB1c2Ugb2ZfZmluZF9tYXRjaGluZ19ub2RlKCku
DQo+IA0KPiBBbHNvLCB3ZSBwcm9iYWJseSBuZWVkIHRvIGNoZWNrIG9mX2RldmljZV9pc19hdmFp
bGFibGUoKSBoZXJlIChsaWtlDQo+IGZzbF9hZGRfYnJpZGdlIGRvZXMpLCBhbmQgbW92ZSBvbiB0
byB0aGUgbmV4dCBQQ0kgYnVzIGlmIGl0J3MgZGlzYWJsZWQuDQo+IA0KPiAtU2NvdHQNCg0KDQpJ
IGFncmVlIHdpdGggeW91LCBvZl9kZXZpY2VfaXNfYXZhaWxhYmxlIHNob3VsZCBiZSB0ZXN0IHRv
by4NCg0KLSBIb25ndGFvLg0KDQo=
