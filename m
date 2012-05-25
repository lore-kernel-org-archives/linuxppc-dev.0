Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E2EFAB6F6E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2012 11:00:09 +1000 (EST)
Message-ID: <1337907595.16119.5.camel@pasglop>
Subject: Re: Oops with Radeon/Uninorth on Maple
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dmitry Eremin-Solenikov <dmitry_eremin@mentor.com>
Date: Fri, 25 May 2012 10:59:55 +1000
In-Reply-To: <4FBDD2CF.5060008@mentor.com>
References: <4FBDD2CF.5060008@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org,
 Michel =?ISO-8859-1?Q?D=E4nzer?= <daenzer@vmware.com>,
 dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-05-24 at 10:18 +0400, Dmitry Eremin-Solenikov wrote:
> Hello, colleagues,
> 
> I'm trying to enable an AGP slot (again) on my Maple board (dual 
> PPC970FX board, with CPC925 (U3H) north bridge).
> 
>   For now I'm stuck with a problem: I use radeon card, drm-radeon driver 
> with KMS.
> 
> If I force drm-radeon to think about a card as about PCI card (by 
> commenting corresponding lines in drm_radeon_kms.c), everything works, I 
> get framebuffer, working X11, etc. If I enable agpgart-uninorth driver
> and RADEON_IS_AGP flag in drm driver, I get an Oops early during the 
> bootstrap. Relevant part of the log (I can send full dmesg of normal 
> bootstrap or this oops on request, if that would help).

Machine Check probably means that there's a HW configuration issue,
possibly something missing in the initialization of the AGP hardware to
make it actually work.

Cheers,
Ben.

