Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 562CDDDECA
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 17:26:17 +1000 (EST)
Date: Wed, 30 Jul 2008 09:26:11 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Lockless get_user_pages_fast()
Message-ID: <20080730072611.GA7986@wotan.suse.de>
References: <1217389038.11188.285.camel@pasglop>
	<1217391656.11188.292.camel@pasglop>
	<1217394382.10646.13.camel@localhost>
	<1217394520.11188.298.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1217394520.11188.298.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 03:08:40PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2008-07-30 at 15:06 +1000, Michael Ellerman wrote:
> > > +
> > > +/*
> > > + * The performance critical leaf functions are made noinline otherwise gcc
> > > + * inlines everything into a single function which results in too much
> > > + * register pressure.
> > > + */
> > 
> > This strikes me as something that is liable to change for compiler
> > version n+1, or n with -fsomething - and might leave us shooting
> > ourselves in the foot, just a thought.
> > 
> 
> Not that much I'd say... In fact, I wouldn't be too worried on powerpc,
> I wonder if that comment is stale from the x86 variant :-) Nick ?

Right... gcc is really poor at over pressuing registers when inlining,
and when I checked I don't think it even allocated registers to the
inner-most variables in cases such as this.

I thought I checked powerpc and sound some spilling there too, but it
was quite a long time ago (and yes it was brought over from x86). Should
double check.
