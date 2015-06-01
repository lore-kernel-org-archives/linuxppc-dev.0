Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 781131A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 09:20:11 +1000 (AEST)
Received: by igbhj9 with SMTP id hj9so73880169igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 16:20:08 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:20:05 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 03/10] powerpc/pci: Remove VFs prior to PF
Message-ID: <20150601232005.GD3631@google.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-4-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432032612-21701-4-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 06:50:05PM +0800, Wei Yang wrote:
> As commit ac205b7b ("PCI: make sriov work with hotplug remove") indicates,

The conventional reference is:

  ac205b7bb72f ("PCI: make sriov work with hotplug remove")

> VFs, which might be hooked to same PCI bus as their PF should be removed
> before the PF. Otherwise, the PCI hot unplugging on the PCI bus would
> cause kernel crash.
> 
> The patch applies the above pattern to PowerPC PCI hotplug path.
> 
> [gwshan: changelog]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci-hotplug.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 7ed85a6..98f84ed 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -50,7 +50,7 @@ void pcibios_remove_pci_devices(struct pci_bus *bus)
>  
>  	pr_debug("PCI: Removing devices on bus %04x:%02x\n",
>  		 pci_domain_nr(bus),  bus->number);
> -	list_for_each_entry_safe(dev, tmp, &bus->devices, bus_list) {
> +	list_for_each_entry_safe_reverse(dev, tmp, &bus->devices, bus_list) {
>  		pr_debug("   Removing %s...\n", pci_name(dev));
>  		pci_stop_and_remove_bus_device(dev);
>  	}
> -- 
> 1.7.9.5
> 
