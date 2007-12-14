Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id DFA90DDF35
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 19:38:15 +1100 (EST)
Date: Fri, 14 Dec 2007 02:43:43 -0600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/15] [POWERPC] pci32: Add flags modifying the PCI code
	behaviour
Message-ID: <20071214084343.GC28118@lixom.net>
References: <1197608163.200976.87755569596.qpush@grosgo>
	<20071214045612.3A7E6DE2E2@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214045612.3A7E6DE2E2@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Minor nitpicks:

On Fri, Dec 14, 2007 at 03:56:05PM +1100, Benjamin Herrenschmidt wrote:

> --- linux-merge.orig/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:28.000000000 +1100
> +++ linux-merge/arch/powerpc/kernel/pci_32.c	2007-12-14 15:49:29.000000000 +1100
> @@ -48,7 +51,7 @@ static u8* pci_to_OF_bus_map;
>  /* By default, we don't re-assign bus numbers. We do this only on
>   * some pmacs
>   */
> -int pci_assign_all_buses;
> +static int pci_assign_all_buses;
>  

Why not remove it alltogether, there's still the function to test the
flag that's just as cheap (load + test + branch).

> Index: linux-merge/include/asm-powerpc/pci-bridge.h
> ===================================================================
> --- linux-merge.orig/include/asm-powerpc/pci-bridge.h	2007-12-14 15:49:01.000000000 +1100
> +++ linux-merge/include/asm-powerpc/pci-bridge.h	2007-12-14 15:49:29.000000000 +1100
> @@ -13,6 +13,26 @@
>  
>  struct device_node;
>  
> +extern unsigned int ppc_pci_flags;

Should the below be a named enum and the type for the above be the same
for nicer decode in gdb?

> +enum {
> +	/* Force re-assigning all resources (ignore firmware
> +	 * setup completely)
> +	 */
> +	PPC_PCI_REASSIGN_ALL_RSRC	= 0x00000001,

This should be ..._RSRCS (resources, not resource)

> +	/* Re-assign all bus numbers */
> +	PPC_PCI_REASSIGN_ALL_BUS	= 0x00000002,

And this should be ..._BUSSES

> +	/* Do not try to assign, just use existing setup */
> +	PPC_PCI_PROBE_ONLY		= 0x00000004,

My first reaction was "what's the difference between setting this and
keeping the two other cleared". Looks like the difference is the
assignment of unassigned resources. Not sure how to better represent
that so it's obvious from the naming (without doing something as
excessive as PPC_PCI_REASSIGN_UNASSIGNED_RSRCS :)

> +
> +	/* Don't bother with ISA alignment unless the bridge has
> +	 * ISA forwarding enabled
> +	 */
> +	PPC_PCI_CAN_SKIP_ISA_ALIGN	= 0x00000008,
> +};


-Olof
