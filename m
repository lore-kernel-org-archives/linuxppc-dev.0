Message-ID: <XFMail.010409095620.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20010408145245.304002F00D@apollo.valhalla.net>
Date: Mon, 09 Apr 2001 09:56:20 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: Sound skips
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Note: this is a completely *different* problem from the PowerComputing
> "DEAD" dbdma one...

Yes, the subject of the message is different too :))

> This problem exist for _all_ PPC Linux users - and _did_ exist for all x86
> users (without) applying Andrew Morton's LL patches.

I didn't noticed the problem on my father's x86, but I'm not
sure. I'll try ASAP.

> Perhaps I'll ask Andrew about libtool (it may still give hassles on x86).

libtool is a bash script.

> If you look at my latest patches they log overruns (reported as xrun in
> /dev/sndstat output).
>
> I get *lots* on all my systems (without LL patches) even when lightly
> loaded.

sndstat ? I didn't looked at that.

>
>>> >(if it doesn't involve libtool).
>>>
>>> hmmm.  Have you got any idea what libtool does that is different ?
>>> (does strace work at the moment?)
>>
>> The only unusual thing strace shows is thai it calls rt_sigprocmask()
>> hundred times. rt_sigprocmask() stops irqs for a very short time. A
>> prog that calls it 1M time shows this is not what I'm looking for.
>> I searched in all /arch/ppc for something interesting... nothing. I
>> definitely need a tool to measure how much time the various
>> spinlock_irq's are hold.
>
> Well, I did something for 2.2.x - maybe I'll try and re-do this soon for
> 2.4.x.

I'll try to write a replacement for spin_*lock_irq* to make use of
time base facility to measure times. The problem is I don't know
how to store and export the data so all the kernel can see it. I have
to write a nice /proc interface too. It could take a lot of time...


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
