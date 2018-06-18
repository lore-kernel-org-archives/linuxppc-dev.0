Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418gf43RQYzF0pl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 05:10:20 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id a141-v6so15860709oii.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2018 12:10:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180618140518.2920804-1-arnd@arndb.de>
In-Reply-To: <20180618140518.2920804-1-arnd@arndb.de>
From: Mathieu Malaterre <malat@debian.org>
Date: Mon, 18 Jun 2018 21:10:06 +0200
Message-ID: <CA+7wUswcgxLz_GAqkyVLpdAmTNEPUZ-cXJ8Ej7Xx9+OgjGUo=Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] powerpc: mac: fix rtc read functions
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, gerg@linux-m68k.org,
 linux-m68k@lists.linux-m68k.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 LKML <linux-kernel@vger.kernel.org>, y2038@lists.linaro.org,
 Meelis Roos <mroos@linux.ee>,
 Alexandre Belloni <alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 18, 2018 at 4:07 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
> in negative times to be read from the RTC. The problem is that during the
> conversion from a byte array to a time64_t, the 'unsigned char' variable
> holding the top byte gets turned into a negative signed 32-bit integer
> before being assigned to the 64-bit variable for any times after 1972.
>
> This changes the logic to cast to an unsigned 32-bit number first for
> the Macintosh time and then convert that to the Unix time, which then gives
> us a time in the documented 1904..2040 year range. I decided not to use
> the longer 1970..2106 range that other drivers use, for consistency with
> the literal interpretation of the register, but that could be easily
> changed if we decide we want to support any Mac after 2040.
>
> Just to be on the safe side, I'm also adding a WARN_ON that will trigger
> if either the year 2040 has come and is observed by this driver, or we
> run into an RTC that got set back to a pre-1970 date for some reason
> (the two are indistinguishable).
>
> The same code exists in arch/m68k/ and is patched in an identical way now
> in a separate patch.
>
> Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/powerpc/platforms/powermac/time.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
> index 7c968e46736f..173a80630169 100644
> --- a/arch/powerpc/platforms/powermac/time.c
> +++ b/arch/powerpc/platforms/powermac/time.c
> @@ -42,7 +42,11 @@
>  #define DBG(x...)
>  #endif
>
> -/* Apparently the RTC stores seconds since 1 Jan 1904 */
> +/*
> + * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
> + * times wrap in 2040. If we need to handle later times, the read_time functions
> + * need to be changed to interpret wrapped times as post-2040.
> + */
>  #define RTC_OFFSET     2082844800
>
>  /*
> @@ -97,8 +101,11 @@ static time64_t cuda_get_time(void)
>         if (req.reply_len != 7)
>                 printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
>                        req.reply_len);
> -       now = (req.reply[3] << 24) + (req.reply[4] << 16)
> -               + (req.reply[5] << 8) + req.reply[6];
> +       now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
> +                   (req.reply[5] << 8) + req.reply[6]);
> +       /* it's either after year 2040, or the RTC has gone backwards */
> +       WARN_ON(now < RTC_OFFSET);
> +
>         return now - RTC_OFFSET;
>  }
>
> @@ -140,8 +147,12 @@ static time64_t pmu_get_time(void)
>         if (req.reply_len != 4)
>                 printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
>                        req.reply_len);
> -       now = (req.reply[0] << 24) + (req.reply[1] << 16)
> -               + (req.reply[2] << 8) + req.reply[3];
> +       now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16) +
> +                   (req.reply[2] << 8) + req.reply[3]);
> +
> +       /* it's either after year 2040, or the RTC has gone backwards */
> +       WARN_ON(now < RTC_OFFSET);
> +
>         return now - RTC_OFFSET;
>  }

Sadly, trying again today does not work anymore. Adding some printk
just before WARN_ON:

+printk(KERN_ERR " rtc DBG pmu_get_time1: %lld %d %lld \n", now,
RTC_OFFSET, now - RTC_OFFSET );
+printk(KERN_ERR " rtc DBG pmu_get_time2: %x %x %x %x %d \n",
req.reply[0], req.reply[1], req.reply[2], req.reply[3] ,
req.reply_len);

leads to:

