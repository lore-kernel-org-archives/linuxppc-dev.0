Date: Fri, 14 Feb 2003 22:59:21 +0900
From: OHMURA Yutaka <ohmura@co-nss.co.jp>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: How to use EP8260 MTD device?
Message-Id: <20030214225921h!ESQh@co-nss.co.jp>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <20030206145802&N-TsG@co-nss.co.jp>
References: <20030206145802&N-TsG@co-nss.co.jp>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


A bit info (and memo for me ^^)

EP8260 using four 16 bits flash ROM (64bit width), and I tried to send CFI
query command. But Linux MTD driver looks not think like this design.
I hope It can use as same as two 16 bits flash ROM (32bit width) or one
16 bits flash ROM (16bit width).

My first try, do "*(volatile unsigned int *)(0xFF000000 + 0x55 * 8) = 0x0098;",
after that I got data "Q" with "data = *(volatile unsigned int *)(0xFF000000 +
0x10 * 8);" same as "R" and "Y".
But I could't got "Q" when I did "writel(0x0098, 0xFF000000 + 0x55 * 8);",
I wondered, finally I got "Q" when I did "writel(0x9800, 0xFF000000 + 0x55
* 8);", so the "writel" wrapper must be adjust EP8260 (or for big endian
MPUs)....

OHMURA Yutaka <ohmura@co-nss.co.jp> wrote:

