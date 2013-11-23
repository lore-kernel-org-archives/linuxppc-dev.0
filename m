Return-Path: <joseph_myers@mentor.com>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "relay1.mentorg.com",
 Issuer "Entrust Certification Authority - L1C" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C358C2C012E
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Nov 2013 12:22:42 +1100 (EST)
Date: Sat, 23 Nov 2013 01:22:31 +0000
From: "Joseph S. Myers" <joseph@codesourcery.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/6] powerpc: fix exception clearing in e500 SPE float
 emulation
In-Reply-To: <1385159644.1403.532.camel@snotra.buserror.net>
Message-ID: <Pine.LNX.4.64.1311230053360.12354@digraph.polyomino.org.uk>
References: <Pine.LNX.4.64.1311041649250.4290@digraph.polyomino.org.uk>
 <Pine.LNX.4.64.1311041651390.4290@digraph.polyomino.org.uk>
 <1385159644.1403.532.camel@snotra.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: Joseph Myers <joseph@codesourcery.com>
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

On Fri, 22 Nov 2013, Scott Wood wrote:

> This sounds like an incompatible change to userspace API.  What about
> older glibc?  What about user code that directly manipulates these bits
> rather than going through libc, or uses a libc other than glibc?  Where
> is this API requirement documented?

The previous EGLIBC port, and the uClibc code copied from it, is 
fundamentally broken as regards any use of prctl for floating-point 
exceptions because it didn't use the PR_FP_EXC_SW_ENABLE bit in its prctl 
calls (and did various worse things, such as passing a pointer when prctl 
expected an integer).  If you avoid anything where prctl is used, the 
clearing of sticky bits still means it will never give anything 
approximating correct exception semantics with existing kernels.  I don't 
believe the patch makes things any worse for existing code that doesn't 
try to inform the kernel of changes to sticky bits - such code may get 
incorrect exceptions in some cases, but it would have done so anyway in 
other cases.

This is the best API I could come up with to fix the fundamentally broken 
nature of what came before, taking into account that in many cases a prctl 
call is already needed along with userspace manipulation of exception 
bits.  I'm not aware of any kernel documentation where this sort of 
subarchitecture-specific API detail is documented.  (The API also includes 
such things as needing to leave the spefscr trap-enable bits set and use 
prctl to control whether SIGFPE results from exceptions.)

> I think the impact of this could be reduced by using this mechanism only
> to clear bits, rather than set them.  That is, if the exception bit is
> unset, don't set it just because it's set in spefscr_last -- but if it's
> not set in spefscr_last, and the emulation code doesn't want to set it,
> then clear it.

It should already be the case in this patch that if a bit is clear in 
spefscr, and set in spefscr_last (i.e. userspace did not inform the kernel 
of clearing the bit, and no traps since then have resulted in the kernel 
noticing it was cleared), it won't get set unless the emulation code wants 
to set it.  The sole place spefscr_last is read is in the statement 
"__FPU_FPSCR &= ~(FP_EX_INVALID | FP_EX_UNDERFLOW) | 
current->thread.spefscr_last;" - if the bit is already clear in spefscr, 
this statement has no effect on it.

> Are there any cases where the exception bit can be set without the
> kernel taking a trap, or is userspace manipulation limited to clearing
> the bits?

Userspace can both set and clear the bits without a trap.  For example, 
fesetenv restores a saved value of spefscr which may both set and clear 
bits (and then it calls prctl because it needs to do so anyway to restore 
the saved state for which exceptions were enabled).  fesetexceptflag 
restores saved state of particular exceptions without a trap (so needs to 
call prctl specially to inform the kernel of a change).

-- 
Joseph S. Myers
joseph@codesourcery.com
