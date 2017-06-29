Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wyz0S42m0zDr26
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 22:06:32 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Eryu Guan <eguan@redhat.com>, tj@kernel.org
Cc: Balbir Singh <bsingharora@gmail.com>, liwan@redhat.com,
 "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>
Subject: kworker with empty task->cpus_allowed (was Re: [v4.12-rc1 regression]
 mount ext4 fs results in kernel crash on PPC64le host)
In-Reply-To: <20170629113933.GT23360@eguan.usersys.redhat.com>
References: <20170628083237.GF23360@eguan.usersys.redhat.com>
 <CAKTCnzncEoCC4=p2_ySpNdB6229SbCCqjDCzfpf8XA0xvvzH1g@mail.gmail.com>
 <20170629034122.GI23360@eguan.usersys.redhat.com>
 <CAKTCnzk8VMN0hBi24vEoNPGvvX-s8uhrjMdn7drQVDUdfA_+Ow@mail.gmail.com>
 <20170629100533.GQ23360@eguan.usersys.redhat.com>
 <87efu39he0.fsf@concordia.ellerman.id.au>
 <20170629113933.GT23360@eguan.usersys.redhat.com>
Date: Thu, 29 Jun 2017 22:06:31 +1000
Message-ID: <878tkb9ewo.fsf@concordia.ellerman.id.au>
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

Eryu Guan <eguan@redhat.com> writes:

