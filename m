Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net
	[151.189.21.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E9A2A67BF3
	for <linuxppc-dev@ozlabs.org>; Sun,  5 Nov 2006 02:40:39 +1100 (EST)
In-Reply-To: <1162589327.10630.125.camel@localhost.localdomain>
References: <1162589327.10630.125.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <A9F3AC31-AB61-4E39-86D7-B14B96B50B4D@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Create PCI busses from of_platform
Date: Sat, 4 Nov 2006 16:40:31 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +static struct of_device_id of_pci_phb_ids[] = {
> +	{ .type = "pci", },
> +	{ .type = "pcix", },
> +	{ .type = "pcie", },
> +	{ .type = "pciex", },
> +	{ .type = "ht", },
> +	{}
> +};
> +
> +static struct of_platform_driver of_pci_phb_driver = {
> +       .name = "of-pci",
> +       .match_table = of_pci_phb_ids,
> +       .probe = of_pci_phb_probe,
> +       .driver = {
> +	       .multithread_probe = 1,
> +       },
> +};

Shouldn't you also/only check for compatible=pci?  Or maybe
that would give too much fallout from all the broken device
trees out there?


Segher
