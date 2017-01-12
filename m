Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzdJv3m0WzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 18:52:31 +1100 (AEDT)
Subject: Re: bootx_init.c:88: undefined reference to `__stack_chk_fail_local'
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <alpine.DEB.2.20.99.1701030715390.31470@trent.utfs.org>
 <81ef821b-8af2-0ee5-ab35-58639548dab7@c-s.fr>
 <alpine.DEB.2.20.99.1701040957380.31470@trent.utfs.org>
 <alpine.DEB.2.20.999.1701091739320.5450@trent.utfs.org>
 <d0e56084-49d7-2486-c2a6-de146331d1c7@c-s.fr>
 <20170111225440.GQ28613@gate.crashing.org>
Cc: Christian Kujau <lists@nerdbynature.de>,
 Benjamin Herrenschmidt <benh@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <1c81ce1a-33ca-7ba4-56f5-976935deb609@c-s.fr>
Date: Thu, 12 Jan 2017 08:52:25 +0100
MIME-Version: 1.0
In-Reply-To: <20170111225440.GQ28613@gate.crashing.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/01/2017 à 23:54, Segher Boessenkool a écrit :
> On Tue, Jan 10, 2017 at 07:26:15AM +0100, Christophe LEROY wrote:
>>> Maybe ppc32 is not supposed to be built with CC_STACKPROTECTOR ?
>>
>> Indeed, the latest versions of GCC don't use anymore the global variable
>> __stack_chk_guard as canary value, but a value stored at -0x7008(r2).
>> This is not compatible with the current implementation of  the kernel
>> with uses r2 as a pointeur to current task struct.
>> So until we fix it, I don't think CC_STACKPROTECTOR is usable on PPC
>> with modern versions of GCC.
>
> I still wonder what changed.  Nothing relevant has changed for ten years
> or whatever as far as I see; unless it is just the -fstack-protector-strong
> that makes it fail now.  Curious.
>

Yes, looks like it was changed from global to TLS in 2005 on powerpc. 
Indeed when I implemented STACKPROTECTOR in Kernel on ppc I 
copied/pasted it from ARM which is (still?) using the global 
__stack_chk_guard, and at first it worked quite well on my powerpc.

x86 has the following option on GCC. Couldn't we have it on powerpc too ?

-mstack-protector-guard=guard
Generate  stack  protection  code  using  canary  at
guard.   Supported  locations are ‘ global ’ for global canary or ‘ tls
’ for per-thread canary in the TLS block (the  default). This  option 
has  effect  only  when  ‘-fstack-protector’  or ‘-fstack-protector-all’ 
is specified.

Christophe
