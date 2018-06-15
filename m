Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 416g0Y6xbwzF1Ld
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2018 22:34:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: UBSAN: Undefined behaviour in
 ../include/linux/percpu_counter.h:137:13
In-Reply-To: <CA+7wUswJcba_Yi63VS5kX+wdbBgsZfkptU0E8J7w3t602bz5sA@mail.gmail.com>
References: <CA+7wUszLF3R3QCgBw2jwLtgLw2C=QnH1jHz6_RUDDouMEmfr9A@mail.gmail.com>
 <87in6ntqar.fsf@concordia.ellerman.id.au>
 <CA+7wUszwmkdrwr0dB=_Sf2qH49yXcJx-91zZVAa=qjyyANoYqA@mail.gmail.com>
 <CA+7wUswJcba_Yi63VS5kX+wdbBgsZfkptU0E8J7w3t602bz5sA@mail.gmail.com>
Date: Fri, 15 Jun 2018 22:34:20 +1000
Message-ID: <87k1r09qk3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mathieu Malaterre <malat@debian.org> writes:
> On Wed, Jun 13, 2018 at 10:43 AM Mathieu Malaterre <malat@debian.org> wrote:
>> On Wed, Jun 13, 2018 at 3:43 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > Mathieu Malaterre <malat@debian.org> writes:
>> > > Hi there,
>> > >
>> > > I have a reproducible UBSAN appearing in dmesg after a while on my G4
>> > > (*). Could anyone suggest a way to diagnose the actual root issue here
>> > > (or is it just a false positive) ?
>> >
>> > It looks like a real overflow, I guess the question is why are we seeing it.
>> >
>> > The first thing to work out would be what exactly is overflowing.
>> >
>> > Is it in here?
>> >
>> >         cfqg_stats_update_completion(cfqq->cfqg, rq->start_time_ns,
>> >                                      rq->io_start_time_ns, rq->cmd_flags);
>> >
>> >
>> > If so that would suggest something is taking multiple hours to complete,
>> > which seems unlikely. Is time going backward?
>>
>> There is also something suspicious in the kern.log file:
>>
>> Jun 12 20:09:04 debian kernel: [    5.504182]
>> ================================================================================
>> Jun 12 20:09:04 debian kernel: [    5.508945] UBSAN: Undefined
>> behaviour in ../drivers/rtc/rtc-lib.c:87:22
>> Jun 12 20:09:04 debian kernel: [    5.513658] signed integer overflow:
>> Jun 12 20:09:04 debian kernel: [    5.518211] 1193024 * 3600 cannot be
>> represented in type 'int'
>> Jun 12 20:09:04 debian kernel: [    5.522866] CPU: 0 PID: 1 Comm:
>> swapper Not tainted 4.17.0+ #1
>> Jun 12 20:09:04 debian kernel: [    5.527567] Call Trace:
>> Jun 12 20:09:04 debian kernel: [    5.532200] [df4e7b00] [c0481074]
>> ubsan_epilogue+0x18/0x4c (unreliable)
>> Jun 12 20:09:04 debian kernel: [    5.537019] [df4e7b10] [c0481a14]
>> handle_overflow+0xbc/0xdc
>> Jun 12 20:09:04 debian kernel: [    5.541832] [df4e7b90] [c060d698]
>> rtc_time64_to_tm+0x344/0x388
>> Jun 12 20:09:04 debian kernel: [    5.546655] [df4e7bd0] [c001076c]
>> rtc_generic_get_time+0x2c/0x40
>> Jun 12 20:09:04 debian kernel: [    5.551477] [df4e7be0] [c06113d4]
>> __rtc_read_time+0x70/0x13c
>> Jun 12 20:09:04 debian kernel: [    5.556288] [df4e7c00] [c061150c]
>> rtc_read_time+0x6c/0x130
>> Jun 12 20:09:04 debian kernel: [    5.561088] [df4e7c30] [c061271c]
>> __rtc_read_alarm+0x34/0x684
>> Jun 12 20:09:04 debian kernel: [    5.565884] [df4e7ce0] [c060f234]
>> rtc_device_register+0x88/0x218
>> Jun 12 20:09:04 debian kernel: [    5.570695] [df4e7d40] [c060f428]
>> devm_rtc_device_register+0x64/0xc4
>> Jun 12 20:09:04 debian kernel: [    5.575528] [df4e7d60] [c09d15d4]
>> generic_rtc_probe+0x50/0x78
>> Jun 12 20:09:04 debian kernel: [    5.580359] [df4e7d70] [c055e4a4]
>> platform_drv_probe+0xa8/0x128
>> Jun 12 20:09:04 debian kernel: [    5.585210] [df4e7d90] [c0559d28]
>> driver_probe_device+0x354/0x6fc
>> Jun 12 20:09:04 debian kernel: [    5.590064] [df4e7dd0] [c055a270]
>> __driver_attach+0x1a0/0x22c
>> Jun 12 20:09:04 debian kernel: [    5.594917] [df4e7df0] [c0555b70]
>> bus_for_each_dev+0x84/0xdc
>> Jun 12 20:09:04 debian kernel: [    5.599750] [df4e7e20] [c0558420]
>> bus_add_driver+0x188/0x348
>> Jun 12 20:09:04 debian kernel: [    5.604584] [df4e7e40] [c055b7b4]
>> driver_register+0xa0/0x18c
>> Jun 12 20:09:04 debian kernel: [    5.609433] [df4e7e50] [c055e950]
>> __platform_driver_probe+0x8c/0x198
>> Jun 12 20:09:04 debian kernel: [    5.614330] [df4e7e70] [c0005800]
>> do_one_initcall+0x64/0x280
>> Jun 12 20:09:04 debian kernel: [    5.619237] [df4e7ee0] [c0997c04]
>> kernel_init_freeable+0x3a4/0x444
>> Jun 12 20:09:04 debian kernel: [    5.624145] [df4e7f30] [c00049f8]
>> kernel_init+0x24/0x118
>> Jun 12 20:09:04 debian kernel: [    5.629029] [df4e7f40] [c001b1c4]
>> ret_from_kernel_thread+0x14/0x1c
>> Jun 12 20:09:04 debian kernel: [    5.633878]
>> ================================================================================
>>
>>
>> Grep-ing all leads to:
>>
>> $ grep  "cannot be represented" kern.log | colrm 1 45|sort -u
>>  1193022 * 3600 cannot be represented in type 'int'
>>  1193024 * 3600 cannot be represented in type 'int'
>>  1193032 * 3600 cannot be represented in type 'int'
>>  1193033 * 3600 cannot be represented in type 'int'
>>  1193034 * 3600 cannot be represented in type 'int'
>>  1193035 * 3600 cannot be represented in type 'int'
>>
>> How come tm_hour can store a value of 1193035 ?
>
> It appears that I am getting a negative value for  time64_t :

That sounds bad :)

Thanks for tracking it down.

cheers
