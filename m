Return-Path: <evilninja@gmx.net>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id EA13D67A64
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Apr 2005 11:52:00 +1000 (EST)
Message-ID: <42509DB9.4090609@gmx.net>
Date: Mon, 04 Apr 2005 03:51:53 +0200
From: Christian <evilninja@gmx.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
References: <423B788F.7040705@kegel.com>
In-Reply-To: <423B788F.7040705@kegel.com>
Content-Type: multipart/mixed; boundary="------------070009010908090506050501"
Cc: Dan Kegel <dank@kegel.com>
Subject: Re: gcc4 compile fixes
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070009010908090506050501
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Dan Kegel wrote:
> Howdy all.  I'm trying to bring up gcc-4.0 toolchains
> using the headers from linux-2.6.11.3, and as a sanity
> check, I'm trying to build ppc750 and ppc970 kernels, too.

i have tried with vanilla 2.6.11.6 now and compiling for ppc604 still
fails with the errors you described. they go away with your suggested
fixes (only had to modify the linenumbers, diff attached, apply with -p0)

oh, not that the kernel compiles now - it seems it just overcame a build
error out of many :->

now it [1] fails with:

In file included from arch/ppc/kernel/time.c:68:
include/asm/time.h:61: warning: type qualifiers ignored on function return
type
arch/ppc/kernel/time.c:92: error: static declaration of 'time_offset'
follows non-static declaration
include/linux/timex.h:236: error: previous declaration of 'time_offset'
was here
make[1]: *** [arch/ppc/kernel/time.o] Error 1
make: *** [arch/ppc/kernel] Error 2

thank you,
Christian.

[1] building a ppc604(PReP) kernel on i386:
powerpc-604-linux-gnu-gcc (GCC) 4.0.0 20050305 (prerelease)
GNU ld version 2.15
  Supported emulations:
   elf32ppclinux
   elf32ppc
   elf32ppcsim
- --
BOFH excuse #345:

Having to manually track the satellite.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCUJ25C/PVm5+NVoYRArBVAKDU+Zbg2dYxXksrN7eK5jpx+kzmpgCdGgHY
kxED/GRoU4+1c/NrrGXn4D8=
=hn4d
-----END PGP SIGNATURE-----

--------------070009010908090506050501
Content-Type: text/plain;
 name="2.6.11.6.gcc4_compile_fixes.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="2.6.11.6.gcc4_compile_fixes.diff"

LS0tIGluY2x1ZGUvYXNtLXBwYzY0L3BhY2EuaC5vcmlnCTIwMDUtMDQtMDQgMDM6Mzk6NDgu
NTc2OTUxNDY1ICswMjAwCisrKyBpbmNsdWRlL2FzbS1wcGM2NC9wYWNhLmgJMjAwNS0wNC0w
NCAwMzo0MjoxNy45NzAwOTA1NDkgKzAyMDAKQEAgLTIyLDcgKzIyLDYgQEAKICNpbmNsdWRl
CTxhc20vaVNlcmllcy9JdExwUmVnU2F2ZS5oPgogI2luY2x1ZGUJPGFzbS9tbXUuaD4KIAot
ZXh0ZXJuIHN0cnVjdCBwYWNhX3N0cnVjdCBwYWNhW107CiByZWdpc3RlciBzdHJ1Y3QgcGFj
YV9zdHJ1Y3QgKmxvY2FsX3BhY2EgYXNtKCJyMTMiKTsKICNkZWZpbmUgZ2V0X3BhY2EoKQls
b2NhbF9wYWNhCiAKQEAgLTExNSw0ICsxMTQsNiBAQAogI2VuZGlmCiB9OwogCitleHRlcm4g
c3RydWN0IHBhY2Ffc3RydWN0IHBhY2FbXTsKKwogI2VuZGlmIC8qIF9QUEM2NF9QQUNBX0gg
Ki8KLS0tIGluY2x1ZGUvYXNtLW02OGsvc2V0dXAuaC5vcmlnCTIwMDUtMDQtMDQgMDM6Mzg6
MzQuMjQ5MzUwMTYwICswMjAwCisrKyBpbmNsdWRlL2FzbS1tNjhrL3NldHVwLmgJMjAwNS0w
NC0wNCAwMzozOTozMy45NDUyMTEwNzggKzAyMDAKQEAgLTM2MiwxMiArMzYyLDEzIEBACiAj
aWZuZGVmIF9fQVNTRU1CTFlfXwogZXh0ZXJuIGludCBtNjhrX251bV9tZW1vcnk7CQkvKiAj
IG9mIG1lbW9yeSBibG9ja3MgZm91bmQgKGFuZCB1c2VkKSAqLwogZXh0ZXJuIGludCBtNjhr
X3JlYWxudW1fbWVtb3J5OwkJLyogcmVhbCAjIG9mIG1lbW9yeSBibG9ja3MgZm91bmQgKi8K
LWV4dGVybiBzdHJ1Y3QgbWVtX2luZm8gbTY4a19tZW1vcnlbTlVNX01FTUlORk9dOy8qIG1l
bW9yeSBkZXNjcmlwdGlvbiAqLwogCiBzdHJ1Y3QgbWVtX2luZm8gewogCXVuc2lnbmVkIGxv
bmcgYWRkcjsJCS8qIHBoeXNpY2FsIGFkZHJlc3Mgb2YgbWVtb3J5IGNodW5rICovCiAJdW5z
aWduZWQgbG9uZyBzaXplOwkJLyogbGVuZ3RoIG9mIG1lbW9yeSBjaHVuayAoaW4gYnl0ZXMp
ICovCiB9OworCitleHRlcm4gc3RydWN0IG1lbV9pbmZvIG02OGtfbWVtb3J5W05VTV9NRU1J
TkZPXTsgLyogbWVtb3J5IGRlc2NyaXB0aW9uICovCiAjZW5kaWYKIAogI2VuZGlmIC8qIF9f
S0VSTkVMX18gKi8K
--------------070009010908090506050501--
