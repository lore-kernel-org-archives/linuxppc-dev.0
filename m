Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7sS55dfQzDqdy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 21:26:45 +1000 (AEST)
In-Reply-To: <1470105583.12584.5.camel@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/xics: Properly set Edge/Level type and enable resend
Message-Id: <3s7sS54c6Mz9t23@ozlabs.org>
Date: Tue,  9 Aug 2016 21:26:45 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 02:39:43 UTC, Benjamin Herrenschmidt wrote:
> This sets the type of the interrupt appropriately. We set it as follow:
> 
>  - If not mapped from the device-tree, we use edge. This is the case
> of the virtual interrupts and PCI MSIs for example.
> 
>  - If mapped from the device-tree and #interrupt-cells is 2 (PAPR
> compliant), we use the second cell to set the appropriate type
> 
>  - If mapped from the device-tree and #interrupt-cells is 1 (current
> OPAL on P8 does that), we assume level sensitive since those are
> typically going to be the PSI LSIs which are level sensitive.
> 
> Additionally, we mark the interrupts requested via the opal_interrupts
> property all level. This is a bit fishy but the best we can do until we
> fix OPAL to properly expose them with a complete descriptor. It is also
> correct for the current HW anyway as OPAL interrupts are currently PCI
> error and PSI interrupts which are level.
> 
> Finally now that edge interrupts are properly identified, we can enable
> CONFIG_HARDIRQS_SW_RESEND which will make the core re-send them if
> they occur while masked, which some drivers rely upon.
> 
> This fixes issues with lost interrupts on some Mellanox adapters.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/880a3d6afd068682d6386a0528

cheers
