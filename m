Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 718362C043D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Mar 2013 15:11:55 +1100 (EST)
Date: Thu, 7 Mar 2013 15:11:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: make sure that we alays include CONFIG_BINFMT_ELF
Message-Id: <20130307151151.fcb469cb5a65a98785081b18@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__7_Mar_2013_15_11_51_+1100_1aoyv0vxv2W6RYa5"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__7_Mar_2013_15_11_51_+1100_1aoyv0vxv2W6RYa5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our kernel is not much good without BINFMT_ELF and this fixes a build
warning on 64 bit allnoconfig builds:

warning: (COMPAT) selects COMPAT_BINFMT_ELF which has unmet direct dependen=
cies (COMPAT && BINFMT_ELF)

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index b89d7eb..a091c01 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -90,6 +90,7 @@ config GENERIC_GPIO
 config PPC
 	bool
 	default y
+	select BINFMT_ELF
 	select OF
 	select OF_EARLY_FLATTREE
 	select HAVE_FTRACE_MCOUNT_RECORD
--=20
1.8.1

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__7_Mar_2013_15_11_51_+1100_1aoyv0vxv2W6RYa5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJROBOHAAoJEECxmPOUX5FEoOIP/jvNPhVejHedLvY6a0jzta1z
Rp3ruwggibda7x3no5Lzd/81E9OQiFO3YvL1nb1Jdmj0Djw5rHGdiAw6mDH2WyIN
ogVzsAfruvZC0MjFkpndkAP/MnvVeAwGDD7GtxLooWukfrhTMIc+QztRhXZ5KiXQ
TJ0pmvxslohK2XD/7Bjnzwo3a+q87oayTVSNLqZVR12C06F5UVXS9VSz+aH7bwlP
lWx1n5zoi8vDiqIrpAx+dRa3kFTYOl6fgGWdAjIah/uwyC9lM1f3aHZ5gnvXT41E
xz7X2+3SEmtoMBiyufE9Hblcd0ijivkYNDka2G5ymF9d2K1Hc9SqdMq/uvEZu9On
mDF+KYsgJNCNg5tozg9VL4qJIHsVm9cX7C/eUBsP1iszP+IrJzk07qnJ/biiurUd
JzV78aEW9WGn5ksjQhjtKG5/W2NXjTEu+AwoaxAO5QVGhiYZbmPvYgUaWb8fdUZm
wog8A4zfZPuDJ71ZcXg/DbMVCsx3wk6EnOXiihKnhpEJZMrBmq5CnmMIXVIEZ5we
I2KrWIlnppCu/erR9HvSHslWrhaIy5v0Tk1VuWa58sTVbJV1yVw2168cfxMT0MDg
MQp3Er2rGwequsSy/e8FPFg/x3prUuwgAQ9mrbyJEr6+pKXcmB2PUvDyJ7orrQqM
W2AiUJp5Vu4XatiqwvDs
=+rDY
-----END PGP SIGNATURE-----

--Signature=_Thu__7_Mar_2013_15_11_51_+1100_1aoyv0vxv2W6RYa5--
