To: Dan Malek <dan@mvista.com>
Cc: Josh Huber <huber@alum.wpi.edu>,
	Tom Rini <trini@kernel.crashing.org>,
	Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: CPCI-405 port (PPC405GP) 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 20 Sep 2001 11:39:56 EDT."
             <3BAA0DCC.122CE6CB@mvista.com>
Date: Sun, 23 Sep 2001 20:00:17 +0200
Message-Id: <20010923180022.A3D2F100A2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3BAA0DCC.122CE6CB@mvista.com> Dan Malek wrote:
>
> > I'm seriously considering adding this support to ppcboot soon.
>
> Why are you doing this?  Why can't you just use a standard zImage
> format and bootloader like all other systems use?  It just seems

PPCBoot has a litle bit more in mind than just Linux.  It  will  load
and boot other OS as well.

> to me you are coding yourselves deeper into a hole where every
> little kernel interface change means a new boot rom.

Maybe you could spend less time digging  such  holes  and  more  time
tinking about compatibility issues ;-)

> I would suggest just creating a standard interface to calling
> an image and passing information.  Create a function in the

There was such  a  "standard"  interface.  Now  it's  being  changed.
Ummm... what was your argument about "standard interface"? I have yet
to  see  the  Linux kernel interface standard that will NOT change at
some point in time.

> embed_config.c to parse it, and call it a day......

PPCBoot adds some functions that are not available with a "standard"
zImage file like:

- checksum protection
- support for configuration management date (versioning at least)
- separation of kernel and ramdisk images
- support for other operating systems
- support for standalone applications

Also I feel it is silly to provide the same function  in  2  or  more
places;  for  instance, you probably have 3 seriel drivers running on
your  system:  one  in  the  firmware,  another  one  in  the  kernel
bootloader,  and  yet  another  one in the Linux kernel. If you store
several kernel images the number of instances of  the  code  for  the
same  function increses even more. The same is true for decompression
etc. Feel free to waste resources like that on the  systems  you  are
using,  but please allow other people to design for systems with less
resources.

There are 50+ boards using the PPCBoot concept by now, and the number
is growing every week.

You may ignore it, but please let us just do our work.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Heavier than air flying machines are impossible.
                    -- Lord Kelvin, President, Royal Society, c. 1895

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
