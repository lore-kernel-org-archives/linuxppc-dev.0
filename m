Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ln4V6JcDzF1R7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:49:30 +1000 (AEST)
In-Reply-To: <20180405175631.31381-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, kvm-ppc@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/2] KVM: PPC: Book3S HV: trace_tlbie must not be called in
 realmode
Message-Id: <40Ln4V4S1xz9s3L@ozlabs.org>
Date: Thu, 12 Apr 2018 00:49:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-05 at 17:56:30 UTC, Nicholas Piggin wrote:
> This crashes with a "Bad real address for load" attempting to load
> from the vmalloc region in realmode (faulting address is in DAR).
> 
>   Oops: Bad interrupt in KVM entry/exit code, sig: 6 [#1]
>   LE SMP NR_CPUS=2048 NUMA PowerNV
>   CPU: 53 PID: 6582 Comm: qemu-system-ppc Not tainted 4.16.0-01530-g43d1859f0994
>   NIP:  c0000000000155ac LR: c0000000000c2430 CTR: c000000000015580
>   REGS: c000000fff76dd80 TRAP: 0200   Not tainted  (4.16.0-01530-g43d1859f0994)
>   MSR:  9000000000201003 <SF,HV,ME,RI,LE>  CR: 48082222  XER: 00000000
>   CFAR: 0000000102900ef0 DAR: d00017fffd941a28 DSISR: 00000040 SOFTE: 3
>   NIP [c0000000000155ac] perf_trace_tlbie+0x2c/0x1a0
>   LR [c0000000000c2430] do_tlbies+0x230/0x2f0
> 
> I suspect the reason is the per-cpu data is not in the linear chunk.
> This could be restored if that was able to be fixed, but for now,
> just remove the tracepoints.
> 
> Fixes: 0428491cba ("powerpc/mm: Trace tlbie(l) instructions")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/19ce7909ed11c49f7eddf59e7f49cd

cheers
