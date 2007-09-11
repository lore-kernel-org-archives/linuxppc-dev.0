Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id C2361DDE02
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 09:00:42 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [RFC][POWERPC] Merge 32 and 64 bit
	pci_process_bridge_OF_ranges() instances
Date: Wed, 12 Sep 2007 00:57:17 +0200
References: <20070911224952.9838.46644.stgit@localhost.localdomain>
In-Reply-To: <20070911224952.9838.46644.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709120057.18873.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007, Vitaly Bordug wrote:
> 
> We are having 2 different instances of pci_process_bridge_OF_ranges(),
> which makes describing 64-bit physical addresses in non PPC64 case
> impossible.
> 
> This approach inherits pci space parsing, but has a new way to behave
> equally good in both 32bit and 64bit environments. This approach uses
> of_translate_address(), so implies proper ranges <> definition in
> devicetree, where PCI node has its reg on soc bus, and its ranges
> effectively belong to LAW addresses.
> 
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> Signed-off-by: Stefan Roese <sr@denx.de>

The patch looks really good, but it's hard to review when you move the
code around at the same as you change it.

Could you perhaps split the patch into two separate changesets, one
that makes both functions identical in place, and one that merges
them to live in a common location?

> diff --git a/include/asm-powerpc/ppc-pci.h b/include/asm-powerpc/ppc-pci.h
> index b847aa1..882b8bc 100644
> --- a/include/asm-powerpc/ppc-pci.h
> +++ b/include/asm-powerpc/ppc-pci.h
> @@ -15,6 +15,13 @@
>  #include <linux/pci.h>
>  #include <asm/pci-bridge.h>
>  
> +struct ranges_pci {
> +	unsigned int pci_space;
> +	u64 pci_addr;
> +	phys_addr_t phys_addr;
> +	u64 size;
> +} __attribute__((packed));
> +

This structure definition uses unaligned members because of the 'packed'
attribute. Is that really what you intended?

	Arnd <><
