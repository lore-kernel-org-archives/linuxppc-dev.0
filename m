Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A4E761A0074
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 12:07:47 +1000 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 20 Aug 2014 07:37:44 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 0E468125804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 07:37:55 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7K27aeN36634626
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 07:37:36 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7K27eki004691
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 07:37:41 +0530
Date: Wed, 20 Aug 2014 12:07:35 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: fix crashing when passing VF
Message-ID: <20140820020735.GA12789@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1408415229-16765-1-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408415229-16765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 19, 2014 at 10:27:09AM +0800, Wei Yang wrote:

The subject would be "powerpc/eeh: Fix kernel crash when passing through VF".

>When doing vfio passthrough a VF, the kernel will crash with following
>message:
>
>[  442.656459] Unable to handle kernel paging request for data at address 0x00000060
>[  442.656593] Faulting instruction address: 0xc000000000038b88
>[  442.656706] Oops: Kernel access of bad area, sig: 11 [#1]
>[  442.656798] SMP NR_CPUS=1024 NUMA PowerNV
>[  442.656890] Modules linked in: vfio_pci mlx4_core nf_conntrack_netbios_ns nf_conntrack_broadcast ipt_MASQUERADE ip6t_REJECT xt_conntrack bnep bluetooth rfkill ebtable_nat ebtable_broute bridge stp llc ebtable_filter ebtables ip6table_nat nf_conntrack_ipv6 nf_defrag_ipv6 nf_nat_ipv6 ip6table_mangle ip6table_security ip6table_raw ip6table_filter ip6_tables iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack iptable_mangle iptable_security iptable_raw tg3 nfsd be2net nfs_acl ses lockd ptp enclosure pps_core kvm_hv kvm_pr shpchp binfmt_misc kvm sunrpc uinput lpfc scsi_transport_fc ipr scsi_tgt [last unloaded: mlx4_core]
>[  442.658152] CPU: 40 PID: 14948 Comm: qemu-system-ppc Not tainted 3.10.42yw-pkvm+ #37
>[  442.658219] task: c000000f7e2a9a00 ti: c000000f6dc3c000 task.ti: c000000f6dc3c000
>[  442.658287] NIP: c000000000038b88 LR: c0000000004435a8 CTR: c000000000455bc0
>[  442.658352] REGS: c000000f6dc3f580 TRAP: 0300   Not tainted  (3.10.42yw-pkvm+)
>[  442.658419] MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 28004882  XER: 20000000
>[  442.658577] CFAR: c00000000000908c DAR: 0000000000000060 DSISR: 40000000 SOFTE: 1
>GPR00: c0000000004435a8 c000000f6dc3f800 c0000000012b1c10 c00000000da24000
>GPR04: 0000000000000003 0000000000001004 00000000000015b3 000000000000ffff
>GPR08: c00000000127f5d8 0000000000000000 000000000000ffff 0000000000000000
>GPR12: c000000000068078 c00000000fdd6800 000001003c320c80 000001003c3607f0
>GPR16: 0000000000000001 00000000105480c8 000000001055aaa8 000001003c31ab18
>GPR20: 000001003c10fb40 000001003c360ae8 000000001063bcf0 000000001063bdb0
>GPR24: 000001003c15ed70 0000000010548f40 c000001fe5514c88 c000001fe5514cb0
>GPR28: c00000000da24000 0000000000000000 c00000000da24000 0000000000000003
>[  442.659471] NIP [c000000000038b88] .pcibios_set_pcie_reset_state+0x28/0x130
>[  442.659530] LR [c0000000004435a8] .pci_set_pcie_reset_state+0x28/0x40
>[  442.659585] Call Trace:
>[  442.659610] [c000000f6dc3f800] [00000000000719e0] 0x719e0 (unreliable)
>[  442.659677] [c000000f6dc3f880] [c0000000004435a8] .pci_set_pcie_reset_state+0x28/0x40
>[  442.659757] [c000000f6dc3f900] [c000000000455bf8] .reset_fundamental+0x38/0x80
>[  442.659835] [c000000f6dc3f980] [c0000000004562a8] .pci_dev_specific_reset+0xa8/0xf0
>[  442.659913] [c000000f6dc3fa00] [c0000000004448c4] .__pci_dev_reset+0x44/0x430
>[  442.659980] [c000000f6dc3fab0] [c000000000444d5c] .pci_reset_function+0x7c/0xc0
>[  442.660059] [c000000f6dc3fb30] [d00000001c141ab8] .vfio_pci_open+0xe8/0x2b0 [vfio_pci]
>[  442.660139] [c000000f6dc3fbd0] [c000000000586c30] .vfio_group_fops_unl_ioctl+0x3a0/0x630
>[  442.660219] [c000000f6dc3fc90] [c000000000255fbc] .do_vfs_ioctl+0x4ec/0x7c0
>[  442.660286] [c000000f6dc3fd80] [c000000000256364] .SyS_ioctl+0xd4/0xf0
>[  442.660354] [c000000f6dc3fe30] [c000000000009e54] syscall_exit+0x0/0x98
>[  442.660420] Instruction dump:
>[  442.660454] 4bfffce9 4bfffee4 7c0802a6 fbc1fff0 fbe1fff8 f8010010 f821ff81 7c7e1b78
>[  442.660566] 7c9f2378 60000000 60000000 e93e02c8 <e8690060> 2fa30000 41de00c4 2b9f0002
>[  442.660679] ---[ end trace a64ac9546bcf0328 ]---
>[  442.660724]
>
>The reason is current VF is not EEH enabled.
>
>This patch is a quick fix for this problem.
>
>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>

With all minor comments fixed:

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
> arch/powerpc/kernel/eeh.c |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>index 0ba4392..d2d2130 100644
>--- a/arch/powerpc/kernel/eeh.c
>+++ b/arch/powerpc/kernel/eeh.c
>@@ -630,7 +630,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
> int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
> {
> 	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
>-	struct eeh_pe *pe = edev->pe;
>+	struct eeh_pe *pe = edev ? edev->pe:NULL;

It would be:

	struct eeh_pe *pe = edev ? edev->pe : NULL;

>
> 	if (!pe) {
> 		pr_err("%s: No PE found on PCI device %s\n",

Thanks,
Gavin
