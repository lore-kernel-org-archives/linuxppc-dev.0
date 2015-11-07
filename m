Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x241.google.com (mail-yk0-x241.google.com
 [IPv6:2607:f8b0:4002:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1E1641A0D58
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Nov 2015 00:01:30 +1100 (AEDT)
Received: by ykek133 with SMTP id k133so19126293yke.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Nov 2015 05:01:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJFZqHzHQ1oH3uNeVQqLPXcff62FUeDdiz+DD2MN43xE=Qowvw@mail.gmail.com>
References: <CAJFZqHzHQ1oH3uNeVQqLPXcff62FUeDdiz+DD2MN43xE=Qowvw@mail.gmail.com>
Date: Sat, 7 Nov 2015 16:01:27 +0300
Message-ID: <CAOJe8K1O1ymO1Tpq6ygEMVB7ppnO8dAOb_+uhftB1_yHf-Y=Kg@mail.gmail.com>
Subject: Re: DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Li RongQing <roy.qing.li@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/7/15, Li RongQing <roy.qing.li@gmail.com> wrote:
> Does Anyone see this calltrace?  I see it from 3.19 to 4.3, did not
> test it on other older release.

http://www.gossamer-threads.com/lists/linux/kernel/2297694

>
>
> EXT4-fs (hda): recovery complete
> EXT4-fs (hda): mounted filesystem with ordered data mode. Opts: (null)
> VFS: Mounted root (ext4 filesystem) on device 3:0.
> devtmpfs: mounted
> Freeing unused kernel memory: 728K (c0924000 - c09da000)
> DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
> ------------[ cut here ]------------
> WARNING: at
> /buildarea1/lirq/wrlinux-8.0/qemuppc/bitbake_build/tmp/work-shared/qemuppc/kernel-source/kernel/locking/lockdep.c:3523
> Modules linked in:
> CPU: 0 PID: 1 Comm: sh Not tainted 4.3.0-rc4-WR8.0.0.0_standard #29
> task: c7928000 ti: c78ea000 task.ti: c78ea000
> NIP: c0071a60 LR: c0071a60 CTR: c04917c4
> REGS: c78ebe00 TRAP: 0700 Not tainted (4.3.0-rc4-WR8.0.0.0_standard)
> MSR: 00021032 <ME,IR,DR,RI> CR: 24000484 XER: 20000000
>
> GPR00: c0071a60 c78ebeb0 c7928000 0000002f 00000001 c007ccc8 00000000
> 00000001
> GPR08: 00000000 00000000 c78ea000 00000000 0000015f 00000000 00000000
> 00000000
> GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 00000000
> GPR24: 00000000 00000000 c0716708 00000000 b7df9000 00000000 00009032
> c0a60000
> NIP [c0071a60] check_flags.part.24+0x19c/0x1c0
> LR [c0071a60] check_flags.part.24+0x19c/0x1c0
> Call Trace:
> [c78ebeb0] [c0071a60] check_flags.part.24+0x19c/0x1c0 (unreliable)
> [c78ebec0] [c0072524] lock_is_held+0x74/0xac
> [c78ebed0] [c0085834] rcu_read_lock_sched_held+0xb0/0xbc
> [c78ebee0] [c008af5c] rcu_note_context_switch+0x398/0x4a8
> [c78ebf00] [c0715bd4] __schedule+0x34/0xab0
> [c78ebf30] [c0716708] schedule+0x44/0xb4
> [c78ebf40] [c0012f88] recheck+0x0/0x20
> --- interrupt: 901 at 0xb7dfecd8
> LR = 0xb7dfeb2c
> Instruction dump:
> 3c80c087 3c60c087 38844aac 3863c028 486affd9 0fe00000 4bfffec8 3c80c087
> 3c60c087 38844a90 3863c028 486affbd <0fe00000> 4bfffefc 3c80c087 3c60c087
> ---[ end trace 7d8f06d0df708599 ]---
> possible reason: unannotated irqs-on.
> irq event stamp: 650326
> hardirqs last enabled at (650324): [<c0089a98>]
> rcu_process_callbacks+0x4e4/0x8d4
> hardirqs last disabled at (650325): [<c0034388>] __do_softirq+0x40c/0x570
> softirqs last enabled at (650326): [<c0034400>] __do_softirq+0x484/0x570
> softirqs last disabled at (650277): [<c0034764>] irq_exit+0xe0/0xec
>
