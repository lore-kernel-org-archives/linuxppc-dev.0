Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyz3QsgzDr64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
In-Reply-To: <1508386123-2726-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/64s: Replace CONFIG_PPC_STD_MMU_64 with
 CONFIG_PPC_BOOK3S_64
Message-Id: <3yWlyy0dyNz9sRg@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:17 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 04:08:43 UTC, Michael Ellerman wrote:
> CONFIG_PPC_STD_MMU_64 indicates support for the "standard" powerpc MMU
> on 64-bit CPUs. The "standard" MMU refers to the hash page table MMU
> found in "server" processors, from IBM mainly.
> 
> Currently CONFIG_PPC_STD_MMU_64 is == CONFIG_PPC_BOOK3S_64. While it's
> annoying to have two symbols that always have the same value, it's not
> quite annoying enough to bother removing one.
> 
> However with the arrival of Power9, we now have the situation where
> CONFIG_PPC_STD_MMU_64 is enabled, but the kernel is running using the
> Radix MMU - *not* the "standard" MMU. So it is now actively confusing
> to use it, because it implies that code is disabled or inactive when
> the Radix MMU is in use, however that is not necessarily true.
> 
> So s/CONFIG_PPC_STD_MMU_64/CONFIG_PPC_BOOK3S_64/, and do some minor
> formatting updates of some of the affected lines.
> 
> This will be a pain for backports, but c'est la vie.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/4e003747043d57aa75c9762fa148ef

cheers
