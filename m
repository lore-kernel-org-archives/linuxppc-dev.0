To: David Jander <david.jander@protonic.nl>
Cc: "Frank Robbins" <Frank.Robbins@Analogue-Micro.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Support for MPC852T, any experience ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 19 Jun 2003 11:06:38 +0200."
             <200306191106.39116.david.jander@protonic.nl>
Date: Thu, 19 Jun 2003 12:23:11 +0200
Message-Id: <20030619102316.10689C5FD7@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear David,

in message <200306191106.39116.david.jander@protonic.nl> you wrote:
>
> Great ! Have you had much trouble making all the hardware work, or do all the
> existing drivers in arch/ppc/8xx_io work out of the box ?

They should work out of the box. This is just another member  of  the
8xx family.

> Equiped with a MMC slot (for MMC's in SPI mode over the SPI interface),

Are you sure you really want to do this? Please be aware that the SPI
port on the 8xx was NOT designed for high performance /  volume  data
transfers. Motorola writes:

        The SPI was not designed to be a high-bandwidth channel. It
        can run very quickly for bursts of up to 16-bits. But the
        peripheral has no FIFO and low priority in the MPC860 and
        thus you cannot burst lots of data quickly through the
        interface.
	...
        Note that the SPI is of lower priority internally than the
        SCCs, thus, the SPI will be the first device to be "starved".
        Snce it has no FIFO, it is especially sensitive to underruns.
        The best way to prevent this is to use a buffer size of 1
        "character" (of size programmed in the mode register).
        ...

Also, you should be aware that the SPI  protocol  is  implemented  as
microcode  running  on the CPM, so any high-speed data transfers will
suck up CPM performance.


>From my experience SPI on the 8xx should NOT be used  for  mass  data
transfers. You will run into a LOT of problems. Been there ...


> 16-64Mb SDRAM, 2-8Mb Flash (for kernel, bootloader, some basic rootfs, data
> storage) and the applications mostly on a fs on MMC.

You mean a filesystem on a device over SPI? I _strongly_ recommend to
change your design. You will run into _serious_ trouble that way.


> I am specially interested in hearing about experience with using a filesystem
> on a MMC via the SPI interface.

See above. Don't even think about it.




Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Another megabytes the dust.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
