Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 554121A1799
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Aug 2015 12:27:26 +1000 (AEST)
Message-ID: <1439087233.3715.52.camel@kernel.crashing.org>
Subject: Re: [V3] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 mikey@neuling.org
Date: Sun, 09 Aug 2015 12:27:13 +1000
In-Reply-To: <20150804095726.66D4A1402E2@ozlabs.org>
References: <20150804095726.66D4A1402E2@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-08-04 at 19:57 +1000, Michael Ellerman wrote:
> On Mon, 2015-13-07 at 08:16:06 UTC, Anshuman Khandual wrote:
> > This patch enables facility unavailable exceptions for generic facility,
> > FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
> > newly added IRQ statistical counters as and when these exceptions happen.
> > This also adds couple of helper functions which will be called from within
> > the interrupt handler context to update their statistics. Similarly this
> > patch also enables alignment and program check exceptions as well.
> 
> ...
> 
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 0a0399c2..a86180c 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1158,6 +1158,7 @@ BEGIN_FTR_SECTION
> >  END_FTR_SECTION_IFSET(CPU_FTR_TM)
> >  #endif
> >  	bl	load_up_fpu
> > +	bl	fpu_unav_exceptions_count
> 
> Is it safe to call C code here?

Even if it was (at some stage it wasn't, I'd have to look very closely
to see what's the situation now), we certainly don't want to add
overhead to load_up_fpu.

> >  	b	fast_exception_return
> >  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> >  2:	/* User process was in a transaction */
> 
> 
> cheers
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
