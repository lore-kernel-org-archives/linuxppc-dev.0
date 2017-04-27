Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCsG0JYrzDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:30:58 +1000 (AEST)
In-Reply-To: <1493213240-5260-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, anton@samba.org
Subject: Re: [v2,1/2] powerpc/mm/radix: Optimise Page Walk Cache flush
Message-Id: <3wDCsF6P2Sz9sNZ@ozlabs.org>
Date: Thu, 27 Apr 2017 20:30:57 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-26 at 13:27:19 UTC, Michael Ellerman wrote:
> Currently we implement flushing of the page walk cache (PWC) by calling
> _tlbiel_pid() with a RIC (Radix Invalidation Control) value of 1 which says to
> only flush the PWC.
> 
> But _tlbiel_pid() loops over each set (congruence class) of the TLB, which is
> not necessary when we're just flushing the PWC.
> 
> In fact the set argument is ignored for a PWC flush, so essentially we're just
> flushing the PWC 127 extra times for no benefit.
> 
> Fix it by adding tlbiel_pwc() which just does a single flush of the PWC.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> [mpe: Split out of combined patch, drop _ in name, rewrite change log]
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/5a9853946c2e7a5ef9ef5302ecada6

cheers
