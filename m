Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 56C10DDFD8
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 00:11:10 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l9FEA6ma015672
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:11:03 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9FEA4XE019629
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 09:10:05 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH v2] [POWERPC] ucc_geth: Fix build break introduced by
	commit 09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
Date: Mon, 15 Oct 2007 22:09:42 +0800
Message-ID: <989B956029373F45A0B8AF0297081890019B5916@zch01exm26.fsl.freescale.net>
In-Reply-To: <1192455830-1028-1-git-send-email-Emilian.Medve@Freescale.com>
References: <1192455830-1028-1-git-send-email-Emilian.Medve@Freescale.com>
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
> Sent: Monday, October 15, 2007 9:44 PM
> To: akpm@linux-foundation.org; jgarzik@pobox.com; Li=20
> Yang-r58472; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH v2] [POWERPC] ucc_geth: Fix build break=20
> introduced by commit 09f75cd7bf13720738e6a196cc0107ce9a5bd5a0
>=20
> drivers/net/ucc_geth.c: In function 'ucc_geth_rx':
> drivers/net/ucc_geth.c:3483: error: 'dev' undeclared (first=20
> use in this function)
> drivers/net/ucc_geth.c:3483: error: (Each undeclared=20
> identifier is reported only once
> drivers/net/ucc_geth.c:3483: error: for each function it appears in.)
> make[2]: *** [drivers/net/ucc_geth.o] Error 1
>=20
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Acked-by: Li Yang <leoli@freescale.com>

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
>  drivers/net/ucc_geth.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c=20
> index d00e7d4..bec413b 100644
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
> @@ -3454,9 +3454,12 @@ static int ucc_geth_rx(struct=20
> ucc_geth_private *ugeth, u8 rxQ, int rx_work_limit
>  	u16 length, howmany =3D 0;
>  	u32 bd_status;
>  	u8 *bdBuffer;
> +	struct net_device * dev;
> =20
>  	ugeth_vdbg("%s: IN", __FUNCTION__);
> =20
> +	dev =3D ugeth->dev;
> +
>  	/* collect received buffers */
>  	bd =3D ugeth->rxBd[rxQ];
> =20
> --
> 1.5.3.GIT
>=20
