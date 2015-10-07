Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 39F101A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 21:10:55 +1100 (AEDT)
In-Reply-To: <1443578287-7847-3-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, mrochs@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 vaibhav@linux.vnet.ibm.com
Subject: Re: [3/3] cxl: fix leak of ctx->mapping when releasing kernel API
 contexts
Message-Id: <20151007101055.211D31402B4@ozlabs.org>
Date: Wed,  7 Oct 2015 21:10:55 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-30-09 at 01:58:07 UTC, Andrew Donnellan wrote:
> When a context is created via the kernel API, ctx->mapping is allocated
> within the kernel and thus needs to be freed when the context is freed.
> reclaim_ctx() attempts to do this for contexts with the ctx->kernelapi flag
> set, but afu_release() (which can be called from the kernel API through
> cxl_fd_release()) sets ctx->mapping to NULL before calling
> cxl_context_free() to free the context.
> 
> Add a check to afu_release() so that the mappings in contexts created via
> the kernel API are left alone so reclaim_ctx() can free them.
> 
> Reported-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Fixes: 6f7f0b3df6d4 ("cxl: Add AFU virtual PHB and kernel API")
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/5f81b95fe2a2de4ec51d46ff

cheers
