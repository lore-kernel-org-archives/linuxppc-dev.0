Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 063411A0097
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 18:19:23 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 13873-06 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 17 Jun 2014 09:19:12 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Arnd Bergmann' <arnd@arndb.de>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Date: Tue, 17 Jun 2014 08:18:03 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1725D868@AcuExch.aculab.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
 <4575870.N9RCpZ4UMg@wuerfel>
In-Reply-To: <4575870.N9RCpZ4UMg@wuerfel>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
 Karsten Keil <isdn@linux-pingi.de>, Peter Hurley <peter@hurleysoftware.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBPbiBNb25kYXkgMTYgSnVuZSAyMDE0IDA5OjE3OjExIFBl
dGVyIEh1cmxleSB3cm90ZToNCj4gPiB0dHlfd2FpdF91bnRpbF9zZW50X2Zyb21fY2xvc2UoKSBk
cm9wcyB0aGUgdHR5IGxvY2sgd2hpbGUgd2FpdGluZw0KPiA+IGZvciB0aGUgdHR5IGRyaXZlciB0
byBmaW5pc2ggc2VuZGluZyBwcmV2aW91c2x5IGFjY2VwdGVkIGRhdGEgKGllLiwNCj4gPiBkYXRh
IHJlbWFpbmluZyBpbiBpdHMgd3JpdGUgYnVmZmVyIGFuZCB0cmFuc21pdCBmaWZvKS4NCj4gPg0K
PiA+IEhvd2V2ZXIsIGRyb3BwaW5nIHRoZSB0dHkgbG9jayBpcyBhIGhvbGQtb3ZlciBmcm9tIHdo
ZW4gdGhlIHR0eQ0KPiA+IGxvY2sgd2FzIHN5c3RlbS13aWRlOyBpZS4sIG9uZSBsb2NrIGZvciBh
bGwgdHR5cy4NCj4gPg0KPiA+IFNpbmNlIGNvbW1pdCA4OWM4ZDkxZTMxZjI2NzcwM2UzNjU1OTNm
NmJmZWJiOWY2ZDJhZDAxLA0KPiA+ICd0dHk6IGxvY2FsaXNlIHRoZSBsb2NrJywgZHJvcHBpbmcg
dGhlIHR0eSBsb2NrIGhhcyBub3QgYmVlbiBuZWNlc3NhcnkuDQo+ID4NCj4gPiBDQzogS2Fyc3Rl
biBLZWlsIDxpc2RuQGxpbnV4LXBpbmdpLmRlPg0KPiA+IENDOiBsaW51eHBwYy1kZXZAbGlzdHMu
b3psYWJzLm9yZw0KPiA+IFNpZ25lZC1vZmYtYnk6IFBldGVyIEh1cmxleSA8cGV0ZXJAaHVybGV5
c29mdHdhcmUuY29tPg0KPiANCj4gSSBkb24ndCB1bmRlcnN0YW5kIHRoZSBzZWNvbmQgaGFsZiBv
ZiB0aGUgY2hhbmdlbG9nLCBpdCBkb2Vzbid0IHNlZW0NCj4gdG8gZml0IGhlcmU6IHRoZXJlIGRl
YWRsb2NrIHRoYXQgd2UgYXJlIHRyeWluZyB0byBhdm9pZCBoZXJlIGhhcHBlbnMNCj4gd2hlbiB0
aGUgKnNhbWUqIHR0eSBuZWVkcyB0aGUgbG9jayB0byBjb21wbGV0ZSB0aGUgZnVuY3Rpb24gdGhh
dA0KPiBzZW5kcyB0aGUgcGVuZGluZyBkYXRhLiBJIGRvbid0IHRoaW5rIHdlIGRvIHN0aWxsIGRv
IHRoYXQgYW55IG1vcmUsDQo+IGJ1dCBpdCBkb2Vzbid0IHNlZW0gcmVsYXRlZCB0byB0aGUgdHR5
IGxvY2sgYmVpbmcgc3lzdGVtLXdpZGUgb3Igbm90Lg0KDQpXaGlsZSBJJ3ZlIG5vdCBsb29rZWQg
YXQgdGhlIGNvZGUgaW4gcXVlc3Rpb247IG15IHRob3VnaHRzIHdlcmUgdGhhdA0KaG9sZGluZyBh
bnkgbG9jayB3aGlsZSB3YWl0aW5nIGZvciBvdXRwdXQgdG8gZHJhaW4gKG9yIGFueXRoaW5nIGVs
c2UNCnJlYWxseSkgcHJvYmFibHkgaXNuJ3QgYSBnb29kIGlkZWEuDQpZb3UgbWlnaHQgZmluZCB0
aGF0IHNvbWV0aGluZyBlbHNlIG5lZWRzIHRoZSBsb2NrIC0gZXZlbiBpZiBvbmx5DQpzb21lIGtp
bmQgb2Ygc3RhdHVzIHJlcXVlc3QuDQoNCglEYXZpZA0KDQo=
