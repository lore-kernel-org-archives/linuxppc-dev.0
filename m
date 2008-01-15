Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC12CDDE35
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 15:23:06 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] Fixup transparent P2P resources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0801142045010.32246@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0801142045010.32246@blarg.am.freescale.net>
Content-Type: text/plain
Date: Tue, 15 Jan 2008 15:22:45 +1100
Message-Id: <1200370965.10470.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2008-01-14 at 20:45 -0600, Kumar Gala wrote:
> For transparent P2P bridges the first 3 resources may get set from based on
> BAR registers and need to get fixed up. Where as the remainder come from the
> parent bus and have already been fixed up.

Ack.

> ---
> 
> in my git tree.
> 
>  arch/powerpc/kernel/pci-common.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 7d0afd4..980fe32 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -792,9 +792,10 @@ static void __devinit __pcibios_fixup_bus(struct pci_bus *bus)
>  		for (i = 0; i < PCI_BUS_NUM_RESOURCES; ++i) {
>  			if ((res = bus->resource[i]) == NULL)
>  				continue;
> -			if (!res->flags || bus->self->transparent)
> +			if (!res->flags)
> +				continue;
> +			if (i >= 3 && bus->self->transparent)
>  				continue;
> -
>  			/* On PowerMac, Apple leaves bridge windows open over
>  			 * an inaccessible region of memory space (0...fffff)
>  			 * which is somewhat bogus, but that's what they think
