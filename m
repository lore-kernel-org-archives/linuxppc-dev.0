Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zdNMP0H5RzF0p3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Feb 2018 05:07:44 +1100 (AEDT)
Date: Fri, 9 Feb 2018 12:07:41 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH kernel v3] powerpc/pci: Fix broken INTx configuration via
 OF
Message-ID: <20180209180741.GB206223@bhelgaas-glaptop.roam.corp.google.com>
References: <20180209062358.33457-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180209062358.33457-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 09, 2018 at 05:23:58PM +1100, Alexey Kardashevskiy wrote:
> Commit 59f47eff03a0 ("powerpc/pci: Use of_irq_parse_and_map_pci() helper")
> replaced of_irq_parse_pci() + irq_create_of_mapping() with
> of_irq_parse_and_map_pci() but this change lost virq returned by
> irq_create_of_mapping() so virq remained zero causing INTx
> misconfiguration.
> 
> This fixes pci_read_irq_line() not to loose a virq returned by
> of_irq_parse_and_map_pci().

s/not to loose a/to not lose the/

> Fixes: 59f47eff03a0 "powerpc/pci: Use of_irq_parse_and_map_pci() helper"
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

I'm fine with this version.

Since you started applying a previous version, Michael, I'll assume
you will handle this unless you tell me otherwise.  One way or another
it would be good to get this in before -rc1.

> ---
> Changes:
> v3:
> * change virq from unsigned to int as of_irq_parse_and_map_pci returns int
> and even though it only returns non-negative values now, this may change
> in the future
> 
> v2:
> * changed the condition from <=0 to !=0 as by design
> of_irq_parse_and_map_pci() can only return 0 for an error and virq>0.
> ---
>  arch/powerpc/kernel/pci-common.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
> index ae2ede4..446c796 100644
> --- a/arch/powerpc/kernel/pci-common.c
> +++ b/arch/powerpc/kernel/pci-common.c
> @@ -362,7 +362,7 @@ struct pci_controller* pci_find_hose_for_OF_device(struct device_node* node)
>   */
>  static int pci_read_irq_line(struct pci_dev *pci_dev)
>  {
> -	unsigned int virq = 0;
> +	int virq;
>  
>  	pr_debug("PCI: Try to map irq for %s...\n", pci_name(pci_dev));
>  
> @@ -370,7 +370,8 @@ static int pci_read_irq_line(struct pci_dev *pci_dev)
>  	memset(&oirq, 0xff, sizeof(oirq));
>  #endif
>  	/* Try to get a mapping from the device-tree */
> -	if (!of_irq_parse_and_map_pci(pci_dev, 0, 0)) {
> +	virq = of_irq_parse_and_map_pci(pci_dev, 0, 0);
> +	if (virq <= 0) {
>  		u8 line, pin;
>  
>  		/* If that fails, lets fallback to what is in the config
> -- 
> 2.11.0
> 
