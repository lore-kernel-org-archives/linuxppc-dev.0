Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B9DF67C48
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Oct 2006 06:53:44 +1000 (EST)
Subject: Re: [POWERPC] Don't get PCI IRQ from OF for devices with no IRQ
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <200610071959.k97JxIK9026331@hera.kernel.org>
References: <200610071959.k97JxIK9026331@hera.kernel.org>
Content-Type: text/plain
Date: Mon, 09 Oct 2006 06:53:23 +1000
Message-Id: <1160340803.5926.2.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-10-07 at 19:59 +0000, Linux Kernel Mailing List wrote:
> commit 41550c5128150175197257b6ceab2cd50dea7b51
> tree 9406c5680e5e7fd49804fe95104453b272533f28
> parent c998de146061db17787c1a31a3db1989f1341fdf
> author Benjamin Herrenschmidt <benh@kernel.crashing.org> 1160030441 +1000
> committer Paul Mackerras <paulus@samba.org> 1160133041 +1000
> 
> [POWERPC] Don't get PCI IRQ from OF for devices with no IRQ

Hi Linus !

Please revert this one for now. It seems to break G5s :( Looks like PCI
cells inside Apple IO ASICs don't have a PCI_INTERRUPT_LINE set. I need
to figure out a better fix.

Cheers,
Ben.

> This patch adds checking of the PCI_INTERRUPT_PIN register before
> using standard OF parsing to retreive PCI interrupts. The reason is
> that some PCI devices may have no PCI interrupt, though they may have
> interrupts attached via other means. In this case, we shall not use
> irq->pdev, but device-specific code can later retreive those interrupts
> instead.
> 
> Without that patch, Maple and derivatives don't get the right interrupt
> for the second IDE channel as the linux IDE code fallsback to the PCI
> irq instead of trying to use the legacy ones for the on-board controller
> (which has no PCI_INTERRUPT_PIN). Having no PCI IRQ assign to it (as it
> doesn't request any) fixes it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> 
>  arch/powerpc/kernel/prom_parse.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
> index 603dff3..17fcb48 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -914,6 +914,17 @@ int of_irq_map_pci(struct pci_dev *pdev,
>  	u8 pin;
>  	int rc;
>  
> +	/* We need to first check if the PCI device has a PCI interrupt at all
> +	 * since we have cases where the device-node might expose non-PCI
> +	 * interrupts, but the device has no PCI interrupt to it
> +	 */
> +	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> +	if (rc != 0)
> +		return rc;
> +	/* No pin, exit */
> +	if (pin == 0)
> +		return -ENODEV;
> +
>  	/* Check if we have a device node, if yes, fallback to standard OF
>  	 * parsing
>  	 */
> @@ -925,12 +936,6 @@ int of_irq_map_pci(struct pci_dev *pdev,
>  	 * interrupt spec.  we assume #interrupt-cells is 1, which is standard
>  	 * for PCI. If you do different, then don't use that routine.
>  	 */
> -	rc = pci_read_config_byte(pdev, PCI_INTERRUPT_PIN, &pin);
> -	if (rc != 0)
> -		return rc;
> -	/* No pin, exit */
> -	if (pin == 0)
> -		return -ENODEV;
>  
>  	/* Now we walk up the PCI tree */
>  	lspec = pin;
> -
> To unsubscribe from this list: send the line "unsubscribe git-commits-head" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
