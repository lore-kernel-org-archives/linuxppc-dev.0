Date: Sat, 23 Sep 2000 10:37:43 -0700 (PDT)
From: William Blew <wblew@home.com>
To: R Shapiro <reshapiro@mediaone.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.0/1 with rage II/rage pro -- should the ati driver work?
In-Reply-To: <14796.42915.582391.766766@ipa.ne.mediaone.net>
Message-ID: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 23 Sep 2000, R Shapiro wrote:

> Subject says it all, really.  I can't get the xf 4.0.x driver to work
> either on a rev. a beige G3 with rage II or a rev. b beige G3 with
> rage pro.  Should it be working, or am I wasting my time trying?  Fwiw
> the r128 driver works great on my G4....

As if a couple of weeks ago I looked at the mach64 drivers that are being
developed. While I think the progress has been good, I would not describe
their mach64 support under linuxPPC as being ready for use. They still
need quite a bit of work, particularly with the 3D rage pro (mach64's GT
family) support.

> Specifics: with the ati driver selected, xf throws away my mode def,
> since it thinks (incorrectly) that there isn't enough vram, and then
> quits since it can't find any valid modes. In both cases I'm running
> 4.0.1 from Franz Sirl's linuxppc page.  I also tried 4.0.0 from the
> Howarth page and got exactly the same results.  I haven't tried
> compiling xf myself but I'm perfectly willing to do so if that's
> likely to help (eg if there are some known ati patches missing from
> the Sirl rpms).

This is because the ati driver (linuxPPC via the framebuffer device) is
not yet correctly probing all of the mach64 chipset's families. This
includes the size of the card's frame buffer ram and its ram type, at
least (it detects my 6MB of SGRAM as EDO).

Further, last I checked, when inadequate ram (incorrect for 3D rage pro)
eliminates a video mode, that mode is still getting sent to the kernel,
even with its incorrect clock rate, etal. This causes a kernel reject of
the mode setting IOCTL.

> If you have any suggestions at all, please cc: me directly -- I'll see
> it more quickly that way.

I am using 3.3.6 still (due to the above issues). However, if you are
interested in development work, there is some porting of the frame buffer
driver related interface that can be done from the FB driver to the ATI
(under LinuxPPC) driver that would help in resolving these issues.
--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
