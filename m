Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e8.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2E4B12C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 17:53:47 +1100 (EST)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Fri, 11 Oct 2013 02:53:44 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 98D4838C803B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 02:53:41 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9B6rgBx42401908
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 06:53:42 GMT
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r9B6rfnP029956
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 03:53:42 -0300
Date: Fri, 11 Oct 2013 14:53:29 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH v2 3/6] powerpc/pci: use pci_is_pcie() to simplify code
Message-ID: <20131011065329.GA5013@shangw.(null)>
References: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
 <1378367730-25996-3-git-send-email-wangyijing@huawei.com>
 <20130906203035.GA27940@google.com>
 <1381470596.5630.61.camel@pasglop>
 <20131011061654.GA561@shangw.(null)> <52579BD6.40802@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52579BD6.40802@huawei.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Oct 11, 2013 at 02:33:58PM +0800, Yijing Wang wrote:
>On 2013/10/11 14:16, Gavin Shan wrote:
>> On Fri, Oct 11, 2013 at 04:49:56PM +1100, Benjamin Herrenschmidt wrote:
>>> On Fri, 2013-09-06 at 14:30 -0600, Bjorn Helgaas wrote:
>>>> On Thu, Sep 05, 2013 at 03:55:27PM +0800, Yijing Wang wrote:

.../...

>>>>> Use pci_is_pcie() to simplify code.
>>>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>>>> index 55593ee..6ebbe54 100644
>>>>> --- a/arch/powerpc/kernel/eeh.c
>>>>> +++ b/arch/powerpc/kernel/eeh.c
>>>>> @@ -189,8 +189,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
>>>>>  	}
>>>>>  
>>>>>  	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
>>>>> -	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
>>>>> -	if (cap) {
>>>>> +	if (pci_is_pcie(dev)) {
>>>>>  		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
>>>>>  		printk(KERN_WARNING
>>>>>  		       "EEH: PCI-E capabilities and status follow:\n");
>>>
>>> So we remove reading of "cap", but slightly further down the code does:
>>>
>>> 		for (i=0; i<=8; i++) {
>>> 			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
>>> 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
>>> 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
>>> 		}
>>>
>>> Which actually *uses* the value of "cap" ... oops :-)
>>>
>> 
>> It's my fault and I should have looked into the changes more closely.
>> How about changing it like this:
>> 
>> 	cap = pci_is_pcie(dev) ? pci_pcie_cap(dev) :
>> 	      pci_find_capability(dev, PCI_CAP_ID_EXP);
>> 	if (cap) {
>> 		...
>> 	}
>> 
>> It would save some PCI-CFG access cycles for most cases :-)
>
>Hi Gavin,  it's not your fault, it's my fault. :)
>
>Because pci_pcie_cap(dev) == dev->pcie_cap == pci_find_capability(dev, PCI_CAP_ID_EXP);
>
>so I think it's ok to use dev->pcie_cap instead of stale "cap".
>

Yijing, There has one exception: dev->pcie_cap isn't updated yet.
This function has possibility to be invoked before that. However,
we don't have the binding (eeh device <-> PCI device) for the case.
So the piece of code shouldn't be running

However, it's a bit safer to have pci_find_capability(dev, PCI_CAP_ID_EXP)
as well even though we needn't it for 99.9% cases if you agree :-)

Thanks,
Gavin
