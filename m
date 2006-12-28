Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2E724DDF00
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Dec 2006 14:03:04 +1100 (EST)
Subject: Re: [PATCH] Do not write virq back to PCI config space.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <E1GzlHs-0006S9-7p@arlx188.austin.ibm.com>
References: <E1GzlHs-0006S9-7p@arlx188.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 28 Dec 2006 14:02:58 +1100
Message-Id: <1167274978.23340.39.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-12-27 at 20:46 -0600, Michal Ostrowski wrote:
> - Drivers will not rely on the PCI config space value, as they've
>   already been conditioned to rely on the irq field in "struct pci_dev".
> 
> - The virq value may not be < 256 as it has been remapped.
> 
> - The PCI config space should reflect the hardware configuration, which
>   is not being changed.  We are only creating a virtual irq mapping that
>   exists in the kernel only. One would never expect the PCI hardware to
>   generate the "virq" interrupt.
> 
> Signed-off-by: Michal Ostrowski <mostrows@watson.ibm.com>

Can you fix 32 bits too ?

Ben.

> ---
>  arch/powerpc/kernel/pci_64.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
> index 9bae8a5..81a73fb 100644
> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -1305,7 +1305,6 @@ int pci_read_irq_line(struct pci_dev *pci_dev)
>  	DBG(" -> mapped to linux irq %d\n", virq);
>  
>  	pci_dev->irq = virq;
> -	pci_write_config_byte(pci_dev, PCI_INTERRUPT_LINE, virq);
>  
>  	return 0;
>  }
