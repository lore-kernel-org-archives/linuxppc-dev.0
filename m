Return-Path: <olof@lixom.net>
Received: from elcamino.pasemi.com (elcamino.pasemi.com [67.155.108.98])
	by ozlabs.org (Postfix) with ESMTP id BE81FDDE00
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jun 2008 00:32:14 +1000 (EST)
Message-Id: <7FE83D5F-6D1C-41F2-8823-868B30A2BDE3@lixom.net>
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <B9E4053C-723F-4BB2-B789-F3F18BA04C4B@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] powerpc/booke: Add support for new e500mc core
Date: Tue, 17 Jun 2008 09:32:09 -0500
References: <Pine.LNX.4.64.0806161045450.20181@blarg.am.freescale.net>
	<55923B54-4F55-4779-B071-CB816BD4FA99@lixom.net>
	<B9E4053C-723F-4BB2-B789-F3F18BA04C4B@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 17, 2008, at 8:56 AM, Kumar Gala wrote:

>
> On Jun 16, 2008, at 2:26 PM, Olof Johansson wrote:
>
>> On Jun 16, 2008, at 10:46 AM, Kumar Gala wrote:
>>> +		.machine_check		= machine_check_e500,
>>> +		.platform		= "ppc4080",
>>
>> Do you really want the platform to be this specific?
>
> I need to look at how this is being used.  I remember having a  
> discussion with Paul about this when introduced platform.

It's used by the AUX vector (AT_PLATFORM), i.e. ld.so can use it to  
load platform-optimized libraries. As such, you probably want it to be  
e500mc instead.

>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/ 
>>> platforms/Kconfig.cputype
>>> index f7efaa9..9e67cf1 100644
>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>> @@ -95,6 +95,12 @@ config E500
>>> 	select FSL_EMB_PERFMON
>>> 	bool
>>>
>>> +config PPC_E500MC
>>> +	bool "e500mc Support"
>>> +	select PPC_FPU
>>> +	depends on E500
>>> +	default n
>>> +
>>> config PPC_FPU
>>> 	bool
>>> 	default y if PPC64
>>> @@ -157,7 +163,7 @@ config ALTIVEC
>>>
>>> config SPE
>>> 	bool "SPE Support"
>>> -	depends on E200 || E500
>>> +	depends on E200 || (E500 && !PPC_E500MC)
>>
>> Why make E500MC a config option, if it's so similar? This way you  
>> can't make a kernel with SPE support that can boot on both  
>> e500{,v2} and e500mc...
>
> I need it for the various things that are compile time, like cache  
> line size, and lwsync support.  If we can get rid of it in the  
> future great.

I got away without doing that on pa6t since we had the same cacheline  
size but ppc64 has a larger value by default so all that hurt by it  
was some padding/alignment being larger than required. I'm sure some  
of the lowend guys won't be happy if you increase the alignment so  
raising the default is out of the picture, I agree with that.

But: since the cacheline is available in cputable, it can still be  
used at runtime, so as long as the alignments are large enough, stuff  
like the dcbz loops should still be OK (might need an audit though to  
make sure there's nothing missed). With that, you could at least still  
boot an E500MC kernel on E500.

> Since I have to have PPC_E500MC I might as well not provide the  
> option to enable SPE since it doesnt exist on e500mc.

With the above, if the line size is used from cputable you should be  
able to boot an e500mc kernel on e500.


-Olof
