Message-ID: <39CCC5AB.C1C2E8B2@student.ethz.ch>
Date: Sat, 23 Sep 2000 17:00:59 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: R Shapiro <reshapiro@mediaone.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
References: <14796.42915.582391.766766@ipa.ne.mediaone.net>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro schrieb:

> Specifics: with the ati driver selected, xf throws away my mode def,
> since it thinks (incorrectly) that there isn't enough vram,

Does it probe the correct amount of VRAM? Do you use Option "UseFBDev" ?

> and then quits since it can't find any valid modes. In both cases I'm
> running 4.0.1 from Franz Sirl's linuxppc page.

While we're at it, can you please send me the URL of those?

> I also tried 4.0.0 from the Howarth page and got exactly the same results.

I think they're too old to work with Mach based ATI chips.

> I haven't tried compiling xf myself but I'm perfectly willing to do so if
> that's likely to help (eg if there are some known ati patches missing from
> the Sirl rpms).

I thought they contained the necessary stuff from Ani Joshi's rsync tree. If
you try to build yourself, you absolutely need that.


> The rev. a machine is running 2.2.15pre3 from the 2000 cd, booted via
> BootX with "no video driver" checked.

I don't think this can work with the ati driver, it needs atyfb.


> The rev. b machine is running a 2.2.16 kernel compiled from kernel.org
> sources, booted directly from OF.  Both are started with kernel args
> video=atyfb:vmode:20,cmode:16.
>
> I can run xf 4.0.x using the fbdev driver, more or less, with an
> otherwise identical XF86Config, though xf with fbdev is noticably
> slower than Xpmac.rev10.

No big surprise as the fbdev driver doesn't have any hardware acceleration.


> Also the screen is oddly "wrapped" on the rage II machine with the fbdev
> driver: I can see the full screen but the virtual edge starts about 75% in,
> instead of matching the physical edge, and then wraps around.  I don't see
> this artifact on the rage pro G3.

This is a known problem, which is also kind of fixed in Ani's tree AFAIK. I'm
currently working with Geert Uytterheuven to get the definite fix.


> Eventually I want to get multiple monitors going.  I already have what
> I think is a valid config file for it, but I'm guessing I'll never be
> able to do it with fbdev.

That should work if you have multiple framebuffer devices. Use

    Option	"fbdev" "/dev/fb1"

for the second one etc.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
