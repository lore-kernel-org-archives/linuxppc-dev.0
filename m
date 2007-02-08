Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8E1CDDDE2E
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 17:54:21 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D4401@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D4401@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17A046C6-5FD3-46D5-AB96-EAEDF22FA829@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] ucc_geth: Change private immrbar_virt_to_phys to
	generic iopa
Date: Thu, 8 Feb 2007 00:53:23 -0600
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: netdev@vger.kernel.org, Tabi Timur-B04825 <timur@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 12:48 AM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Thursday, February 08, 2007 1:58 PM
>> To: Li Yang-r58472
>> Cc: Tabi Timur-B04825; netdev@vger.kernel.org; linuxppc- 
>> dev@ozlabs.org
>> Subject: Re: [PATCH 1/4] ucc_geth: Change private  
>> immrbar_virt_to_phys
> to generic
>> iopa
>>
>>
>> On Feb 7, 2007, at 11:52 PM, Li Yang-r58472 wrote:
>>
>>>> -----Original Message-----
>>>> From: Timur Tabi [mailto:timur@freescale.com]
>>>> Sent: Thursday, February 08, 2007 1:03 AM
>>>> To: Kumar Gala
>>>> Cc: Li Yang-r58472; netdev@vger.kernel.org; linuxppc-dev@ozlabs.org
>>>> Subject: Re: [PATCH 1/4] ucc_geth: Change private
>>>> immrbar_virt_to_phys
>>> to generic
>>>> iopa
>>>>
>>>> Kumar Gala wrote:
>>>>
>>>>> If its been mapped with ioremap() you know the physical address
>>> already
>>>>> so why do you need iopa().
>>>>
>>>> That's what the original function immrbar_virt_to_phys() does.
> We're
>>> trying to
>>>> get rid of it, because we thought is redundant with iopa().
>>>>
>>>> static inline unsigned long immrbar_virt_to_phys(volatile void *
>>> address)
>>>> {
>>>> 	if ( ((u32)address >= (u32)qe_immr) &&
>>>> 			((u32)address < ((u32)qe_immr + QE_IMMAP_SIZE))
>>> )
>>>> 		return (unsigned long)(address - (u32)qe_immr +
>>>> 				(u32)get_qe_base());
>>>> 	return (unsigned long)virt_to_phys(address);
>>>> }
>>>>
>>>> get_qe_base() does a search of the OF tree the first time it's
>>>> called.
>>>>
>>>> Here's the code that calls immrbar_virt_to_phys():
>>>>
>>>> 	out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
>>>> 		 (u32) immrbar_virt_to_phys(ugeth->
>>>> 					    p_tx_bd_ring[i]));
>>>>
>>>>
>>>> Would it be better to replace this code with something like this:
>>>>
>>>> out_be32(&ugeth->p_send_q_mem_reg->sqqd[i].bd_ring_base,
>>>> 	get_qe_base() + ((void *) ugeth->p_tx_bd_ring[i] - (void *)
>>> qe_immr));
>>>
>>> No, we don't know if the BD ring is in MURAM or main memory as it is
>>> configurable.  iopa() is best choice to handle both case, IMHO.
>>
>> Does MURAM behave differently than normal memory?
>
> MURAM is a mmio region so it don't share the characteristic of main
> memory that phy_addr = virt_addr - PAGE_OFFSET.  While they can  
> both be
> mapped through page table using iopa().

Right, so when do you know if you'll be using MURAM or normal  
memory?  Why not just keep around a token that is the physical  
address at the point you make the decision of MURAM vs normal memory.

- k
