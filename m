Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A38ADDFA9
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 03:58:22 +1000 (EST)
Message-Id: <36CDD079-FEFD-4928-A997-8DE9C2E1D3D0@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <856C2CF2-B219-493F-9FE5-15D21DD5C764@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 5/5] powerpc: Add 86xx support for SWIOTLB
Date: Mon, 20 Apr 2009 12:58:09 -0500
References: <1240244810-32193-1-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-2-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-3-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-4-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-5-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-6-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-7-git-send-email-beckyb@kernel.crashing.org>
	<1240244810-32193-8-git-send-email-beckyb@kernel.crashing.org>
	<856C2CF2-B219-493F-9FE5-15D21DD5C764@kernel.crashing.org>
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2009, at 12:00 PM, Kumar Gala wrote:

>
> On Apr 20, 2009, at 11:26 AM, Becky Bruce wrote:
>
>> Minor code to allow enabling swiotlb on mpc86xx, including
>> Kconfig addition for SWIOTLB.
>>
>> Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
>> ---
>> arch/powerpc/Kconfig                       |   10 ++++++++++
>> arch/powerpc/kernel/dma-swiotlb.c          |    2 ++
>> arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    3 +++
>> 3 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 197f6a3..e47c81d 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -292,6 +292,16 @@ config IOMMU_VMERGE
>> config IOMMU_HELPER
>> 	def_bool PPC64
>>
>> +config SWIOTLB
>> +	bool "SWIOTLB support"
>> +	depends on PPC_86xx
>> +	select IOMMU_HELPER
>> +	---help---
>> +	  Support for IO bounce buffering for systems without an IOMMU.
>> +	  This allows us to DMA to the full physical address space on
>> +	  platforms where the size of a physical address is larger
>> +	  than the bus address.
>> +
>
> As stated on previous patch, move the bulk of this into 4/5.

Yep.

>
>
>>
>> config PPC_NEED_DMA_SYNC_OPS
>> 	def_bool y
>> 	depends on (NOT_COHERENT_CACHE || SWIOTLB)
>> diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/ 
>> kernel/dma-swiotlb.c
>> index 29a68e6..3065d03 100644
>> --- a/arch/powerpc/kernel/dma-swiotlb.c
>> +++ b/arch/powerpc/kernel/dma-swiotlb.c
>> @@ -159,3 +159,5 @@ static int __init setup_bus_notifier(void)
>>
>> 	return 0;
>> }
>> +
>> +machine_arch_initcall(mpc86xx_hpcn, setup_bus_notifier);
>
> Hmm, not sure what we chatted about here, but I don't want to have  
> to add every board into this file to register the bus notifiers.

We talked about this, and this was what we decided on - I don't really  
like the idea, either, but there's a lot of precedent for it.  I'd  
like to do this differently, but I"m not sure what the solution is -  
we'd need to look into that more (or perhaps someone here will have  
some sage advice).

Cheers,
B
