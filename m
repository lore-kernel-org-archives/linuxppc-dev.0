Return-Path: <scottwood@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 46C372C012E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 09:34:58 +1100 (EST)
Message-ID: <1385159644.1403.532.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/6] powerpc: fix exception clearing in e500 SPE float
 emulation
From: Scott Wood <scottwood@freescale.com>
To: "Joseph S. Myers" <joseph@codesourcery.com>
Date: Fri, 22 Nov 2013 16:34:04 -0600
In-Reply-To: <Pine.LNX.4.64.1311041651390.4290@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1311041651390.4290@digraph.polyomino.org.uk>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Liu Yu <yu.liu@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Shan Hai <shan.hai@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-11-04 at 16:52 +0000, Joseph S. Myers wrote:
> From: Joseph Myers <joseph@codesourcery.com>
> 
> The e500 SPE floating-point emulation code clears existing exceptions
> (__FPU_FPSCR &= ~FP_EX_MASK;) before ORing in the exceptions from the
> emulated operation.  However, these exception bits are the "sticky",
> cumulative exception bits, and should only be cleared by the user
> program setting SPEFSCR, not implicitly by any floating-point
> instruction (whether executed purely by the hardware or emulated).
> The spurious clearing of these bits shows up as missing exceptions in
> glibc testing.
> 
> Fixing this, however, is not as simple as just not clearing the bits,
> because while the bits may be from previous floating-point operations
> (in which case they should not be cleared), the processor can also set
> the sticky bits itself before the interrupt for an exception occurs,
> and this can happen in cases when IEEE 754 semantics are that the
> sticky bit should not be set.  Specifically, the "invalid" sticky bit
> is set in various cases with non-finite operands, where IEEE 754
> semantics do not involve raising such an exception, and the
> "underflow" sticky bit is set in cases of exact underflow, whereas
> IEEE 754 semantics are that this flag is set only for inexact
> underflow.  Thus, for correct emulation the kernel needs to know the
> setting of these two sticky bits before the instruction being
> emulated.
> 
> When a floating-point operation raises an exception, the kernel can
> note the state of the sticky bits immediately afterwards.  Some
> <fenv.h> functions that affect the state of these bits, such as
> fesetenv and feholdexcept, need to use prctl with PR_GET_FPEXC and
> PR_SET_FPEXC anyway, and so it is natural to record the state of those
> bits during that call into the kernel and so avoid any need for a
> separate call into the kernel to inform it of a change to those bits.
> Thus, the interface I chose to use (in this patch and the glibc port)
> is that one of those prctl calls must be made after any userspace
> change to those sticky bits, other than through a floating-point
> operation that traps into the kernel anyway.

This sounds like an incompatible change to userspace API.  What about
older glibc?  What about user code that directly manipulates these bits
rather than going through libc, or uses a libc other than glibc?  Where
is this API requirement documented?

I think the impact of this could be reduced by using this mechanism only
to clear bits, rather than set them.  That is, if the exception bit is
unset, don't set it just because it's set in spefscr_last -- but if it's
not set in spefscr_last, and the emulation code doesn't want to set it,
then clear it.

Are there any cases where the exception bit can be set without the
kernel taking a trap, or is userspace manipulation limited to clearing
the bits?

-Scott
