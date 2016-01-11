Return-Path: <festevam@gmail.com>
Received: from mail-ig0-x242.google.com (mail-ig0-x242.google.com
 [IPv6:2607:f8b0:4001:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B4E91A0202
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 23:04:44 +1100 (AEDT)
Received: by mail-ig0-x242.google.com with SMTP id o2so12915482iga.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 04:04:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5677107C.60904@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name>
Date: Mon, 11 Jan 2016 10:04:42 -0200
Message-ID: <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
From: Fabio Estevam <festevam@gmail.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Maciej,

On Sun, Dec 20, 2015 at 6:33 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> There is no guarantee that on fsl_ssi module load
> SSI registers will have their power-on-reset values.
>
> In fact, if the driver is reloaded the values in
> registers will be whatever they were set to previously.
>
> This fixes hard lockup on fsl_ssi module reload,
> at least in AC'97 mode.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

This patch causes the following issue in linux-next:

[    2.526984] ------------[ cut here ]------------
[    2.531632] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:2755
lockdep_trace_alloc+0xf4/0x124()
[    2.540771] DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
[    2.546175] Modules linked in:
[    2.549447] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.4.0-rc8-next-20160111 #204
[    2.557021] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[    2.563553] Backtrace:
[    2.566040] [<c00136d8>] (dump_backtrace) from [<c0013874>]
(show_stack+0x18/0x1c)
[    2.573615]  r6:00000ac3 r5:00000000 r4:00000000 r3:00000000
[    2.579362] [<c001385c>] (show_stack) from [<c02de89c>]
(dump_stack+0x88/0xa4)
[    2.586607] [<c02de814>] (dump_stack) from [<c002bcac>]
(warn_slowpath_common+0x80/0xbc)
[    2.594702]  r5:c0071ed0 r4:ef055b90
[    2.598326] [<c002bc2c>] (warn_slowpath_common) from [<c002bd8c>]
(warn_slowpath_fmt+0x38/0x40)
[    2.607028]  r8:00000004 r7:00000004 r6:024080c0 r5:024080c0 r4:60000093
[    2.613829] [<c002bd58>] (warn_slowpath_fmt) from [<c0071ed0>]
(lockdep_trace_alloc+0xf4/0x124)
[    2.622532]  r3:c09a1634 r2:c099dc0c
[    2.626161] [<c0071ddc>] (lockdep_trace_alloc) from [<c010bc0c>]
(kmem_cache_alloc+0x30/0x174)
[    2.634778]  r4:ef001f00 r3:c0b02a88
[    2.638407] [<c010bbdc>] (kmem_cache_alloc) from [<c03edac8>]
(regcache_rbtree_write+0x150/0x724)
[    2.647283]  r10:00000000 r9:00000010 r8:00000004 r7:00000004
r6:0000002c r5:00000000
[    2.655203]  r4:00000000
[    2.657767] [<c03ed978>] (regcache_rbtree_write) from [<c03ec7d8>]
(regcache_write+0x5c/0x64)
[    2.666295]  r10:ef0f1c80 r9:ef0f6500 r8:00000001 r7:ef055cbc
r6:00000010 r5:00000000
[    2.674215]  r4:eeaaf000
[    2.676778] [<c03ec77c>] (regcache_write) from [<c03ea4c0>]
(_regmap_read+0xa8/0xc0)
[    2.684526]  r6:00000000
[    2.685780] mmc2: new DDR MMC card at address 0001
[    2.686495] mmcblk1: mmc2:0001 SEM08G 7.40 GiB
[    2.686792] mmcblk1boot0: mmc2:0001 SEM08G partition 1 2.00 MiB
[    2.687092] mmcblk1boot1: mmc2:0001 SEM08G partition 2 2.00 MiB
[    2.687388] mmcblk1rpmb: mmc2:0001 SEM08G partition 3 128 KiB
[    2.713792]  r5:00000010 r4:eeaaf000 r3:00000000
[    2.718660] [<c03ea418>] (_regmap_read) from [<c03ea51c>]
(regmap_read+0x44/0x64)
[    2.726147]  r7:00001000 r6:ef055cbc r5:00000010 r4:eeaaf000
[    2.731890] [<c03ea4d8>] (regmap_read) from [<c05bbcd8>]
(_fsl_ssi_set_dai_fmt+0xa4/0x440)
[    2.740159]  r6:00001001 r5:eeaaf000 r4:eeaaee10 r3:01400454
[    2.745897] [<c05bbc34>] (_fsl_ssi_set_dai_fmt) from [<c05bc090>]
(fsl_ssi_set_dai_fmt+0x1c/0x20)
[    2.754773]  r10:ef0f1c80 r8:ef118800 r7:00001001 r6:00000000
r5:00000001 r4:ef0f1700
[    2.762706] [<c05bc074>] (fsl_ssi_set_dai_fmt) from [<c059dbe8>]
(snd_soc_runtime_set_dai_fmt+0x104/0x154)
[    2.772375] [<c059dae4>] (snd_soc_runtime_set_dai_fmt) from
[<c05a289c>] (snd_soc_register_card+0xc14/0xdd0)
[    2.782206]  r10:eeaa889c r9:00000002 r8:eeaa8810 r7:ef118800
r6:00000001 r5:00000000
[    2.790126]  r4:ef0f1c80 r3:00000000
[    2.793750] [<c05a1c88>] (snd_soc_register_card) from [<c05ae1f0>]
(devm_snd_soc_register_card+0x38/0x78)
[    2.803321]  r10:ef20b420 r9:00000000 r8:eeaa8810 r7:ef1cf410
r6:eeaa889c r5:ef0f6490
[    2.811240]  r4:eeaa889c
[    2.813806] [<c05ae1b8>] (devm_snd_soc_register_card) from
[<c05c2668>] (imx_wm8962_probe+0x2fc/0x3a0)
[    2.823116]  r7:ef1cf410 r6:eeaa889c r5:c085ad98 r4:ef1cf400
[    2.828858] [<c05c236c>] (imx_wm8962_probe) from [<c03d3f40>]
(platform_drv_probe+0x58/0xb4)
[    2.837300]  r10:00000000 r9:000000de r8:c0b645f4 r7:c0b645f4
r6:fffffdfb r5:ef1cf410
[    2.845220]  r4:fffffffe
[    2.847788] [<c03d3ee8>] (platform_drv_probe) from [<c03d26fc>]
(driver_probe_device+0x1f8/0x2b4)
[    2.856665]  r7:00000000 r6:c1379780 r5:c1379778 r4:ef1cf410
[    2.862405] [<c03d2504>] (driver_probe_device) from [<c03d2854>]
(__driver_attach+0x9c/0xa0)
[    2.870846]  r10:00000000 r8:c0ad7b30 r7:00000000 r6:ef1cf444
r5:c0b645f4 r4:ef1cf410
[    2.878776] [<c03d27b8>] (__driver_attach) from [<c03d0ae8>]
(bus_for_each_dev+0x5c/0x90)
[    2.886956]  r6:c03d27b8 r5:c0b645f4 r4:00000000 r3:ef1b695c
[    2.892695] [<c03d0a8c>] (bus_for_each_dev) from [<c03d1f14>]
(driver_attach+0x20/0x28)
[    2.900703]  r6:c0b2f9f0 r5:ef0f1400 r4:c0b645f4
[    2.905383] [<c03d1ef4>] (driver_attach) from [<c03d1c14>]
(bus_add_driver+0xec/0x1fc)
[    2.913313] [<c03d1b28>] (bus_add_driver) from [<c03d30f8>]
(driver_register+0x80/0xfc)
[    2.921320]  r7:c0ae684c r6:ef0f63c0 r5:c0b06188 r4:c0b645f4
[    2.927059] [<c03d3078>] (driver_register) from [<c03d3dcc>]
(__platform_driver_register+0x38/0x4c)
[    2.936109]  r5:c0b06188 r4:c0b06188
[    2.939733] [<c03d3d94>] (__platform_driver_register) from
[<c0ad7b48>] (imx_wm8962_driver_init+0x18/0x20)
[    2.949398] [<c0ad7b30>] (imx_wm8962_driver_init) from [<c00098dc>]
(do_one_initcall+0x88/0x1e4)
[    2.958200] [<c0009854>] (do_one_initcall) from [<c0a8ce84>]
(kernel_init_freeable+0x11c/0x1f0)
[    2.966902]  r10:c0ae6858 r9:000000de r8:00000000 r7:c0ae684c
r6:c0b6f540 r5:00000006
[    2.974822]  r4:c0af86ec
[    2.977386] [<c0a8cd68>] (kernel_init_freeable) from [<c07c7448>]
(kernel_init+0x10/0xf8)
[    2.985566]  r10:00000000 r9:00000000 r8:00000000 r7:00000000
r6:00000000 r5:c07c7438
[    2.993486]  r4:00000000
[    2.996050] [<c07c7438>] (kernel_init) from [<c000ff30>]
(ret_from_fork+0x14/0x24)
[    3.003624]  r4:00000000 r3:00000000
[    3.007256] ---[ end trace c4f2be75666d4572 ]---
