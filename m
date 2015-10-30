Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27F8C1A0024
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:20:50 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 17:20:49 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F20A03578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:20:45 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9U7Kb3B60555444
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:20:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9U7KDkW024279
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 18:20:13 +1100
Date: Fri, 30 Oct 2015 15:19:47 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 11/12] powerpc/eeh: Don't block PCI config on
 resetting VF PE
Message-ID: <20151030071947.GF5940@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-12-git-send-email-weiyang@linux.vnet.ibm.com>
 <5633032F.9000407@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5633032F.9000407@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2015 at 04:42:07PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:16 PM, Wei Yang wrote:
>>From: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>When passing through SRIOV VF from host to guest via VFIO PCI
>>infrastructure, the VF is resetted by EEH specific backend
>>(pcibios_set_pcie_reset_state()). We can't block the PCI config,
>>otherwise, the reset (FLR or AF FLR), to be completed by PCI
>>config access to the VF, can't be done. Then the VF can't be
>>put into initial state when passing it to the guest and returning
>>back to the host.
>>
>>The patch just doesn't block the VF's PCI config space when doing
>>the reset. It fixes EEH error caused by DMA traffic to bogus DMA
>>address on restarting guest after killing the QEMU process, which
>>includes Mellanox VF passed through from host.
>
>The patch as it is makes sense as a bugfix for our internal tree where the
>EEH VF feature was present at the time when this patch was posted but in this
>patchset is makes more sense to merge it into:
>
>[PATCH V10 08/12] powerpc/powernv: Support EEH reset for VF PE
>
>as it is quite weird within one patchset to introduce a problem  and then fix
>it in a following patch.
>

Sure, got it.

>
>>Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>Tested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
>Remove "sob: aik@..." please.
>
>
>>---
>>  arch/powerpc/kernel/eeh.c | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>>diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>index 28e4d73..e1846f5 100644
>>--- a/arch/powerpc/kernel/eeh.c
>>+++ b/arch/powerpc/kernel/eeh.c
>>@@ -745,7 +745,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
>>  	case pcie_deassert_reset:
>>  		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
>>  		eeh_unfreeze_pe(pe, false);
>>-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
>>+		if (!(pe->type & EEH_PE_VF))
>>+			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
>>  		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
>>  		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
>>  		break;
>>@@ -753,14 +754,16 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
>>  		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
>>  		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
>>  		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
>>-		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
>>+		if (!(pe->type & EEH_PE_VF))
>>+			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
>>  		eeh_ops->reset(pe, EEH_RESET_HOT);
>>  		break;
>>  	case pcie_warm_reset:
>>  		eeh_pe_state_mark(pe, EEH_PE_ISOLATED);
>>  		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
>>  		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
>>-		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
>>+		if (!(pe->type & EEH_PE_VF))
>>+			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
>>  		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
>>  		break;
>>  	default:
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
