Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY55L37zMzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 19:23:50 +1000 (AEST)
Message-ID: <1466414623.27324.2.camel@ellerman.id.au>
Subject: Re: unrecoverable exception on G5 with CONFIG_PPC_EARLY_DEBUG enabled
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Denis Kirjanov
 <kda@linux-powerpc.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 20 Jun 2016 19:23:43 +1000
In-Reply-To: <87eg7u8li9.fsf@skywalker.in.ibm.com>
References: <CAOJe8K1S9-AjJ106rQJMmTg_5238RzKgjFb9dyGuDY5ddydkgQ@mail.gmail.com>
 <1465216025.2658.7.camel@ellerman.id.au>
 <CAOJe8K1bBf-J6ZJq+VfVv+CVcwGyff32beGL4kXaZBr5ZL9hmw@mail.gmail.com>
 <1466078830.19127.0.camel@ellerman.id.au>
 <CAOJe8K2L8D1M_yZPmyiZ11JvJ+HAS0aFHOnsqaY=xLOnQTA3AA@mail.gmail.com>
 <1466116390.24271.27.camel@kernel.crashing.org>
 <1466127964.12899.5.camel@ellerman.id.au>
 <87eg7u8li9.fsf@skywalker.in.ibm.com>
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

On Sat, 2016-06-18 at 22:47 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > On Fri, 2016-06-17 at 08:33 +1000, Benjamin Herrenschmidt wrote:
> > > On Thu, 2016-06-16 at 22:49 +0300, Denis Kirjanov wrote:
> > > > -
> > > > +BEGIN_MMU_FTR_SECTION
> > > > +       b       2f
> > > > +END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
> > > >         andi.   r10,r12,MSR_RI  /* check for unrecoverable exception
> > > > */
> > > >         beq-    2f
> > > 
> > > Are we taking an SLB miss before we do the fixup maybe ?
> > 
> > Yeah that's the only explanation that makes any sense.
> > 
> > I think instead of patching down this low we should instead be redirecting SLB
> > misses to unknown_exception() when radix is enabled. Aneesh?
> 
> The 2f branch ends up doing unrecoverable exception. Or are you
> suggesting something else ?

I meant more like diverting to unknown_exception() higher up the call stack, but
that's complicated.

How about this? Denis does this work?

cheers

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4c9440629128..8bcc1b457115 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1399,11 +1399,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 
 	mtlr	r10
-BEGIN_MMU_FTR_SECTION
-	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
+BEGIN_MMU_FTR_SECTION
 	beq-	2f
+FTR_SECTION_ELSE
+	b	2f
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 
 .machine	push
 .machine	"power4"
