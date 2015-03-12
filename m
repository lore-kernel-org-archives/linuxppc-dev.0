Return-Path: <sfr@canb.auug.org.au>
Received: from pide.tip.net.au (pide.tip.net.au [IPv6:2401:fc00:0:107::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 859E51A0196
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Mar 2015 15:10:20 +1100 (AEDT)
Date: Thu, 12 Mar 2015 15:10:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: comvert relocs_check to a shell script using grep
Message-ID: <20150312151009.18077d0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2SF1h=8P.u7r8cvyec_ITW6"; protocol="application/pgp-signature"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/2SF1h=8P.u7r8cvyec_ITW6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This runs a bit faster and removes another use of perl from
the kernel build.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Makefile        |  4 +--
 arch/powerpc/relocs_check.pl | 66 ----------------------------------------=
----
 arch/powerpc/relocs_check.sh | 58 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 68 deletions(-)
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
index 000000000000..8747dd9f7202
--- /dev/null
+++ b/arch/powerpc/relocs_check.sh
@@ -0,0 +1,58 @@
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
+	printf "%s [path to objdump] [path to vmlinux]\n" $0 1>&2
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
+printf "WARNING: %d bad relocations\n" $(printf "$bad_relocs\n" | wc -l)
+printf "$bad_relocs\n"
+
+# If we see this type of relocation it's an idication that
+# we /may/ be using an old version of binutils.
+if echo "$bad_relocs\n" | grep -q -F -w R_PPC64_UADDR64; then
+	printf "WARNING: You need at least binutils >=3D 2.19 to build a CONFIG_R=
ELOCATABLE kernel\n"
+fi
--=20
2.1.4

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/2SF1h=8P.u7r8cvyec_ITW6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVARGmAAoJEMDTa8Ir7ZwVPmQP/2kLABBgaeYzlaZ9IorTVQ08
0DALjkf7UEUWu6LX5MMJCar/dQawR2i6zA8BHyeOaju09Mz6f0DGpb+ywGFQMYWx
+0RItZo5TO1FMWqEnA5ySJYpzWk+qx5Pk2WZreTPYKvwoGpgWrl/1XF5vW+iJSc8
mFALjGDE/y234oopDojn4VAGcqEeTw0jdgbigur/26I2TfPg/jtK0gLE7tM12C0o
T+WCSnhRHGtKwOlJIHKyCt3hjFleCmSmuC/mEf9QFUl2B0kcuMoNnfD9VbiWTwOY
612612F8MOejllvdLHeCsNuY4pE0UuxBcIElJcsHdaUD+p7DoBan97PTaJWly8Ko
QdmIQZhyEJ+PHryr8o6pAGAW8dC7eqkQKT2efSdkFF0mYwotw8+Skf/KfCykZ4m2
h9R6jhCw3ov4pvRKSmmGIbvfxpztXHUTBKzNRTLX6cIQjDOK0GQSl8GJ4OKoUGFn
m6ifMd2I0attu50RhKg7d4BMZBOMjzeAjbDjO2LQ5saUZuCeE6PVQnDaJSfsmXJe
vgBahIG9r8trKUYpWzcDIFimABVIJCN2Lji9I33YjZrD1jDOdonPRvWyVQ/qY2k4
lDAzMYyPmrcFyeoX7/n6OOtgLT+gpkqmCXgUMsjthgHHPQqgPyWzMZy8A+l/MdDc
kuycwTe9ZyF6C5F/s2yz
=ETsN
-----END PGP SIGNATURE-----

--Sig_/2SF1h=8P.u7r8cvyec_ITW6--
