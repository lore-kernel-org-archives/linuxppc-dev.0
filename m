From: DavidHo@nanometrics.ca
Subject: Fw: EXT_DIRECT IDE Mode
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OFDCE1745F.75320B54-ON85256E37.00772EA4-85256E37.0077879C@nanometrics.ca>
Date: Wed, 11 Feb 2004 16:45:34 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steve,

Who calls ide_init_hwif_ports (function in asm-ppc/ide.h) if
CONFIG_BLK_DEV_IDEPCI is not configured and ide_default_io_base always
returns 0?

That's what's puzzling me.

David

----- Forwarded by David Ho/NMX/CA on 02/11/2004 04:42 PM -----

                      DavidHo@nanometrics.ca
                      Sent by:                                To:      Steven Scholz
                      owner-linuxppc-embedded@lists.l         <steven.scholz@imc-berlin.de>
                      inuxppc.org                             cc:      linuxppc-embedded@lists.linuxppc.org
                                                              Subject: Re: EXT_DIRECT IDE Mode

                      02/11/2004 01:54 PM





Steve,

I'm using a variant of the 2.4.18 kernel from timesys.

The kernel is compiled with those settings.  (in your email)

I had to add a call to m8xx_ide_init in m8xx-setup.c at the end of
platform_init.

I can only find these defines in ide-m8xx.c.  I am thinking there must be
more to it than the one file.

Thanks for your help,
David




DavidHo@nanometrics.ca wrote:

> My application needs a compactflash and a 1.8" disk drive connected to
the
> MPC852T.  Since the compact flash has already taken up the only PCMCIA
> slot, the disk drive is directly attached to the PPC bus so I need to
> enable EXT_DIRECT for the disk drive.
Ok.

> I haven't been able to make linux call the ide_init_hwif function.  I
> looked at how ide.c works and it looks like it enables IDE interfaces on
> the PCI first (ide_default_io_base returns non-zero).  I haven't yet been
> able to find out where it call my function.
>
> Would you be able to tell me how you got this mode working.

I do if you tell me which kernel version you tried.
I guess you have

CONFIG_BLK_DEV_MPC8xx_IDE=y
# CONFIG_IDE_8xx_PCCARD is not set
# CONFIG_IDE_8xx_DIRECT is not set
CONFIG_IDE_EXT_DIRECT=y

in your .config file?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
