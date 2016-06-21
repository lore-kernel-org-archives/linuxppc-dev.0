Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYTsF17THzDrBg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 10:59:45 +1000 (AEST)
Message-ID: <1466470784.9938.2.camel@ellerman.id.au>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 21 Jun 2016 10:59:44 +1000
In-Reply-To: <87a8igyxcx.fsf@skywalker.in.ibm.com>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
 <1466078830.19127.0.camel@ellerman.id.au>
 <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
 <1466116390.24271.27.camel@kernel.crashing.org>
 <1466127964.12899.5.camel@ellerman.id.au>
 <87eg7u8li9.fsf@skywalker.in.ibm.com>
 <1466414623.27324.2.camel@ellerman.id.au>
 <87a8igyxcx.fsf@skywalker.in.ibm.com>
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

On Mon, 2016-06-20 at 15:51 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index 4c9440629128..8bcc1b457115 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -1399,11 +1399,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
> >  	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
> > 
> >  	mtlr	r10
> > -BEGIN_MMU_FTR_SECTION
> > -	b	2f
> > -END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
> >  	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
> > +BEGIN_MMU_FTR_SECTION
> >  	beq-	2f
> > +FTR_SECTION_ELSE
> > +	b	2f
> > +ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
> > 
> >  .machine	push
> >  .machine	"power4"
> 
> I sent a patch which should get this problem fixed.
> 
> http://mid.gmane.org/1466274479-5650-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com

Well s/fixed/avoided/.

I'd rather we fixed the root cause, which is that the SLB miss handler is broken
until code patching happens. When possible we should write feature sections so
that the unpatched code is functional, to avoid problems like this.

cheers
