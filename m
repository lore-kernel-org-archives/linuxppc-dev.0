From: Benjamin Herrenschmidt <bh40@calva.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [ANN] IRQ Latency tool 0.1.3 release.
Date: Tue, 25 Jul 2000 23:39:53 +0200
Message-Id: <20000725213953.24969@192.168.1.10>
In-Reply-To: <Pine.LNX.4.10.10007251413580.434-100000@cassiopeia.home>
References: <Pine.LNX.4.10.10007251413580.434-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> I still haven't found the "hard-block" that is effecting the overall audio
>> latency performance... ah well, back to the drawing board...
>
>Do you have IDE? The IDE driver turned out to be the major interrupt messing
>problem on m68k, since it can disable interrupts for quite a while.

We have some great IRQ blockers in Linux currently. IDE is one,
especially in PIO mode where it disables IRQs by default during
transferts (AFAIK), but I think also in the fbdevs where, I think, a
bunch of lenghtly things like scrolling are done with IRQs disabled.

This has caused me troubles in the past since the PMU on new machines is
very sensitive to timeouts. If IRQ get blocked too long while an
asynchronous PMU request is beeing serviced, the PMU will time out and
shut down the machine abruptly. This happened several times in the past
during IDE probe on PowerBooks while some backlight or ADB requests where
beeing handled.

In my latest kernels, I had to add a pmu_safe_poll() function that polls
until the PMU has finished servicing any pending request in order to
avoid crashes in xmon while scrolling the screen for example.

I'm wondering if we could eventually turn ON the IDE unmask interrupt
options on a per-arch or per-machine basis. It's really not necessary
with recent chipsets anyway.

I don't know how the fbdev case can be improved, I beleive James has some
plans about that for 2.5...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
