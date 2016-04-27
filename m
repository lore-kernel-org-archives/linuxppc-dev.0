Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw3k4285nzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 01:27:39 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Chris Smart' <chris@distroguy.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc: Add support for userspace P9 copy paste
Date: Wed, 27 Apr 2016 15:25:59 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4AB9A0@AcuExch.aculab.com>
References: <20160426002844.GA9198@x1.distroguy.com>
In-Reply-To: <20160426002844.GA9198@x1.distroguy.com>
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

RnJvbTogQ2hyaXMgU21hcnQNCj4gU2VudDogMjYgQXByaWwgMjAxNiAwMToyOQ0KPiBUaGUgY29w
eSBwYXN0ZSBmYWNpbGl0eSBpbnRyb2R1Y2VkIGluIFBPV0VSOSBwcm92aWRlcyBhbiBvcHRpbWlz
ZWQNCj4gbWVjaGFuaXNtIGZvciBhIHVzZXJzcGFjZSBhcHBsaWNhdGlvbiB0byBjb3B5IGEgY2Fj
aGVsaW5lLiBUaGlzIGlzDQo+IHByb3ZpZGVkIGJ5IGEgcGFpciBvZiBpbnN0cnVjdGlvbnMsIGNv
cHkgYW5kIHBhc3RlLCB3aGlsZSBhIHRoaXJkLA0KPiBjcF9hYm9ydCAoY29weSBwYXN0ZSBhYm9y
dCksIHByb3ZpZGVzIGEgY2xlYW4gdXAgb2YgdGhlIHN0YXRlIGluIGNhc2Ugb2YNCj4gYSBmYWls
dXJlLg0KPiANCj4gVGhlIGNvcHkgaW5zdHJ1Y3Rpb24gd2lsbCByZWFkIGEgMTI4IGJ5dGUgY2Fj
aGVsaW5lIGFuZCBzdG9yZSBpdCBpbiBhbg0KPiBpbnRlcm5hbCBidWZmZXIuIFRoZSBzdWJzZXF1
ZW50IHBhc3RlIGluc3RydWN0aW9uIHdpbGwgc3RvcmUgdGhpcw0KPiBpbnRlcm5hbCBidWZmZXIg
dG8gbWVtb3J5IGFuZCBzZXQgYSBDUiBmaWVsZCBpZiB0aGUgcGFzdGUgc3VjY2VlZHMuDQo+IA0K
PiBTaW5jZSB0aGUgc3RhdGUgb2YgdGhlIGNvcHkgcGFzdGUgYnVmZmVyIGlzIGludGVybmFsIChh
bmQgbm90DQo+IGFyY2hpdGVjdHVyYWxseSB2aXNpYmxlKSwgaW4gdGhlIHVubGlrZWx5IGV2ZW50
IG9mIGEgY29udGV4dCBzd2l0Y2gsIHRoZQ0KPiBzdGF0ZSBjYW5ub3QgYmUgc3RvcmVkIGFuZCB0
aGUgcGFzdGUgc2hvdWxkIHRoZXJlZm9yZSBmYWlsLg0KPiANCj4gVGhlIGNwX2Fib3J0IGluc3Ry
dWN0aW9uIGV4aXN0cyB0byBmYWlsIGFuZCBjbGVhbiB1cCBhbnkgc3VjaA0KPiBpbnRlcnJ1cHRl
ZCBjb3B5IHBhc3RlIHNlcXVlbmNlIGFuZCBpcyB0byBiZSBjYWxsZWQgYnkgdGhlIGtlcm5lbCBh
cw0KPiBwYXJ0IG9mIHRoZSBjb250ZXh0IHN3aXRjaC4gRG9pbmcgc28gcHJldmVudHMgZGF0YSBm
cm9tIGEgcHJlY2VkaW5nIGNvcHkNCj4gaW4gb25lIHByb2Nlc3MgbGVha2luZyBpbnRvIHRoZSBw
YXN0ZSBvZiBhbm90aGVyLg0KPiANCj4gVGhpcyBjb2RlIGVuYWJsZXMgdXNlIG9mIHRoZSBjcF9h
Ym9ydCBpbnN0cnVjdGlvbiBpZiBhIHN1cHBvcnRlZA0KPiBwcm9jZXNzb3IgaXMgZGV0ZWN0ZWQu
DQoNCkluIHRoYXQgY2FzZSB3aGF0IGFjdHVhbGx5IGNvbXBsZXRlcyB0aGUgY29weT8NCkkgdGhp
bmsgeW91J2QgbmVlZCB0byBiZSBpbnNpZGUgYSAncmVzdGFydGFibGUgYXRvbWljIHNlcXVlbmNl
Jw0KaW4gd2hpY2ggY2FzZSB0aGUgY3BfYWJvcnQgbmVlZCBvbmx5IGJlIGRvbmUgd2hlbiB0aGUv
YSBSQVMNCmJsb2NrIGlzIGRldGVjdGVkLg0KDQpPciBoYXZlIEkgbWlzc2VkIHNvbWV0aGluZz8/
DQoNCglEYXZpZA0KDQo=
