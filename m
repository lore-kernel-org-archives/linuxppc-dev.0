Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY25T0W0lzDsNS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 08:09:01 +1000 (AEST)
In-Reply-To: <1473225390-4281-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: powernv: Restore SPRs correctly upon wake up from hypervisor
 state loss
Message-Id: <3sY25S6bdKz9sdn@ozlabs.org>
Date: Tue, 13 Sep 2016 08:09:00 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-07-09 at 05:16:30 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> pnv_wakeup_tb_loss function currently expects the cr4 to be "eq" if
> the CPU is waking up from a complete hypervisor state loss. Hence, it
> currently restores the SPR contents only if cr4 is "eq".
> 
> However, after the commit bcef83a00dc4 ("powerpc/powernv: Add platform
> support for stop instruction"), on ISA_V300 CPUs, the function
> pnv_restore_hyp_resource sets cr4 to contain the result of the
> comparison between state the CPU has woken up and the first deepest
> stop state before calling pnv_wakeup_tb_loss.
> 
> Thus if the CPU woke up from a state that is deeper than the first
> deepest stop state, cr4 have "gt" set and hence, pnv_wakeup_tb_loss
> will fail to restore the SPRs on waking up from such a state.
> 
> Fix the code in pnv_wakeup_tb_loss to restore the SPR states when cr4 is
> "eq" or "gt".
> 
> Fixes: Commit bcef83a00dc4 ("powerpc/powernv: Add platform support for stop instruction")
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Reviewed-by: Shreyas B. Prabhu <shreyasbp@gmail.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/bd00a240dc52e28706fbbe3ace

cheers
