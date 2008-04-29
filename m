Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 27D1FDDE05
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:14:58 +1000 (EST)
Message-Id: <0ACF4915-6674-4627-8945-CC91E54C830E@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
To: benh@kernel.crashing.org
In-Reply-To: <1209181131.5420.42.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: Enabling 64 bit data type for dma_addr_t on non PPC64 architecture
Date: Tue, 29 Apr 2008 10:14:44 -0500
References: <BA76C315ECE5B149AE7194FE094819E205E59014@SDCEXCHANGE01.ad.amcc.com>
	<1209181131.5420.42.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Tushar Tyagi <ttyagi@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2008, at 10:38 PM, Benjamin Herrenschmidt wrote:
>
> On Fri, 2008-04-25 at 19:52 -0700, Tushar Tyagi wrote:
>> Hello,
>> I'm working a new DMA hardware for PPC processors.
>> The processor is a 32 bit architecture having 40 bit physical address
>> space.
>> So we need the 32 bit processor code base but we want the type
>> dma_addr_t to represent 64 bit data, without enabling the  
>> CONFIG_PPC64
>> flag.
>
> That shouldn't be a big issue, we already support 64 bits resources,
> extending dma_addr_t shouldn't too hard.
>
>> We want to use the Linux generic DMA layer to offload DMA  
>> operations to
>> the hw and the Linux code path goes through function
>> dma_async_memcpy_buf_to_buf and then dma_map_single.
>>
>> Currently the dma_map_single function has 2 versions based upon
>> CONFIG_PPC64 defined or not.
>>
>> Is it possible to reuse the CONFIG_PPC64 based code only pertaining  
>> to
>> DMA by doing the following:
>
> It's possible, it might be a good idea even as it would allow to have
> different implementations for different busses, which is in fact  
> needed
> for some things like 4xx if we start changing the mapping between
> different PCI bridges vs. SoCs. In fact, I think there's been some
> patches from Becky Bruce posted in februrary for doing just that,  
> which
> I totally forgot to review...
>
>> Add a new flag called CONFIG_DMA64 along with CONFIG_PPC64 and
>> __powerpc64__ flags, enabling our code to use the generic DMA layer  
>> with
>> 64 bit data type for dma_addr_t.
>>
>> With the above modification, the function dma_map_single starts
>> returning 64 bit data type instead of 32.
>>
>> Do you have any comments or suggestions ?
>
> I'd suggest working with Becky on her initial patch and using that as
> the basis for your stuff. I'll try to give it a good review asap.

Actually, Ben, wait on that review - I've made significant changes to  
those patches, including some bugfixes for HIGHMEM and will be posting  
the revised version soon (hopefully later today or tomorrow).   I'm  
behind a bit on the top-of-tree so I'll need to bring them up to date  
and do some testing before I post.  I think the newer version is  
cleaner than the last but can still probably use some improvement.

I've also got a patch that enables larger physical addressing in  
general - it changes the page table/mmu handling to allow for larger  
physical addresses on MPC8641; BookE parts will need a slightly  
different set of changes (some of which are already in place, but I've  
not done any work/testing on BookE at this point).  I'll try to get a  
version of that out this week as well - it needs some cleanup and  
testing on the latest tree.

Cheers,
Becky
