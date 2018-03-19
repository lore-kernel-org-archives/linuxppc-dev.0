Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404rDB2pFpzF0xN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 09:22:50 +1100 (AEDT)
In-Reply-To: <1518232806-17661-1-git-send-email-mhairgrove@nvidia.com>
To: Mark Hairgrove <mhairgrove@nvidia.com>, <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alistair Popple <alistair@popple.id.au>,
 Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: powerpc/npu-dma.c: Fix crash after __mmu_notifier_register failure
Message-Id: <404rD852wzz9sVw@ozlabs.org>
Date: Tue, 20 Mar 2018 09:22:47 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2018-02-10 at 03:20:06 UTC, Mark Hairgrove wrote:
> pnv_npu2_init_context wasn't checking the return code from
> __mmu_notifier_register. If  __mmu_notifier_register failed, the
> npu_context was still assigned to the mm and the caller wasn't given any
> indication that things went wrong. Later on pnv_npu2_destroy_context would
> be called, which in turn called mmu_notifier_unregister and dropped
> mm->mm_count without having incremented it in the first place. This led to
> various forms of corruption like mm use-after-free and mm double-free.
> 
> __mmu_notifier_register can fail with EINTR if a signal is pending, so
> this case can be frequent.
> 
> This patch calls opal_npu_destroy_context on the failure paths, and makes
> sure not to assign mm->context.npu_context until past the failure points.
> 
> Signed-off-by: Mark Hairgrove <mhairgrove@nvidia.com>
> Acked-By: Alistair Popple <alistair@popple.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/720c84046c26444fe825f8614ddceb

cheers
