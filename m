Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8072414008D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:35:43 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 21 Apr 2014 13:35:38 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3163D2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:35:36 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3L3ZLiS131370
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:35:21 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3L3ZZlO016414
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Apr 2014 13:35:35 +1000
Message-ID: <1398051334.19682.14.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/powernv: clear the refcount for pci_dev on
 powernv platform
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Date: Mon, 21 Apr 2014 13:35:34 +1000
In-Reply-To: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1398047119-6861-1-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: aik@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 Gavin Shan <gwshan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-21 at 10:25 +0800, Wei Yang wrote:
> When pcibios_remove_pci_devices() is removing pci devices, it will release
> pci device respectively. When the refcount of the device is 0, the pci_dev
> structure will be destroyed.
> 
> On PowerNV platform, the pci_dev will not be destroyed since the refcount is
> not 0.
> 
> After applying the patch, this warning is cleared during the EEH hotplug
> event.

You have to be careful here. We take a reference to the device in the
structure eeh_dev, that means we might access it after it's freed if
we don't increase the refcount.

Cheers,
Ben.

> [  204.123609] ------------[ cut here ]------------
> [  204.123645] WARNING: at arch/powerpc/kernel/iommu.c:1125
> [  204.123680] Modules linked in: xt_CHECKSUM nf_conntrack_netbios_ns nf_conntrack_broadcast ipt_MASQUERADE ip6t_REJECT bnep bluetooth 6lowpan_iphc rfkill xt_conntrack ebtable_nat ebtable_broute bridge stp llc mlx4_ib ib_sa ib_mad ib_core ib_addr ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw bnx2x tg3 mlx4_core nfsd ptp mdio ses libcrc32c nfs_acl enclosure be2net pps_core shpchp lockd kvm uinput sunrpc binfmt_misc lpfc scsi_transport_fc ipr scsi_tgt
> [  204.124356] CPU: 18 PID: 650 Comm: eehd Not tainted 3.14.0-rc5yw+ #102
> [  204.124400] task: c0000027ed485670 ti: c0000027ed50c000 task.ti: c0000027ed50c000
> [  204.124453] NIP: c00000000003cf80 LR: c00000000006c648 CTR: c00000000006c5c0
> [  204.124506] REGS: c0000027ed50f440 TRAP: 0700   Not tainted  (3.14.0-rc5yw+)
> [  204.124558] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 88008084  XER: 20000000
> [  204.124682] CFAR: c00000000006c644 SOFTE: 1
> GPR00: c00000000006c648 c0000027ed50f6c0 c000000001398380 c0000027ec260300
> GPR04: c0000027ea92c000 c00000000006ad00 c0000000016e41b0 0000000000000110
> GPR08: c0000000012cd4c0 0000000000000001 c0000027ec2602ff 0000000000000062
> GPR12: 0000000028008084 c00000000fdca200 c0000000000d1d90 c0000027ec281a80
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000001
> GPR24: 000000005342697b 0000000000002906 c000001fe6ac9800 c000001fe6ac9800
> GPR28: 0000000000000000 c0000000016e3a80 c0000027ea92c090 c0000027ea92c000
> [  204.125353] NIP [c00000000003cf80] .iommu_add_device+0x30/0x1f0
> [  204.125399] LR [c00000000006c648] .pnv_pci_ioda_dma_dev_setup+0x88/0xb0
> [  204.125443] Call Trace:
> [  204.125464] [c0000027ed50f6c0] [c0000027ed50f750] 0xc0000027ed50f750 (unreliable)
> [  204.125526] [c0000027ed50f750] [c00000000006c648] .pnv_pci_ioda_dma_dev_setup+0x88/0xb0
> [  204.125588] [c0000027ed50f7d0] [c000000000069cc8] .pnv_pci_dma_dev_setup+0x78/0x340
> [  204.125650] [c0000027ed50f870] [c000000000044408] .pcibios_setup_device+0x88/0x2f0
> [  204.125712] [c0000027ed50f940] [c000000000046040] .pcibios_setup_bus_devices+0x60/0xd0
> [  204.125774] [c0000027ed50f9c0] [c000000000043acc] .pcibios_add_pci_devices+0xdc/0x1c0
> [  204.125837] [c0000027ed50fa50] [c00000000086f970] .eeh_reset_device+0x36c/0x4f0
> [  204.125939] [c0000027ed50fb20] [c00000000003a2d8] .eeh_handle_normal_event+0x448/0x480
> [  204.126068] [c0000027ed50fbc0] [c00000000003a35c] .eeh_handle_event+0x4c/0x340
> [  204.126192] [c0000027ed50fc80] [c00000000003a74c] .eeh_event_handler+0xfc/0x1b0
> [  204.126319] [c0000027ed50fd30] [c0000000000d1ea0] .kthread+0x110/0x130
> [  204.126430] [c0000027ed50fe30] [c00000000000a460] .ret_from_kernel_thread+0x5c/0x7c
> [  204.126556] Instruction dump:
> [  204.126610] 7c0802a6 fba1ffe8 fbc1fff0 fbe1fff8 f8010010 f821ff71 7c7e1b78 60000000
> [  204.126787] 60000000 e87e0298 3143ffff 7d2a1910 <0b090000> 2fa90000 40de00c8 ebfe0218
> [  204.126966] ---[ end trace 6e7aefd80add2973 ]---
> 
> This patch clear the step to get reference.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index e2270f4..fc4edda 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -561,7 +561,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>  				pci_name(dev));
>  			continue;
>  		}
> -		pci_dev_get(dev);
>  		pdn->pcidev = dev;
>  		pdn->pe_number = pe->pe_number;
>  		pe->dma_weight += pnv_ioda_dma_weight(dev);
