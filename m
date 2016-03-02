Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82DC31A09FE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 22:53:24 +1100 (AEDT)
In-Reply-To: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: peterz@infradead.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 acme@kernel.org, mingo@redhat.com, paulus@samba.org
Subject: Re: hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
Message-Id: <20160302115324.63B35140BF5@ozlabs.org>
Date: Wed,  2 Mar 2016 22:53:24 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ravi,

On Wed, 2016-02-03 at 09:55:17 UTC, Ravi Bangoria wrote:
> At a time of destroying hw_breakpoint event, kernel ends up with Oops.
> Here is the sample output from 4.5.0-rc6 kernel.

It's nice to trim the oops a bit, the time stamps aren't useful. And the full
GPRs is probably not useful information either.

>   [  450.708568] Unable to handle kernel paging request for data at address 0x00000c07
>   [  450.708684] Faulting instruction address: 0xc0000000000291d0
>   [  450.708750] Oops: Kernel access of bad area, sig: 11 [#1]
>   [  450.708798] SMP NR_CPUS=1024 NUMA pSeries
>   [  450.708856] Modules linked in: stap_4c2bdcf3e1aee79b646bb9a844e600f7__4962(O) xt_CHECKSUM ...
>   [  450.709539] CPU: 5 PID: 5106 Comm: perf_fuzzer Tainted: G           O    4.5.0-rc5+ #1
>   [  450.709620] task: c0000000f8795c80 ti: c0000000e3340000 task.ti: c0000000e3340000
>   [  450.709691] NIP: c0000000000291d0 LR: c00000000020b6b4 CTR: c00000000020b6f0
>   [  450.709760] REGS: c0000000e3343760 TRAP: 0300   Tainted: G           O     (4.5.0-rc5+)
>   [  450.709831] MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22008828  XER: 20000000
>   [  450.710001] CFAR: c000000000010708 DAR: 0000000000000c07 DSISR: 42000000 SOFTE: 1
>   GPR00: c00000000020b6b4 c0000000e33439e0 c000000001350900 c00000009efa7000
>   GPR04: 0000000000000001 c00000009efa7000 0000000000000000 0000000000000001
>   GPR08: 0000000000000000 ffffffffffffffff 0000000000000000 0000000000000000
>   GPR12: c00000000020b6f0 c000000007e02800 c00000009efa5208 0000000000000000
>   GPR16: 0000000000000001 ffffffffffffffff 0000000000000000 c0000000f3ad7f10
>   GPR20: c0000000f87964c8 0000000000000001 c0000000f8795c80 fffffffffffffffd
>   GPR24: 0000000000000000 c0000000f3ad7f08 c0000000f3ad7f68 c00000009efa6800
>   GPR28: c0000000f3ad7f00 c00000009efa5000 c000000001259520 c00000009efa7000
>   [  450.710996] NIP [c0000000000291d0] arch_unregister_hw_breakpoint+0x40/0x60
>   [  450.711066] LR [c00000000020b6b4] release_bp_slot+0x44/0x80
>   [  450.711117] Call Trace:
>   [  450.711165] [c0000000e33439e0] [c0000000009c1e38] mutex_lock+0x28/0x70 (unreliable)
>   [  450.711257] [c0000000e3343a10] [c00000000020b6b4] release_bp_slot+0x44/0x80
>   [  450.711332] [c0000000e3343a40] [c0000000002036c8] _free_event+0xd8/0x350
>   [  450.711404] [c0000000e3343a70] [c000000000208260] perf_event_exit_task+0x2b0/0x4c0
>   [  450.711490] [c0000000e3343b20] [c0000000000b8ac8] do_exit+0x388/0xc60
>   [  450.711563] [c0000000e3343be0] [c0000000000b9484] do_group_exit+0x64/0x100
>   [  450.711641] [c0000000e3343c20] [c0000000000c9100] get_signal+0x220/0x770
>   [  450.711716] [c0000000e3343d10] [c000000000017884] do_signal+0x54/0x2b0
>   [  450.711793] [c0000000e3343e00] [c000000000017cac] do_notify_resume+0xbc/0xd0
>   [  450.711865] [c0000000e3343e30] [c000000000009838] ret_from_except_lite+0x64/0x68
>   [  450.711948] Instruction dump:
>   [  450.711986] f8010010 f821ffd1 7c7f1b78 60000000 60000000 e93f01e8 2fa90000 419e0018
>   [  450.712107] e9290098 2fa90000 419e000c 39400000 <f9490c08> 38210030 e8010010 ebe1fff8
>   [  450.712230] ---[ end trace 3cf087de955e9358 ]---
> 
> Call chain:
> 
>   hw_breakpoint_event_init()
>     bp->destroy = bp_perf_event_destroy;
> 
>   do_exit()
>     perf_event_exit_task()
>       perf_event_exit_task_context()
>         WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
>         perf_event_exit_event()
>           free_event()
>             _free_event()
>               bp_perf_event_destroy()//event->destroy(event);
>                 release_bp_slot()
>                   arch_unregister_hw_breakpoint()
> 
> perf_event_exit_task_context sets child_ctx->task as TASK_TOMBSTONE
> which is (void *)-1. arch_unregister_hw_breakpoint tries to fetch
> 'thread' attribute of 'task' resulting in Oops.
> 
> This patch adds one more condition before accessing data from 'task'.

I assume this was broken by 63b6da39bb38 ("perf: Fix perf_event_exit_task() race") ?

If so you should say so and add:

  Fixes: 63b6da39bb38 ("perf: Fix perf_event_exit_task() race")

That also means we want it to go into v4.5, which means someone needs to merge
it soon.

Peterz, acme, do you guys want to take this? Or should I?

If the former here's an ack:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
