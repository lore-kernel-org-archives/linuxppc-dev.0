Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6A72DDE1B
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 17:08:54 +1000 (EST)
Subject: Re: [PATCH v2 8/9] Export of_bus_pci_get_flags().
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1180996223.9632.76.camel@ld0161-tx32>
References: <1180996223.9632.76.camel@ld0161-tx32>
Content-Type: text/plain
Date: Wed, 06 Jun 2007 17:08:41 +1000
Message-Id: <1181113721.31677.240.camel@localhost.localdomain>
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
> It will be needed by the following patch.
> 
> Signed-off-by: Andy Fleming <afleming@freescale.com>
> Signed-off-by: Jon Loeliger <jdl@freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/kernel/prom_parse.c |    2 +-
>  include/asm-powerpc/prom.h       |    1 +
>  2 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 3786dcc..754926f 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -153,7 +153,7 @@ static int of_bus_pci_translate(u32 *addr, u64 offset, int na)
>  	return of_bus_default_translate(addr + 1, offset, na - 1);
>  }
>  
> -static unsigned int of_bus_pci_get_flags(const u32 *addr)
> +unsigned int of_bus_pci_get_flags(const u32 *addr)
>  {
>  	unsigned int flags = 0;
>  	u32 w = addr[0];
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 6845af9..0168373 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -185,6 +185,7 @@ extern int pci_device_from_OF_node(struct device_node *node,
>  extern struct device_node* pci_busdev_to_OF_node(struct pci_bus *, int);
>  extern struct device_node* pci_device_to_OF_node(struct pci_dev *);
>  extern void pci_create_OF_bus_map(void);
> +extern unsigned int of_bus_pci_get_flags(const u32 *addr);
>  #endif
>  
>  extern struct resource *request_OF_resource(struct device_node* node,
