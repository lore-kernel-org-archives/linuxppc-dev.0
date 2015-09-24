Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mailx.hitachi.co.jp (fallback.hitachi.co.jp [133.145.228.49])
 by lists.ozlabs.org (Postfix) with ESMTP id 878DB1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 21:31:04 +1000 (AEST)
Received: from mail7.hitachi.co.jp (mail7.hitachi.co.jp [133.145.228.42])
 by mailx.hitachi.co.jp (Postfix) with ESMTP id 5A1FB17703F8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2015 19:56:06 +0900 (JST)
From: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?=
 <masami.hiramatsu.pt@hitachi.com>
To: "'Mark Wielaard'" <mjw@redhat.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "acme@kernel.org" <acme@kernel.org>, "sukadev@linux.vnet.ibm.com"
 <sukadev@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "srikar@linux.vnet.ibm.com"
 <srikar@linux.vnet.ibm.com>, "naveen.n.rao@linux.vnet.ibm.com"
 <naveen.n.rao@linux.vnet.ibm.com>
Subject: RE: [PATCH] perf/probe: Search both .eh_frame and .debug_frame
 sections for probe location
Date: Thu, 24 Sep 2015 10:56:01 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB37525585E9@GSjpTKYDCembx32.service.hitachi.net>
References: <1443060990-10313-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1443088766.3102.19.camel@bordewijk.wildebeest.org>
In-Reply-To: <1443088766.3102.19.camel@bordewijk.wildebeest.org>
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

