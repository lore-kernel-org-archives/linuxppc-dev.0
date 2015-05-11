Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 458011A0010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:23:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 11 May 2015 14:23:38 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C56E22CE8050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:23:36 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4B4NRm738338768
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:23:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4B4N33Z016831
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 14:23:03 +1000
Date: Mon, 11 May 2015 14:22:38 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 8/9] powerpc/powernv: Support PCI config restore for VFs
Message-ID: <20150511042238.GA19629@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1430723258-21299-9-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430723258-21299-9-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 04, 2015 at 03:07:37PM +0800, Wei Yang wrote:
>Since FW is not aware of VFs, the restore action for VF should be done in
       ^^
       skiboot firmware
>kernel.
>
>This patch introduces pnv_eeh_vf_restore_config() for VF.
>

Would it be better?

The patch introduces function pnv_eeh_vf_restore_config() to restore PCI
config space for VFs after reset.

Also, the function name would be better with pnv_eeh_restore_vf_config()?

>Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>---
> arch/powerpc/include/asm/pci-bridge.h        |    1 +
> arch/powerpc/platforms/powernv/eeh-powernv.c |   77 +++++++++++++++++++++++++-
> 2 files changed, 77 insertions(+), 1 deletion(-)
>
>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>index 9582aa2..de55ef6 100644
>--- a/arch/powerpc/include/asm/pci-bridge.h
>+++ b/arch/powerpc/include/asm/pci-bridge.h
>@@ -205,6 +205,7 @@ struct pci_dn {
> 	int     m64_per_iov;
> #define IODA_INVALID_M64        (-1)
> 	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
>+	int	mps;
> #endif /* CONFIG_PCI_IOV */
> #endif
> 	struct list_head child_list;
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index 1ad322f..6ba6d87 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -1589,6 +1589,59 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
> 	return ret;
> }
>
>+#ifdef CONFIG_PCI_IOV
>+static int pnv_eeh_vf_restore_config(struct pci_dn *pdn)
>+{
>+	int pcie_cap, aer_cap, old_mps;
>+	u32 devctl, cmd, cap2, aer_capctl;
>+
>+	/* Restore MPS */
>+	pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
>+	if (pcie_cap) {
>+		old_mps = (ffs(pdn->mps) - 8) << 5;
>+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
>+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
>+		devctl |= old_mps;
>+		pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
>+	}
>+

hrm, You can't use pnv_pci_cfg_{read,write} here. Instead, you should use
eeh_ops->{read,write}_config. By design, the PCI config accessors have been
classified to 2 classes: one is used for pci_config_{read,write}_* and another
one is eeh_ops->{read,write}. From EEH perspective, the former isn't controlled
strictly, but the later one is under control completely. "Not controlled" here
means the kernel can't determine when the PCI config is accessed, e.g. PCI
config accesses from user land.
 
>+	/* Disable Completion Timeout */
>+	if (pcie_cap) {
>+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCAP2, 4, &cap2);
>+		if (cap2 & 0x10) {
>+			pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, &cap2);
>+			cap2 |= 0x10;
>+			pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, cap2);
>+		}
>+	}
>+
>+	/* Enable SERR and parity checking */
>+	pnv_pci_cfg_read(pdn, PCI_COMMAND, 2, &cmd);
>+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
>+	pnv_pci_cfg_write(pdn, PCI_COMMAND, 2, cmd);
>+
>+	/* Enable report various errors */
>+	if (pcie_cap) {
>+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
>+		devctl &= ~PCI_EXP_DEVCTL_CERE;
>+		devctl |= (PCI_EXP_DEVCTL_NFERE |
>+			   PCI_EXP_DEVCTL_FERE |
>+			   PCI_EXP_DEVCTL_URRE);
>+		pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
>+	}
>+
>+	/* Enable ECRC generation and check */
>+	if (pcie_cap) {
>+		aer_cap = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
>+		pnv_pci_cfg_read(pdn, aer_cap + PCI_ERR_CAP, 4, &aer_capctl);
>+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
>+		pnv_pci_cfg_write(pdn, aer_cap + PCI_ERR_CAP, 4, aer_capctl);
>+	}
>+
>+	return 0;
>+}
>+#endif /* CONFIG_PCI_IOV */
>+

The code is copied over from skiboot firmware. I still dislike the fact that
we have to maintain two sets of similar functions in skiboot/kernel. I still
believe the way I suggested can help: the firmware exports the error routing
rules and kernel has support it based on the rules. With it, the skiboot is
the source of the information to avoid mismatching between kernel/firmware.

> static int pnv_eeh_restore_config(struct pci_dn *pdn)
> {
> 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>@@ -1599,7 +1652,13 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
> 		return -EEXIST;
>
> 	phb = edev->phb->private_data;
>-	ret = opal_pci_reinit(phb->opal_id,
>+#ifdef CONFIG_PCI_IOV
>+	/* FW is not VF aware, we rely on OS to restore it */
>+	if (edev->mode & EEH_DEV_VF)
>+		ret = pnv_eeh_vf_restore_config(pdn);
>+	else
>+#endif

You don't even have to have CONFIG_PCI_IOV since it won't save much
.text space.

>+		ret = opal_pci_reinit(phb->opal_id,
> 			      OPAL_REINIT_PCI_DEV, edev->config_addr);
> 	if (ret) {
> 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
>@@ -1660,4 +1719,20 @@ static void pnv_pci_fixup_vf_eeh(struct pci_dev *pdev)
> 	}
> }
> DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_eeh);
>+
>+static void pnv_pci_fixup_vf_caps(struct pci_dev *pdev)
>+{

As I said before, this function shouldn't be part of this file because:

- When CONFIG_EEH=n, this file won't be complied/included.
- This function isn't part of EEH naturally.

Also, pnv_pci_vf_header_fixup() would be better name in case you need
apply more fixups for VFs in the function.

>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>+	int parent_mps;
>+
>+	if (!pdev->is_virtfn)
>+		return;
>+
>+	/* Synchronize MPS for VF and PF */
>+	parent_mps = pcie_get_mps(pdev->physfn);
>+	if ((128 << pdev->pcie_mpss) >= parent_mps)
>+		pcie_set_mps(pdev, parent_mps);

Hrm, Again, do we have possibility: (128 << pdev->pcie_mpss) < parent_mps ?
And why we bother if MPS of PF/VF are equal?

>+	pdn->mps = pcie_get_mps(pdev);
>+}
>+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_caps);
> #endif /* CONFIG_PCI_IOV */
>-- 
>1.7.9.5
>
