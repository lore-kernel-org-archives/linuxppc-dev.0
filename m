Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A71331A0058
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 23:32:15 +1100 (AEDT)
In-Reply-To: <1427261761-22952-3-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 02/27] powerpc/powermac: move pmac_pci_probe_mode from
 setup.c to pci.c
Message-Id: <20150330123214.9EE4014009B@ozlabs.org>
Date: Mon, 30 Mar 2015 23:32:14 +1100 (AEDT)
Cc: Daniel Axtens <dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-25-03 at 05:35:36 UTC, Daniel Axtens wrote:

Why did we move it? Just for cleanliness?

> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  arch/powerpc/platforms/powermac/pci.c   | 17 +++++++++++++++++
>  arch/powerpc/platforms/powermac/pmac.h  |  4 ++++
>  arch/powerpc/platforms/powermac/setup.c | 18 ------------------
>  3 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/pci.c b/arch/powerpc/platforms/powermac/pci.c
> index f4071a6..a792f45 100644
> --- a/arch/powerpc/platforms/powermac/pci.c
> +++ b/arch/powerpc/platforms/powermac/pci.c
> @@ -1223,3 +1223,20 @@ static void fixup_u4_pcie(struct pci_dev* dev)
>  	pci_write_config_dword(dev, PCI_PREF_MEMORY_BASE, 0);
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_APPLE, PCI_DEVICE_ID_APPLE_U4_PCIE, fixup_u4_pcie);
> +
> +#ifdef CONFIG_PPC64
> +int pmac_pci_probe_mode(struct pci_bus *bus)
> +{
> +	struct device_node *node = pci_bus_to_OF_node(bus);
> +
> +	/* We need to use normal PCI probing for the AGP bus,
> +	 * since the device for the AGP bridge isn't in the tree.
> +	 * Same for the PCIe host on U4 and the HT host bridge.
> +	 */
> +	if (bus->self == NULL && (of_device_is_compatible(node, "u3-agp") ||
> +				  of_device_is_compatible(node, "u4-pcie") ||
> +				  of_device_is_compatible(node, "u3-ht")))
> +		return PCI_PROBE_NORMAL;
> +	return PCI_PROBE_DEVTREE;
> +}
> +#endif /* CONFIG_PPC64 */
> diff --git a/arch/powerpc/platforms/powermac/pmac.h b/arch/powerpc/platforms/powermac/pmac.h
> index 8327cce..46d2193 100644
> --- a/arch/powerpc/platforms/powermac/pmac.h
> +++ b/arch/powerpc/platforms/powermac/pmac.h
> @@ -39,4 +39,8 @@ extern void low_cpu_die(void) __attribute__((noreturn));
>  extern int pmac_nvram_init(void);
>  extern void pmac_pic_init(void);
>  
> +#ifdef CONFIG_PPC64
> +extern int pmac_pci_probe_mode(struct pci_bus *bus);
> +#endif

You don't need to ifdef declarations, and you don't need extern.

So just:

> +int pmac_pci_probe_mode(struct pci_bus *bus);

Is fine.

cheers
