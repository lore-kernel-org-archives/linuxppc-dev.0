Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 839B2DDE1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 21:18:26 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l9FBIHkF010718
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 04:18:17 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9FBIF2e002211
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 06:18:16 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] [POWERPC] ucc_geth: Fix build break introduced by commit
	09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
Date: Mon, 15 Oct 2007 19:17:58 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B590C@zch01exm26.fsl.freescale.net>
In-Reply-To: <1192231588-17516-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1192231588-17516-1-git-send-email-Emilian.Medve@Freescale.com>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>,
	<akpm@linux-foundation.org>, <jgarzik@pobox.com>,
	<netdev@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Medve Emilian-EMMEDVE1=20
> Sent: Saturday, October 13, 2007 7:26 AM
> To: akpm@linux-foundation.org; jgarzik@pobox.com; Li=20
> Yang-r58472; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH] [POWERPC] ucc_geth: Fix build break=20
> introduced by commit 09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
>=20
>=20
>   CC      drivers/net/ucc_geth.o
> drivers/net/ucc_geth.c: In function 'ucc_geth_startup':
> drivers/net/ucc_geth.c:2614: warning: assignment makes=20
> integer from pointer without a cast
> drivers/net/ucc_geth.c:2651: warning: assignment makes=20
> integer from pointer without a cast
> drivers/net/ucc_geth.c: In function 'ucc_geth_rx':
> drivers/net/ucc_geth.c:3483: error: 'dev' undeclared (first=20
> use in this function)
> drivers/net/ucc_geth.c:3483: error: (Each undeclared=20
> identifier is reported only once
> drivers/net/ucc_geth.c:3483: error: for each function it appears in.)
> make[2]: *** [drivers/net/ucc_geth.o] Error 1

Thanks for the patch.  Here are some comments.

The patch fixes the dev undeclared compile error not the warnings.  So
they shouldn't be listed here.

>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
> ---
>=20
> Here is a convenient link for the culprit patch:=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/jgarzik/netdev-2.6.g
> it;a=3Dcommit;h=3D09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
>=20
> netdev-2.6> scripts/checkpatch.pl=20
> 0001-POWERPC-ucc_geth-Fix-build-break-introduced-by-co.patch
> Your patch has no obvious style problems and is ready for submission.
>=20
>  drivers/net/ucc_geth.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c=20
> index d00e7d4..c43d4d1 100644
> --- a/drivers/net/ucc_geth.c
> +++ b/drivers/net/ucc_geth.c
> @@ -63,7 +63,7 @@
>  #define UGETH_MSG_DEFAULT	(NETIF_MSG_IFUP << 1 ) - 1
> =20
>  void uec_set_ethtool_ops(struct net_device *netdev);
> -=09
> +
>  static DEFINE_SPINLOCK(ugeth_lock);
> =20
>  static struct {

There are quite a few references to the dev structure.  I would prefer
to add a new variable dev here.

- Leo

> @@ -3480,9 +3480,9 @@ static int ucc_geth_rx(struct=20
> ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>  				dev_kfree_skb_any(skb);
> =20
>  		=09
> ugeth->rx_skbuff[rxQ][ugeth->skb_currx[rxQ]] =3D NULL;
> -			dev->stats.rx_dropped++;
> +			ugeth->dev->stats.rx_dropped++;
>  		} else {
> -			dev->stats.rx_packets++;
> +			ugeth->dev->stats.rx_packets++;
>  			howmany++;
> =20
>  			/* Prep the skb for the packet */
> @@ -3491,7 +3491,7 @@ static int ucc_geth_rx(struct=20
> ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>  			/* Tell the skb what kind of packet this is */
>  			skb->protocol =3D eth_type_trans(skb, ugeth->dev);
> =20
> -			dev->stats.rx_bytes +=3D length;
> +			ugeth->dev->stats.rx_bytes +=3D length;
>  			/* Send the packet up the stack */
>  #ifdef CONFIG_UGETH_NAPI
>  			netif_receive_skb(skb);
> @@ -3506,7 +3506,7 @@ static int ucc_geth_rx(struct=20
> ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>  		if (!skb) {
>  			if (netif_msg_rx_err(ugeth))
>  				ugeth_warn("%s: No Rx Data=20
> Buffer", __FUNCTION__);
> -			dev->stats.rx_dropped++;
> +			ugeth->dev->stats.rx_dropped++;
>  			break;
>  		}
> =20
> --
> 1.5.3.GIT
>=20
>=20
