Return-Path: <jstancek@redhat.com>
Received: from mx5-phx2.redhat.com (mx5-phx2.redhat.com [209.132.183.37])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1E1B1A0281
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 21:21:07 +1100 (AEDT)
Date: Wed, 25 Mar 2015 05:29:20 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Message-ID: <499776934.3442137.1427275760679.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150325052509.C995F1400F1@ozlabs.org>
References: <20150325052509.C995F1400F1@ozlabs.org>
Subject: Re: powerpc/perf: add missing put_cpu_var in power_pmu_event_init
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: jolsa@redhat.com, linux-kernel@vger.kernel.org, paulus@samba.org,
 anton@samba.org, tj@kernel.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
 joel@jms.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



----- Original Message -----
> From: "Michael Ellerman" <mpe@ellerman.id.au>
> To: "Jan Stancek" <jstancek@redhat.com>, linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org, tj@kernel.org, cl@linux.com, jolsa@redhat.com,
> jstancek@redhat.com, joel@jms.id.au
> Sent: Wednesday, 25 March, 2015 6:25:09 AM
> Subject: Re: powerpc/perf: add missing put_cpu_var in power_pmu_event_init
> 
> On Tue, 2015-24-03 at 12:33:22 UTC, Jan Stancek wrote:
> > One path in power_pmu_event_init() calls get_cpu_var(), but is
> > missing matching call to put_cpu_var(), which causes preemption
> > imbalance and crash in user-space:
> > 
> >   Page fault in user mode with in_atomic() = 1 mm = c000001fefa5a280
> >   NIP = 3fff9bf2cae0  MSR = 900000014280f032
> >   Oops: Weird page fault, sig: 11 [#23]
> 
> <snip>
> 
> Thanks. But I don't see this. I guess you have CONFIG_PREEMPT enabled?

Hi,

CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
CONFIG_PREEMPT_COUNT=y

but I think the difference comes from:
  CONFIG_DEBUG_ATOMIC_SLEEP=y

I did following:
- took the default config from RHEL7.1 kernel
- ran 'make oldnoconfig'.
- reproducer didn't trigger anything
- then I added "CONFIG_DEBUG_ATOMIC_SLEEP=y"
- this time reproducer triggered a panic (3 out of 3 attempts)

Here's config from panic-ing kernel: http://fpaste.org/202543/

[  133.957305] Page fault in user mode with in_atomic() = 1 mm = c000000005fc7e80
[  133.957399] NIP = 3fff9be0cae0  MSR = 900000014280f032
[  133.957405] Oops: Weird page fault, sig: 11 [#1]
[  133.957409] SMP NR_CPUS=2048 NUMA PowerNV
[  133.957414] Modules linked in: ses enclosure shpchp uio_pdrv_genirq powernv_rng uio xfs libcrc32c sr_mod sd_mod cdrom ipr libata tg3 ptp pps_core dm_mirror dm_region_hash dm_log dm_mod
[  133.957638] CPU: 16 PID: 6035 Comm: a.out Not tainted 4.0.0-rc5+ #4
[  133.957693] task: c000000fea44b640 ti: c000000fea5e4000 task.ti: c000000fea5e4000
[  133.957759] NIP: 00003fff9be0cae0 LR: 00003fff9bdc4898 CTR: 00003fff9be0cae0
[  133.957825] REGS: c000000fea5e7ea0 TRAP: 0401   Not tainted  (4.0.0-rc5+)
[  133.957880] MSR: 900000014280f032 <SF,HV,VEC,VSX,EE,PR,FP,ME,IR,DR,RI>  CR: 22000028  XER: 00000000
[  133.958079] CFAR: 00003fff9bdc4894 SOFTE: 1 
GPR00: 00003fff9bdc494c 00003ffff1fef3e0 00003fff9bf64410 0000000010020068 
GPR04: 0000000000000000 0000000000000002 0000000000000008 0000000000000001 
GPR08: 0000000000000001 00003fff9bf54a30 00003fff9be0cae0 00003fff9be0cd70 
GPR12: 0000000052000022 00003fff9bfeb700 
[  133.958485] NIP [00003fff9be0cae0] 0x3fff9be0cae0
[  133.958530] LR [00003fff9bdc4898] 0x3fff9bdc4898
[  133.958574] Call Trace:
[  133.958597] ---[ end trace 56ec543903422cd9 ]---
[  133.958642] 
[  135.958709] Kernel panic - not syncing: Fatal exception
[  135.958863] Rebooting in 10 seconds..
[  145.970348] BUG: sleeping function called from invalid context at kernel/irq/manage.c:104
[  145.970453] in_atomic(): 1, irqs_disabled(): 1, pid: 6035, name: a.out
[  145.970515] CPU: 16 PID: 6035 Comm: a.out Tainted: G      D         4.0.0-rc5+ #4
[  145.970588] Call Trace:
[  145.970618] [c000000fea5e76d0] [c0000000007c2090] .dump_stack+0x98/0xd4 (unreliable)
[  145.970707] [c000000fea5e7750] [c0000000000d5fe4] .___might_sleep+0x124/0x170
[  145.970782] [c000000fea5e77c0] [c000000000112860] .synchronize_irq+0x40/0xe0
[  145.970857] [c000000fea5e7880] [c000000000112fa8] .__free_irq+0xf8/0x2b0
[  145.970931] [c000000fea5e7920] [c000000000113258] .free_irq+0x78/0x100
[  145.971007] [c000000fea5e79b0] [c000000000067ae8] .opal_shutdown+0x88/0x120
[  145.971081] [c000000fea5e7a40] [c000000000063e88] .pnv_shutdown+0x18/0x30
[  145.971157] [c000000fea5e7ab0] [c000000000020c98] .machine_shutdown+0x38/0x50
[  145.971231] [c000000fea5e7b20] [c000000000020d24] .machine_restart+0x14/0x70
[  145.971307] [c000000fea5e7ba0] [c0000000000cdc10] .emergency_restart+0x20/0x40
[  145.971393] [c000000fea5e7c10] [c0000000007bb0a4] .panic+0x224/0x2a4
[  145.971468] [c000000fea5e7cb0] [c00000000001e1fc] .die+0x43c/0x450
[  145.971543] [c000000fea5e7d60] [c0000000007b62c4] .do_page_fault+0x2d4/0x8f0
[  145.971618] [c000000fea5e7e30] [c000000000008664] handle_page_fault+0x10/0x30

Regards,
Jan
