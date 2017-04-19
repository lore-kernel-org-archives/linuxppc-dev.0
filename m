Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7bd33fkxzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 08:04:23 +1000 (AEST)
In-Reply-To: <20170418191220.3166-2-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [1/4] powerpc/64s: Revert setting LPCR LPES0 on POWER9
Message-Id: <3w7bd32pXFz9s7m@ozlabs.org>
Date: Thu, 20 Apr 2017 08:04:23 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-18 at 19:12:16 UTC, Nicholas Piggin wrote:
> The XIVE enablement patches set LPES0 on POWER9 host. This bit sets
> external interrupts to guest delivery mode that uses SRR[01]. The host's
> EE interrupt handler expects HSRR[01] (for earlier CPUs). which is fine
> because XIVE is configured not to deliver EE to the host (HVI is used
> instead) so this should never be executed.
> 
> However a bug in interrupt controller code or odd configuration of
> mambo/systemsim could result in the host getting EE. Keeping EE delivery
> mode matching the host handler prevents strange crashes due to using
> the wrong exception registers.
> 
> When running in guest mode and getting EE, the guest LPCR will be
> loaded by KVM which contains the LPES0 bit.
> 
> Fixes: 08a1e650cc ("powerpc: Fixup LPCR:PECE and HEIC setting on POWER9")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8d1b48ef580097e111c2644e6fc604

cheers
