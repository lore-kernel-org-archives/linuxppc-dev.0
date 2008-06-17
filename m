Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2D2EDDDF0F
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 23:56:41 +1000 (EST)
Message-Id: <B9E4053C-723F-4BB2-B789-F3F18BA04C4B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 08:56:33 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 16, 2008, at 2:26 PM, Olof Johansson wrote:

> On Jun 16, 2008, at 10:46 AM, Kumar Gala wrote:
>>
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
>
> Do you really want the platform to be this specific?

I need to look at how this is being used.  I remember having a  
discussion with Paul about this when introduced platform.

>
>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/ 
>> platforms/Kconfig.cputype
>> index f7efaa9..9e67cf1 100644
>> --- a/arch/powerpc/platforms/Kconfig.cputype
>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>> @@ -95,6 +95,12 @@ config E500
>> 	select FSL_EMB_PERFMON
>> 	bool
>>
>> +config PPC_E500MC
>> +	bool "e500mc Support"
>> +	select PPC_FPU
>> +	depends on E500
>> +	default n
>> +
>> config PPC_FPU
>> 	bool
>> 	default y if PPC64
>> @@ -157,7 +163,7 @@ config ALTIVEC
>>
>> config SPE
>> 	bool "SPE Support"
>> -	depends on E200 || E500
>> +	depends on E200 || (E500 && !PPC_E500MC)
>
> Why make E500MC a config option, if it's so similar? This way you  
> can't make a kernel with SPE support that can boot on both e500{,v2}  
> and e500mc...

I need it for the various things that are compile time, like cache  
line size, and lwsync support.  If we can get rid of it in the future  
great.

Since I have to have PPC_E500MC I might as well not provide the option  
to enable SPE since it doesnt exist on e500mc.

>>
>> config SMP
>> -	depends on PPC_STD_MMU
>> +	depends on PPC_STD_MMU || FSL_BOOKE
>
> Isn't there quite a bit more needed than just enabling this config  
> option for SMP to work? I.e. why not save this for when the rest is  
> posted?
>
yes.  I'll drop these bits.

- k
