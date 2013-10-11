Return-Path: <wangyijing@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 41B2C2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 19:23:59 +1100 (EST)
Message-ID: <5257B541.9050400@huawei.com>
Date: Fri, 11 Oct 2013 16:22:25 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/6] powerpc/pci: use pci_is_pcie() to simplify code
References: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
 <1378367730-25996-3-git-send-email-wangyijing@huawei.com>
 <20130906203035.GA27940@google.com> <1381470596.5630.61.camel@pasglop>
 <20131011061654.GA561@shangw.(null)> <52579BD6.40802@huawei.com>
 <20131011065329.GA5013@shangw.(null)> <5257A882.1070809@huawei.com>
 <20131011075642.GA20443@shangw.(null)>
In-Reply-To: <20131011075642.GA20443@shangw.(null)>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Paul Mackerras <paulus@samba.org>, Hanjun Guo <guohanjun@huawei.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> In my idea, dev->pcie_cap(here is pci_dev->pcie_cap) will update in set_pcie_port_type() function,
>> and this function always be called after allocate pci device. We get pci_dev by eeh_dev_to_pci_dev(),
>> I think pci_dev has been initialized completely.
>>
>>> This function has possibility to be invoked before that. However,
>>> we don't have the binding (eeh device <-> PCI device) for the case.
>>> So the piece of code shouldn't be running
>>
>> In PCI core, I knew
>>
>> pci_scan_device()
>>   pci_setup_device()
>>       set_pcie_port_type()
>>            pci_dev->pcie_cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
>>
>> In powerpc, I also found
>>
>> of_scan_pci_dev()
>>   of_create_pci_dev()
>>       set_pcie_port_type()
>> 	    pci_dev->pcie_cap = pci_find_capability(pdev, PCI_CAP_ID_EXP);
>>>
>>> However, it's a bit safer to have pci_find_capability(dev, PCI_CAP_ID_EXP)
>>> as well even though we needn't it for 99.9% cases if you agree :-)
>>
>> I agree, this function is not the performance bottleneck,
>> safety is more important. :)
>> So if Bjorn and Benjamin think it's not safe, it's ok to drop it. :)
>>
> 
> No, it's not what I mean. Anyway, "v3" looks good to me.
> At least, it can save PCI-CFG access cycles find locate
> the PCIe capability position :-)

Thanks! :)

> 
> Thanks,
> Gavin
> 
> 
> .
> 


-- 
Thanks!
Yijing
