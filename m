Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 08D431A03BD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Mar 2015 22:08:55 +1100 (AEDT)
Date: Sun, 15 Mar 2015 22:08:47 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv3] powerpc: convert relocs_check to a shell script using grep
Message-ID: <20150315220847.1ecfe174@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/g.=81wo1Wgt/W=xTLWWFeFS"; protocol="application/pgp-signature"
Cc: linuxppc-dev@lists.ozlabs.org, David Laight <David.Laight@ACULAB.COM>,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/g.=81wo1Wgt/W=xTLWWFeFS
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This runs a bit faster and removes another use of perl from
the kernel build.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

v3: use $# instead of ${#*} (thanks David Laight)
    also added check on vmlinux and objdump
v2: address ShellCheck comments from Michael

 arch/powerpc/Makefile        |  4 +--
 arch/powerpc/relocs_check.pl | 66 ----------------------------------------=
--
 arch/powerpc/relocs_check.sh | 68 ++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 70 insertions(+), 68 deletions(-)
 delete mode 100755 arch/powerpc/relocs_check.pl
 create mode 100755 arch/powerpc/relocs_check.sh

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 132d9c681d6a..1e868023b2c3 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -248,10 +248,10 @@ boot :=3D arch/$(ARCH)/boot
=20
 ifeq ($(CONFIG_RELOCATABLE),y)
 quiet_cmd_relocs_check =3D CALL    $<
-      cmd_relocs_check =3D perl $< "$(OBJDUMP)" "$(obj)/vmlinux"
+      cmd_relocs_check =3D $(CONFIG_SHELL) $< "$(OBJDUMP)" "$(obj)/vmlinux"
=20
 PHONY +=3D relocs_check
-relocs_check: arch/powerpc/relocs_check.pl vmlinux
+relocs_check: arch/powerpc/relocs_check.sh vmlinux
 	$(call cmd,relocs_check)
=20
 zImage: relocs_check
