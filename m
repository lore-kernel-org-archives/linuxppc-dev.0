Return-Path: <zwisler@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vCY4B585gzDq9d
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 04:22:50 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id e137so19690926itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 09:22:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485863317.4498.2.camel@gmx.de>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
 <1485863317.4498.2.camel@gmx.de>
From: Ross Zwisler <zwisler@gmail.com>
Date: Tue, 31 Jan 2017 10:22:47 -0700
Message-ID: <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
To: Mike Galbraith <efault@gmx.de>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 peterz@infradead.org,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 31, 2017 at 4:48 AM, Mike Galbraith <efault@gmx.de> wrote:
> On Tue, 2017-01-31 at 16:30 +0530, Sachin Sant wrote:
>> Trimming the cc list.
>>
>> > > I assume I should be worried?
>> >
>> > Thanks for the report. No need to worry, the bug has existed for a
>> > while, this patch just turns on the warning ;-)
>> >
>> > The following commit queued up in tip/sched/core should fix your
>> > issues (assuming you see the same callstack on all your powerpc
>> > machines):
>> >
>> >  https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=3D=
sched/core&id=3D1b1d62254df0fe42a711eb71948f915918987790
>>
>> I still see this warning with today=E2=80=99s next running inside PowerV=
M LPAR
>> on a POWER8 box. The stack trace is different from what Michael had
>> reported.
>>
>> Easiest way to recreate this is to Online/offline cpu=E2=80=99s.
>
> (Ditto tip.today, x86_64 + hotplug stress)
<>

I'm also seeing a splat in the mmots tree with
v4.10-rc5-mmots-2017-01-26-15-49, which pulled in this commit by
merging with next.  Just booting on an x86_64 VM gives me this:

[   13.090436] ------------[ cut here ]------------
[   13.090577] WARNING: CPU: 8 PID: 1 at kernel/sched/sched.h:804
update_load_avg+0x85b/0xb80
[   13.090577] rq->clock_update_flags < RQCF_ACT_SKIP
[   13.090578] Modules linked in: dax_pmem dax nd_pmem nd_btt nd_e820 libnv=
dimm
[   13.090582] CPU: 8 PID: 1 Comm: systemd Not tainted
4.10.0-rc5-mm1-00313-g5c0c3d7-dirty #10
[   13.090583] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.9.1-0-gb3ef39f-prebuilt.qemu-project.org 04/01/2014
[   13.090583] Call Trace:
[   13.090585]  dump_stack+0x86/0xc3
[   13.090586]  __warn+0xcb/0xf0
[   13.090588]  warn_slowpath_fmt+0x5f/0x80
[   13.090590]  update_load_avg+0x85b/0xb80
[   13.090591]  ? debug_smp_processor_id+0x17/0x20
[   13.090593]  detach_task_cfs_rq+0x3f/0x210
[   13.090594]  task_change_group_fair+0x24/0x100
[   13.090596]  sched_change_group+0x5f/0x110
[   13.090597]  sched_move_task+0x53/0x160
[   13.090598]  cpu_cgroup_attach+0x36/0x70
[   13.090600]  cgroup_migrate_execute+0x230/0x3f0
[   13.090602]  cgroup_migrate+0xce/0x140
[   13.090603]  ? cgroup_migrate+0x5/0x140
[   13.090604]  cgroup_attach_task+0x27f/0x3e0
[   13.090606]  ? cgroup_attach_task+0x9b/0x3e0
[   13.090608]  __cgroup_procs_write+0x30e/0x510
[   13.090608]  ? __cgroup_procs_write+0x70/0x510
[   13.090610]  cgroup_procs_write+0x14/0x20
[   13.090611]  cgroup_file_write+0x44/0x1e0
[   13.090613]  kernfs_fop_write+0x13c/0x1c0
[   13.090614]  __vfs_write+0x37/0x160
[   13.090615]  ? rcu_read_lock_sched_held+0x4a/0x80
[   13.090616]  ? rcu_sync_lockdep_assert+0x2f/0x60
[   13.090617]  ? __sb_start_write+0x10d/0x220
[   13.090618]  ? vfs_write+0x19b/0x1f0
[   13.090619]  ? security_file_permission+0x3b/0xc0
[   13.090620]  vfs_write+0xcb/0x1f0
[   13.090621]  SyS_write+0x58/0xc0
[   13.090623]  entry_SYSCALL_64_fastpath+0x1f/0xc2
[   13.090623] RIP: 0033:0x7f8b7c1be210
[   13.090624] RSP: 002b:00007ffe73febfd8 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   13.090625] RAX: ffffffffffffffda RBX: 000055a84870a7e0 RCX: 00007f8b7c1=
be210
[   13.090625] RDX: 0000000000000004 RSI: 000055a84870aa10 RDI: 00000000000=
00033
[   13.090626] RBP: 0000000000000000 R08: 000055a84870a8c0 R09: 00007f8b7db=
da900
[   13.090627] R10: 000055a84870aa10 R11: 0000000000000246 R12: 00000000000=
00000
[   13.090627] R13: 000055a848775360 R14: 000055a84870a7e0 R15: 00000000000=
00033
[   13.090629] ---[ end trace ba535936c2409043 ]---
