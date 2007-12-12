Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: michael@ellerman.id.au
Subject: Re: [PATCH 1/2] Make setjmp/longjmp code generic 
In-reply-to: <1197500215.7695.11.camel@concordia> 
References: <20071212054512.882AC62C070@localhost.localdomain>
	<1197500215.7695.11.camel@concordia>
Date: Thu, 13 Dec 2007 10:40:44 +1100
Message-ID: <29085.1197502844@neuling.org>
Cc: linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com,
	Paul Mackerras <paulus@samba.org>, THEMANN@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> >  arch/powerpc/xmon/setjmp.S    |  135 ------------------------------------------

<snip> 
 
> > +#ifdef CONFIG_XMON
> > +/*
> > + * Grab the register values as they are now.
> > + * This won't do a particularily good job because we really
> > + * want our caller's caller's registers, and our caller has
> > + * already executed its prologue.
> > + * ToDo: We could reach back into the caller's save area to do
> > + * a better job of representing the caller's state (note that
> > + * that will be different for 32-bit and 64-bit, because of the
> > + * different ABIs, though).
> > + */
> > +_GLOBAL(xmon_save_regs)
> > +	PPC_STL	r0,0*SZL(r3)
> > +	PPC_STL	r2,2*SZL(r3)
> > +	PPC_STL	r3,3*SZL(r3)
> > +	PPC_STL	r4,4*SZL(r3)
> 
> Does xmon_save_regs belong here?

This was the only function left in xmon/setjmp.S.  So rather than rename
the whole file to reflect it no longer has anything to do with setjmp, I
moved it out to misc.S

I'm not fussed what we end up doing.

Mikey
