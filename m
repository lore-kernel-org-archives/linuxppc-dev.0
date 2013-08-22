Return-Path: <seiji.aguchi@hds.com>
Received: from usindpps03.hds.com (usindpps03.hds.com [207.126.252.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2484E2C0091
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Aug 2013 09:47:24 +1000 (EST)
From: Seiji Aguchi <seiji.aguchi@hds.com>
To: "Luck, Tony" <tony.luck@intel.com>, Aruna Balakrishnaiah
 <aruna@linux.vnet.ibm.com>, "linuxppc-dev@ozlabs.org"
 <linuxppc-dev@ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "keescook@chromium.org"
 <keescook@chromium.org>
Subject: RE: [RFC PATCH v2 04/11] pstore: Add compression support to pstore
Date: Thu, 22 Aug 2013 23:47:02 +0000
Message-ID: <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F1E2@USINDEM103.corp.hds.com>
References: <20130816131403.3338.82330.stgit@aruna-ThinkPad-T420>
 <20130816131805.3338.68767.stgit@aruna-ThinkPad-T420>
 <A5ED84D3BB3A384992CBB9C77DEDA4D443E8F0D7@USINDEM103.corp.hds.com>
 <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F31CC7AC0@ORSMSX106.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "jkenisto@linux.vnet.ibm.com" <jkenisto@linux.vnet.ibm.com>,
 "cbouatmailru@gmail.com" <cbouatmailru@gmail.com>,
 "mahesh@linux.vnet.ibm.com" <mahesh@linux.vnet.ibm.com>,
 "ccross@android.com" <ccross@android.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjaywgVG9ueSBbbWFp
bHRvOnRvbnkubHVja0BpbnRlbC5jb21dDQo+IFNlbnQ6IFRodXJzZGF5LCBBdWd1c3QgMjIsIDIw
MTMgNzoxNyBQTQ0KPiBUbzogU2VpamkgQWd1Y2hpOyBBcnVuYSBCYWxha3Jpc2huYWlhaDsgbGlu
dXhwcGMtZGV2QG96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGtlZXNj
b29rQGNocm9taXVtLm9yZw0KPiBDYzogamtlbmlzdG9AbGludXgudm5ldC5pYm0uY29tOyBhbmFu
dGhAaW4uaWJtLmNvbTsgYmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnOyBjYm91YXRtYWlscnVAZ21h
aWwuY29tOw0KPiBtYWhlc2hAbGludXgudm5ldC5pYm0uY29tOyBjY3Jvc3NAYW5kcm9pZC5jb20N
Cj4gU3ViamVjdDogUkU6IFtSRkMgUEFUQ0ggdjIgMDQvMTFdIHBzdG9yZTogQWRkIGNvbXByZXNz
aW9uIHN1cHBvcnQgdG8gcHN0b3JlDQo+IA0KPiA8MT5bICAzODMuMjA5MDU3XSBSSVAgIFs8ZmZm
ZmZmZmY4MTNkMzk0Nj5dIHN5c3JxX2hhbmRsZV9jcmFzaCsweDE2LzB4MjANCj4gPDQ+WyAgMzgz
LjIwOTA1N10gIFJTUCA8ZmZmZjg4MDA2ZjU1MWU4MD4NCj4gPDQ+WyAgMzgzLjIwOTA1N10gQ1Iy
OiAwMDAwMDAwMDAwMDAwMDAwDQo+IDw0PlsgIDM4My4yMDkwNTddIC0tLVsgZW5kIHRyYWNlIDA0
YTFjZGRhZDM3YjRiMzMgXS0tLQ0KPiA8Mz5bICAzODMuMjA5MDU3XSBwc3RvcmU6IGNvbXByZXNz
aW9uIGZhaWxlZCBmb3IgUGFydCAyIHJldHVybmVkIC01DQo+IDwzPlsgIDM4My4yMDkwNTddIHBz
dG9yZTogQ2FwdHVyZSB1bmNvbXByZXNzZWQgb29wcy9wYW5pYyByZXBvcnQgb2YgUGFydCAyDQo+
IDwzPlsgIDM4My4yMDkwNTddIHBzdG9yZTogY29tcHJlc3Npb24gZmFpbGVkIGZvciBQYXJ0IDUg
cmV0dXJuZWQgLTUNCj4gDQo+IEludGVyZXN0aW5nLiAgV2l0aCBFUlNUIGJhY2tlbmQgSSBkaWRu
J3Qgc2VlIHRoZXNlIG1lc3NhZ2VzLiAgVHJhY2VzIGluDQo+IHBzdG9yZSByZWNvdmVyZWQgZmls
ZXMgZ28gYXMgZmFyIGFzIHRoZSBsaW5lIGJlZm9yZSB0aGUgIi0tLVsgZW5kIHRyYWNlIDA0YTFj
ZGRhZDM3YjRiMzMgXS0tLSINCj4gDQo+IFdoeSB0aGUgZGlmZmVyZW5jZSBkZXBlbmRpbmcgb24g
d2hpY2ggYmFjayBlbmQgaXMgaW4gdXNlPw0KDQpJIHRoaW5rIHRoZSBkaWZmZXJlbmNlIGRvZXNu
J3QgZGVwZW5kIG9uIHRoZSBiYWNrIGVuZC4NClJhdGhlciBpdCBkZXBlbmRzIG9uIHRoZSBlbnZp
cm9ubWVudC4NCg0KSSB0ZXN0ZWQgb24gYSBrdm0gZ3Vlc3Qgd2l0aCBPVk1GLg0KDQpTZWlqaQ0K
DQoNCj4gDQo+IEJ1dCBJIGFncmVlIHRoYXQgd2Ugc2hvdWxkbid0IGhhdmUgdGhlc2UgbWVzc2Fn
ZXMuICBUaGV5IHVzZSB1cCBzcGFjZQ0KPiBpbiB0aGUgcGVyc2lzdGVudCBzdG9yZSB0aGF0IGNv
dWxkIGJlIGJldHRlciB1c2VkIHNhdmluZyBzb21lIG1vcmUgbGluZXMNCj4gZnJvbSBlYXJsaWVy
IGluIHRoZSBjb25zb2xlIGxvZy4NCj4gDQo+IC1Ub255DQo=
