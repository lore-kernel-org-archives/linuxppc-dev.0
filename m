Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wnq5B3QbyzDqKy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 00:38:54 +1000 (AEST)
Message-ID: <1497451124.2897.43.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/xive: Fix offset for store EOI MMIOs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michaele@au1.ibm.com>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>
Date: Thu, 15 Jun 2017 00:38:44 +1000
In-Reply-To: <87d1a741r2.fsf@concordia.ellerman.id.au>
References: <1497399565.2897.23.camel@kernel.crashing.org>
 <87d1a741r2.fsf@concordia.ellerman.id.au>
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

On Wed, 2017-06-14 at 14:44 +1000, Michael Ellerman wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Architecturally we should apply a 0x400 offset for these. Not doing
> > it will break future HW implementations.
> 
> Can you elaborate a bit?
> 
> You're changing a write to 0x0 to be a write to 0x400, which at face
> value appears like it breaks something, or is already broken?

The code is broken today, I didn't read the spec properly. We never had
a proper DD2 model to test until recently. The offset of 0 is supposed
to remain for "triggers" though not all sources support both trigger
and store EOI, and in P9 specifically, some sources will treat 0 as a
store EOI :-) But future chips will not. So this makes us use the
properly architected offset which should work always.

Cheers,
Ben.

> 
> cheers
> 
> > diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> > index c8a822a..c23ff43 100644
> > --- a/arch/powerpc/include/asm/xive.h
> > +++ b/arch/powerpc/include/asm/xive.h
> > @@ -94,11 +94,13 @@ struct xive_q {
> >   * store at 0 and some ESBs support doing a trigger via a
> >   * separate trigger page.
> >   */
> > -#define XIVE_ESB_GET		0x800
> > -#define XIVE_ESB_SET_PQ_00	0xc00
> > -#define XIVE_ESB_SET_PQ_01	0xd00
> > -#define XIVE_ESB_SET_PQ_10	0xe00
> > -#define XIVE_ESB_SET_PQ_11	0xf00
> > +#define XIVE_ESB_STORE_EOI	0x400 /* Store */
> > +#define XIVE_ESB_LOAD_EOI	0x000 /* Load */
> > +#define XIVE_ESB_GET		0x800 /* Load */
> > +#define XIVE_ESB_SET_PQ_00	0xc00 /* Load */
> > +#define XIVE_ESB_SET_PQ_01	0xd00 /* Load */
> > +#define XIVE_ESB_SET_PQ_10	0xe00 /* Load */
> > +#define XIVE_ESB_SET_PQ_11	0xf00 /* Load */
> >  
> >  #define XIVE_ESB_VAL_P		0x2
> >  #define XIVE_ESB_VAL_Q		0x1
> > diff --git a/arch/powerpc/kvm/book3s_xive_template.c b/arch/powerpc/kvm/book3s_xive_template.c
> > index 023a311..4636ca6 100644
> > --- a/arch/powerpc/kvm/book3s_xive_template.c
> > +++ b/arch/powerpc/kvm/book3s_xive_template.c
> > @@ -69,7 +69,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
> >  {
> >  	/* If the XIVE supports the new "store EOI facility, use it */
> >  	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> > -		__x_writeq(0, __x_eoi_page(xd));
> > +		__x_writeq(0, __x_eoi_page(xd) + XIVE_ESB_STORE_EOI);
> >  	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
> >  		opal_int_eoi(hw_irq);
> >  	} else {
> > @@ -89,7 +89,7 @@ static void GLUE(X_PFX,source_eoi)(u32 hw_irq, struct xive_irq_data *xd)
> >  		 * properly.
> >  		 */
> >  		if (xd->flags & XIVE_IRQ_FLAG_LSI)
> > -			__x_readq(__x_eoi_page(xd));
> > +			__x_readq(__x_eoi_page(xd) + XIVE_ESB_LOAD_EOI);
> >  		else {
> >  			eoi_val = GLUE(X_PFX,esb_load)(xd, XIVE_ESB_SET_PQ_00);
> >  
> > diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
> > index 9138250..8f5e303 100644
> > --- a/arch/powerpc/sysdev/xive/common.c
> > +++ b/arch/powerpc/sysdev/xive/common.c
> > @@ -297,7 +297,7 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
> >  {
> >  	/* If the XIVE supports the new "store EOI facility, use it */
> >  	if (xd->flags & XIVE_IRQ_FLAG_STORE_EOI)
> > -		out_be64(xd->eoi_mmio, 0);
> > +		out_be64(xd->eoi_mmio + XIVE_ESB_STORE_EOI, 0);
> >  	else if (hw_irq && xd->flags & XIVE_IRQ_FLAG_EOI_FW) {
> >  		/*
> >  		 * The FW told us to call it. This happens for some
