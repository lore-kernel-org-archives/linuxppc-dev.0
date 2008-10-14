Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (ns1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC072DDE2A
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 18:06:27 +1100 (EST)
Date: Tue, 14 Oct 2008 09:06:22 +0200
From: Nick Piggin <npiggin@suse.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081014070621.GA2681@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081012054732.GB12535@wotan.suse.de>
	<20081013161547.GB19080@ld0162-tx32.am.freescale.net>
	<20081013162020.GC19080@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081013162020.GC19080@ld0162-tx32.am.freescale.net>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Ingo Molnar <mingo@elte.hu>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 13, 2008 at 11:20:20AM -0500, Scott Wood wrote:
> On Mon, Oct 13, 2008 at 11:15:47AM -0500, Scott Wood wrote:
> > On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> > > +static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
> > > +{
> > > +	int t;
> > > +
> > > +	__asm__ __volatile__ (
> > > +"1:	lwarx	%0,0,%1		# mutex trylock\n\
> > > +	cmpw	0,%0,%2\n\
> > > +	bne-	2f\n"
> > > +	PPC405_ERR77(0,%1)
> > > +"	stwcx.	%3,0,%1\n\
> > > +	bne-	1b"
> > > +	ISYNC_ON_SMP
> > > +	"\n\
> > > +2:"
> > > +	: "=&r" (t)
> > > +	: "r" (&v->counter), "r" (old), "r" (new)
> > > +	: "cc", "memory");
> > 
> > This will break if the compiler picks r0 for &v->counter.  Use "b" as the
> > constraint, or better yet do "lwarx %0, %y1", with a "Z" (v->counter)
> > constraint.
> 
> Sorry, had a morning brain-fart there -- you're not using the base
> register.

OK no problem. Do you think it looks OK? Thanks for reviewing...
