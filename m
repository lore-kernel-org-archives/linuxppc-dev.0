Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38174B6F62
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 15:16:30 +1000 (EST)
Message-ID: <1338959744.7150.153.camel@pasglop>
Subject: Re: [PATCH] PPC: PCI: Fix pcibios_io_space_offset() so it works for
 32-bit ptr/64-bit rsrcs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Collins <ben.c@servergy.com>
Date: Wed, 06 Jun 2012 15:15:44 +1000
In-Reply-To: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
References: <4DC27253-67FC-4A55-8C78-7782D9D0CF53@servergy.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, Paul Mackerras <paulus@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-06-05 at 23:50 -0400, Ben Collins wrote:
> The commit introducing pcibios_io_space_offset() was ignoring 32-bit to
> 64-bit sign extention, which is the case on ppc32 with 64-bit resource
> addresses. This only seems to have shown up while running under QEMU for
> e500mc target. It may or may be suboptimal that QEMU has an IO base
> address > 32-bits for the e500-pci implementation, but 1) it's still a
> regression and 2) it's more correct to handle things this way.

See Bjorn, we both did end up getting it wrong :-)

> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

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
>  }
>  
>  static void __devinit pcibios_setup_phb_resources(struct pci_controller *hose, struct list_head *resources)
