Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413A61A0557
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 21:23:05 +1100 (AEDT)
Message-ID: <1418293377.13358.130.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/powernv: Remove pnv_pci_probe_mode()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 11 Dec 2014 21:22:57 +1100
In-Reply-To: <1418277658-3541-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1418277658-3541-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-12-11 at 17:00 +1100, Gavin Shan wrote:
> The callback (ppc_md.pci_probe_mode()) is used to determine if the
> child PCI devices of the indicated PCI bus should be probed from
> device-tree or hardware. On PowerNV platform, we always expect
> probing PCI devices from hardware, which is PowerPC PCI core's
> default behaviour. Also, the callback had some delay implemented
> based on PHB's device node property "reset-clear-timestamp", which
> wasn't exported from skiboot. So we don't need this function and
> it's safe to remove it.

Yes all that timestamp stuff was related to the old OPAL which is long
gone.

Cheers,
Ben.

> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 4b20f2c..d346df2 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -782,35 +782,6 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
>  }
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
>  
> -static int pnv_pci_probe_mode(struct pci_bus *bus)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(bus);
> -	const __be64 *tstamp;
> -	u64 now, target;
> -
> -
> -	/* We hijack this as a way to ensure we have waited long
> -	 * enough since the reset was lifted on the PCI bus
> -	 */
> -	if (bus != hose->bus)
> -		return PCI_PROBE_NORMAL;
> -	tstamp = of_get_property(hose->dn, "reset-clear-timestamp", NULL);
> -	if (!tstamp || !*tstamp)
> -		return PCI_PROBE_NORMAL;
> -
> -	now = mftb() / tb_ticks_per_usec;
> -	target = (be64_to_cpup(tstamp) / tb_ticks_per_usec)
> -		+ PCI_RESET_DELAY_US;
> -
> -	pr_devel("pci %04d: Reset target: 0x%llx now: 0x%llx\n",
> -		 hose->global_number, target, now);
> -
> -	if (now < target)
> -		msleep((target - now + 999) / 1000);
> -
> -	return PCI_PROBE_NORMAL;
> -}
> -
>  void __init pnv_pci_init(void)
>  {
>  	struct device_node *np;
> @@ -857,7 +828,6 @@ void __init pnv_pci_init(void)
>  	ppc_md.tce_build_rm = pnv_tce_build_rm;
>  	ppc_md.tce_free_rm = pnv_tce_free_rm;
>  	ppc_md.tce_get = pnv_tce_get;
> -	ppc_md.pci_probe_mode = pnv_pci_probe_mode;
>  	set_pci_dma_ops(&dma_iommu_ops);
>  
>  	/* Configure MSIs */
