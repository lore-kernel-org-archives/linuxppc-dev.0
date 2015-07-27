Return-Path: <schmitzmic@gmail.com>
Received: from mail-ig0-x22a.google.com (mail-ig0-x22a.google.com
 [IPv6:2607:f8b0:4001:c05::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC8251A02C2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2015 12:23:46 +1000 (AEST)
Received: by igk11 with SMTP id 11so43929748igk.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 19:23:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1507261103550.21031@nippy.intranet>
References: <20150712102527.356151908@telegraphics.com.au>
 <20150712102528.107134628@telegraphics.com.au>
 <87d1zwc4dj.fsf@igel.home>
 <alpine.LNX.2.00.1507141804300.1622@nippy.intranet>
 <55AF1364.3080701@gmail.com>
 <alpine.LNX.2.00.1507221421100.4187@nippy.intranet>
 <20150723092114.GA10989@guido.earth.sol>
 <CAOmrzkL1rOV=9zu=sfpt4-oveR2j-_KVGYvCvCGWzj83oOihnw@mail.gmail.com>
 <20150724190749.GA7529@guido.earth.sol>
 <55B2DD88.2090804@gmail.com>
 <alpine.LNX.2.00.1507251722580.25996@nippy.intranet>
 <55B43196.5@gmail.com>
 <alpine.LNX.2.00.1507261103550.21031@nippy.intranet>
Date: Mon, 27 Jul 2015 14:23:43 +1200
Message-ID: <CAOmrzkLUfO02c+k31QD3J3pZZOR_BE6zFSwD2cHtyejCJ2Jgxg@mail.gmail.com>
Subject: Re: [RFC v4 03/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
From: Michael Schmitz <schmitzmic@gmail.com>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
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

Finn,

my bad - there is indeed a change in the /proc/driver/nvram output:

--- nvram-4.out    2015-07-24 12:32:44.000000000 +1200
+++ nvram-4p2.out    2015-07-27 13:56:06.000000000 +1200
@@ -7,7 +7,7 @@
 Keyboard language: English (US)
 Date format      : DD.MM.YY, 24h clock
 Boot delay       : 32s
-Video mode       : 4 colors, 40 columns, TV NTSC monitor
+Video mode       : 256 colors, 80 columns, VGA PAL monitor
                    no overscan, compat. mode off
 00000000  00 00 00 00 00 00 00 00  11 2e 20 01 ff 00 00 3b  |.......... ....;|
 00000010  84 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|


That video mode is indeed the one set in the NVRAM (by ARAnyM config,
if running emulated)

Cheers,

  Michael


On Sun, Jul 26, 2015 at 1:19 PM, Finn Thain <fthain@telegraphics.com.au> wrote:
>
> On Sun, 26 Jul 2015, Michael Schmitz wrote:
>
>> Hi Finn,
>>
>> For the sake of completeness: further testing on ARAnyM shows no difference
>> between original and patched kernel in the NVRAM proc and diff outputs:
>>
>> scsi host0: Atari native SCSI, io_port 0x0, n_io_port 0, base 0x0, irq 15,
>> can_queue 8, cmd_per_lun 1, sg_tablesize 0, this_id 7, flags { }, options {
>> REAL_DMA SUPPORT_TAGS }
>> Checksum status  : valid
>> Boot preference  : unspecified
>> SCSI arbitration : on
>> SCSI host ID     : 7
>> OS language      : English (US)
>> Keyboard language: English (US)
>> Date format      : DD.MM.YY, 24h clock
>> Boot delay       : 32s
>> Video mode       : 4 colors, 40 columns, TV NTSC monitor
>>                    no overscan, compat. mode off
>> 00000000  00 00 00 00 00 00 00 00  11 2e 20 01 ff 00 00 3b |.......... ....;|
>> 00000010  87 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 |................|
>> 00000020  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 |................|
>> 00000030  de 21                                            |.!|
>> 00000032
>
> I'd expect to see a change in the Video mode above, because of patch 2.
>
> With 0x3B in byte 15, I'd expect the patched kernel to produce something
> similar to Christian's /proc/driver/nvram results.
>
> --
