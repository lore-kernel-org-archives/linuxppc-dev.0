Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id A03DD1A001C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 02:04:27 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02010-05 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 11 Sep 2014 17:04:23 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Aaron Tomlin' <atomlin@redhat.com>, "peterz@infradead.org"
 <peterz@infradead.org>
Subject: RE: [PATCH v3 0/3] sched: Always check the integrity of the canary
Date: Thu, 11 Sep 2014 16:02:45 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17490245@AcuExch.aculab.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
In-Reply-To: <1410450088-18236-1-git-send-email-atomlin@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "dzickus@redhat.com" <dzickus@redhat.com>,
 "jcastillo@redhat.com" <jcastillo@redhat.com>,
 "riel@redhat.com" <riel@redhat.com>, "prarit@redhat.com" <prarit@redhat.com>,
 "pzijlstr@redhat.com" <pzijlstr@redhat.com>,
 "mingo@kernel.com" <mingo@kernel.com>, "bmr@redhat.com" <bmr@redhat.com>,
 "x86@kernel.org" <x86@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
 "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "minchan@kernel.org" <minchan@kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
 "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "jgh@redhat.com" <jgh@redhat.com>, "akpm@google.com" <akpm@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQWFyb24gVG9tbGluDQo+IEN1cnJlbnRseSBpbiB0aGUgZXZlbnQgb2YgYSBzdGFjayBv
dmVycnVuIGEgY2FsbCB0byBzY2hlZHVsZSgpDQo+IGRvZXMgbm90IGNoZWNrIGZvciB0aGlzIHR5
cGUgb2YgY29ycnVwdGlvbi4gVGhpcyBjb3JydXB0aW9uIGlzDQo+IG9mdGVuIHNpbGVudCBhbmQg
Y2FuIGdvIHVubm90aWNlZC4gSG93ZXZlciBvbmNlIHRoZSBjb3JydXB0ZWQNCj4gcmVnaW9uIGlz
IGV4YW1pbmVkIGF0IGEgbGF0ZXIgc3RhZ2UsIHRoZSBvdXRjb21lIGlzIHVuZGVmaW5lZA0KPiBh
bmQgb2Z0ZW4gcmVzdWx0cyBpbiBhIHNwb3JhZGljIHBhZ2UgZmF1bHQgd2hpY2ggY2Fubm90IGJl
DQo+IGhhbmRsZWQuDQo+IA0KPiBUaGUgZmlyc3QgcGF0Y2ggYWRkcyBhIGNhbmFyeSB0byBpbml0
X3Rhc2sncyBlbmQgb2Ygc3RhY2suDQo+IFdoaWxlIHRoZSBzZWNvbmQgcGF0Y2ggcHJvdmlkZXMg
YSBoZWxwZXIgdG8gZGV0ZXJtaW5lIHRoZQ0KPiBpbnRlZ3JpdHkgb2YgdGhlIGNhbmFyeS4gVGhl
IHRoaXJkIGNoZWNrcyBmb3IgYSBzdGFjaw0KPiBvdmVycnVuIGFuZCB0YWtlcyBhcHByb3ByaWF0
ZSBhY3Rpb24gc2luY2UgdGhlIGRhbWFnZQ0KPiBpcyBhbHJlYWR5IGRvbmUsIHRoZXJlIGlzIG5v
IHBvaW50IGluIGNvbnRpbnVpbmcuDQoNCkNsZWFybHkgeW91J3ZlIGp1c3QgYmVlbiAnYml0dGVu
JyBieSBhIGtlcm5lbCBzdGFjayBvdmVyZmxvdy4NCkJ1dCBhIHNpbXBsZSAnY2FuYXJ5JyBpc24n
dCBnb2luZyB0byBmaW5kIG1vc3Qgb2YgdGhlIG92ZXJmbG93cw0KYW5kIHdpbGwgZ2l2ZSBhbiBp
bmNvcnJlY3QgJ3NlbnNlIG9mIHNlY3VyaXR5Jy4NCg0KVGhlIGNhbmFyeSB3aWxsIG9ubHkgd29y
ayBpZiB0aGUgc3RhY2sgaXMgZGVuc2VseSB3cml0dGVuLg0KSW4gcHJhY3Rpc2UgdGhlIHN0YWNr
IGFsaWdubWVudCBydWxlcyBjcmVhdGUgZ2FwcywgYW5kIHRoZQ0KbW9zdCBsaWtlbHkgcmVhc29u
IGZvciBvdmVyZmxvdyBpcyBhIGxhcmdlIG9uLXN0YWNrIGJ1ZmZlcg0KdGhhdCBpc24ndCBhY3R1
YWxseSB3cml0dGVuIHRvLg0KDQpUaGUgb25seSByZWFsIHdheSB0byBkZXRlY3Qga2VybmVsIHN0
YWNrIG92ZXJmbG93IGlzIHRvIGFycmFuZ2UNCmZvciBhbiB1bm1hcHBlZCBwYWdlIGJleW9uZCB0
aGUgc3RhY2suDQpUaGF0IGNvc3RzIEtWQSwgYnV0IG5vdCBtdWNoIGVsc2UuDQoNCglEYXZpZA0K
DQo=
