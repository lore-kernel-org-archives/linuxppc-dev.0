Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A93DCDDF79
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 05:29:00 +1100 (EST)
Date: Thu, 6 Dec 2007 12:33:19 -0600
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 07/19] [POWERPC] iSeries: unindent and clean
	iSeries_pci_final_fixup
Message-ID: <20071206183319.GA9949@lixom.net>
References: <20071206180045.0eb1db98.sfr@canb.auug.org.au>
	<20071207015148.917436cc.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071207015148.917436cc.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 07, 2007 at 01:51:48AM +1100, Stephen Rothwell wrote:
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/platforms/iseries/pci.c |   68 +++++++++++++++++----------------
>  1 files changed, 35 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/iseries/pci.c b/arch/powerpc/platforms/iseries/pci.c
> index cff832a..8e2ac3d 100644
> --- a/arch/powerpc/platforms/iseries/pci.c
> +++ b/arch/powerpc/platforms/iseries/pci.c
> @@ -177,47 +177,49 @@ void __init iSeries_pci_final_fixup(void)
>  
>  	printk("pcibios_final_fixup\n");
>  	for_each_pci_dev(pdev) {
> +		struct pci_dn *pdn;
> +		const u32 *agent;
> +
>  		node = find_device_node(pdev->bus->number, pdev->devfn);
>  		printk("pci dev %p (%x.%x), node %p\n", pdev,
>  		       pdev->bus->number, pdev->devfn, node);
> +		if (!node) {
> +			printk("PCI: Device Tree not found for 0x%016lX\n",
> +					(unsigned long)pdev);

Hi,

Care to add KERN_ levels, while you're touching it? (both printks above
lack them).


-Olof
