Message-Id: <200007150155.CAA18362@hyperion.valhalla.net>
Date: Sat, 15 Jul 2000 02:55:10 +0100
Subject: Hmmm... We have a problem...
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In making sense of the output of some audio latency tests (see my Linux page
for details), it has become apparent that LinuxPPC (currently) has a very
significant problem with IRQ blocking.

A couple of weeks ago I got some code from Jun Sun which profiles IRQ
blocking latency and put it onto linux-pmac-stable (17pre7) and -benh
(17pre10-ben1).

However, at the time I had not read my PPC750 manual (bad boy) and thought
that the VEA timebase clocked at the processor rate  (in my case 300 MHz).
Not so - it clocks at 1/4 of the bus rate (in the case of my machine
somewhere around 18 MHz).

So when I reported "no drama - a few at 600 us" this was rubbish...
In fact, the true situation looks like this:  (the patch keeps track of the
top 8 IRQ blocking times for the duration you run it)...

interrupt latency test for PPC (8 distinctive entries) :
[...]
log entry : 0
        blockingTime     : 166671 (9975.3 us)
        startFilename    : idle.c                         Line : 301
        endFileName      : irq.c                          Line : 267
log entry : 1
        blockingTime     : 166971 (9993.2 us)
        startFilename    : idle.c                         Line : 301
        endFileName      : softirq.c                      Line : 63
log entry : 2
        blockingTime     : 165308 (9893.7 us)
        startFilename    : softirq.c                      Line : 65
        endFileName      : irq.c                          Line : 267
log entry : 3
        blockingTime     : 167140 (10003.3 us)
        startFilename    : softirq.c                      Line : 65
        endFileName      : softirq.c                      Line : 63
log entry : 4
        blockingTime     : 114105 (6829.2 us)
        startFilename    : irq.c                          Line : 273
        endFileName      : irq.c                          Line : 267
log entry : 5
        blockingTime     : 1884383 (112780.5 us)
        startFilename    : bmac.c                         Line : 1231
        endFileName      : bmac.c                         Line : 1252
log entry : 6
        blockingTime     : 6790 (406.4 us)
        startFilename    : ll_rw_blk.c                    Line : 167
        endFileName      : ll_rw_blk.c                    Line : 179
log entry : 7
        blockingTime     : 164597 (9851.1 us)
        startFilename    : irq.c                          Line : 273
        endFileName      : softirq.c                      Line : 63


This is *very* grim for audio work... (and probably not too hot for mouse
tracking & games)...

Let's ignore the bmac.c entry (that only happens during start-up).

My problem is that I cannot narrow down the source of the "IRQ Hog"... I
don't know what uses "softirq.c".

I think it probably occurs around every 20 seconds - but I may modify the JS
code to see if I can quantify this better...

My config:  300 MHz G3, 256 Mb ram, All SCSI-UW (Apple SCSI card).
No, dmasound is *not* loaded..
No USB devices - although USB is complied in.

Sorry for the long mail - but you probably want to see this for
yourselves...

I'll re-do the IRQ lat patch for pre10-benh2 tomorrow (too tired tonight -
I'll make a mistake)...

Iain.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
