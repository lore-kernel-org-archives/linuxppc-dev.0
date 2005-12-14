Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50F0E68879
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 09:29:31 +1100 (EST)
In-Reply-To: <17312.38814.551675.906916@cargo.ozlabs.ibm.com>
References: <1134569118.3875.9.camel@localhost>
	<17312.38814.551675.906916@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <41642915-3DF7-445D-B6D2-A4CB74601234@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 14 Dec 2005 16:29:37 -0600
To: Paul Mackerras <paulus@samba.org>
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


On Dec 14, 2005, at 4:07 PM, Paul Mackerras wrote:

> Johannes Berg writes:
>
>> So I run across this warning:
>> [ 2724.595549] Debug: sleeping function called from invalid  
>> context at arch/ppc/kernel/traps.c:528
>> [ 2724.595563] in_atomic():0, irqs_disabled():1
>
> Hmmm.  What kernel version is this?  I assume you are using ARCH=ppc,
> is that right?
>
>> But here's the actual question:
>> static inline unsigned long __copy_from_user(void *to,
>>                 const void __user *from, unsigned long size)
>>
>>         might_sleep();
>>         return __copy_from_user_inatomic(to, from, size);
>>
>>
>> Does that mean __copy_from_user_inatomic isn't actually valid to  
>> call in
>> atomic context?
>
> No, it doesn't mean that.  However, if the page isn't in memory,
> __copy_from_user_inatomic won't try to bring it in if it has been
> called from an atomic context (i.e. preempt or interrupts disabled).
>
> The real question is why we have interrupts disabled in the illegal
> instruction handler.  There was a reason why I wanted interrupts
> disabled on entry to program_check_exception which I don't recall
> clearly at the moment, but I think program_check_exception should be
> doing a local_irq_enable() at some point (and it also shouldn't be
> trying to emulate instructions for the kernel).

I'm glad I'm not the only one thinking that interrupts disabled in  
program_check_exception was a little odd.  It looks like  
AltiVecAssist is handling MSR[EE] properly.

The same issue existed in math-emu which is really just another case  
of emulation.

- kumar
