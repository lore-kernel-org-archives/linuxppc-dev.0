Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A66501A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 22:08:07 +1000 (EST)
Message-ID: <53B547A3.1020902@suse.de>
Date: Thu, 03 Jul 2014 14:08:03 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [PATCH] KVM: PPC: e500: Fix default tlb for victim hint
References: <1404132898-27261-1-git-send-email-mihai.caraman@freescale.com>
 <1404152335.2435.130.camel@snotra.buserror.net>
In-Reply-To: <1404152335.2435.130.camel@snotra.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.06.14 20:18, Scott Wood wrote:
> On Mon, 2014-06-30 at 15:54 +0300, Mihai Caraman wrote:
>> Tlb search operation used for victim hint relies on the default tlb set by the
>> host. When hardware tablewalk support is enabled in the host, the default tlb is
>> TLB1 which leads KVM to evict the bolted entry. Set and restore the default tlb
>> when searching for victim hint.
>>
>> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
>> ---
>>   arch/powerpc/include/asm/mmu-book3e.h | 5 ++++-
>>   arch/powerpc/kvm/e500_mmu_host.c      | 4 ++++
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/mmu-book3e.h b/arch/powerpc/include/asm/mmu-book3e.h
>> index 901dac6..5dad378 100644
>> --- a/arch/powerpc/include/asm/mmu-book3e.h
>> +++ b/arch/powerpc/include/asm/mmu-book3e.h
>> @@ -40,7 +40,9 @@
>>   
>>   /* MAS registers bit definitions */
>>   
>> -#define MAS0_TLBSEL(x)		(((x) << 28) & 0x30000000)
>> +#define MAS0_TLBSEL_MASK        0x30000000
>> +#define MAS0_TLBSEL_SHIFT       28
>> +#define MAS0_TLBSEL(x)          (((x) << MAS0_TLBSEL_SHIFT) & MAS0_TLBSEL_MASK)
>>   #define MAS0_ESEL_MASK		0x0FFF0000
>>   #define MAS0_ESEL_SHIFT		16
>>   #define MAS0_ESEL(x)		(((x) << MAS0_ESEL_SHIFT) & MAS0_ESEL_MASK)
>> @@ -86,6 +88,7 @@
>>   #define MAS3_SPSIZE		0x0000003e
>>   #define MAS3_SPSIZE_SHIFT	1
>>   
>> +#define MAS4_TLBSEL_MASK	MAS0_TLBSEL_MASK
>>   #define MAS4_TLBSELD(x) 	MAS0_TLBSEL(x)
>>   #define MAS4_INDD		0x00008000	/* Default IND */
>>   #define MAS4_TSIZED(x)		MAS1_TSIZE(x)
>> diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
>> index dd2cc03..79677d7 100644
>> --- a/arch/powerpc/kvm/e500_mmu_host.c
>> +++ b/arch/powerpc/kvm/e500_mmu_host.c
>> @@ -107,11 +107,15 @@ static u32 get_host_mas0(unsigned long eaddr)
>>   {
>>   	unsigned long flags;
>>   	u32 mas0;
>> +	u32 mas4;
>>   
>>   	local_irq_save(flags);
>>   	mtspr(SPRN_MAS6, 0);
>> +	mas4 = mfspr(SPRN_MAS4);
>> +	mtspr(SPRN_MAS4, mas4 & ~MAS4_TLBSEL_MASK);
>>   	asm volatile("tlbsx 0, %0" : : "b" (eaddr & ~CONFIG_PAGE_OFFSET));
>>   	mas0 = mfspr(SPRN_MAS0);
>> +	mtspr(SPRN_MAS4, mas4);
>>   	local_irq_restore(flags);
>>   
>>   	return mas0;
> Reviewed-by: Scott Wood <scottwood@freescale.com>

Thanks, applied to kvm-ppc-queue.


Alex
