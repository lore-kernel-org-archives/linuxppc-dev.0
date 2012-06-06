Return-Path: <B07421@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe006.messaging.microsoft.com [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10D58B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2012 07:15:40 +1000 (EST)
Message-ID: <4FCFC870.40004@freescale.com>
Date: Wed, 6 Jun 2012 16:15:28 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Ben Collins <ben.c@servergy.com>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
In-Reply-To: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/05/2012 10:50 PM, Ben Collins wrote:
> The commit introducing pcibios_io_space_offset() was ignoring 32-bit to
> 64-bit sign extention, which is the case on ppc32 with 64-bit resource
> addresses. This only seems to have shown up while running under QEMU for
> e500mc target. It may or may be suboptimal that QEMU has an IO base
> address > 32-bits for the e500-pci implementation, but 1) it's still a
> regression and 2) it's more correct to handle things this way.

Where do you see addresses over 32 bits in QEMU's e500-pci, at least
with current mainline QEMU and the mpc8544ds model?

I/O space should be at 0xe1000000.

I'm also not sure what this has to do with the virtual address returned
by ioremap().

> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/pci-common.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index 8e78e93..be9ced7 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -1477,9 +1477,15 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
>  	return pci_enable_resources(dev, mask);
>  }
>  
> +/* Before assuming too much here, take care to realize that we need sign
> + * extension from 32-bit pointers to 64-bit resource addresses to work.
> + */
>  resource_size_t pcibios_io_space_offset(struct pci_controller *hose)
>  {
> -	return (unsigned long) hose->io_base_virt - _IO_BASE;
> +	long vbase = (long)hose->io_base_virt;
> +	long io_base = _IO_BASE;
> +
> +	return (resource_size_t)(vbase - io_base);

Why do we want sign extension here?

If we do want it, there are a lot of other places in this file where the
same calculation is done.

-Scott
