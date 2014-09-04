Return-Path: <Emilian.Medve@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7DB481A00F4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 06:56:53 +1000 (EST)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AECEF1400B9
 for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2014 06:56:51 +1000 (EST)
Message-ID: <5408D1EB.4060907@Freescale.com>
Date: Thu, 4 Sep 2014 15:56:11 -0500
From: Emil Medve <Emilian.Medve@Freescale.com>
MIME-Version: 1.0
To: Varun Sethi <Varun.Sethi@Freescale.com>, <joro@8bytes.org>,
 <iommu@lists.linux-foundation.org>, <alex.williamson@redhat.com>,
 <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iommu/fsl: Fix warning resulting from adding PCI device
 twice
References: <1409830725-4469-1-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1409830725-4469-1-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2014 06:38 AM, Varun Sethi wrote:
> iommu_group_get_for_dev determines the iommu group for the PCI device and adds
> the device to the group.
> 
> In the PAMU driver we were again adding the device to the same group without checking
> if the device already had an iommu group. This resulted in the following warning.
> 
> sysfs: cannot create duplicate filename '/devices/ffe200000.pcie/pci0000:00/0000:00:00.0/iommu_group'
> ------------[ cut here ]------------
> WARNING: at fs/sysfs/dir.c:31
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.17.0-rc3-00002-g7505cea-dirty #126
> task: c0000001fe0a0000 ti: c0000001fe044000 task.ti: c0000001fe044000
> NIP: c00000000018879c LR: c000000000188798 CTR: c00000000001ea50
> REGS: c0000001fe047040 TRAP: 0700   Not tainted  (3.17.0-rc3-00002-g7505cea-dirty)
> MSR: 0000000080029000 <CE,EE,ME>  CR: 24ad8e22  XER: 20000000
> SOFTE: 1 
> GPR00: c000000000188798 c0000001fe0472c0 c0000000009a52e0 0000000000000065 
> GPR04: 0000000000000001 0000000000000000 3a30303a00000000 0000000027000000 
> GPR08: 2f696f6d00000000 c0000000008d3830 c0000000009b3938 c0000000009bb3d0 
> GPR12: 0000000028ad8e24 c00000000fff4000 c00000000000205c 0000000000000000 
> GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR20: 0000000000000000 0000000000000000 0000000000000000 c0000000008a4c70 
> GPR24: c0000000007e9010 c0000001fe0140a8 ffffffffffffffef 0000000000000001 
> GPR28: c0000001fe22ebb8 c0000000007e9010 c00000000090bf10 c0000001fe220000 
> NIP [c00000000018879c] .sysfs_warn_dup+0x74/0xa4
> LR [c000000000188798] .sysfs_warn_dup+0x70/0xa4
> Call Trace:
> [c0000001fe0472c0] [c000000000188798] .sysfs_warn_dup+0x70/0xa4 (unreliable)
> [c0000001fe047350] [c000000000188d34] .sysfs_do_create_link_sd.clone.2+0x168/0x174
> [c0000001fe047400] [c0000000004b3cf8] .iommu_group_add_device+0x78/0x244
> [c0000001fe0474b0] [c0000000004b6964] .fsl_pamu_add_device+0x88/0x1a8
> [c0000001fe047570] [c0000000004b3960] .iommu_bus_notifier+0xdc/0x15c
> [c0000001fe047600] [c000000000059848] .notifier_call_chain+0x8c/0xe8
> [c0000001fe0476a0] [c000000000059d04] .__blocking_notifier_call_chain+0x58/0x84
> [c0000001fe047750] [c00000000036619c] .device_add+0x464/0x5c8
> [c0000001fe047820] [c000000000300ebc] .pci_device_add+0x14c/0x17c
> [c0000001fe0478c0] [c000000000300fbc] .pci_scan_single_device+0xd0/0xf4
> [c0000001fe047970] [c00000000030104c] .pci_scan_slot+0x6c/0x18c
> [c0000001fe047a10] [c00000000030226c] .pci_scan_child_bus+0x40/0x114
> [c0000001fe047ac0] [c000000000021974] .pcibios_scan_phb+0x240/0x2c8
> [c0000001fe047b70] [c00000000085a970] .pcibios_init+0x64/0xc8
> [c0000001fe047c00] [c000000000001884] .do_one_initcall+0xbc/0x224
> [c0000001fe047d00] [c000000000852d50] .kernel_init_freeable+0x14c/0x21c
> [c0000001fe047db0] [c000000000002078] .kernel_init+0x1c/0xfa4
> [c0000001fe047e30] [c000000000000884] .ret_from_kernel_thread+0x58/0xd4
> Instruction dump:
> 7c7f1b79 4182001c 7fe4fb78 7f83e378 38a01000 4bffc905 60000000 7c641b78 
> e87e8008 7fa5eb78 48482ff5 60000000 <0fe00000> 7fe3fb78 4bf7bd39 60000000 
> 
> 
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>

Tested-by: Emil Medve <Emilian.Medve@Freescale.com>
