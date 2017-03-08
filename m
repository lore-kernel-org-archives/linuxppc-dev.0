Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdQ6s4lHkzDqYh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 18:25:57 +1100 (AEDT)
In-Reply-To: <20170303005844.21050-1-bsingharora@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/xics,icp-opal: Fix CPPR setting for icp-opal
Message-Id: <3vdQ6s3LwLz9sNW@ozlabs.org>
Date: Wed,  8 Mar 2017 18:25:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-03 at 00:58:44 UTC, Balbir Singh wrote:
> CPPR (Current Processor Priority Register) emulation on icp-opal
> uses a single priority in the backend and that can cause CPU
> hotplug to be affected when we try to send an IPI to it.
> 
> The fix is in migrate_irqs_away, the fix does the following:
> 
> 1. It moves the setting of CPPR to after all IRQ migration
>    is complete
> 2. In icp-opal, we ignore masking the CPPR when the CPPR
> is set to default priority, anything else we just pass
> through
> 
> Right now this fix is designed with backporting to stable
> in mind
> 
> We'll need a newer version of this later when we merge the
> DEFAULT and IPI priorities to the same value in the kernel.
> 
> Fixes: d74361881f0d ("powerpc/xics: Add ICP OPAL backend")
> Cc: stable@vger.kernel.org (v4.8+)
> 
> Testing
> 
> 1. I've tested this fix on a virtual partition running under
>    kvm
> 2. Gautham and Vaidy have done some testing on an system that
>    uses the OPAL backend
> 3. I've also tested this on a system with a native XICS controller
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Reported-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Tested-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a69e2fb70350a66f91175cd2625f1e

cheers
