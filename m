Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82B741A0651
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:11:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 3 Jun 2015 15:11:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C94FF3578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 15:11:24 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t535BGIa59244552
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 15:11:24 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t535Ap1o016157
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Jun 2015 15:10:52 +1000
Date: Wed, 3 Jun 2015 15:10:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, gwshan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150603051023.GA26652@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150601234645.GF3631@google.com> <20150603033142.GA22584@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603033142.GA22584@richard>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 03, 2015 at 11:31:42AM +0800, Wei Yang wrote:
>On Mon, Jun 01, 2015 at 06:46:45PM -0500, Bjorn Helgaas wrote:
>>On Tue, May 19, 2015 at 06:50:08PM +0800, Wei Yang wrote:
>>> Current EEH recovery code works with the assumption: the PE has primary
>>> bus. Unfortunately, that's not true to VF PEs, which generally contains
>>> one or multiple VFs (for VF group case). The patch creates PEs for VFs
>>> at PCI final fixup time. Those PEs for VFs are indentified with newly
>>> introduced flag EEH_PE_VF so that we handle them differently during
>>> EEH recovery.
>>> 
>>> [gwshan: changelog and code refactoring]
>>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/eeh.h               |    1 +
>>>  arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
>>>  arch/powerpc/platforms/powernv/eeh-powernv.c |   17 +++++++++++++++++
>>>  3 files changed, 26 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>>> index 1b3614d..c1fde48 100644
>>> --- a/arch/powerpc/include/asm/eeh.h
>>> +++ b/arch/powerpc/include/asm/eeh.h
>>> @@ -70,6 +70,7 @@ struct pci_dn;
>>>  #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
>>>  #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
>>>  #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
>>> +#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>>>  
>>>  #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
>>>  #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
>>> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>>> index 35f0b62..260a701 100644
>>> --- a/arch/powerpc/kernel/eeh_pe.c
>>> +++ b/arch/powerpc/kernel/eeh_pe.c
>>> @@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>>>  	 * EEH device already having associated PE, but
>>>  	 * the direct parent EEH device doesn't have yet.
>>>  	 */
>>> -	pdn = pdn ? pdn->parent : NULL;
>>> +	if (edev->physfn)
>>> +		pdn = pci_get_pdn(edev->physfn);
>>> +	else
>>> +		pdn = pdn ? pdn->parent : NULL;
>>>  	while (pdn) {
>>>  		/* We're poking out of PCI territory */
>>>  		parent = pdn_to_eeh_dev(pdn);
>>> @@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>>>  	}
>>>  
>>>  	/* Create a new EEH PE */
>>> -	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>>> +	if (edev->physfn)
>>> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
>>> +	else
>>> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>>>  	if (!pe) {
>>>  		pr_err("%s: out of memory!\n", __func__);
>>>  		return -ENOMEM;
>>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> index ce738ab..c505036 100644
>>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>>> @@ -1520,6 +1520,23 @@ static struct eeh_ops pnv_eeh_ops = {
>>>  	.restore_config		= pnv_eeh_restore_config
>>>  };
>>>  
>>> +static void pnv_eeh_vf_final_fixup(struct pci_dev *pdev)
>>> +{
>>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>>> +
>>> +	if (!pdev->is_virtfn)
>>> +		return;
>>> +
>>> +	/*
>>> +	 * The following operations will fail if VF's sysfs files
>>> +	 * aren't created or its resources aren't finalized.
>>> +	 */
>>
>>I don't understand this comment.  "The following operations" seems to refer
>>to eeh_add_device_early() and eeh_add_device_late(), and
>>"VF's sysfs files being created" seems to refer to eeh_sysfs_add_device().
>>
>>So the comment suggests that eeh_add_device_early() and
>>eeh_add_device_late() will fail because they're called before
>>eeh_sysfs_add_device().  So I think you must be talking about some other
>>"following operations," not eeh_add_device_early() and
>>eeh_add_device_late().
>
>Sorry for this confusion.
>
>The comment here wants to say the eeh_sysfs_add_device() will fail if the VF's
>sysfs is not created well. Or it will fail if the VF's resources are not set
>properly, since we would cache the VF's BAR in eeh_add_device_late().
>
>Gavin,
>
>If my understanding is not correct please let me know.
>

It's correct. "The following operations" refers to eeh_add_device_late()
and eeh_sysfs_add_device(). The former one requires the resources for
one particular PCI device (VF here) are finalized (assigned). eeh_sysfs_add_device()
will fail if the sysfs entry for the PCI device isn't populated yet.

>>
>>> +	eeh_add_device_early(pdn);
>>> +	eeh_add_device_late(pdev);
>>> +	eeh_sysfs_add_device(pdev);
>>> +}
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_eeh_vf_final_fixup);
>>
>>Ugh.  This is powerpc code, but I don't like using fixups as a hook like
>>this.  There is a pcibios_add_device() -- could this be done there?
>>
>
>I don't like it neither :-) But looks we can't put it in the
>pcibios_add_device().
>
>>If not, what happens after pcibios_add_device() that is required for this
>>code?  Maybe we need a pcibios_bus_add_device() hook?
>
>The pnv_eeh_vf_final_fixup() will try to create sysfs for VFs. This requires
>the VF sysfs(kobj) is initialized properly. If we put these into
>pcibios_add_device(), the eeh_sysfs_add_device() would fail.
>
>Below is the call flow for your reference:
>
>pci_device_add()
>    pcibios_add_device()
>    device_add()                <--- kobj initialized here
>

We can put it into pcibios_bus_add_device(), but we don't it currently. If
Bjorn agree to add pcibios_bus_add_device(), I'm fine to move the block code
there.

Thanks,
Gavin

>>
>>> +
>>>  /**
>>>   * eeh_powernv_init - Register platform dependent EEH operations
>>>   *
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
