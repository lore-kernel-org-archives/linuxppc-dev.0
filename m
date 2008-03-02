Return-Path: <waldi@debian.org>
Received: from wavehammer.waldi.eu.org (wavehammer.waldi.eu.org
	[82.139.201.20]) by ozlabs.org (Postfix) with ESMTP id 0FA9DDDEC5
	for <linuxppc-dev@ozlabs.org>; Mon,  3 Mar 2008 06:33:17 +1100 (EST)
Date: Sun, 2 Mar 2008 20:06:32 +0100
From: Bastian Blank <waldi@debian.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc - Use KBUILD_CFLAGS and similar
Message-ID: <20080302190632.GA9898@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks

The attached patch changes the powerpc main Makefile from using the override
make directive to KBUILD_CFLAGS and similar.

The override approach breaks with both variants "CC=3Dgcc-4.3 make" and
"make CC=3Dgcc-4.3". The first ignores the given value completely because
the toplevel Makefile includes a CC definition:

| $ CC=3D"gcc-4.3" make V=3D1
[...]
|  gcc -m64 -Wp,-MD,init/.main.o.d

The second does not add -m64:
| $ make CC=3D"gcc-4.3" V=3D1
[...]
|  gcc-4.3 -Wp,-MD,arch/powerpc/kernel/.asm-offsets.s.d

The patch changes the CC, AS and LD overrides into changes of
KBUILD_CFLAGS, KBUILD_AFLAGS and LDFLAGS similar to arch/s390/Makefile.

Signed-off-by: Bastian Blank <waldi@debian.org>

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 1c6ce35..b267c60 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -63,9 +63,9 @@ endif
 UTS_MACHINE :=3D $(OLDARCH)
=20
 ifeq ($(HAS_BIARCH),y)
-override AS    +=3D -a$(CONFIG_WORD_SIZE)
-override LD    +=3D -m elf$(CONFIG_WORD_SIZE)ppc
-override CC    +=3D -m$(CONFIG_WORD_SIZE)
+LDFLAGS                :=3D -m elf$(CONFIG_WORD_SIZE)ppc
+KBUILD_CFLAGS  +=3D -m$(CONFIG_WORD_SIZE)
+KBUILD_AFLAGS  +=3D -m$(CONFIG_WORD_SIZE)
 override AR    :=3D GNUTARGET=3Delf$(CONFIG_WORD_SIZE)-powerpc $(AR)
 endif
=20
--=20
Men will always be men -- no matter where they are.
		-- Harry Mudd, "Mudd's Women", stardate 1329.8

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iEYEARECAAYFAkfK+rgACgkQnw66O/MvCNFf1wCff0HGBL+LIu+LiuJ0KSXqDn1H
bwkAn3U6aN8KlBPV+HzzN8+eASUNtY8D
=Bk79
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
