Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7bDN0spqzDqk7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 22:46:44 +1000 (AEST)
In-Reply-To: <1499775054-631-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/64: Fix atomic64_inc_not_zero() to return an int
Message-Id: <3x7bDM6dDgz9sNw@ozlabs.org>
Date: Thu, 13 Jul 2017 22:46:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-11 at 12:10:54 UTC, Michael Ellerman wrote:
> Although it's not documented anywhere, there is an expectation that
> atomic64_inc_not_zero() returns a result which fits in an int. This is
> the behaviour implemented on all arches except powerpc.
> 
> This has caused at least one bug in practice, in the percpu-refcount
> code, where the long result from our atomic64_inc_not_zero() was
> truncated to an int leading to lost references and stuck systems. That
> was worked around in that code in commit 966d2b04e070 ("percpu-refcount:
> fix reference leak during percpu-atomic transition").
> 
> To the best of my grepping abilities there are no other callers
> in-tree which truncate the value, but we should fix it anyway. Because
> the breakage is subtle and potentially very harmful I'm also tagging
> it for stable.
> 
> Code generation is largely unaffected because in most cases the
> callers are just using the result for a test anyway. In particular the
> case of fget() that was mentioned in commit a6cf7ed5119f
> ("powerpc/atomic: Implement atomic*_inc_not_zero") generates exactly
> the same code.
> 
> Fixes: a6cf7ed5119f ("powerpc/atomic: Implement atomic*_inc_not_zero")
> Cc: stable@vger.kernel.org # v3.4
> Noticed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/01e6a61aceb82e13bec29502a8eb70

cheers
