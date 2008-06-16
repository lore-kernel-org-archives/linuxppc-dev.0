Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 63819DDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 04:02:11 +1000 (EST)
Message-Id: <1CB8E1F2-9BE6-468D-81D8-431CB9FFDA77@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Becky Bruce <becky.bruce@freescale.com>
In-Reply-To: <8037A14F-8CCA-4920-8B26-F31ACCD012C7@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Mon, 16 Jun 2008 13:01:38 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<8037A14F-8CCA-4920-8B26-F31ACCD012C7@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 16, 2008, at 11:56 AM, Becky Bruce wrote:

>
> On Jun 16, 2008, at 10:46 AM, Kumar Gala wrote:
>
>> The new e500mc core from Freescale is based on the e500v2 but with  
>> the
>> following changes:
>>
>> * Supports only the Enhanced Debug Architecture (DSRR0/1, etc)
>> * Floating Point
>> * No SPE
>> * Supports lwsync
>> * Doorbell Exceptions
>> * Hypervisor
>>
>> ---
>>
>> In my powerpc-next tree.
>>
>> arch/powerpc/kernel/cputable.c         |   15 +++++++++++++++
>> arch/powerpc/kernel/head_booke.h       |    6 +++++-
>> arch/powerpc/kernel/head_fsl_booke.S   |   10 ++++++++--
>> arch/powerpc/platforms/Kconfig.cputype |   10 ++++++++--
>> include/asm-powerpc/cache.h            |    3 +++
>> include/asm-powerpc/cputable.h         |    6 ++++--
>> include/asm-powerpc/synch.h            |    2 +-
>> 7 files changed, 44 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/ 
>> cputable.c
>> index e44d553..36fa061 100644
>> --- a/arch/powerpc/kernel/cputable.c
>> +++ b/arch/powerpc/kernel/cputable.c
>> @@ -1522,6 +1522,21 @@ static struct cpu_spec __initdata  
>> cpu_specs[] = {
>> 		.machine_check		= machine_check_e500,
>> 		.platform		= "ppc8548",
>> 	},
>> +	{	/* e500mc */
>> +		.pvr_mask		= 0xffff0000,
>> +		.pvr_value		= 0x80230000,
>> +		.cpu_name		= "e500mc",
>> +		/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
>> +		.cpu_features		= CPU_FTRS_E500MC,
>> +		.cpu_user_features	= COMMON_USER_BOOKE | PPC_FEATURE_HAS_FPU,
>> +		.icache_bsize		= 64,
>> +		.dcache_bsize		= 64,
>> +		.num_pmcs		= 4,
>> +		.oprofile_cpu_type	= "ppc/e500", /* xxx - galak, e500mc? */
>> +		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
>> +		.machine_check		= machine_check_e500,
>> +		.platform		= "ppc4080",
>> +	},
>> 	{	/* default match */
>> 		.pvr_mask		= 0x00000000,
>> 		.pvr_value		= 0x00000000,
>
> Did you intend to leave your 2 "xxx - galak" comments in here?

Yes, the _CAN_DOZE exists on all e500's right now and will go away  
once we resolve the e500 PM patch from Dave Liu.  The perf mon comment  
I plan on keeping around for now.

> Also, I think you have a problem - you allow CONFIG_SMP to be set  
> with CONFIG_FSL_BOOKE now, but if you actually turn on CONFIG_SMP,  
> in pgtable_32.c you're going to have build problems.  CONFIG_SMP  
> enables hash_page_sync(), which we don't have on BookE.  You need to  
> add a !BOOKE to the config protections in pgtable_32.c for  
> hash_page_sync() declaration and callers.

Yeah, I'll drop the CONFIG_SMP bits since the full blown SMP support  
for fsl booke isnt in the tree (at which time we will address the  
issue you raise).

- k
