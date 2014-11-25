Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CFC981A04BF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 09:58:16 +1100 (AEDT)
Message-ID: <1416956282.5089.4.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/8] powerpc/pci: Don't scan empty slot
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Wed, 26 Nov 2014 09:58:02 +1100
In-Reply-To: <1416869365-7671-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1416869365-7671-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1416869365-7671-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-25 at 09:49 +1100, Gavin Shan wrote:
> In hotplug case, function pcibios_add_pci_devices() is called to
> rescan the specified PCI bus, which possibly doesn't have any child
> devices. Access to the PCI bus's child device node will cause kernel
> crash without exception. The patch adds two more conditions to avoid
> the kernel crash.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/pci-hotplug.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
> index 6e2b4e3..ea5513b 100644
> --- a/arch/powerpc/kernel/pci-hotplug.c
> +++ b/arch/powerpc/kernel/pci-hotplug.c
> @@ -105,7 +105,7 @@ EXPORT_SYMBOL_GPL(pcibios_remove_pci_devices);
>   * is how this routine differs from other, similar pcibios
>   * routines.)
>   */
> -void pcibios_add_pci_devices(struct pci_bus * bus)
> +void pcibios_add_pci_devices(struct pci_bus *bus)

Unrelated whitespace change

>  {
>  	int slotno, mode, pass, max;
>  	struct pci_dev *dev;
> @@ -120,7 +120,8 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
>  	if (mode == PCI_PROBE_DEVTREE) {
>  		/* use ofdt-based probe */
>  		of_rescan_bus(dn, bus);
> -	} else if (mode == PCI_PROBE_NORMAL) {
> +	} else if (mode == PCI_PROBE_NORMAL &&
> +		   dn->child && PCI_DN(dn->child)) {
>  		/*
>  		 * Use legacy probe. In the partial hotplug case, we
>  		 * probably have grandchildren devices unplugged. So
