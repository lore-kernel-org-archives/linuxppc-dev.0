Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zxgf17mSzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jun 2018 00:11:26 +1000 (AEST)
In-Reply-To: <20180530103122.27674-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Fix compiler store ordering to SLB shadow area
Message-Id: <40zxgd3sqlz9s0w@ozlabs.org>
Date: Tue,  5 Jun 2018 00:11:22 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-05-30 at 10:31:22 UTC, Nicholas Piggin wrote:
> The stores to update the SLB shadow area must be made as they appear
> in the C code, so that the hypervisor does not see an entry with
> mismatched vsid and esid. Use WRITE_ONCE for this.
> 
> GCC has been observed to elide the first store to esid in the update,
> which means that if the hypervisor interrupts the guest after storing
> to vsid, it could see an entry with old esid and new vsid, which may
> possibly result in memory corruption.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/926bc2f100c24d4842b3064b5af44a

cheers
