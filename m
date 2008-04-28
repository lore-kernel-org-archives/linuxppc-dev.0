Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B19CDDDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Apr 2008 15:50:34 +1000 (EST)
Message-Id: <D84B894B-B6E8-47FD-97CE-CACDE7835B78@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18453.24013.647603.723185@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] Add IRQSTACKS support on ppc32
Date: Mon, 28 Apr 2008 00:50:28 -0500
References: <Pine.LNX.4.64.0804240814280.29846@blarg.am.freescale.net>
	<18453.24013.647603.723185@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 28, 2008, at 12:17 AM, Paul Mackerras wrote:
> Kumar Gala writes:
>
>> * Added allocation and initialization of the irq stacks.  We limit  
>> the
>>  stacks to be in lowmem for ppc32.
>> * Implemented ppc32 versions of call_do_softirq() and  
>> call_handle_irq()
>>  to switch the stack pointers
>> * Reworked how we do stack overflow detection.  We now keep around  
>> the
>>  limit of the stack in the thread_struct and compare against the  
>> limit
>>  to see if we've overflowed.  We can now use this on ppc64 if  
>> desired.
>
> Mostly looks great.  One minor nit is that this ifdef could disappear
> entirely now:

How do you figure?  If we want to maintain it as a config option (for  
at least 2.6.26) we  either need this ifdef or a dummy irq_ctx_init().


>> @@ -352,7 +356,7 @@ void __init init_IRQ(void)
>> {
>> 	if (ppc_md.init_IRQ)
>> 		ppc_md.init_IRQ();
>> -#ifdef CONFIG_PPC64
>> +#ifdef CONFIG_IRQSTACKS
>> 	irq_ctx_init();
>> #endif
>
> Since it looks pretty much exactly like what 64-bit already does, and
> it's under a config option, I withdraw my objection to it going into
> 2.6.26.

:)

- k
