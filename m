From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Michel=20D=E4nzer?= <michel@daenzer.net>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Weird interrupt problem
Date: Thu, 8 Aug 2002 14:07:00 +0200
Message-Id: <20020808120700.30639@192.168.4.1>
In-Reply-To: <1028761518.1262.1236.camel@tibook>
References: <1028761518.1262.1236.camel@tibook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Today this happened to me the second time: All of a sudden, the USB
>mouse stopped working. At the same time this appeared in the syslog:
>
>Aug  7 17:19:57 tibook kernel: Unhandled interrupt 1d, disabled
>
>Plugging the mouse to the other socket worked, but it wouldn't work
>again in the original one. As you can see in the attached
>/proc/interrupts, interrupt 29 (=1d) is unknown. Interestingly,
>interrupt 28 seems to be for the USB socket which stopped working (I
>think it was the same one when the first problem first occured, might be
>coincidence though). Was it somehow rewarded for its 100'000th
>occurence? ;) Seriously, is it possible that the number changed somehow?
>
>
>This wouldn't be all that bad, if the whole system wasn't very sluggish
>afterwards. When it occured the first time, I had CONFIG_TAU enabled in
>the kernel, which Ben said might cause the sluggishness at least. But
>now it's disabled.
>
>
>This is on a TiBook III/667 running 2.4.18-ben0-lotsanicestuff if it
>matters. The first occurence was with 2.4.19-presomething-ben0.
>
>
>Has anyone experienced anything similar?

Really weird. It looks like the openpic is going south. Seriously, looks
like a HW problem, that is the interrupt controller starts giving us
bogus interrupt numbers. Doesn't sound good at all :(

Ideally, when that happens, you could drop into macsbug and peek at
the vector/priority & destination registers for this interrupt source
and tell me what they say. (Hook into the code for the error message
which is in arch/ppc/kernel/irq.c, and call a function you'll write
in open_pic.c that will dump these (to access them, look at what
openpic_enable/disable IRQ does).

It may be some kind of race within the openpic driver when we keep
enabling/disabling the source in ack() and end(). I'm pretty sure
we don't really need them, oh well...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
