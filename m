Return-Path: <galak@kernel.crashing.org>
Subject: Re: Instable kernel  (2.6.29 or 2.6.31) on MPC8548 with 2 GByte RAM
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4AD6F5D4.7080909@nl.thalesgroup.com>
Date: Fri, 16 Oct 2009 12:50:00 -0500
Message-Id: <9D6CC1B3-F6C7-4F3B-9CB1-24B3616E24E5@kernel.crashing.org>
References: <4AD6F5D4.7080909@nl.thalesgroup.com>
To: willy jacobs <willy.jacobs@nl.thalesgroup.com>
Cc: Linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 15, 2009, at 5:13 AM, willy jacobs wrote:

> On our MPC8548 (latest die revision) based boards with 2 GByte DDR2  
> RAM we see an stable kernel when
>
> CONFIG_HIGHMEM is not set
>
> In this case only the first 768 MB will be used (as reported by / 
> proc/cpuinfo).
> Tested with/without the RT-patches for 2.6.29.6(-rt23) and 2.6.31.2(- 
> rt13) kernels.
>
> With CONFIG_HIGHMEM=y (2048 MB reported) we see (under "heavy" load  
> conditions) regulary page
> errors like this (with/without RT patches):
>
> BUG: Bad page state in process loadgen  pfn:7e31d
> page:c17c23a0 flags:80000000 count:0 mapcount:-128 mapping:(null)  
> index:48105
> Call Trace:
> [ef867d20] [c00072ac] show_stack+0x34/0x160 (unreliable)
> [ef867d50] [c006fcd0] bad_page+0x90/0x13c
> [ef867d70] [c0070d94] get_page_from_freelist+0x424/0x45c
> [ef867de0] [c0070ea4] __alloc_pages_nodemask+0xd8/0x48c
> [ef867e40] [c0082bf0] handle_mm_fault+0x404/0x740
> [ef867e90] [c00131bc] do_page_fault+0x150/0x460
> [ef867f40] [c001017c] handle_page_fault+0xc/0x80
>
> With the RT-patches we see already during Linux startup at lot of  
> these errors (from several processes):
>
> BUG: scheduling while atomic: pam_console_app/0x00000001/802, CPU#0
> Modules linked in:
> Call Trace:
> [ef28dce0] [c00072ac] show_stack+0x34/0x160 (unreliable)
> [ef28dd10] [c002fa90] __schedule_bug+0x6c/0x80
> [ef28dd30] [c02660fc] __schedule+0x264/0x338
> [ef28dd60] [c0266400] schedule+0x1c/0x40
> [ef28dd70] [c0267898] rt_spin_lock_slowlock+0x124/0x264
> [ef28dde0] [c0079154] __lru_cache_add+0x24/0xa8
> [ef28de00] [c008ee04] page_add_new_anon_rmap+0x58/0x88
> [ef28de20] [c0086ff8] handle_mm_fault+0x5a4/0x804
> [ef28de80] [c0013590] do_page_fault+0x14c/0x49c
> [ef28df40] [c00101c4] handle_page_fault+0xc/0x80
> BUG: scheduling while atomic: pam_console_app/0x00000001/807, CPU#0
> Modules linked in:
> Call Trace:
> [ef323a30] [c00072ac] show_stack+0x34/0x160 (unreliable)
> [ef323a60] [c002fa90] __schedule_bug+0x6c/0x80
> [ef323a80] [c02660fc] __schedule+0x264/0x338
> [ef323ab0] [c0266400] schedule+0x1c/0x40
> [ef323ac0] [c0267898] rt_spin_lock_slowlock+0x124/0x264
> [ef323b30] [c0079154] __lru_cache_add+0x24/0xa8
> [ef323b50] [c008ee04] page_add_new_anon_rmap+0x58/0x88
> [ef323b70] [c0086ff8] handle_mm_fault+0x5a4/0x804
> [ef323bd0] [c0013590] do_page_fault+0x14c/0x49c
> [ef323c90] [c00101c4] handle_page_fault+0xc/0x80
> [ef323d50] [00000007] 0x7
> [ef323d80] [c0071320] generic_file_aio_read+0x2d4/0x6bc
> [ef323e00] [c00ffe98] nfs_file_read+0x124/0x178
> [ef323e30] [c009d56c] do_sync_read+0xc4/0x138
> [ef323ef0] [c009e0a4] vfs_read+0xc4/0x188
> [ef323f10] [c009e514] sys_read+0x4c/0x90
> [ef323f40] [c000fd84] ret_from_syscall+0x0/0x3c
>
> Anyone experience with MPC8548 with 2 GByte RAM (HIGHMEM)?
>

We've used MPC85xx w/2G+ for some time w/HIGHMEM and havent seen any  
issues.  Are you sure your DDR settings are stable?

- k
