Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
 [209.85.218.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411vBw74WhzF35G
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 04:26:48 +1000 (AEST)
Received: by mail-oi0-f54.google.com with SMTP id k190-v6so9503036oib.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Jun 2018 11:26:48 -0700 (PDT)
MIME-Version: 1.0
From: Mathieu Malaterre <malat@debian.org>
Date: Thu, 7 Jun 2018 20:26:33 +0200
Message-ID: <CA+7wUszLF3R3QCgBw2jwLtgLw2C=QnH1jHz6_RUDDouMEmfr9A@mail.gmail.com>
Subject: UBSAN: Undefined behaviour in ../include/linux/percpu_counter.h:137:13
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi there,

I have a reproducible UBSAN appearing in dmesg after a while on my G4
(*). Could anyone suggest a way to diagnose the actual root issue here
(or is it just a false positive) ?

Thanks,

(*)
[41877.514338] ================================================================================
[41877.514364] UBSAN: Undefined behaviour in
../include/linux/percpu_counter.h:137:13
[41877.514373] signed integer overflow:
[41877.514378] 9223352809007201260 + 41997676517838 cannot be
represented in type 'long long int'
[41877.514389] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #54
[41877.514394] Call Trace:
[41877.514411] [dffedd30] [c047a5f8] ubsan_epilogue+0x18/0x4c (unreliable)
[41877.514422] [dffedd40] [c047af98] handle_overflow+0xbc/0xdc
[41877.514437] [dffeddc0] [c043aaa8] cfq_completed_request+0x560/0x1234
[41877.514446] [dffede40] [c03f595c] __blk_put_request+0xb0/0x2dc
[41877.514460] [dffede80] [c05aa41c] scsi_end_request+0x19c/0x344
[41877.514469] [dffedeb0] [c05abba0] scsi_io_completion+0x4b4/0x854
[41877.514482] [dffedf10] [c040604c] blk_done_softirq+0xe4/0x1e0
[41877.514496] [dffedf60] [c07eef84] __do_softirq+0x16c/0x5f0
[41877.514508] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
[41877.514520] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
[41877.514533] [c0ce5e80] [c0009a2c] do_IRQ+0x98/0x1a0
[41877.514541] [c0ce5eb0] [c001b93c] ret_from_except+0x0/0x14
[41877.514549] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
                   LR = arch_cpu_idle+0x30/0x78
[41877.514558] [c0ce5f70] [c0ce4000] 0xc0ce4000 (unreliable)
[41877.514570] [c0ce5f80] [c00a3928] do_idle+0xc4/0x158
[41877.514577] [c0ce5fb0] [c00a3b74] cpu_startup_entry+0x24/0x28
[41877.514585] [c0ce5fc0] [c0988820] start_kernel+0x47c/0x490
[41877.514592] [c0ce5ff0] [00003444] 0x3444
[41877.514597] ================================================================================
[41886.390210] ================================================================================
[41886.390236] UBSAN: Undefined behaviour in
../include/linux/percpu_counter.h:137:13
[41886.390245] signed integer overflow:
[41886.390250] 9223366156262940402 + 42006563339289 cannot be
represented in type 'long long int'
[41886.390260] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #54
[41886.390265] Call Trace:
[41886.390282] [dffedd30] [c047a5f8] ubsan_epilogue+0x18/0x4c (unreliable)
[41886.390293] [dffedd40] [c047af98] handle_overflow+0xbc/0xdc
[41886.390309] [dffeddc0] [c043a8c4] cfq_completed_request+0x37c/0x1234
[41886.390317] [dffede40] [c03f595c] __blk_put_request+0xb0/0x2dc
[41886.390331] [dffede80] [c05aa41c] scsi_end_request+0x19c/0x344
[41886.390340] [dffedeb0] [c05abba0] scsi_io_completion+0x4b4/0x854
[41886.390353] [dffedf10] [c040604c] blk_done_softirq+0xe4/0x1e0
[41886.390367] [dffedf60] [c07eef84] __do_softirq+0x16c/0x5f0
[41886.390379] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
[41886.390391] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
[41886.390404] [c0ce5e80] [c0009a2c] do_IRQ+0x98/0x1a0
[41886.390411] [c0ce5eb0] [c001b93c] ret_from_except+0x0/0x14
[41886.390420] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
                   LR = arch_cpu_idle+0x30/0x78
[41886.390429] [c0ce5f70] [c0ce4000] 0xc0ce4000 (unreliable)
[41886.390441] [c0ce5f80] [c00a3928] do_idle+0xc4/0x158
[41886.390449] [c0ce5fb0] [c00a3b74] cpu_startup_entry+0x24/0x28
[41886.390457] [c0ce5fc0] [c0988820] start_kernel+0x47c/0x490
[41886.390463] [c0ce5ff0] [00003444] 0x3444
[41886.390468] ================================================================================
