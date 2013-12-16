Return-Path: <wangyijing@huawei.com>
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [119.145.14.64])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5EC462C009A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 20:06:45 +1100 (EST)
Message-ID: <52AEC241.1040507@huawei.com>
Date: Mon, 16 Dec 2013 17:05:05 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/9] powerpc/pci: Use dev_is_pci() to check whether it
 is pci device
References: <1386244880-22300-1-git-send-email-wangyijing@huawei.com>
 <20131216071305.GA16842@weiyang.vnet.ibm.com>
In-Reply-To: <20131216071305.GA16842@weiyang.vnet.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Scott Wood <scottwood@freescale.com>, Paul Mackerras <paulus@samba.org>,
 Hanjun Guo <guohanjun@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2013/12/16 15:13, Wei Yang wrote:
> Yijing,
> 
> This one looks good.
> 
> While I take a look at the source code, there are around 20 places with
> similar style. Do you think it would be good to change all these places
> in one patch?

I sent the other similar changes to related maillist, some of them (David, Greg )has been accepted,
and other is not. :)

eg.
http://article.gmane.org/gmane.linux.kernel/1608341/match=dev_is_pci

Thanks!
Yijing.

> 
> On Thu, Dec 05, 2013 at 08:01:20PM +0800, Yijing Wang wrote:
>> Use PCI standard marco dev_is_pci() instead of directly compare
>> pci_bus_type to check whether it is pci device.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> ---
>> arch/powerpc/sysdev/fsl_pci.c |    2 +-
>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>> index 4dfd61d..7066e52 100644
>> --- a/arch/powerpc/sysdev/fsl_pci.c
>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>> @@ -122,7 +122,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
>> 	 * address width of the SoC such that we can address any internal
>> 	 * SoC address from across PCI if needed
>> 	 */
>> -	if ((dev->bus == &pci_bus_type) &&
>> +	if ((dev_is_pci(dev)) &&
>> 	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
>> 		set_dma_ops(dev, &dma_direct_ops);
>> 		set_dma_offset(dev, pci64_dma_offset);
>> -- 
>> 1.7.1
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 


-- 
Thanks!
Yijing
