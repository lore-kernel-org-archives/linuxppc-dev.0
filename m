Message-ID: <XFMail.010326123459.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20010326085607.B61492EFD1@apollo.valhalla.net>
Date: Mon, 26 Mar 2001 12:34:59 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: Sound skips
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Ok, I'll try, but this problem regards interrupt latency,
>> not user-spacelatency.
>
> can you be sure it is IRQ and not scheduling latency?

No, but it's likely to be. The audio buffer is 32 fragments (2KB),
that is 1.48s. I don't think an app can remain blocked so long and it
doesn't explain why libtool blocks the sound since it executes in much
less time than one second.

> If so, can you
> identify what driver or function is holding off IRQs for this length of
> time? [a few hundred ms is a 'monstrous' time to hold IRQs off].

Console scrolling does it IFAIK, but this is not the case.

> Andrew's ll patch addresses scheduling latency - i.e. processes
> blocked from running by other processes executing lengthy jobs in system
> state.  For example, fs work done by the kernel on behalf of user processes.

I'll try it.

>> I was fiddling compiling things and I noticed that one of the
>> worst offenders is libtool, a script in the root the the xmms source tree.
>> Just
>> run it to get a 100ms pause. This night I'll check if rt_sigprocmask() keeps
>> irq disabled.
>
> When I last checked it, disk activity was likely to give up to 300 ms
> blocks.  So, the particular culprit (in terms of applications) might be a
> bit misleading - it possibly depends more on how often the buffer cache
> is hit/missed.

This is not the case: libtool doesn't hit the disk.

> Also, if you are IDE-based, make sure that you've used hdparm to allow
> interrupts on during PIO - this makes a huge difference (especially with
> CDROMs).

Nope. All SCSI.

>>Another thing is console scrolling.
>
> yes, console *is/was* bad. - but I read a message going past on Linux Audio
> Dev between Cort & AM that suggested this particular problem had been
> resolved...
>
>  http://www.uow.edu.au/~andrewm/linux/console.html
>
> I'm not fully up-to-date with the state of the LL patches... I'd be
> interested to hear any results you get.

Ok.

Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
