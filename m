Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77C3ADDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 13:44:30 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] Make pci_bus_to_host()'s struct pci_bus *
	argument const
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Trent Piepho <tpiepho@freescale.com>
In-Reply-To: <1207707572-24364-1-git-send-email-tpiepho@freescale.com>
References: <1207707572-24364-1-git-send-email-tpiepho@freescale.com>
Content-Type: text/plain
Date: Wed, 09 Apr 2008 13:44:16 +1000
Message-Id: <1207712656.9079.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-04-08 at 19:19 -0700, Trent Piepho wrote:
> Why?  Because:
> A) It's not modified and so it can be made const.  const is good.
> B) If one has a function that was given a const pci_bus pointer and you
> want to get a pointer to its pci_controller, you'll get a warning from gcc
> when you use pci_bus_to_host().  This is the right way to stop that
> warning.
> 
> Signed-off-by: Trent Piepho <tpiepho@freescale.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  include/asm-powerpc/pci-bridge.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-powerpc/pci-bridge.h b/include/asm-powerpc/pci-bridge.h
> index e5802c6..b95d033 100644
> --- a/include/asm-powerpc/pci-bridge.h
> +++ b/include/asm-powerpc/pci-bridge.h
> @@ -117,7 +117,7 @@ struct pci_controller {
>  
>  #ifndef CONFIG_PPC64
>  
> -static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
> +static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
>  {
>  	return bus->sysdata;
>  }
> @@ -235,7 +235,7 @@ extern void pcibios_fixup_new_pci_devices(struct pci_bus *bus);
>  
>  extern int pcibios_remove_root_bus(struct pci_controller *phb);
>  
> -static inline struct pci_controller *pci_bus_to_host(struct pci_bus *bus)
> +static inline struct pci_controller *pci_bus_to_host(const struct pci_bus *bus)
>  {
>  	struct device_node *busdn = bus->sysdata;
>  
