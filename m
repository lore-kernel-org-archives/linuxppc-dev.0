Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A460DDDF7
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Dec 2007 18:11:04 +1100 (EST)
Subject: Re: [PATCH 23/25] powerpc: Rework 4xx clock probing in boot wrapper
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20071206212744.7257f1a2@zod.rchland.ibm.com>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080133.D24A9DE136@ozlabs.org>
	<20071206212744.7257f1a2@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Dec 2007 18:05:43 +1100
Message-Id: <1197183943.6572.16.camel@pasglop>
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


On Thu, 2007-12-06 at 21:27 -0600, Josh Boyer wrote:
> On Thu, 06 Dec 2007 19:00:22 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Index: linux-work/arch/powerpc/boot/reg.h
> > ===================================================================
> > --- linux-work.orig/arch/powerpc/boot/reg.h	2007-12-03 14:26:09.000000000 +1100
> > +++ linux-work/arch/powerpc/boot/reg.h	2007-12-03 14:26:09.000000000 +1100
> > @@ -24,6 +24,14 @@ static inline u32 mfpvr(void)
> >  				: "=r" (rval)); rval; })
> >  #define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
> > 
> > +#define __stringify_1(x)	#x
> > +#define __stringify(x)		__stringify_1(x)
> > +
> > +#define mfspr(rn)	({unsigned long rval; \
> > +			asm volatile("mfspr %0," __stringify(rn) \
> > +				: "=r" (rval)); rval; })
> > +#define mtspr(rn, v)	asm volatile("mtspr " __stringify(rn) ",%0" : : "r" (v))
> > +
> 
> You felt like duplicating this?  It was added in the previous patch. :)

Ah yes, it's a typical mistake when splitting patches, sometimes, it
doesn't complain when the same hunk is applied multiple times. I'll fix
that up.

Ben.
 
