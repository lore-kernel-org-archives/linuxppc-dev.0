Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B4E7EDDFED
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 19:42:33 +1000 (EST)
Date: Wed, 16 Apr 2008 19:42:27 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: linux-next: 4xx build failure
Message-Id: <20080416194227.1e5e1a9a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Wed__16_Apr_2008_19_42_27_+1000_pTuUqE=Vcysh2cf+"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Wed__16_Apr_2008_19_42_27_+1000_pTuUqE=Vcysh2cf+
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,

Today's linux-next build (powerpc allyesconfig) failed like this:

drivers/net/ibm_newemac/core.c: In function =E2=80=98emac_rx_clk_tx=E2=80=
=99:
drivers/net/ibm_newemac/core.c:146: error: implicit declaration of function=
 =E2=80=98dcri_clrset=E2=80=99
drivers/net/ibm_newemac/core.c:146: error: =E2=80=98SDR0=E2=80=99 undeclare=
d (first use in this function)
drivers/net/ibm_newemac/core.c:146: error: (Each undeclared identifier is r=
eported only once
drivers/net/ibm_newemac/core.c:146: error: for each function it appears in.)
drivers/net/ibm_newemac/core.c: In function =E2=80=98emac_rx_clk_default=E2=
=80=99:
drivers/net/ibm_newemac/core.c:152: error: =E2=80=98SDR0=E2=80=99 undeclare=
d (first use in this function)
drivers/net/ibm_newemac/core.c: In function =E2=80=98emac_init_phy=E2=80=99:
drivers/net/ibm_newemac/core.c:2361: error: =E2=80=98SDR0=E2=80=99 undeclar=
ed (first use in this function)

I have reverted commit 863a1175e22cb108f596a5aa55b1e535a77e7cce
("[POWERPC] ibm_newemac: PowerPC 440EP/440GR EMAC PHY clock workaround")
and commit 4b2d72f5035764cd2e89f5a13ab35c11a27c557b ("[POWERPC]
ibm_newemac: PowerPC 440GX EMAC PHY clock workaround").

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Wed__16_Apr_2008_19_42_27_+1000_pTuUqE=Vcysh2cf+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIBcoITgG2atn1QN8RAtKDAJ92tcHrB2F/yQN6um5Kjt+wFrdXPwCePOph
IKf/W2Auwu7MPiddxx/izng=
=6zZG
-----END PGP SIGNATURE-----

--Signature=_Wed__16_Apr_2008_19_42_27_+1000_pTuUqE=Vcysh2cf+--
