Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
 [65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2BBEF1007D4
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2011 10:52:51 +1100 (EST)
Received: from mail118-tx2 (localhost [127.0.0.1])	by
 mail118-tx2-R.bigfish.com (Postfix) with ESMTP id 270DA5402BE	for
 <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 23:52:46 +0000 (UTC)
Received: from TX2EHSMHS037.bigfish.com (unknown [10.9.14.241])	by
 mail118-tx2.bigfish.com (Postfix) with ESMTP id ED282300049	for
 <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2011 23:52:45 +0000 (UTC)
Message-ID: <4EE693C9.3080009@freescale.com>
Date: Mon, 12 Dec 2011 17:52:41 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/fsl: add MSI support for the Freescale hypervisor
References: <1323733052-21495-1-git-send-email-timur@freescale.com>
In-Reply-To: <1323733052-21495-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/12/2011 05:37 PM, Timur Tabi wrote:
> @@ -205,6 +207,29 @@ static void __init setup_pci_atmu(struct pci_controller *hose,
>  
>  	/* Setup inbound mem window */
>  	mem = memblock_end_of_DRAM();
> +
> +	/*
> +	 * The msi-address-64 property, if it exists, indicates the physical
> +	 * address of the MSIIR register.  Normally, this register is located
> +	 * inside CCSR, so the ATMU that covers all of CCSR is used for MSIs.
> +	 * But if this property exists, then we'll normally need to create a
> +	 * new ATMU for it.  For now, however, we cheat.  The only entity that
> +	 * creates this property is the Freescale hypervisor, and it
> +	 * always locates MSIIR in the page immediately after the end of DDR.
> +	 * So we can avoid allocating a new ATMU by just extending the DDR
> +	 * ATMU by one page.
> +	 */

Technically, it's up to the hv config file where MSIIR gets mapped.
After main memory is just a common way of configuring it, but won't work
if we're limiting the partition's memory to end at an unusual address.

Might also want to comment that the reason for this weird remapping is
hardware limitations in the IOMMU.

-Scott
