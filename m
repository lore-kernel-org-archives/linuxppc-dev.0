Return-Path: <aris@conectiva.com.br>
Received: from orion.netbank.com.br (orion.netbank.com.br [200.203.199.90])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9931B67CA4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 06:27:30 +1000 (EST)
Date: Thu, 14 Jul 2005 17:27:15 -0300
From: aris@conectiva.com.br
To: Anton =?iso-8859-1?Q?W=F6llert?= <a.woellert@gmail.com>
Message-ID: <20050714202715.GS19321@oops.ghostprotocols.net>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<faba7798050714012370af5e74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <faba7798050714012370af5e74@mail.gmail.com>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: ptrace on linux 2.6.12 causes oops
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> when i try to run strace or gdbserver on a program, the following comes:
> 
> NIP [c000543c] __flush_dcache_icache_phys+0x38/0x54
> LR [c000b060] flush_dcache_icache_page+0x20/0x30
> Call trace:
> [c000b154] update_mmu_cache+0x7c/0xa4
> [c005ae98] do_wp_page+0x460/0x5ec
> [c005c8a0] handle_mm_fault+0x7cc/0x91c
> [c005ccec] get_user_pages+0x2fc/0x65c
> [c0027104] access_process_vm+0x9c/0x1d4
> [c00076e0] sys_ptrace+0x240/0x4a4
> [c0002bd0] ret_from_syscall+0x0/0x44
> mm/memory.c:2054: spin_lock(kernel/fork.c:c0ea1618) already locked by 
> mm/memory.c/1306
please try to reproduce with 2.6.13-rc2. seems much like the problem Marcelo
fixed recently (dcbst misbehaviour with unpopulated TLB entries)

-- 
Aristeu
