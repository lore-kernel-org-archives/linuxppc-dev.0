Date: Wed, 18 Jul 2001 14:34:12 +0100
Subject: Re: 2.4 - buttons, temperature, ictc
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: "Joseph P. Garcia" <jpgarcia@execpc.com>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010718134722.A47432EFC5@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Wed, Jul 18, 2001, Joseph P. Garcia wrote:
> On Wed, 18 Jul 2001 12:11:42 +0100
> "Iain Sandoe" <iain@sandoe.co.uk> wrote:
>> How does the action end up getting routed to the sound driver?
>
> In the current set up, [...]
> code that should/will not make the trip into a public kernel.  but i'd have
> double check to make sure..

well, I understood that from the original patch (and the objection I had was
just as you say)... I don't fancy trying to maintain that cross-linkage in
dmasound.

>> I'd definitely favour a daemon that didn't imply dependence on a particular
> [...]
>> so that coverage would come as part of a standard install?
>
> I'm not familiar with what kind of apis already exist, but your suggestion
> to make something like esound sounds good.

Apart from Bastien's comment in another follow-up..

> Given that these daemons try to
> allow for such things that we can provide in hardware (iirc), like multiple
> opens of /dev/dsp.  So would this be like taking most of the kernel's sound
> interface (like mixer too?) and bringing it into a userspace daemon?

as I understand it, yes... although I tend to concentrate on the raw driver
and haven't done much with esound/arts...

>  You mention ALSA a bit.
> Would this be a better fit than OSS, or are we better making our own?

I doubt (seriously) that another audio API would stand *any* chance of
making it into official linux ... it's still debatable whether ALSA will...

> but then again, I always lean a bit too much toward the
> generic all-purpose APIs created by Mr./Ms. Someone Else whenever userspace
> is involved.

ALSA is *much* cleaner - in principle - all the bloat is taken out of the
kernel drivers into user-land.   However, it's much more complex to set up
at the moment - IMHO probably hasn't really reached 'end user' status yet.

There are starter PPC drivers - based on dmasound.  However, much is still
to be done and ASLA hasn't reached 1.0 yet.  (This is why I'm still working
on adding other Apple chip-sets into dmasound).

> And so with this, how much would stay kernel side?  is this a new api'ed
> kernel driver, or a userspace driver/daemon using a semi-generic ioctl
> interface for ppc sound hardware that also listens to other devices for
> control?  Can this be achieved in a kernel thread?  or would that still be
> considered kernel-bloat?  not to sure on userspace scheduling reliability.

Well pre-ALSA (which is where we are at) ... the role of user-space
abstraction of the OSS devices is handled by aRts et. al.  So I guess taking
a look at how you might feed stuff to that is a start.

Otherwise, you could take the Apple HIG ethic of letting the user select
things... it works quite well (if you don't have a religious problem with
how they do things ;-)))

> (i talk alot when im trying to help)

s'ok - better to get a solution that will be acceptable from the start.
ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
