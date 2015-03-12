Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86A9A1A0394
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Mar 2015 10:26:32 +1100 (AEDT)
Message-ID: <1426202791.2772.1.camel@ellerman.id.au>
Subject: Re: [RFC] powerpc: e6500 optimised copy_to_user/copy_from_user
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kim Phillips <kim.phillips@freescale.com>
Date: Fri, 13 Mar 2015 10:26:31 +1100
In-Reply-To: <20150312174549.2b735117897e772bc91e29a4@freescale.com>
References: <20150312174549.2b735117897e772bc91e29a4@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-12 at 17:45 -0500, Kim Phillips wrote:
> This mimics commit a66086b8197da8dc83b698642d5947ff850e708d "powerpc:
> POWER7 optimised copy_to_user/copy_from_user using VMX", but for
> the e6500, or BOOK3S_64.  Changes have been made for the smaller
> cacheline size (64 bytes on e6500), and data cache block touch (dcbt)
> instructions have been rewritten to prefetch 8 lines ahead, based
> on preliminary benchmark results and perf -e L1-dcache-prefetches
> and misses observations.
> 
> We see a gain of 5% in large netperf benchmarks between two T4240s,
> both in terms of throughput, and latency.  The same netperf
> lo(opback) test improves 27%.
> 
> Anton's microbenchmark results show a clear linear improvement path
> with sizes 32KB and above, where, below that, the additional overhead
> over the existing copyuser_64 implementation shows its head: e.g., 6%
> for 1448 byte copies.  The observed transfer sizes under large,
> netperf benchmarks show the TCP stack is invoking copies on the
> order of a few 10's of KB, however. 1MB transfers are 30% better-off
> on wall clock time.
> 
> RFC because of the following known issues:
> - unsure if PPC_BOOK3E_64 vs. PPC_BOOK3S_64 build-time switch to
>   re-target __copy_tofrom_user_vmx is appropriate (ppc64_defconfig
>   builds fine, however)

That's fine, a combined kernel is not really on the horizon.

> - syscalls report deficits when folding vmx_unaligned_copy to a 64B
>   cacheline (undone for this RFC)
> - any consideration for the e5500?
> - asm branch label re-enumeration
> - ..I'm sure I've missed another couple of things, possibly
> including how to fix lower-sized transfer performance

Well the big issue for me is the code duplication. The diff between the
original and yours is not small, but it looks like doing a combined version
*should* be possible?

If you take out the 8 line prefetch changes it looks like it's just the
cacheline size that is the issue?

cheers
