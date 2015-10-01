Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 271A11A0FE2
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 16:51:04 +1000 (AEST)
In-Reply-To: <1443578287-7847-2-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 vaibhav@linux.vnet.ibm.com
Subject: Re: [2/3] cxl: fix leak of ctx->irq_bitmap when releasing context via
 kernel API
Message-Id: <20151001065103.3F70F140D6C@ozlabs.org>
Date: Thu,  1 Oct 2015 16:51:03 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-30-09 at 01:58:06 UTC, Andrew Donnellan wrote:
> At present, ctx->irq_bitmap is freed in afu_release_irqs(), which is called
> from afu_release() via cxl_context_detach().
> 
> Move the freeing of ctx->irq_bitmap from afu_release_irqs() to
> reclaim_ctx() (called through cxl_context_free()) so it's freed when
> releasing a context via the kernel API (cxl_release_context()) or the
> userspace API (afu_release()).
> 
> Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/52adee580d3c71a0dfabc316

cheers
