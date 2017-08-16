Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTFD5H0mzDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:29:52 +1000 (AEST)
In-Reply-To: <1502175992-13626-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/iommu: Avoid undefined right shift in iommu_range_alloc()
Message-Id: <3xXTFD2yt6z9t4Z@ozlabs.org>
Date: Wed, 16 Aug 2017 22:29:52 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-08 at 07:06:32 UTC, Michael Ellerman wrote:
> In iommu_range_alloc() we generate a mask by right shifting ~0,
> however if the specified alignment is 0 then we right shift by 64,
> which is undefined. UBSAN tells us so:
> 
>   UBSAN: Undefined behaviour in ../arch/powerpc/kernel/iommu.c:193:35
>   shift exponent 64 is too large for 64-bit type 'long unsigned int'
> 
> We can avoid it by instead generating the mask with:
> 
>   align_mask = (1ull << align_order) - 1;
> 
> That will also generate an undefined shift if align_order is 64 or
> greater, but that shouldn't be a problem for a while.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/63b85621d9aa6bdc410f01b22f7821

cheers
