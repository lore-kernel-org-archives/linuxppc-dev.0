Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 31C82DDEDB
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:21:47 +1000 (EST)
Subject: Re: [PATCH 1/4] Simplify error logic in u3msi_setup_msi_irqs()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:21:34 +1000
Message-Id: <1191302494.6310.84.camel@pasglop>
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
> u3msi_setup_msi_irqs() doesn't need to call teardown() itself,
> the generic code will do this for us as long as we return a non
> zero value.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/sysdev/mpic_u3msi.c |   11 ++---------
>  1 files changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic_u3msi.c b/arch/powerpc/sysdev/mpic_u3msi.c
> index 305b864..4e50d1c 100644
> --- a/arch/powerpc/sysdev/mpic_u3msi.c
> +++ b/arch/powerpc/sysdev/mpic_u3msi.c
> @@ -124,7 +124,6 @@ static void u3msi_compose_msi_msg(struct pci_dev *pdev, int virq,
>  static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  {
>  	irq_hw_number_t hwirq;
> -	int rc;
>  	unsigned int virq;
>  	struct msi_desc *entry;
>  	struct msi_msg msg;
> @@ -132,17 +131,15 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	list_for_each_entry(entry, &pdev->msi_list, list) {
>  		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
>  		if (hwirq < 0) {
> -			rc = hwirq;
>  			pr_debug("u3msi: failed allocating hwirq\n");
> -			goto out_free;
> +			return hwirq;
>  		}
>  
>  		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
>  		if (virq == NO_IRQ) {
>  			pr_debug("u3msi: failed mapping hwirq 0x%lx\n", hwirq);
>  			mpic_msi_free_hwirqs(msi_mpic, hwirq, 1);
> -			rc = -ENOSPC;
> -			goto out_free;
> +			return -ENOSPC;
>  		}
>  
>  		set_irq_msi(virq, entry);
> @@ -156,10 +153,6 @@ static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	}
>  
>  	return 0;
> -
> - out_free:
> -	u3msi_teardown_msi_irqs(pdev);
> -	return rc;
>  }
>  
>  int mpic_u3msi_init(struct mpic *mpic)
