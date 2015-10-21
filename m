Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BE771A03AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 03:04:50 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: "'paulmck@linux.vnet.ibm.com'" <paulmck@linux.vnet.ibm.com>, Boqun Feng
 <boqun.feng@gmail.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras
 <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Wed, 21 Oct 2015 16:04:04 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBBD844@AcuExch.aculab.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com> <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151019011718.GB924@fixme-laptop.cn.ibm.com>
 <20151020233451.GI5105@linux.vnet.ibm.com>
In-Reply-To: <20151020233451.GI5105@linux.vnet.ibm.com>
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

RnJvbTogUGF1bCBFLiBNY0tlbm5leQ0KPiBTZW50OiAyMSBPY3RvYmVyIDIwMTUgMDA6MzUNCi4u
Lg0KPiBUaGVyZSBpcyBhbHNvIHRoZSBxdWVzdGlvbiBvZiB3aGV0aGVyIHRoZSBiYXJyaWVyIGZv
cmNlcyBvcmRlcmluZw0KPiBvZiB1bnJlbGF0ZWQgc3RvcmVzLCBldmVyeXRoaW5nIGluaXRpYWxs
eSB6ZXJvIGFuZCBhbGwgYWNjZXNzZXMNCj4gUkVBRF9PTkNFKCkgb3IgV1JJVEVfT05DRSgpOg0K
PiANCj4gCVAwCQlQMQkJUDIJCVAzDQo+IAlYID0gMTsJCVkgPSAxOwkJcjEgPSBYOwkJcjMgPSBZ
Ow0KPiAJCQkJCXNvbWVfYmFycmllcigpOwlzb21lX2JhcnJpZXIoKTsNCj4gCQkJCQlyMiA9IFk7
CQlyNCA9IFg7DQo+IA0KPiBQMidzIGFuZCBQMydzIG9yZGVyaW5nIGNvdWxkIGJlIGdsb2JhbGx5
IHZpc2libGUgd2l0aG91dCByZXF1aXJpbmcNCj4gUDAncyBhbmQgUDEncyBpbmRlcGVuZGVudCBz
dG9yZXMgdG8gYmUgb3JkZXJlZCwgZm9yIGV4YW1wbGUsIGlmIHlvdQ0KPiB1c2VkIHNtcF9ybWIo
KSBmb3Igc29tZV9iYXJyaWVyKCkuICBJbiBjb250cmFzdCwgaWYgd2UgdXNlZCBzbXBfbWIoKQ0K
PiBmb3IgYmFycmllciwgZXZlcnlvbmUgd291bGQgYWdyZWUgb24gdGhlIG9yZGVyIG9mIFAwJ3Mg
YW5kIFAwJ3Mgc3RvcmVzLg0KPiANCj4gVGhlcmUgYXJlIGFjdHVhbGx5IGEgZmFpciBudW1iZXIg
b2YgZGlmZmVyZW50IGNvbWJpbmF0aW9ucyBvZg0KPiBhc3BlY3RzIG9mIG1lbW9yeSBvcmRlcmlu
Zy4gIFdlIHdpbGwgbmVlZCB0byBjaG9vc2Ugd2lzZWx5LiAgOy0pDQoNCk15IHRob3VnaHRzIG9u
IHRoaXMgYXJlIHRoYXQgbW9zdCBjb2RlIHByb2JhYmx5IGlzbid0IHBlcmZvcm1hbmNlIGNyaXRp
Y2FsDQplbm91Z2ggdG8gYmUgdXNpbmcgYW55dGhpbmcgb3RoZXIgdGhhbiBub3JtYWwgbG9ja3Mg
Zm9yIGludGVyLWNwdQ0Kc3luY2hyb25pc2F0aW9uLg0KQ2VydGFpbmx5IG1vc3QgcGVvcGxlIGFy
ZSBsaWtlbHkgdG8gZ2V0IGl0IHdyb25nIHNvbWV3aGVyZS4NClNvIHlvdSB3YW50IGEgYmlnIHJl
ZCBzdGlja2VyIHNheWluZyAnRG9uJ3QgdHJ5IHRvIGJlIHRvbyBjbGV2ZXInLg0KDQpBbHNvIHdp
dGhvdXQgZXhhbXBsZXMgb2Ygd2h5IHRoaW5ncyBnbyB3cm9uZyAoZWcgbWVtYmVyX2NvbnN1bWVy
KCkNCmFuZCBhbHBoYSkgaXQgaXMgZGlmZmljdWx0IHRvIHVuZGVyc3RhbmQgdGhlIGRpZmZlcmVu
Y2VzIGJldHdlZW4NCmFsbCB0aGUgYmFycmllcnMgKGV0YykuDQoNCk9UT0ggZGV2aWNlIGRyaXZl
ciBjb2RlIG1heSBuZWVkIHRoaW5ncyBzbGlnaHRseSBzdHJvbmdlciB0aGFuDQpiYXJyaWVyKCkg
KHdoaWNoIEkgdGhpbmsgaXMgYXNtKDo6OiJtZW1vcnkiKSkgdG8gc2VxdWVuY2UgYWNjZXNzZXMN
CnRvIGhhcmR3YXJlIGRldmljZXMgKGFuZCBtZW1vcnkgdGhlIGhhcmR3YXJlIHJlYWRzKSwgYnV0
IHdpdGhvdXQNCmhhdmluZyBhIHN0cm9uZyBiYXJyaWVyIGluIGV2ZXJ5IGlvcmVhZC93cml0ZSgp
IGFjY2Vzcy4NCg0KCURhdmlkDQoNCg==
