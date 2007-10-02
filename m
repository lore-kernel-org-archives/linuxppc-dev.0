Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 575E0DDE35
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:09:34 +1000 (EST)
Subject: Re: [PATCH] Make sure to of_node_get() the result of
	pci_device_to_OF_node()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <8183225ab4b14684bb0939e0c5258caaf5b8102f.1190008974.git.michael@ellerman.id.au>
References: <8183225ab4b14684bb0939e0c5258caaf5b8102f.1190008974.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:09:21 +1000
Message-Id: <1191301761.6310.64.camel@pasglop>
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


On Mon, 2007-09-17 at 16:03 +1000, Michael Ellerman wrote:
> pci_device_to_OF_node() returns the device node attached to a PCI device,
> but doesn't actually grab a reference - we need to do it ourselves.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/platforms/cell/axon_msi.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/cell/axon_msi.c b/arch/powerpc/platforms/cell/axon_msi.c
> index 57a6149..2b2dfcc 100644
> --- a/arch/powerpc/platforms/cell/axon_msi.c
> +++ b/arch/powerpc/platforms/cell/axon_msi.c
> @@ -119,7 +119,7 @@ static struct axon_msic *find_msi_translator(struct pci_dev *dev)
>  	const phandle *ph;
>  	struct axon_msic *msic = NULL;
>  
> -	dn = pci_device_to_OF_node(dev);
> +	dn = of_node_get(pci_device_to_OF_node(dev));
>  	if (!dn) {
>  		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
>  		return NULL;
> @@ -176,7 +176,7 @@ static int setup_msi_msg_address(struct pci_dev *dev, struct msi_msg *msg)
>  	int len;
>  	const u32 *prop;
>  
> -	dn = pci_device_to_OF_node(dev);
> +	dn = of_node_get(pci_device_to_OF_node(dev));
>  	if (!dn) {
>  		dev_dbg(&dev->dev, "axon_msi: no pci_dn found\n");
>  		return -ENODEV;
