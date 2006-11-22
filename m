Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id D887567C7F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Nov 2006 03:13:20 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/14] cell: abstract spu management routines
Date: Wed, 22 Nov 2006 17:13:06 +0100
References: <4563CFE7.1050108@am.sony.com>
In-Reply-To: <4563CFE7.1050108@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611221713.07284.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gV2VkbmVzZGF5IDIyIE5vdmVtYmVyIDIwMDYgMDU6MTksIEdlb2ZmIExldmFuZCB3cm90ZToK
PiArc3RhdGljIGludCBfX2luaXQgc3B1X21hcF9kZXZpY2Uoc3RydWN0IHNwdSAqc3B1LCBzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5vZGUpCj4gK3sKPiAroKCgoKCgoGludCByZXQgPSAtRU5PREVWOwo+
ICugoKCgoKCgc3B1LT5uYW1lID0gZ2V0X3Byb3BlcnR5KG5vZGUsICJuYW1lIiwgTlVMTCk7Cj4g
K6CgoKCgoKBpZiAoIXNwdS0+bmFtZSkKPiAroKCgoKCgoKCgoKCgoKCgZ290byBvdXQ7Cj4gKwo+
ICugoKCgoKCgcmV0ID0gc3B1X21hcF9yZXNvdXJjZShub2RlLCAwLCAodm9pZCBfX2lvbWVtKiop
JnNwdS0+bG9jYWxfc3RvcmUsCj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCZzcHUtPmxvY2FsX3N0b3JlX3BoeXMpOwo+ICugoKCgoKCgaWYgKHJldCkKPiAroKCgoKCg
oKCgoKCgoKCgZ290byBvdXQ7Cj4gK6CgoKCgoKByZXQgPSBzcHVfbWFwX3Jlc291cmNlKG5vZGUs
IDEsICh2b2lkIF9faW9tZW0qKikmc3B1LT5wcm9ibGVtLAo+ICugoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKAmc3B1LT5wcm9ibGVtX3BoeXMpOwo+ICugoKCgoKCgaWYgKHJl
dCkKPiAroKCgoKCgoKCgoKCgoKCgZ290byBvdXRfdW5tYXA7Cj4gK6CgoKCgoKByZXQgPSBzcHVf
bWFwX3Jlc291cmNlKG5vZGUsIDIsICh2b2lkIF9faW9tZW0qKikmc3B1LT5wcml2MiwKPiAroKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgTlVMTCk7Cj4gK6CgoKCgoKBpZiAo
cmV0KQo+ICugoKCgoKCgoKCgoKCgoKBnb3RvIG91dF91bm1hcDsKPiArCj4gK6CgoKCgoKBpZiAo
IWZpcm13YXJlX2hhc19mZWF0dXJlKEZXX0ZFQVRVUkVfTFBBUikpCj4gK6CgoKCgoKCgoKCgoKCg
oHJldCA9IHNwdV9tYXBfcmVzb3VyY2Uobm9kZSwgMywKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKAodm9pZCBfX2lvbWVtKiopJnNwdV9nZXRfcGRhdGEoc3B1KS0+cHJpdjEsIE5VTEwpOwo+ICug
oKCgoKCgaWYgKHJldCkKPiAroKCgoKCgoKCgoKCgoKCgZ290byBvdXRfdW5tYXA7Cj4gK6CgoKCg
oKByZXR1cm4gMDsKCkkganVzdCBub3RpY2VkIHRoYXQgeW91IG1vdmVkIHRoaXMgY29kZSB3aGls
ZSBpdCBjaGFuZ2VkIGVsc2V3aGVyZSwgYW5kCnlvdSBtaXNzZWQgYSBidWcgZml4IHRoYXQgYmVu
aCBkaWQuIEknbGwgc2VuZCBhIGZpeGVkIHZlcnNpb24uCgpUaGUgc2FtZSBodW5rIGFsc28gY3Jl
YXRlcyBhIG1lcmdlIGNvbmZsaWN0IGJldHdlZW4gdGhlIG1hc3RlciBhbmQKZm9yLTIuNi4yMCBi
cmFuY2hlcyBvZiBwb3dlcnBjLmdpdC4KCglBcm5kIDw+PAo=
