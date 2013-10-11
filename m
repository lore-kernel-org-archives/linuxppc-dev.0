Return-Path: <wangyijing@huawei.com>
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [119.145.14.66])
 (using TLSv1 with cipher DES-CBC3-SHA (168/168 bits))
 (Client CN "myname.my.domain", Issuer "www.mirapoint.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B26B62C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Oct 2013 17:36:39 +1100 (EST)
Message-ID: <52579A7D.4040901@huawei.com>
Date: Fri, 11 Oct 2013 14:28:13 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 3/6] powerpc/pci: use pci_is_pcie() to simplify code
References: <1378367730-25996-1-git-send-email-wangyijing@huawei.com>
 <1378367730-25996-3-git-send-email-wangyijing@huawei.com>
 <20130906203035.GA27940@google.com> <1381470596.5630.61.camel@pasglop>
In-Reply-To: <1381470596.5630.61.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
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

On 2013/10/11 13:49, Benjamin Herrenschmidt wrote:
> On Fri, 2013-09-06 at 14:30 -0600, Bjorn Helgaas wrote:
>> On Thu, Sep 05, 2013 at 03:55:27PM +0800, Yijing Wang wrote:
>>> Use pci_is_pcie() to simplify code.
>>>
>>> Acked-by: Kumar Gala <galak@kernel.crashing.org>
>>> Reviewed-by: Gavin Shan <shangw@linux.vnet.ibm.com>
>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Cc: Paul Mackerras <paulus@samba.org>
>>> Cc: linuxppc-dev@lists.ozlabs.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>  arch/powerpc/kernel/eeh.c     |    3 +--
>>>  arch/powerpc/sysdev/fsl_pci.c |    2 +-
>>>  2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> Ben, Paul, this has no dependencies on anything new to PCI or any
>> other patches in this series, so you can take it through the POWERPC
>> tree.  If you don't want to do that, let me know and I can take it.
>>
>> If you want it:
>>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> It's also quite broken :-)
> 
> See below:
> 
>>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>>> index 55593ee..6ebbe54 100644
>>> --- a/arch/powerpc/kernel/eeh.c
>>> +++ b/arch/powerpc/kernel/eeh.c
>>> @@ -189,8 +189,7 @@ static size_t eeh_gather_pci_data(struct eeh_dev *edev, char * buf, size_t len)
>>>  	}
>>>  
>>>  	/* If PCI-E capable, dump PCI-E cap 10, and the AER */
>>> -	cap = pci_find_capability(dev, PCI_CAP_ID_EXP);
>>> -	if (cap) {
>>> +	if (pci_is_pcie(dev)) {
>>>  		n += scnprintf(buf+n, len-n, "pci-e cap10:\n");
>>>  		printk(KERN_WARNING
>>>  		       "EEH: PCI-E capabilities and status follow:\n");
> 
> So we remove reading of "cap", but slightly further down the code does:
> 
> 		for (i=0; i<=8; i++) {
> 			eeh_ops->read_config(dn, cap+4*i, 4, &cfg);
> 			n += scnprintf(buf+n, len-n, "%02x:%x\n", 4*i, cfg);
> 			printk(KERN_WARNING "EEH: PCI-E %02x: %08x\n", i, cfg);
> 		}
> 
> Which actually *uses* the value of "cap" ... oops :-)

Hi Benjamin,
   Thanks for your review and comments!  I will update it at once.

Thanks!
Yijing.

> 
>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>>> index 46ac1dd..5402a1d 100644
>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>>> @@ -41,7 +41,7 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
>>>  	u8 hdr_type;
>>>  
>>>  	/* if we aren't a PCIe don't bother */
>>> -	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
>>> +	if (!pci_is_pcie(dev))
>>>  		return;
>>>  
>>>  	/* if we aren't in host mode don't bother */
>>> -- 
>>> 1.7.1
>>>
>>>
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> .
> 


-- 
Thanks!
Yijing
