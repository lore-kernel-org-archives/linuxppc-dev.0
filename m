Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BA5B5DE299
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:23:35 +1000 (EST)
Subject: Re: [PATCH 3/4] Simplify rtas_change_msi() error semantics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <fbd88f287ba9d9ca41b5c8da734afd595ae25922.1190270165.git.michael@ellerman.id.au>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
	<fbd88f287ba9d9ca41b5c8da734afd595ae25922.1190270165.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:23:23 +1000
Message-Id: <1191302603.6310.88.camel@pasglop>
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
> Currently rtas_change_msi() returns either the error code from RTAS, or if
> the RTAS call succeeded the number of irqs that were configured by RTAS.
> This makes checking the return value more complicated than it needs to be.
> 
> Instead, have rtas_change_msi() check that the number of irqs configured by
> RTAS is equal to what we requested - and return an error otherwise. This makes
> the return semantics match the usual 0 for success, something else for error.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Looks allright, just a question tho... what do we do if it fails ? Do we
try to fallback to a lower number of MSIs ? Or what ? Dead device ?

Ben.

> ---
>  arch/powerpc/platforms/pseries/msi.c |   18 +++++++++++-------
>  1 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/msi.c b/arch/powerpc/platforms/pseries/msi.c
> index 9c3bcfe..2793a1b 100644
> --- a/arch/powerpc/platforms/pseries/msi.c
> +++ b/arch/powerpc/platforms/pseries/msi.c
> @@ -70,11 +70,15 @@ static int rtas_change_msi(struct pci_dn *pdn, u32 func, u32 num_irqs)
>  		seq_num = rtas_ret[1];
>  	} while (rtas_busy_delay(rc));
>  
> -	if (rc == 0) /* Success */
> -		rc = rtas_ret[0];
> +	/*
> +	 * If the RTAS call succeeded, check the number of irqs is actually
> +	 * what we asked for. If not, return an error.
> +	 */
> +	if (rc == 0 && rtas_ret[0] != num_irqs)
> +		rc = -ENOSPC;
>  
> -	pr_debug("rtas_msi: ibm,change_msi(func=%d,num=%d) = (%d)\n",
> -		 func, num_irqs, rc);
> +	pr_debug("rtas_msi: ibm,change_msi(func=%d,num=%d), got %d rc = %d\n",
> +		 func, num_irqs, rtas_ret[0], rc);
>  
>  	return rc;
>  }
> @@ -87,7 +91,7 @@ static void rtas_disable_msi(struct pci_dev *pdev)
>  	if (!pdn)
>  		return;
>  
> -	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0) != 0)
> +	if (rtas_change_msi(pdn, RTAS_CHANGE_FN, 0))
>  		pr_debug("rtas_msi: Setting MSIs to 0 failed!\n");
>  }
>  
> @@ -180,14 +184,14 @@ static int rtas_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
>  	if (type == PCI_CAP_ID_MSI) {
>  		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSI_FN, nvec);
>  
> -		if (rc != nvec) {
> +		if (rc) {
>  			pr_debug("rtas_msi: trying the old firmware call.\n");
>  			rc = rtas_change_msi(pdn, RTAS_CHANGE_FN, nvec);
>  		}
>  	} else
>  		rc = rtas_change_msi(pdn, RTAS_CHANGE_MSIX_FN, nvec);
>  
> -	if (rc != nvec) {
> +	if (rc) {
>  		pr_debug("rtas_msi: rtas_change_msi() failed\n");
>  		return rc;
>  	}
