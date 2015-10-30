Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2C7821A0200
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 19:18:46 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 30 Oct 2015 18:18:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 558152BB003F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 19:18:41 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9U8IYKT32768030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 19:18:42 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9U8I8g3015936
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 19:18:08 +1100
Date: Fri, 30 Oct 2015 16:17:43 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 09/12] powerpc/powernv: Support PCI config restore
 for VFs
Message-ID: <20151030081743.GA6664@richards-mbp.cn.ibm.com>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-10-git-send-email-weiyang@linux.vnet.ibm.com>
 <5632F86C.9060602@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5632F86C.9060602@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 30, 2015 at 03:56:12PM +1100, Alexey Kardashevskiy wrote:
>On 10/26/2015 02:15 PM, Wei Yang wrote:
>>After PE reset, OPAL API opal_pci_reinit() is called on all devices
>>contained in the PE to reinitialize them. However, VFs can't be seen
>>from skiboot firmware. We have to implement the functions, similar
>>those in skiboot firmware, to reinitialize VFs after reset on PE
>>for VFs.
>>
>>[gwshan: changelog and code refactoring]
>>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/include/asm/pci-bridge.h        |  1 +
>>  arch/powerpc/platforms/powernv/eeh-powernv.c | 70 +++++++++++++++++++++++++++-
>>  arch/powerpc/platforms/powernv/pci.c         | 18 +++++++
>>  3 files changed, 88 insertions(+), 1 deletion(-)
>>
>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>index 3d7e537..e499d93 100644
>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>@@ -219,6 +219,7 @@ struct pci_dn {
>>  #define IODA_INVALID_M64        (-1)
>>  	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>>  #endif /* CONFIG_PCI_IOV */
>>+	int     mps;
>
>int     mps; /* maximum payload size */
>?

You are right. Will add this comment in code.

>
>
>>  #endif
>>  	struct list_head child_list;
>>  	struct list_head list;
>>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>index 017cd72..3cc3e76 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>@@ -1616,6 +1616,67 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>>  	return ret;
>>  }
>>
>>+static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
>
>It does not exactly restore it, it just tweaks few bytes.
>
>
>>+{
>>+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>+	u32 devctl, cmd, cap2, aer_capctl;
>>+	int old_mps;
>>+
>>+	/* Restore MPS */
>>+	if (edev->pcie_cap) {
>>+		old_mps = (ffs(pdn->mps) - 8) << 5;
>>+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>+				     2, &devctl);
>>+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>+		devctl |= old_mps;
>>+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>+				      2, devctl);
>>+	}
>>+
>>+	/* Disable Completion Timeout */
>>+	if (edev->pcie_cap) {
>>+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
>>+				     4, &cap2);
>>+		if (cap2 & 0x10) {
>>+			eeh_ops->read_config(pdn,
>>+					edev->pcie_cap + PCI_EXP_DEVCTL2,
>>+					4, &cap2);
>>+			cap2 |= 0x10;
>>+			eeh_ops->write_config(pdn,
>>+					edev->pcie_cap + PCI_EXP_DEVCTL2,
>>+					4, cap2);
>>+		}
>>+	}
>>+
>>+	/* Enable SERR and parity checking */
>>+	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
>
>
>No complains from gcc about uninitialized @cmd and others? Cooool...
>

No...

>
>>+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
>>+	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
>>+
>>+	/* Enable report various errors */
>>+	if (edev->pcie_cap) {
>>+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>+				2, &devctl);
>>+		devctl &= ~PCI_EXP_DEVCTL_CERE;
>>+		devctl |= (PCI_EXP_DEVCTL_NFERE |
>>+			   PCI_EXP_DEVCTL_FERE |
>>+			   PCI_EXP_DEVCTL_URRE);
>>+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>+				2, devctl);
>>+	}
>>+
>>+	/* Enable ECRC generation and check */
>>+	if (edev->pcie_cap && edev->aer_cap) {
>>+		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
>>+				4, &aer_capctl);
>>+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
>>+		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
>>+				4, aer_capctl);
>>+	}
>>+
>>+	return 0;
>>+}
>>+
>>  static int pnv_eeh_restore_config(struct pci_dn *pdn)
>>  {
>>  	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>@@ -1626,7 +1687,14 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
>>  		return -EEXIST;
>>
>>  	phb = edev->phb->private_data;
>>-	ret = opal_pci_reinit(phb->opal_id,
>>+	/*
>>+	 * We have to restore the PCI config space after reset since the
>>+	 * firmware can't see SRIOV VFs.
>
>
>When I see "restore config space", pci_restore_state() comes to my mind...
>What you do is rather "fixup" but for some reason you do not call this from
>pnv_pci_fixup_vf_mps (which could be more generic and call
>pnv_eeh_restore_config()). Or that pnv_pci_fixup_vf_mps() could be merged
>into pnv_eeh_restore_config(). Having "restore" code in 2 places with unclear
>execution order does not feel right.
>
>
>
>>+	 */
>>+	if (edev->physfn)
>>+		ret = pnv_eeh_restore_vf_config(pdn);
>>+	else
>>+		ret = opal_pci_reinit(phb->opal_id,
>>  			      OPAL_REINIT_PCI_DEV, edev->config_addr);
>>  	if (ret) {
>>  		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
>>diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>>index 765d8ed..0e4f42e 100644
>>--- a/arch/powerpc/platforms/powernv/pci.c
>>+++ b/arch/powerpc/platforms/powernv/pci.c
>>@@ -788,6 +788,24 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
>>  }
>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
>>
>>+#ifdef CONFIG_PCI_IOV
>>+static void pnv_pci_fixup_vf_mps(struct pci_dev *pdev)
>>+{
>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>>+	int parent_mps;
>>+
>>+	if (!pdev->is_virtfn)
>>+		return;
>>+
>>+	/* Synchronize MPS for VF and PF */
>>+	parent_mps = pcie_get_mps(pdev->physfn);
>>+	if ((128 << pdev->pcie_mpss) >= parent_mps)
>>+		pcie_set_mps(pdev, parent_mps);
>
>
>There is no mentioning of MPS in the commit log. What and why is happening
>here? Is this cut-n-paste? Is not there already some code somewhere which
>does the same thing already for initial init()? Can this be reused? Or
>extracted to a helper and reused?
>

Ok, this code confused you.

This code, pnv_eeh_restore_vf_config() is called in pnv_eeh_restore_config().
The purpose of this function is to be the counter part of opal_pci_reinit().
To be simple, what this function does, is what opal_pci_reinit() does in
skiboot. You may ask why we just rely on opal_pci_reinit(). The reason is in
skiboot, we don't have device to represent a VF.

About why we have pnv_pci_fixup_vf_mps() and pnv_eeh_restore_vf_config() and
both handle mps, because in skiboot during system initialization devices' MPS
is set by this rule. While skiboot has no idea about VFs, this step is done in
kernel. 

>
>
>>+	pdn->mps = pcie_get_mps(pdev);
>>+}
>>+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_mps);
>>+#endif /* CONFIG_PCI_IOV */
>>+
>>  void __init pnv_pci_init(void)
>>  {
>>  	struct device_node *np;
>>
>
>
>-- 
>Alexey

-- 
Richard Yang
Help you, Help me
