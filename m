Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A658BDE03B
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 04:03:26 +1000 (EST)
Message-Id: <519AC89C-88A5-418A-AD91-488EC13E8387@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <9A5921B1-48D8-49B1-8D10-5DF68DEBF5D3@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 4/5] powerpc: Add support for swiotlb on 32-bit
Date: Mon, 20 Apr 2009 13:03:20 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
	<9A5921B1-48D8-49B1-8D10-5DF68DEBF5D3@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 11:57 AM, Kumar Gala wrote:

>
> On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:
>
>> This patch includes the basic infrastructure to use swiotlb
>> bounce buffering on 32-bit powerpc.  It is not yet enabled on
>> any platforms.
>>
>> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
>> ---
>> arch/powerpc/Kconfig                   |    2 +-
>> arch/powerpc/include/asm/dma-mapping.h |   11 ++
>> arch/powerpc/include/asm/swiotlb.h     |   24 +++++
>> arch/powerpc/kernel/Makefile           |    1 +
>> arch/powerpc/kernel/dma-swiotlb.c      |  161 ++++++++++++++++++++++ 
>> ++++++++++
>> arch/powerpc/kernel/dma.c              |    2 +-
>> arch/powerpc/kernel/setup_32.c         |    4 +
>> 7 files changed, 203 insertions(+), 2 deletions(-)
>> create mode 100644 arch/powerpc/include/asm/swiotlb.h
>> create mode 100644 arch/powerpc/kernel/dma-swiotlb.c
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 5b50e1a..197f6a3 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -294,7 +294,7 @@ config IOMMU_HELPER
>>
>> config PPC_NEED_DMA_SYNC_OPS
>> 	def_bool y
>> -	depends on NOT_COHERENT_CACHE
>> +	depends on (NOT_COHERENT_CACHE || SWIOTLB)
>
> This isn't right, since you haven't introduced the SWIOTLB Kconfig.
>
>
> Why don't we just put the SWIOTLB Kconfig option in here and default  
> it no (and remove the dep on 86xx).

Sure.  I'll probably add a comment or something though so people don't  
think they can just enable it on anything and expect it to work.  Too  
many people seem to read the config files and decide things are  
possible that actually aren't :)

>
>
>> config HOTPLUG_CPU
>> 	bool "Support for enabling/disabling CPUs"
>
>
>> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/ 
>> kernel/dma-swiotlb.c
>> new file mode 100644
>> index 0000000..29a68e6
>> --- /dev/null
>> +++ b/arch/powerpc/kernel/dma-swiotlb.c
>> @@ -0,0 +1,161 @@
>> +/*
>> + * Contains routines needed to support swiotlb for ppc.
>> + *
>> + * Copyright (C) 2009 Becky Bruce, Freescale Semiconductor
>> + *
>> + * This program is free software; you can redistribute  it and/or  
>> modify it
>> + * under  the terms of  the GNU General  Public License as  
>> published by the
>> + * Free Software Foundation;  either version 2 of the  License, or  
>> (at your
>> + * option) any later version.
>> + *
>> + */
>
> [snip]
>
>>
>> +
>> +static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
>> +				  unsigned long action, void *data)
>> +{
>> +	struct device *dev = data;
>> +
>> +	/* We are only intereted in device addition */
>> +	if (action != BUS_NOTIFY_ADD_DEVICE)
>> +		return 0;
>> +
>> +	if (dma_get_mask(dev) < DMA_BIT_MASK(36))
>> +		set_dma_ops(dev, &swiotlb_dma_ops);
>> +
>
> this isn't right.  Isn't possible for a PCI dev to have a  
> DMA_BIT_MASK(64) but us still not be able to dma to it?  Also, I  
> dont like the assumption of 36-bit physical here.

You're right - this is just handling the basic case and for now I'm  
assuming that we don't bounce 64-bit devices (or any device that can  
handle 36 bits).   We'll need to talk in more detail about a solution  
to that problem, because knowing if a 64b dev *might* need to bounce  
(which is all this is really saying) requires more information.   We  
also don't really have infrastructure to deal with holes in the  
visible dev memory, and I don't know if we want to handle that as  
well. I don't want to set the dma_ops to swiotlb unless we have to  
because there's a slight perf hit in running all the checks to see if  
an address needs to be bounced.

Thanks,
B
