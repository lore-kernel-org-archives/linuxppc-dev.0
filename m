Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 12 Mar 2014 15:12:01 +1100
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/le: Avoid creatng R_PPC64_TOCSAVE relocations for
 modules.
Message-ID: <20140312041201.GA13555@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Cc: Rusty Russell <rusty@rustcorp.com.au>, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When building modules with a native le toolchain the linker will
generate R_PPC64_TOCSAVE relocations when it's safe to omit saving r2 on
a plt call.  This isn't helpful in the conext of a kernel module and the
kernel will fail to load those modules with an error like:
	nf_conntrack: Unknown ADD relocation: 109

This patch tells the linker to avoid createing R_PPC64_TOCSAVE
relocations allowing modules to load.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 0f4344e..fff3945 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -74,6 +74,9 @@ override CROSS32AS +=3D -mlittle-endian
 LDEMULATION	:=3D lppc
 GNUTARGET	:=3D powerpcle
 MULTIPLEWORD	:=3D -mno-multiple
+ifeq ($(call cc-option-yn,-mno-save-toc-indirect),y)
+       KBUILD_CFLAGS_MODULE +=3D -mno-save-toc-indirect
+endif
 else
 ifeq ($(call cc-option-yn,-mbig-endian),y)
 override CC	+=3D -mbig-endian
--=20
1.8.5.3

Yours Tony

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJTH96RAAoJEPvNNsFAAoTBbIEP/iBvREL4znSi9X3F/3k0AN5E
nRBcH7JI4daI6/90IedK4QDUc+QS+GyYlHJoEaASDSb2/pB86/x6dZkeLEYwb1IB
GGXidTSa2JINSNZuY78gdaXvWcz8CAKlJAPSsx5+bitU4NWrPonIdWdes8DPdgEn
GtSm8ug7OnbFfoS8jrkeFOJan4bQe27945jeTu96NTufjtgROpqR/IyrbZ6SZQSY
DCIfgZ/xnKicXZ/uYiGBFyXbIYGAeat8T118J0qbjpMTNbhdVECOJ0p3qKUsOIYG
IeT6HTd8Hw+CdVexJ868lJd68r92u6xxpG8HSp0YzzjknWS12fLD9dk5NoaZ3Rq4
bQzzfAx/QDEPhJwwwqwSoOlxWrVg3AWed79RpHQ8Jq5i4+HrN0UVdyCPqSYhAXBW
ZXEQ1K6myoTv0AnRtlB3Wf3lB+8UisGPv2LztlPrhOuGcEWv89vlAaeuKZBCxoY2
gTIhkxHtjpoLOAFqqPmvuuVzNhZMa4FzYDHAlk6WZEKezs4w9xK/+ooqZdcOhZ4F
HQHYZE1raFWy9lNAe9oWPfm8M1L2C16h7YZ/UXTBTbXbrgqItWraRLm7dxPL3VvM
vfW+y3kGypLkERByAMs0jN1Qq0qElQT6jmgl1regj4NrlGQN7WkaP2gQtn0ytXhA
RHWB84GYlBtib9t16aL5
=iriV
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
