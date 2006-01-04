Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C76BF68971
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 08:10:06 +1100 (EST)
To: Matthias Transier <matthias.transier@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 04 Jan 2006 17:19:42 +0100."
	<b789c2e60601040819j65eea749p@mail.gmail.com>
Date: Wed, 04 Jan 2006 22:10:03 +0100
Sender: wd@denx.de
Message-Id: <20060104211003.EED51352ADF@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Segmentation fault with X.org and Coral-P drivers 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Matthias,

in message <b789c2e60601040819j65eea749p@mail.gmail.com> you wrote:
> 
> > and EP5200 and Lite5200 are two different boards.
> 
> Ok, my fault. I saw a Lite5200 on a picture somewhere and it looked
> pretty much like my EP board :-). But what I can tell for sure is:
> when I remove the "Embedded Planet" sticker on the board, there is a
> Freescale logo and a print (directly on the board): "IceCube Version
> 103"

Ouch. So far for marketing methods. I didn't know this.

> > Our kernel does not include any support for the EP5200 board.
> 
> I checked it out from CVS, configured it, and it works (besides the X11 thing).

It should work on the  Lite5200  board.  I  just  expected  different
hardware ...

> I did not use the prebuilt binaries, but I was able to compile the

I see.

> driver within my x.org tree. (I had to adapt the Imakefiles by myself,
> the provided ones were too different from the originals.)

If you want to send me your patches: they are welcome.

> The last line is a message that I added. Since the output stops at
> that point, it must be the next call that fails
> (mb86290_driver.c:604):
> 
>         if (!xf86I2CProbeAddress(fPtr->I2C, I2C_SAA7113))
>                 return FALSE;
> 
> May that be a problem with the i2c driver in the kernel which does not
> exactly fit with my board?

This is not the kernel's (MPC5200) I2C driver; actually I2C  is  only
needed for external video decoder chip that _may_ be connected to the
CoralP chip. It is the CoralP itself that acts as an I2C "adapter" in
this  case.  By writing to some CoralP registers, accessible from the
host (CPU) via PCI, the  driver  manipulates  external  pins  of  the
CoralP  chip,  which form the I2C bus. It is an external (relative to
both CoralP and the CPU) device that is controlled  through  I2C;  in
your case the Philips SA71111 video decoder chip.

> The following message also appears in Xorg.0.log, some lines above:
> (II) MB86290(0): I2C bus "MB86290 I2C bus" removed.
> 
> Thanks in advance for any hint that you can give me.

You can disable video capture support, and thus the I2C,  by  setting
option "Video" to "no" in the driver's X11 config file:

	Section "Device"
		 Identifier  "MB86290 card"
		 Driver      "mb86290"
		 Option     "Video" "no"
	EndSection


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Artificial Intelligence is the study of how to  make  real  computers
act like the ones in movies.
