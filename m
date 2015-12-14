Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5297D1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 20:46:37 +1100 (AEDT)
In-Reply-To: <1449448108-9867-1-git-send-email-alistair@popple.id.au>
To: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: dllehr@us.ibm.com, mikey@neuling.org, stable@vger.kernel.org,
 Alistair Popple <alistair@popple.id.au>
Subject: Re: powernv/opal-irqchip: Fix double endian conversion
Message-Id: <20151214094636.D3A40140323@ozlabs.org>
Date: Mon, 14 Dec 2015 20:46:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-07-12 at 00:28:28 UTC, Alistair Popple wrote:
> The OPAL event calls return a mask of events that are active in big
> endian format. This is checked when unmasking the events in the
> irqchip by comparison with a cached value. The cached value was stored
> in big endian format but should've been converted to CPU endian
> first. This bug leads to OPAL event delivery being delayed or dropped
> on some systems.
> 
> The bug is fixed by calling opal_handle_events(...) instead of
> duplicating code in opal_event_unmask(...).
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> Reported-by: Douglas L Lehr <dllehr@us.ibm.com>
> Cc: stable@vger.kernel.org

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/25642e1459ace29f6ce5a171

cheers
