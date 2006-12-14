Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2C1EE67BC9
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 15:55:21 +1100 (EST)
Subject: Re: [PATCH 6/19] powerpc: avoid claiming some PCI bus
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200612140228.kBE2SvUQ013034@toshiba.co.jp>
References: <200612140228.kBE2SvUQ013034@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 15:55:15 +1100
Message-Id: <1166072115.11914.280.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-12-14 at 11:28 +0900, Ishizaki Kou wrote:
> Celleb has multiple PCI buses. Devices on some of those PCI buses
> require to assign resources by Linux.  This patch is for such buses
> not to claim resources, because claimed resource does not become a
> target for resource assign.

I don't fully understand what's going on here, and why you have this
insert_resource() hacks in the platform PCI code as well...

Care to explain ? Unfortunately, we haven't received the HW yet so I
can't have a look by myself and propose alternate patches just yet...

Cheers,
Ben.

> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
> ---
> 
> Index: linux-powerpc-git/arch/powerpc/kernel/pci_64.c
> diff -u linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.1.1.1 linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.3
> --- linux-powerpc-git/arch/powerpc/kernel/pci_64.c:1.1.1.1	Wed Dec  6 08:25:43 2006
> +++ linux-powerpc-git/arch/powerpc/kernel/pci_64.c	Tue Dec 12 15:37:56 2006
> @@ -249,8 +249,13 @@
>  	if (firmware_has_feature(FW_FEATURE_ISERIES))
>  		return;
>  
> -	list_for_each_entry(b, &pci_root_buses, node)
> -		pcibios_claim_one_bus(b);
> +	list_for_each_entry(b, &pci_root_buses, node) {
> +		if (machine_is(celleb) &&
> +		    ppc_md.pci_probe_mode(b) != PCI_PROBE_DEVTREE)
> +			;
> +		else
> +			pcibios_claim_one_bus(b);
> +	}
>  }
>  
>  static u32 get_int_prop(struct device_node *np, const char *name, u32 def)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
