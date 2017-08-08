Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRWw92DlszDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 21:12:57 +1000 (AEST)
In-Reply-To: <1502189757-11623-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: schwab@linux-m68k.org, npiggin@gmail.com
Subject: Re: Revert "powerpc/64: Avoid restore_math call if possible in
 syscall exit"
Message-Id: <3xRWw904g6z9s83@ozlabs.org>
Date: Tue,  8 Aug 2017 21:12:56 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 10:55:57 UTC, Michael Ellerman wrote:
> This reverts commit bc4f65e4cf9d6cc43e0e9ba0b8648cf9201cd55f.
> 
> As reported by Andreas, this commit is causing unrecoverable SLB misses in the
> system call exit path:
> 
>   Unrecoverable exception 4100 at c00000000000a1ec
>   Oops: Unrecoverable exception, sig: 6 [#1]
>   SMP NR_CPUS=2 PowerMac
>   ...
>   CPU: 0 PID: 18626 Comm: rm Not tainted 4.13.0-rc3 #1
>   task: c00000018335e080 task.stack: c000000139e50000
>   NIP: c00000000000a1ec LR: c00000000000a118 CTR: 0000000000000000
>   REGS: c000000139e53bb0 TRAP: 4100   Not tainted  (4.13.0-rc3)
>   MSR: 9000000000001030 <SF,HV,ME,IR,DR> CR: 24000044  XER: 20000000 SOFTE: 1
>   GPR00: 0000000000000000 c000000139e53e30 c000000000abb500 fffffffffffffffe
>   GPR04: c0000001eb866298 0000000000000000 0000000000000000 c00000018335e080
>   GPR08: 900000000000d032 0000000000000000 0000000000000002 fffffffffffff001
>   GPR12: c000000139e50000 c00000000ffff000 00003fffa8c0dca0 00003fffa8c0dc88
>   GPR16: 0000000010000000 0000000000000001 00003fffa8c0eaa0 0000000000000000
>   GPR20: 00003fffa8c27528 00003fffa8c27b00 0000000000000000 0000000000000000
>   GPR24: 00003fffa8c0d918 00003ffff1b3efa0 00003fffa8c26d68 0000000000000000
>   GPR28: 00003fffa8c249e8 00003fffa8c263d0 00003fffa8c27550 00003ffff1b3ef10
>   NIP [c00000000000a1ec] system_call_exit+0xc0/0x21c
>   LR [c00000000000a118] system_call+0x58/0x6c
>   Call Trace:
>   [c000000139e53e30] [c00000000000a118] system_call+0x58/0x6c (unreliable)
>   Instruction dump:
>   64a51000 7c6300d0 f8a101a0 4bffff9c 3c000000 60000006 780007c6 64000000
>   60000000 7c004039 4082001c e8ed0170 <88070b78> 88c70b79 7c003214 2c200000
> 
> This is caused by us trying to load THREAD_LOAD_FP with MSR_RI=0, and taking an
> SLB miss on the thread struct.
> 
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Diagnosed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/44a12806d010944a5727f1dc991231

cheers
