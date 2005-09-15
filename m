Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <200509150158.10511.arnd@arndb.de>
References: <200509150158.10511.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CEA72228-613A-4106-8ACB-97B81D018B03@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 15 Sep 2005 12:44:29 -0500
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

I get the idea now, how about we make CPU_FTR_ALWAYS &  
CPU_FTR_POSSIBLE just #defines and leave it to various sub-archs to  
define CPU_FTR_POSSIBLE if they want to.

I see the classes of for FTR_POSSIBLE: CLASSIC_PPC, 8xx, 4xx, FSL- 
BOOKE, PPC64 (maybe more subclasses here).

The hugh enum while useful, is just really ugly and I can't believe  
it's worth it for the ~60 cases we are using cpu_has_feature() in.

- kumar

On Sep 14, 2005, at 6:58 PM, Arnd Bergmann wrote:

> On Middeweken 14 September 2005 21:11, Kumar Gala wrote:
>
>> I not sure I understand what the introduction of the enum's gets us.
>>
>>
> It doesn't have to be an enum, it could just as well be a #define,
> if we find that to be better in some way (maybe compile-time).
>
> The general idea is to convert run-time checks into compile-time
> checks in order to improve the running kernel. If you have
>
> // start code
> enum {
>     FEATURE_1 = 1,
>     FEATURE_2 = 2,
>     PLATFORM_1 = FEATURE_1,
>     PLATFORM_2 = FEATURE_2,
>     PLATFORM_3 = FEATURE_1 | FEATURE_2,
>     FEATURE_POSSIBLE =
> #ifdef CONFIG_PLATFORM_1
>         PLATFORM_1 |
> #endif
> #ifdef CONFIG_FEATURE_2
>         PLATFORM_2 |
> #endif
> #ifdef CONFIG_FEATURE_3
>         PLATFORM_3 |
> #endif
>         0,
>     FEATURE_ALWAYS =
> #ifdef CONFIG_PLATFORM_1
>         PLATFORM_1 &
> #endif
> #ifdef CONFIG_PLATFORM_2
>         PLATFORM_2 &
> #endif
> #ifdef CONFIG_PLATFORM_3
>         PLATFORM_3 &
> #endif
>         FEATURE_POSSIBLE,
> };
>
> static inline int have_feature(unsigned long feature)
> {
>     return (FEATURE_ALWAYS & feature) ||
>            (FEATURE_POSSIBLE & runtime_feature & feature);
> }
>
> int foo();
> int bar();
> int main(void)
> {
>     if (have_feature(FEATURE_1))
>         return foo();
>     if (have_feature(FEATURE_2))
>         return bar();
>     return 0;
> }
> // end code
>
> Then gcc will produce optimal object code for any combination
> of CONFIG_PLATFORM_{1,2,3}. Of course I have to admit that the
> header file is not exactly elegant ;-).
>
>     Arnd <><
>
