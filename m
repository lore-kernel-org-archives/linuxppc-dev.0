From: "Georg Klug" <gklug@giga-stream.de>
To: "Muaddi, Cecilia" <cecilia.muaddi@alloptic.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: AW: access memory mapped registers 
Date: Fri, 10 Jan 2003 09:19:26 +0100
Message-ID: <FFECLICFNBJAHONLGAKMKEKGCHAA.gklug@giga-stream.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <885489B3B89FB6449F93E525DF78777F064541@srvnt506.ALLOPTIC.COM>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Cecilia,

> Given that, do you know what is the convention if I need to address the GPIO
> pins in
> the 860?   I have some FPGA which require me to download the FPGA code
> and they are controlled via JTAG from my GPIO pins out of 860.  I can use
> mmap to map the ppc 860 internal memory (the quick dirty way just to see if
> works), or is there a driver already provided which will allow me to control
> the GPIO pins from user application?

we had a similar problem with our custom 405 board and we solved it this way:

- making a device driver which does the basic stuff like accessing the GPIOs
  in the proper way.
- defining an ioctl interface that allows any application to download the
  FPGA code.
- creating an user space application which takes a filename as a parameter and
  sends it via the ioctls to the device driver. (we called it loadfpga)

The ioctl interface is pretty simple. It only needs just one action code
(FpgaProg) with a block of at most 4k bytes as data and an additional option
field showing the driver whether this block of data is the first one and/or the
last one.

The driver now does just some simple actions like this:
 - if this is the first block do the proper initilization of the downloading
   (in our case we needed to initialize the GPIOs, puls the PROG and check the
    INIT signal)
 - for all blocks do the signaling via the GPIO bitwise (in our case set DIN
    for all bits and puls the CLK signal)
 - if this was the last block do the concluding actions (in our case do some
    CLK pulses and wait for the DONE signal and then take the chip out of reset)

The user space application is even simplier:
 - Read the binary file in 4k blocks
 - Issue an ioctl and set the bits signaling whether this block is the first
    and/or the last properly.

This concept may also work for your case.

Kind regards,
Georg


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
