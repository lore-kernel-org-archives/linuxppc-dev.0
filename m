Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 253351A0296
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jun 2014 21:05:04 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 14906-09 for <linuxppc-dev@lists.ozlabs.org>;
 Tue, 17 Jun 2014 12:04:53 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Peter Hurley' <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH tty-next 14/22] tty: Remove
 tty_wait_until_sent_from_close()
Date: Tue, 17 Jun 2014 11:03:50 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1725DAF6@AcuExch.aculab.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
 <1402924639-5164-15-git-send-email-peter@hurleysoftware.com>
 <4575870.N9RCpZ4UMg@wuerfel> <53A01F02.7000202@hurleysoftware.com>
In-Reply-To: <53A01F02.7000202@hurleysoftware.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Karsten Keil <isdn@linux-pingi.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
 One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

RnJvbTogUGV0ZXIgSHVybGV5DQouLi4NCj4gPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIHNlY29u
ZCBoYWxmIG9mIHRoZSBjaGFuZ2Vsb2csIGl0IGRvZXNuJ3Qgc2VlbQ0KPiA+IHRvIGZpdCBoZXJl
OiB0aGVyZSBkZWFkbG9jayB0aGF0IHdlIGFyZSB0cnlpbmcgdG8gYXZvaWQgaGVyZSBoYXBwZW5z
DQo+ID4gd2hlbiB0aGUgKnNhbWUqIHR0eSBuZWVkcyB0aGUgbG9jayB0byBjb21wbGV0ZSB0aGUg
ZnVuY3Rpb24gdGhhdA0KPiA+IHNlbmRzIHRoZSBwZW5kaW5nIGRhdGEuIEkgZG9uJ3QgdGhpbmsg
d2UgZG8gc3RpbGwgZG8gdGhhdCBhbnkgbW9yZSwNCj4gPiBidXQgaXQgZG9lc24ndCBzZWVtIHJl
bGF0ZWQgdG8gdGhlIHR0eSBsb2NrIGJlaW5nIHN5c3RlbS13aWRlIG9yIG5vdC4NCj4gDQo+IFRo
ZSB0dHkgbG9jayBpcyBub3QgdXNlZCBpbiB0aGUgaS9vIHBhdGg7IGl0J3MgcHVycG9zZSBpcyB0
bw0KPiBtdXR1YWxseSBleGNsdWRlIHN0YXRlIGNoYW5nZXMgaW4gb3BlbigpLCBjbG9zZSgpIGFu
ZCBoYW5ndXAoKS4NCj4gDQo+IFRoZSBjb21taXQgdGhhdCBhZGRlZCB0aGlzIFsxXSBjb21tZW50
cyB0aGF0IF9vdGhlcl8gdHR5cyBtYXkgd2FpdA0KPiBmb3IgdGhpcyB0dHkgdG8gY29tcGxldGUs
IGFuZCBjb21tZW50cyBpbiB0aGUgY29kZSBub3RlIHRoYXQgdGhpcw0KPiBmdW5jdGlvbiBzaG91
bGQgYmUgcmVtb3ZlZCB3aGVuIHRoZSBzeXN0ZW0td2lkZSB0dHkgbXV0ZXggd2FzIHJlbW92ZWQN
Cj4gKHdoaWNoIGhhcHBlbmVkIHdpdGggdGhlIGNvbW1pdCBub3RlZCBpbiB0aGUgY2hhbmdlbG9n
KS4NCg0KV2hhdCBoYXBwZW5zIGlmIGFub3RoZXIgcHJvY2VzcyB0cmllcyB0byBkbyBhIG5vbi1i
bG9ja2luZyBvcGVuDQp3aGlsZSB5b3UgYXJlIHNsZWVwaW5nIGluIGNsb3NlIHdhaXRpbmcgZm9y
IG91dHB1dCB0byBkcmFpbj8NCg0KSG9wZWZ1bGx5IHRoaXMgcmV0dXJucyBiZWZvcmUgdGhhdCBk
YXRhIGhhcyBkcmFpbmVkLg0KDQoJRGF2aWQNCg0K
