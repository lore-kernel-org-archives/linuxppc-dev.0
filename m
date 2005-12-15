Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A944068869
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 01:04:49 +1100 (EST)
In-Reply-To: <4590.131.234.232.31.1134639886.squirrel@secure.sipsolutions.net>
References: <1134569118.3875.9.camel@localhost>
	<17312.38814.551675.906916@cargo.ozlabs.ibm.com>
	<4590.131.234.232.31.1134639886.squirrel@secure.sipsolutions.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <44B795CA-E338-4AAC-937D-F2EEA5E27EB9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Thu, 15 Dec 2005 08:04:58 -0600
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


On Dec 15, 2005, at 3:44 AM, Johannes Berg wrote:

> Paul Mackerras wrote:
>>> So I run across this warning:
>>> [ 2724.595549] Debug: sleeping function called from invalid  
>>> context at
>>> arch/ppc/kernel/traps.c:528
>>> [ 2724.595563] in_atomic():0, irqs_disabled():1
>>
>> Hmmm.  What kernel version is this?  I assume you are using ARCH=ppc,
>> is that right?
>
> 2.6.15-rc5, IIRC (might have been rc1, I currently need to use both
> kernels depending on what I want to do), and yes, ARCH=ppc.
>
>> No, it doesn't mean that.  However, if the page isn't in memory,
>> __copy_from_user_inatomic won't try to bring it in if it has been
>> called from an atomic context (i.e. preempt or interrupts disabled).
>
> Good, thanks. So essentially __copy_from_user has the same logic  
> (since it
> just calls __copy_from_user_inatomic) but calls might_sleep() to  
> show the
> developer what he's doing wrong although it won't actually hurt.  
> Right?
>
>> The real question is why we have interrupts disabled in the illegal
>> instruction handler.  There was a reason why I wanted interrupts
>> disabled on entry to program_check_exception which I don't recall
>> clearly at the moment, but I think program_check_exception should be
>> doing a local_irq_enable() at some point (and it also shouldn't be
>> trying to emulate instructions for the kernel).
>
> I don't have the code here right now but I did have a userspace  
> program
> that it tried to emulate (so I'm not sure if it would try to emulate
> kernel instructions). And it wouldn't emulate that instruction, my  
> program
> died with SIGILL, but obviously it still needs to load it to see  
> what kind
> of instruction it was.

Out of interest, is there a reason you dont handle the emulation in  
user space?

- kumar
