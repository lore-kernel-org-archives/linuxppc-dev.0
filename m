To: "Dejan Jovanovic" <dejanj@erlangtech.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on SBC8260 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 14 Aug 2002 11:03:06 CDT."
             <00e301c243ac$14182dc0$db00000a@dejanj>
Date: Fri, 16 Aug 2002 21:09:33 +0200
Message-Id: <20020816190938.B2A2410DF4@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <00e301c243ac$14182dc0$db00000a@dejanj> you wrote:
>
> I am trying to run Linux on a EST's SBC8260 board.
>
> First thing I have tried is using ppcboot to load the Linux kernel image.
> - ppcboot version is 1.1.6
> - Linux version is 2.4.4 - the one that comes with ELDK from Wolfgang. (as a
> side question - is it enough if I do the 'make est8260_config' or I need to do
> menuconfig as well after that?)

The general procedure is always the same:

	make est8260_config
	make oldconfig              or make menuconfig
	make dep
	make pImage

"make oldconfig" is good if you don't  want  to  change  the  default
configuration  (which is probably a good idea to get a system running
first), while "make menuconfig" is goot to modify  the  configuration
to  your  specific  needs (you should know what you're doing then, of
course).

> First I have used the Linux kernel image, one in arch/ppc/coffboot and converted
> using mkimage tool (with parameters -a 0x0000_0000 and -e 0x0000_0000)

This is done automatically with "make pImage".

> After that I have executed ppcboot 'bootm' command, and got the message
> 'Loading Kernel Image OK' -- (?? this is strange though - should it not say here
> Uncompressing Kernel Image ?)

This depends. If you use an uncompressed  kernel  image  (build  with
mkimage  option  "-C  none")  you'll  see  " Loading %s ... ", with a
compressed image you'll get " Uncompressing %s ... ".

> After that nothing happens on my serial console.

Probably you made some errors when building the image  -  that's  why
there is the "pImage" make target, to provide a working solution.

> So I tried to use the BDI2000 to debug this.
> I skipped the ppcboot, and loaded the Linux Kernel Image (now the one from
> arch/ppc/mbxboot) into the RAM directly.
> After setting the PC and doing a 'go' I got the message that the 'Target has

You cannot (simply) do this.  The  Linux  kernel  expects  a  lot  of
hardware initialization before it can run, and even then it expects a
couple of arguments passed to it.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
EMACS belongs in <sys/errno.h>: Editor too big!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
