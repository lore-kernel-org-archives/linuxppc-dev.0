Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t5HtR5xLhzDvTC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Oct 2016 09:07:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/64: Used named initialisers for ibm_pa_features
In-Reply-To: <812af4fb-a672-c058-1ab6-0ee77928d42e@gmail.com>
References: <1477636793-32760-1-git-send-email-mpe@ellerman.id.au>
 <812af4fb-a672-c058-1ab6-0ee77928d42e@gmail.com>
Date: Sat, 29 Oct 2016 09:07:26 +1100
Message-ID: <878tt82km9.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 28/10/16 17:39, Michael Ellerman wrote:
>> 
>> I've tested this but I would appreciate if someone can verify I didn't typo
>> anything when transcribing it.
>> 
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index b0245bed6f54..a7b87b6b4ef4 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -156,21 +156,22 @@ static struct ibm_pa_feature {
>>  	unsigned char	pabit;		/* bit number (big-endian) */
>>  	unsigned char	invert;		/* if 1, pa bit set => clear feature */
>>  } ibm_pa_features[] __initdata = {
>> -	{0, 0, PPC_FEATURE_HAS_MMU, 0,		0, 0, 0},
>> -	{0, 0, PPC_FEATURE_HAS_FPU, 0,		0, 1, 0},
>> -	{CPU_FTR_CTRL, 0, 0, 0,			0, 3, 0},
>> -	{CPU_FTR_NOEXECUTE, 0, 0, 0,		0, 6, 0},
>> -	{CPU_FTR_NODSISRALIGN, 0, 0, 0,		1, 1, 1},
>> -	{0, MMU_FTR_CI_LARGE_PAGE, 0, 0,		1, 2, 0},
>> -	{CPU_FTR_REAL_LE, 0, PPC_FEATURE_TRUE_LE, 0, 5, 0, 0},
>> +	{ .pabyte = 0,  .pabit = 0, .cpu_user_ftrs = PPC_FEATURE_HAS_MMU },
>> +	{ .pabyte = 0,  .pabit = 1, .cpu_user_ftrs = PPC_FEATURE_HAS_FPU },
>> +	{ .pabyte = 0,  .pabit = 3, .cpu_features  = CPU_FTR_CTRL },
>> +	{ .pabyte = 0,  .pabit = 6, .cpu_features  = CPU_FTR_NOEXECUTE },
>> +	{ .pabyte = 1,  .pabit = 2, .mmu_features  = MMU_FTR_CI_LARGE_PAGE },
>> +	{ .pabyte = 40, .pabit = 0, .mmu_features  = MMU_FTR_TYPE_RADIX },
>> +	{ .pabyte = 1,  .pabit = 1, .invert = 1, .cpu_features = CPU_FTR_NODSISRALIGN },
>> +	{ .pabyte = 5,  .pabit = 0, .cpu_features  = CPU_FTR_REAL_LE,
>> +				    .cpu_user_ftrs = PPC_FEATURE_TRUE_LE },
>>  	/*
>>  	 * If the kernel doesn't support TM (ie CONFIG_PPC_TRANSACTIONAL_MEM=n),
>>  	 * we don't want to turn on TM here, so we use the *_COMP versions
>>  	 * which are 0 if the kernel doesn't support TM.
>>  	 */
>> -	{CPU_FTR_TM_COMP, 0, 0,
>> -	 PPC_FEATURE2_HTM_COMP|PPC_FEATURE2_HTM_NOSC_COMP, 22, 0, 0},
>> -	{0, MMU_FTR_TYPE_RADIX, 0, 0,		40, 0, 0},
>> +	{ .pabyte = 22, .pabit = 0, .cpu_features = CPU_FTR_TM_COMP,
>> +	  .cpu_user_ftrs2 = PPC_FEATURE2_HTM_COMP | PPC_FEATURE2_HTM_NOSC_COMP },
>>  };
>>  
>
> The code looks easier to parse with this

I know, but did you check I didn't make a typo :)

cheers
