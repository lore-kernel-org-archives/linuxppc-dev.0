Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tK88Z6YrSzDvrN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 16:00:46 +1100 (AEDT)
In-Reply-To: <1479184113.2608.45.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anton Blanchard <anton@au1.ibm.com>
Subject: Re: powerpc/64: Fix setting of AIL in hypervisor mode
Message-Id: <3tK88Z4mXzz9t0X@ozlabs.org>
Date: Thu, 17 Nov 2016 16:00:46 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-15-11 at 04:28:33 UTC, Benjamin Herrenschmidt wrote:
> Commit d3cbff1b5 "powerpc: Put exception configuration in a common place"
> broke the setting of the AIL bit (which enables taking exceptions with
> the MMU still on) on all processors, moving it incorrectly to a function
> called only on the boot CPU. This was correct for the guest case but
> not when running in hypervisor mode.
> 
> This fixes it by partially reverting that commit, putting the setting
> back in cpu_ready_for_interrupts()
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Fixes: d3cbff1b5 ("powerpc: Put exception configuration in a common place")
> CC: stable@vger.kernel.org # v4.8+

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/c0a36013639b06760f7c2c21a8387e

cheers
