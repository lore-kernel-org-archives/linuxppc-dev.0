Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41h9LG4tw5zF1pj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 23:01:58 +1000 (AEST)
In-Reply-To: <20180731132452.15994-1-fbarrat@linux.ibm.com>
To: Frederic Barrat <fbarrat@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 vaibhav@linux.ibm.com, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: clombard@linux.ibm.com, felix@linux.ibm.com
Subject: Re: powerpc/64s/radix: Fix missing global invalidations when removing
 copro
Message-Id: <41h9LG2MKpz9s9F@ozlabs.org>
Date: Thu,  2 Aug 2018 23:01:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-07-31 at 13:24:52 UTC, Frederic Barrat wrote:
> With the optimizations for TLB invalidation from commit 0cef77c7798a
> ("powerpc/64s/radix: flush remote CPUs out of single-threaded
> mm_cpumask"), the scope of a TLBI (global vs. local) can now be
> influenced by the value of the 'copros' counter of the memory context.
> 
> When calling mm_context_remove_copro(), the 'copros' counter is
> decremented first before flushing. It may have the unintended side
> effect of sending local TLBIs when we explicitly need global
> invalidations in this case. Thus breaking any nMMU user in a bad and
> unpredictable way.
> 
> Fix it by flushing first, before updating the 'copros' counter, so
> that invalidations will be global.
> 
> Fixes: 0cef77c7798a ("powerpc/64s/radix: flush remote CPUs out of single-threaded mm_cpumask")
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/cca19f0b684f4ed6aabf6ad07ae3e1

cheers
