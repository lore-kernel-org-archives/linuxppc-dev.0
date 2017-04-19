Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Fyk66BwzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 18:48:30 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: "'Naveen N. Rao'" <naveen.n.rao@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH v2 1/5] kprobes: convert kprobe_lookup_name() to a function
Date: Wed, 19 Apr 2017 08:48:22 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DCFFD4D95@AcuExch.aculab.com>
References: <cover.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <2780c632bc2c6e39f27920f8cc98e17430189e27.1491991939.git.naveen.n.rao@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFD3C07@AcuExch.aculab.com>
 <1492589122.ncy876vm18.astroid@naverao1-tp.none>
In-Reply-To: <1492589122.ncy876vm18.astroid@naverao1-tp.none>
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

RnJvbTogTmF2ZWVuIE4uIFJhbw0KPiBTZW50OiAxOSBBcHJpbCAyMDE3IDA5OjA5DQo+IFRvOiBE
YXZpZCBMYWlnaHQ7IE1pY2hhZWwgRWxsZXJtYW4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBNYXNhbWkgSGlyYW1hdHN1
OyBJbmdvIE1vbG5hcg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHYyIDEvNV0ga3Byb2JlczogY29u
dmVydCBrcHJvYmVfbG9va3VwX25hbWUoKSB0byBhIGZ1bmN0aW9uDQo+IA0KPiBFeGNlcnB0cyBm
cm9tIERhdmlkIExhaWdodCdzIG1lc3NhZ2Ugb2YgQXByaWwgMTgsIDIwMTcgMTg6MjI6DQo+ID4g
RnJvbTogTmF2ZWVuIE4uIFJhbw0KPiA+PiBTZW50OiAxMiBBcHJpbCAyMDE3IDExOjU4DQo+ID4g
Li4uDQo+ID4+ICtrcHJvYmVfb3Bjb2RlX3QgKmtwcm9iZV9sb29rdXBfbmFtZShjb25zdCBjaGFy
ICpuYW1lKQ0KPiA+PiArew0KPiA+IC4uLg0KPiA+PiArCWNoYXIgZG90X25hbWVbTU9EVUxFX05B
TUVfTEVOICsgMSArIEtTWU1fTkFNRV9MRU5dOw0KPiA+PiArCWNvbnN0IGNoYXIgKm1vZHN5bTsN
Cj4gPj4gKwlib29sIGRvdF9hcHBlbmRlZCA9IGZhbHNlOw0KPiA+PiArCWlmICgobW9kc3ltID0g
c3RyY2hyKG5hbWUsICc6JykpICE9IE5VTEwpIHsNCj4gPj4gKwkJbW9kc3ltKys7DQo+ID4+ICsJ
CWlmICgqbW9kc3ltICE9ICdcMCcgJiYgKm1vZHN5bSAhPSAnLicpIHsNCj4gPj4gKwkJCS8qIENv
bnZlcnQgdG8gPG1vZHVsZTouc3ltYm9sPiAqLw0KPiA+PiArCQkJc3RybmNweShkb3RfbmFtZSwg
bmFtZSwgbW9kc3ltIC0gbmFtZSk7DQo+ID4+ICsJCQlkb3RfbmFtZVttb2RzeW0gLSBuYW1lXSA9
ICcuJzsNCj4gPj4gKwkJCWRvdF9uYW1lW21vZHN5bSAtIG5hbWUgKyAxXSA9ICdcMCc7DQo+ID4+
ICsJCQlzdHJuY2F0KGRvdF9uYW1lLCBtb2RzeW0sDQo+ID4+ICsJCQkJc2l6ZW9mKGRvdF9uYW1l
KSAtIChtb2RzeW0gLSBuYW1lKSAtIDIpOw0KPiA+PiArCQkJZG90X2FwcGVuZGVkID0gdHJ1ZTsN
Cj4gPg0KPiA+IElmIHRoZSAnOicgaXMgJ2Egd2F5IGRvd24nIG5hbWVbXSB0aGVuIGFsdGhvdWdo
IHRoZSBzdHJuY3B5KCkgd29uJ3QNCj4gPiBvdmVycnVuIGRvdF9uYW1lW10gdGhlIHJlc3Qgb2Yg
dGhlIGNvZGUgY2FuLg0KPiANCj4gTmljZSBjYXRjaCwgdGhhbmtzIERhdmlkIQ0KPiBXZSBuZWVk
IHRvIGJlIHZhbGlkYXRpbmcgdGhlIGxlbmd0aCBvZiAnbmFtZScuIEknbGwgcHV0IG91dCBhIHBh
dGNoIGZvcg0KPiB0aGF0Lg0KDQpTaWxlbnQgdHJ1bmNhdGlvbiBpcyBhbG1vc3QgY2VydGFpbmx5
IHdyb25nIGhlcmUuDQoNCj4gQXMgYW4gYXNpZGUsIEknbSBub3Qgc3VyZSBJIGZvbGxvdyB3aGF0
IHlvdSBtZWFuIHdoZW4geW91IHNheSB0aGF0IHRoZQ0KPiBzdHJuY3B5KCkgd29uJ3Qgb3ZlcnJ1
biBkb3RfbmFtZVtdLiBJZiB3ZSBoYXZlIGEgbmFtZVtdIGxvbmdlciB0aGFuDQo+IHNpemVvZihk
b3RfbmFtZSkgd2l0aCB0aGUgJzonIGFmdGVyIHRoYXQsIHRoZSBzdHJuY3B5KCkgY2FuIGFsc28g
b3ZlcnJ1bg0KPiBkb3RfbmFtZVtdLg0KDQpZZXMsIHRoYXQgc2hvdWxkIGp1c3QgYmUgYSBtZW1j
cHkoKSwgYXMgc2hvdWxkIHRoZSBzdHJuY2F0KCkuDQoNClVzaW5nIHN0cm5jcHkoKSB3aGVyZSB0
aGUgbGVuZ3RoIGlzIG90aGVyIHRoYW4gdGhlIHNpemUgb2YgdGhlIHRhcmdldCBidWZmZXINCnNo
b3VsZCBiZSBiYW5uZWQuIE5vdCB0aGF0IGl0IGV2ZXIgZG9lcyB3aGF0IHBlb3BsZSBleHBlY3Qu
DQpzdHJuY2F0KCkgaXMgZXZlbiB3b3JzZS4NCg0KCURhdmlkDQoNCg0KDQoNCg==
