Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE7D6DDF45
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 09:29:40 +1100 (EST)
Message-Id: <96E82635-F660-4D42-8834-2AF6AD264C28@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Dale Farnsworth <dale@farnsworth.org>
In-Reply-To: <20071214172315.GA26448@xyzzy.farnsworth.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 05/10] powerpc: Add crash kernel support for 85xx
Date: Fri, 18 Jan 2008 16:29:23 -0600
References: <20071122154619.GA26471@xyzzy.farnsworth.org>
	<7AF0D992-6B4E-475C-949B-FAE4DDE03D3A@kernel.crashing.org>
	<20071214172315.GA26448@xyzzy.farnsworth.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2007, at 11:23 AM, Dale Farnsworth wrote:

> On Fri, Dec 14, 2007 at 10:48:58AM -0600, Kumar Gala wrote:
>> On Nov 22, 2007, at 9:46 AM, Dale Farnsworth wrote:
>>
>>> Add the ability to build a ppc_85xx kernel to run at a physical
>>> address of 32MB.
>>>
>>> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
>>> ---
>>> arch/powerpc/Kconfig                 |    2 +-
>>> arch/powerpc/kernel/head_fsl_booke.S |   23 ++++++++++++++++++-----
>>> arch/powerpc/mm/fsl_booke_mmu.c      |    6 +++---
>>> 3 files changed, 22 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>> index 805b4d1..d405298 100644
>>> --- a/arch/powerpc/Kconfig
>>> +++ b/arch/powerpc/Kconfig
>>> @@ -253,7 +253,7 @@ config KEXEC
>>>
>>> config CRASH_DUMP
>>> 	bool "Build a kdump crash kernel (EXPERIMENTAL)"
>>> -	depends on PPC_MULTIPLATFORM && EXPERIMENTAL
>>> +	depends on (PPC_MULTIPLATFORM || PPC_85xx) && EXPERIMENTAL
>>> 	help
>>> 	  Build a kernel suitable for use as a kdump capture kernel.
>>> 	  The kernel will be linked at a different address than normal, and
>>> diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/
>>> kernel/head_fsl_booke.S
>>> index 4b98227..1c9685f 100644
>>> --- a/arch/powerpc/kernel/head_fsl_booke.S
>>> +++ b/arch/powerpc/kernel/head_fsl_booke.S
>>> @@ -41,6 +41,12 @@
>>> #include <asm/asm-offsets.h>
>>> #include "head_booke.h"
>>>
>>> +#ifdef CONFIG_CRASH_DUMP
>>> +#define INITIAL_BOOKE_PAGESZ (BOOKE_PAGESZ_64M)
>>> +#else
>>> +#define INITIAL_BOOKE_PAGESZ (BOOKE_PAGESZ_16M)
>>> +#endif
>>
>> I'm ok with bumping the first page to 64M in all cases.
>
> OK, I'll make that change in the next rev.  Thanks.

I'm about to commit a version of this patch, why did you need to bump  
to 64M?
>
>
> <snip>
>
>> The rest looks good.  Does this mean we can boot a e500 kernel at a
>> non-zero physical address?  (can we run or is the non-zero phy just
>> for a short period of init time).
>
> Yes, with this series of patches, we can boot and run with a classic  
> ppc
> or e500 kernel at 32MB physical (0xc2000000 virtual).  Note that on
> classic, we still need memory at phys 0 for the exception vectors.
> On e500 IIRC, we don't use the vectors at phys 0, but we still write
> the trampoline vectors there.  I just didn't bother making that  
> conditional.

trampoline vectors?

> I'll post an updated series soon, with hopes of getting it into 2.6.25


- k
