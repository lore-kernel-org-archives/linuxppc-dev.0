Message-Id: <200007261841.TAA22154@hyperion.valhalla.net>
Date: Wed, 26 Jul 2000 19:42:03 +0100
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Jul 26, 2000, Geert Uytterhoeven wrote:
> On Tue, 25 Jul 2000, Benjamin Herrenschmidt wrote:
>> >> I still haven't found the "hard-block" that is effecting the overall audio
>> >> latency performance... ah well, back to the drawing board...
>> >
>> >Do you have IDE? The IDE driver turned out to be the major interrupt messing
>> >problem on m68k, since it can disable interrupts for quite a while.
>>
>> We have some great IRQ blockers in Linux currently. IDE is one,
>> especially in PIO mode where it disables IRQs by default during
>> transferts (AFAIK), but I think also in the fbdevs where, I think, a
>> bunch of lenghtly things like scrolling are done with IRQs disabled.
>
>> I don't know how the fbdev case can be improved, I beleive James has some
>> plans about that for 2.5...
>
> There's indeed a global lock on the console, to prevent multiple accesses to
> the console at once. This solves some problems, one being that some graphics
> hardware crashes when both the CPU and the graphics accelerator touch the
video
> RAM at the same time.
>
> Interrupts in fbdev would be nice for some high-end hardware, which can
> trigger an interrupt when a bunch of graphics processing was done.

but, unless the test code is c**p, that is not what's causing my problem...

on the x86 (over on the linux-audio-dev list) they've come to the conclusion
that the spikes are caused by APM introduced at 2.2.16.

I'm not very aware of whether this is an issue on ppc (I though APM was an
x86-specific feature).

please correct me if I'm wrong..

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
