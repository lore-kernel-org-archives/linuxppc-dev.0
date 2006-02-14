Return-Path: <egoforth@gmail.com>
Received: from rwcrmhc11.comcast.net (rwcrmhc11.comcast.net [216.148.227.151])
	by ozlabs.org (Postfix) with ESMTP id F1B9A67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Feb 2006 16:30:44 +1100 (EST)
Message-ID: <43F168A3.4020808@gmail.com>
Date: Tue, 14 Feb 2006 00:20:35 -0500
From: Ed Goforth <egoforth@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: 440gx GPIO
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am struggling with a problem and I hope someone can give me some
pointers.  We have a custom board with a 440gx.  I need to drive GPIO11
low.  The best as I can tell from the docs, I need to set bit 11 of the
TCR to 1 and bit 11 of the OR to 0 to do this.  I'm using kernel
2.4.18-timesys-4.0

Here's what I've tried:

Prior to making an calls, the values of the registers are:
or      0x00101000
tcr     0x00101700
odr     0x00000000
ir      0xeffff820


(from ibm440gx.h)
#define PPC440GX_GPIO0_ADDR  0x0000000140000700


Attempt one: write the bit directly:

  volatile gpio_t *gpio;
  volatile u32 or_reg;

  gpio = (gpio_t *) ioremap_nocache(0x40000700,
                                    sizeof(gpio_t));

  or_reg = gpio->or;
  or_reg &= 0x00100000;
  gpio->or = or_reg;


Attempt two: use the accessor routine:
  extern int ibm_gpio_out(__u32 device, __u32 mask, __u32 data);

  rc = ibm_gpio_out(0, 0x00100000, 0);


With either approach, I can read the registers fine.  But as soon as I
either modify gpio->or or call ibm_gpio_out(), the board hangs hard.

Any hints would be greatly appreciated.  On-list replies are fine; I am
a subscriber.

Thanks,
Ed