[    0.000000]  rtc DBG pmu_get_time1: 14096662 2082844800 -2068748138
[    0.000000]  rtc DBG pmu_get_time2: 0 d7 19 16 4
[    0.000000] WARNING: CPU: 0 PID: 0 at
../arch/powerpc/platforms/powermac/time.c:158 pmu_get_time+0x11c/0x16c
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #8
[    0.000000] NIP:  c0035658 LR: c0035640 CTR: c00d4a5c
[    0.000000] REGS: c0cf7da0 TRAP: 0700   Not tainted  (4.17.0+)
[    0.000000] MSR:  00021032 <ME,IR,DR,RI>  CR: 84000848  XER: 00000000
[    0.000000]
               GPR00: c0035640 c0cf7e50 c0a41bd0 00000025 00000001
00000051 c0d56430 00000000
               GPR08: 00000051 00000001 c0aa4b38 00000004 24000842
00000000 ffbbf4c0 0013da1c
               GPR16: 0013da18 0013da20 00000000 00000000 00b81044
01696028 01697e02 40140000
               GPR24: 00000000 00d71000 c09debec dfff1120 000001a4
00d71916 ffffffff 84b16896
[    0.000000] NIP [c0035658] pmu_get_time+0x11c/0x16c
[    0.000000] LR [c0035640] pmu_get_time+0x104/0x16c
[    0.000000] Call Trace:
[    0.000000] [c0cf7e50] [c0035640] pmu_get_time+0x104/0x16c (unreliable)
[    0.000000] [c0cf7ed0] [c00113fc] read_persistent_clock64+0x78/0x1ac
[    0.000000] [c0cf7f30] [c09ad470] timekeeping_init+0x24/0x2f4
[    0.000000] [c0cf7fc0] [c09986f0] start_kernel+0x34c/0x490
[    0.000000] [c0cf7ff0] [00003444] 0x3444
[    0.000000] Instruction dump:
[    0.000000] 88e1002f 3863404c 88c1002e 88a1002d 8881002c 4809baf1
3d207c25 6129b07f
[    0.000000] 7f9d4840 39200001 409d0008 39200000 <0f090000> 4bffff20
3c60c0c1 7fe4fb78
[    0.000000] random: get_random_bytes called from
print_oops_end_marker+0x6c/0x90 with crng_init=0
[    0.000000] ---[ end trace 93a1b37c50fb7a33 ]---


and then later on :

[    5.535354]  rtc DBG pmu_get_time1: 14096667 2082844800 -2068748133
[    5.539988]  rtc DBG pmu_get_time2: 0 d7 19 1b 4
[    5.544477] WARNING: CPU: 0 PID: 1 at
../arch/powerpc/platforms/powermac/time.c:158 pmu_get_time+0x11c/0x16c
[    5.553536] Modules linked in:
[    5.558076] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.17.0+ #8
[    5.562769] NIP:  c0035658 LR: c0035640 CTR: c00d4a5c
[    5.567437] REGS: df4e7a90 TRAP: 0700   Tainted: G        W
 (4.17.0+)
[    5.572201] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 88008288  XER: 00000000
[    5.577028]
               GPR00: c0035640 df4e7b40 df4e8000 00000025 00000001
00000344 00000400 00000000
               GPR08: 00000003 00000001 c0aa4b38 00000000 28008282
00000000 c09dfc4c c09dfc28
               GPR16: 00000690 c0aedae0 c0aee64c c0aecf50 00000054
c0ae7488 c0aea0f4 00000000
               GPR24: c0d70000 c0a85850 c086fc74 df4e7c5c df4e7ce8
