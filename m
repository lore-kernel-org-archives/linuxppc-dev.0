Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C0282C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 03:35:09 +1000 (EST)
Message-ID: <502BDDC4.8050609@freescale.com>
Date: Wed, 15 Aug 2012 12:35:00 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jia Hongtao <B38951@freescale.com>
Subject: Re: [PATCH V7 3/3] powerpc/fsl-pci: Unify pci/pcie initialization code
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-4-git-send-email-B38951@freescale.com>
In-Reply-To: <1345021026-10886-4-git-send-email-B38951@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, B07421@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/15/2012 03:57 AM, Jia Hongtao wrote:
> We unified the Freescale pci/pcie initialization by changing the fsl_pci
> to a platform driver. In previous PCI code architecture the initialization
> routine is called at board_setup_arch stage. Now the initialization is done
> in probe function which is architectural better. Also It's convenient for
> adding PM support for PCI controller in later patch.
> 
> We also change the way of determining primary bus for fitting platform
> driver. Two previous patches are the preparation for this.
> 
> Now we registered pci controllers as platform devices. So we combine two
> initialization code as one platform driver.
> 
> Signed-off-by: Jia Hongtao <B38951@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
> ---
> Changes for V7:
> - Separate V6 to three functional independent patches.
> 
>  arch/powerpc/platforms/85xx/common.c       |   10 +++
>  arch/powerpc/platforms/85xx/corenet_ds.c   |   31 +--------
>  arch/powerpc/platforms/85xx/ge_imp3a.c     |   48 +------------
>  arch/powerpc/platforms/85xx/mpc8536_ds.c   |   36 +---------
>  arch/powerpc/platforms/85xx/mpc85xx_ads.c  |    9 +--
>  arch/powerpc/platforms/85xx/mpc85xx_cds.c  |   14 +----
>  arch/powerpc/platforms/85xx/mpc85xx_ds.c   |   38 ++--------
>  arch/powerpc/platforms/85xx/mpc85xx_mds.c  |   38 +---------
>  arch/powerpc/platforms/85xx/mpc85xx_rdb.c  |   28 +++-----
>  arch/powerpc/platforms/85xx/p1010rdb.c     |   14 +----
>  arch/powerpc/platforms/85xx/p1022_ds.c     |   34 +---------
>  arch/powerpc/platforms/85xx/p1022_rdk.c    |   34 +---------
>  arch/powerpc/platforms/85xx/p1023_rds.c    |    7 +--
>  arch/powerpc/platforms/85xx/p2041_rdb.c    |    2 +-
>  arch/powerpc/platforms/85xx/p3041_ds.c     |    2 +-
>  arch/powerpc/platforms/85xx/p4080_ds.c     |    2 +-
>  arch/powerpc/platforms/85xx/p5020_ds.c     |    2 +-
>  arch/powerpc/platforms/85xx/p5040_ds.c     |    2 +-
>  arch/powerpc/platforms/85xx/qemu_e500.c    |    3 +-
>  arch/powerpc/platforms/85xx/sbc8548.c      |   19 +-----
>  arch/powerpc/platforms/85xx/socrates.c     |   11 +---
>  arch/powerpc/platforms/85xx/stx_gp3.c      |   11 +---
>  arch/powerpc/platforms/85xx/tqm85xx.c      |   21 +------
>  arch/powerpc/platforms/85xx/xes_mpc85xx.c  |   54 ++-------------
>  arch/powerpc/platforms/86xx/gef_ppc9a.c    |   10 +--
>  arch/powerpc/platforms/86xx/gef_sbc310.c   |   11 +---
>  arch/powerpc/platforms/86xx/gef_sbc610.c   |   10 +--
>  arch/powerpc/platforms/86xx/mpc8610_hpcd.c |   19 +----
>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |   40 +----------
>  arch/powerpc/platforms/86xx/sbc8641d.c     |   12 +---
>  arch/powerpc/sysdev/fsl_pci.c              |  102 +++++++++++++++++-----------
>  arch/powerpc/sysdev/fsl_pci.h              |    9 ++-
>  drivers/edac/mpc85xx_edac.c                |   43 +++---------
>  33 files changed, 160 insertions(+), 566 deletions(-)

Please separate the core changes from the conversion of boards.  The
easiest way to do this is to convert them to using fsl_pci_init() first.

Which boards have you tested on?

> -void __devinit fsl_pci_init(void)
> +/* Checkout if PCI contains ISA node */
> +static int of_pci_has_isa(struct device_node *pci_node)
> +{
> +	struct device_node *np;
> +	int ret = 0;
> +
> +	if (!pci_node)
> +		return 0;
> +
> +	read_lock(&devtree_lock);
> +	np = pci_node->allnext;
> +
> +	/* Only scan the children of PCI node */
> +	for (; np != pci_node->sibling; np = np->allnext) {
> +		if (np->type && (of_node_cmp(np->type, "isa") == 0)
> +		    && of_node_get(np)) {
> +			ret = 1;
> +			break;
> +		}
> +	}
> +
> +	of_node_put(pci_node);
> +	read_unlock(&devtree_lock);
> +
> +	return ret;
> +}

Didn't Kumar already say to leave this alone?  Do you think you'll get
your patches merged by eternal stubornness?

-Scott
