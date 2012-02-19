Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id 2F142B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 07:01:19 +1100 (EST)
Date: Mon, 20 Feb 2012 07:01:06 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] tty/powerpc: early udbg consoles can't be modules
Message-Id: <20120220070106.7df60c7d30e68601c2b8dd7e@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__20_Feb_2012_07_01_06_+1100_w7zH9JwZPyfbZaOw"
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>, Timur Tabi <timur@freescale.com>,
 stable@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Mon__20_Feb_2012_07_01_06_+1100_w7zH9JwZPyfbZaOw
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fixes these build errors:

ERROR: ".udbg_printf" [drivers/tty/ehv_bytechan.ko] undefined!
ERROR: ".register_early_udbg_console" [drivers/tty/ehv_bytechan.ko] undefin=
ed!
ERROR: "udbg_putc" [drivers/tty/ehv_bytechan.ko] undefined!

Cc: Timur Tabi <timur@freescale.com>
Cc: stable@vger.kernel.org (v3.2)
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/tty/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index b3d1741..830cd62 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -365,7 +365,7 @@ config PPC_EPAPR_HV_BYTECHAN
=20
 config PPC_EARLY_DEBUG_EHV_BC
 	bool "Early console (udbg) support for ePAPR hypervisors"
-	depends on PPC_EPAPR_HV_BYTECHAN
+	depends on PPC_EPAPR_HV_BYTECHAN=3Dy
 	help
 	  Select this option to enable early console (a.k.a. "udbg") support
 	  via an ePAPR byte channel.  You also need to choose the byte channel
--=20
1.7.9

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Mon__20_Feb_2012_07_01_06_+1100_w7zH9JwZPyfbZaOw
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPQVUCAAoJEECxmPOUX5FEybYP/Rd/TL+SnXx0B2JHV54JC+FX
Bx1Xxex/Cl+q9NoceOcPQ6Z80Uym8dhOti4Sgx5CXkgryfEUTj5DmA0GnXfHzpRG
qDvNx/nOltz2zoTVGo/99t8Rh8f9uwX4i/JWf+5yT4W6LHzGemb1lXEbtK5q8wPS
pJe0GyPvwUVrg0WE3aSLoXpleb3siIj01n3/lgxMpwcwE+IpZj6T1xIeiIwa//JD
hMY4UBW2knExmLfK4080/BCJLNbbkdKnyqRLY6+hhqqkS70K78562RshYeHDY899
UYS7W23KDDpAnCrqCseU//rpI0WBYxW/hmstXm5Pr2iP5HssbBZVNoor4VxruV+s
1koKCSnDUBuG96AMtF8NiBwhbO0g8XkogAXv3LkItEvnYXC+wdD25E9LLEGMA6pE
ENmsrvDxLvihUHopNFXPx665tj8Fgp5d6KfKdvQ0OhDTQNZcQX30mLGIPIL+m9kt
TcWHmm5GLX0msDVfGNDHILtKtvtfvFhtXAQn37RCa4y5EqkrsbCAH7MHWDH18xV6
D2dFTKpcd+PfRi/n0IntnC42AzK7pLIyjTDU6LdUnS31s4yMqdJdR9DA2TgxUgQi
Mv0jqrJIzE7mSnXzlJZS0f87HP1X+OCS9snR2d6axEflopmRstDIlU7R4MzWrQ0V
shT8mCVPusXIp9n+TRjr
=yBJU
-----END PGP SIGNATURE-----

--Signature=_Mon__20_Feb_2012_07_01_06_+1100_w7zH9JwZPyfbZaOw--
