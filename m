Message-ID: <XFMail.20030115103256.medp@primag.co.uk>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <4926614F7A31D411820F00D0B74FF7E0013D1A21@RDC03>
Date: Wed, 15 Jan 2003 10:32:56 -0000 (GMT)
From: Mark Powell <medp@primag.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Assistance with using /dev/fb0 and No X windows
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 14-Jan-2003 Gallant, John wrote:
>
>  I want to thank Claus and Chirag for their responses.  I believe that my
>  access problems are more lower level than I originally thought.
>
>  In our searching's we were only able to find an XFree86 driver for the
>  Silicon Motion LynxEM chip and one that was in the PPCBoot tree.

John,
I don't know about the LynxEM, but we have some experience of the Lynx3DM chip.
There is a driver for this chip in the XFree86 tree too. However, we found that
it relied on the chip having been initialised by the video BIOS.
The manual is incomplete and lacks any information on initialisation; we have
spent months working out what the BIOS does at initialisation and enhancing the
XFree86 driver to initialise enough registers.

>  So all this rambling leads me to these questions to the distribution list:
>
>  1) Does the "generic" VGA stuff expect that the VGA device is already
>  initialized and setup by the BIOS/LILO/BOOT code?

The 3DM requires some basic initialisation before you can even do VGA
initialisation. The EM may be similar. My understanding is that the linux VGA
driver expects the VGA to be in a basic test mode (mode 3?).

>  2) Does anyone know of a driver for the LynxEM chip that is not from the
>  XFree86 code base?

we looked at the lynxfb.c but it didn't do enough to make the 3DM work for us.
There was a comment on this list a while ago from the author, saying that it
only did the extra init he needed for XFree to work.

Not much practical help I'm afraid, but hopefully useful info to see where you
stand.

I expect to add a driver for Lynx3DM to PPCBoot for our card, but not for
another month.

Mark


--
Mark Powell, Senior Software Engineer, Primagraphics Limited
New Cambridge House, Litlington, nr.Royston, Herts, SG8 0SS, UK
Tel. +44 1763 852222, Fax. 853324, medp@primagraphics.co.uk,
http://www.primagraphics.co.uk


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
