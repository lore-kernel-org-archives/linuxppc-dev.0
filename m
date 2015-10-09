Return-Path: <David.Laight@ACULAB.COM>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C84E91A0272
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 20:09:07 +1100 (AEDT)
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5FAC91401AD
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 20:09:07 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wei Yang
 <weiyang@linux.vnet.ibm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>, "aik@ozlabs.ru" <aik@ozlabs.ru>
CC: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: RE: [PATCH V5 1/6] powerpc/powernv: don't enable SRIOV when VF BAR
 has non 64bit-prefetchable BAR
Date: Fri, 9 Oct 2015 09:02:16 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBB0E91@AcuExch.aculab.com>
References: <1444358816-8163-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444358816-8163-2-git-send-email-weiyang@linux.vnet.ibm.com>
 <1444378519.2845.14.camel@kernel.crashing.org>
In-Reply-To: <1444378519.2845.14.camel@kernel.crashing.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBTZW50OiAwOSBPY3RvYmVyIDIwMTUgMDk6
MTUNCj4gT24gRnJpLCAyMDE1LTEwLTA5IGF0IDEwOjQ2ICswODAwLCBXZWkgWWFuZyB3cm90ZToN
Cj4gPiBPbiBQSEJfSU9EQTIsIHdlIGVuYWJsZSBTUklPViBkZXZpY2VzIGJ5IG1hcHBpbmcgSU9W
IEJBUiB3aXRoIE02NCBCQVJzLiBJZg0KPiA+IGEgU1JJT1YgZGV2aWNlJ3MgSU9WIEJBUiBpcyBu
b3QgNjRiaXQtcHJlZmV0Y2hhYmxlLCB0aGlzIGlzIG5vdCBhc3NpZ25lZA0KPiA+IGZyb20gNjRi
aXQgcHJlZmV0Y2hhYmxlIHdpbmRvdywgd2hpY2ggbWVhbnMgTTY0IEJBUiBjYW4ndCB3b3JrIG9u
IGl0Lg0KPiANCj4gV29uJ3QgdGhpcyBjYXVzZSBhIGxvdCBvZiBkZXZpY2VzIHRvIGJlY29tZSB1
bnN1cHBvcnRlZCBmb3IgdXMgPyBPciBkbw0KPiBhbGwgZGV2aWNlcyB3ZSBjYXJlIGFib3V0IGhh
dmUgdGhlaXIgQkFScyBtYXJrZWQgcHJlZmV0Y2hhYmxlID8NCj4gDQo+ID4gVGhlIHJlYXNvbiBp
cyBQQ0kgYnJpZGdlcyBzdXBwb3J0IG9ubHkgMiB3aW5kb3dzIGFuZCB0aGUga2VybmVsIGNvZGUN
Cj4gPiBwcm9ncmFtcyBicmlkZ2VzIGluIHRoZSB3YXkgdGhhdCBvbmUgd2luZG93IGlzIDMyYml0
LW5vbnByZWZldGNoYWJsZSBhbmQNCj4gPiB0aGUgb3RoZXIgb25lIGlzIDY0Yml0LXByZWZldGNo
YWJsZS4gU28gaWYgZGV2aWNlcycgSU9WIEJBUiBpcyA2NGJpdCBhbmQNCj4gPiBub24tcHJlZmV0
Y2hhYmxlLCBpdCB3aWxsIGJlIG1hcHBlZCBpbnRvIDMyYml0IHNwYWNlIGFuZCB0aGVyZWZvcmUg
TTY0DQo+ID4gY2Fubm90IGJlIHVzZWQgZm9yIGl0Lg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBtYWtl
cyB0aGlzIGV4cGxpY2l0Lg0KPiANCj4gU28gUENJZSBhbGxvd3MgZm9yIG5vbi1wcmVmZXRjaGFi
bGUgQkFScyB0byBiZSBwdXQgdW5kZXIgcHJlZmV0Y2hhYmxlDQo+IGJyaWRnZSB3aW5kb3dzIGFz
IGxvbmcgYXMgdGhlIG1hcHBpbmcgZG9uZSBieSB0aGUgQ1BVIGRvZXNuJ3QgcHJlZmV0Y2gsDQo+
IEkgYmVsaWV2ZS4gV2VsbCBpdCdzIGEgbmF0dXJhbCBjb25jbHVzaW9uIG9mIHRoZSB3ZWlyZCBu
b3RlICJBZGRpdGlvbmFsDQo+IEd1aWRhbmNlIG9uIHRoZSBQcmVmZXRjaGFibGUgQml0IGluIE1l
bW9yeSBTcGFjZSBCQVJzIiBwYWdlIDU5NiBvZiBQQ0llDQo+IHNwZWMgdjMuMC4uLiBpdCBhbHNv
IHNheXMgdGhhdCBkZXZpY2VzIHNob3VsZCBiZSBwcmV0dHkgbXVjaCBmcmVlIHRvDQo+IHNldCB0
aGVpciBwcmVmZXRjaGFibGUgYml0IGV2ZW4gaWYgdGhleSBoYXZlIHNpZGUgZWZmZWN0cyBzby4N
Cj4gDQo+IFNvIG1heWJlIHdlIHNob3VsZCBoYXZlIHRoYXQgb3B0aW9uLCByYXRoZXIgdGhhbiBq
dXN0IG5vdCB1c2luZyB0aGUNCj4gZGV2aWNlcywgYWxsb3cgdGhlbSB0byBiZSBhbGxvY2F0ZSB2
aWEgdGhlIHByZWZldGNoYWJsZSB3aW5kb3cuLi4NCg0KSSdtIHRyeWluZyB0byB1bmRlcnN0YW5k
IHNvbWUgb2YgdGhpcyBmb3Igb3RoZXIgcmVhc29ucy4uLg0KKE1vc3RseSBiZWNhdXNlIE5ldEJT
RCBkb2Vzbid0IGFsbG93IFBDSWUgYWRkcmVzc2VzIGFib3ZlIDRHLikNCg0KQUZBSUNUIHRoZXJl
IGFyZSB0d28gb3B0aW9ucyAnMzJiaXQnIGFuZCAnNjRiaXQgcHJlZmV0Y2hhYmxlJy4NCg0KSSBw
cmVzdW1lIHRoZSBsYXR0ZXIgYWxsb3dzIGFkZHJlc3NlcyBhYm92ZSA0RyAoYWx0aG91Z2ggSSd2
ZQ0Kbm90IGxvb2tlZCBjbG9zZWx5IGVub3VnaCB0byBzZWUgaG93IHRoYXQgZ2V0cyB3cml0dGVu
IGludG8gdGhlIEJBUikuDQoNClRoYXQgc2VlbXMgcHJvYmxlbWF0aWMgb24gYXJjaGl0ZWN0dXJl
cyBsaWtlIHg4NiB3aGVyZSB0aGUgYmlvcw0KaW5pdGlhbGlzZXMgdGhlIEJBUnMgYnV0IGRvZXNu
J3QgKHVzdWFsbHkpIGtub3cgd2hldGhlciB0aGUgT1MNCndpbGwgYmUgMzIgb3IgNjRiaXQuDQoN
CldoZXRoZXIgdGhlIGNwdSBtYXBzIHRoZSBhZGRyZXNzZXMgcHJlZmV0Y2hhYmxlIG91Z2h0IHRv
IGRlcGVuZA0Kb24gdGhlIHdheSB0aGUgZHJpdmVyIG1hcHMgdGhlIGFyZWEgLSBzaW5jZSBpdCBp
cyB0aGUgZHJpdmVyDQp0aGF0IGtub3dzIHdoZXRoZXIgcHJlZmV0Y2hpbmcgaXMgc2Vuc2libGUu
DQoNCglEYXZpZA0KDQoNCg==
