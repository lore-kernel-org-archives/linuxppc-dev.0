Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <200509160511.39277.arnd@arndb.de>
References: <200509160511.39277.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <17FA692D-4643-4390-AE8A-AEF6F716C5EE@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 16 Sep 2005 16:40:17 -0500
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

Ok, I've given into the enum as I dont see anything better.

However, I do have some questions, why introduce new Kconfig options  
for ppc64.  It seems overkill to have specific build options for each  
"class" of ppc64.  One could make the argument we should go do the  
same thing for classic ppc32.  From an embedded point of view I could  
reduce down to the specific cpu I'm using.  I really dont think we  
want to start doing this.

If we did I would have to say we would have to add Kconfig for 601,  
603, 604, 750 (740, 750, 755), 7400 (7400/7410), 7450 (744x/745x).   
That's six more Kconfig options

I'm ok with the patch, but think we should drop the arch/ppc64/ 
Kconfig portion and its related effects.

Also, I've changed CPU_FTR to CPU_FTRS for the "left hand side" of  
the enum.

- kumar

On Sep 15, 2005, at 10:11 PM, Arnd Bergmann wrote:

> On Freedag 16 September 2005 04:22, Kumar Gala wrote:
>
>
>>> #define CPU_FTR_POSSIBLE CPU_FTR_PSERIES_POSSIBLE |
>>> CPU_FTR_PMAC_POSSIBLE \
>>>          | CPU_FTR_...
>>> #define CPU_FTR_ALWAYS CPU_FTR_POSSIBLE & CPU_FTR_PSERIES_ALWAYS \
>>>         & CPU_FTR_PMAC_ALWAYS & CPU_FTR_ ...
>>>
>>
>> Yes, something like that.  Why do we need the CPU_FTR_ALWAYS.  It
>> seems that CPU_FTR_POSSIBLE is sufficient.  I may just not understand
>> the purpose of CPU_FTR_ALWAYS.
>>
>>
>>> One point to consider is that we traditionally use #ifdef in the
>>> source for many places that could simply use cpu_has_feature(). E.g.
>>> most instances of #ifdef CONFIG_ALTIVEC could be replaced by
>>> cpu_has_feature(CPU_FTR_ALTIVEC) without additional run-time  
>>> overhead.
>>>
>>
>> These should stay as CONFIG options because to reduce the code size
>> of the kernel which is important to embedded people.
>>
>
> The whole point of the logic is to reduce code size, because gcc
> is smart enough to remove all dead code then.
> Consider again the definition of
>
> | static inline int have_feature(unsigned long feature)
> | {
> |      return (FEATURE_ALWAYS & feature) ||
> |             (FEATURE_POSSIBLE & runtime_feature & feature);
> | }
>
> If the feature is part of FEATURE_ALWAYS, this will be optimized to
>
> |      return 1 || FEATURE_POSSIBLE & runtime_feature & feature;
>
> and subsequently
>
> |      return 1;
>
> If it is not part of FEATURE_POSSIBLE, it it equivalent to
>
> |      return 0 || (0 & runtime_feature & feature);
>
> which becomes
>
> |      return 0;
>
>
> Any code inside of
>
> |      if (0) { /* ... */ }
>
> is only checked for syntax by gcc but will not end up in the object  
> code.
> For the 'if(1)' case, the code gets smaller as well, because the  
> runtime
> flag does not have to be dereferenced.
>
> For some places, we might prefer to replace '#ifdef CONFIG_FOO' not  
> with
> have_feature(FOO), but rather with feature_possible(FOO), given a  
> definition
> of
>
> static inline int have_feature(unsigned int feature)
> {
>     return !!(FEATURE_POSSIBLE & feature);
> }
>
> which always get evaluated at compile time.
>
>     Arnd <><
>
