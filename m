Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZx0z3cc3zDqks
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 19:26:27 +1000 (AEST)
In-Reply-To: <1466132722-13512-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Fix invalid cached PE primary bus
Message-Id: <3rZx0z0vk1z9t17@ozlabs.org>
Date: Thu, 23 Jun 2016 19:26:27 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-17-06 at 03:05:11 UTC, Gavin Shan wrote:
> The PE primary bus cannot be got from its child devices when having
> full hotplug in error recovery. The PE primary bus is cached, which
> is done in commit <05ba75f84864> ("powerpc/eeh: Fix stale cached primary
> bus"). In eeh_reset_device(), the flag (EEH_PE_PRI_BUS) is cleared
> before the PCI hot remove. eeh_pe_bus_get() then returns NULL as the
> PE primary bus in pnv_eeh_reset() and it crashes the kernel eventually.
> 
> This fixes the issue by clearing the flag (EEH_PE_PRI_BUS) before the
> PCI hot add. With it, the PowerNV EEH reset backend (pnv_eeh_reset())
> can get valid PE primary bus through eeh_pe_bus_get().
> 
> Fixes: 67086e32b564 ("powerpc/eeh: powerpc/eeh: Support error recovery for VF PE")
> Reported-by: Pridhiviraj Paidipeddi <ppaiddipe@in.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a3aa256b7258b3d19f8b44557c

cheers
