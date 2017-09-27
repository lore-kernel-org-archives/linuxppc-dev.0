Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2Df71ZqTzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 20:32:15 +1000 (AEST)
In-Reply-To: <1504766144.12628.15.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Russell Currey <ruscur@au1.ibm.com>
Subject: Re: [2/2] powerpc/powernv: Rework EEH initialization on powernv
Message-Id: <3y2Df70nk9z9tXs@ozlabs.org>
Date: Wed, 27 Sep 2017 20:32:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-09-07 at 06:35:44 UTC, Benjamin Herrenschmidt wrote:
> Remove the post_init callback which is only used
> by powernv, we can just call it explicitly from
> the powernv code.
> 
> This partially kills the ability to "disable" eeh at
> runtime via debugfs as this was calling that same
> callback again, but this is both unused and broken
> in several ways. If we want to revive it, we need
> to create a dedicated enable/disable callback on the
> backend that does the right thing.
> 
> Let the bulk of eeh initialize normally at
> core_initcall() like it does on pseries by removing
> the hack in eeh_init() that delays it.
> 
> Instead we make sure our eeh->probe cleanly bails
> out of the PEs haven't been created yet and we force
> a re-probe where we used to call eeh_init() again.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Acked-by: Russell Currey <ruscur@russell.cc>

Patch 2 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b9fde58db7e5738cacb740b0ec5479

cheers