00d7191b ffffffff 84b1689b
[    5.601871] NIP [c0035658] pmu_get_time+0x11c/0x16c
[    5.606952] LR [c0035640] pmu_get_time+0x104/0x16c
[    5.612042] Call Trace:
[    5.617079] [df4e7b40] [c0035640] pmu_get_time+0x104/0x16c (unreliable)
[    5.622297] [df4e7bc0] [c003572c] pmac_get_rtc_time+0x34/0x4c
[    5.627509] [df4e7bd0] [c001076c] rtc_generic_get_time+0x2c/0x40
[    5.632740] [df4e7be0] [c0611fb8] __rtc_read_time+0x70/0x13c
[    5.637977] [df4e7c00] [c06120f0] rtc_read_time+0x6c/0x130
[    5.643230] [df4e7c30] [c0613324] __rtc_read_alarm+0x34/0x684
[    5.648503] [df4e7ce0] [c060fe18] rtc_device_register+0x88/0x218
[    5.653804] [df4e7d40] [c061000c] devm_rtc_device_register+0x64/0xc4
[    5.659127] [df4e7d60] [c09d2630] generic_rtc_probe+0x50/0x78
[    5.664457] [df4e7d70] [c055eefc] platform_drv_probe+0xa8/0x128
[    5.669735] [df4e7d90] [c055a780] driver_probe_device+0x354/0x6fc
[    5.674905] [df4e7dd0] [c055acc8] __driver_attach+0x1a0/0x22c
[    5.679971] [df4e7df0] [c05565c8] bus_for_each_dev+0x84/0xdc
[    5.685017] [df4e7e20] [c0558e78] bus_add_driver+0x188/0x348
[    5.690021] [df4e7e40] [c055c20c] driver_register+0xa0/0x18c
[    5.694982] [df4e7e50] [c055f3a8] __platform_driver_probe+0x8c/0x198
[    5.699918] [df4e7e70] [c0005800] do_one_initcall+0x64/0x280
[    5.704726] [df4e7ee0] [c0998bd8] kernel_init_freeable+0x3a4/0x444
[    5.709433] [df4e7f30] [c00049f8] kernel_init+0x24/0x118
[    5.713995] [df4e7f40] [c001b1c4] ret_from_kernel_thread+0x14/0x1c
[    5.718536] Instruction dump:
[    5.723041] 88e1002f 3863404c 88c1002e 88a1002d 8881002c 4809baf1
3d207c25 6129b07f
[    5.727651] 7f9d4840 39200001 409d0008 39200000 <0f090000> 4bffff20
3c60c0c1 7fe4fb78
[    5.732196] ---[ end trace 93a1b37c50fb7a34 ]---
[    5.736768] ================================================================================
[    5.741519] UBSAN: Undefined behaviour in ../drivers/rtc/rtc-lib.c:87:22
[    5.746295] signed integer overflow:
[    5.751002] 1193026 * 3600 cannot be represented in type 'int'
[    5.755739] CPU: 0 PID: 1 Comm: swapper Tainted: G        W
4.17.0+ #8
[    5.760529] Call Trace:
[    5.765124] [df4e7b00] [c04817ec] ubsan_epilogue+0x18/0x4c (unreliable)
[    5.769871] [df4e7b10] [c048218c] handle_overflow+0xbc/0xdc
[    5.774580] [df4e7b90] [c060e27c] rtc_time64_to_tm+0x344/0x388
[    5.779264] [df4e7bd0] [c001076c] rtc_generic_get_time+0x2c/0x40
[    5.783841] [df4e7be0] [c0611fb8] __rtc_read_time+0x70/0x13c
[    5.788395] [df4e7c00] [c06120f0] rtc_read_time+0x6c/0x130
[    5.792929] [df4e7c30] [c0613324] __rtc_read_alarm+0x34/0x684
[    5.797415] [df4e7ce0] [c060fe18] rtc_device_register+0x88/0x218
[    5.801895] [df4e7d40] [c061000c] devm_rtc_device_register+0x64/0xc4
[    5.806395] [df4e7d60] [c09d2630] generic_rtc_probe+0x50/0x78
[    5.810889] [df4e7d70] [c055eefc] platform_drv_probe+0xa8/0x128
[    5.815405] [df4e7d90] [c055a780] driver_probe_device+0x354/0x6fc
[    5.819929] [df4e7dd0] [c055acc8] __driver_attach+0x1a0/0x22c
[    5.824440] [df4e7df0] [c05565c8] bus_for_each_dev+0x84/0xdc
[    5.828922] [df4e7e20] [c0558e78] bus_add_driver+0x188/0x348
[    5.833366] [df4e7e40] [c055c20c] driver_register+0xa0/0x18c
[    5.837789] [df4e7e50] [c055f3a8] __platform_driver_probe+0x8c/0x198
[    5.842244] [df4e7e70] [c0005800] do_one_initcall+0x64/0x280
[    5.846700] [df4e7ee0] [c0998bd8] kernel_init_freeable+0x3a4/0x444
[    5.851186] [df4e7f30] [c00049f8] kernel_init+0x24/0x118
[    5.855656] [df4e7f40] [c001b1c4] ret_from_kernel_thread+0x14/0x1c
[    5.860171] ================================================================================
[    5.864998] device: 'rtc0': device_add



> --
> 2.9.0
>
