Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 36D2B67BDA
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Dec 2006 23:45:38 +1100 (EST)
Message-ID: <457418CF.9040303@ru.mvista.com>
Date: Mon, 04 Dec 2006 15:47:11 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] mark PCI resource with start 0 as unassigned
References: <20061130165202.GA23205@aepfle.de>
	<20061204123854.GA28159@aepfle.de>
In-Reply-To: <20061204123854.GA28159@aepfle.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Olaf Hering wrote:
> mark pci resources with start 0 as unassigned
> libata calls pci_request_regions to claim bar 0 - 5
> bar 5 has base 0.
> Tested on a p630 in SMP mode with pata_sl82c105

[...]

> --- a/arch/powerpc/kernel/pci_64.c
> +++ b/arch/powerpc/kernel/pci_64.c
> @@ -1234,6 +1234,14 @@ static void __devinit fixup_resource(str
>  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>  	unsigned long start, end, mask, offset;
>  
> +	/*
> +	 * tell the core code that this ressource is unassigned
> +	 * fixes p630 winbond IDE with libata
> +	 */
> +	if (res->start == 0) {
> +		res->flags = 0;

     Wouldn't it be better to set flags to IORESOURCE_UNSET to get it reassigned?

> +		return;
> +	}
>  	if (res->flags & IORESOURCE_IO) {
>  		offset = (unsigned long)hose->io_base_virt - pci_io_base;
> 

WBR, Sergei
