Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AFAEB70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Oct 2010 12:29:08 +1100 (EST)
Subject: Re: advice on reading a call trace
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean-Mickael Guerin <jean-mickael.guerin@6wind.com>
In-Reply-To: <4CA9B967.9060907@6wind.com>
References: <4CA9B967.9060907@6wind.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Oct 2010 12:28:57 +1100
Message-ID: <1286501337.2463.398.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-04 at 13:24 +0200, Jean-Mickael Guerin wrote:
> Hello,
> I'm stepping into ppc world and I'd like to know how to read this call trace,
> I enabled debug options but I'm not able to track the origin of this bug, I mean
> what happens before handle_page_fault():
> 
> Unable to handle kernel paging request for data at address 0x00000008

That's a NULL dereference

> Faulting instruction address: 0xc00abcd8
>
> [c1d0dd40] [c00ab2e4] swapin_readahead+0x34/0xbc
> [c1d0dd80] [c009e91c] handle_mm_fault+0x724/0x9b0
> [c1d0dde0] [c0014e10] do_page_fault+0x2e8/0x55c
> [c1d0df40] [c000fc8c] handle_page_fault+0xc/0x80

I suspect it's userspace before handle_page_fault(). It died with a NULL
deref in the swap code (which is strange... which kernel is this ? Do
you have out of tree patches applied ?)

Cheers,
Ben.

> Instruction dump:
> 80010034 7d435378 bb210014 38210030 7c0803a6 4e800020 7d695b78 4bffff00
> 387a007c 4847616d 38000001 7c00f830 <817b0008> 7d3c0214 7f895840 7f9ee378
> Kernel panic - not syncing: Fatal exception
> 
> Another one:
> NIP: c00b6980 LR: c00b6978 CTR: 0f9ffb20
> REGS: d6a9dc60 TRAP: 0300   Not tainted  (2.6.34.6-00392-g31e1857)
> MSR: 10029002   CR: 24004442  XER: 00000000
> DEAR: 00000008, ESR: 00000000
> TASK = da6a7440[4915] 'smrd' THREAD: d6a9c000 CPU: 0
> GPR00: 00000008 d6a9dd10 da6a7440 c0738340 00000000 00000000 00000000 00000001
> GPR08: 00000000 00000000 c00b6978 00000000 44004442 10027f04 c077790c d79f94a8
> GPR16: d6a9dd88 c07a0000 d72301f0 d6a9c000 000001ff 00000000 0f9ffb20 da5c6f78
> GPR24: d79f9440 c0738340 d6a9dd48 00000000 07832400 00000001 00000003 07832400
> NIP [c00b6980] valid_swaphandles+0x19c/0x1d0
> LR [c00b6978] valid_swaphandles+0x194/0x1d0
> Call Trace:
> [d6a9dd10] [c00b6978] valid_swaphandles+0x194/0x1d0 (unreliable)
> [d6a9dd40] [c00b5a10] swapin_readahead+0x34/0xbc
> [d6a9dd80] [c00a9064] handle_mm_fault+0x7c0/0x868
> [d6a9dde0] [c00158d8] do_page_fault+0x2fc/0x570
> [d6a9df40] [c001061c] handle_page_fault+0xc/0x80
> Instruction dump:
> 38210030 7c0803a6 4e800020 7d695b78 4bffff04 3d20c074 39298300 3b290040
> 7f23cb78 484843a9 38000001 7c00f030 <817b0008> 7d3f0214 7f895840 7ffdfb78
> Kernel panic - not syncing: Fatal exception
> Call Trace:
> [d6a9dba0] [c000765c] show_stack+0x40/0x15c (unreliable)
> [d6a9dbd0] [c053b780] panic+0x94/0x118
> [d6a9dc20] [c000d630] die+0x15c/0x1bc
> [d6a9dc40] [c00155a4] bad_page_fault+0x90/0xc8
> [d6a9dc50] [c001068c] handle_page_fault+0x7c/0x80
> [d6a9dd10] [c00b6978] valid_swaphandles+0x194/0x1d0
> [d6a9dd40] [c00b5a10] swapin_readahead+0x34/0xbc
> [d6a9dd80] [c00a9064] handle_mm_fault+0x7c0/0x868
> [d6a9dde0] [c00158d8] do_page_fault+0x2fc/0x570
> [d6a9df40] [c001061c] handle_page_fault+0xc/0x80
> Rebooting in 5 seconds..
> 
> Thanks,
> Jean-Mickael
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
