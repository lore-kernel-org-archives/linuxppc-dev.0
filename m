Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wJCHX0TNYzDqFt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 May 2017 08:19:04 +1000 (AEST)
In-Reply-To: <1493786699-14850-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, npiggin@gmail.com, anton@samba.org
Subject: Re: powerpc/mm/radix: Drop support for CPUs without lockless tlbie
Message-Id: <3wJCHW665Wz9s03@ozlabs.org>
Date: Thu,  4 May 2017 08:19:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-05-03 at 04:44:59 UTC, Michael Ellerman wrote:
> Currently the radix TLB code includes support for CPUs that do *not*
> have MMU_FTR_LOCKLESS_TLBIE. On those CPUs we are required to take a
> global spinlock before issuing a tlbie.
> 
> Radix can only be built for 64-bit Book3s CPUs, and of those, only
> POWER4, 970, Cell and PA6T do not have MMU_FTR_LOCKLESS_TLBIE. Although
> it's possible to build a kernel with Radix support that can also boot on
> those CPUs, we happen to know that in reality none of those CPUs support
> the Radix MMU, so the code can never actually run on those CPUs.
> 
> So remove the native_tlbie_lock in the Radix TLB code.
> 
> Note that there is another lock of the same name in the hash code, which
> is unaffected by this patch.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/3c9ac2bcc35453141f82461c71ed10

cheers
