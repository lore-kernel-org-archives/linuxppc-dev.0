Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id C50C3B6FA5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 07:22:45 +1100 (EST)
Date: Mon, 20 Feb 2012 07:22:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: gregkh@linuxfoundation.org
Subject: [PATCH] tty/powerpc: early udbg consoles can't be modules
Message-Id: <20120220072238.b68316862f0f1619e56ab41d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Mon__20_Feb_2012_07_22_38_+1100_g/gdUOQ2J4KDY=9z"
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

--Signature=_Mon__20_Feb_2012_07_22_38_+1100_g/gdUOQ2J4KDY=9z
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

Resent with Greg's correct new address.

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

--Signature=_Mon__20_Feb_2012_07_22_38_+1100_g/gdUOQ2J4KDY=9z
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJPQVoOAAoJEECxmPOUX5FEobgQAJ+ai7pDTPNTFzWBfOHbqqrU
JHYctHswFdTLvOwqDdNsds1K4HrezeJp4Ufn8zmw4wunFZliVC3FWO+rPDRXWtco
ZvLIZyBcCx/dlGRUltT+CuKvJO3XQOpfWNr9KigRUfZI2kOiBlAu4J2wWZJjNQY3
Jb/TpzZCTLkMIawv3SOng9LII9HhInan19uQ3RGOn1dk9FLjQe0fu4alzxLC0BvD
BAh3F8PSMDl/rPk1zgtjQRMdtUZX+GCK0r5A5omih2E8iCYCJOlMYiuvVYfI1REn
i6IKylF1KnAP46svchUzgePK4Av8Wy22xlRaaGVs/lOxtE8sCIgwsV3amHtkMner
wpQyllNcw5FNcO5lmSVYW2eFx0SevoSG/VoCyWxrgWtfS8AEVZx0HlnEuOy7lhBx
LE0KHd2M55sZ6tcmQEtlJI4zQtUZcyl+8T7ORqdCvBorwmtcHVVYRiT3Wxgm7WOO
c9Zv4jN1MyFtejs3YPH9WBg+Q8gncW7o0tuJ3y34hXvX3j5UmTzjiVTW+VIPWS+T
QlRvLEVvoadY26qrwYgHtZyhhBoJcfkuIbrvU1S0YoeN5eH+FVDMqLNCvNgCfuv8
Wwq7+AiYX91Zpd0PDMt+W8f6JdwkKC4tUC5jLniiYBXEbjFonSEOPdoKCPd6Tm3P
DlSBdMaxUc6PevvpalZ0
=OdDD
-----END PGP SIGNATURE-----

--Signature=_Mon__20_Feb_2012_07_22_38_+1100_g/gdUOQ2J4KDY=9z--
