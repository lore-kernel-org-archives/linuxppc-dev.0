Date: Wed, 15 Jan 2003 22:38:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mark Powell <medp@primag.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Assistance with using /dev/fb0 and No X windows
Message-ID: <20030115113838.GB23564@zax>
References: <4926614F7A31D411820F00D0B74FF7E0013D1A21@RDC03> <XFMail.20030115103256.medp@primag.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.20030115103256.medp@primag.co.uk>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jan 15, 2003 at 10:32:56AM -0000, Mark Powell wrote:
>
> On 14-Jan-2003 Gallant, John wrote:
> >
> >  I want to thank Claus and Chirag for their responses.  I believe that my
> >  access problems are more lower level than I originally thought.
> >
> >  In our searching's we were only able to find an XFree86 driver for the
> >  Silicon Motion LynxEM chip and one that was in the PPCBoot tree.
>
> John,
> I don't know about the LynxEM, but we have some experience of the Lynx3DM chip.
> There is a driver for this chip in the XFree86 tree too. However, we found that
> it relied on the chip having been initialised by the video BIOS.
> The manual is incomplete and lacks any information on initialisation; we have
> spent months working out what the BIOS does at initialisation and enhancing the
> XFree86 driver to initialise enough registers.

Indeed..  however I did find that the folks from Silicon Motion seemed
to be reasonably willing to help with finding the necessary frobbing
to do.

> >  So all this rambling leads me to these questions to the distribution list:
> >
> >  1) Does the "generic" VGA stuff expect that the VGA device is already
> >  initialized and setup by the BIOS/LILO/BOOT code?
>
> The 3DM requires some basic initialisation before you can even do VGA
> initialisation. The EM may be similar. My understanding is that the linux VGA
> driver expects the VGA to be in a basic test mode (mode 3?).
>
> >  2) Does anyone know of a driver for the LynxEM chip that is not from the
> >  XFree86 code base?
>
> we looked at the lynxfb.c but it didn't do enough to make the 3DM work for us.
> There was a comment on this list a while ago from the author, saying that it
> only did the extra init he needed for XFree to work.

Indeed.  The crucial part is the (undocumented) procedure for
initializing the memory, without you couldn't access the frame buffer
at all.  I have no idea if that will have any bearing on the LynxEM
chip, though.

I'm a bit surprised that lynxfb.c plus XFree wasn't enough to work for
you (well, after modifying the Icebox specific parts), but it was
pretty flaky, so I'm not all that surprised.  From memory, it
shouldn't be a really big job to make lynxfb.c a bit more solid, and
even make it work as a proper kernel framebuffer driver, but it worked
enough for my purposes so I never got around to it (plus that would
have meant figuring out the baroque intricacies of the fbdev
interface).

> Not much practical help I'm afraid, but hopefully useful info to see where you
> stand.
>
> I expect to add a driver for Lynx3DM to PPCBoot for our card, but not for
> another month.
>
> Mark
>
>

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
