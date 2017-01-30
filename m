Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vC2Ty5c1lzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2017 08:24:54 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: fweisbec@gmail.com, matt@codeblueprint.co.uk, tglx@linutronix.de,
 pmladek@suse.com, hpa@zytor.com, efault@gmx.de,
 sergey.senozhatsky.work@gmail.com, peterz@infradead.org,
 mgorman@techsingularity.net, wanpeng.li@hotmail.com, umgwanakikbuti@gmail.com,
 byungchul.park@lge.com, jack@suse.cz, mingo@kernel.org, riel@redhat.com,
 luca.abeni@unitn.it, yuyang.du@intel.com, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Cc: fweisbec@gmail.com, tglx@linutronix.de, matt@codeblueprint.co.uk,
 pmladek@suse.com, hpa@zytor.com, efault@gmx.de,
 sergey.senozhatsky.work@gmail.com, mgorman@techsingularity.net,
 peterz@infradead.org, wanpeng.li@hotmail.com, umgwanakikbuti@gmail.com,
 byungchul.park@lge.com, luca.abeni@unitn.it, riel@redhat.com, jack@suse.cz,
 mingo@kernel.org, torvalds@linux-foundation.org, yuyang.du@intel.com,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>,
 linux-next@vger.kernel.org <linux-next@vger.kernel.org>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
In-Reply-To: <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
References: <20160921133813.31976-8-matt@codeblueprint.co.uk>
 <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
Date: Tue, 31 Jan 2017 08:24:53 +1100
Message-ID: <87tw8gutp6.fsf@concordia.ellerman.id.au>
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

tip-bot for Matt Fleming <tipbot@zytor.com> writes:

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 98e7eee..6eeae7e 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -768,48 +768,110 @@ static inline u64 __rq_clock_broken(struct rq *rq)
>  	return READ_ONCE(rq->clock);
>  }
>  
> +/*
> + * rq::clock_update_flags bits
> + *
> + * %RQCF_REQ_SKIP - will request skipping of clock update on the next
> + *  call to __schedule(). This is an optimisation to avoid
> + *  neighbouring rq clock updates.
> + *
> + * %RQCF_ACT_SKIP - is set from inside of __schedule() when skipping is
> + *  in effect and calls to update_rq_clock() are being ignored.
> + *
> + * %RQCF_UPDATED - is a debug flag that indicates whether a call has been
> + *  made to update_rq_clock() since the last time rq::lock was pinned.
> + *
> + * If inside of __schedule(), clock_update_flags will have been
> + * shifted left (a left shift is a cheap operation for the fast path
> + * to promote %RQCF_REQ_SKIP to %RQCF_ACT_SKIP), so you must use,
> + *
> + *	if (rq-clock_update_flags >= RQCF_UPDATED)
> + *
> + * to check if %RQCF_UPADTED is set. It'll never be shifted more than
> + * one position though, because the next rq_unpin_lock() will shift it
> + * back.
> + */
> +#define RQCF_REQ_SKIP	0x01
> +#define RQCF_ACT_SKIP	0x02
> +#define RQCF_UPDATED	0x04
> +
> +static inline void assert_clock_updated(struct rq *rq)
> +{
> +	/*
> +	 * The only reason for not seeing a clock update since the
> +	 * last rq_pin_lock() is if we're currently skipping updates.
> +	 */
> +	SCHED_WARN_ON(rq->clock_update_flags < RQCF_ACT_SKIP);
> +}

I'm hitting this on multiple powerpc systems:

