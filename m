Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18427.27360.30297.84859@cargo.ozlabs.ibm.com>
Date: Tue, 8 Apr 2008 22:53:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUG] 2.6.25-rc2-git4 - Regression Kernel oops  while running
	kernbench and tbench on powerpc
In-Reply-To: <47FB5C5A.5020104@linux.vnet.ibm.com>
References: <47BC40BC.3040405@linux.vnet.ibm.com>
	<18427.11023.8067.795279@cargo.ozlabs.ibm.com>
	<47FB5C5A.5020104@linux.vnet.ibm.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, nacc@us.ibm.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <balbir@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kamalesh Babulal writes:

> The kernel oops after applying the patch. Some time it takes more than
> one run to reproduce it, it was reproducible in the second run this
> time.
> 
>  Unrecoverable exception 4100 at c000000000008c8c
> Oops: Unrecoverable exception, sig: 6 [#1]
> SMP NR_CPUS=128 NUMA pSeries
> Modules linked in:
> NIP: c000000000008c8c LR: 000000000ff0135c CTR: 000000000ff012f0
> REGS: c000000772343bb0 TRAP: 4100   Not tainted  (2.6.25-rc8-autotest)
> MSR: 8000000000001030 <ME,IR,DR>  CR: 44044228  XER: 00000000
> TASK = c00000077cfa0900[13437] 'cc1' THREAD: c000000772340000 CPU: 2
> GPR00: 0000000000004000 c000000772343e30 00000000000000bb 000000000000d032 
> GPR04: 00000000000000bb 0000000000000400 000000000000000a 0000000000000002 
> GPR08: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> GPR12: 0000000000000000 c000000000734000 0000000000000064 00000000ffe6df08 
> GPR16: 00000000105b0000 00000000105b0000 0000000010440000 00000000105b0000 
> GPR20: 00000000ffe6e008 00000000105b0000 00000000105b0000 000000000000000a 
> GPR24: 000000000ffec408 0000000000000001 00000000ffe6ddca 0000000000000400 
> GPR28: 000000000ffec408 00000000f7ff8000 000000000ffebff4 0000000000000400 
> NIP [c000000000008c8c] restore+0x8c/0xc0
> LR [000000000ff0135c] 0xff0135c
> Call Trace:
> [c000000772343e30] [c000000000008cd4] do_work+0x14/0x2c (unreliable)
> Instruction dump:
> 7c840078 7c810164 70604000 41820028 60000000 7c4c42e6 e88d01f0 f84d01f0 
> 7c841050 e84d01e8 7c422214 f84d01e8 <e9a100d8> 7c7b03a6 e84101a0 7c4ff120 
> 
> (gdb) l *0xc000000000008cdc
> 0xc000000000008cdc is at arch/powerpc/kernel/entry_64.S:608.
> 603             mtmsrd  r10,1
> 604
> 605             andi.   r0,r4,_TIF_NEED_RESCHED
> 606             beq     1f
> 607             bl      .schedule
> 608             b       .ret_from_except_lite
> 609
> 610     1:      bl      .save_nvgprs
> 611             li      r3,0
> 612             addi    r4,r1,STACK_FRAME_OVERHEAD

The exception happened at c...8c8c but you looked at c...8cdc with
gdb.  What's at c...8c8c?

> please let me know if you need more information.

The .config would be useful, but don't spam everyone on cc with it,
just send it to me privately.

Paul.
