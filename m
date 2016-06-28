Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rf37p2YMMzDqnv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 21:13:10 +1000 (AEST)
Message-ID: <1467112384.16036.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Use VM_WARN_ONCE() for irqs disabled check
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@ozlabs.org
Cc: Anton Blanchard <anton@samba.org>
Date: Tue, 28 Jun 2016 21:13:04 +1000
In-Reply-To: <87furx6189.fsf@skywalker.in.ibm.com>
References: <1467095901-4634-1-git-send-email-mpe@ellerman.id.au>
 <87furx6189.fsf@skywalker.in.ibm.com>
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

On Tue, 2016-06-28 at 16:15 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
> > index ee09e99097f0..651848039dc4 100644
> > --- a/arch/powerpc/include/asm/pgtable.h
> > +++ b/arch/powerpc/include/asm/pgtable.h
> > @@ -71,10 +71,8 @@ pte_t *__find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
> >  static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
> >  					       bool *is_thp, unsigned *shift)
> >  {
> > -	if (!arch_irqs_disabled()) {
> > -		pr_info("%s called with irq enabled\n", __func__);
> > -		dump_stack();
> > -	}
> > +	VM_WARN_ONCE(!arch_irqs_disabled(),
> > +		     "find_linux_pte_or_hugepte() called with irqs enabled!\n");
> >  	return __find_linux_pte_or_hugepte(pgdir, ea, is_thp, shift);
> >  }
> > 
> 
> https://lkml.kernel.org/r/574de240.uG8/5OM2Lu9RY6K+%akpm@linux-foundation.orgdd
> 
> Isn't this patch already part of -mm.

Ugh, yes. I missed that you'd already sent it.

> And why ONCE, we want to find about all the wrong usage.

Sure, but if you hit it repeatedly in a common path you're likely to kill the
box just with console spam.

But I don't mind. Ignore this version.

cheers
