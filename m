Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4CYj6jsnzDqBY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 07:48:41 +1000 (AEST)
In-Reply-To: <1462337578-15883-1-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>, mikey <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>, Frederic Barrat <frederic.barrat@fr.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: cxl: Ensure PSL interrupt is configured for contexts with no AFU
 IRQs
Message-Id: <3r4CYj5yD6z9t6W@ozlabs.org>
Date: Wed, 11 May 2016 07:48:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-04-05 at 04:52:58 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> In the cxl kernel API, it is possible to create a context and start it
> without allocating any interrupts. Since we assign or allocate the PSL
> interrupt when allocating AFU interrupts this will lead to a situation
> where we start the context with no means to take any faults.
> 
> The user API is not affected as it always goes through the cxl interrupt
> allocation code paths and will have the PSL interrupt allocated or
> assigned, even if no AFU interrupts were requested.
> 
> This checks that at least one interrupt is configured at the time of
> attach, and if not it will assign the multiplexed PSL interrupt for
> powernv, or allocate a single interrupt for PowerVM.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b75d94509921cb6d9f475d7a85

cheers
