Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id BB928B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 May 2012 10:51:57 +1000 (EST)
Date: Thu, 3 May 2012 10:51:46 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: [PATCH] net/pasemi: fix compiler warning
Message-Id: <20120503105146.83f0a4a074dafad0443b875d@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__3_May_2012_10_51_46_+1000_zjNGosqx.hAVI645"
Cc: Olof Johansson <olof@lixom.net>,
 "Pradeep A. Dalvi" <netdev@pradeepdalvi.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Thu__3_May_2012_10_51_46_+1000_zjNGosqx.hAVI645
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix this compiler warning (on PowerPC) by not marking a parameter as
const:

drivers/net/ethernet/pasemi/pasemi_mac.c: In function 'pasemi_mac_replenish=
_rx_ring':
drivers/net/ethernet/pasemi/pasemi_mac.c:646:3: warning: passing argument 1=
 of 'netdev_alloc_skb' discards qualifiers from pointer target type
include/linux/skbuff.h:1706:31: note: expected 'struct net_device *' but ar=
gument is of type 'const struct net_device *'

Cc: Olof Johansson <olof@lixom.net>
Cc: Pradeep A. Dalvi <netdev@pradeepdalvi.com>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/net/ethernet/pasemi/pasemi_mac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

The warning was introduced by commit dae2e9f430c4 ("netdev: ethernet
dev_alloc_skb to netdev_alloc_skb").

diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/etherne=
t/pasemi/pasemi_mac.c
index ddc95b0..e559dfa 100644
--- a/drivers/net/ethernet/pasemi/pasemi_mac.c
+++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
@@ -623,7 +623,7 @@ static void pasemi_mac_free_rx_resources(struct pasemi_=
mac *mac)
 	mac->rx =3D NULL;
 }
=20
-static void pasemi_mac_replenish_rx_ring(const struct net_device *dev,
+static void pasemi_mac_replenish_rx_ring(struct net_device *dev,
 					 const int limit)
 {
 	const struct pasemi_mac *mac =3D netdev_priv(dev);
--=20
1.7.10.280.gaa39

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__3_May_2012_10_51_46_+1000_zjNGosqx.hAVI645
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPodajAAoJEECxmPOUX5FEpFUP/2OW0IF0jT7U9kd9n5piSJfJ
MCQIdjCcEpoVS6dCApdJ2hxLQA0ahn7ZLAYvr2YJk7COyidZpJY0Fu6TwBHu7cp2
PaY/6DpPT4yL2GZR3VqOe9kLXPgbpgpMbPT8DlAlMLnfB6wJ3cQecjp1Nv0V1CwB
UZgCGtwBUxiRiFBHEJ4dqSF1gei47xfWPB1r75GuCUwtB+2Lhrs7Z8lK86fs9xV8
HqsS/3YF2aNm0+N3+zwnCZO3sqgxo5YmxKzJx9+wyqpjFZw0BJwU5R54XdG27hoo
STfG209D39Vrm/gNj7cL6Q4aeVASgwrWbLI+Ej1r9TtzWp0X4+oUmQ5IsPwDscPI
1pjqwB1YWboIzcsOC/w6SNxGljaatgTYhudoJnPNJfQ+U90dcda82idosGvd1yrq
8R3ZkufidbJb/PtdDrr4lWbQDxdPfltWsu//u2+wFvt5c2iFyhjVpDX30B4a88Kn
Z6tbt2HjaCYZ6JigWYdpekLt+EgCS5P9Bh/fyPagzEpgqFRFUNRglC1UurAp5Po+
cQCMrDLX74Sl0bn5Jk9TIHwlVJrDeAPjSp3nTeJga83yubJlbGiMAsctcXB3c/da
Mg5nMwZFE9Rb3AzD8RSHZ6Hvq47jNqJnubA3/k+jOVcVdt5eT3RteGgKiDrReCZU
M/BkF326LHcsfW0FlHG8
=z+11
-----END PGP SIGNATURE-----

--Signature=_Thu__3_May_2012_10_51_46_+1000_zjNGosqx.hAVI645--
