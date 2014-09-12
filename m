Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D2D6B1A006B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 19:35:39 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 12 Sep 2014 15:05:31 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C65811258048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:05:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8C9ZtUe43909300
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:05:56 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8C9ZRDJ003079
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 15:05:28 +0530
Date: Fri, 12 Sep 2014 17:35:25 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] powerpc/eeh: Fix kernel crash when passing through VF
Message-ID: <20140912093525.GA6916@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
References: <1410406921-8557-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1410494123.17540.2.camel@concordia>
 <20140912050518.GA17933@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140912050518.GA17933@shangw>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2014 at 03:05:18PM +1000, Gavin Shan wrote:
>On Fri, Sep 12, 2014 at 01:55:23PM +1000, Michael Ellerman wrote:
>>On Thu, 2014-09-11 at 11:42 +0800, Wei Yang wrote:
>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>> index 4a45ba8..403445e 100644
>>> --- a/arch/powerpc/kernel/eeh.c
>>> +++ b/arch/powerpc/kernel/eeh.c
>>> @@ -625,7 +625,7 @@ int eeh_pci_enable(struct eeh_pe *pe, int function)
>>>  int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
>>>  {
>>>  	struct eeh_dev *edev = pci_dev_to_eeh_dev(dev);
>>> -	struct eeh_pe *pe = edev->pe;
>>> +	struct eeh_pe *pe = edev ? edev->pe : NULL;
>>>  
>>>  	if (!pe) {
>>>  		pr_err("%s: No PE found on PCI device %s\n",
>>
>>
>>We seem to do this or something similar in a few places. Is it worth having a
>>pci_dev_to_eeh_pe() inline?
>>
>
>Yes, maybe we just need a eeh_dev_to_pe() because converting
>pci_dev to eeh_dev is already coverred by pci_dev_to_eeh_dev().
>
>With eeh_dev_to_pe(), it looks like this:
>
>struct pci_dev *pdev;
>struct eeh_dev *edev = pci_dev_to_eeh_dev(pdev);
>struct eeh_pe *pe = eeh_dev_to_pe(edev);
>
>Or another case:
>
>struct device_node *dn;
>struct eeh_dev *edev = of_node_to_eeh_dev(dn);
>struct eeh_pe *pe = eeh_dev_to_pe(edev);

With these helper, it would be more consolidate to jump between those data.

Gavin,

You would add these helpers? Or would like me to add them?

>
>Thanks,
>Gavin
>
>>cheers
>>
>>

-- 
Richard Yang
Help you, Help me