RnJvbTogTWFyayBXaWVsYWFyZCBbbWFpbHRvOm1qd0ByZWRoYXQuY29tXQ0KPg0KPkhpIEhlbWFu
dCwNCj4NCj5PbiBUaHUsIDIwMTUtMDktMjQgYXQgMDc6NDYgKzA1MzAsIEhlbWFudCBLdW1hciB3
cm90ZToNCj4+IHBlcmYgcHJvYmUgdGhyb3VnaCBkZWJ1Z2luZm9fX2ZpbmRfcHJvYmVzKCkgaW4g
dXRpbC9wcm9iZS1maW5kZXIuYw0KPj4gY2hlY2tzIGZvciB0aGUgZnVuY3Rpb25zJyBmcmFtZSBk
ZXNjcmlwdGlvbnMgaW4gZWl0aGVyIC5laF9mcmFtZSBzZWN0aW9uDQo+PiBvZiBhbiBFTEYgb3Ig
dGhlIC5kZWJ1Z19mcmFtZS4gVGhlIGNoZWNrIGlzIGJhc2VkIG9uIHdoZXRoZXIgZWl0aGVyIG9u
ZQ0KPj4gb2YgdGhlc2Ugc2VjdGlvbnMgaXMgcHJlc2VudC4gQnV0IHNvbWV0aW1lcywgaXQgbWF5
IGhhcHBlbiB0aGF0LA0KPj4gLmVoX2ZyYW1lLCBldmVuIGlmIHByZXNlbnQsIG1heSBub3QgYmUg
Y29tcGxldGUgYW5kIG1heSBtaXNzIHNvbWUNCj4+IGRlc2NyaXB0aW9ucy4NCj4NCj5SaWdodC4g
RGVwZW5kaW5nIG9uIGRpc3RybywgdG9vbGNoYWluIGRlZmF1bHRzLCBhcmNoLCBidWlsZCBmbGFn
cywgZXRjLg0KPkNGSSBtaWdodCBiZSBmb3VuZCBpbiBlaXRoZXIgLmVoX2ZyYW1lIGFuZC9vciAu
ZGVidWdfZnJhbWUuIFRvIGJlIHN1cmUNCj55b3UgZmluZCB0aGUgQ0ZJIGNvdmVyaW5nIGFuIGFk
ZHJlc3MgeW91IHdpbGwgYWx3YXlzIGhhdmUgdG8gaW52ZXN0aWdhdGUNCj5ib3RoIGlmIGF2YWls
YWJsZS4NCg0KT0ssIEkgZGlkbid0IGNhcmUgYWJvdXQgdGhhdC4NCg0KPg0KPkkgYW0gbm90IHRv
byBmYW1pbGlhciB3aXRoIHRoZSBjb2RlIHNvIHRoZXJlIG1pZ2h0IGJlIGEgcmVhc29uIGZvcg0K
PnNldHRpbmcgYW5kIHJldXNpbmcgdGhlIHBmLT5jZmkgdG8gZG8gdGhlIHNlYXJjaCB0d2ljZS4g
QnV0IG1pZ2h0IGl0IG5vdA0KPmJlIG1vcmUgY2xlYXIgdG8ganVzdCBzdG9yZSBib3RoIHBmLT5j
ZmlfZWggYW5kIHBmLT5jZmlfZGVidWcgYW5kIHRoZW4NCj5jaGVjayBib3RoIGluIGNhbGxfcHJv
YmVfZmluZGVyICgpIHdpdGggdGhlIGR3YXJmX2NmaV9hZGRyZnJhbWUgKCkgY2FsbD8NCj5XaGlj
aCBpcyB0aGUgb25seSBwbGFjZSBJIHNlZSBhY3R1YWxseSB1c2luZyB0aGUgY2ZpLg0KDQpSaWdo
dCwgYnV0IHNpbmNlIGNhbGxfcHJvYmVfZmluZGVyIGNhbiBiZSBjYWxsZWQgcmVwZWF0ZWRseSBv
biBzYW1lIGJpbmFyeSwNCndlIHNob3VsZCBrZWVwIHBmLT5jZmkgZm9yIGNhY2hpbmcgQ0ZJIHRv
by4NCg0KPkJUVy4gTm90IHJlYWxseSByZWxhdGVkIHRvIHRoaXMgcGF0Y2ggc2luY2UgdGhlIGZv
bGxvd2luZyB3YXMgYWxyZWFkeSBpbg0KPnRoZSBjb2RlLCBhbmQgaXMgbW9zdCBsaWtlbHkgYWx3
YXlzIGNvcnJlY3QgYW55d2F5Og0KPg0KPj4gKwlpZiAoZWxmX3NlY3Rpb25fYnlfbmFtZShlbGYs
ICZlaGRyLCAmc2hkciwgIi5laF9mcmFtZSIsIE5VTEwpICYmDQo+PiArCSAgICBzaGRyLnNoX3R5
cGUgPT0gU0hUX1BST0dCSVRTKSB7DQo+PiArCQlwZi0+Y2ZpID0gZHdhcmZfZ2V0Y2ZpX2VsZihl
bGYpOw0KPg0KPkJ1dCB0aGF0IFNIVF9QUk9HQklUUyBjaGVjayBpcyBvbmx5IG5lY2Vzc2FyeSBi
ZWNhdXNlIG9mIGEgYnVnIGluDQo+ZWxmdXRpbHMgPCAwLjE1Ni4gRm9yIDAuMTU2KyBkd2FyZl9n
ZXRjZmlfZWxmICgpIHdpbGwgcHJvcGVybHkgcmV0dXJuDQo+TlVMTCBpbiBjYXNlIHlvdSBoYXBw
ZW4gdG8gYmUgbG9va2luZyBhdCBhIHNlcGFyYXRlIGRlYnVnIGZpbGUgdGhhdA0KPmhhcyAuZWhf
ZnJhbWUgYXMgTk9CSVRTLiBJbiB0aGVvcnkgdGhpcyBwcmV2ZW50cyBnZXR0aW5nIHRoZSBDRkkg
aWYgdGhlDQo+ZmlsZSBoYXMgc3RyaXBwZWQgYXdheSB0aGUgc2hkcnMuIFdoaWNoIGlzIHJlYXNv
bmFibGUsIHRoZXJlIGFyZQ0KPnByb2JhYmx5IGFsc28gb3RoZXIgdGhpbmdzIHRoYXQgcmVseSBv
biB0aGUgc2hkcnMuDQoNCkFoLCBJIGhhZCBqdXN0IHdhbnRlZCB0byBhdm9pZCBpbnRyb2R1Y2lu
ZyBuZXcgaWZkZWZzLg0KDQo+IEJ1dCBkd2FyZl9nZXRjZmlfZWxmDQo+aXMgYWJsZSB0byBhbHNv
IGdldCB5b3UgdGhlIENGSSB3aXRoIGp1c3QgdGhlIHBoZHJzLg0KDQpIbW0sIGhvdyBjYW4gSSBt
YWtlIHN1Y2ggYmluYXJ5PyBJIGNhbiBmaXggaXQsIGJ1dCB3ZSBuZWVkIGENCnRlc3RjYXNlIGZv
ciB0aGF0Lg0KDQpUaGFua3MhDQoNCj4NCj5DaGVlcnMsDQo+DQo+TWFyaw0K
