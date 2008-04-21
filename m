Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BDE1DE20E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 06:25:23 +1000 (EST)
Message-Id: <B34B52EF-51C4-4CF6-B72E-BACCEF4EE733@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
In-Reply-To: <20080421201959.GA2281@iram.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] ppc32: Fix errata for 603 CPUs
Date: Mon, 21 Apr 2008 15:25:15 -0500
References: <Pine.LNX.4.64.0804211457010.8003@blarg.am.freescale.net>
	<20080421201959.GA2281@iram.es>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 21, 2008, at 3:19 PM, Gabriel Paubert wrote:
> On Mon, Apr 21, 2008 at 02:57:47PM -0500, Kumar Gala wrote:
>> 603 CPUs have the same issue that some 750 CPUs have in that they  
>> can crash
>> in funny ways if a store from an FPU register instruction is  
>> executed on a
>> register that has never been initialized since power on.  This  
>> patch fixes
>> it by making sure all FP registers have been properly initialized  
>> at kernel
>> boot.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>>
>> Paul, I've put this into my powerpc-next tree since its a pretty  
>> trivial
>> patch.
>>
>> - k
>>
>> arch/powerpc/kernel/cpu_setup_6xx.S |    9 ++++++++-
>> 1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/ 
>> kernel/cpu_setup_6xx.S
>> index f1ee0b3..4a1c3cd 100644
>> --- a/arch/powerpc/kernel/cpu_setup_6xx.S
>> +++ b/arch/powerpc/kernel/cpu_setup_6xx.S
>> @@ -17,7 +17,14 @@
>> #include <asm/cache.h>
>>
>> _GLOBAL(__setup_cpu_603)
>> -	b	setup_common_caches
>> +	mflr	r4
>> +BEGIN_FTR_SECTION
>> +	bl	__init_fpu_registers
>> +END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
>> +	bl	__init_fpu_registers
>
> I don't understand that code.
>
> What does the second bl __init_fpu_regiters do?

that was a copy/paste error.  (see v2 of the patch).

> As I understand it, the first one is conditional on the presence
> of an FPU (reasonable). But the secone one makes no sense.
>
> Finally wouldn't it be simpler to initialize the FPU on all CPU
> that have it?

that would require a change to the entry point of all these  
functions.  Its not worth the savings.

>> +	bl	setup_common_caches
>> +	mtlr	r4
>> +	blr
>
> You can use tail call elimination and save one instruction there :-)

I think we can find better places to save code size. :)

- k
