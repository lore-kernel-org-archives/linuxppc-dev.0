Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 86E1EDE10C
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Dec 2008 08:05:34 +1100 (EST)
Date: Sat, 13 Dec 2008 15:13:35 -0600
From: Olof Johansson <olof@lixom.net>
To: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] [POWERPC] pasemi: ioremap/iounmap balance and failure
	handling
Message-ID: <20081213211335.GC17331@lixom.net>
References: <4943E6B5.6010501@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4943E6B5.6010501@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 13, 2008 at 05:45:41PM +0100, Roel Kluin wrote:
> map_onedev can return NULL, so catch that. Also iounmap if DMA controller can't be
> found.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> UNTESTED! I am a bit new, so please confirm whether this is correct. especially: 
> 
> * can we iounmap while init_lock is held?

Yes, should be OK.

> * is it ok to add another BUG() here?
> 
> diff --git a/arch/powerpc/platforms/pasemi/dma_lib.c b/arch/powerpc/platforms/pasemi/dma_lib.c
> index 217af32..bdf5440 100644
> --- a/arch/powerpc/platforms/pasemi/dma_lib.c
> +++ b/arch/powerpc/platforms/pasemi/dma_lib.c
> @@ -534,14 +534,21 @@ int pasemi_dma_init(void)
>  		err = -ENODEV;
>  		goto out;
>  	}
> +
>  	iob_regs = map_onedev(iob_pdev, 0);
> +	if (iob_regs == NULL) {
> +		BUG();
> +		printk(KERN_WARNING "Can't ioremap I/O Bridge registers\n");
> +		err = -ENODEV;
> +		goto out;
> +	}

I don't see the point of doing BUG() _and_ error recovery. BUG() is
definitely heavy handed. Something like "pasemi_dma_init: Can't..." would
be a good and detailed enough error message.

>  
>  	dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
>  	if (!dma_pdev) {
>  		BUG();
>  		printk(KERN_WARNING "Can't find DMA controller\n");
>  		err = -ENODEV;
> -		goto out;
> +		goto out_unmap;
>  	}
>  	dma_regs = map_onedev(dma_pdev, 0);
>  	base_hw_irq = virq_to_hw(dma_pdev->irq);
> @@ -624,6 +631,10 @@ int pasemi_dma_init(void)
>  
>  	printk(KERN_INFO "PA Semi PWRficient DMA library initialized "
>  		"(%d tx, %d rx channels)\n", num_txch, num_rxch);
> +	goto out;
> +
> +out_unmap:
> +	iounmap(iob_regs);
>  
>  out:
>  	spin_unlock(&init_lock);
