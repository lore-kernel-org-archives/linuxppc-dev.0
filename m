Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 56AC82C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jan 2014 19:25:21 +1100 (EST)
Message-ID: <52DCDD6A.8080204@windriver.com>
Date: Mon, 20 Jan 2014 16:25:14 +0800
From: =?UTF-8?B?IuKAnHRpZWp1bi5jaGVu4oCdIg==?= <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Arun Chandran <achandran@mvista.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: KGDB panics on p2020 target
References: <CAFdej02gyEuDDWwBa4wG01NVf_-wOysdWha+mi+Z+0YafiUAGQ@mail.gmail.com>
In-Reply-To: <CAFdej02gyEuDDWwBa4wG01NVf_-wOysdWha+mi+Z+0YafiUAGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/17/2014 03:52 PM, Arun Chandran wrote:
> Hi,
>
> I am testing kgdb on freescale p2020 target.
>
> In target
> ------------
>
> 1)
> root@freescale-p2020ds:~# uname -a
> Linux freescale-p2020ds 3.10.20-rt14+ #9 SMP Thu Jan 16 16:32:15 IST 2014
> ppc GNU/Linux
>
> 2)
> root@freescale-p2020ds:~# cat /proc/cpuinfo
> processor       : 0
> cpu             : e500v2
> clock           : 999.990008MHz
> revision        : 4.0 (pvr 8021 1040)
> bogomips        : 124.99
>
> processor       : 1
> cpu             : e500v2
> clock           : 999.990008MHz
> revision        : 4.0 (pvr 8021 1040)
> bogomips        : 124.99
>
> total bogomips  : 249.99
> timebase        : 62499376
> platform        : P2020 DS
> model           : fsl,P2020DS
> Memory          : 768 MB
>
> 3)
> freescale-p2020ds:~# echo "ttyS1,115200" >
> /sys/module/kgdboc/parameters/kgdoc
>
> 4) I set up host (settings given below); Then I send   "SysRq : DEBUG"
>
> In host
> ----------
> (gdb) target remote /dev/ttyS0
> Remote debugging using /dev/ttyS0
> kgdb_breakpoint () at kernel/debug/debug_core.c:1013
> 1013 arch_kgdb_breakpoint();
> (gdb) b sys_sync
> Breakpoint 1 at 0xc0167288: file fs/sync.c, line 103.
> (gdb) c
> Continuing.
>
> I am able to take control in host; after that I am setting breakpoint at
> "sys_sync"
>
> In target
> ------------
> root@freescale-p2020ds:~# for i in 1 2 3 4 5 6 7 8 9
>> do
>> sync
>> done
>
> In host
> ----------
> Breakpoint 1, sys_sync () at fs/sync.c:103
> 103 {
> (gdb) c
> Continuing.
>
> Breakpoint is hit only one time instead of 9 times; after that target hangs.

I recommend you try upstream to take a further look at this, instead of that 
Freescale distribution. As I recall currently KGDB works well in 85xx case in ML.

>
> Then i tried to send "SysRq : DEBUG" in target kernel panics.
>
> I have pasted the panic below.
>
> #########################################
> SysRq : DEBUG
> Kernel panic - not syncing: Recursive entry to debugger

The kernel already trap into kgdb_handle_exception() with the debug exception 
while triggering that break point, but again you trigger another debug exception 
by SysRq. Actually KGDB can't handle such this recursive behavior, so KGDB 
always call kgdb_reenter_check() to prevent this scenario with this call trace.

static int kgdb_reenter_check(struct kgdb_state *ks)
{
         unsigned long addr;

         if (atomic_read(&kgdb_active) != raw_smp_processor_id())
                 return 0;
	...

         if (exception_level > 1) {
                 dump_stack();
                 panic("Recursive entry to debugger");
         }


Tiejun	

> CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6
> Call Trace:
> [effe5d10] [c0008060] show_stack+0x4c/0x168 (unreliable)
> [effe5d50] [c0588878] panic+0xe4/0x224
> [effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/0x1f8
> [effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
> [effe5e00] [c057e7e0] program_check_exception+0x10c/0x264
> [effe5e10] [c000f660] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8
>      LR = __handle_sysrq+0x154/0x1cc
> [effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)
> [effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218
> [effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174
> [effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8
> [effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/0x2a8
> [effe5fc0] [c00b5720] handle_irq_event+0x44/0x74
> [effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c
> [effe5ff0] [c000d58c] call_handle_irq+0x18/0x28
> [c4f91b10] [c0004f60] do_IRQ+0x150/0x224
> [c4f91b40] [c000f6ac] ret_from_except+0x0/0x18
> --- Exception: 501 at rpcauth_lookup_credcache+0x138/0x2a4
>      LR = rpcauth_lookup_credcache+0xb8/0x2a4
> [c4f91c00] [24002424] 0x24002424 (unreliable)
> [c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac
> [c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/0x124
> [c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330
> [c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4
> [c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8
> [c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c
> [c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/0x168
> [c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/0x194
> [c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8
> [c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824
> [c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/0x8c
> [c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c
> [c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4
> [c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44
> [c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c
> --- Exception: c01 at 0xff08a98
>      LR = 0xfed53e8
> CPU: 1 PID: 2266 Comm: cron Not tainted 3.10.20-rt14+ #6
> Call Trace:
> [effe5bb0] [c0008060] show_stack+0x4c/0x168 (unreliable)
> [effe5bf0] [c00b2cac] kgdb_handle_exception+0x1c4/0x1f8
> [effe5c40] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
> [effe5c50] [c057e7e0] program_check_exception+0x10c/0x264
> [effe5c60] [c000f660] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at kgdb_panic_event+0x1c/0x3c
>      LR = notifier_call_chain+0x60/0xb0
> [effe5d20] [00000000]    (nil) (unreliable)
> [effe5d40] [c05819dc] __atomic_notifier_call_chain+0x14/0x24
> [effe5d50] [c05888a8] panic+0x114/0x224
> [effe5da0] [c00b2cbc] kgdb_handle_exception+0x1d4/0x1f8
> [effe5df0] [c0010038] kgdb_handle_breakpoint+0x4c/0x80
> [effe5e00] [c057e7e0] program_check_exception+0x10c/0x264
> [effe5e10] [c000f660] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at sysrq_handle_dbg+0x3c/0xc8
>      LR = __handle_sysrq+0x154/0x1cc
> [effe5ed0] [c033df5c] __handle_sysrq+0x140/0x1cc (unreliable)
> [effe5f00] [c0353ef8] serial8250_rx_chars+0xe8/0x218
> [effe5f30] [c0359644] fsl8250_handle_irq+0xac/0x174
> [effe5f50] [c0352f9c] serial8250_interrupt+0x40/0xe8
> [effe5f70] [c00b5500] handle_irq_event_percpu+0xcc/0x2a8
> [effe5fc0] [c00b5720] handle_irq_event+0x44/0x74
> [effe5fe0] [c00b8e14] handle_fasteoi_irq+0xd0/0x17c
> [effe5ff0] [c000d58c] call_handle_irq+0x18/0x28
> [c4f91b10] [c0004f60] do_IRQ+0x150/0x224
> [c4f91b40] [c000f6ac] ret_from_except+0x0/0x18
> --- Exception: 501 at rpcauth_lookup_credcache+0x138/0x2a4
>      LR = rpcauth_lookup_credcache+0xb8/0x2a4
> [c4f91c00] [24002424] 0x24002424 (unreliable)
> [c4f91c50] [c055cb84] rpcauth_lookupcred+0x64/0xac
> [c4f91c80] [c055ce2c] rpcauth_refreshcred+0x11c/0x124
> [c4f91cc0] [c055ac80] __rpc_execute+0x8c/0x330
> [c4f91d10] [c05540b8] rpc_run_task+0x9c/0xc4
> [c4f91d20] [c0554204] rpc_call_sync+0x50/0xb8
> [c4f91d50] [c0257164] nfs_proc_getattr+0x48/0x5c
> [c4f91d70] [c024aaa4] __nfs_revalidate_inode+0xa8/0x168
> [c4f91d90] [c024ac1c] nfs_revalidate_mapping+0xb8/0x194
> [c4f91da0] [c0251f00] nfs_follow_link+0x24/0xc8
> [c4f91dc0] [c0145280] path_lookupat+0x2f4/0x824
> [c4f91e10] [c01457dc] filename_lookup.isra.33+0x2c/0x8c
> [c4f91e30] [c0147a74] user_path_at_empty+0x58/0x9c
> [c4f91eb0] [c013d5bc] vfs_fstatat+0x54/0xb4
> [c4f91ee0] [c013d93c] SyS_stat64+0x1c/0x44
> [c4f91f40] [c000eec0] ret_from_syscall+0x0/0x3c
> --- Exception: c01 at 0xff08a98
>      LR = 0xfed53e8
>
>
> ########################################################
>
> Could you please share your thoughts on this issue?
>
> I have also attached my kernel .config.
>
> Regards,
> Arun C
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
