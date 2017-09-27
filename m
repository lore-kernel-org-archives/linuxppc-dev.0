Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2Df81SnZzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 20:32:16 +1000 (AEST)
In-Reply-To: <20170915052549.8105-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [1/2] powerpc: Add workaround for P9 vector CI load issue
Message-Id: <3y2Df80GwFz9tXw@ozlabs.org>
Date: Wed, 27 Sep 2017 20:32:15 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-09-15 at 05:25:48 UTC, Michael Neuling wrote:
> POWER9 DD2.1 and earlier has an issue where some cache inhibited
> vector load will return bad data. The workaround is two part, one
> firmware/microcode part triggers HMI interrupts when hitting such
> loads, the other part is this patch which then emulates the
> instructions in Linux.
> 
> The affected instructions are limited to lxvd2x, lxvw4x, lxvb16x and
> lxvh8x.
> 
> When an instruction triggers the HMI, all threads in the core will be
> sent to the HMI handler, not just the one running the vector load.
> 
> In general, these spurious HMIs are detected by the emulation code and
> we just return back to the running process. Unfortunately, if a
> spurious interrupt occurs on a vector load that's to normal memory we
> have no way to detect that it's spurious (unless we walk the page
> tables, which is very expensive). In this case we emulate the load but
> we need do so using a vector load itself to ensure 128bit atomicity is
> preserved.
> 
> Some additional debugfs emulated instruction counters are added also.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Patch 1 applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/5080332c2c893118dbc18755f35c8b

cheers
