Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 72489DDEE7
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 06:48:11 +1100 (EST)
Date: Wed, 9 Jan 2008 12:20:38 -0600
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH for 2.6.24][NET] fs_enet: check for phydev existence in
	the ethtool handlers
Message-ID: <20080109182038.GA4337@loki.buserror.net>
References: <1199875566.3408.11.camel@p60365-ste> <4784C509.5030507@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4784C509.5030507@denx.de>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 01:58:49PM +0100, Heiko Schocher wrote:
> @@ -1312,6 +1312,9 @@ static int __devinit fs_enet_probe(struct of_device *ofdev,
>  	       ndev->dev_addr[0], ndev->dev_addr[1], ndev->dev_addr[2],
>  	       ndev->dev_addr[3], ndev->dev_addr[4], ndev->dev_addr[5]);
> 
> +	/* to initialize the fep->cur_rx,... */
> +	/* not doing this, will cause a crash in fs_enet_rx_napi */
> +	fs_init_bds(ndev);
>  	return 0;

We don't want to allocate ring buffers for network interfaces that are never
opened, especially given the small amount of memory on some boards that use
this driver.

Instead, we should probably not be calling napi_enable() until the link is
up and init_bds() has been called.

> @@ -1342,9 +1345,13 @@ static int fs_enet_remove(struct of_device *ofdev)
>  }
> 
>  static struct of_device_id fs_enet_match[] = {
> -#ifdef CONFIG_FS_ENET_HAS_SCC
> +#if defined(CONFIG_FS_ENET_HAS_SCC)
>  	{
> +#if defined(CONFIG_CPM1)
>  		.compatible = "fsl,cpm1-scc-enet",
> +#else
> +		.compatible = "fsl,cpm2-scc-enet",
> +#endif

I know there are already ifdefs of this sort, and that multiplatform
cpm1/cpm2 is very unlikely to ever happen, but can we try to avoid
introducing more such ifdefs?

We can have both match entries present at the same time.

>  		.data = (void *)&fs_scc_ops,
>  	},
>  #endif
> diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
> index 48f2f30..3b5ca76 100644
> --- a/drivers/net/fs_enet/mac-scc.c
> +++ b/drivers/net/fs_enet/mac-scc.c
> @@ -50,6 +50,7 @@
>  #include "fs_enet.h"
> 
>  /*************************************************/
> +#define SCC_EB ((u_char)0x10)  /* Set big endian byte order */

This is already defined in asm-powerpc/commproc.h, and thus will cause a
duplicate definition when building for 8xx.  Please add this definition to
asm-powerpc/cpm2.h.

> +#if defined(CONFIG_CPM1)
>  	W16(cpmp, cp_cpcr, fpi->cp_command | CPM_CR_FLG | (op << 8));
>  	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
>  		if ((R16(cpmp, cp_cpcr) & CPM_CR_FLG) == 0)
>  			return 0;
> +#else
> +	W32(cpmp, cp_cpcr, fpi->cp_command | CPM_CR_FLG | op);
> +	for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
> +		if ((R32(cpmp, cp_cpcr) & CPM_CR_FLG) == 0)
> +			return 0;
> +
> +#endif

Commit 362f9b6fa8c9670cc5496390845021c2865d049b in Paul's tree makes this
unnecessary.

> @@ -306,8 +317,15 @@ static void restart(struct net_device *dev)
> 
>  	/* Initialize function code registers for big-endian.
>  	 */
> +#ifdef CONFIG_CPM2
> +	/* from oldstyle driver in arch/ppc */
> +	/* seems necessary */
> +	W8(ep, sen_genscc.scc_rfcr, SCC_EB | 0x20);
> +	W8(ep, sen_genscc.scc_tfcr, SCC_EB | 0x20);
> +#else
>  	W8(ep, sen_genscc.scc_rfcr, SCC_EB);
>  	W8(ep, sen_genscc.scc_tfcr, SCC_EB);
> +#endif

Please define 0x20 as SCC_GBL (Snooping Enabled) in cpm2.h, and
conditionalize this on #ifndef CONFIG_NOT_COHERENT_CACHE.

You can remove the comment; it's really necessary, not just "seems" so. :-)

-Scott
