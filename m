Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RgC41KqfzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2018 23:42:08 +1000 (AEST)
In-Reply-To: <20180411033758.20794-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, sam.bobroff@au1.ibm.com,
 Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
Subject: Re: powerpc/eeh: Fix enabling bridge MMIO windows
Message-Id: <40RgC33D1fz9s2B@ozlabs.org>
Date: Thu, 19 Apr 2018 23:42:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-04-11 at 03:37:58 UTC, Michael Neuling wrote:
> On boot we save the configuration space of PCIe bridges. We do this so
> when we get an EEH event and everything gets reset that we can restore
> them.
> 
> Unfortunately we save this state before we've enabled the MMIO space
> on the bridges. Hence if we have to reset the bridge when we come back
> MMIO is not enabled and we end up taking an PE freeze when the driver
> starts accessing again.
> 
> This patch forces the memory/MMIO and bus mastering on when restoring
> bridges on EEH. Ideally we'd do this correctly by saving the
> configuration space writes later, but that will have to come later in
> a larger EEH rewrite. For now we have this simple fix.
> 
> The original bug can be triggered on a boston machine by doing:
>   echo 0x8000000000000000 > /sys/kernel/debug/powerpc/PCI0001/err_injct_outbound
> On boston, this PHB has a PCIe switch on it.  Without this patch,
> you'll see two EEH events, 1 expected and 1 the failure we are fixing
> here. The second EEH event causes the anything under the PHB to
> disappear (i.e. the i40e eth).
> 
> With this patch, only 1 EEH event occurs and devices properly recover.
> 
> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: stable@vger.kernel.org
> Acked-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/13a83eac373c49c0a081cbcd137e79

cheers
