Date: Mon, 26 Mar 2001 09:56:07 +0100
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010326085607.B61492EFD1@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>>>> there are a variety of things that can block for between 16 & 300 ms (not
>>>> necessarily IRQs).
>>>>
>>>> what size fragments are you using?
>>>
>>> 2K. I have to rise it to 8KB to work fine. My friend with the G4 still have
>>> very few interruptions even with 8KB.
>>
>> OK.... if you can't do with such large fragments....
>>
>>  You might want to try Andrew Morton's Low-Latency patch (URL:
>>  http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads )
>
> Ok, I'll try, but this problem regards interrupt latency,
> not user-spacelatency.

can you be sure it is IRQ and not scheduling latency?  If so, can you
identify what driver or function is holding off IRQs for this length of
time? [a few hundred ms is a 'monstrous' time to hold IRQs off].

Andrew's ll patch addresses scheduling latency - i.e. processes
blocked from running by other processes executing lengthy jobs in system
state.  For example, fs work done by the kernel on behalf of user processes.

That is, it's not about IRQ latency or "User-state" latency ... but
"system-state" latency.

> In the meantime I applied your patch (ints << 10 can't compile
> in _core.c and I had to comment them out).

I'll take a look at this.

>It makes no difference.

OK, that is not too much a surprise given the effects you are seeing.

> I was fiddling compiling things and I noticed that one of the
> worst offenders is libtool, a script in the root the the xmms source tree.
> Just
> run it to get a 100ms pause. This night I'll check if rt_sigprocmask() keeps
> irq disabled.

When I last checked it, disk activity was likely to give up to 300 ms
blocks.  So, the particular culprit (in terms of applications) might be a
bit misleading - it possibly depends more on how often the buffer cache
is hit/missed.

Also, if you are IDE-based, make sure that you've used hdparm to allow
interrupts on during PIO - this makes a huge difference (especially with
CDROMs).

>Another thing is console scrolling.

yes, console *is/was* bad. - but I read a message going past on Linux Audio
Dev between Cort & AM that suggested this particular problem had been
resolved...

 http://www.uow.edu.au/~andrewm/linux/console.html

I'm not fully up-to-date with the state of the LL patches... I'd be
interested to hear any results you get.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
