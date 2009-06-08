Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 11609B70C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 02:45:50 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 85796DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 02:45:49 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MDhyk-00025j-A2
	for linuxppc-dev@ozlabs.org; Mon, 08 Jun 2009 09:45:46 -0700
Message-ID: <23927820.post@talk.nabble.com>
Date: Mon, 8 Jun 2009 09:45:46 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Missing some interrupts
In-Reply-To: <23906859.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23901807.post@talk.nabble.com> <1244328442.31984.45.camel@pasglop>
	<23906859.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



wael showair wrote:
> 
>> > You cannot really rely on getting the exact same number of edge
>> > interrupts that were emitted. At least not unless you have a hard RT
>> > system and can guarantee that you'll always dequeue them fast enough.
>> 
>> Yes, my system is a hard RT & i want to receive all the interrupts that
>> have been generated exactly
> 
> No. Linux is not hard RT. You cannot rely on this in a reliable way,
> if for any reason the kernel masks interrupt for too long, which can
> happen, you'll see that sort of coalescing happening.

what about using the RT-Preempt Patch? i can see that it will convert Linux
ti an RTOS.

> 
> If you -really- can't do anything else, then use critical interrupts
> but there is little if no support at all for them in linux. 
>It's your model that is wrong, you should be able to "poll" the device for
how
> much work (or interrupts) have been sent and react accordingly
> regardless of how many actual IRQ triggers came in via the OpenPIC.
> 
>> so who is responsible for acking the interrupt? 
> 
> At the PIC level, they are acked by the core just before calling into
> your handler.
> 

i have check the function of do_IRQ: there is no ack called b 4 calling the
handler but actually it does the following:
1. it gets the irq number using :
       irq = ppc_md.get_irq();

2. then it calls the handler : 
	if (irq != NO_IRQ && irq != NO_IRQ_IGNORE) {
			generic_handle_irq(irq);
	} else if (irq != NO_IRQ_IGNORE)
		/* That's not SMP safe ... but who cares ? */
		ppc_spurious_interrupts++;

i have checked the function of  generic_handle_irq  where it is defined
linux/irq.h & it calls the handler


so from the previous code the processor or the pic does not ack but they
call my ISR handler.
i have also read the specs of my OpenPIC & found that:

"the interrupt handler executing on the processor should then acknowledge
the interrupt by explicitly reading the IACK register.The PIC unit
interprets this read as an interrupt acknowledge (IACK) cycle; in response,
the PIC unit returns the vector associated with the
interrupt source to the interrupt handler routine."

"At the end of the interrupt  the End Of Interrupt (EOI) register must be
set"

So the processor neither reads this iack register nor the handler set the
EOI register.
how is the interrupts works on my board? i dont know?
my linux version is 2.6.27. 

>> is there any API in the kernel should i call to do this ack? or 
>> it is something Dependant on the device that generates the interrupt?
> 
> The PIC-level ack is done for you. I don't know what your DSP does.
> 
>> Actaully, the device in my case which is a DSP-core is toggles the
>> outpin pin of its GPIO that is connected to the input pin of the
>> OpenPIC, so how can 
>> i ack this device? do u have any suggestions?
> 
> The Ack isn't your problem. Your model is wrong if you design assuming
> you will receive all edge interrupts. Being careful about latencies
> etc... (and making sure you toggle for long enough, btw, didn't think
> about that one, check your MPIC specs) may improve how many of them you
> actually receive, -but- you cannot guarantee that you'll get them all,
> so even if you somewhat manager into most of your tests to get 100%,
> you'll still have an unreliable system.
> 
> You must design your communication between the DSP and Linux such that
> the interrupt is purely a wakeup call indicating there's work to do, and
> some -other- mean for Linux to actually know how much work is to be
> done, the actual number of interrupts is not a proper way to do so.
> 
>> So how can i achieve this step? how can i ack the interrupt b 4 i call
>>  the handler? where can i do this in the kernel?
> 
> The kernel does it for you as I said. It's your communication model
> that is flawed. Never -ever- rely on edge interrupts in ways that
> require them not to be coalesced.
> 
> Cheers,
> Ben.
> 
>> >So you don't need  to worry too much about racing with new incoming
>> messages inside the
>> > interrupt handler itself. But you need to be prepared to pick up more
>> > than one item of work... whatever that is.
>> > 
>> > Cheers,
>> > Ben.
>> > 
>> > _______________________________________________
>> > Linuxppc-dev mailing list
>> > Linuxppc-dev@lists.ozlabs.org
>> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>> > 
>> > 
>> Quoted from: 
>> http://www.nabble.com/Missing-some-interrupts-tp23901807p23906326.html
> 
> 
> 
Quoted from: 
http://www.nabble.com/Missing-some-interrupts-tp23901807p23906859.html


-- 
View this message in context: http://www.nabble.com/Missing-some-interrupts-tp23901807p23927820.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
