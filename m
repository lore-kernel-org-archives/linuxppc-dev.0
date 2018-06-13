Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com
 [209.85.218.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415PxG5tCtzDr9J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 21:42:10 +1000 (AEST)
Received: by mail-oi0-f68.google.com with SMTP id 188-v6so1978146oid.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 04:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUszLF3R3QCgBw2jwLtgLw2C=QnH1jHz6_RUDDouMEmfr9A@mail.gmail.com>
 <87in6ntqar.fsf@concordia.ellerman.id.au>
 <CA+7wUszwmkdrwr0dB=_Sf2qH49yXcJx-91zZVAa=qjyyANoYqA@mail.gmail.com>
In-Reply-To: <CA+7wUszwmkdrwr0dB=_Sf2qH49yXcJx-91zZVAa=qjyyANoYqA@mail.gmail.com>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 Jun 2018 13:41:56 +0200
Message-ID: <CA+7wUswJcba_Yi63VS5kX+wdbBgsZfkptU0E8J7w3t602bz5sA@mail.gmail.com>
Subject: Re: UBSAN: Undefined behaviour in
 ../include/linux/percpu_counter.h:137:13
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2018 at 10:43 AM Mathieu Malaterre <malat@debian.org> wrote:
>
> On Wed, Jun 13, 2018 at 3:43 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Mathieu Malaterre <malat@debian.org> writes:
> >
> > > Hi there,
> > >
> > > I have a reproducible UBSAN appearing in dmesg after a while on my G4
> > > (*). Could anyone suggest a way to diagnose the actual root issue here
> > > (or is it just a false positive) ?
> >
> > It looks like a real overflow, I guess the question is why are we seeing it.
> >
> > The first thing to work out would be what exactly is overflowing.
> >
> > Is it in here?
> >
> >         cfqg_stats_update_completion(cfqq->cfqg, rq->start_time_ns,
> >                                      rq->io_start_time_ns, rq->cmd_flags);
> >
> >
> > If so that would suggest something is taking multiple hours to complete,
> > which seems unlikely. Is time going backward?
>
> There is also something suspicious in the kern.log file:
>
> Jun 12 20:09:04 debian kernel: [    5.504182]
> ================================================================================
> Jun 12 20:09:04 debian kernel: [    5.508945] UBSAN: Undefined
> behaviour in ../drivers/rtc/rtc-lib.c:87:22
> Jun 12 20:09:04 debian kernel: [    5.513658] signed integer overflow:
> Jun 12 20:09:04 debian kernel: [    5.518211] 1193024 * 3600 cannot be
> represented in type 'int'
> Jun 12 20:09:04 debian kernel: [    5.522866] CPU: 0 PID: 1 Comm:
> swapper Not tainted 4.17.0+ #1
> Jun 12 20:09:04 debian kernel: [    5.527567] Call Trace:
> Jun 12 20:09:04 debian kernel: [    5.532200] [df4e7b00] [c0481074]
> ubsan_epilogue+0x18/0x4c (unreliable)
> Jun 12 20:09:04 debian kernel: [    5.537019] [df4e7b10] [c0481a14]
> handle_overflow+0xbc/0xdc
> Jun 12 20:09:04 debian kernel: [    5.541832] [df4e7b90] [c060d698]
> rtc_time64_to_tm+0x344/0x388
> Jun 12 20:09:04 debian kernel: [    5.546655] [df4e7bd0] [c001076c]
> rtc_generic_get_time+0x2c/0x40
> Jun 12 20:09:04 debian kernel: [    5.551477] [df4e7be0] [c06113d4]
> __rtc_read_time+0x70/0x13c
> Jun 12 20:09:04 debian kernel: [    5.556288] [df4e7c00] [c061150c]
> rtc_read_time+0x6c/0x130
> Jun 12 20:09:04 debian kernel: [    5.561088] [df4e7c30] [c061271c]
> __rtc_read_alarm+0x34/0x684
> Jun 12 20:09:04 debian kernel: [    5.565884] [df4e7ce0] [c060f234]
> rtc_device_register+0x88/0x218
> Jun 12 20:09:04 debian kernel: [    5.570695] [df4e7d40] [c060f428]
> devm_rtc_device_register+0x64/0xc4
> Jun 12 20:09:04 debian kernel: [    5.575528] [df4e7d60] [c09d15d4]
> generic_rtc_probe+0x50/0x78
> Jun 12 20:09:04 debian kernel: [    5.580359] [df4e7d70] [c055e4a4]
> platform_drv_probe+0xa8/0x128
> Jun 12 20:09:04 debian kernel: [    5.585210] [df4e7d90] [c0559d28]
> driver_probe_device+0x354/0x6fc
> Jun 12 20:09:04 debian kernel: [    5.590064] [df4e7dd0] [c055a270]
> __driver_attach+0x1a0/0x22c
> Jun 12 20:09:04 debian kernel: [    5.594917] [df4e7df0] [c0555b70]
> bus_for_each_dev+0x84/0xdc
> Jun 12 20:09:04 debian kernel: [    5.599750] [df4e7e20] [c0558420]
> bus_add_driver+0x188/0x348
> Jun 12 20:09:04 debian kernel: [    5.604584] [df4e7e40] [c055b7b4]
> driver_register+0xa0/0x18c
> Jun 12 20:09:04 debian kernel: [    5.609433] [df4e7e50] [c055e950]
> __platform_driver_probe+0x8c/0x198
> Jun 12 20:09:04 debian kernel: [    5.614330] [df4e7e70] [c0005800]
> do_one_initcall+0x64/0x280
> Jun 12 20:09:04 debian kernel: [    5.619237] [df4e7ee0] [c0997c04]
> kernel_init_freeable+0x3a4/0x444
> Jun 12 20:09:04 debian kernel: [    5.624145] [df4e7f30] [c00049f8]
> kernel_init+0x24/0x118
> Jun 12 20:09:04 debian kernel: [    5.629029] [df4e7f40] [c001b1c4]
> ret_from_kernel_thread+0x14/0x1c
> Jun 12 20:09:04 debian kernel: [    5.633878]
> ================================================================================
>
>
> Grep-ing all leads to:
>
> $ grep  "cannot be represented" kern.log | colrm 1 45|sort -u
>  1193022 * 3600 cannot be represented in type 'int'
>  1193024 * 3600 cannot be represented in type 'int'
>  1193032 * 3600 cannot be represented in type 'int'
>  1193033 * 3600 cannot be represented in type 'int'
>  1193034 * 3600 cannot be represented in type 'int'
>  1193035 * 3600 cannot be represented in type 'int'
>
> How come tm_hour can store a value of 1193035 ?

It appears that I am getting a negative value for  time64_t :

[    5.495470] devices_kset: Moving rtc-generic to end of list
[    5.502584]  mm DBG: TIME64_T -2068738348
[    5.507205] WARNING: CPU: 0 PID: 1 at ../drivers/rtc/rtc-lib.c:60
rtc_time64_to_tm+0x48/0x38c
[    5.511843] Modules linked in:
[    5.516306] CPU: 0 PID: 1 Comm: swapper Not tainted 4.17.0+ #6
[    5.520879] NIP:  c060d498 LR: c060d494 CTR: c00d49dc
[    5.525467] REGS: df4e7ad0 TRAP: 0700   Not tainted  (4.17.0+)
[    5.530115] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 88008282  XER: 00000000
[    5.534865]
               GPR00: c060d494 df4e7b80 df4e8000 00000019 00000001
0000032e 00000400 00000000
               GPR08: 00000003 00000001 c0aa4b38 00000000 24008882
00000000 c09dfc4c c09dfc28
               GPR16: 00000690 c0aedc6c c0aee7f8 c0aed13c 00000054
c0ae75cc c0aea2a4 00000000
               GPR24: c0d70000 c0a85850 df4e7c5c df4e7c5c df4e7ce8
de519040 df4e7c5c ffffffff
[    5.559346] NIP [c060d498] rtc_time64_to_tm+0x48/0x38c
[    5.564356] LR [c060d494] rtc_time64_to_tm+0x44/0x38c
[    5.569382] Call Trace:
[    5.574354] [df4e7b80] [c060d494] rtc_time64_to_tm+0x44/0x38c (unreliable)
[    5.579525] [df4e7bd0] [c001076c] rtc_generic_get_time+0x2c/0x40
[    5.584689] [df4e7be0] [c06114d4] __rtc_read_time+0x70/0x13c
[    5.589845] [df4e7c00] [c061160c] rtc_read_time+0x6c/0x130
[    5.594993] [df4e7c30] [c061281c] __rtc_read_alarm+0x34/0x684
[    5.600151] [df4e7ce0] [c060f334] rtc_device_register+0x88/0x218
[    5.605343] [df4e7d40] [c060f528] devm_rtc_device_register+0x64/0xc4
[    5.610584] [df4e7d60] [c09d25a8] generic_rtc_probe+0x50/0x78
[    5.615833] [df4e7d70] [c055e5a0] platform_drv_probe+0xa8/0x128
[    5.621106] [df4e7d90] [c0559e24] driver_probe_device+0x354/0x6fc
[    5.626387] [df4e7dd0] [c055a36c] __driver_attach+0x1a0/0x22c
[    5.631663] [df4e7df0] [c0555c6c] bus_for_each_dev+0x84/0xdc
[    5.636853] [df4e7e20] [c055851c] bus_add_driver+0x188/0x348
[    5.641906] [df4e7e40] [c055b8b0] driver_register+0xa0/0x18c
[    5.646850] [df4e7e50] [c055ea4c] __platform_driver_probe+0x8c/0x198
[    5.651841] [df4e7e70] [c0005800] do_one_initcall+0x64/0x280
[    5.656805] [df4e7ee0] [c0998bd8] kernel_init_freeable+0x3a4/0x444
[    5.661752] [df4e7f30] [c00049f8] kernel_init+0x24/0x118
[    5.666596] [df4e7f40] [c001b1c4] ret_from_kernel_thread+0x14/0x1c
[    5.671348] Instruction dump:
[    5.675944] 90010054 bf010030 9181002c 7c7f1b78 7cba2b78 90810018
7c651b78 3c60c093
[    5.680655] 7c862378 38636340 4bac3c1d 57e90ffe <0f090000> 3ca00001
80810018 7fe3fb78
[    5.685436] ---[ end trace 57955f2c4e7598fd ]---
[    5.690118]  mm DBG: SECS 4294904148
[    5.694648]  mm DBG: HOUR 1193028


> > cheers
> >
> > > (*)
> > > [41877.514338] ================================================================================
> > > [41877.514364] UBSAN: Undefined behaviour in
> > > ../include/linux/percpu_counter.h:137:13
> > > [41877.514373] signed integer overflow:
> > > [41877.514378] 9223352809007201260 + 41997676517838 cannot be
> > > represented in type 'long long int'
> > > [41877.514389] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #54
> > > [41877.514394] Call Trace:
> > > [41877.514411] [dffedd30] [c047a5f8] ubsan_epilogue+0x18/0x4c (unreliable)
> > > [41877.514422] [dffedd40] [c047af98] handle_overflow+0xbc/0xdc
> > > [41877.514437] [dffeddc0] [c043aaa8] cfq_completed_request+0x560/0x1234
> > > [41877.514446] [dffede40] [c03f595c] __blk_put_request+0xb0/0x2dc
> > > [41877.514460] [dffede80] [c05aa41c] scsi_end_request+0x19c/0x344
> > > [41877.514469] [dffedeb0] [c05abba0] scsi_io_completion+0x4b4/0x854
> > > [41877.514482] [dffedf10] [c040604c] blk_done_softirq+0xe4/0x1e0
> > > [41877.514496] [dffedf60] [c07eef84] __do_softirq+0x16c/0x5f0
> > > [41877.514508] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
> > > [41877.514520] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
> > > [41877.514533] [c0ce5e80] [c0009a2c] do_IRQ+0x98/0x1a0
> > > [41877.514541] [c0ce5eb0] [c001b93c] ret_from_except+0x0/0x14
> > > [41877.514549] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
> > >                    LR = arch_cpu_idle+0x30/0x78
> > > [41877.514558] [c0ce5f70] [c0ce4000] 0xc0ce4000 (unreliable)
> > > [41877.514570] [c0ce5f80] [c00a3928] do_idle+0xc4/0x158
> > > [41877.514577] [c0ce5fb0] [c00a3b74] cpu_startup_entry+0x24/0x28
> > > [41877.514585] [c0ce5fc0] [c0988820] start_kernel+0x47c/0x490
> > > [41877.514592] [c0ce5ff0] [00003444] 0x3444
> > > [41877.514597] ================================================================================
> > > [41886.390210] ================================================================================
> > > [41886.390236] UBSAN: Undefined behaviour in
> > > ../include/linux/percpu_counter.h:137:13
> > > [41886.390245] signed integer overflow:
> > > [41886.390250] 9223366156262940402 + 42006563339289 cannot be
> > > represented in type 'long long int'
> > > [41886.390260] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #54
> > > [41886.390265] Call Trace:
> > > [41886.390282] [dffedd30] [c047a5f8] ubsan_epilogue+0x18/0x4c (unreliable)
> > > [41886.390293] [dffedd40] [c047af98] handle_overflow+0xbc/0xdc
> > > [41886.390309] [dffeddc0] [c043a8c4] cfq_completed_request+0x37c/0x1234
> > > [41886.390317] [dffede40] [c03f595c] __blk_put_request+0xb0/0x2dc
> > > [41886.390331] [dffede80] [c05aa41c] scsi_end_request+0x19c/0x344
> > > [41886.390340] [dffedeb0] [c05abba0] scsi_io_completion+0x4b4/0x854
> > > [41886.390353] [dffedf10] [c040604c] blk_done_softirq+0xe4/0x1e0
> > > [41886.390367] [dffedf60] [c07eef84] __do_softirq+0x16c/0x5f0
> > > [41886.390379] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
> > > [41886.390391] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
> > > [41886.390404] [c0ce5e80] [c0009a2c] do_IRQ+0x98/0x1a0
> > > [41886.390411] [c0ce5eb0] [c001b93c] ret_from_except+0x0/0x14
> > > [41886.390420] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
> > >                    LR = arch_cpu_idle+0x30/0x78
> > > [41886.390429] [c0ce5f70] [c0ce4000] 0xc0ce4000 (unreliable)
> > > [41886.390441] [c0ce5f80] [c00a3928] do_idle+0xc4/0x158
> > > [41886.390449] [c0ce5fb0] [c00a3b74] cpu_startup_entry+0x24/0x28
> > > [41886.390457] [c0ce5fc0] [c0988820] start_kernel+0x47c/0x490
> > > [41886.390463] [c0ce5ff0] [00003444] 0x3444
> > > [41886.390468] ================================================================================
