Message-ID: <3B5586AB.7000604@hadess.net>
Date: Wed, 18 Jul 2001 13:52:59 +0100
From: Bastien Nocera <hadess@hadess.net>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.4 - buttons, temperature, ictc
References: <20010718111339.6EF762EFBD@apollo.valhalla.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Iain Sandoe wrote:

> On Tue, Jul 17, 2001, Joseph P. Garcia wrote:
>
>>On Tue, 17 Jul 2001 16:40:24 +0200 (CEST)
>>Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:
>>
>>>Why pmud? For backlight I kind of see how you'd get that notion. But
>>>volume?
>>>


Why would pmud make sense for the backlight ? because changing the
backlight settings saves power ? ..Right.

With Ben's latest changes (the /proc/pmu/* for example), pmud should
only be a daemon waiting for events, ie:
- sleep event: execute a bunch of shell commands (the pwrctl script
should really be split into foo.d directories)
- backlight keypress event: change the backlight
- volume keypress event would be a bad idea to implement inside pmud
because that's the kind of thing you want visual feedback for, and there
are a lot of different sound implementations that this could be built on
top of. (aRts/alsa/oss)
- eject keypress event: eject the damn CD !

>>...
>>
>>>handle all this. That way, users could even customize the thing to get
>>>particular functions mapped to keys :-)
>>>
>>I agree.  At least at the moment, there are measures to have volume
>>controls in the new input layer.  Else, why would there be macros in
>>input.h for them.  Assuming that this is generally preferred direction, it
>>would require a shell- or X-based handler.  I'm sure that if keycodes are
>>set up properly, you could have Sawfish or Enlightenment capture the key
>>stroke and use it like macos with the volume bar appear at the bottom (if
>>you want that sort of thing).  In console, it would be different.  But
>>taken as stated, this starts to put bloat wherever it goes.  Having a
>>window manager call aumix isn't very linux like, but I'd argue that its the
>>kind of result you would get in a nice integrated environment like kde or
>>gnome would like to attain.  if the user doesn't realize its part of the
>>wm, and the code is clean, it should be tolerable.
>>


Better yet for handling the volume would be to get all these keys
recognized by the Linux kernel (these keys don't produce any recognized
keycode on my iMac's Apple Pro kbd), and then by XFree86 so that anybody
can start adding shortcuts for their preferred window manager/desktop
for these keys (that do also exist on x86, btw)


> How does the action end up getting routed to the sound driver?
>
> We have some limitations owing to the OSS API:
>
> (a) you can't open /dev/dsp more than once *well, you shouldn't be able to -
> and I think I've fixed that - at least in Ben's tree*
>
> (b) linking /dev/mixerXX with a particular piece of h/w can be quite tricky
> (it might have to be a user selection - which mixer is controlled by the
> keys).
>
> (c) the OSS implementation *might* soon be sitting on top of an ALSA driver
> talking to a non-onboard sound card (e.g. a pcmcia card) [although this is
> not likely in the immediate future on PPC ... it is quite likely soon on x86
> laptops]


A pcmcia sound card ?! didn't know that existed. Maybe USB speakers
would be a better example (like on the Cube).


> (d) AFAICT there is no OSS "increment/decrement" volume function/ioctl().
> You'd have to read the vol and then re-write it with an increment.  OSS
> specifically says "you can't rely on the return value from the write vol.
> ioctl()".
>
> ----
>
> I'd definitely favour a daemon that didn't imply dependence on a particular
> shell/window manager/gui-toolkit  (although I don't really think you are
> suggesting that) ... there are endless toolkit debates on linux-audio-dev.
>
> I've been toying with the idea of a PMac-specific GUI mixer for a while -
> the PMac hardware doesn't map well onto OSS.
>
> - that is, we have several capabilities (and growing with tumbler etc.) that
> cannot be reached from the normal OSS interface.


Can you explain ? OSS is indeed not very good for our mixers, maybe your
ideas could be integrated into ALSA before it reaches 1.0 or gets
included in the kernel.


> Perhaps (at least the sound part) it could be integrated with eSound & aRts
> so that coverage would come as part of a standard install?


esound is _dead_. On PPC, it's a piece of junk, and Gnome 2.0 will use
aRts through a C interface.

Cheers

--
/Bastien Nocera
http://hadess.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
