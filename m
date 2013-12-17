Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E80A62C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 13:02:23 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 17 Dec 2013 12:02:22 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A87262BB0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 13:02:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBH1hphG42532948
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 12:43:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBH22Ipo018011
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Dec 2013 13:02:19 +1100
Date: Tue, 17 Dec 2013 10:02:17 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Yijing Wang <wangyijing@huawei.com>
Subject: Re: [PATCH 6/9] powerpc/pci: Use dev_is_pci() to check whether it is
 pci device
Message-ID: <20131217020217.GA7677@weiyang.vnet.ibm.com>
References: <1386244880-22300-1-git-send-email-wangyijing@huawei.com>
 <20131216071305.GA16842@weiyang.vnet.ibm.com>
 <52AEC241.1040507@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52AEC241.1040507@huawei.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Hanjun Guo <guohanjun@huawei.com>,
 linux-kernel@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 Paul Mackerras <paulus@samba.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Dec 16, 2013 at 05:05:05PM +0800, Yijing Wang wrote:
>On 2013/12/16 15:13, Wei Yang wrote:
>> Yijing,
>> 
>> This one looks good.
>> 
>> While I take a look at the source code, there are around 20 places with
>> similar style. Do you think it would be good to change all these places
>> in one patch?
>
>I sent the other similar changes to related maillist, some of them (David, Greg )has been accepted,
>and other is not. :)
>
>eg.
>http://article.gmane.org/gmane.linux.kernel/1608341/match=dev_is_pci

Ah, I see. Thanks :-)

>
>Thanks!
>Yijing.
>
>> 
>> On Thu, Dec 05, 2013 at 08:01:20PM +0800, Yijing Wang wrote:
>>> Use PCI standard marco dev_is_pci() instead of directly compare
>>> pci_bus_type to check whether it is pci device.
>>>
>>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>>> ---
>>> arch/powerpc/sysdev/fsl_pci.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
>>> index 4dfd61d..7066e52 100644
>>> --- a/arch/powerpc/sysdev/fsl_pci.c
>>> +++ b/arch/powerpc/sysdev/fsl_pci.c
>>> @@ -122,7 +122,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
>>> 	 * address width of the SoC such that we can address any internal
>>> 	 * SoC address from across PCI if needed
>>> 	 */
>>> -	if ((dev->bus == &pci_bus_type) &&
>>> +	if ((dev_is_pci(dev)) &&
>>> 	    dma_mask >= DMA_BIT_MASK(MAX_PHYS_ADDR_BITS)) {
>>> 		set_dma_ops(dev, &dma_direct_ops);
>>> 		set_dma_offset(dev, pci64_dma_offset);
>>> -- 
>>> 1.7.1
>>>
>>>
>>> _______________________________________________
>>> Linuxppc-dev mailing list
>>> Linuxppc-dev@lists.ozlabs.org
>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>> 
>
>
>-- 
>Thanks!
>Yijing

-- 
Richard Yang
Help you, Help me
