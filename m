Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4cgF3zHmzDqRt
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 14:40:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/xics: Properly set Edge/Level type and enable
 resend
In-Reply-To: <1470105583.12584.5.camel@kernel.crashing.org>
References: <1470105583.12584.5.camel@kernel.crashing.org>
Date: Thu, 04 Aug 2016 14:40:08 +1000
Message-ID: <87twf1f8pj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

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

Broken since forever?

Cc stable?

cheers
