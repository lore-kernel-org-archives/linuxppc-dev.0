Return-Path: <dgibson@bilbo.ozlabs.org>
Date: Tue, 26 May 2009 12:23:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Initialize DBCR0 for PPC440 targets
Message-ID: <20090526022341.GA18801@yookeroo.seuss>
References: <6213bc560905190608j73f4191fxbd94158a2b1740c0@mail.gmail.com>
	<20090519235302.GA6333@yookeroo.seuss>
	<6213bc560905192250w4caa84aem9c0dedb2eed72fea@mail.gmail.com>
	<20090520060014.GL6333@yookeroo.seuss>
	<1243235075.24376.60.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1243235075.24376.60.camel@pasglop>
Cc: srikanth krishnakar <skrishnakar@gmail.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 05:04:35PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2009-05-20 at 16:00 +1000, David Gibson wrote:
> > On Wed, May 20, 2009 at 11:20:46AM +0530, srikanth krishnakar wrote:
> > > Hi David,
> > > 
> > > I am not sure how the IDM behaves on few of PPC440 targets which don't
> > > have boot loaders. I have a reference for your question:
> > > 
> > > http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td23049044.html
> > > 
> > > Without this fix (given patch) I am facing problems with GDB, and
> > > further target hangs while running gdbserver !
> > 
> > That doesn't answer my question.  It's not enough to say "this fixes a
> > problem" you need to explain *how* it fixes the problem.
> > 
> > And I don't see why IDM would have any effect on *software*
> > breakpoints.
> 
> No but gdb can use the DABR emulation and single step would be busted
> too. GDB internally heavily uses single step in places you wouldn't
> expect it to :-) Like I think when breaking on main, it sometimes single
> step the whole init process of the executable until it hits it. At least
> I've seen it do that when I was debugging the debug support for 64-bit
> Book3E.

Right, but I believe the kernel does turn on IDM when it turns on
single step, or the DAC event bit.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