[   38.339126] rq->clock_update_flags < RQCF_ACT_SKIP
[   38.339134] ------------[ cut here ]------------
[   38.339142] WARNING: CPU: 2 PID: 1 at kernel/sched/sched.h:804 detach_task_cfs_rq+0xa0c/0xd10
[   38.339142] Modules linked in: fuse pseries_rng rng_core vmx_crypto ib_iser rdma_cm iw_cm ib_cm ib_core libiscsi scsi_transport_iscsi autofs4 btrfs raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c multipath raid10
[   38.339162] CPU: 2 PID: 1 Comm: systemd Not tainted 4.10.0-rc6-gccN-next-20170130-g14dcd7e #1
[   38.339163] task: c000000ffc900000 task.stack: c0000007fda00000
[   38.339164] NIP: c00000000012d31c LR: c00000000012d318 CTR: c0000000005aed80
[   38.339165] REGS: c0000007fda03630 TRAP: 0700   Not tainted  (4.10.0-rc6-gccN-next-20170130-g14dcd7e)
[   38.339166] MSR: 8000000000029033 <SF,EE,ME,IR,DR,RI,LE>
[   38.339170]   CR: 28044242  XER: 20000000
[   38.339171] CFAR: c000000000a732c8 SOFTE: 0 
               GPR00: c00000000012d318 c0000007fda038b0 c000000000f32c00 0000000000000026 
               GPR04: 0000000000000000 00000000000001f7 6574616470755f6b 0000000000000000 
               GPR08: 00000004baa70000 c000000000e1edb0 0000000000000000 0000000000000e8a 
               GPR12: 0000000000004400 c00000000eaa0800 00003fffc25fdd50 000000003a30b518 
               GPR16: 000001002495fe70 0000000000000000 000000003a301668 000000000000001b 
               GPR20: 0000000000000001 c000000ff1d0a000 c0000004a8191300 c00000000b12fe90 
               GPR24: c000000000e80500 c000000001026dfc c0000007fda03aa0 c0000007fda03b30 
               GPR28: c0000007fda03b10 c0000004bb864880 c00000000b12fe80 c0000004acb8a900 
[   38.339186] NIP [c00000000012d31c] detach_task_cfs_rq+0xa0c/0xd10
[   38.339188] LR [c00000000012d318] detach_task_cfs_rq+0xa08/0xd10
[   38.339188] Call Trace:
[   38.339189] [c0000007fda038b0] [c00000000012d318] detach_task_cfs_rq+0xa08/0xd10 (unreliable)
[   38.339192] [c0000007fda03970] [c000000000133cb8] task_change_group_fair+0x48/0x130
[   38.339193] [c0000007fda039b0] [c0000000001139e4] sched_change_group+0x64/0xd0
[   38.339195] [c0000007fda039f0] [c000000000121790] sched_move_task+0x60/0x210
[   38.339197] [c0000007fda03a40] [c000000000121984] cpu_cgroup_attach+0x44/0x70
[   38.339200] [c0000007fda03a80] [c0000000001b84d0] cgroup_migrate_execute+0x410/0x460
[   38.339202] [c0000007fda03af0] [c0000000001b8790] cgroup_attach_task+0x180/0x350
[   38.339203] [c0000007fda03bb0] [c0000000001bb76c] __cgroup_procs_write+0x30c/0x450
[   38.339205] [c0000007fda03c40] [c0000000001b5644] cgroup_file_write+0x74/0x160
[   38.339208] [c0000007fda03ca0] [c0000000003fec00] kernfs_fop_write+0x190/0x260
[   38.339210] [c0000007fda03cf0] [c000000000344a0c] __vfs_write+0x6c/0x1c0
[   38.339211] [c0000007fda03d90] [c000000000346988] vfs_write+0xd8/0x240
[   38.339213] [c0000007fda03de0] [c00000000034882c] SyS_write+0x6c/0x110
[   38.339215] [c0000007fda03e30] [c00000000000b760] system_call+0x38/0xfc
[   38.339215] Instruction dump:
[   38.339217] 60420000 3d22fff4 8929130e 2f890000 409ef6c4 39200001 3d42fff4 3c62ffd2 
[   38.339220] 3863b610 992a130e 48945f65 60000000 <0fe00000> 4bfff6a0 60000000 60000000 
[   38.339223] ---[ end trace d76dabbf37156e2a ]---


I assume I should be worried?

cheers
