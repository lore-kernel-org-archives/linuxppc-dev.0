Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.183])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 371F91A0F8C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 21:08:14 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Anton Blanchard' <anton@samba.org>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>, "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: RE: [PATCH 1/2] powerpc: Add 64bit optimised memcmp
Date: Fri, 9 Jan 2015 10:06:59 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CAC418D@AcuExch.aculab.com>
References: <1420768591-6831-1-git-send-email-anton@samba.org>
In-Reply-To: <1420768591-6831-1-git-send-email-anton@samba.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQW50b24gQmxhbmNoYXJkDQo+IEkgbm90aWNlZCBrc20gc3BlbmRpbmcgcXVpdGUgYSBs
b3Qgb2YgdGltZSBpbiBtZW1jbXAgb24gYSBsYXJnZQ0KPiBLVk0gYm94LiBUaGUgY3VycmVudCBt
ZW1jbXAgbG9vcCBpcyB2ZXJ5IHVub3B0aW1pc2VkIC0gYnl0ZSBhdCBhDQo+IHRpbWUgY29tcGFy
ZXMgd2l0aCBubyBsb29wIHVucm9sbGluZy4gV2UgY2FuIGRvIG11Y2ggbXVjaCBiZXR0ZXIuDQo+
IA0KPiBPcHRpbWlzZSB0aGUgbG9vcCBpbiBhIGZldyB3YXlzOg0KPiANCj4gLSBVbnJvbGwgdGhl
IGJ5dGUgYXQgYSB0aW1lIGxvb3ANCj4gDQo+IC0gRm9yIGxhcmdlIChhdCBsZWFzdCAzMiBieXRl
KSBjb21wYXJpc29ucyB0aGF0IGFyZSBhbHNvIDggYnl0ZQ0KPiAgIGFsaWduZWQsIHVzZSBhbiB1
bnJvbGxlZCBtb2R1bG8gc2NoZWR1bGVkIGxvb3AgdXNpbmcgOCBieXRlDQo+ICAgbG9hZHMuIFRo
aXMgaXMgc2ltaWxhciB0byBvdXIgZ2xpYmMgbWVtY21wLg0KPiANCj4gQSBzaW1wbGUgbWljcm9i
ZW5jaG1hcmsgdGVzdGluZyAxMDAwMDAwMCBpdGVyYXRpb25zIG9mIGFuIDgxOTIgYnl0ZQ0KPiBt
ZW1jbXAgd2FzIHVzZWQgdG8gbWVhc3VyZSB0aGUgcGVyZm9ybWFuY2U6DQo+IA0KPiBiYXNlbGlu
ZToJMjkuOTMgcw0KPiANCj4gbW9kaWZpZWQ6CSAxLjcwIHMNCj4gDQo+IEp1c3Qgb3ZlciAxN3gg
ZmFzdGVyLg0KDQpUaGUgdW5yb2xsZWQgbG9vcCAoZGVsZXRlZCkgbG9va3MgZXhjZXNzaXZlLg0K
T24gYSBtb2Rlcm4gY3B1IHdpdGggbXVsdGlwbGUgZXhlY3V0aW9uIHVuaXRzIHlvdSBjYW4gdXN1
YWxseQ0KbWFuYWdlIHRvIGdldCB0aGUgbG9vcCBvdmVyaGVhZCB0byBleGVjdXRlIGluIHBhcmFs
bGVsIHRvIHRoZQ0KYWN0dWFsICd3b3JrJy4NClNvIEkgc3VzcGVjdCB0aGF0IGEgbXVjaCBzaW1w
bGVyICd3b3JkIGF0IGEgdGltZScgbG9vcCB3aWxsIGJlDQphbG1vc3QgYXMgZmFzdCAtIGVzcGVj
aWFsbHkgaW4gdGhlIGNhc2Ugd2hlcmUgdGhlIGNvZGUgaXNuJ3QNCmFscmVhZHkgaW4gdGhlIGNh
Y2hlIGFuZCB0aGUgY29tcGFyZSBpcyByZWxhdGl2ZWx5IHNob3J0Lg0KVHJ5IHNvbWV0aGluZyBi
YXNlZCBvbjoNCglhMSA9ICphKys7DQoJYjEgPSAqYisrOw0KCXdoaWxlIHsNCgkJYTIgPSAqYSsr
Ow0KCQliMiA9ICpiKys7DQoJCWlmIChhMSAhPSBhMikNCgkJCWJyZWFrOw0KCQlhMSA9ICphKys7
DQoJCWIxID0gKmIrKzsNCgl9IHdoaWxlIChhMiAhPSBhMSk7DQoNCglEYXZpZA0KDQo=
