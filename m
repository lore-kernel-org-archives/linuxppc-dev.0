Return-Path: <r61911@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DED4C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jun 2013 17:58:38 +1000 (EST)
From: Zang Roy-R61911 <r61911@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: FSL 64-bit DMA window question
Date: Fri, 7 Jun 2013 07:58:01 +0000
Message-ID: <3E027F8168735B46AC006B1D0C7BB0020B213AA9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
 <1368687133.9603.51.camel@pasglop>
 <CAOZdJXU79kqEGk_nqv1NSzna7c=bgwSv+6WFgaTVjR4Rj4cZVg@mail.gmail.com>
 <1370577138.3766.342.camel@pasglop> <1370579976.3766.345.camel@pasglop>
 <3E027F8168735B46AC006B1D0C7BB0020B2135A0@039-SN2MPN1-012.039d.mgd.msft.net>
 <1370588727.3766.355.camel@pasglop>
In-Reply-To: <1370588727.3766.355.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Xie Shaohui-B21989 <B21989@freescale.com>,
 Liu Qiang-B32616 <B32616@freescale.com>, Timur Tabi <timur@tabi.org>,
 "tiejun.chen" <tiejun.chen@windriver.com>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Bhushan Bharat-R65777 <R65777@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gDQo+IEhpIEZvbGtz
ICENCj4gDQo+IElzIHRoZXJlIGFueSBzcGVjaWZpYyByZWFzb24gd2h5IHlvdSBjaG9zZSAxVCAo
NDAgYml0KSBhcyB0aGUgbG9jYXRpb24gb2YNCj4gdGhlIDY0LWJpdCBETUEgd2luZG93ID8NCj4g
DQo+IEl0IGhhcHBlbnMgdGhhdCBtb3N0IGN1cnJlbnQgcmFkZW9uIGFkYXB0ZXJzIGNhbm5vdCBE
TUEgdGhlcmUsIHRoZXkgaGF2ZQ0KPiBhIDQwLWJpdCBETUEgbGltaXQuIEkgc2VlbSB0byBiZSBn
ZXR0aW5nIHRoaW5ncyB0byB3b3JrIGZpbmUgdXNpbmcgYSAzOS0NCj4gYml0IHdpbmRvdywgYnV0
IEkgc3VwcG9zZSB0aGF0IG1pZ2h0IGNvbGxpZGUgd2l0aCBzb21ldGhpbmcgZWxzZSA/DQpUNDI0
MCBoYXMgNDBiaXQgcGh5c2ljYWwgYWRkcmVzcyBhYmlsaXR5Lg0KIg0KVGhpcyBjaGlwJ3MgNDAt
Yml0LCBwaHlzaWNhbCBhZGRyZXNzIG1hcCBjb25zaXN0cyBvZiBsb2NhbCBzcGFjZSBhbmQgZXh0
ZXJuYWwgYWRkcmVzcw0Kc3BhY2UuIEZvciB0aGUgbG9jYWwgYWRkcmVzcyBtYXAsIDMyIGxvY2Fs
IGFjY2VzcyB3aW5kb3dzIChMQVdzKSBkZWZpbmUgbWFwcGluZw0Kd2l0aGluIHRoZSBsb2NhbCA0
MC1iaXQgKDEgVEIpIGFkZHJlc3Mgc3BhY2UuIEluYm91bmQgYW5kIG91dGJvdW5kIHRyYW5zbGF0
aW9uIHdpbmRvd3MNCmNhbiBtYXAgdGhlIGNoaXAgaW50byBhIGxhcmdlciBzeXN0ZW0gYWRkcmVz
cyBzcGFjZSBzdWNoIGFzIHRoZSBSYXBpZElPIG9yIFBDSWUgNjQtYml0DQphZGRyZXNzIGVudmly
b25tZW50LiBUaGlzIGZ1bmN0aW9uYWxpdHkgaXMgaW5jbHVkZWQgaW4gdGhlIGFkZHJlc3MgdHJh
bnNsYXRpb24gYW5kDQptYXBwaW5nIHVuaXRzIChBVE1VcykuDQoNCiINClRoYXQgc2hvdWxkIGJl
IHRoZSByZWFzb24gdG8gc2V0IHRoZSBETUEgd2luZG93IHRvIDQwLWJpdC4NCg0KPiANCj4gQ2Fu
IHlvdSBndXlzIGNvbnNpZGVyIGNoYW5naW5nIHRoZSBkZWZhdWx0ID8NCkFueSBjb2xsaWRlIGZv
ciA0MGJpdD8NClJveQ0K
