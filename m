Return-Path: <Hamish.Martin@alliedtelesis.co.nz>
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz
 [IPv6:2001:df5:b000:5::4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTsqp3lHfzDqGG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 11:46:46 +1100 (AEDT)
From: Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman
 <mpe@ellerman.id.au>, "paulus@samba.org" <paulus@samba.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 0/2] Allow configurable stack size (especially 32k on
 PPC64)
Date: Fri, 24 Feb 2017 00:40:00 +0000
Message-ID: <95856692-8547-5bb4-9a7e-993c39adccfd@alliedtelesis.co.nz>
References: <20170220202440.25796-1-hamish.martin@alliedtelesis.co.nz>
 <871suqn3m7.fsf@concordia.ellerman.id.au>
 <1487750793.23576.219.camel@kernel.crashing.org>
In-Reply-To: <1487750793.23576.219.camel@kernel.crashing.org>
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

T24gMDIvMjIvMjAxNyAwOTowNiBQTSwgQmVuamFtaW4gSGVycmVuc2NobWlkdCB3cm90ZToNCj4g
T24gV2VkLCAyMDE3LTAyLTIyIGF0IDE3OjI1ICsxMTAwLCBNaWNoYWVsIEVsbGVybWFuIHdyb3Rl
Og0KPj4NCj4+IFRoYW5rcyBmb3IgdGhlIGRldGFpbGVkIGV4cGxhbmF0aW9uLg0KPj4NCj4+IFRo
ZSBwYXRjaGVzIGxvb2sgZmluZSwgc28gSSBkb24ndCBzZWUgYW55IHJlYXNvbiB3aHkgd2Ugd291
bGRuJ3QgbWVyZ2UNCj4+IHRoaXMuIEkgbWlnaHQgbWFrZSB0aGUgY29uZmlnIG9wdGlvbiBkZXBl
bmQgb24gRVhQRVJULCBidXQgdGhhdCdzIGp1c3QNCj4+IGNvc21ldGljLg0KPj4NCj4+DQo+PiBZ
b3UncmUgcmlnaHQgYWJvdXQgdGhlIGRpZmZlcmVuY2UgaW4gc3RhY2sgb3ZlcmhlYWQgYmV0d2Vl
biAzMiAmIDY0LWJpdC4NCj4+IEJ1dCBJIGd1ZXNzIG9uIHRoZSBvdGhlciBoYW5kIHdlJ3ZlIGJl
ZW4gdXNpbmcgMTZLIHN0YWNrcyBvbiA2NC1iaXQgZm9yDQo+PiBvdmVyIDE1IHllYXJzLCBhbmQg
YWx0aG91Z2ggd2UgaGF2ZSBoYWQgc29tZSByZXBvcnRzIG9mIHN0YWNrIG92ZXJmbG93DQo+PiB0
aGV5J3JlIG5vdCBhIGNvbW1vbiBwcm9ibGVtLg0KPg0KPiBSaWdodCBhbmQgaW4gZmFjdCBJIHdv
bmRlciBpZiB3ZSBjb3VsZCBnZW5lcmFsbHkgaGVscCB0aGlzIGZvciBjYXNlcw0KPiBsaWtlIHRo
aXMgb25lIChsb3RzIG9mIHN0YWNrZWQgZGV2aWNlcykgYnkgaGF2aW5nIHRoZSBnZW5lcmljIGRy
aXZlcg0KPiBjb3JlIGJyZWFrIHRob3NlIGNoYWlucyBieSBkZWZlcnJpbmcgbmV3IGRldmljZSBy
ZWdpc3RyYXRpb24gdG8gYSB3b3JrDQo+IHF1ZXVlIG9yIGt0aHJlYWQuDQo+DQo+IFRoYXQgd291
bGQgaGVscCBpbiBhIGxvdCBvZiBjYXNlcy4gV2UgZG8gZ2V0IHNvbWUgc3R1cGlkIGRlZXAgY2hh
aW5zDQo+IGluIGNhc2VzIG9mIG1hbnkgYnVzIGVuY2Fwc3VsYXRpb24uDQo+DQo+IENoZWVycywN
Cj4gQmVuLg0KPg0KPg0KQWdyZWVkLiBJbiBmYWN0IHlvdSBzdWdnZXN0ZWQgaXQgYmFjayBpbiAy
MDA4IHNvbWV3aGVyZSBpbiB0aGUgdGhyZWFkIEkgDQpsaW5rZWQgdG8gaW4gbXkgY292ZXIgbGV0
dGVyIGZvciB0aGUgc2VyaWVzLiBUaGF0J3Mgb2J2aW91c2x5IGdvaW5nIHRvIA0KdGFrZSBhIGxv
bmcgdGltZSB0byBoYXBwZW4sIHNvIGZvciBub3cgSSBob3BlIHRoaXMgc2VyaWVzIHdpbGwgYWxs
b3cgDQpzb21lIHJlc3BpdGUgZm9yIHVzZXJzIGFmZmVjdGVkLg0KDQpUaGFua3MgZm9yIHlvdXIg
aW5wdXQu
