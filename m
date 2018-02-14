Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zh7cf1xsrzF12y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 16:43:46 +1100 (AEDT)
In-Reply-To: <20180208091838.27992-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/vas: do not set uses_vas for kernel windows
Message-Id: <3zh7cf17qqz9t3F@ozlabs.org>
Date: Wed, 14 Feb 2018 16:43:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-02-08 at 09:18:38 UTC, Nicholas Piggin wrote:
> cp_abort is only required or user windows, because kernel context
> must not be preempted between a copy/paste pair.
> 
> Without this patch, the init task gets used_vas set when it runs
> the nx842_powernv_init initcall, which opens windows for kernel
> usage.
> 
> used_vas is then never cleared anywhere, so it gets propagated
> into all other tasks. It's a property of the address space, so it
> should really be cleared when a new mm is created (or in dup_mmap
> if the mmaps are marked as VM_DONTCOPY). For now we seem to have
> no such driver, so leave that for another patch.
> 
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/b00b62898631b756c3e123542bbb04

cheers
