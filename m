Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 567BD2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2012 22:50:36 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Alexander Graf <agraf@suse.de>
Subject: RE: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
Date: Thu, 13 Sep 2012 12:50:14 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF1DED0A@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
 <F4E2A678-6697-4207-8CEE-2CFB3629F554@suse.de>
 <505100BD.6020304@freescale.com>
 <B9A48F7E-664A-4E8A-883F-CEB01068CC2A@suse.de>
 <5051048D.3080309@freescale.com>
In-Reply-To: <5051048D.3080309@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>,
 "<kvm@vger.kernel.org>" <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDEzLCAyMDEyIDEyOjU0IEFNDQo+IFRvOiBBbGV4
YW5kZXIgR3JhZg0KPiBDYzogQ2FyYW1hbiBNaWhhaSBDbGF1ZGl1LUIwMjAwODsgPGt2bS1wcGNA
dmdlci5rZXJuZWwub3JnPjsgPGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZz47IDxr
dm1Admdlci5rZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBLVk06IFBQQzogYm9v
a2VodjogQWxsb3cgZHVwbGljYXRlIGNhbGxzIG9mIERPX0tWTQ0KPiBtYWNybw0KPiANCj4gT24g
MDkvMTIvMjAxMiAwNDo0NSBQTSwgQWxleGFuZGVyIEdyYWYgd3JvdGU6DQo+ID4NCj4gPg0KPiA+
IE9uIDEyLjA5LjIwMTIsIGF0IDIzOjM4LCBTY290dCBXb29kIDxzY290dHdvb2RAZnJlZXNjYWxl
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gT24gMDkvMTIvMjAxMiAwMTo1NiBQTSwgQWxleGFuZGVy
IEdyYWYgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4NCj4gPj4+IE9uIDEyLjA5LjIwMTIsIGF0IDE1OjE4
LCBNaWhhaSBDYXJhbWFuIDxtaWhhaS5jYXJhbWFuQGZyZWVzY2FsZS5jb20+DQo+IHdyb3RlOg0K
PiA+Pj4NCj4gPj4+PiBUaGUgY3VycmVudCBmb3JtIG9mIERPX0tWTSBtYWNybyByZXN0cmljdHMg
aXRzIHVzZSB0byBvbmUgY2FsbCBwZXINCj4gaW5wdXQNCj4gPj4+PiBwYXJhbWV0ZXIgc2V0LiBU
aGlzIGlzIGNhdXNlZCBieSBrdm1wcGNfcmVzdW1lX1xpbnRub1woKV9cc3JyMQ0KPiBzeW1ib2wN
Cj4gPj4+PiBkZWZpbml0aW9uLg0KPiA+Pj4+IER1cGxpY2F0ZSBjYWxscyBvZiBET19LVk0gYXJl
IHJlcXVpcmVkIGJ5IGRpc3RpbmN0IGltcGxlbWVudGF0aW9ucw0KPiBvZg0KPiA+Pj4+IGV4ZXB0
aW9uIGhhbmRsZXJzIHdoaWNoIGFyZSBkZWxlZ2F0ZWQgYXQgcnVudGltZS4NCj4gPj4+DQo+ID4+
PiBOb3Qgc3VyZSBJIHVuZGVyc3RhbmQgd2hhdCB5b3UncmUgdHJ5aW5nIHRvIGFjaGlldmUgaGVy
ZS4gUGxlYXNlDQo+IGVsYWJvcmF0ZSA7KQ0KPiA+Pg0KPiA+PiBPbiA2NC1iaXQgYm9vazNlIHdl
IGNvbXBpbGUgbXVsdGlwbGUgdmVyc2lvbnMgb2YgdGhlIFRMQiBtaXNzDQo+IGhhbmRsZXJzLA0K
PiA+PiBhbmQgY2hvb3NlIGZyb20gdGhlbSBhdCBydW50aW1lLg0KDQpUaGUgZXhjZXB0aW9uIGhh
bmRsZXIgcGF0Y2hpbmcgaXMgYWN0aXZlIGluIF9fZWFybHlfaW5pdF9tbXUoKSBmdW5jdGlvbg0K
cG93ZXJwYy9tbS90bGJfbm9oYXNoLmMgZm9yIHF1aXRlIGEgZmV3IHllYXJzLiBGb3IgdGxiIG1p
c3MgZXhjZXB0aW9ucw0KdGhlcmUgYXJlIHRocmVlIGhhbmRsZXIgdmVyc2lvbnM6IHN0YW5kYXJk
LCBIVyB0YWJsZXdhbGsgYW5kIGJvbHRlZC4NCg0KPiBJIHBvc3RlZCBhIHBhdGNoIHRvIGFkZCBh
bm90aGVyIHZhcmlhbnQsIGZvciBlNjUwMC1zdHlsZSBoYXJkd2FyZQ0KPiB0YWJsZXdhbGssIHdo
aWNoIHNoYXJlcyB0aGUgYm9sdGVkIHByb2xvZy9lcGlsb2cgKGJlc2lkZXMgcHJvbG9nL2VwaWxv
Zw0KPiBwZXJmb3JtYW5jZSwgZTY1MDAgaXMgaW5jb21wYXRpYmxlIHdpdGggdGhlIElCTSB0YWJs
ZXdhbGsgY29kZSBmb3INCj4gdmFyaW91cyByZWFzb25zKS4gIFRoYXQgY2F1c2VkIHVzIHRvIGhh
dmUgdHdvIERPX0tWTXMgZm9yIHRoZSBzYW1lDQo+IGV4Y2VwdGlvbiB0eXBlLg0KDQpTb3JyeSwg
SSBtaXNzZWQgdG8gY2Mga3ZtLXBwYyBtYWlsaXN0IHdoZW4gSSByZXBsYXllZCB0byB0aGF0IGRp
c2N1c3Npb24NCnRocmVhZC4NCg0KLU1pa2UNCg==
