Message-ID: <3B56A30B.2070702@hadess.net>
Date: Thu, 19 Jul 2001 10:06:19 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
References: <Pine.LNX.4.10.10107182324190.27335-100000@zirkon.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

>>>Yep. Plus any other power status change events. /proc/pmu has got nothing
>>>to do with it, neither has /proc/apm.
>>>
>>>
>>I mean that we could strip the code of pmu by half, using /proc/pmu
>>instead of poking /dev/pmu directly (which is broken).
>>The OS is supposed to give applications an abstraction layer on top of
>>the hardware. pmud attacking the hardware directly is broken (and the
>>amount of code needed to do this in the kernel is minimum).
>>
>
> This depends - does /proc/pmu allow me to poll for 'new' data, or will it
> always return with the same data immediately? I'd rather use /dev/pmu and
> rely on getting one reply every second.


It's possible to add an event so that /proc/pmu is only polled when
needed. If you rely on pmud to give you new data every second, I think
you're dreaming (or it would need to be async). Using pmud's socket to
get battery status is just very very slow and dodgy.


>>>Nope. Not power related. Not 'PMU'd.
>>>
>>>
>>Let's make "pmud" mean "PowerMac Uber Daemon" then...
>>
>
> Sigh. That's hard to understand, isn't it? Let's do pmud one job
> (monitoring the battery status, plus the remotely related lid switch) and
> do that well. Let's not make it do anything a Powerbook user might want
> due to the special hardware features. How do you translate 'eierlegende
> Wollmilchsau' in English?


Right, I'm pretty sure you can put power management, and some key event
handling in less than a 100k of sources.
I really don't see where the bloat is...


> But this is only my preference. If you want a Powermac bloat daemon, write
> and maintain it. If users want the added features they'll use it.
>
>
>>>>- volume keypress event would be a bad idea to implement inside pmud
>>>>because that's the kind of thing you want visual feedback for, and there
>>>>are a lot of different sound implementations that this could be built on
>>>>top of. (aRts/alsa/oss)
>>>>
>>>>
>>>Nope. See above.
>>>
>>>
>>Huh, are you agreeing with me there ?
>>
>
> For a different reason. I don't give a damn about how you implement volume
> control but I don't want to bother pmud with it. Not its job.


Yep.



>>>Neither. Again, see above. Write a general purpose all powerful event
>>>daemon for this. Don't bloat pmud because of some unspecific desire for
>>>feeping creaturitis. This is Linux (Unix), not MockOS.
>>>
>>>
>>I don't see the problem there... Bloat of pmud ? hmm, maybe a more
>>general-purpose daemon would be interesting, even for x86'ers.
>>
>
> Doing many unrelated things badly is the problem I see. But the general
> purpose event handler might even run on x86. Thanks for supporting my
> side of this argument :-)


Pmud is just *that*, an event handler. Read Joseph's mail.
In the end this code wouldn't be pmud anymore, so we wouldn't have the
problem of you saying that it doesn't fit into the "power management
unit" daemon ;P


>>>Nope, not longer an option (kernel bloat, even worse than app bloat).
>>>
>>>
>>Hahaha, this was a good one. If the kernel doesn't recognize the key
>>(ie. it doesn't generate a keycode), we can't make anything out of it.
>>We *have* to have these keys in the usb and adb keycodes translation tables.
>>
>
> Sure, but handling of these keys goes in user space. So far it's in the
> kernel as well, and if I understand Franz right that's going to change
> (because now there's a nice generic interface, no special ADB hacks). The
> new input code is a chance to implement things in a generic, portable way,
> let's do it right. Otherwise the whole thing wouldn't be worth the hassle
> (and hassle we had plenty, with breaking interfaces in an incompatible
> way in the stable kernel series)


I agree with that.

Cheers

--
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
