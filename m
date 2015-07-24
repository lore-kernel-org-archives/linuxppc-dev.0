Return-Path: <schmitzmic@gmail.com>
Received: from mail-ig0-x22d.google.com (mail-ig0-x22d.google.com
 [IPv6:2607:f8b0:4001:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 373361A0186
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 12:56:29 +1000 (AEST)
Received: by igbpg9 with SMTP id pg9so25733857igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:56:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150723092114.GA10989@guido.earth.sol>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au>
 <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
Date: Fri, 24 Jul 2015 14:56:26 +1200
Message-ID: <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
From: Michael Schmitz <schmitzmic@gmail.com>
To: Finn Thain <fthain@telegraphics.com.au>,
 Michael Schmitz <schmitzmic@gmail.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Linux Kernel Development <linux-kernel@vger.kernel.org>,
 "Linux/m68k" <linux-m68k@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christian,

here's what Finn asked me to run as tests:

# dmesg | grep this_id > nvram.out
# cat /proc/driver/nvram >> nvram.out
# hexdump -C /dev/nvram >> nvram.out
# cp /dev/nvram /tmp/nvram
# cp /tmp/nvram /dev/nvram
# md5sum /dev/nvram /tmp/nvram >> nvram.out

What you sent so far looks OK. I've tested the change of SCSI ID
(using EmuTOS) along with a trivial patch to atari_scsi.c (replace
offset 14 by 16) and the driver now uses the stored ID properly. I'll
sent kernels to test Finn's NVRAM patch for regression ASAP.

Thanks for your offer of help!

Cheers,

  Michael


On Thu, Jul 23, 2015 at 9:21 PM, Christian T. Steigies <cts@debian.org> wrote:
> On Wed, Jul 22, 2015 at 02:22:21PM +1000, Finn Thain wrote:
>>
>> Anyone with a suitable Atari, i.e. ATARIHW_PRESENT(TT_CLK), who can boot
>> both TOS and Linux could resolve the question. (Perhaps with an emulator?)
>>
>> Any old kernel binary would do, since atari_scsi should print either
>> "HOSTID=n" or "this_id n" at startup.
>>
>> If n doesn't agree with what TOS says about the host's SCSI ID, then I
>> think a trivial patch is safe enough. Especially if cat /proc/driver/nvram
>> produces a "SCSI host ID : m" that does agree with TOS.
>
> root@garkin:~>cat /proc/hardware
> Model:          Atari Falcon
> System Memory:  522752K
>         510 MB at 0x01000000 (alternate RAM)
> Detected hardware:
>         Falcon Shifter
>         Programmable Sound Generator
>         PCM 8 Bit Sound
>         CODEC Sound
>         SCSI Controller NCR5380 (Falcon style)
>         IDE Interface
>         8/16 Mhz Switch for FDC
>         Multi Function Peripheral MFP 68901
>         Serial Communications Controller SCC 8530
>         Paddle Interface
>         DMA Controller for SCC
>         Clock Chip MC146818A
>         Blitter
>         DSP56001 processor
>
> root@garkin:~>dmesg |grep SCSI
> [    0.000000] Atari hardware found: VIDEL STDMA-SCSI ST_MFP YM2149 PCM CODEC DSP56K SCC_DMA SCC ANALOG_JOY BLITTER IDE TT_CLK FDC_SPEED
> [    0.410000] SCSI subsystem initialized
> [    0.850000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
> [    4.230000] Atari SCSI: resetting the SCSI bus... done
> [    6.750000] scsi host0: Atari native SCSI, io_port 0x0, n_io_port 0, base 0x0, irq 15, can_queue 8, cmd_per_lun 1, sg_tablesize 0, this_id 7, flags { }, options { REAL_DMA SUPPORT_TAGS }
>
> root@garkin:~>cat /proc/driver/nvram
> Checksum status  : not valid
> Boot preference  : 0xff (undefined)
> SCSI arbitration : on
> SCSI host ID     : 7
> OS language      : 255 (undefined)
> Keyboard language: 255 (undefined)
> Date format      : 7 (undefined), 24h clock
> Boot delay       : 255s
> Video mode       : 4 colors, 40 columns, TV NTSC monitor
>                    no overscan, compat. mode off
>
>
> Let me know if you need more info.
>
> Christian
