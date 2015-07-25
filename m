Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 820D11A019D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Jul 2015 10:35:58 +1000 (AEST)
Date: Sat, 25 Jul 2015 10:35:31 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: "Christian T. Steigies" <cts@debian.org>
cc: Michael Schmitz <schmitzmic@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 Linux/m68k <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
In-Reply-To: <20150724190749.GA7529@guido.earth.sol>
Message-ID: <alpine.LNX.2.00.1507251023410.10487@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au> <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
 <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
 <20150724190749.GA7529@guido.earth.sol>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, 24 Jul 2015, Christian T. Steigies wrote:

> Moin,
> On Fri, Jul 24, 2015 at 02:56:26PM +1200, Michael Schmitz wrote:
> > 
> > here's what Finn asked me to run as tests:
> > 
> > # dmesg | grep this_id > nvram.out
> > # cat /proc/driver/nvram >> nvram.out
> > # hexdump -C /dev/nvram >> nvram.out
> > # cp /dev/nvram /tmp/nvram
> > # cp /tmp/nvram /dev/nvram
> > # md5sum /dev/nvram /tmp/nvram >> nvram.out
> 
> It seems I could successfully reset the nvram under TOS with bootconf.
> Here is nvram.out, using the new kernel you sent me:
> 
> root@garkin:~>uname -a
> Linux garkin 4.2.0-rc2-atari-269994-gc1e9d12 #327 Fri Jul 24 19:34:44 NZST 2015 m68k GNU/Linux
> 
> PS it seems LVM is working with this kernel as well!
> 
> Christian
> 
> 
> [    7.000000] scsi host0: Atari native SCSI, io_port 0x0, n_io_port 0, base 0x0, irq 15, can_queue 8, cmd_per_lun 1, sg_tablesize 0, this_id 7, flags { }, options { REAL_DMA SUPPORT_TAGS } 
> Checksum status  : valid
> Boot preference  : unspecified
> SCSI arbitration : on
> SCSI host ID     : 7
> OS language      : English (US)
> Keyboard language: English (UK)
> Date format      : YY?DD?MM, 24h clock
> Boot delay       : 10s
> Video mode       : ?? colors, 80 columns, VGA PAL monitor
>                    overscan, compat. mode off, line doubling
> 00000000  00 00 ff ff ff ff 00 03  13 ff 0a ff ff ff 01 7f  |................|
> 00000010  87 ff 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
> 00000030  e1 1e                                             |..|
> 00000032
> 3b5801864975cf23bcacb52f648e74cc  /dev/nvram
> 3b5801864975cf23bcacb52f648e74cc  /tmp/nvram


Thanks for helping with this, Christian. I'll add your name in "Tested-by" 
tags on the relevant patches. These are rudimentary tests but combined 
with my own testing on m68k, ppc32 and x86, coverage is quite good. Some 
testing on ppc64 is still lacking though.

-- 
