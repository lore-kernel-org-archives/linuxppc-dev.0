Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com
 [209.85.218.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 415Kyq4pzCzF0dW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 18:43:15 +1000 (AEST)
Received: by mail-oi0-f66.google.com with SMTP id i205-v6so1594869oib.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2018 01:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7wUszLF3R3QCgBw2jwLtgLw2C=QnH1jHz6_RUDDouMEmfr9A@mail.gmail.com>
 <87in6ntqar.fsf@concordia.ellerman.id.au>
In-Reply-To: <87in6ntqar.fsf@concordia.ellerman.id.au>
From: Mathieu Malaterre <malat@debian.org>
Date: Wed, 13 Jun 2018 10:43:00 +0200
Message-ID: <CA+7wUszwmkdrwr0dB=_Sf2qH49yXcJx-91zZVAa=qjyyANoYqA@mail.gmail.com>
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

On Wed, Jun 13, 2018 at 3:43 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Mathieu Malaterre <malat@debian.org> writes:
>
> > Hi there,
> >
> > I have a reproducible UBSAN appearing in dmesg after a while on my G4
> > (*). Could anyone suggest a way to diagnose the actual root issue here
> > (or is it just a false positive) ?
>
> It looks like a real overflow, I guess the question is why are we seeing it.
>
> The first thing to work out would be what exactly is overflowing.
>
> Is it in here?
>
>         cfqg_stats_update_completion(cfqq->cfqg, rq->start_time_ns,
>                                      rq->io_start_time_ns, rq->cmd_flags);
>
>
> If so that would suggest something is taking multiple hours to complete,
> which seems unlikely. Is time going backward?

There is also something suspicious in the kern.log file:

Jun 12 20:09:04 debian kernel: [    5.504182]
================================================================================
Jun 12 20:09:04 debian kernel: [    5.508945] UBSAN: Undefined
behaviour in ../drivers/rtc/rtc-lib.c:87:22
Jun 12 20:09:04 debian kernel: [    5.513658] signed integer overflow:
Jun 12 20:09:04 debian kernel: [    5.518211] 1193024 * 3600 cannot be
represented in type 'int'
Jun 12 20:09:04 debian kernel: [    5.522866] CPU: 0 PID: 1 Comm:
swapper Not tainted 4.17.0+ #1
Jun 12 20:09:04 debian kernel: [    5.527567] Call Trace:
Jun 12 20:09:04 debian kernel: [    5.532200] [df4e7b00] [c0481074]
ubsan_epilogue+0x18/0x4c (unreliable)
Jun 12 20:09:04 debian kernel: [    5.537019] [df4e7b10] [c0481a14]
handle_overflow+0xbc/0xdc
Jun 12 20:09:04 debian kernel: [    5.541832] [df4e7b90] [c060d698]
rtc_time64_to_tm+0x344/0x388
Jun 12 20:09:04 debian kernel: [    5.546655] [df4e7bd0] [c001076c]
rtc_generic_get_time+0x2c/0x40
Jun 12 20:09:04 debian kernel: [    5.551477] [df4e7be0] [c06113d4]
__rtc_read_time+0x70/0x13c
Jun 12 20:09:04 debian kernel: [    5.556288] [df4e7c00] [c061150c]
rtc_read_time+0x6c/0x130
Jun 12 20:09:04 debian kernel: [    5.561088] [df4e7c30] [c061271c]
__rtc_read_alarm+0x34/0x684
Jun 12 20:09:04 debian kernel: [    5.565884] [df4e7ce0] [c060f234]
rtc_device_register+0x88/0x218
Jun 12 20:09:04 debian kernel: [    5.570695] [df4e7d40] [c060f428]
devm_rtc_device_register+0x64/0xc4
Jun 12 20:09:04 debian kernel: [    5.575528] [df4e7d60] [c09d15d4]
generic_rtc_probe+0x50/0x78
Jun 12 20:09:04 debian kernel: [    5.580359] [df4e7d70] [c055e4a4]
platform_drv_probe+0xa8/0x128
Jun 12 20:09:04 debian kernel: [    5.585210] [df4e7d90] [c0559d28]
driver_probe_device+0x354/0x6fc
Jun 12 20:09:04 debian kernel: [    5.590064] [df4e7dd0] [c055a270]
__driver_attach+0x1a0/0x22c
Jun 12 20:09:04 debian kernel: [    5.594917] [df4e7df0] [c0555b70]
bus_for_each_dev+0x84/0xdc
Jun 12 20:09:04 debian kernel: [    5.599750] [df4e7e20] [c0558420]
bus_add_driver+0x188/0x348
Jun 12 20:09:04 debian kernel: [    5.604584] [df4e7e40] [c055b7b4]
driver_register+0xa0/0x18c
Jun 12 20:09:04 debian kernel: [    5.609433] [df4e7e50] [c055e950]
__platform_driver_probe+0x8c/0x198
Jun 12 20:09:04 debian kernel: [    5.614330] [df4e7e70] [c0005800]
do_one_initcall+0x64/0x280
Jun 12 20:09:04 debian kernel: [    5.619237] [df4e7ee0] [c0997c04]
kernel_init_freeable+0x3a4/0x444
Jun 12 20:09:04 debian kernel: [    5.624145] [df4e7f30] [c00049f8]
kernel_init+0x24/0x118
Jun 12 20:09:04 debian kernel: [    5.629029] [df4e7f40] [c001b1c4]
ret_from_kernel_thread+0x14/0x1c
Jun 12 20:09:04 debian kernel: [    5.633878]
================================================================================


Grep-ing all leads to:

$ grep  "cannot be represented" kern.log | colrm 1 45|sort -u
 1193022 * 3600 cannot be represented in type 'int'
 1193024 * 3600 cannot be represented in type 'int'
 1193032 * 3600 cannot be represented in type 'int'
 1193033 * 3600 cannot be represented in type 'int'
 1193034 * 3600 cannot be represented in type 'int'
 1193035 * 3600 cannot be represented in type 'int'

How come tm_hour can store a value of 1193035 ?

> cheers
>
> > (*)
> > [41877.514338] ================================================================================
> > [41877.514364] UBSAN: Undefined behaviour in
> > ../include/linux/percpu_counter.h:137:13
> > [41877.514373] signed integer overflow:
> > [41877.514378] 9223352809007201260 + 41997676517838 cannot be
> > represented in type 'long long int'
> > [41877.514389] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #54
> > [41877.514394] Call Trace:
> > [41877.514411] [dffedd30] [c047a5f8] ubsan_epilogue+0x18/0x4c (unreliable)
> > [41877.514422] [dffedd40] [c047af98] handle_overflow+0xbc/0xdc
> > [41877.514437] [dffeddc0] [c043aaa8] cfq_completed_request+0x560/0x1234
> > [41877.514446] [dffede40] [c03f595c] __blk_put_request+0xb0/0x2dc
> > [41877.514460] [dffede80] [c05aa41c] scsi_end_request+0x19c/0x344
> > [41877.514469] [dffedeb0] [c05abba0] scsi_io_completion+0x4b4/0x854
> > [41877.514482] [dffedf10] [c040604c] blk_done_softirq+0xe4/0x1e0
> > [41877.514496] [dffedf60] [c07eef84] __do_softirq+0x16c/0x5f0
> > [41877.514508] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
> > [41877.514520] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
> > [41877.514533] [c0ce5e80] [c0009a2c] do_IRQ+0x98/0x1a0
> > [41877.514541] [c0ce5eb0] [c001b93c] ret_from_except+0x0/0x14
> > [41877.514549] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
> >                    LR = arch_cpu_idle+0x30/0x78
> > [41877.514558] [c0ce5f70] [c0ce4000] 0xc0ce4000 (unreliable)
> > [41877.514570] [c0ce5f80] [c00a3928] do_idle+0xc4/0x158
> > [41877.514577] [c0ce5fb0] [c00a3b74] cpu_startup_entry+0x24/0x28
> > [41877.514585] [c0ce5fc0] [c0988820] start_kernel+0x47c/0x490
> > [41877.514592] [c0ce5ff0] [00003444] 0x3444
> > [41877.514597] ================================================================================
> > [41886.390210] ================================================================================
> > [41886.390236] UBSAN: Undefined behaviour in
> > ../include/linux/percpu_counter.h:137:13
> > [41886.390245] signed integer overflow:
> > [41886.390250] 9223366156262940402 + 42006563339289 cannot be
> > represented in type 'long long int'
> > [41886.390260] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #54
> > [41886.390265] Call Trace:
> > [41886.390282] [dffedd30] [c047a5f8] ubsan_epilogue+0x18/0x4c (unreliable)
> > [41886.390293] [dffedd40] [c047af98] handle_overflow+0xbc/0xdc
> > [41886.390309] [dffeddc0] [c043a8c4] cfq_completed_request+0x37c/0x1234
> > [41886.390317] [dffede40] [c03f595c] __blk_put_request+0xb0/0x2dc
> > [41886.390331] [dffede80] [c05aa41c] scsi_end_request+0x19c/0x344
> > [41886.390340] [dffedeb0] [c05abba0] scsi_io_completion+0x4b4/0x854
> > [41886.390353] [dffedf10] [c040604c] blk_done_softirq+0xe4/0x1e0
> > [41886.390367] [dffedf60] [c07eef84] __do_softirq+0x16c/0x5f0
> > [41886.390379] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
> > [41886.390391] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
> > [41886.390404] [c0ce5e80] [c0009a2c] do_IRQ+0x98/0x1a0
> > [41886.390411] [c0ce5eb0] [c001b93c] ret_from_except+0x0/0x14
> > [41886.390420] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
> >                    LR = arch_cpu_idle+0x30/0x78
> > [41886.390429] [c0ce5f70] [c0ce4000] 0xc0ce4000 (unreliable)
> > [41886.390441] [c0ce5f80] [c00a3928] do_idle+0xc4/0x158
> > [41886.390449] [c0ce5fb0] [c00a3b74] cpu_startup_entry+0x24/0x28
> > [41886.390457] [c0ce5fc0] [c0988820] start_kernel+0x47c/0x490
> > [41886.390463] [c0ce5ff0] [00003444] 0x3444
> > [41886.390468] ================================================================================
