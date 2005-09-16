Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <200509160056.32617.arnd@arndb.de>
References: <200509160056.32617.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D6BA4E97-B338-4584-8ECD-440FC70AFED0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 15 Sep 2005 21:22:08 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, pantelis.antoniou@gmail.com,
	linuxppc64-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] powerpc: merge include/asm/cputable.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 15, 2005, at 5:56 PM, Arnd Bergmann wrote:

> On Dunnersdag 15 September 2005 19:44, Kumar Gala wrote:
>
>
>> I get the idea now, how about we make CPU_FTR_ALWAYS &
>> CPU_FTR_POSSIBLE just #defines and leave it to various sub-archs to
>> define CPU_FTR_POSSIBLE if they want to.
>>
>>
>
>
> So you mean like:
>
> #ifdef CONFIG_PPC_PSERIES
> #define CPU_FTR_PSERIES_POSSIBLE (CPU_FTR_FOO | CPU_FTR_BAR)
> #define CPU_FTR_PSERIES_ALWAYS (CPU_FTR_FOO)
> #else
> #define CPU_FTR_PSERIES_POSSIBLE (0)
> #define CPU_FTR_PSERIES_ALWAYS (-1)
> #endif
>
> #ifdef CONFIG_PPC_PMAC
> #define CPU_FTR_PMAC_POSSIBLE (CPU_FTR_BAR | CPU_FTR_BAZ)
> #define CPU_FTR_PMAL_ALWAYS (CPU_FTR_BAZ)
> #else
> #define CPU_FTR_PMAC_POSSIBLE (0)
> #define CPU_FTR_PMAC_ALWAYS (-1)
> #endif
>
> ...
>
> #define CPU_FTR_POSSIBLE CPU_FTR_PSERIES_POSSIBLE |  
> CPU_FTR_PMAC_POSSIBLE \
>          | CPU_FTR_...
> #define CPU_FTR_ALWAYS CPU_FTR_POSSIBLE & CPU_FTR_PSERIES_ALWAYS \
>         & CPU_FTR_PMAC_ALWAYS & CPU_FTR_ ...

Yes, something like that.  Why do we need the CPU_FTR_ALWAYS.  It  
seems that CPU_FTR_POSSIBLE is sufficient.  I may just not understand  
the purpose of CPU_FTR_ALWAYS.

> That would of course avoid having to define the features per CPU type,
> but at the same time make the system more error prone, because every
> time you add a feature to some of the CPUs, you'd have to know exactly
> which platform defines to change as well, and they might get out of  
> sync.

Well if you are adding a new FTR you better know what CPUs it belongs  
to otherwise how would you update the cputable today?  However, I do  
agree it could be error prone.

> I also don't think that using the #defines here makes it any more
> readable than the enums, because you cannot have compile-time  
> conditionals
> inside of #define.
>
>
>> I see the classes of for FTR_POSSIBLE: CLASSIC_PPC, 8xx, 4xx, FSL-
>> BOOKE, PPC64 (maybe more subclasses here).
>>
>> The hugh enum while useful, is just really ugly and I can't believe
>> it's worth it for the ~60 cases we are using cpu_has_feature() in.
>>
>
> One point to consider is that we traditionally use #ifdef in the
> source for many places that could simply use cpu_has_feature(). E.g.
> most instances of #ifdef CONFIG_ALTIVEC could be replaced by
> cpu_has_feature(CPU_FTR_ALTIVEC) without additional run-time overhead.

These should stay as CONFIG options because to reduce the code size  
of the kernel which is important to embedded people.

- kumar
