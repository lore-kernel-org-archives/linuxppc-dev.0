Message-Id: <200007301031.LAA32665@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 11:31:33 +0100
Subject: Re: Stealth port problems
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sun, Jul 30, 2000,   Giuliano Pochini wrote:
> Giuliano Pochini wrote:
>>
>> > >Hi!  I have troubles with my stealth port on a G3-blue. When it runs at
>> > 115200
>> > >ifconfig
>> > >shows a lot of overruns. At 57600 it works fine, but it's slow :-((
>
> The problem is definitely X.  I made a lot of tests: with dma and non-dma
> serial driver, X accelerated, non accelerated, X bare.bone (started with
> xinit). The problem is X. When X is running the serial ports looses packets
> :-((
> Am I the only one who is having this problem ???  Why does X cause overruns ??

If you can try 2.2.17pre10ben2 or pre13ben2 (linuxcare linux-pmac-benh) then
you can apply the IRQ latency test and see if it is that which is blocking
you.  Scan the dev list for "[ANN} IRQ".

It is possible (there was a discussion in the ANN thread about fb IRQ
blocks) - X may aggravate this.

I have seen 2ms of IRQ blocking on the Lombard (using IDE CDROM) and around
450-750 us of IRQ blocking on my other machines (SCSI). [when heavily
loaded].

The RX buffer in an 85230 (which is actually the chip - IIRC - an enhanced
8530) is 8 characters deep - so any more that about 700 us IRQ block will
cause a drop out at 115200 continuous...

So it looks like music might not be the only pressure to tune the IRQ
latencies :-)

Note that an x86 kernel guru said on the lad list "a well tuned kernel
should not exhibit more than about 60 us worst-case IRQ block"

we have a ways to go to get to that.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
