Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5554C1A03D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 14:20:07 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 14:20:06 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0AF532CE804D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 14:20:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9141h9L23330834
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 14:01:44 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s914K3cu016350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 14:20:03 +1000
Date: Wed, 1 Oct 2014 14:20:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [02/21] powerpc/eeh: Add eeh_pe_state sysfs entry
Message-ID: <20141001042002.GA23382@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1412044750-24460-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <20141001034343.9626514012C@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141001034343.9626514012C@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 01, 2014 at 01:43:43PM +1000, Michael Ellerman wrote:
>On Tue, 2014-30-09 at 02:38:51 UTC, Gavin Shan wrote:
>> diff --git a/arch/powerpc/kernel/eeh_sysfs.c b/arch/powerpc/kernel/eeh_sysfs.c
>> index e2595ba..eb15be4 100644
>> --- a/arch/powerpc/kernel/eeh_sysfs.c
>> +++ b/arch/powerpc/kernel/eeh_sysfs.c
>> @@ -54,6 +54,62 @@ EEH_SHOW_ATTR(eeh_mode,            mode,            "0x%x");
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
>> +		return -ENODEV;
>> +
>> +	state = eeh_ops->get_state(edev->pe, NULL);
>> +	return sprintf(buf, "%08x %08x\n",
>> +		       state, edev->pe->state);
>
>Looking at all the other eeh sysfs files, they all use 0x%x. Which makes it
>much clearer when you're looking at the file in userspace that the content is
>hex.
>
>Please send an incremental patch to change the format to 0x%08x, unless there's
>a good reason not to.
>

Agree and will do :)

Thanks,
Gavin

>cheers
>
