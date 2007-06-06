Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4257DDE49
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 17:07:01 +1000 (EST)
Subject: Re: [PATCH v2 6/9] Let subordinate transparent bridges be transparent.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180996213.9632.74.camel@ld0161-tx32>
References: <1180996213.9632.74.camel@ld0161-tx32>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 17:06:52 +1000
Message-Id: <1181113612.31677.238.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 17:30 -0500, Jon Loeliger wrote:
> In pcibios_fixup_bus(), bridges that are subordinate
> to transparent bridges were still relocating their
> IORESOURCE_IO and IO_RESOURCE_MEM start and end values.
> 
> Fix this by preventing the transparent bridge from
> relocating the start and end values, thus allowing the
> subordinate non-transparent bridge full molestation rights.
> 
> Signed-off-by: York Sun <yorksun@freescale.com>
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> This is the variant that was suggested by Ben H.
> 
>  arch/powerpc/kernel/pci_32.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_32.c b/arch/powerpc/kernel/pci_32.c
> index e66064b..7738a28 100644
> --- a/arch/powerpc/kernel/pci_32.c
> +++ b/arch/powerpc/kernel/pci_32.c
> @@ -1370,7 +1370,7 @@ void __init pcibios_fixup_bus(struct pci_bus *bus)
>  		for (i = 0; i < 4; ++i) {
>  			if ((res = bus->resource[i]) == NULL)
>  				continue;
> -			if (!res->flags)
> +			if (!res->flags || bus->self->transparent)
>  				continue;
>  			if (io_offset && (res->flags & IORESOURCE_IO)) {
>  				res->start += io_offset;
