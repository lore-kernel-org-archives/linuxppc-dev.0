Subject: Re: pismo upgraded to 750fx not detected correctly
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Chris Studholme <cvs@cs.utoronto.ca>,
	linuxppc-dev@lists.linuxppc.org,
	Terry Greeniaus <tgree@phys.ualberta.ca>
In-Reply-To: <20030623082751.GA2738@iram.es>
References: <1056275365.3808.49.camel@gaston>
	 <Pine.LNX.4.44.0306230032020.17411-100000@stoa.dhs.org>
	 <20030623082751.GA2738@iram.es>
Content-Type: text/plain
Message-Id: <1056390396.9642.46.camel@gaston>
Mime-Version: 1.0
Date: 23 Jun 2003 19:46:37 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > ***************
> > *** 127,132 ****
> > --- 148,158 ----
> >   	slwi	r4,r4,2
> >   	sub	r8,r8,r3
> >   	stwx	r8,r4,r6
> > +
> > + 	addis	r6,r3,real_pvr@ha
> > + 	addi	r6,r6,real_pvr@l
> > + 	stwx	r7,0,r6
>
> A bit convoluted no? r3 is supposed to be zero, so
> the standard way of performing this is:

Well... he may be called while the kernel hasn't been relocated
yet, so he should take r3 into account at this point.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
