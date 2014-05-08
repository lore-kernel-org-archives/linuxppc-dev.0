Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 525BB1401B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 16:30:11 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 8 May 2014 16:30:10 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9B88D2BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 May 2014 16:30:08 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4868vMK45547660
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 16:08:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s486U77b006226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 May 2014 16:30:07 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, aik@au1.ibm.com
Subject: [PATCH] powerpc: reduce multi-hit of pcibios_setup_device() in hotplug
Date: Thu,  8 May 2014 14:30:02 +0800
Message-Id: <1399530602-4231-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During the EEH hotplug event, pcibios_setup_device() will be invoked two
times. And the last time will trigger a warning of re-attachment of iommu
group.

The two times are:

    pci_device_add
        ...
        pcibios_add_device
        pcibios_setup_device   <- 1st time
    pcibios_add_pci_devices
        ...
        pcibios_setup_bus_devices
        pcibios_setup_device   <- 2rd time

As we see, in pcibios_add_pci_devices() the pci_bus passed in as a parameter
is initialized and already added in the system. Which means the
pcibios_setup_device() in pcibios_add_device() will be called. Then the
pcibios_setup_device() in pcibios_setup_bus_devices() is the 2nd time to be
called on the same pci_dev.

After applying the patch, the warning of re-attach the iommu group will be
fixed.

[  161.133979] ------------[ cut here ]------------
[  161.134013] WARNING: at arch/powerpc/kernel/iommu.c:1125
[  161.134046] Modules linked in: xt_CHECKSUM bnep bluetooth 6lowpan_iphc rfkill nf_conntrack_netbios_ns nf_conntrack_broadcast ipt_MASQUERADE ip6t_REJECT xt_conntrack ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw mlx4_ib ib_sa ib_mad ib_core ib_addr bnx2x ses enclosure mlx4_core(O) tg3 be2net ptp pps_core mdio libcrc32c shpchp kvm nfsd nfs_acl lockd sunrpc binfmt_misc uinput lpfc scsi_transport_fc ipr scsi_tgt
[  161.134678] CPU: 23 PID: 650 Comm: eehd Tainted: G           O 3.14.0-rc5yw+ #173
[  161.134727] task: c0000027ed485670 ti: c0000027ed50c000 task.ti: c0000027ed50c000
[  161.134777] NIP: c00000000003ca40 LR: c00000000006c738 CTR: c00000000006c6b0
[  161.134827] REGS: c0000027ed50f470 TRAP: 0700   Tainted: G           O  (3.14.0-rc5yw+)
[  161.134876] MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 88008084  XER: 20000000
[  161.134992] CFAR: c00000000006c734 SOFTE: 1
GPR00: c00000000006c738 c0000027ed50f6f0 c0000000013982f0 c0000027ed464000
GPR04: c0000027e8a87000 c00000000006a980 c0000000016e84a0 0000000000004400
GPR08: c0000000012cd490 0000000000000001 c0000027ed463fff 000000003003b868
GPR12: 0000000028008084 c00000000fdccf00 c0000000000d1970 c000002d74cf0840
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
GPR24: 0000000000000001 000000005360a3b9 00000000000f2d17 c000000fe7659800
GPR28: 0000000000000000 c0000000016e3a80 c0000027e8a87090 c0000027e8a87000
[  161.135624] NIP [c00000000003ca40] .iommu_add_device+0x30/0x1f0
[  161.135668] LR [c00000000006c738] .pnv_pci_ioda_dma_dev_setup+0x88/0xb0
[  161.135709] Call Trace:
[  161.135728] [c0000027ed50f6f0] [c0000027ed50f780] 0xc0000027ed50f780 (unreliable)
[  161.135787] [c0000027ed50f780] [c00000000006c738] .pnv_pci_ioda_dma_dev_setup+0x88/0xb0
[  161.135845] [c0000027ed50f800] [c0000000000699c8] .pnv_pci_dma_dev_setup+0x78/0x310
[  161.135903] [c0000027ed50f8a0] [c000000000044008] .pcibios_setup_device+0x88/0x2f0
[  161.135961] [c0000027ed50f970] [c000000000045d40] .pcibios_setup_bus_devices+0x60/0xd0
[  161.136019] [c0000027ed50f9f0] [c0000000000436dc] .pcibios_add_pci_devices+0xdc/0x1c0
[  161.136078] [c0000027ed50fa80] [c00000000086f4ac] .eeh_reset_device+0x21c/0x2d8
[  161.136136] [c0000027ed50fb40] [c000000000039db8] .eeh_handle_normal_event+0x3b8/0x3f0
[  161.136193] [c0000027ed50fbd0] [c000000000039e38] .eeh_handle_event+0x48/0x320
[  161.136251] [c0000027ed50fc80] [c00000000003a20c] .eeh_event_handler+0xfc/0x1b0
[  161.136309] [c0000027ed50fd30] [c0000000000d1a80] .kthread+0x110/0x130
[  161.136360] [c0000027ed50fe30] [c00000000000a460] .ret_from_kernel_thread+0x5c/0x7c
[  161.136417] Instruction dump:
[  161.136442] 7c0802a6 fba1ffe8 fbc1fff0 fbe1fff8 f8010010 f821ff71 7c7e1b78 60000000
[  161.136524] 60000000 e87e0298 3143ffff 7d2a1910 <0b090000> 2fa90000 40de00c8 ebfe0218
[  161.136608] ---[ end trace b959c4ca6f08c270 ]---
[  161.136641] iommu_tce: device 0003:05:00.0 is already in iommu group 7, skipping

This patch removes the pcibios_setup_bus_devices() in
pcibios_add_pci_devices().

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/pci-hotplug.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index c1e17ae..39a1bac 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -94,7 +94,6 @@ void pcibios_add_pci_devices(struct pci_bus * bus)
 		 */
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 		pci_scan_slot(bus, PCI_DEVFN(slotno, 0));
-		pcibios_setup_bus_devices(bus);
 		max = bus->busn_res.start;
 		for (pass = 0; pass < 2; pass++) {
 			list_for_each_entry(dev, &bus->devices, bus_list) {
-- 
1.7.9.5
