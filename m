Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434441A1D3E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Aug 2015 12:52:30 +1000 (AEST)
Message-ID: <1439520749.2056.4.camel@ellerman.id.au>
Subject: Re: [V3] powerpc/irq: Enable some more exceptions in
 /proc/interrupts interface
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
Date: Fri, 14 Aug 2015 12:52:29 +1000
In-Reply-To: <55C35FF4.9050001@linux.vnet.ibm.com>
References: <20150804095726.66D4A1402E2@ozlabs.org>
 <55C35FF4.9050001@linux.vnet.ibm.com>
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

On Thu, 2015-08-06 at 18:54 +0530, Anshuman Khandual wrote:
> On 08/04/2015 03:27 PM, Michael Ellerman wrote:
> > On Mon, 2015-13-07 at 08:16:06 UTC, Anshuman Khandual wrote:
> >> This patch enables facility unavailable exceptions for generic facility,
> >> FPU, ALTIVEC and VSX in /proc/interrupts listing by incrementing their
> >> newly added IRQ statistical counters as and when these exceptions happen.
> >> This also adds couple of helper functions which will be called from within
> >> the interrupt handler context to update their statistics. Similarly this
> >> patch also enables alignment and program check exceptions as well.
> > 
> > ...
> > 
> >> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> >> index 0a0399c2..a86180c 100644
> >> --- a/arch/powerpc/kernel/exceptions-64s.S
> >> +++ b/arch/powerpc/kernel/exceptions-64s.S
> >> @@ -1158,6 +1158,7 @@ BEGIN_FTR_SECTION
> >>  END_FTR_SECTION_IFSET(CPU_FTR_TM)
> >>  #endif
> >>  	bl	load_up_fpu
> >> +	bl	fpu_unav_exceptions_count
> > 
> > Is it safe to call C code here?
> 
> Hmm, is it not ? I had that question but was not really sure. Dont
> understand the difference between 'fast_exception_return' and
> 'ret_from_except' completely.

If you're "not really sure" it's correct, please say so in the change log!

I'd rather you didn't send me patches with possibly subtle bugs in core code.

cheers
