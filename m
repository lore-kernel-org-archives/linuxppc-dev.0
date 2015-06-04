Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BD931A0E79
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 11:26:57 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 11:26:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7F2B9357804F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 11:26:52 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t541Qhjb60293358
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 11:26:52 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t541QJNg003615
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 11:26:19 +1000
Date: Thu, 4 Jun 2015 11:25:52 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150604012552.GA1983@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
 <20150601234645.GF3631@google.com> <20150603033142.GA22584@richard>
 <20150603051023.GA26652@gwshan> <20150603154638.GL3631@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150603154638.GL3631@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 03, 2015 at 10:46:38AM -0500, Bjorn Helgaas wrote:
>On Wed, Jun 03, 2015 at 03:10:23PM +1000, Gavin Shan wrote:
>> On Wed, Jun 03, 2015 at 11:31:42AM +0800, Wei Yang wrote:
>> >On Mon, Jun 01, 2015 at 06:46:45PM -0500, Bjorn Helgaas wrote:
>> >>On Tue, May 19, 2015 at 06:50:08PM +0800, Wei Yang wrote:
>> >>> Current EEH recovery code works with the assumption: the PE has primary
>> >>> bus. Unfortunately, that's not true to VF PEs, which generally contains
>> >>> one or multiple VFs (for VF group case). The patch creates PEs for VFs
>> >>> at PCI final fixup time. Those PEs for VFs are indentified with newly
>> >>> introduced flag EEH_PE_VF so that we handle them differently during
>> >>> EEH recovery.
>> >>> 
>> >>> [gwshan: changelog and code refactoring]
>> >>> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
>> >>> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> >>> ---
>> >>>  arch/powerpc/include/asm/eeh.h               |    1 +
>> >>>  arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
>> >>>  arch/powerpc/platforms/powernv/eeh-powernv.c |   17 +++++++++++++++++
>> >>>  3 files changed, 26 insertions(+), 2 deletions(-)
>> >>> 
>> >>> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
>> >>> index 1b3614d..c1fde48 100644
>> >>> --- a/arch/powerpc/include/asm/eeh.h
>> >>> +++ b/arch/powerpc/include/asm/eeh.h
>> >>> @@ -70,6 +70,7 @@ struct pci_dn;
>> >>>  #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
>> >>>  #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
>> >>>  #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
>> >>> +#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>> >>>  
>> >>>  #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
>> >>>  #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
>> >>> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>> >>> index 35f0b62..260a701 100644
>> >>> --- a/arch/powerpc/kernel/eeh_pe.c
>> >>> +++ b/arch/powerpc/kernel/eeh_pe.c
>> >>> @@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>> >>>  	 * EEH device already having associated PE, but
>> >>>  	 * the direct parent EEH device doesn't have yet.
>> >>>  	 */
>> >>> -	pdn = pdn ? pdn->parent : NULL;
>> >>> +	if (edev->physfn)
>> >>> +		pdn = pci_get_pdn(edev->physfn);
>> >>> +	else
>> >>> +		pdn = pdn ? pdn->parent : NULL;
>> >>>  	while (pdn) {
>> >>>  		/* We're poking out of PCI territory */
>> >>>  		parent = pdn_to_eeh_dev(pdn);
>> >>> @@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>> >>>  	}
>> >>>  
>> >>>  	/* Create a new EEH PE */
>> >>> -	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>> >>> +	if (edev->physfn)
>> >>> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
>> >>> +	else
>> >>> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>> >>>  	if (!pe) {
>> >>>  		pr_err("%s: out of memory!\n", __func__);
>> >>>  		return -ENOMEM;
>> >>> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> >>> index ce738ab..c505036 100644
>> >>> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>> >>> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>> >>> @@ -1520,6 +1520,23 @@ static struct eeh_ops pnv_eeh_ops = {
>> >>>  	.restore_config		= pnv_eeh_restore_config
>> >>>  };
>> >>>  
>> >>> +static void pnv_eeh_vf_final_fixup(struct pci_dev *pdev)
>> >>> +{
>> >>> +	struct pci_dn *pdn = pci_get_pdn(pdev);
>> >>> +
>> >>> +	if (!pdev->is_virtfn)
>> >>> +		return;
>> >>> +
>> >>> +	/*
>> >>> +	 * The following operations will fail if VF's sysfs files
>> >>> +	 * aren't created or its resources aren't finalized.
>> >>> +	 */
>> >>
>> >>I don't understand this comment.  "The following operations" seems to refer
>> >>to eeh_add_device_early() and eeh_add_device_late(), and
>> >>"VF's sysfs files being created" seems to refer to eeh_sysfs_add_device().
>> >>
>> >>So the comment suggests that eeh_add_device_early() and
>> >>eeh_add_device_late() will fail because they're called before
>> >>eeh_sysfs_add_device().  So I think you must be talking about some other
>> >>"following operations," not eeh_add_device_early() and
>> >>eeh_add_device_late().
>> >
>> >Sorry for this confusion.
>> >
>> >The comment here wants to say the eeh_sysfs_add_device() will fail if the VF's
>> >sysfs is not created well. Or it will fail if the VF's resources are not set
>> >properly, since we would cache the VF's BAR in eeh_add_device_late().
>> >
>> >Gavin,
>> >
>> >If my understanding is not correct please let me know.
>> >
>> 
>> It's correct. "The following operations" refers to eeh_add_device_late()
>> and eeh_sysfs_add_device(). The former one requires the resources for
>> one particular PCI device (VF here) are finalized (assigned). eeh_sysfs_add_device()
>> will fail if the sysfs entry for the PCI device isn't populated yet.
>
>eeh_add_device_late() contains several things that read config space:
>eeh_save_bars() caches the entire config header, and
>eeh_addr_cache_insert_dev() looks at the device resources (which are
>determined by BARs in config space).  I think this is an error-prone
>approach.  I think it would be simpler and safer for you to capture what
>you need in your PCI config accessors.
>

I don't follow you very well. I think you're saying the source of all
information should be config space exclusively. The code is shared by
multple platforms, one of which is pSeries running on top of PowerVM
hypervisor or KVM/QEMU. The device resources are figured from device-tree,
not from config space.

>eeh_add_device_late() also contains code to deal with an EEH cache that
>"might not be removed correctly because of unbalanced kref to the device
>during unplug time."  That's unrelated to this patch series, but it sounds
>... like a hacky workaround for some bug in the unplug path.
>

Yes. We depend on pcibios_release_device() to disconnect EEH device
and PCI device. pcibios_release_device() might not be called because
of unbalanced refcount. The workaround here is to disconnect EEH device
and PCI device lazily, and then the EEH device is connected to the
right PCI device and EEH address cache is updated accordingly.

>> >>> +	eeh_add_device_early(pdn);
>> >>> +	eeh_add_device_late(pdev);
>> >>> +	eeh_sysfs_add_device(pdev);
>> >>> +}
>> >>> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_eeh_vf_final_fixup);
>> >>
>> >>Ugh.  This is powerpc code, but I don't like using fixups as a hook like
>> >>this.  There is a pcibios_add_device() -- could this be done there?
>> >>
>> >
>> >I don't like it neither :-) But looks we can't put it in the
>> >pcibios_add_device().
>> >
>> >>If not, what happens after pcibios_add_device() that is required for this
>> >>code?  Maybe we need a pcibios_bus_add_device() hook?
>> >
>> >The pnv_eeh_vf_final_fixup() will try to create sysfs for VFs. This requires
>> >the VF sysfs(kobj) is initialized properly. If we put these into
>> >pcibios_add_device(), the eeh_sysfs_add_device() would fail.
>> >
>> >Below is the call flow for your reference:
>> >
>> >pci_device_add()
>> >    pcibios_add_device()
>> >    device_add()                <--- kobj initialized here
>> >
>> 
>> We can put it into pcibios_bus_add_device(), but we don't it currently. If
>> Bjorn agree to add pcibios_bus_add_device(), I'm fine to move the block code
>> there.
>
>I think I'm OK with adding a pcibios_bus_add_device().  I think that would
>be better than using the fixup mechanism for this.
>

Ok. Thanks for confirm.

Thanks,
Gavin
