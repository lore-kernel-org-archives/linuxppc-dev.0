Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1B771A127F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 22:57:32 +1100 (AEDT)
In-Reply-To: <1449138559-10205-1-git-send-email-ldufour@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, aneesh.kumar@linux.vnet.ibm.com,
 kda@linux-powerpc.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: xemul@parallels.com
Subject: Re: [v5] powerpc/mm: Add page soft dirty tracking
Message-Id: <20151217115732.7AB091402E2@ozlabs.org>
Date: Thu, 17 Dec 2015 22:57:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-12 at 10:29:19 UTC, Laurent Dufour wrote:
> User space checkpoint and restart tool (CRIU) needs the page's change
> to be soft tracked. This allows to do a pre checkpoint and then dump
> only touched pages.
> 
> This is done by using a newly assigned PTE bit (_PAGE_SOFT_DIRTY) when
> the page is backed in memory, and a new _PAGE_SWP_SOFT_DIRTY bit when
> the page is swapped out.
> 
> To introduce a new PTE _PAGE_SOFT_DIRTY bit value common to hash 4k
> and hash 64k pte, the bits already defined in hash-*4k.h should be
> shifted left by one.
> 
> The _PAGE_SWP_SOFT_DIRTY bit is dynamically put after the swap type in
> the swap pte. A check is added to ensure that the bit is not
> overwritten by _PAGE_HPTEFLAGS.
> 
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7207f43665b83ed7881c5111bc

cheers
