Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id DEC05B7B89
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 13:12:40 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F732DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 13:12:39 +1000 (EST)
Message-Id: <2E027F3C-8FAA-42EC-99B2-9B7EC470094E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090724091523.8AD8CDDD1B@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH 3/20] powerpc/mm: Add HW threads support to no_hash TLB
	management
Date: Thu, 30 Jul 2009 22:12:32 -0500
References: <20090724091523.8AD8CDDD1B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 24, 2009, at 4:15 AM, Benjamin Herrenschmidt wrote:

> The current "no hash" MMU context management code is written with
> the assumption that one CPU == one TLB. This is not the case on
> implementations that support HW multithreading, where several
> linux CPUs can share the same TLB.
>
> This adds some basic support for this to our context management
> and our TLB flushing code.
>
> It also cleans up the optional debugging output a bit
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

I'm getting this nice oops on 32-bit book-e SMP (and I'm guessing its  
because of this patch)

Unable to handle kernel paging request for data at address 0x00000000
Faulting instruction address: 0xc0016dac
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=8 MPC8572 DS
Modules linked in:
NIP: c0016dac LR: c0016d58 CTR: 0000001e
REGS: eed77ce0 TRAP: 0300   Not tainted  (2.6.31-rc4-00442-gdb4c9c5)
MSR: 00021000 <ME,CE>  CR: 24288482  XER: 20000000
DEAR: 00000000, ESR: 00000000
TASK = eecfe140[1581] 'msgctl08' THREAD: eed76000 CPU: 0
GPR00: 00400000 eed77d90 eecfe140 00000000 00000000 00000001 c05bf074  
c05c0cf4
GPR08: 00000003 00000002 ff7fffff 00000000 00009b05 1004f894 c05bdd24  
00000001
GPR16: ffffffff c05ab890 c05c0ce8 c04e0f58 c04da364 c05c0000 00000000  
c04cfa04
GPR24: 00000002 00000000 00000000 c05c0cd8 00000080 00000000 ef056380  
00000017
NIP [c0016dac] switch_mmu_context+0x15c/0x520
LR [c0016d58] switch_mmu_context+0x108/0x520
Call Trace:
[eed77d90] [c0016d58] switch_mmu_context+0x108/0x520 (unreliable)
[eed77df0] [c040efec] schedule+0x2bc/0x800
[eed77e70] [c01b9268] do_msgrcv+0x198/0x420
[eed77ef0] [c01b9520] sys_msgrcv+0x30/0xa0
[eed77f10] [c0003fe8] sys_ipc+0x1a8/0x2c0
[eed77f40] [c00116c4] ret_from_syscall+0x0/0x3c
Instruction dump:
57402834 7c00f850 3920fffe 5d2a003e 397b0010 5500103a 7ceb0214 60000000
60000000 81670000 39080001 38e70004 <7c0be82e> 7c005038 7c0be92e  
81260000
---[ end trace 3c4c3106446e1bd8 ]---


- k
