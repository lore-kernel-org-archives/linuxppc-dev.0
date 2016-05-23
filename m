Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rCtsX1qWZzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 May 2016 19:43:59 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Kosina' <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>
CC: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Jessica Yu
 <jeyu@redhat.com>, Vojtech Pavlik <vojtech@suse.com>, Petr Mladek
 <pmladek@suse.com>, Peter Zijlstra <peterz@infradead.org>, "x86@kernel.org"
 <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar
 <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>, Jiri Slaby
 <jslaby@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Chris J
 Arges" <chris.j.arges@canonical.com>
Subject: RE: livepatch: change to a per-task consistency model
Date: Mon, 23 May 2016 09:42:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4C40D2@AcuExch.aculab.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <d60b2b9ce6911bb10dbbf244df58df31c7a8af66.1461875890.git.jpoimboe@redhat.com>
 <20160517225357.GA30725@packer-debian-8-amd64.digitalocean.com>
 <alpine.LNX.2.00.1605181011550.31937@cbobk.fhfr.pm>
 <20160518165147.vyuamqfnm5kfwiqf@treble>
 <alpine.LNX.2.00.1605182221420.31937@cbobk.fhfr.pm>
In-Reply-To: <alpine.LNX.2.00.1605182221420.31937@cbobk.fhfr.pm>
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

RnJvbTogSmlyaSBLb3NpbmENCj4gU2VudDogMTggTWF5IDIwMTYgMjE6MjMNCj4gT24gV2VkLCAx
OCBNYXkgMjAxNiwgSm9zaCBQb2ltYm9ldWYgd3JvdGU6DQo+IA0KPiA+IFllYWgsIEkgdGhpbmsg
dGhpcyBzaXR1YXRpb24gLS0gYSB0YXNrIHNsZWVwaW5nIG9uIGFuIGFmZmVjdGVkIGZ1bmN0aW9u
DQo+ID4gaW4gdW5pbnRlcnJ1cHRpYmxlIHN0YXRlIGZvciBhIGxvbmcgcGVyaW9kIG9mIHRpbWUg
LS0gd291bGQgYmUNCj4gPiBleGNlZWRpbmdseSByYXJlIGFuZCBub3Qgc29tZXRoaW5nIHdlIG5l
ZWQgdG8gd29ycnkgYWJvdXQgZm9yIG5vdy4NCj4gDQo+IFBsdXMgaW4gY2FzZSB0YXNrJ2QgYmUg
aW4gVEFTS19VTklOVEVSUlVQVElCTEUgZm9yIG1vcmUgdGhhbiAxMjBzLCBodW5nDQo+IHRhc2sg
ZGV0ZWN0b3Igd291bGQgdHJpZ2dlciBhbnl3YXkuDQoNClJlbGF0ZWQsIHBsZWFzZSBjYW4gd2Ug
aGF2ZSBhIGZsYWcgZm9yIHRoZSBzbGVlcCBhbmQvb3IgcHJvY2VzcyBzbyB0aGF0DQphbiB1bmlu
dGVycnVwdGlibGUgc2xlZXAgZG9lc24ndCB0cmlnZ2VyIHRoZSAnaHVuZyB0YXNrJyBkZXRlY3Rv
cg0KYW5kIGFsc28gc3RvcHMgdGhlIHByb2Nlc3MgY291bnRpbmcgdG93YXJkcyB0aGUgJ2xvYWQg
YXZlcmFnZScuDQoNCkluIHBhcnRpY3VsYXIgc29tZSBrZXJuZWwgdGhyZWFkcyBhcmUgbm90IHNp
Z25hbGFibGUsIGFuZCBkbyBub3QNCndhbnQgdG8gYmUgd29rZW4gYnkgc2lnbmFscyAodGhleSBl
eGl0IG9uIGEgc3BlY2lmaWMgcmVxdWVzdCkuDQoNCglEYXZpZA0KDQo=
