Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v0M5V04mpzDqVJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jan 2017 23:15:09 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: Segher Boessenkool <segher@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
 <20170111225440.GQ28613@gate.crashing.org>
 <1c81ce1a-33ca-7ba4-56f5-976935deb609@c-s.fr>
 <7604032b-c9ae-e3ce-fcd5-d9e555559f52@c-s.fr>
 <1484234447.2492.34.camel@kernel.crashing.org>
 <20170112180713.GU28613@gate.crashing.org>
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <ca5a9d35-3fe6-9fe3-b490-0fb667aa8c9f@c-s.fr>
Date: Fri, 13 Jan 2017 13:15:03 +0100
MIME-Version: 1.0
In-Reply-To: <20170112180713.GU28613@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 12/01/2017 à 19:07, Segher Boessenkool a écrit :
> On Thu, Jan 12, 2017 at 09:20:47AM -0600, Benjamin Herrenschmidt wrote:
>> On Thu, 2017-01-12 at 15:42 +0100, Christophe LEROY wrote:
>>> The 4.6.3 uses __stack_chk_guard, while the 4.4.4 and 4.8.3 use
>>> -28680(r2)
>>>
>>> Is it dependent on the way GCC is built ? Then do we have a way to
>>> know,
>>> when we compile, which method GCC will use ?
>>>
>>> See details below for each of the 3 GCC versions.
>>
>> I think it depends if you built it along with glibc (so it can produce
>> userspace binaries) or not.
>
> Right.  Tony's compilers are built using a (modified version of) buildall,
> and buildall goes out of its way to build without libc whatsoever, even
> if the configuration (powerpc64-linux, for example) expects one.
>
> Which leads to TARGET_LIBC_PROVIDES_SSP being undefined (it would normally
> be true for glibc >= 2.4), and that is all.  Mystery solved.  Thanks!
>

Is there a way to know during compilation how the compiler will behave, 
in order to select the correct method ?

I have drafted a new approach in the kernel that uses -0x7008(r2) 
instead of the global __stack_chk_guard, but how can I select the proper 
approach during kernel compilation in line with the selected GCC ?

Christophe
