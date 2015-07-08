Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C3F9F1A1992
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 20:54:08 +1000 (AEST)
In-Reply-To: <1436230877-14542-1-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 imunsie@au.ibm.com
Subject: Re: cxl: Fix refcounting in kernel API
Message-Id: <20150708105408.82DA9140AF3@ozlabs.org>
Date: Wed,  8 Jul 2015 20:54:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-07-07 at 01:01:17 UTC, Michael Neuling wrote:
> Currently the kernel API AFU dev refcounting is done on context start and stop.
> This patch moves this refcounting to context init and release, bringing it
> inline with how the userspace API does it.
> 
> Without this we've seen the refcounting on the AFU get out of whack between the
> user and kernel API usage.  This causes the AFU structures to be freed when
> they are actually still in use.
> 
> This fixes some kref warnings we've been seeing and spurious ErrIVTE IRQs.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/cgit/linux/kernel/git/powerpc/linux.git/commit/?h=fixes&id=3f8dc44d88d3e86178eb9322c779c599f3745b21

cheers