> On Thu, Jun 29, 2017 at 09:12:55PM +1000, Michael Ellerman wrote:
>> Eryu Guan <eguan@redhat.com> writes:
>> 
>> > On Thu, Jun 29, 2017 at 06:47:50PM +1000, Balbir Singh wrote:
>> >> On Thu, Jun 29, 2017 at 1:41 PM, Eryu Guan <eguan@redhat.com> wrote:
>> >> > On Thu, Jun 29, 2017 at 03:16:10AM +1000, Balbir Singh wrote:
>> >> >> On Wed, Jun 28, 2017 at 6:32 PM, Eryu Guan <eguan@redhat.com> wrote:
>> >> <snip>
>> >> >> Thanks for the excellent bug report, I am a little lost on the stack
>> >> >> trace, it shows a bad page access that we think is triggered by the
>> >> >> mmap changes? The patch changed the return type to integrate the call
>> >> >> into trace-cmd. Could you point me to the tests that can help
>> >> >> reproduce the crash. Could you also suggest how long to try the test
>> >> >> cases for?
>> >> >
>> >> > Sorry, I should have provided it in the first place. It's as simple as
>> >> > mounting an ext4 filesystem on my test ppc64le host, i.e.
>> >> >
>> >> > mkdir -p /mnt/ext4
>> >> > mkfs -t ext4 -F /dev/sda5
>> >> > mount /dev/sda5 /mnt/ext4
>> >> 
>> >> I tried this test a few times with the kernel and could not reproduce it.
>> >> Could you please share the config and compiler details, I'll retry with -rc7.
>> >> 
>> >> In the meanwhile, does enabling kmemleak, DEBUG_PAGE_ALLOC,
>> >> slub/slab debug, list corruption, etc catch anything at the time of the
>> >> corruption?
>> >
>> > Testing with debug kernel (config file attached) didn't trigger kernel
>> > crash, but only warnings
>> 
>> But the warning says try_to_wake_up() is using a CPU number that's out
>> of bounds, which means when you lookup the runqueue for that CPU you
>> just get junk, and that's what was triggering the crash in your previous
>> report.
>> 
>> So at least that part of the mystery is solved.
>> 
>> > [   99.686770] ------------[ cut here ]------------
>> > [   99.686868] WARNING: CPU: 1 PID: 2272 at ./include/linux/cpumask.h:121 try_to_wake_up+0x17c/0x8f0
>> 
>> static inline unsigned int cpumask_check(unsigned int cpu)
>> {
>> #ifdef CONFIG_DEBUG_PER_CPU_MAPS
>> 	WARN_ON_ONCE(cpu >= nr_cpumask_bits);
>> #endif /* CONFIG_DEBUG_PER_CPU_MAPS */
>> 	return cpu;
>> }
>> 
>> > [   99.686873] Modules linked in: ext4 jbd2 mbcache sg pseries_rng ghash_generic gf128mul xts vmx_crypto nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod ibmvscsi ibmveth scsi_transport_srp
>> > [   99.686950] CPU: 1 PID: 2272 Comm: mount Not tainted 4.12.0-rc7.debug #28
>> > [   99.686955] task: c0000003f00b7b00 task.stack: c0000003f25e0000
>> > [   99.686959] NIP: c0000000001359ec LR: c000000000135ed4 CTR: c00000000016f940
>> > [   99.686964] REGS: c0000003f25e3420 TRAP: 0700   Not tainted  (4.12.0-rc7.debug)
>> > [   99.686968] MSR: 800000010282b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>
>> > [   99.686994]   CR: 28028822  XER: 00000001
>> > [   99.687000] CFAR: c000000000135cb4 SOFTE: 0
>> > [   99.687000] GPR00: c000000000135da0 c0000003f25e36a0 c000000001751800 00000000000000a0
>> > [   99.687000] GPR04: 00000000000000a0 00000000000000c0 0000000000000000 0000000000000000
>> > [   99.687000] GPR08: ffffffffffffffff 00000000000000a0 0000000000000000 00000000000041e0
>> > [   99.687000] GPR12: 0000000000008800 c00000000fac0a80 0000000000000002 c0000003fd20b000
>> > [   99.687000] GPR16: c0000003cabb0400 0000000000000000 0000000000000000 0000000000000002
>> > [   99.687000] GPR20: 0000000000000000 c0000003f7a59d60 c000000001326300 c000000001795d00
>> > [   99.687000] GPR24: c000000001799d48 0000000000000000 c00000000179a294 c0000003ec786be8
>> > [   99.687000] GPR28: 0000000000000000 c0000003ec786680 00000000000000a0 c0000003ec786300
>> > [   99.687083] NIP [c0000000001359ec] try_to_wake_up+0x17c/0x8f0
>> > [   99.687088] LR [c000000000135ed4] try_to_wake_up+0x664/0x8f0
>> > [   99.687092] Call Trace:
>> > [   99.687095] [c0000003f25e36a0] [c000000000135da0] try_to_wake_up+0x530/0x8f0 (unreliable)
>> > [   99.687104] [c0000003f25e3730] [c000000000114ea8] create_worker+0x148/0x220
>> > [   99.687110] [c0000003f25e37d0] [c00000000011a418] alloc_unbound_pwq+0x4c8/0x620
>> > [   99.687117] [c0000003f25e3830] [c00000000011a9c4] apply_wqattrs_prepare+0x1f4/0x340
>> > [   99.687123] [c0000003f25e38a0] [c00000000011ab4c] apply_workqueue_attrs_locked+0x3c/0xa0
>> > [   99.687130] [c0000003f25e38d0] [c00000000011b094] apply_workqueue_attrs+0x54/0x90
>> > [   99.687137] [c0000003f25e3910] [c00000000011d674] __alloc_workqueue_key+0x184/0x5b0
>> 
>> We had a similar bug a few months back, caused by task->cpus_allowed
>> being fubar.
>> 
>> This looks similar, but different.
>> 
>> Can you try this debug patch? It might get us one step closer to the culprit.
>
> [   69.039219] select_task_rq: CPU 160 out of range for task c0000003f0772780 (kworker/u321:0)
> [   69.039312] p->cpus_allowed:
> [   69.039317] CPU: 11 PID: 2230 Comm: mount Not tainted 4.12.0-rc7.debug+ #29
> [   69.039322] Call Trace:
> [   69.039328] [c0000003eee1b620] [c000000000a55f28] dump_stack+0xe8/0x154 (unreliable)
> [   69.039338] [c0000003eee1b660] [c000000000135a2c] try_to_wake_up+0x1bc/0x940
> [   69.039345] [c0000003eee1b730] [c000000000114ea8] create_worker+0x148/0x220
> [   69.039352] [c0000003eee1b7d0] [c00000000011a418] alloc_unbound_pwq+0x4c8/0x620
> [   69.039358] [c0000003eee1b830] [c00000000011a9c4] apply_wqattrs_prepare+0x1f4/0x340
> [   69.039365] [c0000003eee1b8a0] [c00000000011ab4c] apply_workqueue_attrs_locked+0x3c/0xa0
> [   69.039372] [c0000003eee1b8d0] [c00000000011b094] apply_workqueue_attrs+0x54/0x90
> [   69.039378] [c0000003eee1b910] [c00000000011d674] __alloc_workqueue_key+0x184/0x5b0
> [   69.039399] [c0000003eee1b9d0] [d0000000141f1768] ext4_fill_super+0x1c68/0x33e0 [ext4]
> [   69.039406] [c0000003eee1bb10] [c00000000039101c] mount_bdev+0x22c/0x260
> [   69.039425] [c0000003eee1bbb0] [d0000000141e9020] ext4_mount+0x20/0x40 [ext4]
> [   69.039431] [c0000003eee1bbd0] [c000000000392464] mount_fs+0x74/0x210
> [   69.039438] [c0000003eee1bc80] [c0000000003c0728] vfs_kern_mount+0x78/0x220
> [   69.039444] [c0000003eee1bd00] [c0000000003c60e4] do_mount+0x254/0xf70
> [   69.039451] [c0000003eee1bde0] [c0000000003c7224] SyS_mount+0x94/0x100
> [   69.039458] [c0000003eee1be30] [c00000000000b190] system_call+0x38/0xe0
> [   69.044301] EXT4-fs (sda5): mounted filesystem with ordered data mode. Opts: (null)
>
> I applied this patch on top of 4.12-rc7 kernel, built with debug options
> enabled.

So the question is why does kworker/u321:0 have an empty task->cpus_allowed ?

It's late here, but can you try this as well?

cheers


diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c74bf39ef764..da4e0f969239 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1780,9 +1780,14 @@ static struct worker *create_worker(struct worker_pool *pool)
 	if (IS_ERR(worker->task))
 		goto fail;
 
+	WARN_ON(cpumask_empty(worker->task->cpus_allowed));
+
 	set_user_nice(worker->task, pool->attrs->nice);
 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
 
+	WARN_ON(cpumask_empty(worker->task->cpus_allowed));
+	WARN_ON(cpumask_empty(pool->attrs->cpumask));
+
 	/* successful, attach the worker to the pool */
 	worker_attach_to_pool(worker, pool);
 
