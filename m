Date: Wed, 18 Jul 2001 12:11:42 +0100
Subject: Re: 2.4 - buttons, temperature, ictc
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010718111339.6EF762EFBD@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jul 17, 2001, Joseph P. Garcia wrote:
> On Tue, 17 Jul 2001 16:40:24 +0200 (CEST)
> Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de> wrote:
>> Why pmud? For backlight I kind of see how you'd get that notion. But
>> volume?
> ...
>> handle all this. That way, users could even customize the thing to get
>> particular functions mapped to keys :-)
>
> I agree.  At least at the moment, there are measures to have volume
> controls in the new input layer.  Else, why would there be macros in
> input.h for them.  Assuming that this is generally preferred direction, it
> would require a shell- or X-based handler.  I'm sure that if keycodes are
> set up properly, you could have Sawfish or Enlightenment capture the key
> stroke and use it like macos with the volume bar appear at the bottom (if
> you want that sort of thing).  In console, it would be different.  But
> taken as stated, this starts to put bloat wherever it goes.  Having a
> window manager call aumix isn't very linux like, but I'd argue that its the
> kind of result you would get in a nice integrated environment like kde or
> gnome would like to attain.  if the user doesn't realize its part of the
> wm, and the code is clean, it should be tolerable.

How does the action end up getting routed to the sound driver?

We have some limitations owing to the OSS API:

(a) you can't open /dev/dsp more than once *well, you shouldn't be able to -
and I think I've fixed that - at least in Ben's tree*

(b) linking /dev/mixerXX with a particular piece of h/w can be quite tricky
(it might have to be a user selection - which mixer is controlled by the
keys).

(c) the OSS implementation *might* soon be sitting on top of an ALSA driver
talking to a non-onboard sound card (e.g. a pcmcia card) [although this is
not likely in the immediate future on PPC ... it is quite likely soon on x86
laptops]

(d) AFAICT there is no OSS "increment/decrement" volume function/ioctl().
You'd have to read the vol and then re-write it with an increment.  OSS
specifically says "you can't rely on the return value from the write vol.
ioctl()".

----

I'd definitely favour a daemon that didn't imply dependence on a particular
shell/window manager/gui-toolkit  (although I don't really think you are
suggesting that) ... there are endless toolkit debates on linux-audio-dev.

I've been toying with the idea of a PMac-specific GUI mixer for a while -
the PMac hardware doesn't map well onto OSS.

- that is, we have several capabilities (and growing with tumbler etc.) that
cannot be reached from the normal OSS interface.

Perhaps (at least the sound part) it could be integrated with eSound & aRts
so that coverage would come as part of a standard install?

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
