Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A9C5DDDEA
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 22:58:25 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lBABwM7x005565
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 06:58:22 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lBABwMvR443612
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 06:58:22 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lBABwMot005228
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Dec 2007 06:58:22 -0500
Date: Mon, 10 Dec 2007 05:54:33 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 23/25] powerpc: Rework 4xx clock probing in boot wrapper
Message-ID: <20071210055433.5cf6fcec@zod.rchland.ibm.com>
In-Reply-To: <1197265411.6563.56.camel@pasglop>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080133.D24A9DE136@ozlabs.org>
	<20071206212744.7257f1a2@zod.rchland.ibm.com>
	<1197265411.6563.56.camel@pasglop>
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

On Mon, 10 Dec 2007 16:43:31 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2007-12-06 at 21:27 -0600, Josh Boyer wrote:
> > On Thu, 06 Dec 2007 19:00:22 +1100
> > Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> > 
> > > Index: linux-work/arch/powerpc/boot/reg.h
> > > ===================================================================
> > > --- linux-work.orig/arch/powerpc/boot/reg.h	2007-12-03 14:26:09.000000000 +1100
> > > +++ linux-work/arch/powerpc/boot/reg.h	2007-12-03 14:26:09.000000000 +1100
> > > @@ -24,6 +24,14 @@ static inline u32 mfpvr(void)
> > >  				: "=r" (rval)); rval; })
> > >  #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
> > > 
> > > +#define __stringify_1(x)	#x
> > > +#define __stringify(x)		__stringify_1(x)
> > > +
> > > +#define mfspr(rn)	({unsigned long rval; \
> > > +			asm volatile("mfspr %0," __stringify(rn) \
> > > +				: "=r" (rval)); rval; })
> > > +#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
> > > +
> > 
> > You felt like duplicating this?  It was added in the previous patch. :)
> 
> Want a new patch or can you just remove that bit ?

I can remove it on my final apply.

josh
