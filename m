Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89A581A0D92
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 02:50:24 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, Petr Mladek
 <pmladek@suse.com>
CC: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Daniel Thompson
 <daniel.thompson@linaro.org>, Jiri Kosina <jkosina@suse.com>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>, Ingo Molnar <mingo@redhat.com>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 3/5] printk/nmi: Try hard to print Oops message in
 NMI context
Date: Mon, 7 Dec 2015 15:48:33 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CBE68C7@AcuExch.aculab.com>
References: <1448622572-16900-1-git-send-email-pmladek@suse.com>
 <1448622572-16900-4-git-send-email-pmladek@suse.com>
 <20151201234437.GA8644@n2100.arm.linux.org.uk>
 <20151204152709.GA20935@pathway.suse.cz>
 <20151204171255.GZ8644@n2100.arm.linux.org.uk>
In-Reply-To: <20151204171255.GZ8644@n2100.arm.linux.org.uk>
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

RnJvbTogUnVzc2VsbCBLaW5nIC0gQVJNIExpbnV4DQo+IFNlbnQ6IDA0IERlY2VtYmVyIDIwMTUg
MTc6MTMNCi4uLg0KPiBJIGhhdmUgYSBzbGlnaHRseSBkaWZmZXJlbnQgdmlldy4uLg0KPiANCj4g
PiA+IEkgZG9uJ3Qgc2VlIGJ1c3Rfc3BpbmxvY2tzKCkgZGVhbGluZyB3aXRoIGFueSBvZiB0aGVz
ZSBsb2Nrcywgc28gSU1ITw0KPiA+ID4gdHJ5aW5nIHRvIG1ha2UgdGhpcyB3b3JrIGluIE5NSSBj
b250ZXh0IHN0cmlrZXMgbWUgYXMgbWFraW5nIHRoZQ0KPiA+ID4gZXhpc3Rpbmcgc29sdXRpb24g
bW9yZSB1bnJlbGlhYmxlIG9uIEFSTSBzeXN0ZW1zLg0KPiA+DQo+ID4gYnVzdF9zcGlubG9ja3Mo
KSBjYWxscyBwcmludGtfbm1pX2ZsdXNoKCkgdGhhdCB3b3VsZCBjYWxsIHByaW50aygpDQo+ID4g
dGhhdCB3b3VsZCB6YXAgImxvY2tidWZfbG9jayIgYW5kICJjb25zb2xlX3NlbSIgd2hlbiBpbiBP
b3BzIGFuZCBOTUkuDQo+ID4gWWVzLCB0aGVyZSBtaWdodCBiZSBtb3JlIGxvY2tzIGJsb2NrZWQg
YnV0IHdlIHRyeSB0byBicmVhayBhdCBsZWFzdA0KPiA+IHRoZSBmaXJzdCB0d28gd2FsbHMuIEFs
c28gemFwcGluZyBpcyBhbGxvd2VkIG9ubHkgb25jZSBwZXIgMzAgc2Vjb25kcywNCj4gPiBzZWUg
emFwX2xvY2tzKCkuIFdoeSBkbyB5b3UgdGhpbmsgdGhhdCBpdCBtaWdodCBtYWtlIHRoaW5ncyBt
b3JlDQo+ID4gdW5yZWxpYWJsZSwgcGxlYXNlPw0KPiANCj4gVGFrZSB0aGUgc2NlbmFyaW8gd2hl
cmUgQ1BVMSBpcyBpbiB0aGUgbWlkZGxlIG9mIGEgcHJpbnRrKCksIGFuZCBpcw0KPiBob2xkaW5n
IGl0cyBsb2NrLg0KPiANCj4gQ1BVMCBjb21lcyBhbG9uZyBhbmQgZGVjaWRlcyB0byB0cmlnZ2Vy
IGEgTk1JIGJhY2t0cmFjZS4gIFRoaXMgc2VuZHMNCj4gYSBOTUkgdG8gQ1BVMSwgd2hpY2ggdGFr
ZXMgaXQgaW4gdGhlIG1pZGRsZSBvZiB0aGUgc2VyaWFsIGNvbnNvbGUNCj4gb3V0cHV0Lg0KPiAN
Cj4gV2l0aCB0aGUgZXhpc3Rpbmcgc29sdXRpb24sIHRoZSBOTUkgb3V0cHV0IHdpbGwgYmUgd3Jp
dHRlbiB0byB0aGUNCj4gdGVtcG9yYXJ5IGJ1ZmZlciwgYW5kIENQVTEgaGFzIGZpbmlzaGVkIGhh
bmRsaW5nIHRoZSBOTUkgaXQgcmVzdW1lcw0KPiB0aGUgc2VyaWFsIGNvbnNvbGUgb3V0cHV0LCBl
dmVudHVhbGx5IGRyb3BwaW5nIHRoZSBsb2NrLiAgVGhhdCB0aGVuDQo+IGFsbG93cyBDUFUwIHRv
IHByaW50IHRoZSBjb250ZW50cyBvZiBhbGwgYnVmZmVycywgYW5kIHdlIGdldCBOTUkNCj4gcHJp
bnRrIG91dHB1dC4NCg0KSXMgdGhlIHRyYWNlYmFjayBmcm9tIGluc2lkZSBwcmludGsoKSBvciBz
ZXJpYWwgY29uc29sZSBjb2RlDQpsaWtlbHkgdG8gYmUgdXNlZnVsPw0KSWYgbm90IHRoZW4gd2h5
IG5vdCBnZXQgdGhlIHN0YWNrdHJhY2UgZ2VuZXJhdGVkIHdoZW4gdGhlIHJlbGV2YW50DQpsb2Nr
IGlzIHJlbGVhc2VkPw0KVGhhdCBzaG91bGQgc2F2ZSBhbnkgZmFmZmluZyB3aXRoIGEgc3BlY2lh
bCBidWZmZXIuDQoNCglEYXZpZA0KDQo=
