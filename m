Date: Mon, 09 Apr 2001 10:34:01 +0100
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010409093406.12C61DB9CF@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Giuliano,
>> Note: this is a completely *different* problem from the PowerComputing
>> "DEAD" dbdma one...
>
> Yes, the subject of the message is different too :))

sorry... (don't send mail when tired Iain.. ;-) [there are two threads one
named "sound stoppage" & one named "sound skips"...]

>> This problem exist for _all_ PPC Linux users - and _did_ exist for all x86
>> users (without) applying Andrew Morton's LL patches.
>
> I didn't noticed the problem on my father's x86, but I'm not
> sure. I'll try ASAP.

well, it is widely reported on Linux Audio Dev (and the motivation behind
much debate about the right method to cure it on lkml)...

>> Perhaps I'll ask Andrew about libtool (it may still give hassles on x86).
> libtool is a bash script.
but it must be calling something that does the damage - maybe whatever it
calls still does damage on x86.  (unless it's bash itself)...

>> If you look at my latest patches they log overruns (reported as xrun in
>> /dev/sndstat output).
>>
>> I get *lots* on all my systems (without LL patches) even when lightly
>> loaded.
>
> sndstat ? I didn't looked at that.

I'd be interested to see the output of /dev/sndstat when you are running
your tests...

>>
>>>> >(if it doesn't involve libtool).
>>>>
>>>> hmmm.  Have you got any idea what libtool does that is different ?
>>>> (does strace work at the moment?)
>>>
>>> The only unusual thing strace shows is thai it calls rt_sigprocmask()
>>> hundred times. rt_sigprocmask() stops irqs for a very short time. A
>>> prog that calls it 1M time shows this is not what I'm looking for.
>>> I searched in all /arch/ppc for something interesting... nothing. I
>>> definitely need a tool to measure how much time the various
>>> spinlock_irq's are hold.
>>
>> Well, I did something for 2.2.x - maybe I'll try and re-do this soon for
>> 2.4.x.
>
> I'll try to write a replacement for spin_*lock_irq*

are you on an SMP machine?

there's a lot more that needs intercepting than that... unfortunately..

>to make use of
> time base facility to measure times.

OK - if you look at www.drfruitcake.com/linux/linuxppc.html there's a link
to the 2.2.x IRQ blocking monitor code...

>The problem is I don't know
> how to store and export the data so all the kernel can see it.

this exports the line & file of each point that does a cli/sti etc. etc.

>I have
> to write a nice /proc interface too. It could take a lot of time...

which is why I haven't re-done it yet... ;-)
(although the version before used access to a kernel memory area - which was
simpler)...

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
