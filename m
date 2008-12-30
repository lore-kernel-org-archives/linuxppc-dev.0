Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE006.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id B703BDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Dec 2008 06:23:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: RE: virtex uImage and serial ports
Date: Tue, 30 Dec 2008 12:23:07 -0700
In-Reply-To: <1230664433.702423004@192.168.1.201>
References: <20081230181636.49A821BA0065@mail222-wa4.bigfish.com>
	<1230664433.702423004@192.168.1.201>
From: John Linn <John.Linn@xilinx.com>
To: "Joshua Lamorie" <jpl@xiphos.ca>
Message-ID: <20081230192309.05D4C158063@mail121-wa4.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It's been a while, but here's what I remember.

You have to have SERIAL_OF* turned on in the kernel configuration to get
the code to work.

Then the device tree gets parsed by of_serial.c functions for the 16550
uart.

-- John

> -----Original Message-----
> From: Joshua Lamorie [mailto:jpl@xiphos.ca]
> Sent: Tuesday, December 30, 2008 12:14 PM
> To: John Linn
> Cc: linuxppc-embedded@ozlabs.org
> Subject: RE: virtex uImage and serial ports
> =

> Gidday John,
> =

> Thanks for the pointer.  I think I have already gone through every
possible page on the wiki, without
> finding my answer.  There are some great pointers however, such as
> http://xilinx.wikidot.com/debugging-kernel-boot-problems.
> =

> As far as I can tell, if I do 'make uImage', there is no code built
into vmlinux that will parse the
> device tree and set up the serial ports (at least as far as I can see
with objdump -S).  When it
> boots, there is no console output and __log_buf doesn't show any
serial ports detected during the
> initialization of the serial driver.
> =

> Which leads to my question, how does the 8250 serial driver get the
information about the attached
> serial ports from the dtb?  Which part of the code parses the dtb,
finds the "ns16550" and
> updates/builds the platform_device information for the 8250 serial
port driver?
> =

> Joshua
> =

> On Tuesday, 30 December, 2008 13:16, "John Linn"
<John.Linn@xilinx.com> said:
> =

> > Hi Joshua,
> >
> > Have you looked at our wiki site at http://xilinx.wikidot.com as we
> > quite a bit of information there.
> >
> > The ML405 board is a V2Pro chip so it should be pretty close to what
you
> > want using the default kernel config for virtex4.
> >
> > I haven't tested the console at 115,200 as I use it at 9600.
Shouldn't
> > be a problem, but may not hurt to stay at 9600 to get it working.
> >
> > There are pages on the wiki about using u-boot with the kernel also
as
> > it sounds like that's what you're doing.
> >
> > Thanks,
> > John
> >
> >
> >> -----Original Message-----
> >> From: linuxppc-embedded-bounces+john.linn=3Dxilinx.com@ozlabs.org
> > [mailto:linuxppc-embedded-
> >> bounces+john.linn=3Dxilinx.com@ozlabs.org] On Behalf Of Joshua
Lamorie
> >> Sent: Wednesday, December 24, 2008 3:48 PM
> >> To: linuxppc-embedded@ozlabs.org
> >> Subject: virtex uImage and serial ports
> >>
> >> Gidday there,
> >>
> >> I am trying to get 2.6.27(ish) running on my custom Virtex-II Pro
> > platform (I call it Q5).  I already
> >> have many years of running 2.4.26 and booting from u-boot.
> >>
> >> The problem is getting the console running.  I have a device tree
blob
> > built and loaded into memory,
> >> and by peeking at __log_buf I can see that it is reading this okay
> > (i.e. it is correctly finding my
> >> interrupt controller).  However, by the time it goes to mount the
> > ramdisk as root, it complains that
> >> there is no console.
> >>
> >> I'm fairly certain /chosen has stdout pointing to the correct UART,
> > and the console arguments are
> >> ttyS0,115200.
> >>
> >> In looking through the code however, I cannot figure out how the
> > uImage code actually initializes the
> >> serial-ports for the XILINX_VIRTEX_GENERIC_BOARD.  As I understand
it,
> > the only place where
> >> serial_console_init is called, is within platform_init, and this
isn't
> > called for uImage.
> >>
> >> So, three questions.
> >>
> >> 1) How is the serial driver supposed to know where the platforms
> > serial ports are?
> >>
> >> 2) If I wanted to scrap u-boot and just copy kernel/ramdisk/dtb to
> > memory, which kernel make target
> >> should I use?  dtbImage, simpleImage?
> >>
> >> 3) What is the best, most modern image to build that should be used
by
> > u-boot?
> >>
> >> Thanks in advance
> >>
> >> Joshua
> >>
> >> p.s. I've been trying with kernel.org mainline, xilinx git and denx
> > ELDK xenomai (2.6.24).  U-boot is
> >> built from latest git source.  DTS file built from XPS 9.1i with
> > latest service packs, and turned
> >> into DTB with latest dtc source from git.
> >>
> >>
> >> --
> >> Xiphos Technologies
> >> (514) 847-9474 x227
> >> (514) 848-9644 fax
> >>
> >> www.xiphos.com
> >> _______________________________________________
> >> The information transmitted is intended only for the
> >> person or entity to which it is addressed and may contain
> >> confidential and/or privileged material.  If you have
> >> received this in error, please contact the sender and delete
> >> this communication and any copy immediately. Thank you.
> >>
> >>
> >>
> >> _______________________________________________
> >> Linuxppc-embedded mailing list
> >> Linuxppc-embedded@ozlabs.org
> >> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> >
> > This email and any attachments are intended for the sole use of the
named
> > recipient(s) and contain(s) confidential information that may be
proprietary,
> > privileged or copyrighted under applicable law. If you are not the
intended
> > recipient, do not read, copy, or forward this email message or any
attachments.
> > Delete this email message and any attachments immediately.
> >
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> >
> =

> =

> --
> Xiphos Technologies
> (514) 847-9474 x227
> (514) 848-9644 fax
> =

> www.xiphos.com
> _______________________________________________
> The information transmitted is intended only for the
> person or entity to which it is addressed and may contain
> confidential and/or privileged material.  If you have
> received this in error, please contact the sender and delete
> this communication and any copy immediately. Thank you.
> =

> =

> =

> =



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
