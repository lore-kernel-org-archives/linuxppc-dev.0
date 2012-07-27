Return-Path: <B38951@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EB8C32C008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jul 2012 12:07:31 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH 3/6] powerpc/fsl-pci: Determine primary bus by looking
 for ISA node
Date: Fri, 27 Jul 2012 02:07:23 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A285D0@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1343125210-16720-1-git-send-email-B38951@freescale.com>
 <1343125210-16720-3-git-send-email-B38951@freescale.com>
 <500EEDD9.8050507@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A275B4@039-SN1MPN1-002.039d.mgd.msft.net>
 <50102C27.8040004@freescale.com>
 <412C8208B4A0464FA894C5F0C278CD5D01A27C7D@039-SN1MPN1-002.039d.mgd.msft.net>
 <5011F01C.8000008@freescale.com>
In-Reply-To: <5011F01C.8000008@freescale.com>
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
MjENCj4gU2VudDogRnJpZGF5LCBKdWx5IDI3LCAyMDEyIDk6MzQgQU0NCj4gVG86IEppYSBIb25n
dGFvLUIzODk1MQ0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IGxpbnV4cHBjLWRldkBsaXN0cy5v
emxhYnMub3JnOw0KPiBnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBMaSBZYW5nLVI1ODQ3Mg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvNl0gcG93ZXJwYy9mc2wtcGNpOiBEZXRlcm1pbmUgcHJp
bWFyeSBidXMgYnkNCj4gbG9va2luZyBmb3IgSVNBIG5vZGUNCj4gDQo+IE9uIDA3LzI1LzIwMTIg
MDk6MjAgUE0sIEppYSBIb25ndGFvLUIzODk1MSB3cm90ZToNCj4gPiBBbGwgdGhpcyByZWN1cnNp
b24gdGhpbmcgSSB3aWxsIHRyeSBhbm90aGVyIHdheS4NCj4gPg0KPiA+IEJ1dCB0aGlzIGlzIG5v
dCB0aGUgc2FtZSBhcyB5b3UgZGlkLiBJZiB3ZSB1c2UgcGxhdGZvcm0gZHJpdmVyIHByb2JlDQo+
IGZ1bmN0aW9uDQo+ID4gd2lsbCBiZSBjYWxsZWQgbW9yZSB0aGFuIG9uY2UuIFlvdXIgZnVuY3Rp
b24gaXMgdG8gZmluZCBJU0Egbm9kZSBhbmQNCj4gY2hlY2sgaWYNCj4gPiB0aGUgcGFyZW50IGVx
dWFsIHRvIHRoaXMgUENJIGNvbnRyb2xsZXIuIE15IGZ1bmN0aW9uIGlzIHRvIHNlYXJjaCBJU0EN
Cj4gdW5kZXINCj4gPiBlYWNoIFBDSSBjb250cm9sbGVyLg0KPiANCj4gVGhlIHJlc3VsdCBpcyB0
aGUgc2FtZSAtLSAiZG9lcyB0aGlzIFBDSSBjb250cm9sbGVyIGhhdmUgYW4gSVNBIG5vZGUNCj4g
dW5kZXIgaXQ/Ig0KPiANCj4gLVNjb3R0DQoNCg0KVGhlIHJlc3VsdCBpcyB0aGUgc2FtZSBidXQg
YXMgSSBzYWlkIGluIHBsYXRmb3JtIGRyaXZlciBwcm9iZSBmdW5jdGlvbiB3aWxsDQpiZSBjYWxs
ZWQgZm9yIGVhY2ggUENJIGNvbnRyb2xsZXIuIFdlIGRvbid0IHdhbnQgSVNBIGlzIHNlYXJjaGVk
IGZvciBtb3JlDQp0aGFuIG9uY2UuIEFsc28gcGxlYXNlIHJlZmVyIHRvIFYzIG9mIHRoaXMgcGF0
Y2ggc2V0IGluIHdoaWNoIEkgcmViYXNlIHRoZW0NCm9uIGxhdGVzdCB0cmVlLiBJIG1hZGUgYSBu
b24tcmVjdXJzaXZlIHZlcnNpb24gb2YgZnVuY3Rpb24gdG8gc2VhcmNoIGZvcg0KSVNBIHVuZGVy
IFBDSSBub2Rlcy4NCg0KLUhvbmd0YW8uDQo=
