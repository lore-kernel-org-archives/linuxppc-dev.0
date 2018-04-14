Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Nqjl6ClyzF1pY
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Apr 2018 08:55:23 +1000 (AEST)
In-Reply-To: <20180412134751.25098-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64s: Fix CPU_FTRS_ALWAYS vs DT CPU features
Message-Id: <40Nqjl4wpdz9s15@ozlabs.org>
Date: Sun, 15 Apr 2018 08:55:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-04-12 at 13:47:51 UTC, Michael Ellerman wrote:
> The cpu_has_feature() mechanism has an optimisation where at build
> time we construct a mask of the CPU feature bits that will always be
> true for the given .config, based on the platform/bitness/etc. that we
> are building for.
> 
> That is incompatible with DT CPU features, where the set of CPU
> features is dependent on feature flags that are given to us by
> firmware.
> 
> The result is that some feature bits can not be *disabled* by DT CPU
> features. Or more accurately, they can be disabled but they will still
> appear in the ALWAYS mask, meaning cpu_has_feature() will always
> return true for them.
> 
> In the past this hasn't really been a problem because on Book3S
> 64 (where we support DT CPU features), the set of ALWAYS bits has been
> very small. That was because we always built for POWER4 and later,
> meaning the set of common bits was small.
> 
> The only bit that could be cleared by DT CPU features that was also in
> the ALWAYS mask was CPU_FTR_NODSISRALIGN, and that was only used in
> the alignment handler to create a fake DSISR. That code was itself
> deleted in 31bfdb036f12 ("powerpc: Use instruction emulation
> infrastructure to handle alignment faults") (Sep 2017).
> 
> However the set of ALWAYS features changed with the recent commit
> db5ae1c155af ("powerpc/64s: Refine feature sets for little endian
> builds") which restricted the set of feature flags when building
> little endian to Power7 or later. That caused the ALWAYS mask to
> become much larger for little endian builds.
> 
> The result is that the following feature bits can currently not
> be *disabled* by DT CPU features:
> 
>   CPU_FTR_REAL_LE, CPU_FTR_MMCRA, CPU_FTR_CTRL, CPU_FTR_SMT,
>   CPU_FTR_PURR, CPU_FTR_SPURR, CPU_FTR_DSCR, CPU_FTR_PKEY,
>   CPU_FTR_VMX_COPY, CPU_FTR_CFAR, CPU_FTR_HAS_PPR.
> 
> To fix it we need to mask the set of ALWAYS features with the base set
> of DT CPU features, ie. the features that are always enabled by DT CPU
> features. That way there are no bits in the ALWAYS mask that are not
> also always set by DT CPU features.
> 
> Fixes: db5ae1c155af ("powerpc/64s: Refine feature sets for little endian builds")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/81b654c273914704a4bdf580f28d67

cheers
