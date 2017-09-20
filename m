Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxl4K70x1zDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:05:53 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: Traceback due to 'powerpc/mm: Fix kernel RAM protection...' when
 running ppc image in qemu
In-Reply-To: <20170919182459.GA7933@roeck-us.net>
References: <20170919182459.GA7933@roeck-us.net>
Date: Wed, 20 Sep 2017 13:05:48 +1000
Message-ID: <8760ce9iib.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Guenter Roeck <linux@roeck-us.net> writes:

> Hi,
>
> I see a the following traceback when running an SMP image based on
> 85xx/mpc85xx_cds_defconfig in qemu.
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at kernel/smp.c:416 smp_call_function_many+0xcc/0x2fc
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.14.0-rc1-00009-g0666f56 #1
> task: cf830000 task.stack: cf82e000
> NIP:  c00a93c8 LR: c00a9634 CTR: 00000001
> REGS: cf82fde0 TRAP: 0700   Not tainted  (4.14.0-rc1-00009-g0666f56)
> MSR:  00021000 <CE,ME>  CR: 24000082  XER: 00000000
>
> GPR00: c00a9634 cf82fe90 cf830000 c050ad3c c0015a54 00000000 00000001 00000001 
> GPR08: 00000001 00000000 00000000 cf82e000 24000084 00000000 c0003150 00000000 
> GPR16: 00000000 00000000 00000000 00000000 00000000 00000001 00000000 c0510000 
> GPR24: 00000000 c0015a54 00000000 c050ad3c c051823c c050ad3c 00000025 00000000 
> NIP [c00a93c8] smp_call_function_many+0xcc/0x2fc
> LR [c00a9634] smp_call_function+0x3c/0x50
> Call Trace:
> [cf82fe90] [00000010] 0x10 (unreliable)
> [cf82fed0] [c00a9634] smp_call_function+0x3c/0x50
> [cf82fee0] [c0015d2c] flush_tlb_kernel_range+0x20/0x38
> [cf82fef0] [c001524c] mark_initmem_nx+0x154/0x16c
> [cf82ff20] [c001484c] free_initmem+0x20/0x4c
> [cf82ff30] [c000316c] kernel_init+0x1c/0x108
> [cf82ff40] [c000f3a8] ret_from_kernel_thread+0x5c/0x64
> Instruction dump:
> 7c0803a6 7d808120 38210040 4e800020 3d20c052 812981a0 2f890000 40beffac 
> 3d20c051 8929ac64 2f890000 40beff9c <0fe00000> 4bffff94 7fc3f378 7f64db78 
> ---[ end trace 7da7bdcf8b15ddb3 ]---

Thanks.

I guess the system still runs OK otherwise, you're just seeing the warning?

> A complete log is available at:
> http://kerneltests.org/builders/qemu-ppc-master/builds/814/steps/qemubuildcommand/logs/stdio
>
> Bisect points to commit 3184cc4b6f6a1dc0 ("powerpc/mm: Fix kernel RAM protection
> after freeing unused memory on PPC32"). Bisect log is attached. A quick look
> suggests that mark_initmem_nx() is called with interrupts disabled, which
> triggers the traceback.

Hmm. Yes the MSR says you have interrupts disabled (EE missing).

But I don't see why. start_kernel() did local_irq_enable(), so I don't
understand why we got to mark_initmem_nx() with them disabled. I'll hope
that Christophe has some idea.

cheers
