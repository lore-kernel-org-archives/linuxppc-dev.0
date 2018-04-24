Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40VTnk2cJlzF1RV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2018 13:48:26 +1000 (AEST)
In-Reply-To: <20180411063855.5451-1-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, mhairgrove@nvidia.com,
 arbab@linux.ibm.com
Subject: Re: [1/2] powernv/npu: Add lock to prevent race in concurrent context
 init/destroy
Message-Id: <40VTnk1qkgz9rvt@ozlabs.org>
Date: Tue, 24 Apr 2018 13:48:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-11 at 06:38:54 UTC, Alistair Popple wrote:
> The pnv_npu2_init_context() and pnv_npu2_destroy_context() functions are
> used to allocate/free contexts to allow address translation and shootdown
> by the NPU on a particular GPU. Context initialisation is implicitly safe
> as it is protected by the requirement mmap_sem be held in write mode,
> however pnv_npu2_destroy_context() does not require mmap_sem to be held and
> it is not safe to call with a concurrent initialisation for a different
> GPU.
> 
> It was assumed the driver would ensure destruction was not called
> concurrently with initialisation. However the driver may be simplified by
> allowing concurrent initialisation and destruction for different GPUs. As
> npu context creation/destruction is not a performance critical path and the
> critical section is not large a single spinlock is used for simplicity.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reviewed-by: Mark Hairgrove <mhairgrove@nvidia.com>
> Tested-by: Mark Hairgrove <mhairgrove@nvidia.com>
> Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Series applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/28a5933e8d362766462ea9e5f135e1

cheers
