Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 24F54DDE0E
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 14:02:40 +1000 (EST)
Date: Tue, 23 Oct 2007 14:02:31 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Problems with allyesconfig kernel build
Message-Id: <20071023140231.12698d1c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__23_Oct_2007_14_02_31_+1000_NQX+HRNt=efG9DJ5"
Cc: Andrew Morton <akpm@linux-foundation.org>, amodra@bigpond.net.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__23_Oct_2007_14_02_31_+1000_NQX+HRNt=efG9DJ5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

This was first noted with the -mm tree, but has now migrated into Linus'
tree.  An allyesconfig build dies in the link stage like this:

/usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x80c8): sibling call opti=
mization to `.text.init.refok' does not allow automatic multiple TOCs; reco=
mpile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.ini=
t.refok' extern
/usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x8160): sibling call opti=
mization to `.text.init.refok' does not allow automatic multiple TOCs; reco=
mpile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.ini=
t.refok' extern
/usr/bin/ld: arch/powerpc/kernel/head_64.o(.text+0x81c4): sibling call opti=
mization to `.text.init.refok' does not allow automatic multiple TOCs; reco=
mpile with -mminimal-toc or -fno-optimize-sibling-calls, or make `.text.ini=
t.refok' extern
/usr/bin/ld: final link failed: Bad value

We already compile with -mminimal-toc and adding
-fno-optimize-sibling-call did not help.

Intuiting the obvious, I changed all the _INIT_STATIC and _INIT_GLOBAL
uses in head_64.S back to _STATIC and _GLOBAL (which just moves the code
from .text.init.refok to .text).  Now the linker segfaults instead.  :-)

/bin/sh: line 1:  5260 Segmentation fault      ld -m elf64ppc -Bstatic --em=
it-relocs --build-id -o .tmp_vmlinux1 -T arch/powerpc/kernel/vmlinux.lds ar=
ch/powerpc/kernel/head_64.o arch/powerpc/kernel/entry_64.o arch/powerpc/ker=
nel/fpu.o init/built-in.o --start-group usr/built-in.o arch/powerpc/kernel/=
built-in.o arch/powerpc/mm/built-in.o arch/powerpc/lib/built-in.o arch/powe=
rpc/sysdev/built-in.o arch/powerpc/platforms/built-in.o arch/powerpc/xmon/b=
uilt-in.o kernel/built-in.o mm/built-in.o fs/built-in.o ipc/built-in.o secu=
rity/built-in.o crypto/built-in.o block/built-in.o lib/lib.a lib/built-in.o=
 drivers/built-in.o sound/built-in.o arch/powerpc/oprofile/built-in.o net/b=
uilt-in.o --end-group
make[1]: *** [.tmp_vmlinux1] Error 139

$ ld --version
GNU ld (GNU Binutils for Debian) 2.18

I take this as an improvement :-)

We link .text.init.refok immediately after .text, but with
allyesconfig, .text ends up very large.

The --emit-relocs is a product of something else I am working on.  So I
took that out and now get a whole lot more messages like:

/usr/bin/ld: net/built-in.o(.fixup+0x4): sibling call optimization to `.tex=
t' does not allow automatic multiple TOCs; recompile with -mminimal-toc or =
-fno-optimize-sibling-calls, or make `.text' extern
/usr/bin/ld: net/built-in.o(.fixup+0xc): sibling call optimization to `.tex=
t' does not allow automatic multiple TOCs; recompile with -mminimal-toc or =
-fno-optimize-sibling-calls, or make `.text' extern

Anyone have any ideas?
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__23_Oct_2007_14_02_31_+1000_NQX+HRNt=efG9DJ5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHXJdTgG2atn1QN8RAiDSAJwIOTEub72EVPz1TIX9OfPo3zcHAgCglSHH
lW/rhvxIISs2tLkKngaZROU=
=cJKH
-----END PGP SIGNATURE-----

--Signature=_Tue__23_Oct_2007_14_02_31_+1000_NQX+HRNt=efG9DJ5--
