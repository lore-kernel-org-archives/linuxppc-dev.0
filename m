Message-ID: <391C3164.E68C4EC4@motorola.com>
Date: Fri, 12 May 2000 11:29:24 -0500
From: "Richard Hendricks" <richard.hendricks@motorola.com>
MIME-Version: 1.0
CC: "'linuxppc-embedded@lists.linuxppc.org'"  <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem with CPM I2C driver
References: <819E3E914E0AD11194DE00805F0D100B0138B857@fbi.infocom.dk>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kim Jørgensen wrote:
>
> Hi.
>
> After solving my hardware problem on custom MPC823E board and I got my LCD
> running, thank you for the help.
> But I have a new problem: I want to use the I2C bus, but the driver doesn't
> seam to work.
>
> I added CPM IIC and IIC/SPI Microcode patch in xconfig. Then I added the
> cpm_iic_init function in drivers/char/mem.c so that is would be called at
> startup.

I assume you are using the microcode patch because you are using
Ethernet?
If your Ethernet is on SCC2 (which it should be), you don't need the
patch unless you are using SPI.

> When I try to read some data from /dev/i2c0 the driver just hang. I have
> added some printk in the iic driver read function, and it seam to hang just
> after enabling the i2c controller.
> Can anyone help me with this?

Are you trying to do any of the CPM Microcontroller commands?  I don't
think you can do the SPI/I2C commands when using the patch.  The uCode
patch itself has been recently updated to address a problem with
high CPM loads, is that the environment you are running in?

> The "driver" in arch/ppc/mbxboot seam to work fine on my board.
>
> Is there any other more complete i2c driver available?
>
> ---
> Kim Jorgensen
>

--
MPC823 Applications Engineering Development
Get help from other MPC823 customers on the
comp.sys.powerpc.tech newsgroup!

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
