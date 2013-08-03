Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 690742C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 12:59:05 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
Date: Sat, 3 Aug 2013 02:58:47 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FCC@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1375484319.26902.4.camel@snotra.buserror.net>
 <1375485408.15999.67.camel@pasglop>
In-Reply-To: <1375485408.15999.67.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogU2F0dXJk
YXksIEF1Z3VzdCAwMywgMjAxMyA0OjQ3IEFNDQo+IFRvOiBXb29kIFNjb3R0LUIwNzQyMQ0KPiBD
YzogQmh1c2hhbiBCaGFyYXQtUjY1Nzc3OyBhZ3JhZkBzdXNlLmRlOyBrdm0tcHBjQHZnZXIua2Vy
bmVsLm9yZzsNCj4ga3ZtQHZnZXIua2VybmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFi
cy5vcmc7IEJodXNoYW4gQmhhcmF0LVI2NTc3Nw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDUvNiB2
Ml0ga3ZtOiBwb3dlcnBjOiBib29rZTogQWRkIGxpbnV4IHB0ZSBsb29rdXAgbGlrZQ0KPiBib29r
ZTNzDQo+IA0KPiBPbiBGcmksIDIwMTMtMDgtMDIgYXQgMTc6NTggLTA1MDAsIFNjb3R0IFdvb2Qg
d3JvdGU6DQo+ID4NCj4gPiBXaGF0IGFib3V0IDY0LWJpdCBQVEVzIG9uIDMyLWJpdCBrZXJuZWxz
Pw0KPiA+DQo+ID4gSW4gYW55IGNhc2UsIHRoaXMgY29kZSBkb2VzIG5vdCBiZWxvbmcgaW4gS1ZN
LiAgSXQgc2hvdWxkIGJlIGluIHRoZQ0KPiA+IG1haW4gUFBDIG1tIGNvZGUsIGV2ZW4gaWYgS1ZN
IGlzIHRoZSBvbmx5IHVzZXIuDQo+IA0KPiBBbHNvIGRvbid0IHdlIGRvIHNpbWlsYXIgdGhpbmdz
IGluIEJvb2tTIEtWTSA/IEF0IHRoZSB2ZXJ5IGxlYXN0IHRoYXQgc3V0ZmYNCj4gc2hvdWxkIGJl
Y29tZSBjb21tb24uIEFuZCB5ZXMsIEkgYWdyZWUsIGl0IHNob3VsZCBwcm9iYWJseSBhbHNvIG1v
dmUgdG8gcGd0YWJsZSoNCg0KT25lIG9mIHRoZSBwcm9ibGVtIEkgc2F3IHdhcyB0aGF0IGlmIEkg
cHV0IHRoaXMgY29kZSBpbiBhc20vcGd0YWJsZS0zMi5oIGFuZCBhc20vcGd0YWJsZS02NC5oIHRo
ZW4gcHRlX3BlcnNlbnQoKSBhbmQgb3RoZXIgZnJpZW5kIGZ1bmN0aW9uIChvbiB3aGljaCB0aGlz
IGNvZGUgZGVwZW5kcykgYXJlIGRlZmluZWQgaW4gcGd0YWJsZS5oLiBBbmQgcGd0YWJsZS5oIGlu
Y2x1ZGVzIGFzbS9wZ3RhYmxlLTMyLmggYW5kIGFzbS9wZ3RhYmxlLTY0LmggYmVmb3JlIGl0IGRl
ZmluZXMgcHRlX3ByZXNlbnQoKSBhbmQgZnJpZW5kcyBmdW5jdGlvbnMuDQoNCk9rIEkgbW92ZSB3
b3ZlIHRoaXMgaW4gYXNtL3BndGFibGUqLmgsIGluaXRpYWxseSBJIGZvdWdodCB3aXRoIG15c2Vs
ZiB0byB0YWtlIHRoaXMgY29kZSBpbiBwZ3RhYmxlKiBidXQgZmluYWxseSBlbmQgdXAgZG9pbmcg
aGVyZSAoZ290IGJpYXNlZCBieSBib29rM3MgOikpLg0KDQpUaGFua3MNCi1CaGFyYXQNCg0KPiAN
Cj4gQ2hlZXJzLA0KPiBCZW4uDQo+IA0KPiANCg0K
