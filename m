Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ptdB5FtSzF0Vv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 21:23:10 +1000 (AEST)
In-Reply-To: <153358813908.15150.18359359970445648733.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>, stable@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [v2,
 1/2] powerpc/fadump: handle crash memory ranges array index overflow
Message-Id: <41ptdB092jz9sC7@ozlabs.org>
Date: Mon, 13 Aug 2018 21:23:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-08-06 at 20:42:45 UTC, Hari Bathini wrote:
> Crash memory ranges is an array of memory ranges of the crashing kernel
> to be exported as a dump via /proc/vmcore file. The size of the array
> is set based on INIT_MEMBLOCK_REGIONS, which works alright in most cases
> where memblock memory regions count is less than INIT_MEMBLOCK_REGIONS
> value. But this count can grow beyond INIT_MEMBLOCK_REGIONS value since
> commit 142b45a72e22 ("memblock: Add array resizing support").
> 
> On large memory systems with a few DLPAR operations, the memblock memory
> regions count could be larger than INIT_MEMBLOCK_REGIONS value. On such
> systems, registering fadump results in crash or other system failures
> like below:
> 
>   task: c00007f39a290010 ti: c00000000b738000 task.ti: c00000000b738000
>   NIP: c000000000047df4 LR: c0000000000f9e58 CTR: c00000000010f180
>   REGS: c00000000b73b570 TRAP: 0300   Tainted: G          L   X  (4.4.140+)
>   MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 22004484  XER: 20000000
>   CFAR: c000000000008500 DAR: 000007a450000000 DSISR: 40000000 SOFTE: 0
>   GPR00: c0000000000f9e58 c00000000b73b7f0 c000000000f09a00 000000000000001a
>   GPR04: c00007f3bf774c90 0000000000000004 c000000000eb9a00 0000000000000800
>   GPR08: 0000000000000804 000007a450000000 c000000000fa9a00 c00007ffb169ca20
>   GPR12: 0000000022004482 c00000000fa12c00 c00007f3a0ea97a8 0000000000000000
>   GPR16: c00007f3a0ea9a50 c00000000b73bd60 0000000000000118 000000000001fe80
>   GPR20: 0000000000000118 0000000000000000 c000000000b8c980 00000000000000d0
>   GPR24: 000007ffb0b10000 c00007ffb169c980 0000000000000000 c000000000b8c980
>   GPR28: 0000000000000004 c00007ffb169c980 000000000000001a c00007ffb169c980
>   NIP [c000000000047df4] smp_send_reschedule+0x24/0x80
>   LR [c0000000000f9e58] resched_curr+0x138/0x160
>   Call Trace:
>   [c00000000b73b7f0] [c0000000000f9e58] resched_curr+0x138/0x160 (unreliable)
>   [c00000000b73b820] [c0000000000fb538] check_preempt_curr+0xc8/0xf0
>   [c00000000b73b850] [c0000000000fb598] ttwu_do_wakeup+0x38/0x150
>   [c00000000b73b890] [c0000000000fc9c4] try_to_wake_up+0x224/0x4d0
>   [c00000000b73b900] [c00000000011ef34] __wake_up_common+0x94/0x100
>   [c00000000b73b960] [c00000000034a78c] ep_poll_callback+0xac/0x1c0
>   [c00000000b73b9b0] [c00000000011ef34] __wake_up_common+0x94/0x100
>   [c00000000b73ba10] [c00000000011f810] __wake_up_sync_key+0x70/0xa0
>   [c00000000b73ba60] [c00000000067c3e8] sock_def_readable+0x58/0xa0
>   [c00000000b73ba90] [c0000000007848ac] unix_stream_sendmsg+0x2dc/0x4c0
>   [c00000000b73bb70] [c000000000675a38] sock_sendmsg+0x68/0xa0
>   [c00000000b73bba0] [c00000000067673c] ___sys_sendmsg+0x2cc/0x2e0
>   [c00000000b73bd30] [c000000000677dbc] __sys_sendmsg+0x5c/0xc0
>   [c00000000b73bdd0] [c0000000006789bc] SyS_socketcall+0x36c/0x3f0
>   [c00000000b73be30] [c000000000009488] system_call+0x3c/0x100
>   Instruction dump:
>   4e800020 60000000 60420000 3c4c00ec 38421c30 7c0802a6 f8010010 60000000
>   3d42000a e92ab420 2fa90000 4dde0020 <e9290000> 2fa90000 419e0044 7c0802a6
>   ---[ end trace a6d1dd4bab5f8253 ]---
> 
> as array index overflow is not checked for while setting up crash memory
> ranges causing memory corruption. To resolve this issue, dynamically
> allocate memory for crash memory ranges and resize it incrementally,
> in units of pagesize, on hitting array size limit.
> 
> Fixes: 2df173d9e85d ("fadump: Initialize elfcore header and add PT_LOAD program headers.")
> Cc: stable@vger.kernel.org
> Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1bd6a1c4b80a28d975287630644e6b

cheers
