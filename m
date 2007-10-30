Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D2AEDE31D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 07:25:14 +1100 (EST)
Subject: Re: [RFC/PATCH] powerpc: Deal with 44x virtually tagged icache
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071030072310.51870c65@weaponx.rchland.ibm.com>
References: <20071030051713.5B8B9DE174@ozlabs.org>
	<20071030072310.51870c65@weaponx.rchland.ibm.com>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 07:16:31 +1100
Message-Id: <1193775391.9928.78.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Fortunately, we don't support SMP on these or this solution wouldn't
> > work.
> 
> We should mark 44x BROKEN on SMP in Kconfig.

Can we enable SMP on 44x at all currently ?

> No arch/ppc fix?  I know we all want it to die as soon as possible, but
> still... :)

Yeah, I didn't do it yet, which is one reason this patch is marked
RFC :-)

> >  	/* interrupts are hard-disabled at this point */
> >  restore:
> > +#ifdef CONFIG_44x
> > +	lis	r4,icache_44x_need_flush@ha
> > +	lwz	r5,icache_44x_need_flush@l(r4)
> > +	cmplwi	cr0,r5,0
> > +	beq+	1f
> > +	iccci	r0,r0
> > +	li	r6,0
> > +	iccci	r0,r0
> > +	stw	r6,icache_44x_need_flush@l(r4)
> > +1:
> 
> Why two iccci's here?

No idea... thinko/typo.

Ben.
