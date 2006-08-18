Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 80A0B679E7
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Aug 2006 09:09:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
Date: Sat, 19 Aug 2006 01:09:13 +0200
References: <20060818220700.GG26889@austin.ibm.com>
	<20060818222146.GI26889@austin.ibm.com>
In-Reply-To: <20060818222146.GI26889@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608190109.15129.arnd@arndb.de>
Cc: akpm@osdl.org, James K Lewis <jklewis@us.ibm.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jeff Garzik <jgarzik@pobox.com>, ens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gU2F0dXJkYXkgMTkgQXVndXN0IDIwMDYgMDA6MjEsIExpbmFzIFZlcHN0YXMgd3JvdGU6Cj4g
K6CgoKCgoKAvKiBNZWFzdXJlIHRoZSBsZW5ndGggb2YgdGhlIHF1ZXVlLiAqLwo+ICugoKCgoKCg
d2hpbGUgKGRlc2NyICE9IGNhcmQtPnR4X2NoYWluLmhlYWQpIHsKPiAroKCgoKCgoKCgoKCgoKCg
c3RhdHVzID0gZGVzY3ItPmRtYWNfY21kX3N0YXR1cyAmIFNQSURFUl9ORVRfREVTQ1JfTk9UX0lO
X1VTRTsKPiAroKCgoKCgoKCgoKCgoKCgaWYgKHN0YXR1cyA9PSBTUElERVJfTkVUX0RFU0NSX05P
VF9JTl9VU0UpCj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgYnJlYWs7Cj4gK6CgoKCgoKCgoKCg
oKCgoGRlc2NyID0gZGVzY3ItPm5leHQ7Cj4gK6CgoKCgoKCgoKCgoKCgoGNudCsrOwo+ICugoKCg
oKCgfQo+ICugoKCgoKCgaWYgKGNudCA9PSAwKQo+ICugoKCgoKCgoKCgoKCgoKByZXR1cm47Cj4g
Kwo+ICugoKCgoKCgLyogU2V0IGxvdy13YXRlcm1hcmsgMy80dGgncyBvZiB0aGUgd2F5IGludG8g
dGhlIHF1ZXVlLiAqLwo+ICugoKCgoKCgZGVzY3IgPSBjYXJkLT50eF9jaGFpbi50YWlsOwo+ICug
oKCgoKCgY250ID0gKGNudCozKS80Owo+ICugoKCgoKCgZm9yIChpPTA7aTxjbnQ7IGkrKykKPiAr
oKCgoKCgoKCgoKCgoKCgZGVzY3IgPSBkZXNjci0+bmV4dDsKCkkgd29uZGVyIGlmIGNhbGxpbmcg
dGhpcyBmcmVxdWVudGx5IHJlc3VsdHMgaW4gYSBzaWduaWZpY2FudCBwcm9jZXNzaW5nCm92ZXJo
ZWFkIGluIHRoZSBDUFUuIERvZXMgdGhlIHNwaWRlcl9uZXRfc2V0X2xvd193YXRlcm1hcmsgZnVu
Y3Rpb24Kc2hvdyB1cCBpbiB5b3VyIHByb2ZpbGVzPwoKQSBtb3JlIGVmZmljaWVudCBpbXBsZW1l
bnRhdGlvbiBtaWdodCBiZSB0byBtYXJrIG9uZSBkZXNjcmlwdG9yIHRoYXQKaXMgYXQgYSBmaXhl
ZCBvZmZzZXQgZnJvbSB0aGUgVFggcXVldWUgdGFpbCwgc28gd2Ugb25seSBuZWVkIHRvIGRvCgpj
YXJkLT5sb3dfd2F0ZXJtYXJrLT5uZXh0LT5kbWFjX2NtZF9zdGF0dXMgfD0gU1BJREVSX05FVF9E
RVNDUl9UWERFU0ZMRzsKbWIoKTsKY2FyZC0+bG93X3dhdGVybWFyay0+ZG1hY19jbWRfc3RhdHVz
ICY9IH5TUElERVJfTkVUX0RFU0NSX1RYREVTRkxHOwpjYXJkLT5sb3dfd2F0ZXJtYXJrID0gY2Fy
ZC0+bG93X3dhdGVybWFyay0+bmV4dDsKCndoZW4gd2UgcXVldWUgYW5vdGhlciBmcmFtZSBmb3Ig
VFguCgoJQXJuZCA8PjwK
