Date: Sun, 08 Apr 2001 15:52:41 +0100
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010408145245.304002F00D@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Note: this is a completely *different* problem from the PowerComputing
"DEAD" dbdma one...

This problem exist for _all_ PPC Linux users - and _did_ exist for all x86
users (without) applying Andrew Morton's LL patches.

Perhaps I'll ask Andrew about libtool (it may still give hassles on x86).

If you look at my latest patches they log overruns (reported as xrun in
/dev/sndstat output).

I get *lots* on all my systems (without LL patches) even when lightly
loaded.

>> >(if it doesn't involve libtool).
>>
>> hmmm.  Have you got any idea what libtool does that is different ?
>> (does strace work at the moment?)
>
> The only unusual thing strace shows is thai it calls rt_sigprocmask()
> hundred times. rt_sigprocmask() stops irqs for a very short time. A
> prog that calls it 1M time shows this is not what I'm looking for.
> I searched in all /arch/ppc for something interesting... nothing. I
> definitely need a tool to measure how much time the various
> spinlock_irq's are hold.

Well, I did something for 2.2.x - maybe I'll try and re-do this soon for
2.4.x.

>> mmap-ing files is "bad news" even with the LL patches (IIRC).
>
> strace libtool shows 13 lines like this:
>
> mmap(ptrace: umoven: input/output error
> )                                  = 0x30019000
>
> I don't know what does it mean.

Me neither... (exactly) - but maybe it's the problem  ;-)

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
