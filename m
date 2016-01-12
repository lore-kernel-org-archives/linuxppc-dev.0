Return-Path: <masami.hiramatsu.pt@hitachi.com>
Received: from mailxx.hitachi.co.jp (fallback.hitachi.co.jp [133.145.228.50])
 by lists.ozlabs.org (Postfix) with ESMTP id EECF11A0D83
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 22:43:02 +1100 (AEDT)
Received: from mail4.hitachi.co.jp (mail4.hitachi.co.jp [133.145.228.5])
 by mailxx.hitachi.co.jp (Postfix) with ESMTP id 4FF8F177033B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 20:04:35 +0900 (JST)
From: =?utf-8?B?5bmz5p2+6ZuF5bezIC8gSElSQU1BVFXvvIxNQVNBTUk=?=
 <masami.hiramatsu.pt@hitachi.com>
To: "'Hemant Kumar'" <hemant@linux.vnet.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "mjw@redhat.com" <mjw@redhat.com>, "sukadev@linux.vnet.ibm.com"
 <sukadev@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "srikar@linux.vnet.ibm.com"
 <srikar@linux.vnet.ibm.com>, "acme@kernel.org" <acme@kernel.org>
Subject: RE: [PATCH v2] perf/probe: Search both .eh_frame and .debug_frame
 sections for probe location
Date: Tue, 12 Jan 2016 11:04:30 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB37526926A9@GSjpTKYDCembx32.service.hitachi.net>
References: <1451900918-6710-1-git-send-email-hemant@linux.vnet.ibm.com>
In-Reply-To: <1451900918-6710-1-git-send-email-hemant@linux.vnet.ibm.com>
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

