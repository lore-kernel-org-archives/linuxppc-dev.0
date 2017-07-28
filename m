Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJjCv3L4RzDrRQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 18:47:54 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Borislav Petkov' <bp@suse.de>, Brijesh Singh <brijesh.singh@amd.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
 =?utf-8?B?UmFkaW0gS3JjbcOhcg==?= <rkrcmar@redhat.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, Matt Fleming
 <matt@codeblueprint.co.uk>, David Howells <dhowells@redhat.com>, "Paul
 Mackerras" <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, "Christoph
 Lameter" <cl@linux.com>, Jonathan Corbet <corbet@lwn.net>, "x86@kernel.org"
 <x86@kernel.org>, Piotr Luc <piotr.luc@intel.com>, Ingo Molnar
 <mingo@redhat.com>, Dave Airlie <airlied@redhat.com>, Laura Abbott
 <labbott@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, Kees Cook
 <keescook@chromium.org>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Reza Arbab <arbab@linux.vnet.ibm.com>, "Andy
 Lutomirski" <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Tony
 Luck" <tony.luck@intel.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biederman
 <ebiederm@xmission.com>, Tejun Heo <tj@kernel.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Kirill A .
 Shutemov" <kirill.shutemov@linux.intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>
Subject: RE: [RFC Part1 PATCH v3 07/17] x86/mm: Include SEV for encryption
 memory attribute changes
Date: Fri, 28 Jul 2017 08:47:30 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0045508@AcuExch.aculab.com>
References: <20170724190757.11278-1-brijesh.singh@amd.com>
 <20170724190757.11278-8-brijesh.singh@amd.com>
 <20170727145841.GG28553@nazgul.tnic>
In-Reply-To: <20170727145841.GG28553@nazgul.tnic>
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

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDI3IEp1bHkgMjAxNyAxNTo1OQ0KPiBPbiBN
b24sIEp1bCAyNCwgMjAxNyBhdCAwMjowNzo0N1BNIC0wNTAwLCBCcmlqZXNoIFNpbmdoIHdyb3Rl
Og0KPiA+IEZyb206IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+DQo+ID4N
Cj4gPiBUaGUgY3VycmVudCBjb2RlIGNoZWNrcyBvbmx5IGZvciBzbWVfYWN0aXZlKCkgd2hlbiBk
ZXRlcm1pbmluZyB3aGV0aGVyDQo+ID4gdG8gcGVyZm9ybSB0aGUgZW5jcnlwdGlvbiBhdHRyaWJ1
dGUgY2hhbmdlLiAgSW5jbHVkZSBzZXZfYWN0aXZlKCkgaW4gdGhpcw0KPiA+IGNoZWNrIHNvIHRo
YXQgbWVtb3J5IGF0dHJpYnV0ZSBjaGFuZ2VzIGNhbiBvY2N1ciB1bmRlciBTTUUgYW5kIFNFVi4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvbSBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFt
ZC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBh
bWQuY29tPg0KPiA+IC0tLQ0KPiA+ICBhcmNoL3g4Ni9tbS9wYWdlYXR0ci5jIHwgNCArKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vcGFnZWF0dHIuYyBiL2FyY2gveDg2L21tL3Bh
Z2VhdHRyLmMNCj4gPiBpbmRleCBkZmI3ZDY1Li5iNzI2YjIzIDEwMDY0NA0KPiA+IC0tLSBhL2Fy
Y2gveDg2L21tL3BhZ2VhdHRyLmMNCj4gPiArKysgYi9hcmNoL3g4Ni9tbS9wYWdlYXR0ci5jDQo+
ID4gQEAgLTE3ODEsOCArMTc4MSw4IEBAIHN0YXRpYyBpbnQgX19zZXRfbWVtb3J5X2VuY19kZWMo
dW5zaWduZWQgbG9uZyBhZGRyLCBpbnQgbnVtcGFnZXMsIGJvb2wgZW5jKQ0KPiA+ICAJdW5zaWdu
ZWQgbG9uZyBzdGFydDsNCj4gPiAgCWludCByZXQ7DQo+ID4NCj4gPiAtCS8qIE5vdGhpbmcgdG8g
ZG8gaWYgdGhlIFNNRSBpcyBub3QgYWN0aXZlICovDQo+ID4gLQlpZiAoIXNtZV9hY3RpdmUoKSkN
Cj4gPiArCS8qIE5vdGhpbmcgdG8gZG8gaWYgU01FIGFuZCBTRVYgYXJlIG5vdCBhY3RpdmUgKi8N
Cj4gPiArCWlmICghc21lX2FjdGl2ZSgpICYmICFzZXZfYWN0aXZlKCkpDQo+IA0KPiBUaGlzIGlz
IHRoZSBzZWNvbmQgcGxhY2Ugd2hpY2ggZG9lcw0KPiANCj4gCWlmICghU01FICYmICFTRVYpDQo+
IA0KPiBJIHdvbmRlciBpZiwgaW5zdGVhZCBvZiBzcHJpbmtpbmcgdGhvc2UsIHdlIHNob3VsZCBo
YXZlIGENCj4gDQo+IAlpZiAobWVtX2VuY19hY3RpdmUoKSkNCj4gDQo+IG9yIHNvIHdoaWNoIHVu
aWZpZXMgYWxsIHRob3NlIG1lbW9yeSBlbmNyeXB0aW9uIGxvZ2ljIHRlc3RzIGFuZCBtYWtlcw0K
PiB0aGUgY29kZSBtb3JlIHN0cmFpZ2h0Zm9yd2FyZCBmb3IgcmVhZGVycyB3aG8gZG9uJ3QgaGF2
ZSB0byBwYXkNCj4gYXR0ZW50aW9uIHRvIFNNRSB2cyBTRVYgLi4uDQoNCklmIGFueSBvZiB0aGUg
Y29kZSBwYXRocyBhcmUgJ2hvdCcgaXQgd291bGQgbWFrZSBzZW5zZSB0byBiZSBjaGVja2luZw0K
YSBzaW5nbGUgbWVtb3J5IGxvY2F0aW9uLg0KDQoJRGF2aWQNCg0K
