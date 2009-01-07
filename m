Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AAE0EDE27F
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 11:51:47 +1100 (EST)
Subject: Re: [PATCH] [POWERPC] pasemi: ioremap/iounmap balance and failure
	handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Roel Kluin <roel.kluin@gmail.com>
In-Reply-To: <49478879.2030409@gmail.com>
References: <4943E6B5.6010501@gmail.com> <20081213211335.GC17331@lixom.net>
	<49478879.2030409@gmail.com>
Content-Type: text/plain
Date: Wed, 07 Jan 2009 11:50:55 +1100
Message-Id: <1231289455.14860.46.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> +
>  	iob_regs = map_onedev(iob_pdev, 0);
> +	if (iob_regs == NULL)
> +		printk(KERN_WARNING "pasemi_dma_init: Can't ioremap I/O Bridge registers\n");
>  
>  	dma_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa007, NULL);
>  	if (!dma_pdev) {
>  		BUG();
>  		printk(KERN_WARNING "Can't find DMA controller\n");
>  		err = -ENODEV;
> -		goto out;
> +		goto out_unmap;
>  	}

None of that will be reached due to the previous BUG :-)

Cheers,
Ben.
