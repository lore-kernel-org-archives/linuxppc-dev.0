Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F295E1A011B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:17:04 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 15:17:03 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EAFC63578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:17:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t535Fc9D4587882
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 15:15:46 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t535FDJ0017949
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 15:15:14 +1000
Date: Wed, 3 Jun 2015 15:14:48 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, gwshan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 08/10] powerpc/powernv: Support PCI config restore for
 VFs
Message-ID: <20150603051448.GB26652@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-9-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150602000136.GH3631@google.com> <20150603013753.GA7387@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603013753.GA7387@richard>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 03, 2015 at 09:37:53AM +0800, Wei Yang wrote:
>On Mon, Jun 01, 2015 at 07:01:36PM -0500, Bjorn Helgaas wrote:
>>On Tue, May 19, 2015 at 06:50:10PM +0800, Wei Yang wrote:
>>> After PE reset, OPAL API opal_pci_reinit() is called on all devices
>>> contained in the PE to reinitialize them. However, VFs can't be seen
>>> from skiboot firmware. We have to implement the functions, similar
>>> those in skiboot firmware, to reinitialize VFs after reset on PE
>>> for VFs.
>>> 
>>> [gwshan: changelog and code refactoring]
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/pci-bridge.h        |    1 +
>>>  arch/powerpc/platforms/powernv/eeh-powernv.c |   70 +++++++++++++++++++++++++-
>>>  arch/powerpc/platforms/powernv/pci.c         |   18 +++++++
>>>  3 files changed, 88 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>> index c324882..ad60263 100644
>>> --- a/arch/powerpc/include/asm/pci-bridge.h
>>> +++ b/arch/powerpc/include/asm/pci-bridge.h
>>> @@ -206,6 +206,7 @@ struct pci_dn {
>>>  #define IODA_INVALID_M64        (-1)
>>>  	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
>>>  #endif /* CONFIG_PCI_IOV */
>>> +	int	mps;
>>>  #endif
>>>  	struct list_head child_list;
>>>  	struct list_head list;
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index 7af3c1e..33deb78 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -1612,6 +1612,67 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>>>  	return ret;
>>>  }
>>>  
>>> +static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
>>> +{
>>> +	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>> +	u32 devctl, cmd, cap2, aer_capctl;
>>> +	int old_mps;
>>> +
>>> +	/* Restore MPS */
>>> +	if (edev->pcie_cap) {
>>> +		old_mps = (ffs(pdn->mps) - 8) << 5;
>>> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>> +				     2, &devctl);
>>> +		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>> +		devctl |= old_mps;
>>> +		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>> +				      2, devctl);
>>> +	}
>>> +
>>> +	/* Disable Completion Timeout */
>>> +	if (edev->pcie_cap) {
>>> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
>>> +				     4, &cap2);
>>> +		if (cap2 & 0x10) {
>>> +			eeh_ops->read_config(pdn,
>>> +					edev->pcie_cap + PCI_EXP_DEVCTL2,
>>> +					4, &cap2);
>>> +			cap2 |= 0x10;
>>> +			eeh_ops->write_config(pdn,
>>> +					edev->pcie_cap + PCI_EXP_DEVCTL2,
>>> +					4, cap2);
>>> +		}
>>> +	}
>>> +
>>> +	/* Enable SERR and parity checking */
>>> +	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
>>> +	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
>>> +	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
>>> +
>>> +	/* Enable report various errors */
>>> +	if (edev->pcie_cap) {
>>> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>> +				2, &devctl);
>>> +		devctl &= ~PCI_EXP_DEVCTL_CERE;
>>> +		devctl |= (PCI_EXP_DEVCTL_NFERE |
>>> +			   PCI_EXP_DEVCTL_FERE |
>>> +			   PCI_EXP_DEVCTL_URRE);
>>> +		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
>>> +				2, devctl);
>>> +	}
>>> +
>>> +	/* Enable ECRC generation and check */
>>> +	if (edev->pcie_cap && edev->aer_cap) {
>>> +		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
>>> +				4, &aer_capctl);
>>> +		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
>>> +		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
>>> +				4, aer_capctl);
>>> +	}
>>
>>Where is all this stuff set up the first time?  It'd be nice if we could
>>use the same path that did it the first time.
>>
>
>Those steps in this function are called to setup the pci_dev. For those PFs,
>they are done in the skiboot firmware, invoked by opal_pci_reinit(). For VFs,
>since skiboot firmware is not aware of those VFs, we need to setup it in
>kernel.
>
>This means originally, those stuffs are in skiboot firmware. This is the first
>time appears in kernel.
>
>>Are we setting up a PF or a VF here?  The function is called
>>pnv_eeh_restore_vf_config(), but it's called when "edev->physfn", so it's a
>>little confusing.
>>
>
>Yes, this is called for VFs. "edev->physfn" means the edev has a PF, so that
>this edev is a VF.
>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>  static int pnv_eeh_restore_config(struct pci_dn *pdn)
>>>  {
>>>  	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
>>> @@ -1622,7 +1683,14 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
>>>  		return -EEXIST;
>>>  
>>>  	phb = edev->phb->private_data;
>>> -	ret = opal_pci_reinit(phb->opal_id,
>>> +	/*
>>> +	 * We have to restore the PCI config space after reset since the
>>> +	 * firmware can't see SRIOV VFs.
>>> +	 */
>>> +	if (edev->physfn)
>>> +		ret = pnv_eeh_restore_vf_config(pdn);
>>> +	else
>>> +		ret = opal_pci_reinit(phb->opal_id,
>>>  			      OPAL_REINIT_PCI_DEV, edev->config_addr);
>>>  	if (ret) {
>>>  		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
>>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>>> index bca2aeb..10bc8c3 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.c
>>> +++ b/arch/powerpc/platforms/powernv/pci.c
>>> @@ -729,6 +729,24 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
>>>  }
>>>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
>>>  
>>> +#ifdef CONFIG_PCI_IOV
>>> +static void pnv_pci_fixup_vf_mps(struct pci_dev *pdev)
>>> +{
>>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>>> +	int parent_mps;
>>> +
>>> +	if (!pdev->is_virtfn)
>>> +		return;
>>> +
>>> +	/* Synchronize MPS for VF and PF */
>>> +	parent_mps = pcie_get_mps(pdev->physfn);
>>> +	if ((128 << pdev->pcie_mpss) >= parent_mps)
>>> +		pcie_set_mps(pdev, parent_mps);
>>> +	pdn->mps = pcie_get_mps(pdev);
>>> +}
>>> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_mps);
>>
>>Same comment as before -- I don't like this usage of fixups.  Would it work
>>to do this in pcibios_add_device()?
>>
>>I assume you need this to happen when you hot-remove and hot-add a VF
>>during EEH recovery?  Where does this happen in the normal hotplug path,
>>e.g., pciehp, and can you do it in a corresponding place for EEH hotplug?
>>
>
>Yes, this is called in the EEH recovery. While not only in the hot-add case,
>when we do the normal EEH reset, 
>
>eeh_reset_device()
>    eeh_pe_restore_bars()
>        eeh_restore_one_device_bars()
>	    eeh_ops->restore_config()
>	        pnv_eeh_restore_config()
>
>eeh_reset_device() would handle both hot-add and non-hot-add cases. So this is
>not proper to move it to the hot-plug path.
>

If I don't miss anything here. The code does have the problem as Bjorn raised:
When VF is brought up for the first time (without EEH involved yet), the AER
and PCIe timeout setting are not initialized to the expected values.

For non-VFs, the device has been initialize properly before it's exposed to
OS from firmware.

Thanks,
Gavin

>>
>>> +#endif /* CONFIG_PCI_IOV */
>>> +
>>>  void __init pnv_pci_init(void)
>>>  {
>>>  	struct device_node *np;
>>> -- 
>>> 1.7.9.5
>>> 
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>-- 
>Richard Yang
>Help you, Help me
