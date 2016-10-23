Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2Ftv1yVdzDsxX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:27:19 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9NNOHFU118386
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 19:27:15 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2692jq7b0e-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Oct 2016 19:27:15 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 24 Oct 2016 09:27:12 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AF3E22CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:27:10 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9NNRA4f20971586
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:27:10 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9NNR9QD016347
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 10:27:10 +1100
Date: Mon, 24 Oct 2016 10:28:02 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com, benh@au1.ibm.com,
 benh@kernel.crashing.org, mpe@ellerman.id.au, clsoto@us.ibm.com
Subject: Re: [PATCH v2 2/2] PCI: Don't disable PF's memory decoding when
 enabling SRIOV
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1475192870-7763-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1475192870-7763-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20161021165034.GE9007@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161021165034.GE9007@localhost>
Message-Id: <20161023232802.GA7215@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 21, 2016 at 11:50:34AM -0500, Bjorn Helgaas wrote:
>Hi Gavin,
>
>On Fri, Sep 30, 2016 at 09:47:50AM +1000, Gavin Shan wrote:
>> pci_update_resource() might be called to update (shift) IOV BARs
>> in PPC PowerNV specific pcibios_sriov_enable() when enabling PF's
>> SRIOV capability. At that point, the PF have been functional if
>> the SRIOV is enabled through sysfs entry "sriov_numvfs". The PF's
>> memory decoding (0x2 in PCI_COMMAND) shouldn't be disabled when
>> updating its IOV BARs with pci_update_resource(). Otherwise, we
>> receives EEH error caused by MMIO access to PF's memory BARs during
>> the window when PF's memory decoding is disabled.
>
>The fact that you get EEH errors is irrelevant.  We can't write code
>simply to avoid errors -- we have to write code to make the system
>work correctly.
>
>I do not want to add a "mmio_force_on" parameter to
>pci_update_resource().  That puts the burden on the caller to
>understand this subtle issue.  If the caller passes mmio_force_on=1
>when it shouldn't, things will almost always work, but once in a blue
>moon a half-updated BAR will conflict with some other device in the
>system, and we'll have an unreproducible, undebuggable crash.
>

Bjorn, thanks for your comments. Yes, the EEH error was caused by MMIO
access to PF's normal BARs, not VF BARs. Yeah, I also had the conern
that adding parameter to pci_update_resource() increases the visible
complexity to the caller of the function.

>What you do need is an explanation of why it's safe to non-atomically
>update a VF BARx in the SR-IOV capability.  I think this probably
>involves the VF MSE bit, and you probably have to either disable VFs
>completely or clear the MSE bit while you're updating the VF BARx.  We
>should be able to do this inside pci_update_resource() without
>changing the interface.
>

Yes, It's what PATCH[1/2] does: (PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE)
are set after VF BARs are updated with pci_update_resource() in this PPC
specific scenario. There are other two situations where the IOV BARs are
updated: PCI resource resizing and allocation during system booting or hot
adding PF. The VF shouldn't be enabled in both cases when updating IOV BARs.

I think you suggest to add check in pci_update_resource(): Don't disable
PF's memory decoding when updating VF BARs. I will send updated revision
if it's what you want.

	/*
	 * The PF might be functional when updating its IOV BARs. So PF's
	 * memory decoding shouldn't be disabled when updating its IOV BARs.
	 */
	disable = (res->flags & IORESOURCE_MEM_64) && !dev->mmio_always_on;
#ifdef CONFIG_PCI_IOV
	disable &= !(resno >= PCI_IOV_RESOURCES &&
		     resno <= PCI_IOV_RESOURCE_END);
#endif
	if (disable) {
		pci_read_config_word(dev, PCI_COMMAND, &cmd);
		pci_write_config_word(dev, PCI_COMMAND,
				      cmd & ~PCI_COMMAND_MEMORY);
	}

Thanks,
Gavin

