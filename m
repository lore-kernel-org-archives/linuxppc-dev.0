Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbDNt05xBzDsd1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 21:59:57 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nicholas Piggin' <npiggin@gmail.com>
CC: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH][RFC] Implement arch primitives for busywait loops
Date: Fri, 16 Sep 2016 11:57:37 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB00FF831@AcuExch.aculab.com>
References: <20160916085736.7857-1-npiggin@gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DB00FF7D8@AcuExch.aculab.com>
 <20160916215200.2775f252@roar.ozlabs.ibm.com>
In-Reply-To: <20160916215200.2775f252@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Nicholas Piggin
> Sent: 16 September 2016 12:52
> On Fri, 16 Sep 2016 11:30:58 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
>=20
> > From: Nicholas Piggin
> > > Sent: 16 September 2016 09:58
> > > Implementing busy wait loops with cpu_relax() in callers poses
> > > some difficulties for powerpc.
> > >
> > > First, we want to put our SMT thread into a low priority mode for the
> > > duration of the loop, but then return to normal priority after exitin=
g
> > > the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' a=
s
> > > cpu_relax() does may have HMT_medium take effect before HMT_low made
> > > any (or much) difference.
> > >
> > > Second, it can be beneficial for some implementations to spin on the
> > > exit condition with a statically predicted-not-taken branch (i.e.,
> > > always predict the loop will exit).
> > >
> > > This is a quick RFC with a couple of users converted to see what
> > > people think. I don't use a C branch with hints, because we don't wan=
t
> > > the compiler moving the loop body out of line, which makes it a bit
> > > messy unfortunately. If there's a better way to do it, I'm all ears.
> >
> > I think it will still all go wrong if the conditional isn't trivial.
> > In particular if the condition contains || or && it is likely to
> > have a branch - which could invert the loop.
>=20
> I don't know that it will.
>=20
> Yes, if we have exit condition that requires more branches in order to
> be computed then we lose our nice property of never taking a branch
> miss on loop exit. But we still avoid *this* branch miss, and still
> prevent multiple iterations of the wait loop being speculatively
> executed concurrently when there's no work to be done.
>=20
> And C doesn't know about the loop, so it can't do any transformation
> except to compute the final condition.
>=20
> Or have I missed something?

Try putting the code inside a conditional or at the bottom of a loop.
gcc can replicate code to remove a branch.

So:
	for (;;) {
		a;
		if (b)
			c;
		d;
	}

can become:
   x1:
	a;
	if (b) to x2;
	d;
	goto x1;

    x2:
	c;
	d;
	goto x1;

Which won't work.

	David
