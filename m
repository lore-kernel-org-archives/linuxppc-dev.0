Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [209.128.68.125])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6DE86829E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Sep 2005 01:16:49 +1000 (EST)
Date: Tue, 13 Sep 2005 12:11:32 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050913151132.GF10602@dmt.cnet>
References: <4326968F.5030609@2net.co.uk>
	<20050913122541.GB9076@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050913122541.GB9076@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb hangs on Linux 2.6.11 on 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2005 at 09:25:41AM -0300, Aristeu Sergio Rozanski Filho wrote:
> > I am running Linux 2.6.11 on a TQM823L development board. I find that 
> > gdb (version 6.3) hangs when I try to run an application - any 
> > application, even a simple helloworld. It's not just gdb hanging, the 
> > whole system is stone dead.
> "me too"
> actually the system is not completely dead, you still can use sysrq keys.
> Tried to use gdbserver too, but it also doesn't work (hangs after the first
> breakpoint and timeouts).
> 
> gdb           S 30106778     0   691    687   692               (NOTLB)
> Call trace:
>  [c0005330] __switch_to+0x44/0x78
>  [c015beb0] schedule+0x30c/0x730
>  [c015c888] schedule_timeout+0xdc/0xe0
>  [c0068918] sys_poll+0x27c/0x404
>  [c0002810] syscall_dotrace_cont+0x24/0x38
> flash_test    t 100009E4     0   692    691                     (NOTLB)
> Call trace:
>  [c0005330] __switch_to+0x44/0x78
>  [c015beb0] schedule+0x30c/0x730
>  [c0026248] ptrace_stop+0x68/0x88
>  [c0026604] get_signal_to_deliver+0x130/0x2b4
>  [c00063dc] do_signal+0x38/0x464
>  [c0003034] do_user_signal+0x74/0xc4

Aris,

How does the disassemble of __switch_to looks like? 

Chris oopsen is exactly what the 'icbi' patch fixes.

Maybe this is an additional problem then.

SysRq : Show Regs
NIP: C00047BC LR: C000A0C0 SP: C09FBDD0 REGS: c09fbd20 TRAP: 0501    Not
tainted
MSR: 00009022 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 10
TASK = c031f3e0[187] 'gdb' THREAD: c09fa000
Last syscall: 26
GPR00: 00009022 C09FBDD0 C031F3E0 00589000 00000100 C01F3000 00588000
808B0000
GPR08: 38600000 C01D0000 00009032 0000B100 33003035
NIP [c00047bc] __flush_dcache_icache_phys+0x38/0x54
LR [c000a0c0] flush_dcache_icache_page+0x20/0x30
Call trace:
 [c000a17c] update_mmu_cache+0x68/0x98
 [c003dbe8] do_wp_page+0x184/0x3a4
 [c003ebc8] handle_mm_fault+0x29c/0x42c
 [c003ee7c] get_user_pages+0x124/0x428
 [c001a030] access_process_vm+0xfc/0x1bc
 [c0006680] sys_ptrace+0x22c/0x4b4
 [c0002590] ret_from_syscall+0x0/0x44
