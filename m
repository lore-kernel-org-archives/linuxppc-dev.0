Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMl211RWzzDvgS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 21:19:05 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Set missing wakeup bit in LPCR on POWER9
In-Reply-To: <1479712085.10230.31.camel@kernel.crashing.org>
References: <1479712085.10230.31.camel@kernel.crashing.org>
Date: Mon, 21 Nov 2016 21:19:04 +1100
Message-ID: <87h971w2xz.fsf@concordia.ellerman.id.au>
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

> There is a new bit, LPCR_PECEu0, which controls wakeup from STOP
> states on Hypervisor Virtualization Interrupts (which happen to
> also be all external interrupts in host or bare metal mode).
>
> It needs to be set or we will miss wakeups.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Paul, I haven't fixed KVM. You probably should include such a fix
> as part of your KVM-on-power9 series.
>
> Michael: That should probably go to -stable as far as P9 support goes.

I ended up with:

    powerpc: Set missing wakeup bit in LPCR on POWER9
    
    There is a new bit, LPCR_PECE_HVEE (Hypervisor Virtualization Exit
    Enable), which controls wakeup from STOP states on Hypervisor
    Virtualization Interrupts (which happen to also be all external
    interrupts in host or bare metal mode).
    
    It needs to be set or we will miss wakeups.
    
    Fixes: 9baaef0a22c8 ("powerpc/irq: Add support for HV virtualization interrupts")
    Cc: stable@vger.kernel.org # v4.8+
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    [mpe: Rename it to HVEE to match the name in the ISA]
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
