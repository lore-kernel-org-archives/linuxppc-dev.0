Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zFnkc081JzF0RR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jan 2018 08:01:28 +1100 (AEDT)
Date: Tue, 9 Jan 2018 08:01:23 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, tglx@linutronix.de, npiggin@gmail.com,
 anton@samba.org, mikey@neuling.org, oohall@gmail.com
Subject: Re: [PATCH 03/11] powerpc/64s: Simple RFI macro conversions
Message-ID: <20180108210123.GA9895@fergus.ozlabs.ibm.com>
References: <20180108165453.26066-1-mpe@ellerman.id.au>
 <20180108165453.26066-3-mpe@ellerman.id.au>
 <20180108170951.GB6176@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180108170951.GB6176@hirez.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 08, 2018 at 06:09:51PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 09, 2018 at 03:54:45AM +1100, Michael Ellerman wrote:
> > diff --git a/arch/powerpc/kvm/book3s_rmhandlers.S b/arch/powerpc/kvm/book3s_rmhandlers.S
> > index 42a4b237df5f..34a5adeff084 100644
> > --- a/arch/powerpc/kvm/book3s_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_rmhandlers.S
> > @@ -46,6 +46,9 @@
> >  
> >  #define FUNC(name)		name
> >  
> > +#define RFI_TO_KERNEL	RFI
> > +#define RFI_TO_GUEST	RFI
> > +
> >  .macro INTERRUPT_TRAMPOLINE intno
> >  
> >  .global kvmppc_trampoline_\intno
> 
> Leftovers? The previous patch seems to define all that in common
> headers, why redefine here again?

Not leftovers - this is for the sake of 32-bit compiles.  There is
code in this file and in book3s_segment.S which gets used both for
32-bit and 64-bit kernels, and this is supplying a definition on
32-bit platforms.  Without this, 32-bit builds that have PR KVM
configured will fail.

Paul.