> [    2.820647] Linux agpgart interface v0.103
> [    2.824909] agpgart-uninorth 0000:f0:0b.0: Apple U3H chipset
> [    2.830668] agpgart-uninorth 0000:f0:0b.0: Found device u3, rev 35
> [    2.843611] agpgart-uninorth 0000:f0:0b.0: configuring for size idx: 64
> [    2.850638] agpgart-uninorth 0000:f0:0b.0: AGP aperture is 256M @ 0x0
> [    2.857646] [drm] Initialized drm 1.1.0 20060810
> [    2.862567] [drm] radeon defaulting to kernel modesetting.
> [    2.868091] [drm] radeon kernel modesetting enabled.
> [    2.873222] radeon 0000:f0:10.0: enabling device (0000 -> 0003)
> [    2.880311] radeon 0000:f0:10.0: enabling bus mastering
> [    2.885591] [drm] initializing kernel modesetting (RV350 
> 0x1002:0x4152 0x18BC:0x0416).
> [    2.893629] [drm] register mmio base: 0xD0020000
> [    2.898260] [drm] register mmio size: 65536
> [    2.947112] [drm] GPU not posted. posting now...
> [    3.051033] agpgart-uninorth 0000:f0:0b.0: putting AGP V3 device into 
> 8x mode
> [    3.058197] radeon 0000:f0:10.0: putting AGP V3 device into 8x mode
> [    3.064666] radeon 0000:f0:10.0: GTT: 256M 0x00000000 - 0x0FFFFFFF
> [    3.070864] [drm] Generation 2 PCI interface, using max accessible memory
> [    3.077672] radeon 0000:f0:10.0: VRAM: 128M 0x00000000C0000000 - 
> 0x00000000C7FFFFFF (128M used)
> [    3.086487] [drm] Supports vblank timestamp caching Rev 1 (10.10.2010).
> [    3.093126] [drm] Driver supports precise vblank timestamp query.
> [    3.099291] [drm] radeon: irq initialized.
> [    3.103404] [drm] Detected VRAM RAM=128M, BAR=128M
> [    3.108214] [drm] RAM width 128bits DDR
> [    3.112263] [TTM] Zone  kernel: Available graphics memory: 496682 kiB
> [    3.118732] [TTM] Initializing pool allocator
> [    3.123346] [drm] radeon: 128M of VRAM memory ready
> [    3.128256] [drm] radeon: 256M of GTT memory ready.
> [    3.133295] [drm] radeon: ib pool ready.
> [    3.137708] [drm] radeon: 1 quad pipes, 1 Z pipes initialized.
> [    3.144018] radeon 0000:f0:10.0: WB disabled
> [    3.148326] [drm] fence driver on ring 0 use gpu addr 0x00000000 and 
> cpu addr 0xd000000000066000
> [    3.157474] [drm] Loading R300 Microcode
> [    3.162480] [drm] radeon: ring at 0x0000000000001000
> [    3.167569] [drm] ring test succeeded in 0 usecs
> cpu 0x0: Vector: 200 (Machine Check) at [c000000000d63aa0]
>      pc: c0000000000cc07c: .trace_hardirqs_on_caller+0x6c/0x190
>      lr: c0000000000152f4: .cpu_idle+0x1a4/0x220
>      sp: c000000000d63d20
>     msr: 9000000000009032
>    current = 0xc000000000c4db30
>    paca    = 0xc00000000ffff000   softe: 0        irq_happened: 0x01
>      pid   = 0, comm = swapper/0
> enter ? for help
> [c000000000d63db0] c0000000000152f4 .cpu_idle+0x1a4/0x220
> [c000000000d63e50] c000000000008fb8 .rest_init+0xe8/0x110
> [c000000000d63ee0] c000000000ba2998 .start_kernel+0x3e4/0x408
> [c000000000d63f90] c000000000007558 .start_here_common+0x20/0x48
> 0:mon> x
> [  843.783295] Oops: Machine check, sig: 7 [#1]
> [  843.787589] SMP NR_CPUS=4 Maple
> [  843.790768] Modules linked in:
> [  843.793855] NIP: c0000000000cc07c LR: c0000000000152f4 CTR: 
> c000000000023eac
> [  843.800920] REGS: c000000000d63aa0 TRAP: 0200   Not tainted  (3.4.0+)
> [  843.807376] MSR: 9000000000009032 <SF,HV,EE,ME,IR,DR,RI>  CR: 
> 24222222  XER: 00000006
> [  843.815412] SOFTE: 0
> [  843.817607] TASK = c000000000c4db30[0] 'swapper/0' THREAD: 
> c000000000d60000 CPU: 0
> [  843.825035] GPR00: 0000000000000000 c000000000d63d20 c000000000d63280 
> c0000000000152f4
> [  843.833169] GPR04: 0000000000000000 c000000000099d10 0000000000000001 
> 0000000000000002
> [  843.841302] GPR08: 0100000000000000 c000000000e828e8 0140000000000000 
> 0000000000000000
> [  843.849436] GPR12: 0000000044222282 c00000000ffff000 0000000000000000 
> 0000000000000000
> [  843.857570] GPR16: 0000000000ff8750 0000000000cdc890 00000000010001e0 
> 0000000000000000
> [  843.865702] GPR20: 0000000000000000 0000000000000000 000000001dcd6500 
> 0000000000000000
> [  843.873835] GPR24: 0000000000000000 0000000000ec7b00 9000000000009032 
> c000000000d7b178
> [  843.881979] GPR28: c000000000d7b278 0000000000000008 c000000000c970f8 
> c0000000000152f4
> [  843.890314] NIP [c0000000000cc07c] .trace_hardirqs_on_caller+0x6c/0x190
> [  843.896942] LR [c0000000000152f4] .cpu_idle+0x1a4/0x220
> [  843.902181] Call Trace:
> [  843.904640] [c000000000d63d20] [c000000000d63db0] 
> init_thread_union+0x3db0/0x4000 (unreliable)
> [  843.913317] [c000000000d63db0] [c0000000000152f4] .cpu_idle+0x1a4/0x220
> [  843.919964] [c000000000d63e50] [c000000000008fb8] .rest_init+0xe8/0x110
> [  843.926615] [c000000000d63ee0] [c000000000ba2998] 
> .start_kernel+0x3e4/0x408
> [  843.933611] [c000000000d63f90] [c000000000007558] 
> .start_here_common+0x20/0x48
> [  843.940866] Instruction dump:
> [  843.943868] 40de00a4 e92d01c8 800908e8 2f800000 40de0094 e93e8098 
> 80090000 2f800000
> [  843.951829] 409e0030 880d01f2 2fa00000 40de00b0 <e93e84e8> 88090000 
> 2f800000 40de00c8
> 
> 
> Looking for any suggestions on this.
> 
