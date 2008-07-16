Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id C790EDDDFD
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 06:22:43 +1000 (EST)
Date: Wed, 16 Jul 2008 15:22:36 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] powerpc: support for latencytop
Message-ID: <20080716202236.GZ9594@localdomain>
References: <48755237.9070701@nortel.com> <200807101557.22354.arnd@arndb.de>
	<200807101608.18643.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807101608.18643.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> Implement save_stack_trace_tsk on powerpc, so that we can run with
> latencytop.

So I tried latencytop with linux-next and got the following oops, but
I didn't really look into it yet.

Unable to handle kernel paging request for data at address 0x00000008
Faulting instruction address: 0xc00000000002d114
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=32 pSeries
Modules linked in:
NIP: c00000000002d114 LR: c0000000005d3c68 CTR: 0000000000000000
REGS: c0000000e9137580 TRAP: 0300   Not tainted  (2.6.26-next-20080716-08333-g49de20b)
MSR: 8000000000009032 <EE,ME,IR,DR>  CR: 24000040  XER: 20000018
DAR: 0000000000000008, DSISR: 0000000040000000
TASK = c0000000e9138000[9] 'migration/2' THREAD: c0000000e9134000 CPU: 2
GPR00: c0000000005d3c68 c0000000e9137800 c000000000a54fc8 c0000000e91378f0 
GPR04: c0000000e91378f0 c0000000e91e2750 0000000000000000 0000000000000002 
GPR08: c0000000011154e0 0000000000000000 0000000000000400 c000000000a876c0 
GPR12: 0000000044000042 c000000000a90800 00000000002146f4 0000000000214744 
GPR16: 4000000002040000 0000000002903b58 c0000000e90bff10 00000000ffffffff 
GPR20: c0000000010aec30 c000000000a95dc8 0000000000000010 0000000000000003 
GPR24: 0000000000000001 c0000000011154a0 c0000000e91e2750 c000000000eedf68 
GPR28: c0000000e9137908 0000000000000003 c0000000009c0c30 c0000000e9137800 
NIP [c00000000002d114] .save_stack_trace_tsk+0x24/0x40
LR [c0000000005d3c68] .account_scheduler_latency+0xa4/0x2dc
Call Trace:
[c0000000e9137800] [c0000000e9137850] 0xc0000000e9137850 (unreliable)
[c0000000e9137880] [c0000000005d3c68] .account_scheduler_latency+0xa4/0x2dc
[c0000000e91379b0] [c0000000000794e8] .enqueue_task_fair+0x1e0/0x24c
[c0000000e9137a60] [c000000000074be4] .enqueue_task+0x80/0xb0
[c0000000e9137af0] [c000000000074c50] .activate_task+0x3c/0x64
[c0000000e9137b80] [c00000000007a5c8] .try_to_wake_up+0x2a0/0x384
[c0000000e9137c50] [c00000000007a6d0] .default_wake_function+0x24/0x38
[c0000000e9137cd0] [c00000000007438c] .__wake_up_common+0x74/0xec
[c0000000e9137d90] [c0000000000765c0] .complete+0x5c/0x8c
[c0000000e9137e30] [c00000000007eaa4] .migration_thread+0x2a4/0x33c
[c0000000e9137f00] [c0000000000a1da4] .kthread+0x84/0xd4
[c0000000e9137f90] [c000000000029ce4] .kernel_thread+0x4c/0x68
Instruction dump:
7c0803a6 7d808120 4e800020 7c0802a6 fbe1fff0 7c651b78 7c832378 38c00000 
f8010010 f821ff81 e9250478 7c3f0b78 <e8890008> 4bfffef5 e8210000 e8010010 
---[ end trace e35e4a6e751f309e ]---
