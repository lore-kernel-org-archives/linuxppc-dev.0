Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 81D1D1A0010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Mar 2015 16:46:21 +1100 (AEDT)
Date: Wed, 18 Mar 2015 16:46:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv4] powerpc: comvert relocs_check to a shell script using grep
Message-ID: <20150318164616.42a1cc93@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ngD+ZH_R3Tmgt8dnNi7q+8t"; protocol="application/pgp-signature"
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

--Sig_/ngD+ZH_R3Tmgt8dnNi7q+8t
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This runs a bit faster and removes another use of perl from
the kernel build.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
v4: don't do checks on $objdump or $vmlinux as it will become pretty
    obvious if they are not the correct things (Michael)
v3: use $# instead of ${#*} (thanks David Laight)
    also added check on vmlinux and objdump
v2: address ShellCheck comments from Michael

 arch/powerpc/Makefile        |  4 +--
 arch/powerpc/relocs_check.pl | 66 ----------------------------------------=
----
 arch/powerpc/relocs_check.sh | 59 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 68 deletions(-)
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
index 000000000000..2e4ebd0e25b3
--- /dev/null
+++ b/arch/powerpc/relocs_check.sh
@@ -0,0 +1,59 @@
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

--Sig_/ngD+ZH_R3Tmgt8dnNi7q+8t
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVCREtAAoJEMDTa8Ir7ZwVOVkP/1cnlc+4JKcbKT9ujkSvMCRd
gIL4M+S8Z25L4johWWCEwOgQ3/XkX9+EtdW0dheYvZhjZOt6z8Rw2USOlkouYk5k
2R5Ih+HGaXVJHdERGQzOjvX1+V6pTmYgMvsxs4zHl3Iyb7BtfvfiDIsYg99PNxvp
7YIi2BsKL/lDZpyzWZh+G67mj0h5c+f3mlGrF0SVua3H5RVIykH+FzqKp3+yO0N4
Nvq5s0c527TasJ/PtfecD5/di470TUjm0pIVB9YqKJkMgpQCvxUzL19ACDxSgdQW
1lIAUepJJvSdAnFWHoINmV+ciUSmWkRM6KqYxP5QHElxOSKRTPoZtRY+vE9msd6D
KsqxtgSTd+zePa1mUUFrwemUHIssDSiBhbKQAQIpJi0y4r188dHtKQdPVugG6Zx4
BO+4WLo0VJpmA+ofh9YxrjyJ7XWTGNMg3dzXZRRIshV7U1hTIugrtlW17PA1fCGQ
HjE3+1p2sn3tiHo5WG+8MGWFlGkFNFNNZdp4Zmt8W+NPUTOOaZwspENtJAeF3E1A
ZXVmUz+vuojMHlOgyJ3E2TO8MQrOzyczogQ/7gcv7x0v87Pk/MpC5SVWvXdN6Zrs
HECE0H9dilL8fjJhdebXXhpHyP8WTiy+/KgmXLCRLEHHNFgM9NSa8/4j1UAhJ5En
u1fq3NorDI0iKoQYKC2X
=UV98
-----END PGP SIGNATURE-----

--Sig_/ngD+ZH_R3Tmgt8dnNi7q+8t--
