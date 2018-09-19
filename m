Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FhsZ2McnzDr5Y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2018 00:22:58 +1000 (AEST)
Subject: Re: [PATCH v2 2/2] powerpc/32: add stack protector support
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <d60ce7dd74704b0ca0a857186f30de4006b63534.1537355312.git.christophe.leroy@c-s.fr>
 <ef8fcc7933d56db6f5f7251cb982ca7131f7408d.1537355312.git.christophe.leroy@c-s.fr>
 <20180919132618.GX23155@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <3f5d1937-393c-1105-30a0-72d568a1c190@c-s.fr>
Date: Wed, 19 Sep 2018 16:22:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180919132618.GX23155@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 19/09/2018 à 15:26, Segher Boessenkool a écrit :
> On Wed, Sep 19, 2018 at 11:14:45AM +0000, Christophe Leroy wrote:
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -112,6 +112,10 @@ KBUILD_LDFLAGS	+= -m elf$(BITS)$(LDEMULATION)
>>   KBUILD_ARFLAGS	+= --target=elf$(BITS)-$(GNUTARGET)
>>   endif
>>   
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard=tls
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-reg=r2
>> +cflags-$(CONFIG_STACKPROTECTOR)	+= -mstack-protector-guard-offset=4
> 
> This last line is only correct if !CONFIG_THREAD_INFO_IN_TASK; is that
> always true?  Add an assert somewhere maybe?

At the time being powerpc doesn't select CONFIG_THREAD_INFO_IN_TASK.

A BUILD_BUG_ON() is added in stackprotector.h

> 
>> +	/*
>> +	 * The stack_canary must be located at the offset given to
>> +	 * -mstack-protector-guard-offset in the Makefile
>> +	 */
>> +	BUILD_BUG_ON(offsetof(struct task_struct, stack_canary) != sizeof(long));
> 
> Well this will help :-)
> 
> It looks like it will be easy to enable on 64 bit as well.

Will it ? It seems that PPC64 doesn't have r2 pointing to current task 
struct, but instead it has r13 pointing to the paca struct. Which means 
we should add a canary in the paca struct, and populate it at task 
switch from current->stack_canary. Or am I missing something ?

> 
>> +	/* Try to get a semi random initial value. */
>> +	get_random_bytes(&canary, sizeof(canary));
>> +	canary ^= mftb();
>> +	canary ^= LINUX_VERSION_CODE;
> 
> These last two lines are useless (or worse, they may give people the idea
> that they are not!)

Well, the last line is in all arches except x86
The mftb() was suggested by Michael to add some entropy.
x86 does the same sort of thing with their rdtsc()

> 
> You should use wait_for_random_bytes I think.

On the 8xx, it takes several minutes before crnd_is_ready(), while 
boot_init_stack_canary() is called quite early in start_kernel()

Christophe