>
> Hi,
>
> I got some info about EP8260, the 200MHz uses AM29LV320, and it's not supported
> by Linux, so I'll tring to use it now.
> And I'm tring to add set BCSR2 register GFWP bit which controll Flash write/not.
>
> Steven Blakeslee <BlakesleeS@embeddedplanet.com> wrote:
>
> >
> > It looks like you are using the MTD with the onboard FLASH.  I noticed you
> > have "CONFIG_MTD_PHYSMAP_BUSWIDTH=2", the FLASH on the ep8260 is a 64bit
> > bus, wouldn't that mean this should be a "CONFIG_MTD_PHYSMAP_BUSWIDTH=4".
> >
> > Also, there are more configurations you can make, particularly for FLASH.
> > You should use make menuconfig and look at the other options.
> >
> > Lastly, there is mention of MTD for the RPX LITE and CLLF boards.  These
> > have the same FLASH but a 32 bit bus, you may be able to modify this support
> > to include 64 bit for the ep8260.
> >
> > -----Original Message-----
> > From: OHMURA Yutaka [mailto:ohmura@co-nss.co.jp]
> > Sent: Friday, January 31, 2003 8:40 AM
> > To: linuxppc-embedded@lists.linuxppc.org
> > Subject: Re: How to use EP8260 MTD device?
> >
> >
> >
> > Hi,
> >
> > In this ML, no one uses EP8260?
> > Or TSL(2.4.7 base)?
> >
> > I changed my .config as follows, but still not work.
> > > # Memory Technology Devices (MTD)
> > > CONFIG_MTD=y
> > > CONFIG_MTD_DEBUG=y
> > > CONFIG_MTD_DEBUG_VERBOSE=3
> > > CONFIG_MTD_PARTITIONS=y
> > > CONFIG_MTD_CHAR=y
> > > CONFIG_MTD_BLOCK=y
> > > CONFIG_FTL=y
> > >
> > > # RAM/ROM/Flash chip drivers
> > > CONFIG_MTD_CFI=y
> > > CONFIG_MTD_GEN_PROBE=y
> > > CONFIG_MTD_CFI_AMDSTD=y
> > >
> > > # Mapping drivers for chip access
> > > CONFIG_MTD_PHYSMAP=y
> > > CONFIG_MTD_PHYSMAP_START=FF000000
> > > CONFIG_MTD_PHYSMAP_LEN=FFFFFF
> > > CONFIG_MTD_PHYSMAP_BUSWIDTH=2
> >
> > By the way, TSL uses DEC register for timer, is this same in pure PPC-Linux?
> > I could't find pure PPC-Linux 2.4.7 source code...
> >
> > Regards,
> >
> > Yutaka
> >
> > OHMURA Yutaka <ohmura@co-nss.co.jp> wrote:
> >
> > >
> > > Hello,
> > >
> > > Now I'm trying to use Embedded Planet 8260 board Flash memory with TimeSys
> > > Linux 3.1(TSL). I have two type of this board. One has 200MHz clock, have
> > RTC,
> > > 64MB PSDRAM, 32MB LSDRAM and 16MB Flash ROM. The other has 300MHz clock,
> > > no RTC, 32MB PSDRAM and 8MB Flash ROM. My goal is use MTD device under TSL
> > with
> > > 300MHz MPU board, but the board looks some other difference with 200MHz
> > board,
> > > so TSL can't works fine, so at first I'm trying to use MTD device with
> > 200MHz
> > > board. But I can't use MTD until now.
> > > In now situation, /dev/mtd and /dev/mtdblock are normal directory and
> > there are
> > > nothing under the directory.
> > >
> > > Please tell me how to use MTD on EP8260 under TSL!
> > >
> > > Here is my .config
> > > > # Memory Technology Devices (MTD)
> > > > CONFIG_MTD=y
> > > > CONFIG_MTD_DEBUG=y
> > > > CONFIG_MTD_DEBUG_VERBOSE=3
> > > > CONFIG_MTD_PARTITIONS=y
> > > > CONFIG_MTD_CHAR=y
> > > > CONFIG_MTD_BLOCK=y
> > > > CONFIG_FTL=y
> > >
> > > > # RAM/ROM/Flash chip drivers
> > > > CONFIG_MTD_CFI=y
> > > > CONFIG_MTD_JEDECPROBE=y
> > > > CONFIG_MTD_GEN_PROBE=y
> > > > CONFIG_MTD_CFI_AMDSTD=y	<-On board Flash memory looks AMD
> > > 				  chip but the print faint so I
> > > 				  can't read chip type
> > > > CONFIG_MTD_CFI_AMDSTD=y
> > > > CONFIG_MTD_OBSOLETE_CHIPS=y
> > > > CONFIG_MTD_AMDSTD=y
> > >
> > > > # Mapping drivers for chip access
> > > > CONFIG_MTD_PHYSMAP=y
> > > > CONFIG_MTD_PHYSMAP_START=FF800000	<-adjusting to 300MHz board
> > > > CONFIG_MTD_PHYSMAP_LEN=70000000	  I hope 200MHz board can work with
> > > 					  this parameter
> > > > CONFIG_MTD_PHYSMAP_BUSWIDTH=2
> > > other MTD parameters are not set
> > >
> > > Under this environment, MTD driver says
> > > > physmap flash device: 6ffffc at ff800000
> > > > CFI: Found no Physically mapped flash device at location zero
> > > > RPX Lite or CLLF flash device: 2000000 at fe000000
> > > > CFI: Found no RPX device at location zero
> > > > $Id: ftl.c,v 1.38 2001/09/23 21:15:12 dwmw2 Exp $
> > >
> > > This is first time to use MTD for me, so if you know good reference to use
> > it,
> > > please tell me too.
> > > /usr/src/timesys/ep8260/2.4.7-timesys-3.1.180/kernel/Documents was not
> > help me.
> > >
> > > Regards,
> > >
> > > Yutaka
> > >
> > >
> >
> >
> > _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
> > OHMURA, Yutaka <ohmura@co-nss.co.jp>
> >   Nissin Systems co.,ltd.
> >   (Phone) +81-75-344-7950  (FAX) +81-75-344-7888
> >    Ayakoji, Horikawa street, Shimogyo-ku, KYOTO, JAPAN
> > _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
> >
> >
> >
>
>
> _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
> OHMURA, Yutaka <ohmura@co-nss.co.jp>
>   Nissin Systems co.,ltd.
>   (Phone) +81-75-344-7950  (FAX) +81-75-344-7888
>    Ayakoji, Horikawa street, Shimogyo-ku, KYOTO, JAPAN
> _/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
>
>
>


_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/
OHMURA, Yutaka <ohmura@co-nss.co.jp>
  Nissin Systems co.,ltd.
  (Phone) +81-75-344-7950  (FAX) +81-75-344-7888
   Ayakoji, Horikawa street, Shimogyo-ku, KYOTO, JAPAN
_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/_/


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
