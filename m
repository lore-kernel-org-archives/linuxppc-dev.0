Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjgLH3l3dzDqRM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 21:36:07 +1000 (AEST)
In-Reply-To: <20170705035627.19563-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [v2,
 1/3] powerpc: do not call ppc_md.panic in fadump panic notifier
Message-Id: <3xjgLH1hs0z9t2y@ozlabs.org>
Date: Thu, 31 Aug 2017 21:36:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-05 at 03:56:25 UTC, Nicholas Piggin wrote:
> If fadump is not registered, and no other crash or debug handlers are
> registered, the powerpc panic handler stops the guest before the generic
> panic code can push out debug information to the console.
> 
> Currently, system reset injection causes the guest to silently
> stop.
> 
> Stop calling ppc_md.panic in the panic notifier. crash_fadump already
> does rtas_os_term() to terminate the guest if fadump is registered.
> 
> Remove ppc_md.panic. Move fadump panic notifier into fadump code.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a3b2cb30f252b21a6f962e0dd107c8

cheers
