Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14FED1A054E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 17:30:02 +1000 (EST)
Message-ID: <1402471784.14780.45.camel@pasglop>
Subject: Re: [PATCH] powerpc: reduce multi-hit of pcibios_setup_device() in
 hotplug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Wed, 11 Jun 2014 17:29:44 +1000
In-Reply-To: <20140611071241.GA10729@richard>
References: <1399530602-4231-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1399863559.17624.66.camel@pasglop> <20140611071241.GA10729@richard>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bjorn Helgaas <bhelgaas@google.com>, aik@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-06-11 at 15:12 +0800, Wei Yang wrote:

> Sorry for the long delay. It took me some time to investigate and test the code.
> Currently, the hotplug by qemu monitor command line has been verified. Two pci
> device on the same bus have been hotpluged one by one successfully.
> 
> Another case in my mind is the EEH hotplug, which requires code in
> Qemu/Sapphire/Kernel. I will did further test later.
> 
> Below is the patch which is verified in guest with monitor command line. If my
> understanding is not correct, please let me know :-)

Please verify under pHyp, the code path are a bit different.

Cheers,
Ben.

> >From 69c5f014836b24897356731c39cbaf18f4563573 Mon Sep 17 00:00:00 2001
> From: Wei Yang <weiyang@linux.vnet.ibm.com>
> Date: Tue, 10 Jun 2014 15:28:53 +0800
> Subject: [PATCH] powerpc/pci: Use bus->is_added in of_scan_bus() as in
>  general platform
> 
> When scan the pci bus on general platform, it use bus->is_added to mark the
> bus has been added successfully. While this flag is not used when the bus scan
> relies on device node. Instead, it uses a particular parameter
> "rescan_existing" to play the same role.
> 
> This patch enables the bus->is_added when device node is used, drops the
> "rescan_existing" parameter. Also it skip the pcibios_setup_bus_devices()
> procedure when bus has already been added, since the pcibios_setup_device()
> step is done in pci_device_add() when the bus is already added.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci_of_scan.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci_of_scan.c b/arch/powerpc/kernel/pci_of_scan.c
> index 83c26d8..3e943ab 100644
> --- a/arch/powerpc/kernel/pci_of_scan.c
> +++ b/arch/powerpc/kernel/pci_of_scan.c
> @@ -334,10 +334,8 @@ static struct pci_dev *of_scan_pci_dev(struct pci_bus *bus,
>   * __of_scan_bus - given a PCI bus node, setup bus and scan for child devices
>   * @node: device tree node for the PCI bus
>   * @bus: pci_bus structure for the PCI bus
> - * @rescan_existing: Flag indicating bus has already been set up
>   */
> -static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
> -			  int rescan_existing)
> +static void __of_scan_bus(struct device_node *node, struct pci_bus *bus)
>  {
>  	struct device_node *child;
>  	struct pci_dev *dev;
> @@ -356,9 +354,11 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
>  	/* Apply all fixups necessary. We don't fixup the bus "self"
>  	 * for an existing bridge that is being rescanned
>  	 */
> -	if (!rescan_existing)
> +	if (!bus->is_added) {
>  		pcibios_setup_bus_self(bus);
> -	pcibios_setup_bus_devices(bus);
> +		pcibios_setup_bus_devices(bus);
> +		bus->is_added = 1;
> +	}
>  
>  	/* Now scan child busses */
>  	list_for_each_entry(dev, &bus->devices, bus_list) {
> @@ -376,7 +376,7 @@ static void __of_scan_bus(struct device_node *node, struct pci_bus *bus,
>   */
>  void of_scan_bus(struct device_node *node, struct pci_bus *bus)
>  {
> -	__of_scan_bus(node, bus, 0);
> +	__of_scan_bus(node, bus);
>  }
>  EXPORT_SYMBOL_GPL(of_scan_bus);
>  
> @@ -390,7 +390,7 @@ EXPORT_SYMBOL_GPL(of_scan_bus);
>   */
>  void of_rescan_bus(struct device_node *node, struct pci_bus *bus)
>  {
> -	__of_scan_bus(node, bus, 1);
> +	__of_scan_bus(node, bus);
>  }
>  EXPORT_SYMBOL_GPL(of_rescan_bus);
>  
> -- 
> 1.7.9.5
> 
> >
> >
> >_______________________________________________
> >Linuxppc-dev mailing list
> >Linuxppc-dev@lists.ozlabs.org
> >https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
