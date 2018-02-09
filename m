Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zd4502Wj7zF0rL
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Feb 2018 16:54:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH kernel v2] powerpc/pci: Fix broken INTx configuration via
 OF
In-Reply-To: <20180209024125.38862-1-aik@ozlabs.ru>
References: <20180209024125.38862-1-aik@ozlabs.ru>
Date: Fri, 09 Feb 2018 16:54:11 +1100
Message-ID: <87vaf6wvwc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> replaced of_irq_parse_pci() + irq_create_of_mapping() with
> of_irq_parse_and_map_pci() but this change lost virq returned by
> irq_create_of_mapping() so virq remained zero causing INTx
> misconfiguration.
>
> This fixes pci_read_irq_line() not to loose a virq returned by
> of_irq_parse_and_map_pci().
>
> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v2:
> * changed the condition from <=0 to !=0 as by design
> of_irq_parse_and_map_pci() can only return 0 for an error and virq>0.

It returns int, so you should store the result in an int, and check the
result for <= 0.

Otherwise if it starts returning a negative error value this code will
break.

If it's a problem that of_irq_parse_and_map_pci() might internally
convert an unsigned virq to int then we need to fix that there, or make
of_irq_parse_and_map_pci() return unsigned also.

cheers

> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index ae2ede4..33580a9 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -362,7 +362,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
>   */
>  static int pci_read_irq_line(struct pci_dev *pci_dev)
>  {
> -	unsigned int virq = 0;
> +	unsigned int virq;
>  
>  	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
>  
> @@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  	memset(&oirq, 0xff, sizeof(oirq));
>  #endif
>  	/* Try to get a mapping from the device-tree */
> -	if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
> +	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> +	if (!virq) {
>  		u8 line, pin;
>  
>  		/* If that fails, lets fallback to what is in the config
> -- 
> 2.11.0
