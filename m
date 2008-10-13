Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B0750DE01D
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 03:20:58 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m9DGKped007556
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 09:20:51 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m9DGKLtF008272
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:20:21 -0500 (CDT)
Date: Mon, 13 Oct 2008 11:20:20 -0500
From: Scott Wood <scottwood@freescale.com>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] powerpc: implement optimised mutex fastpaths
Message-ID: <20081013162020.GC19080@ld0162-tx32.am.freescale.net>
References: <20081012054634.GA12535@wotan.suse.de>
	<20081012054732.GB12535@wotan.suse.de>
	<20081013161547.GB19080@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081013161547.GB19080@ld0162-tx32.am.freescale.net>
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

On Mon, Oct 13, 2008 at 11:15:47AM -0500, Scott Wood wrote:
> On Sun, Oct 12, 2008 at 07:47:32AM +0200, Nick Piggin wrote:
> > +static inline int __mutex_cmpxchg_lock(atomic_t *v, int old, int new)
> > +{
> > +	int t;
> > +
> > +	__asm__ __volatile__ (
> > +"1:	lwarx	%0,0,%1		# mutex trylock\n\
> > +	cmpw	0,%0,%2\n\
> > +	bne-	2f\n"
> > +	PPC405_ERR77(0,%1)
> > +"	stwcx.	%3,0,%1\n\
> > +	bne-	1b"
> > +	ISYNC_ON_SMP
> > +	"\n\
> > +2:"
> > +	: "=&r" (t)
> > +	: "r" (&v->counter), "r" (old), "r" (new)
> > +	: "cc", "memory");
> 
> This will break if the compiler picks r0 for &v->counter.  Use "b" as the
> constraint, or better yet do "lwarx %0, %y1", with a "Z" (v->counter)
> constraint.

Sorry, had a morning brain-fart there -- you're not using the base
register.

-Scott
