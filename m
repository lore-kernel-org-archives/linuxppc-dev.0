Message-Id: <200007252153.WAA27683@hyperion.valhalla.net>
Date: Tue, 25 Jul 2000 22:53:52 +0100
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>> I still haven't found the "hard-block" that is effecting the overall audio
>>> latency performance... ah well, back to the drawing board...
>>
>>Do you have IDE? The IDE driver turned out to be the major interrupt messing
>>problem on m68k, since it can disable interrupts for quite a while.
>
> We have some great IRQ blockers in Linux currently. IDE is one,
> especially in PIO mode where it disables IRQs by default during

[...]

Does this mean that there are already other tools to measure the IRQ
blocking?

To go back to the original problem:

running a sched_fifo based audio latency test (Benno Senoner's x86 version
with PPC patches) I was seeing 8-10ms 'inexplicable' scheduling spikes.

Someone postulated that this could be caused by IRQ blocking.

Hence the tool.  However, on my set-up, using the same latency test the
spikes show - but there are no IRQ blocks of that length showing in the
measurement.

I therefore have to conclude that:

(a) The tool is missing something - please peruse and suggest if you have
time... I think that most stuff is covered (and I did cover the DataAccess &
InstructionAccess exceptions - although that is currently not enabled in the
patch I've posted).

(b) The effect is caused by some other phenomenon (which is my current
guess).

So, I'm going to have another look at the latency test to see what I can do
to narrow down the source of the problem (including checking what the test
does :-)

Iain,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
