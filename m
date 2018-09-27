Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LY793NNqzF35Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 21:51:33 +1000 (AEST)
Subject: Re: [PATCH v4 1/2] powerpc/32: add stack protector support
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <d6c43ab708bf9ae1266c745fece457ed2da43d7c.1537961921.git.christophe.leroy@c-s.fr>
 <20180926191615.GO23155@gate.crashing.org>
 <220fbef8-429c-9485-d10e-c1eaa989918d@c-s.fr>
 <20180927074525.GQ23155@gate.crashing.org>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <28451b6a-e302-691e-ee28-16521997fb07@c-s.fr>
Date: Thu, 27 Sep 2018 13:51:28 +0200
MIME-Version: 1.0
In-Reply-To: <20180927074525.GQ23155@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 27/09/2018 à 09:45, Segher Boessenkool a écrit :
> On Thu, Sep 27, 2018 at 08:20:00AM +0200, Christophe LEROY wrote:
>> Le 26/09/2018 à 21:16, Segher Boessenkool a écrit :
>>> On Wed, Sep 26, 2018 at 11:40:38AM +0000, Christophe Leroy wrote:
>>>> +static __always_inline void boot_init_stack_canary(void)
>>>> +{
>>>> +	unsigned long canary;
>>>> +
>>>> +	/* Try to get a semi random initial value. */
>>>> +	get_random_bytes(&canary, sizeof(canary));
>>>> +	canary ^= mftb();
>>>> +	canary ^= LINUX_VERSION_CODE;
>>>> +
>>>> +	current->stack_canary = canary;
>>>> +}
>>>
>>> I still think you should wait until there is entropy available.  You
>>> haven't answered my questions about that (or I didn't see them): what
>>> does the kernel do in other similar cases?
>>>
>>> Looks great otherwise!
>>
>> What do you mean by 'other similar cases' ? All arches have similar
>> boot_init_stack_canary().
> 
> Yes, those, and other things that want entropy early.

Functions add_latent_entropy() and add_device_randomness() are
there for that it seems, allthough it is not real entropy.

> 
>> x86 uses rdtsc() which is equivalent to our
>> mftb(). Most arches xor it with LINUX_VERSION_CODE.
>>
>> The issue is that it is called very early in start_kernel(), however
>> they try to set some entropy anyway:
>>
>> 	boot_cpu_init();
>> 	page_address_init();
>> 	pr_notice("%s", linux_banner);
>> 	setup_arch(&command_line);
>> 	/*
>> 	 * Set up the the initial canary and entropy after arch
>> 	 * and after adding latent and command line entropy.
>> 	 */
>> 	add_latent_entropy();
>> 	add_device_randomness(command_line, strlen(command_line));
>> 	boot_init_stack_canary();
>>
>> Apparently, it is too early for calling wait_for_random_bytes(), see below.
> 
> Hrm.  Too early to call wait_event_interruptible?  From there it went
> into schedule(), which blew up.  Well you say we have only one context
> at this point, so that is not too surprising then :-)
> 
>> However this is the canary for initial startup only. Only idle() still
>> uses this canary once the system is running. A new canary is set for any
>> new forked task.
> 
> Ah, that makes things a lot better!  Do those new tasks get a canary
> from something with sufficient entropy though?

For the kernel threads that are started early, probably not. For the 
ones started a bit later, and for user processes, I believe they have 
better entropy. Anyway, all this is handled by the kernel core and is 
out of control of individual arches, as its done in kernel/fork.c in 
function dup_task_struct(). However this function is declared as
static __latent_entropy struct task_struct *copy_process(). This 
__latent_entropy attibute must help in a way.

> 
>> Maybe should the idle canary be updated later once there is more entropy
> 
> That is tricky to do, but sure, if you can, that should help.
> 
>> ? Today there is a new call to boot_init_stack_canary() in
>> cpu_startup_entry(), but it is enclosed inside #ifdef CONFIG_X86.
> 
> It needs to know the details of how ssp works on each platform.

Well, that could be for another patch in the future. That's probably 
feasible on x86 and PPC because they both use TLS guard, but not for 
other arches where the guard is global at the moment. So we'll have to 
do it carefully.

I agree with you that we may not for the time being get all the expected 
security against hackers out of it due to that little entropy, but my 
main concern at the time being is to deter developper's bugs clobbering 
the stack, and for that any non trivial canary should make it, shouldn't 
it ?

Christophe
