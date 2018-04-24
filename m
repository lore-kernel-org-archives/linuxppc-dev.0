Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VTnl2p0szF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 13:48:27 +1000 (AEST)
In-Reply-To: <20180417091129.23069-1-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, mhairgrove@nvidia.com,
 arbab@linux.ibm.com
Subject: Re: [1/2] powernv/npu: Do a PID GPU TLB flush when invalidating a
 large address range
Message-Id: <40VTnl1sdMz9s1b@ozlabs.org>
Date: Tue, 24 Apr 2018 13:48:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-04-17 at 09:11:28 UTC, Alistair Popple wrote:
> The NPU has a limited number of address translation shootdown (ATSD)
> registers and the GPU has limited bandwidth to process ATSDs. This can
> result in contention of ATSD registers leading to soft lockups on some
> threads, particularly when invalidating a large address range in
> pnv_npu2_mn_invalidate_range().
> 
> At some threshold it becomes more efficient to flush the entire GPU TLB for
> the given MM context (PID) than individually flushing each address in the
> range. This patch will result in ranges greater than 2MB being converted
> from 32+ ATSDs into a single ATSD which will flush the TLB for the given
> PID on each GPU.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>
> Tested-by: Balbir Singh <bsingharora@gmail.com>

Patch 1 applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/d0cf9b561ca97d5245bb9e0c4774b7

cheers
