Return-Path: <srs0=ts6k=by=microsoft.com=mawilcox@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMPX84XwTzDqkp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 20:11:36 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yMPX76dPKz8t2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 20:11:35 +1100 (AEDT)
From: Matthew Wilcox <mawilcox@microsoft.com>
To: Paul Mackerras <paulus@ozlabs.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: RE: [PATCH] bitmap: Fix optimization of bitmap_set/clear for
 big-endian machines
Date: Wed, 25 Oct 2017 09:11:29 +0000
Message-ID: <MWHPR21MB0845F366FAEC16ABC46D8309CB440@MWHPR21MB0845.namprd21.prod.outlook.com>
References: <20171025065726.GA25140@fergus.ozlabs.ibm.com>
 <MWHPR21MB08455F1374F717DBA20B7798CB440@MWHPR21MB0845.namprd21.prod.outlook.com>
 <20171025084602.GC25140@fergus.ozlabs.ibm.com>
In-Reply-To: <20171025084602.GC25140@fergus.ozlabs.ibm.com>
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

RnJvbTogUGF1bCBNYWNrZXJyYXMgW21haWx0bzpwYXVsdXNAb3psYWJzLm9yZ10NCj4gT24gV2Vk
LCBPY3QgMjUsIDIwMTcgYXQgMDc6Mzk6NDhBTSArMDAwMCwgTWF0dGhldyBXaWxjb3ggd3JvdGU6
DQo+ID4gSGFuZyBvbiwgZG9uJ3QgdGVsbCBtZSB5b3UgZm91bmQgdGhpcyBieSBpbnNwZWN0aW9u
LiAgQXJlIHlvdSBub3QgcnVubmluZyB0aGUNCj4gYml0bWFwIHRlc3RjYXNlLCBlbmFibGVkIGJ5
IENPTkZJR19URVNUX0JJVE1BUD8gIEVpdGhlciB0aGF0IHNob3VsZCBiZQ0KPiBwcm9kdWNpbmcg
YW4gZXJyb3IsIG9yIHRoZXJlJ3MgYSBtaXNzaW5nIHRlc3QgY2FzZSwgb3IgeW91ciBpbnNwZWN0
aW9uIGlzIHdyb25nIC4uLg0KPiANCj4gSSBkaWQgZmluZCBpdCBieSBpbnNwZWN0aW9uLiAgSSB3
YXMgbG9va2luZyBmb3IgYSB2ZXJzaW9uIG9mIHRoZQ0KPiBiaXRtYXBfKiBBUEkgdGhhdCBkb2Vz
IGxpdHRsZS1lbmRpYW4gc3R5bGUgYml0bWFwcyBvbiBhbGwgc3lzdGVtcywgYW5kDQo+IHRoZSBp
bmxpbmUgYml0bWFwX3NldCgpIGRvZXMgdGhhdCBpbiB0aGUgY2FzZSB3aGVyZSBpdCBjYWxscyBt
ZW1zZXQsDQo+IGJ1dCBub3QgaW4gdGhlIGNhc2Ugd2hlcmUgaXQgY2FsbHMgX19iaXRtYXBfc2V0
Lg0KDQpJIGRvIGJlbGlldmUgdGhhdCB5b3Ugbm90aWNlZCBpdCBieSBpbnNwZWN0aW9uLCBidXQg
eW91IHNob3VsZG4ndCd2ZSBoYWQgdG8uICBJIHRob3VnaHQgd2UgaGFkIGEgY29tcHJlaGVuc2l2
ZSBzZXQgb2YgdGVzdHMgZm9yIGV4YWN0bHkgdGhpcywgd2hpY2ggbWVhbnMgdGhhdCBlaXRoZXIg
MDEub3JnIGlzbid0IHJ1bm5pbmcgdGhlIHJpZ2h0IHNldCBvZiB0ZXN0cyBvbiBhIEJFIHN5c3Rl
bSBvciB0aGUgdGVzdHMgYXJlIGJyb2tlbi4NCg0KPiBJJ2xsIGZpcmUgdXAgYSBiaWctZW5kaWFu
IHN5c3RlbSB0b21vcnJvdyB3aGVuIEkgZ2V0IHRvIHdvcmsgdG8gcnVuDQo+IHRoZSB0ZXN0IGNh
c2UuICAoUFBDNjQgaXMgYWxtb3N0IGVudGlyZWx5IGxpdHRsZS1lbmRpYW4gdGhlc2UgZGF5cyBh
cw0KPiBmYXIgYXMgdGhlIElCTSBQT1dFUiBzeXN0ZW1zIGFyZSBjb25jZXJuZWQuKQ0KPiANCj4g
SW4gYW55IGNhc2UsIGl0J3MgcHJldHR5IGNsZWFybHkgd3JvbmcgYXMgaXQgaXMuICBPbiBhIGJp
Zy1lbmRpYW4NCj4gNjQtYml0IHN5c3RlbSwgYml0bWFwX3NldChwLCA1NiwgMTYpIHNob3VsZCBz
ZXQgYnl0ZXMgMCBhbmQgMTUgdG8NCj4gMHhmZiwgYW5kIHRoZXJlJ3Mgbm8gd2F5IGEgc2luZ2xl
IG1lbXNldCBjYW4gZG8gdGhhdC4NCg0KU28gLi4uIHRoaXMgbG9vcCBzaG91bGQgaW5jbHVkZSB0
aGF0IGNhc2UsIHJpZ2h0Pw0KDQogICAgICAgIGZvciAoc3RhcnQgPSAwOyBzdGFydCA8IDEwMjQ7
IHN0YXJ0ICs9IDgpIHsNCiAgICAgICAgICAgICAgICBtZW1zZXQoYm1hcDEsIDB4NWEsIHNpemVv
ZihibWFwMSkpOw0KICAgICAgICAgICAgICAgIG1lbXNldChibWFwMiwgMHg1YSwgc2l6ZW9mKGJt
YXAyKSk7DQogICAgICAgICAgICAgICAgZm9yIChuYml0cyA9IDA7IG5iaXRzIDwgMTAyNCAtIHN0
YXJ0OyBuYml0cyArPSA4KSB7DQogICAgICAgICAgICAgICAgICAgICAgICBiaXRtYXBfc2V0KGJt
YXAxLCBzdGFydCwgbmJpdHMpOw0KICAgICAgICAgICAgICAgICAgICAgICAgX19iaXRtYXBfc2V0
KGJtYXAyLCBzdGFydCwgbmJpdHMpOw0KICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFiaXRt
YXBfZXF1YWwoYm1hcDEsIGJtYXAyLCAxMDI0KSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcHJpbnRrKCJzZXQgbm90IGVxdWFsICVkICVkXG4iLCBzdGFydCwgbmJpdHMpOw0KICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKCFfX2JpdG1hcF9lcXVhbChibWFwMSwgYm1hcDIsIDEw
MjQpKQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmludGsoInNldCBub3QgX19l
cXVhbCAlZCAlZFxuIiwgc3RhcnQsIG5iaXRzKTsNCg0KDQo=
