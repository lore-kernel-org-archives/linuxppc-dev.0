Message-ID: <3B55FB76.8080909@hadess.net>
Date: Wed, 18 Jul 2001 22:11:18 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: Iain Sandoe <iain@sandoe.co.uk>,
	"Joseph P. Garcia" <jpgarcia@execpc.com>, benh@kernel.crashing.org,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
References: <Pine.LNX.4.33.0107182204380.2441-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael Schmitz wrote:

>>>>>Why pmud? For backlight I kind of see how you'd get that notion. But
>>>>>volume?
>>>>>
>>
>>Why would pmud make sense for the backlight ? because changing the
>>backlight settings saves power ? ..Right.
>>
>
>Sort of.
>
>>With Ben's latest changes (the /proc/pmu/* for example), pmud should
>>only be a daemon waiting for events, ie:
>>- sleep event: execute a bunch of shell commands (the pwrctl script
>>should really be split into foo.d directories)
>>
>
>Yep. Plus any other power status change events. /proc/pmu has got nothing
>to do with it, neither has /proc/apm.
>
I mean that we could strip the code of pmu by half, using /proc/pmu
instead of poking /dev/pmu directly (which is broken).
The OS is supposed to give applications an abstraction layer on top of
the hardware. pmud attacking the hardware directly is broken (and the
amount of code needed to do this in the kernel is minimum).

>>- backlight keypress event: change the backlight
>>
>
>Nope. Not power related. Not 'PMU'd.
>
Let's make "pmud" mean "PowerMac Uber Daemon" then...

>
>
>>- volume keypress event would be a bad idea to implement inside pmud
>>because that's the kind of thing you want visual feedback for, and there
>>are a lot of different sound implementations that this could be built on
>>top of. (aRts/alsa/oss)
>>
>
>Nope. See above.
>
Huh, are you agreeing with me there ?

>
>
>>- eject keypress event: eject the damn CD !
>>
>
>Neither. Again, see above. Write a general purpose all powerful event
>daemon for this. Don't bloat pmud because of some unspecific desire for
>feeping creaturitis. This is Linux (Unix), not MockOS.
>
I don't see the problem there... Bloat of pmud ? hmm, maybe a more
general-purpose daemon would be interesting, even for x86'ers.

>
>
>>Better yet for handling the volume would be to get all these keys
>>recognized by the Linux kernel (these keys don't produce any recognized
>>
>
>Nope, not longer an option (kernel bloat, even worse than app bloat).
>
Hahaha, this was a good one. If the kernel doesn't recognize the key
(ie. it doesn't generate a keycode), we can't make anything out of it.
We *have* to have these keys in the usb and adb keycodes translation tables.

Cheers

---
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
