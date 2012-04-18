Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id ED600B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2012 21:30:29 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel@daenzer.net>
Subject: Re: PowerPC radeon KMS - is it possible?
References: <BAY163-W54EBB2437ED2068EF5AF5D03F0@phx.gbl>
 <1334730915.5989.265.camel__41553.0639271767$1334731329$gmane$org@thor.local>
 <m2liltbhkp.fsf@igel.home> <1334736133.5989.278.camel@thor.local>
Date: Wed, 18 Apr 2012 13:30:26 +0200
In-Reply-To: <1334736133.5989.278.camel@thor.local> ("Michel =?utf-8?Q?D?=
 =?utf-8?Q?=C3=A4nzer=22's?= message
 of "Wed, 18 Apr 2012 10:02:13 +0200")
Message-ID: <m24nshb7l9.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: o jordan <ojordan12345@hotmail.co.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michel Dänzer <michel@daenzer.net> writes:

> On Mit, 2012-04-18 at 09:54 +0200, Andreas Schwab wrote: 
>> Michel Dänzer <michel@daenzer.net> writes:
>> 
>> > Probably not (AGP is flaky in general, but in particular with older
>> > UniNorth bridges), but it might be interesting to see some kernel output
>> > from booting without agpmode=-1. If you can't get it via ssh, maybe you
>> > can via netconsole or so.
>> 
>> While logging into KDE:
>> 
>> radeon 0000:00:10.0: GPU lockup CP stall for more than 10064msec
>> GPU lockup (waiting for 0x000003EE last fence id 0x000003ED)
>> radeon: wait for empty RBBM fifo failed ! Bad things might happen.
>> Failed to wait GUI idle while programming pipes. Bad things might happen.
>> radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=0x8802C137
>> radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=0x8802C137
>> radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=0x8802C137
>> radeon 0000:00:10.0: GPU reset succeed
>> radeon 0000:00:10.0: GPU reset succeed
>> radeon 0000:00:10.0: (r300_asic_reset:414) RBBM_STATUS=0x8802C137
>> radeon 0000:00:10.0: (r300_asic_reset:433) RBBM_STATUS=0x8802C137
>> radeon 0000:00:10.0: (r300_asic_reset:445) RBBM_STATUS=0x8802C137
>> radeon 0000:00:10.0: GPU reset succeed
>> radeon: wait for empty RBBM fifo failed ! Bad things might happen.
>> Failed to wait GUI idle while programming pipes. Bad things might happen.
>
> That's even with agpmode=1?

Yes.  Note that I get pretty far into the login process until the lockup
happens.

> Note that I'm interested in seeing the full dmesg or at least all
> agp/drm/radeon related messages.

This was a test with agpmode=1:

Linux agpgart interface v0.103
agpgart-uninorth 0000:00:0b.0: Apple UniNorth 2 chipset
agpgart-uninorth 0000:00:0b.0: configuring for size idx: 64
agpgart-uninorth 0000:00:0b.0: AGP aperture is 256M @ 0x0
[drm] Initialized drm 1.1.0 20060810
[drm] radeon kernel modesetting enabled.
radeon 0000:00:10.0: enabling device (0006 -> 0007)
[drm] initializing kernel modesetting (RV350 0x1002:0x4E56 0x1002:0x4E56).
[drm] register mmio base: 0x90000000
[drm] register mmio size: 65536
radeon 0000:00:10.0: Invalid ROM contents
radeon 0000:00:10.0: Invalid ROM contents
[drm:radeon_get_bios] *ERROR* Unable to locate a BIOS ROM
[drm] Using device-tree clock info
[drm] AGP mode requested: 1
agpgart-uninorth 0000:00:0b.0: putting AGP V2 device into 1x mode
radeon 0000:00:10.0: putting AGP V2 device into 1x mode
radeon 0000:00:10.0: GTT: 256M 0x00000000 - 0x0FFFFFFF
[drm] Generation 2 PCI interface, using max accessible memory
radeon 0000:00:10.0: VRAM: 128M 0x0000000098000000 - 0x000000009FFFFFFF (32M used)
[drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
[drm] Driver supports precise vblank timestamp query.
[drm] radeon: irq initialized.
[drm] Detected VRAM RAM=128M, BAR=128M
[drm] RAM width 64bits DDR
[TTM] Zone  kernel: Available graphics memory: 384080 kiB
[TTM] Zone highmem: Available graphics memory: 515152 kiB
[TTM] Initializing pool allocator
[drm] radeon: 32M of VRAM memory ready
[drm] radeon: 256M of GTT memory ready.
[drm] radeon: ib pool ready.
[drm] radeon: 1 quad pipes, 1 Z pipes initialized.
radeon 0000:00:10.0: WB disabled
[drm] fence driver on ring 0 use gpu addr 0x00000000 and cpu addr 0xf1086000
[drm] Loading R300 Microcode
[drm] radeon: ring at 0x0000000000001000
[drm] ring test succeeded in 2 usecs
[drm] ib test succeeded in 0 usecs
[drm] Connector Table: 2 (ibook)
[drm] No panel info found in BIOS
[drm] Panel info derived from registers
[drm] Panel Size 1024x768
[drm] radeon legacy LVDS backlight initialized
[drm] No TV DAC info found in BIOS

>> After that is is dead.

> The whole machine?

No pings any more.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
