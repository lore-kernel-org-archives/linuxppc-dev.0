Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tyMVM35sxzDqGl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jan 2017 17:26:19 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: Christian Kujau <lists@nerdbynature.de>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
Cc: Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
Date: Tue, 10 Jan 2017 07:26:15 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/01/2017 à 03:11, Christian Kujau a écrit :
> On Wed, 4 Jan 2017, Christian Kujau wrote:
>> So, would the following be sufficient? It compiles, but I haven't had a
>> chance to boot yet.
>>
>
> So, with -fno-stack-protector my GCC 4.9.2 compiles with
> CC_STACKPROTECTOR_STRONG=y but panics during boot:
>
>
>
> Maybe ppc32 is not supposed to be built with CC_STACKPROTECTOR ?

Indeed, the latest versions of GCC don't use anymore the global variable 
__stack_chk_guard as canary value, but a value stored at -0x7008(r2). 
This is not compatible with the current implementation of  the kernel 
with uses r2 as a pointeur to current task struct.
So until we fix it, I don't think CC_STACKPROTECTOR is usable on PPC 
with modern versions of GCC.

Christophe

>
> Thanks,
> Christian.
>
>>
>> diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
>> index 1eb7b45..c7dcab9 100644
>> --- a/arch/powerpc/platforms/powermac/Makefile
>> +++ b/arch/powerpc/platforms/powermac/Makefile
>> @@ -1,4 +1,4 @@
>> -CFLAGS_bootx_init.o  		+= -fPIC
>> +CFLAGS_bootx_init.o  		+= -fPIC -fno-stack-protector
>>
>>  ifdef CONFIG_FUNCTION_TRACER
>>  # Do not trace early boot code
>>
>>
>> Thanks,
>> Christian.
>> --
>> BOFH excuse #156:
>>
>> Zombie processes haunting the computer
>>
>
