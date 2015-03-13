Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7F21A0371
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 13:19:54 +1100 (AEDT)
Date: Fri, 13 Mar 2015 13:19:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv2] powerpc: comvert relocs_check to a shell script using grep
Message-ID: <20150313131949.3e9d2b11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wZ4JVJDhaZO_6TKFZwHAGg0"; protocol="application/pgp-signature"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/wZ4JVJDhaZO_6TKFZwHAGg0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This runs a bit faster and removes another use of perl from
the kernel build.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---

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
index 000000000000..182eae9cc40d
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
+if [ ${#*} -lt 2 ]; then
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

--Sig_/wZ4JVJDhaZO_6TKFZwHAGg0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVAklJAAoJEMDTa8Ir7ZwV3RUP/1Aq+Uj9Xdlzpx6RsITVktpm
QqowmVxnHA0mvTqbmmNhS4QhOUkqiuQWaYzr+7FaJ6EMiYcxjK4J6pYTRgh/oNde
UK9rvTP7Lp9m2Wyp+/r+4UN4xAxlItE5lmsBp8PI+GfxLWZJMU0319TKSEX1a+6T
CvBASBTTMEw+bDwhbySgfhBzW0tcf2I1SWfp7wYXL6wJxrUkf1y56zUadeA7qfVj
RVv6UQvHLD4UUzygW2dlp8D3opE1A+kWYwwvP0GBTQQ3Er0R1dWBDLMzzHsqSVCP
uVqKdtOMWJ/FBmI/1qOF6n/0GUuHY2qYWw4kNLxfFUfv7NMpGXH0FvtLu2CRlcaW
YoruWoJjKaX+t2u+jssbFgeIWxIF6nqj23rPpRovmThUXdayrogbl/uREWsRElKs
SmHoIIFqXhFXi2W16PC18wZaxfbEfuHNS4xofJk0CGNYvaIRDHoRJ4p0221YtCCX
04V4e3DI7hXkp18IEL3A/g/DozdaUJMzQpd50qpG4Od4zHWMKmgQciJGdfyQqO75
5DAGvoV5ebBwMUYQH7LNmlAfU9ugDYpBCe5hAQAwr6pwIgBRXBOdVC3FGemHMQrE
9UMGGRzyHeWu3vaGUentJ6U7Q8L+E9YPBE0exbYlbVODYruGGdm3lF44EZTJ1CZk
Lm9Lpg1/2S4MFATw3Z7L
=7xf1
-----END PGP SIGNATURE-----

--Sig_/wZ4JVJDhaZO_6TKFZwHAGg0--
