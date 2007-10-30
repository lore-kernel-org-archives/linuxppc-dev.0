Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9507EDE1D3
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 08:07:42 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9UL7dxY028010
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 17:07:39 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9UL7btp103348
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 15:07:38 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9UL7bwn023352
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 15:07:37 -0600
Date: Tue, 30 Oct 2007 16:07:36 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] powerpc: Deal with 44x virtually tagged icache
Message-ID: <20071030160736.26afae6c@weaponx.rchland.ibm.com>
In-Reply-To: <1193775391.9928.78.camel@pasglop>
References: <20071030051713.5B8B9DE174@ozlabs.org>
	<20071030072310.51870c65@weaponx.rchland.ibm.com>
	<1193775391.9928.78.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Oct 2007 07:16:31 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > Fortunately, we don't support SMP on these or this solution wouldn't
> > > work.
> > 
> > We should mark 44x BROKEN on SMP in Kconfig.
> 
> Can we enable SMP on 44x at all currently ?

Not without editing the Kconfig.cputypes file.  I was thinking of being
a bit proactive so people didn't just add || 44x to it and think it
would work.  But it's minor.

> > No arch/ppc fix?  I know we all want it to die as soon as possible, but
> > still... :)
> 
> Yeah, I didn't do it yet, which is one reason this patch is marked
> RFC :-)

Fair enough.

> > >  	/* interrupts are hard-disabled at this point */
> > >  restore:
> > > +#ifdef CONFIG_44x
> > > +	lis	r4,icache_44x_need_flush@ha
> > > +	lwz	r5,icache_44x_need_flush@l(r4)
> > > +	cmplwi	cr0,r5,0
> > > +	beq+	1f
> > > +	iccci	r0,r0
> > > +	li	r6,0
> > > +	iccci	r0,r0
> > > +	stw	r6,icache_44x_need_flush@l(r4)
> > > +1:
> > 
> > Why two iccci's here?
> 
> No idea... thinko/typo.

And here I thought you were being extra careful ;)

josh
