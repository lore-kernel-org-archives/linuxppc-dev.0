Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F196668895
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 02:07:47 +1100 (EST)
In-Reply-To: <1134571773.3875.12.camel@localhost>
References: <1134569118.3875.9.camel@localhost>
	<66D10776-B8F2-48E4-9B96-CA37323B5799@kernel.crashing.org>
	<1134571773.3875.12.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D5163F2D-A7C9-47E2-BE8D-E291B6C98A40@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 14 Dec 2005 09:07:56 -0600
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: illegal instructions / irqs disabled warning
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 14, 2005, at 8:49 AM, Johannes Berg wrote:

> On Wed, 2005-12-14 at 08:41 -0600, Kumar Gala wrote:
>
>> Its highly likely, but not guaranteed on all systems.  In truth this
>> is most likely a bug.
>
> Ok.
>
>>> But here's the actual question:
>>> static inline unsigned long __copy_from_user(void *to,
>>>                 const void __user *from, unsigned long size)
>>> {
>>>         might_sleep();
>>>         return __copy_from_user_inatomic(to, from, size);
>>> }
>>>
>>> Does that mean __copy_from_user_inatomic isn't actually valid to
>>> call in
>>> atomic context? Or is this only so that kernel developers that use
>>> powerpc see the bugs their code would have on other platforms? The
>>> magic
>>> in get_user_asm thoroughly confuses me.
>>
>> What do you mean atomic context?  Not exactly sure what your asking
>> about.
>
> Well, the above code loading the instruction that faulted is called  
> from
> the interrupt context where the kernel tries to fix it up. If that
> instruction is not in memory for whatever reason, then it shouldn't  
> try
> to fix it up bug kill the program with SIGILL or SIGSEGV or  
> whatever...
> This is what I came from, and tried looking into how to implement  
> that.
> But then I ran across the code in __copy_from_user which just calls
> __copy_from_user_inatomic so I'm wondering if it is actually  
> possible to
> safely copy data (the instruction) from user space in an interrupt.

It is, we just need to ensure that the user page we are copying from  
is in memory.

But, now that I go back and look at your log message, its odd. I  
didn't expect ProgramExceptions to be executed with the MSR[EE] = 0.  
Now, I'm wondering why that is.

- kumar
