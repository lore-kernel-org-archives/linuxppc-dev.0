Return-Path: <ARNDB@de.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0D01DDE1C
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 06:33:01 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l6KKWwD5029392
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 16:32:58 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l6KKWvUo211060
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 14:32:57 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l6KKWvXj018875
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 14:32:57 -0600
From: Arnd Bergmann <ARNDB@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] OProfile - Enable SPU switch notification to detect
	currently active SPU tasks - update
Date: Fri, 20 Jul 2007 21:58:18 +0200
References: <200707201424.07292.rrnelson@linux.vnet.ibm.com>
	<20070720130241.176c50a5.akpm@linux-foundation.org>
In-Reply-To: <20070720130241.176c50a5.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707202158.19631.ARNDB@de.ibm.com>
Cc: Maynard Johnson <maynardj@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bob Nelson <rrnelson@linux.vnet.ibm.com>,
	oprofile <oprofile-list@lists.sourceforge.net>,
	Philippe Elie <phil.el@wanadoo.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gRnJpZGF5IDIwIEp1bHkgMjAwNywgQW5kcmV3IE1vcnRvbiB3cm90ZToKPiAroKCgoKCgoGZv
cl9lYWNoX29ubGluZV9ub2RlKG5vZGUpIHsKPiCgoKCgoKCgoKCgoKCgoKCgc3RydWN0IHNwdSAq
c3B1Owo+IKCgoKCgoKCgoKCgoKCgoKBtdXRleF9sb2NrKCZzcHVfcHJpby0+YWN0aXZlX211dGV4
W25vZGVdKTsKPiCgoKCgoKCgoKCgoKCgoKCgbGlzdF9mb3JfZWFjaF9lbnRyeShzcHUsICZzcHVf
cHJpby0+YWN0aXZlX2xpc3Rbbm9kZV0sIGxpc3QpIHsKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKBzdHJ1Y3Qgc3B1X2NvbnRleHQgKmN0eCA9IHNwdS0+Y3R4Owo+IKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoHNldF9iaXQoU1BVX1NDSEVEX05PVElGWV9BQ1RJVkUsICZjdHgtPnNjaGVkX2ZsYWdz
KTsKPiAtoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBtYigpOwo+ICugoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoG1iKCk7oKCgLyogbWFrZSBzdXJlIGFueSB0YXNrcyB3b2tlbiB1cCBiZWxvdyAqLwo+ICug
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgLyogY2FuIHNlZSB0aGUgYml0KHMpIHNldCBh
Ym92ZSAqLwo+IKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoHdha2VfdXBfYWxsKCZjdHgtPnN0b3Bf
d3EpOwo+IKCgoKCgoKCgoKCgoKCgoKB9Cj4goKCgoKCgoKCgoKCgoKCgoG11dGV4X3VubG9jaygm
c3B1X3ByaW8tPmFjdGl2ZV9tdXRleFtub2RlXSk7Cj4gXwo+IAo+IEkgc3RpbGwgd29uZGVyIGFi
b3V0IHRoYXQgYmFycmllci4goEF0IHRoZSBsZWFzdCBpdCBzaG91bGQgYmUgc21wX21iKCkuIAo+
IEJ1dCBhcmVuJ3Qgb3VyIHNldF9iaXQoKSBzZW1hbnRpY3MgX2Fsb25lXyBzdWZmaWNpZW50IHRv
IG1ha2UgdGhpcyBiYXJyaWVyCj4gdW5uZWVkZWQ/CgpJIGJlbGlldmUgdGhleSBhcmUgc3VmZmlj
aWVudCBvbiBwb3dlcnBjLCBhbmQgc2hvdWxkIGJlIGV2ZXJ5d2hlcmUsIHNvCnRoZSBtYigpIGNh
biBwcm9iYWJseSBnbyBhd2F5IGVudGlyZWx5LiBzZXRfYml0KCkgZG9lcyBhIGxkYXJ4L3N0ZGN4
LAp3aGljaCBpcyBndWFyYW50ZWVkIHRvIGJlIGF0b21pYyBhY3Jvc3MgQ1BVcy4KCglBcm5kIDw+
PAo=
