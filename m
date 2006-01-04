Return-Path: <matthias.transier@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.201])
	by ozlabs.org (Postfix) with ESMTP id 328756895A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 03:19:44 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id i24so1616193wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Jan 2006 08:19:43 -0800 (PST)
Message-ID: <b789c2e60601040819j65eea749p@mail.gmail.com>
Date: Wed, 4 Jan 2006 17:19:42 +0100
From: Matthias Transier <matthias.transier@gmail.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20060104154812.24858352B1E@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <b789c2e60601040333o42d64c52n@mail.gmail.com>
	<20060104154812.24858352B1E@atlas.denx.de>
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

Hi Wolfgang,

thanks for the quick response.

2006/1/4, Wolfgang Denk <wd@denx.de>:
> > I have been trying to get X.org running on a board called "Embedded
> > Planet EP5200C" (it seems to be a "Freescale Lite5200") and a Fujitsu
>
> Umm... no. Embedded Plaet and Freescale are two different  companies,
> and EP5200 and Lite5200 are two different boards.

Ok, my fault. I saw a Lite5200 on a picture somewhere and it looked
pretty much like my EP board :-). But what I can tell for sure is:
when I remove the "Embedded Planet" sticker on the board, there is a
Freescale logo and a print (directly on the board): "IceCube Version
103"

> > Coral-P (Rev 5.0). I am using the 2.4 kernel from denx.de and
>
> Our kernel does not include any support for the EP5200 board.

I checked it out from CVS, configured it, and it works (besides the X11 thi=
ng).

> > succesfully installed gentoo-ppc on nfs. The framebuffer works, I get
> > a login prompt on the monitor.
> >
> > Now I compiled x.org-6.8.2 (gentoo -r4) and the mb86290 driver from
> > denx.de. Unfortunately, it does not work and I get a segmentation
> > fault when trying to startx. strace produces the output attached
> > below.
>
> Please read the documentation that comes with the driver:
> ftp://ftp.denx.de/pub/fujitsu/Coral-P/README.html

That is what I already read in order to compile the driver.

> Note that the driver was  built  and  tested  against  xfree86-4.3.0;
> don't  expect  the  binary  to  work  in  a  completely different X11
> release. You wil have to rebuild (and eventually  adapt)  the  driver
> for your environment.

I did not use the prebuilt binaries, but I was able to compile the
driver within my x.org tree. (I had to adapt the Imakefiles by myself,
the provided ones were too different from the originals.)

In the meantime, I can provide you with further debugging information:
from Xorg.0.log:
=3D=3D=3D=3D=3D=3D
(II) MB86290(0): Using XFree86 Acceleration Architecture (XAA)
        Screen to screen bit blits
        Solid filled rectangles
        8x8 mono pattern filled rectangles
        Indirect CPU to Screen color expansion
        Solid Lines
        Dashed Lines
(II) MB86290(0): Acceleration enabled
fbdevHW: LoadPalette 0
(II) MB86290(0): fbdevHWLoadPalette succeeded
=3D=3D=3D=3D=3D=3D

The last line is a message that I added. Since the output stops at
that point, it must be the next call that fails
(mb86290_driver.c:604):

        if (!xf86I2CProbeAddress(fPtr->I2C, I2C_SAA7113))
                return FALSE;

May that be a problem with the i2c driver in the kernel which does not
exactly fit with my board?
The following message also appears in Xorg.0.log, some lines above:
(II) MB86290(0): I2C bus "MB86290 I2C bus" removed.

Thanks in advance for any hint that you can give me.

Best regards,
Matthias
