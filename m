Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE1B01A0835
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:48:00 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 25 Sep 2014 14:47:57 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1F7EF2CE8047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:47:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8P4NkLC31785008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:23:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8P4lsX0014023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 14:47:55 +1000
Date: Thu, 25 Sep 2014 14:47:54 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [2/5] powerpc/eeh: Add eeh_pe_state sysfs entry
Message-ID: <20140925044754.GA11163@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1408244549-10221-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <20140925040958.4D2C414016A@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140925040958.4D2C414016A@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2014 at 02:09:58PM +1000, Michael Ellerman wrote:
>On Sun, 2014-17-08 at 03:02:26 UTC, Gavin Shan wrote:
>> The patch adds sysfs entry "eeh_pe_state". Reading on it returns
>> the PE's state while writing to it clears the frozen state. It's
>> used to check or clear the PE frozen state from userland for
>> debugging purpose.
>> 
>> diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
>> index e2595ba..e69bcbb 100644
>> --- a/arch/powerpc/kernel/eeh_sysfs.c
>> +++ b/arch/powerpc/kernel/eeh_sysfs.c
>> @@ -54,6 +54,63 @@ EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
>>  EEH_SHOW_ATTR(eeh_config_addr,     config_addr,     "0x%x");
>>  EEH_SHOW_ATTR(eeh_pe_config_addr,  pe_config_addr,  "0x%x");
>>  
>> +static ssize_t eeh_pe_state_show(struct device *dev,
>> +				 struct device_attribute *attr, char *buf)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
>> +	int state;
>> +
>> +	if (!edev || !edev->pe)
>> +		return 0;
>> +
>> +	state = eeh_ops->get_state(edev->pe, NULL);
>> +	return sprintf(buf, "PHB#%d-PE#%d: 0x%08x 0x%08x\n",
>> +		       edev->pe->phb->global_number,
>> +		       edev->pe->addr, state, edev->pe->state);
>
>Shouldn't this only display the state, ie not the number and addr etc.
>

Yes, I'll remove PHB#%d-PE#%d in next revision. Another sysfs entry
gives the PE number: /sys/bus/pci/devices/xxxx:xx:xx.x/eeh_pe_config_addr

>And why are there two states, state and edev->pe->state ?
>

state is from hardware, edev->pe->state is software maintained state.

>> +static ssize_t eeh_pe_state_store(struct device *dev,
>> +				  struct device_attribute *attr,
>> +				  const char *buf, size_t count)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
>> +	int ret;
>> +
>> +	if (!edev || !edev->pe)
>> +		return 0;
>
>Shouldn't that be an error?
>
>> +	/* Nothing to do if it's not frozen */
>> +	if (!(edev->pe->state & EEH_PE_ISOLATED))
>> +		return 0;
>> +
>> +	/* Enable MMIO */
>> +	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_MMIO);
>> +	if (ret) {
>> +		pr_warn("%s: Failure %d enabling MMIO for PHB#%d-PE#%d\n",
>> +			__func__, ret, edev->pe->phb->global_number,
>> +			edev->pe->addr);
>> +		return 0;
>
>Error ?
>
>> +	}
>> +
>> +	/* Enable DMA */
>> +	ret = eeh_pci_enable(edev->pe, EEH_OPT_THAW_DMA);
>> +	if (ret) {
>> +		pr_warn("%s: Failure %d enabling DMA for PHB#%d-PE#%d\n",
>> +			__func__, ret, edev->pe->phb->global_number,
>> +			edev->pe->addr);
>> +		return 0;
>
>Error?
>

Yes, I'll fix all "Error" cases.

>And should it roll back, ie. unthaw MMIO?
>

It's not necessary as it's only for debugging purpose. The main
purpose is to keep dumping the PE hardware/software state when
recovering one specific PE.

Thanks,
Gavin
