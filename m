Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40582T2MG4zF0n6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 21:15:29 +1100 (AEDT)
In-Reply-To: <20170804034233.13628-1-matthew.brown.dev@gmail.com>
To: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: dja@axtens.net
Subject: Re: [v6,
 1/2] raid6/altivec: Add vpermxor implementation for raid6 Q syndrome
Message-Id: <40582T1bYMz9sZ7@ozlabs.org>
Date: Tue, 20 Mar 2018 21:15:29 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-08-04 at 03:42:32 UTC, Matt Brown wrote:
> This patch uses the vpermxor instruction to optimise the raid6 Q syndrome.
> This instruction was made available with POWER8, ISA version 2.07.
> It allows for both vperm and vxor instructions to be done in a single
> instruction. This has been tested for correctness on a ppc64le vm with a
> basic RAID6 setup containing 5 drives.
> 
> The performance benchmarks are from the raid6test in the /lib/raid6/test
> directory. These results are from an IBM Firestone machine with ppc64le
> architecture. The benchmark results show a 35% speed increase over the best
> existing algorithm for powerpc (altivec). The raid6test has also been run
> on a big-endian ppc64 vm to ensure it also works for big-endian
> architectures.
> 
> Performance benchmarks:
> 		raid6: altivecx4 gen() 18773 MB/s
> 		raid6: altivecx8 gen() 19438 MB/s
> 
> 		raid6: vpermxor4 gen() 25112 MB/s
> 		raid6: vpermxor8 gen() 26279 MB/s
> 
> Signed-off-by: Matt Brown <matthew.brown.dev@gmail.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/751ba79cc552c146595cd439b21c4f

cheers
