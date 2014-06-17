Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0183.outbound.protection.outlook.com [207.46.163.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 070301A0322
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Jun 2014 05:04:13 +1000 (EST)
From: "mihai.caraman@freescale.com" <mihai.caraman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH v2] KVM: PPC: e500mc: Enhance tlb invalidation condition
 on vcpu schedule
Date: Tue, 17 Jun 2014 19:04:03 +0000
Message-ID: <66e18c10162144f0b9e63c6c3b0ade84@BY2PR03MB508.namprd03.prod.outlook.com>
References: <1402995739-23756-1-git-send-email-mihai.caraman@freescale.com>
 <1403019343.6603.723.camel@snotra.buserror.net>
In-Reply-To: <1403019343.6603.723.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE3LCAyMDE0IDY6MzYgUE0NCj4gVG86IENhcmFtYW4gTWlo
YWkgQ2xhdWRpdS1CMDIwMDgNCj4gQ2M6IGt2bS1wcGNAdmdlci5rZXJuZWwub3JnOyBrdm1Admdl
ci5rZXJuZWwub3JnOyBsaW51eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2Ml0gS1ZNOiBQUEM6IGU1MDBtYzogRW5oYW5jZSB0bGIgaW52YWxpZGF0
aW9uDQo+IGNvbmRpdGlvbiBvbiB2Y3B1IHNjaGVkdWxlDQo+IA0KPiBPbiBUdWUsIDIwMTQtMDYt
MTcgYXQgMTI6MDIgKzAzMDAsIE1paGFpIENhcmFtYW4gd3JvdGU6DQo+ID4gT24gdmNwdSBzY2hl
ZHVsZSwgdGhlIGNvbmRpdGlvbiBjaGVja2VkIGZvciB0bGIgcG9sbHV0aW9uIGlzIHRvbyBsb29z
ZS4NCj4gPiBUaGUgdGxiIGVudHJpZXMgb2YgYSB2Y3B1IGJlY29tZSBwb2xsdXRlZCAodnMgc3Rh
bGUpIG9ubHkgd2hlbiBhDQo+IGRpZmZlcmVudA0KPiA+IHZjcHUgd2l0aGluIHRoZSBzYW1lIGxv
Z2ljYWwgcGFydGl0aW9uIHJ1bnMgaW4tYmV0d2Vlbi4gT3B0aW1pemUgdGhlDQo+IHRsYg0KPiA+
IGludmFsaWRhdGlvbiBjb25kaXRpb24gdGFraW5nIGludG8gYWNjb3VudCB0aGUgbG9naWNhbCBw
YXJ0aXRpb24gaWQuDQo+ID4NCj4gPiBXaXRoIHRoZSBuZXcgaW52YWxpZGF0aW9uIGNvbmRpdGlv
biwgYSBndWVzdCBzaG93cyA0JSBwZXJmb3JtYW5jZQ0KPiBpbXByb3ZlbWVudA0KPiA+IG9uIFA1
MDIwRFMgd2hpbGUgcnVubmluZyBhIG1lbW9yeSBzdHJlc3MgYXBwbGljYXRpb24gd2l0aCB0aGUg
Y3B1DQo+IG92ZXJzdWJzY3JpYmVkLA0KPiA+IHRoZSBvdGhlciBndWVzdCBydW5uaW5nIGEgY3B1
IGludGVuc2l2ZSB3b3JrbG9hZC4NCj4gDQo+IFNlZQ0KPiBodHRwczovL2xpc3RzLm96bGFicy5v
cmcvcGlwZXJtYWlsL2xpbnV4cHBjLWRldi8yMDE0LUp1bmUvMTE4NTQ3Lmh0bWwNCg0KVGhhbmtz
LiBUaGUgb3JpZ2luYWwgY29kZSBuZWVkcyBqdXN0IGEgc2ltcGxlIGFkanVzdG1lbnQgdG8gYmVu
ZWZpdCBmcm9tDQp0aGlzIG9wdGltaXphdGlvbiwgcGxlYXNlIHJldmlldyB2My4NCg0KLSBNaWtl
DQo=
