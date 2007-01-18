Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A9713DDEC7
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jan 2007 11:30:56 +1100 (EST)
Subject: Re: [PATCH 13/19] powerpc: Supporting iommu for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200701120113.l0C1D5WP000520@toshiba.co.jp>
References: <200701120113.l0C1D5WP000520@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 18 Jan 2007 11:31:20 +1100
Message-Id: <1169080280.4965.21.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> +static int __init celleb_init_iommu(void)
> +{

This needs a:

	if (!machine_is(celleb))
		return 0;

Since the initcall will always be called wether your platform was
selected at boot or not as long as it's built into the kernel.

> +	celleb_init_direct_mapping();
> +	pci_dma_ops = &dma_direct_ops;
> +	bus_register_notifier(&of_platform_bus_type, &celleb_of_bus_notifier);
> +
> +	return 0;
> +}
> +
> +arch_initcall(celleb_init_iommu);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
