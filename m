Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6E05DDEF8
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:22:16 +1000 (EST)
Subject: Re: [PATCH 2/4] Simplify error logic in rtas_setup_msi_irqs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <9a0ebd42c2e31f6a99a1028dd370f9ee36c771f3.1190270165.git.michael@ellerman.id.au>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
	<9a0ebd42c2e31f6a99a1028dd370f9ee36c771f3.1190270165.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:21:59 +1000
Message-Id: <1191302519.6310.86.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2007-09-20 at 16:36 +1000, Michael Ellerman wrote:
> rtas_setup_msi_irqs() doesn't need to call teardown() itself,
> the generic code will do this for us as long as we return a non
> zero value.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/pseries/msi.c |   17 +++--------------
>  1 files changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 6063ea2..9c3bcfe 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -189,29 +189,22 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  
>  	if (rc != nvec) {
>  		pr_debug("rtas_msi: rtas_change_msi() failed\n");
> -
> -		/*
> -		 * In case of an error it's not clear whether the device is
> -		 * left with MSI enabled or not, so we explicitly disable.
> -		 */
> -		goto out_free;
> +		return rc;
>  	}
>  
>  	i = 0;
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
>  		hwirq = rtas_query_irq_number(pdn, i);
>  		if (hwirq < 0) {
> -			rc = hwirq;
>  			pr_debug("rtas_msi: error (%d) getting hwirq\n", rc);
> -			goto out_free;
> +			return hwirq;
>  		}
>  
>  		virq = irq_create_mapping(NULL, hwirq);
>  
>  		if (virq == NO_IRQ) {
>  			pr_debug("rtas_msi: Failed mapping hwirq %d\n", hwirq);
> -			rc = -ENOSPC;
> -			goto out_free;
> +			return -ENOSPC;
>  		}
>  
>  		dev_dbg(&pdev->dev, "rtas_msi: allocated virq %d\n", virq);
> @@ -220,10 +213,6 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	}
>  
>  	return 0;
> -
> - out_free:
> -	rtas_teardown_msi_irqs(pdev);
> -	return rc;
>  }
>  
>  static void rtas_msi_pci_irq_fixup(struct pci_dev *pdev)
