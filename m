Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 1FBE61A00FA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 18:44:29 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 08139-08 for <linuxppc-dev@lists.ozlabs.org>;
 Thu,  4 Sep 2014 09:44:25 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, Peter Hurley
 <peter@hurleysoftware.com>
Subject: RE: bit fields && data tearing
Date: Thu, 4 Sep 2014 08:43:13 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17487172@AcuExch.aculab.com>
References: <20140712181328.GA8738@redhat.com>
 <54079B70.4050200@hurleysoftware.com> <1409785893.30640.118.camel@pasglop>
In-Reply-To: <1409785893.30640.118.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Jakub Jelinek <jakub@redhat.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Tony Luck <tony.luck@intel.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, "Paul E.
 McKenney" <paulmck@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Miroslav Franc <mfranc@redhat.com>, Richard Henderson <rth@twiddle.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogIEJlbmphbWluIEhlcnJlbnNjaG1pZHQNCj4gT24gV2VkLCAyMDE0LTA5LTAzIGF0IDE4
OjUxIC0wNDAwLCBQZXRlciBIdXJsZXkgd3JvdGU6DQo+IA0KPiA+IEFwb2xvZ2llcyBmb3IgaGlq
YWNraW5nIHRoaXMgdGhyZWFkIGJ1dCBJIG5lZWQgdG8gZXh0ZW5kIHRoaXMgZGlzY3Vzc2lvbg0K
PiA+IHNvbWV3aGF0IHJlZ2FyZGluZyB3aGF0IGEgY29tcGlsZXIgbWlnaHQgZG8gd2l0aCBhZGph
Y2VudCBmaWVsZHMgaW4gYSBzdHJ1Y3R1cmUuDQo+ID4NCj4gPiBUaGUgdHR5IHN1YnN5c3RlbSBk
ZWZpbmVzIGEgbGFyZ2UgYWdncmVnYXRlIHN0cnVjdHVyZSwgc3RydWN0IHR0eV9zdHJ1Y3QuDQo+
ID4gSW1wb3J0YW50bHksIHNldmVyYWwgZGlmZmVyZW50IGxvY2tzIGFwcGx5IHRvIGRpZmZlcmVu
dCBmaWVsZHMgd2l0aGluIHRoYXQNCj4gPiBzdHJ1Y3R1cmU7IGllLiwgYSBzcGVjaWZpYyBzcGlu
bG9jayB3aWxsIGJlIGNsYWltZWQgYmVmb3JlIHVwZGF0aW5nIG9yIGFjY2Vzc2luZw0KPiA+IGNl
cnRhaW4gZmllbGRzIHdoaWxlIGEgZGlmZmVyZW50IHNwaW5sb2NrIHdpbGwgYmUgY2xhaW1lZCBi
ZWZvcmUgdXBkYXRpbmcgb3INCj4gPiBhY2Nlc3NpbmcgY2VydGFpbiBfYWRqYWNlbnRfIGZpZWxk
cy4NCj4gPg0KPiA+IFdoYXQgaXMgbmVjZXNzYXJ5IGFuZCBzdWZmaWNpZW50IHRvIHByZXZlbnQg
YWNjaWRlbnRhbCBmYWxzZS1zaGFyaW5nPw0KPiA+IFRoZSBwYXRjaCBiZWxvdyB3YXMgZmxhZ2dl
ZCBhcyBpbnN1ZmZpY2llbnQgb24gaWE2NCwgYW5kIHBvc3NpYmx5IEFSTS4NCj4gDQo+IFdlIGV4
cGVjdCBuYXRpdmUgYWxpZ25lZCBzY2FsYXIgdHlwZXMgdG8gYmUgYWNjZXNzZWQgYXRvbWljYWxs
eSAodGhlDQo+IHJlYWQvbW9kaWZ5L3dyaXRlIG9mIGEgbGFyZ2VyIHF1YW50aXR5IHRoYXQgZ2Nj
IGRvZXMgb24gc29tZSBiaXRmaWVsZA0KPiBjYXNlcyBoYXMgYmVlbiBmbGFnZ2VkIGFzIGEgZ2Nj
IGJ1ZywgYnV0IHNob3VsZG4ndCBoYXBwZW4gb24gbm9ybWFsDQo+IHNjYWxhciB0eXBlcykuDQoN
ClRoYXQgaXNuJ3QgdHJ1ZSBvbiBhbGwgYXJjaGl0ZWN0dXJlcyBmb3IgaXRlbXMgc21hbGxlciB0
aGFuIGEgbWFjaGluZSB3b3JkLg0KQXQgbGVhc3Qgb25lIGhhcyB0byBkbyBybXcgZm9yIGJ5dGUg
YWNjZXNzZXMuDQoNCglEYXZpZA0KDQo+IEkgYW0gbm90IDEwMCUgY2VydGFpbiBvZiAiYm9vbCIg
aGVyZSwgSSBhc3N1bWUgaXQncyB0cmVhdGVkIGFzIGEgbm9ybWFsDQo+IHNjYWxhciBhbmQgdGh1
cyBhdG9taWMgYnV0IGlmIHVuc3VyZSwgeW91IGNhbiBhbHdheXMgdXNlIGludC4NCj4gDQo+IEFu
b3RoZXIgb3B0aW9uIGlzIHRvIHVzZSB0aGUgYXRvbWljIGJpdG9wcyBhbmQgbWFrZSB0aGVzZSBi
aXRzIGluIGENCj4gYml0bWFzayBidXQgdGhhdCBpcyBwcm9iYWJseSB1bm5lY2Vzc2FyeSBpZiB5
b3UgaGF2ZSBsb2NrcyBhbHJlYWR5Lg0KPiANCj4gQ2hlZXJzLA0KPiBCZW4uDQo=
