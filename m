Return-Path: <srs0=ddu1=ed=infradead.org=peterz@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFhbY23rDzF0by
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 04:10:01 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zFhbX288Kz8wQy
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 04:10:00 +1100 (AEDT)
Date: Mon, 8 Jan 2018 18:09:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, npiggin@gmail.com, anton@samba.org,
 mikey@neuling.org, oohall@gmail.com, paulus@samba.org
Subject: Re: [PATCH 03/11] powerpc/64s: Simple RFI macro conversions
Message-ID: <20180108170951.GB6176@hirez.programming.kicks-ass.net>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-3-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108165453.26066-3-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 09, 2018 at 03:54:45AM +1100, Michael Ellerman wrote:
> diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
> index 42a4b237df5f..34a5adeff084 100644
> --- a/arch/powerpc/kvm/book3s_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_rmhandlers.S
> @@ -46,6 +46,9 @@
>  
>  #define FUNC(name)		name
>  
> +#define RFI_TO_KERNEL	RFI
> +#define RFI_TO_GUEST	RFI
> +
>  .macro INTERRUPT_TRAMPOLINE intno
>  
>  .global kvmppc_trampoline_\intno

Leftovers? The previous patch seems to define all that in common
headers, why redefine here again?
