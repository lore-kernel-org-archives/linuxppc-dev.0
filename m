Return-Path: <jean-mickael.guerin@6wind.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	by ozlabs.org (Postfix) with ESMTP id 0E812B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Oct 2010 16:22:28 +1100 (EST)
Received: by wwa36 with SMTP id 36so5618828wwa.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 04 Oct 2010 22:22:26 -0700 (PDT)
Message-ID: <4CAAB5F4.9030002@6wind.com>
Date: Tue, 05 Oct 2010 07:21:56 +0200
From: Jean-Mickael Guerin <jean-mickael.guerin@6wind.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: advice on reading a call trace
References: <4CA9B967.9060907@6wind.com>
In-Reply-To: <4CA9B967.9060907@6wind.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SLUB is turned on, and the oops does not seem to happen when SLAB replaces SLUB.
I just got lucky with SLAB, or does it sound familiar on ppc?

Regards,
Jean-Mickael

On 10/4/2010 1:24 PM, Jean-Mickael Guerin wrote:
> Hello,
> I'm stepping into ppc world and I'd like to know how to read this call trace,
> I enabled debug options but I'm not able to track the origin of this bug, I mean
> what happens before handle_page_fault():
> 
> Unable to handle kernel paging request for data at address 0x00000008
> Faulting instruction address: 0xc00abcd8
> 
> [c1d0dd40] [c00ab2e4] swapin_readahead+0x34/0xbc
> [c1d0dd80] [c009e91c] handle_mm_fault+0x724/0x9b0
> [c1d0dde0] [c0014e10] do_page_fault+0x2e8/0x55c
> [c1d0df40] [c000fc8c] handle_page_fault+0xc/0x80
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