diff --git a/arch/powerpc/relocs_check.pl b/arch/powerpc/relocs_check.pl
deleted file mode 100755
index 3f46e8b9c56d..000000000000
--- a/arch/powerpc/relocs_check.pl
+++ /dev/null
@@ -1,66 +0,0 @@
-#!/usr/bin/perl
-
-# Copyright =C2=A9 2009 IBM Corporation
-
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; either version
-# 2 of the License, or (at your option) any later version.
-
-# This script checks the relocations of a vmlinux for "suspicious"
-# relocations.
-
-use strict;
-use warnings;
-
-if ($#ARGV !=3D 1) {
-	die "$0 [path to objdump] [path to vmlinux]\n";
-}
-
-# Have Kbuild supply the path to objdump so we handle cross compilation.
-my $objdump =3D shift;
-my $vmlinux =3D shift;
-my $bad_relocs_count =3D 0;
-my $bad_relocs =3D "";
-my $old_binutils =3D 0;
-
-open(FD, "$objdump -R $vmlinux|") or die;
-while (<FD>) {
-	study $_;
-
-	# Only look at relocation lines.
-	next if (!/\s+R_/);
-
-	# These relocations are okay
-	# On PPC64:
-	# 	R_PPC64_RELATIVE, R_PPC64_NONE, R_PPC64_ADDR64
-	# On PPC:
-	# 	R_PPC_RELATIVE, R_PPC_ADDR16_HI,=20
-	# 	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
-	# 	R_PPC_NONE
-
-	next if (/\bR_PPC64_RELATIVE\b/ or /\bR_PPC64_NONE\b/ or
-	         /\bR_PPC64_ADDR64\s+mach_/);
-	next if (/\bR_PPC_ADDR16_LO\b/ or /\bR_PPC_ADDR16_HI\b/ or
-		 /\bR_PPC_ADDR16_HA\b/ or /\bR_PPC_RELATIVE\b/ or
-		 /\bR_PPC_NONE\b/);
-
-	# If we see this type of relocation it's an idication that
-	# we /may/ be using an old version of binutils.
-	if (/R_PPC64_UADDR64/) {
-		$old_binutils++;
-	}
-
-	$bad_relocs_count++;
-	$bad_relocs .=3D $_;
-}
-
-if ($bad_relocs_count) {
-	print "WARNING: $bad_relocs_count bad relocations\n";
-	print $bad_relocs;
-}
-
-if ($old_binutils) {
-	print "WARNING: You need at least binutils >=3D 2.19 to build a ".
-	      "CONFIG_RELOCATABLE kernel\n";
-}
diff --git a/arch/powerpc/relocs_check.sh b/arch/powerpc/relocs_check.sh
new file mode 100755
index 000000000000..bdc5cc639569
--- /dev/null
+++ b/arch/powerpc/relocs_check.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+# Copyright =C2=A9 2015 IBM Corporation
+
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version
+# 2 of the License, or (at your option) any later version.
+
+# This script checks the relocations of a vmlinux for "suspicious"
+# relocations.
+
+# based on relocs_check.pl
+# Copyright =C2=A9 2009 IBM Corporation
+
+if [ $# -lt 2 ]; then
+	echo "$0 [path to objdump] [path to vmlinux]" 1>&2
+	exit 1
+fi
+
+# Have Kbuild supply the path to objdump so we handle cross compilation.
+objdump=3D"$1"
+vmlinux=3D"$2"
+
+if [ ! -x "$objdump" ]; then
+	echo "$0: objdump ($objdump) is not executable" 1>&2
+	exit 1
+fi
+if [ ! -r "$vmlinux" ]; then
+	echo "$0: vmlinux ($vmlinux) is not readable" 1>&2
+	exit 1
+fi
+
+bad_relocs=3D$(
+"$objdump" -R "$vmlinux" |
+	# Only look at relocation lines.
+	grep -E '\<R_' |
+	# These relocations are okay
+	# On PPC64:
+	#	R_PPC64_RELATIVE, R_PPC64_NONE
+	#	R_PPC64_ADDR64 mach_<name>
+	# On PPC:
+	#	R_PPC_RELATIVE, R_PPC_ADDR16_HI,
+	#	R_PPC_ADDR16_HA,R_PPC_ADDR16_LO,
+	#	R_PPC_NONE
+	grep -F -w -v 'R_PPC64_RELATIVE
+R_PPC64_NONE
+R_PPC_ADDR16_LO
+R_PPC_ADDR16_HI
+R_PPC_ADDR16_HA
+R_PPC_RELATIVE
+R_PPC_NONE' |
+	grep -E -v '\<R_PPC64_ADDR64[[:space:]]+mach_'
+)
+
+if [ -z "$bad_relocs" ]; then
+	exit 0
+fi
+
+num_bad=3D$(echo "$bad_relocs" | wc -l)
+echo "WARNING: $num_bad bad relocations"
+echo "$bad_relocs"
+
+# If we see this type of relocation it's an idication that
+# we /may/ be using an old version of binutils.
+if echo "$bad_relocs" | grep -q -F -w R_PPC64_UADDR64; then
+	echo "WARNING: You need at least binutils >=3D 2.19 to build a CONFIG_REL=
OCATABLE kernel"
+fi
--=20
2.1.4

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/g.=81wo1Wgt/W=xTLWWFeFS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVBWhFAAoJEMDTa8Ir7ZwV67kP/RNglZe4Djh2QVDR89BLctGg
FzRUMKVZHoIirKkMzEkcV3tzV3P0xWYQJbgPRfablWNryyzduNp0nVTKW3MAm192
ou2ALNIHa6Hhz+ukWzyAKQVDaqXzCkcWF5WTvhpNlsHSMQ7oZo8JMRT/qJrC4mmV
62C/izQIW4UvX2EHT9p1lK7gL20cj+/Ljc2fEhZqGmBbO3fDrB+5psjuaFtHuLn9
j7P9Mn1jRZ+t8wI8A2ZTgGSjQ15AmhFtgjurzYFhaQXaXYvSayIyLBgkyg97+bMl
z1kq68/y7KRE6z2Uq/ect2Jbl/EenLn2auLgLBa8Vu7SkqZN3J4XMTaWcORebMkw
nveblxXiEpxbI9L6KJ6a97YXF3nxTd19KZL2bDhEiuq1Bx7b/DrS09rsV9BhbG9c
Lv9vO4DUvOiRC2Udk0gtcHYMlD09VYVprxsZJVUzbkXx/BOtUmfcG1Pam7SWmDPL
8VsniFUv5yfpVLzMDtaYGJK7/S3Z7tHTeU0x63h5qdks/lpPSw2QnJNm2P8gvG0L
GfhzDPXWujEgcnQC3R0pUDIM+7SrAbmmJwXnMDokMP5r/P/d6Xz1K+RAMpb2nP/d
+pzBx1CABCm+jKQBSzoDUV0/BADEKFvkuS1CSzZ1zRT00Irs+m7flRaPFi+DquwB
EZahKKmQXAr8ZDG2lmGX
=OX6z
-----END PGP SIGNATURE-----

--Sig_/g.=81wo1Wgt/W=xTLWWFeFS--