>>    sriov_numvfs_store
>>    pdev->driver->sriov_configure
>>    mlx5_core_sriov_configure
>>    pci_enable_sriov
>>    sriov_enable
>>    pcibios_sriov_enable
>>    pnv_pci_sriov_enable
>>    pnv_pci_vf_resource_shift
>>    pci_update_resource
>> 
>> This doesn't change the PF's memory decoding in the path by introducing
>> additional parameter (@mmio_force_on) to pci_update_resource() in
>> the above path.
>
>> 
>> Reported-by: Carol Soto <clsoto@us.ibm.com>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Tested-by: Carol Soto <clsoto@us.ibm.com>
>> ---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
>>  drivers/pci/iov.c                         | 2 +-
>>  drivers/pci/pci.c                         | 2 +-
>>  drivers/pci/setup-res.c                   | 9 +++++----
>>  include/linux/pci.h                       | 2 +-
>>  5 files changed, 9 insertions(+), 8 deletions(-)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 38a5c65..f4ccc5b 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1006,7 +1006,7 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>  		dev_info(&dev->dev, "VF BAR%d: %pR shifted to %pR (%sabling %d VFs shifted by %d)\n",
>>  			 i, &res2, res, (offset > 0) ? "En" : "Dis",
>>  			 num_vfs, offset);
>> -		pci_update_resource(dev, i + PCI_IOV_RESOURCES);
>> +		pci_update_resource(dev, i + PCI_IOV_RESOURCES, true);
>>  	}
>>  	return 0;
>>  }
>> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> index f1343f0..db31966 100644
>> --- a/drivers/pci/iov.c
>> +++ b/drivers/pci/iov.c
>> @@ -511,7 +511,7 @@ static void sriov_restore_state(struct pci_dev *dev)
>>  		return;
>>  
>>  	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++)
>> -		pci_update_resource(dev, i);
>> +		pci_update_resource(dev, i, false);
>>  
>>  	pci_write_config_dword(dev, iov->pos + PCI_SRIOV_SYS_PGSIZE, iov->pgsz);
>>  	pci_iov_set_numvfs(dev, iov->num_VFs);
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index aab9d51..87a33c0 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -545,7 +545,7 @@ static void pci_restore_bars(struct pci_dev *dev)
>>  		return;
>>  
>>  	for (i = 0; i < PCI_BRIDGE_RESOURCES; i++)
>> -		pci_update_resource(dev, i);
>> +		pci_update_resource(dev, i, false);
>>  }
>>  
>>  static const struct pci_platform_pm_ops *pci_platform_pm;
>> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
>> index 66c4d8f..e8a50ff 100644
>> --- a/drivers/pci/setup-res.c
>> +++ b/drivers/pci/setup-res.c
>> @@ -26,7 +26,7 @@
>>  #include "pci.h"
>>  
>>  
>> -void pci_update_resource(struct pci_dev *dev, int resno)
>> +void pci_update_resource(struct pci_dev *dev, int resno, bool mmio_force_on)
>>  {
>>  	struct pci_bus_region region;
>>  	bool disable;
>> @@ -81,7 +81,8 @@ void pci_update_resource(struct pci_dev *dev, int resno)
>>  	 * disable decoding so that a half-updated BAR won't conflict
>>  	 * with another device.
>>  	 */
>> -	disable = (res->flags & IORESOURCE_MEM_64) && !dev->mmio_always_on;
>> +	disable = (res->flags & IORESOURCE_MEM_64) &&
>> +		  !mmio_force_on && !dev->mmio_always_on;
>>  	if (disable) {
>>  		pci_read_config_word(dev, PCI_COMMAND, &cmd);
>>  		pci_write_config_word(dev, PCI_COMMAND,
>> @@ -310,7 +311,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
>>  	res->flags &= ~IORESOURCE_STARTALIGN;
>>  	dev_info(&dev->dev, "BAR %d: assigned %pR\n", resno, res);
>>  	if (resno < PCI_BRIDGE_RESOURCES)
>> -		pci_update_resource(dev, resno);
>> +		pci_update_resource(dev, resno, false);
>>  
>>  	return 0;
>>  }
>> @@ -350,7 +351,7 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
>>  	dev_info(&dev->dev, "BAR %d: reassigned %pR (expanded by %#llx)\n",
>>  		 resno, res, (unsigned long long) addsize);
>>  	if (resno < PCI_BRIDGE_RESOURCES)
>> -		pci_update_resource(dev, resno);
>> +		pci_update_resource(dev, resno, false);
>>  
>>  	return 0;
>>  }
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 0ab8359..99231d1 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1039,7 +1039,7 @@ int pci_try_reset_bus(struct pci_bus *bus);
>>  void pci_reset_secondary_bus(struct pci_dev *dev);
>>  void pcibios_reset_secondary_bus(struct pci_dev *dev);
>>  void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
>> -void pci_update_resource(struct pci_dev *dev, int resno);
>> +void pci_update_resource(struct pci_dev *dev, int resno, bool mmio_force_on);
>>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
>>  int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
>>  int pci_select_bars(struct pci_dev *dev, unsigned long flags);
>> -- 
>> 2.1.0
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
