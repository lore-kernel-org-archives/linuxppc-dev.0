Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DDC06DE004
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 04:03:15 +1100 (EST)
Subject: Re: [RFC/PATCH 5/10] powerpc: pci32: Remove obsolete PowerMac bus
	number hack
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20071206081245.EBC65DE18E@ozlabs.org>
References: <20071206081245.EBC65DE18E@ozlabs.org>
Content-Type: text/plain
Message-Id: <1196960570.18340.9.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 06 Dec 2007 11:02:50 -0600
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-12-06 at 02:11, Benjamin Herrenschmidt wrote:
> The 32 bits PCI code carries an old hack that was only useful for G5
> machines. Nowdays, the 32 bits kernel doesn't support any of those
> machines anymore so the hack is basically never used, remove it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
>  arch/powerpc/kernel/pci_32.c |   11 -----------
>  1 file changed, 11 deletions(-)
> 
> Index: linux-work/arch/powerpc/kernel/pci_32.c
> ===================================================================
> --- linux-work.orig/arch/powerpc/kernel/pci_32.c	2007-12-05 11:36:30.000000000 +1100
> +++ linux-work/arch/powerpc/kernel/pci_32.c	2007-12-05 11:36:36.000000000 +1100
> @@ -922,17 +922,6 @@ long sys_pciconfig_iobase(long which, un
>  	struct pci_controller* hose;
>  	long result = -EOPNOTSUPP;
>  
> -	/* Argh ! Please forgive me for that hack, but that's the
> -	 * simplest way to get existing XFree to not lockup on some
> -	 * G5 machines... So when something asks for bus 0 io base
> -	 * (bus 0 is HT root), we return the AGP one instead.
> -	 */
> -#ifdef CONFIG_PPC_PMAC
> -	if (machine_is(powermac) && machine_is_compatible("MacRISC4"))
> -		if (bus == 0)
> -			bus = 0xf0;
> -#endif /* CONFIG_PPC_PMAC */
> -

I believe, with this patch, you are officially forgiven. :-)

jdl
