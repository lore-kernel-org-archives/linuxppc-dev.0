Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rvZmY17J3zDqRj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jul 2016 21:43:25 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dave Young' <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>
CC: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "bhe@redhat.com" <bhe@redhat.com>,
 "arnd@arndb.de" <arnd@arndb.de>, "kexec@lists.infradead.org"
 <kexec@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "bauerman@linux.vnet.ibm.com" <bauerman@linux.vnet.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Vivek Goyal
 <vgoyal@redhat.com>
Subject: RE: [RFC 3/3] kexec: extend kexec_file_load system call
Date: Wed, 20 Jul 2016 11:41:35 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4FE82B@AcuExch.aculab.com>
References: <20160712014201.11456-1-takahiro.akashi@linaro.org>
 <20160712014201.11456-4-takahiro.akashi@linaro.org>
 <20160715130955.GC23514@redhat.com> <20160715131950.GB19840@leverpostej>
 <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20160718023024.GB6310@dhcp-128-65.nay.redhat.com>
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

RnJvbTogRGF2ZSBZb3VuZw0KPiBPbiAwNy8xNS8xNiBhdCAwMjoxOXBtLCBNYXJrIFJ1dGxhbmQg
d3JvdGU6DQo+ID4gT24gRnJpLCBKdWwgMTUsIDIwMTYgYXQgMDk6MDk6NTVBTSAtMDQwMCwgVml2
ZWsgR295YWwgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEp1bCAxMiwgMjAxNiBhdCAxMDo0MjowMUFN
ICswOTAwLCBBS0FTSEkgVGFrYWhpcm8gd3JvdGU6DQo+ID4gPg0KPiA+ID4gWy4uXQ0KPiA+ID4g
PiAtU1lTQ0FMTF9ERUZJTkU1KGtleGVjX2ZpbGVfbG9hZCwgaW50LCBrZXJuZWxfZmQsIGludCwg
aW5pdHJkX2ZkLA0KPiA+ID4gPiArU1lTQ0FMTF9ERUZJTkU2KGtleGVjX2ZpbGVfbG9hZCwgaW50
LCBrZXJuZWxfZmQsIGludCwgaW5pdHJkX2ZkLA0KPiA+ID4gPiAgCQl1bnNpZ25lZCBsb25nLCBj
bWRsaW5lX2xlbiwgY29uc3QgY2hhciBfX3VzZXIgKiwgY21kbGluZV9wdHIsDQo+ID4gPiA+IC0J
CXVuc2lnbmVkIGxvbmcsIGZsYWdzKQ0KPiA+ID4gPiArCQl1bnNpZ25lZCBsb25nLCBmbGFncywg
Y29uc3Qgc3RydWN0IGtleGVjX2Zkc2V0IF9fdXNlciAqLCB1ZmRzZXQpDQo+ID4gPg0KPiA+ID4g
Q2FuIG9uZSBhZGQgbW9yZSBwYXJhbWV0ZXJzIHRvIGV4aXN0aW5nIHN5c2NhbGwuIENhbiBpdCBi
cmVhayBleGlzdGluZw0KPiA+ID4gcHJvZ3JhbXMgd2l0aCBuZXcga2VybmVsPyBJIHdhcyBvZiB0
aGUgaW1wcmVzc2lvbiB0aGF0IG9uZSBjYW4ndCBkbyB0aGF0Lg0KPiA+ID4gQnV0IG1heSBiZSBJ
IGFtIG1pc3Npbmcgc29tZXRoaW5nLg0KPiA+DQo+ID4gSSB0aGluayB0aGUgaWRlYSB3YXMgdGhh
dCB3ZSB3b3VsZCBvbmx5IGxvb2sgYXQgdGhlIG5ldyBwYXJhbXMgaWYgYSBuZXcNCj4gPiBmbGFn
cyB3YXMgc2V0LCBhbmQgb3RoZXJ3aXNlIGl0IHdvdWxkIGJlaGF2ZSBhcyB0aGUgb2xkIHN5c2Nh
bGwuDQo+ID4NCj4gPiBSZWdhcmRsZXNzLCBJIHRoaW5rIGl0IG1ha2VzIGZhciBtb3JlIHNlbnNl
IHRvIGFkZCBhIGtleGVjX2ZpbGVfbG9hZDINCj4gPiBzeXNjYWxsIGlmIHdlJ3JlIGdvaW5nIHRv
IG1vZGlmeSB0aGUgcHJvdG90eXBlIGF0IGFsbC4gSXQncyBhIHJhdGhlcg0KPiA+IGRpZmZlcmVu
dCBwcm9wb3NpdGlvbiB0byB0aGUgZXhpc3Rpbmcgc3lzY2FsbCwgYW5kIG5lZWRzIHRvIGJlIHRy
ZWF0ZWQNCj4gPiBhcyBzdWNoLg0KPiANCj4gSSBkbyBub3QgdGhpbmsgaXQgaXMgd29ydGggdG8g
YWRkIGFub3RoZXIgc3lzY2FsbCBmb3IgZXh0cmEgZmRzLg0KPiBXZSBoYXZlIG9wZW4oMikgYXMg
YW4gZXhhbXBsZSBmb3IgZGlmZmVyZW50IG51bWJlcnMgb2YgYXJndW1lbnRzDQo+IGFscmVhZHku
DQoNClByb2JhYmx5IHdvcmtzICdieSBsdWNrJyBhbmQgbm8gb25lIGhhcyBhY3R1YWxseSB0aG91
Z2h0IGFib3V0IHdoeS4NClRoYXQgaW9jdGwoKSB3b3JrcyBpcyAocHJvYmFibHkpIGV2ZW4gbW9y
ZSBsdWNreS4NCg0KVGhlcmUgYXJlIEFCSSB0aGF0IHVzZSBkaWZmZXJlbnQgY2FsbGluZyBjb252
ZW50aW9ucyBmb3IgdmFyYWdzIGZ1bmN0aW9ucw0KKGVnIGFsd2F5cyBzdGFjayBhbGwgdGhlIGFy
Z3VtZW50cykuIEkgZ3Vlc3MgbGludXggZG9lc24ndCBydW4gb24gYW55IG9mIHRoZW0uDQoNCmlv
Y3RsKCkgaXMgYSBwYXJ0aWN1bGFyIHByb2JsZW0gYmVjYXVzZSB0aGUgJ2FyZycgbWlnaHQgYmUg
YW4gaW50ZWdlciBvciBhIHBvaW50ZXIuDQpGb3J0dW5hdGVseSBhbGwgdGhlIDY0Yml0IEFCSSBs
aW51eCB1c2VzIHBhc3MgdGhlIGFyZyBwYXJhbWV0ZXIgaW4gYSByZWdpc3Rlcg0KKGFuZCBkb24n
dCB1c2UgZGlmZmVyZW50IHJlZ2lzdGVycyBmb3IgcG9pbnRlciBhbmQgZGF0YSBhcmd1bWVudHMp
Lg0KDQpZb3UgY291bGQgaGF2ZSB0d28gJ2xpYmMnIGZ1bmN0aW9ucyB0aGF0IHJlZmVyIHRvIHRo
ZSBzYW1lIHN5c3RlbSBjYWxsIGVudHJ5Lg0KQ2VydGFpbmx5IHNhZmVyIHRoYW4gYSB2YXJhcmdz
IGZ1bmN0aW9uLg0KDQoJRGF2aWQNCg0K
