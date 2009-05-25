Return-Path: <benh@kernel.crashing.org>
Subject: Re: Initialize DBCR0 for PPC440 targets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20090520060014.GL6333@yookeroo.seuss>
References: <6213bc560905190608j73f4191fxbd94158a2b1740c0@mail.gmail.com>
	<20090519235302.GA6333@yookeroo.seuss>
	<6213bc560905192250w4caa84aem9c0dedb2eed72fea@mail.gmail.com>
	<20090520060014.GL6333@yookeroo.seuss>
Content-Type: text/plain
Date: Mon, 25 May 2009 17:04:35 +1000
Message-Id: <1243235075.24376.60.camel@pasglop>
Mime-Version: 1.0
Cc: srikanth krishnakar <skrishnakar@gmail.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-05-20 at 16:00 +1000, David Gibson wrote:
> On Wed, May 20, 2009 at 11:20:46AM +0530, srikanth krishnakar wrote:
> > Hi David,
> > 
> > I am not sure how the IDM behaves on few of PPC440 targets which don't
> > have boot loaders. I have a reference for your question:
> > 
> > http://www.nabble.com/Question-about-DBCR0-initialization-for-440-td23049044.html
> > 
> > Without this fix (given patch) I am facing problems with GDB, and
> > further target hangs while running gdbserver !
> 
> That doesn't answer my question.  It's not enough to say "this fixes a
> problem" you need to explain *how* it fixes the problem.
> 
> And I don't see why IDM would have any effect on *software*
> breakpoints.

No but gdb can use the DABR emulation and single step would be busted
too. GDB internally heavily uses single step in places you wouldn't
expect it to :-) Like I think when breaking on main, it sometimes single
step the whole init process of the executable until it hits it. At least
I've seen it do that when I was debugging the debug support for 64-bit
Book3E.

Cheers,
Ben.

> > On Wed, May 20, 2009 at 5:23 AM, David Gibson
> > <david@gibson.dropbear.id.au> wrote:
> > > On Tue, May 19, 2009 at 06:38:53PM +0530, srikanth krishnakar wrote:
> > >> Hi,
> > >>
> > >> kernel- 2.6.29
> > >> Debug technique: KGDB
> > >>
> > >> The PowerPC kernel does not initialize the PPC440 DBCR0 register. This
> > >> prevents the use of software breakpoints in case of internal debug
> > >> mode. Looking into head_fsl_booke.S for initialization of DBCR0 is
> > >> used by boot-loaders.
> > >> It seems head_44x.S lacks this step of DBCR0 register initialization.
> > >> So fixing this with initializing the DBCR0 register as shown below :
> > >>
> > >> Subject: [PATCH] powerpc: 44x: Initialize DBCR0 for targets not having
> > >> bootloader
> > >>
> > >> The kernel does not initialize the PPC440 DBCR0 register.
> > >> This prevents (among other things) the use of software
> > >> breakpoints with GDB. The boot loaders probably do initialize
> > >> this but few targets run without a boot loader
> > >
> > > Um.. how does this prevent the use of software breakpoints with gdb?
> > > The trap instructions still work with IDM==0.
> 