SGkgSGVtYW50LA0KDQo+RnJvbTogSGVtYW50IEt1bWFyIFttYWlsdG86aGVtYW50QGxpbnV4LnZu
ZXQuaWJtLmNvbV0NCj4NCj5wZXJmIHByb2JlIHRocm91Z2ggZGVidWdpbmZvX19maW5kX3Byb2Jl
cygpIGluIHV0aWwvcHJvYmUtZmluZGVyLmMNCj5jaGVja3MgZm9yIHRoZSBmdW5jdGlvbnMnIGZy
YW1lIGRlc2NyaXB0aW9ucyBpbiBlaXRoZXIgLmVoX2ZyYW1lIHNlY3Rpb24NCj5vZiBhbiBFTEYg
b3IgdGhlIC5kZWJ1Z19mcmFtZS4gVGhlIGNoZWNrIGlzIGJhc2VkIG9uIHdoZXRoZXIgZWl0aGVy
IG9uZQ0KPm9mIHRoZXNlIHNlY3Rpb25zIGlzIHByZXNlbnQuIERlcGVuZGluZyBvbiBkaXN0cm8s
IHRvb2xjaGFpbiBkZWZhdWx0cywNCj5hcmNoaXRldGN1dHJlLCBidWlsZCBmbGFncywgZXRjLiwg
Q0ZJIG1pZ2h0IGJlIGZvdW5kIGluIGVpdGhlciAuZWhfZnJhbWUNCj5hbmQvb3IgLmRlYnVnX2Zy
YW1lLiBTb21ldGltZXMsIGl0IG1heSBoYXBwZW4gdGhhdCwgLmVoX2ZyYW1lLCBldmVuIGlmDQo+
cHJlc2VudCwgbWF5IG5vdCBiZSBjb21wbGV0ZSBhbmQgbWF5IG1pc3Mgc29tZSBkZXNjcmlwdGlv
bnMuIFRoZXJlZm9yZSwNCj50byBiZSBzdXJlLCB0byBmaW5kIHRoZSBDRkkgY292ZXJpbmcgYW4g
YWRkcmVzcyB3ZSB3aWxsIGFsd2F5cyBoYXZlIHRvDQo+aW52ZXN0aWdhdGUgYm90aCBpZiBhdmFp
bGFibGUuDQoNCk9LLCBzbyB3ZSdkIGJldHRlciBjaGVjayBib3RoIGNmaSdzLg0KIFsuLi5dDQo+
Ky8qIEZpbmQgcHJvYmUgcG9pbnRzIGZyb20gZGVidWdpbmZvICovDQo+K3N0YXRpYyBpbnQgZGVi
dWdpbmZvX19maW5kX3Byb2JlcyhzdHJ1Y3QgZGVidWdpbmZvICpkYmcsDQo+KwkJCQkgIHN0cnVj
dCBwcm9iZV9maW5kZXIgKnBmKQ0KPit7DQo+KwlpbnQgcmV0ID0gMDsNCj4rDQo+KyNpZiBfRUxG
VVRJTFNfUFJFUkVRKDAsIDE0MikNCj4rCUVsZiAqZWxmOw0KPisJR0VsZl9FaGRyIGVoZHI7DQo+
KwlHRWxmX1NoZHIgc2hkcjsNCj4rDQo+KwlpZiAocGYtPmNmaV9laCB8fCBwZi0+Y2ZpX2RiZykN
Cj4rCQlyZXR1cm4gZGVidWdpbmZvX19maW5kX3Byb2JlX2xvY2F0aW9uKGRiZywgcGYpOw0KPisN
Cj4rCS8qIEdldCB0aGUgY2FsbCBmcmFtZSBpbmZvcm1hdGlvbiBmcm9tIHRoaXMgZHdhcmYgKi8N
Cj4rCWVsZiA9IGR3YXJmX2dldGVsZihkYmctPmRiZyk7DQo+KwlpZiAoZWxmID09IE5VTEwpDQo+
KwkJcmV0dXJuIC1FSU5WQUw7DQo+Kw0KPisJaWYgKGdlbGZfZ2V0ZWhkcihlbGYsICZlaGRyKSA9
PSBOVUxMKQ0KPisJCXJldHVybiAtRUlOVkFMOw0KPisNCj4rCWlmIChlbGZfc2VjdGlvbl9ieV9u
YW1lKGVsZiwgJmVoZHIsICZzaGRyLCAiLmVoX2ZyYW1lIiwgTlVMTCkgJiYNCj4rCSAgICBzaGRy
LnNoX3R5cGUgPT0gU0hUX1BST0dCSVRTKSB7DQo+KwkJcGYtPmNmaV9laCA9IGR3YXJmX2dldGNm
aV9lbGYoZWxmKTsNCj4rCX0gZWxzZSB7DQo+KwkJcGYtPmNmaV9kYmcgPSBkd2FyZl9nZXRjZmko
ZGJnLT5kYmcpOw0KPisJfQ0KDQpIbW0sIGlmIHlvdSB3YW50IHRvIGNoZWNrIGJvdGggb2YgdGhv
c2UgY2ZpJ3MsIGRvbid0IHdlIGhhdmUgdG8gZG8gYmVsb3c/DQoNCglpZiAoZWxmX3NlY3Rpb25f
YnlfbmFtZShlbGYsICZlaGRyLCAmc2hkciwgIi5laF9mcmFtZSIsIE5VTEwpICYmDQoJICAgIHNo
ZHIuc2hfdHlwZSA9PSBTSFRfUFJPR0JJVFMpDQoJCXBmLT5jZmlfZWggPSBkd2FyZl9nZXRjZmlf
ZWxmKGVsZik7DQoNCglwZi0+Y2ZpX2RiZyA9IGR3YXJmX2dldGNmaShkYmctPmRiZyk7DQoNClRo
ZW4sIGJvdGggb2YgcGYtPmNmaV8qIHdpbGwgYmUgZmlsbGVkIChpZiB0aGUgZWxmIGhhcyAiLmVo
X2ZyYW1lIikuDQoNClRoYW5rcyENCg0KDQoNCg==
