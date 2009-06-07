Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C9881B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 10:26:47 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 46E6EDDD04
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 10:26:47 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MD6Dk-0006vz-6f
	for linuxppc-dev@ozlabs.org; Sat, 06 Jun 2009 17:26:44 -0700
Message-ID: <23906859.post@talk.nabble.com>
Date: Sat, 6 Jun 2009 17:26:44 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Missing some interrupts
In-Reply-To: <1244328442.31984.45.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23901807.post@talk.nabble.com> <1244328442.31984.45.camel@pasglop>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > You cannot really rely on getting the exact same number of edge
> > interrupts that were emitted. At least not unless you have a hard RT
> > system and can guarantee that you'll always dequeue them fast enough.
> 
> Yes, my system is a hard RT & i want to receive all the interrupts that
> have been generated exactly

No. Linux is not hard RT. You cannot rely on this in a reliable way,
if for any reason the kernel masks interrupt for too long, which can
happen, you'll see that sort of coalescing happening.

If you -really- can't do anything else, then use critical interrupts
but there is little if no support at all for them in linux. It's your
model that is wrong, you should be able to "poll" the device for how
much work (or interrupts) have been sent and react accordingly
regardless of how many actual IRQ triggers came in via the OpenPIC.

> so who is responsible for acking the interrupt? 

At the PIC level, they are acked by the core just before calling into
your handler.

> is there any API in the kernel should i call to do this ack? or 
> it is something Dependant on the device that generates the interrupt?

The PIC-level ack is done for you. I don't know what your DSP does.

> Actaully, the device in my case which is a DSP-core is toggles the
> outpin pin of its GPIO that is connected to the input pin of the
> OpenPIC, so how can 
> i ack this device? do u have any suggestions?

The Ack isn't your problem. Your model is wrong if you design assuming
you will receive all edge interrupts. Being careful about latencies
etc... (and making sure you toggle for long enough, btw, didn't think
about that one, check your MPIC specs) may improve how many of them you
actually receive, -but- you cannot guarantee that you'll get them all,
so even if you somewhat manager into most of your tests to get 100%,
you'll still have an unreliable system.

You must design your communication between the DSP and Linux such that
the interrupt is purely a wakeup call indicating there's work to do, and
some -other- mean for Linux to actually know how much work is to be
done, the actual number of interrupts is not a proper way to do so.

> So how can i achieve this step? how can i ack the interrupt b 4 i call
>  the handler? where can i do this in the kernel?

The kernel does it for you as I said. It's your communication model
that is flawed. Never -ever- rely on edge interrupts in ways that
require them not to be coalesced.

Cheers,
Ben.

> >So you don't need  to worry too much about racing with new incoming
> messages inside the
> > interrupt handler itself. But you need to be prepared to pick up more
> > than one item of work... whatever that is.
> > 
> > Cheers,
> > Ben.
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
> > 
> > 
> Quoted from: 
> http://www.nabble.com/Missing-some-interrupts-tp23901807p23906326.html


-- 
View this message in context: http://www.nabble.com/Missing-some-interrupts-tp23901807p23906859.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
