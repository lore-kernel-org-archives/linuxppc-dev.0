Message-ID: <3858FCC5.C0520AFA@email.sps.mot.com>
Date: Thu, 16 Dec 1999 08:52:53 -0600
From: "Richard Hendricks" <ra6353@email.sps.mot.com>
MIME-Version: 1.0
To: Alan Mimms <alan@packetengines.com>
CC: Dan Malek <dan@netx4.com>, Jim Chapman <jim.chapman@iname.com>,
        bsimon@ctam.com.au,
        linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <3857F56C.65411CA4@netx4.com> <385807D7.8262398C@email.sps.mot.com> <99121513483409.00750@alan.corp.packetengines.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>




Alan Mimms wrote:
> 
> > The only possible problem I could see is if you had a routine that
> > flushed the caches manually.  Of course, if you did, you probably
> > needed to be slapped anyways.
> 
> Richard, how DO you flush the cache if you need to do so without doing it
> "manually"?  Say I have a boot ROM that loads code into RAM and wants to flush
> the cache afterwards so the D cache is coherent wrt the I cache.  I need to
> flush all of the dirty D cache lines out.  Is there some other usage of
> "manually" that I am missing?  Of course, I ALWAYS loop over the entire area
> I am flushing using a DCBF/ICBI for each addressable cache line boundary (16
> bytes for MPC8xx processors).

Sorry, what I meant here was if you were flushing the whole cache
manually, using the special commands provided.  Using the DCBF 
instructions to flush specific locations is always a good idea, and
isn't a problem.  IE, it's portable across all processors (so long
as they have the same cache line size, or your program accounts for it.)
 
> > > > Dan, can you tell us if the DMA operations on the 8xx processors are cache
> > > > coherent?
> > >
> > > Yes, I can tell you, and no they are not.
> >
> > Dan's correct, they are not.  The caches sit between the CPU
> > (really the MMUs) and the bus.  The DMA controller is part of the
> > CPM, which also sits on the bus.  The 8xx family doesn't support
> > any kind of snooping for those type of accesses.  You can either mark
> > the locations you need to DMA non-cacheable (if you plan on writing to
> > the memory), or as write-through (if you plan on reading from them).
> > Just basic good system design.
> 
> Actually and arguably, "good system design" says precisely the opposite.  If
> you're building up, say, network protocol packets to be DMAed out through a FEC
> you want to be able to touch the area of the packet buffer repeatedly without
> having to do a memory cycle for each "touch".  Cacheable packet buffers are the
> only way to get this performance enhancing behavior.  The added benefit that
> you get burst accesses to RAM comes with caches ON as well.

Caches on, with a read to an inhibited memory area, will burst read 
into a single-cache-line read buffer internally.

>  Write-thru won't
> get you either of these benefits, if I understand what "write thru" means for
> MPC8xx, since it will always start a memory write cycle after each access.
> There will be no attempt to aggregate the accesses to adjacent bytes, shorts or
> longs into cache line bursts out to RAM unless the cache is in full copy back
> mode.  You get this performance at the cost of having to "manually" (there's
> that word again!) flush the cache for the area of the bufferr before starting
> the DMA.  For receive operations, you can simply invalidate (rather than
> flush - cheaper) the cache for the range but only if the buffer is guaranteed to
> span the entire cache line aligned region.
> 
> > > > ..... so I have erred on the conservative side and in my drivers
> > > > have done cache flushing operations before/after each DMA as appropriate for
> > > > DMA direction.
> > >
> > > What kind of drivers are you using?  The only thing likely to
> > > perform DMA on the 8xx is the CPM.  There are already CPM functions
> > > for managing this stuff, which is a combination of uncached
> > > memory and cache management.  Try to use something that already
> > > exists, or at least use it as a model for something special
> > > you are doing.
> >
> > Being conservative never hurt anyone...Unless it seriously hurts your
> > performance, I wouldn't worry to heavily about it.  BTW, you shouldn't
> > be caching the internal memory map, including DPRAM, and memory
> > areas the CPM writes to.
> 
> That much was clear.  My IMMR and DPRAM areas are non-cacheable.
> 
> > > > ....  MOT sent us 40 chips of which 4 or 5 were rev A.
> > >
> > > Cool.  Make key chains out of them.  Seriously, depending upon
> > > what you are trying to accomplish, the Rev. A parts should work
> > > fine.  It may take a few software patches, but they will work.
> >
> > Really?  Wow.  Rev. A's.  Maybe you *should* make keychains out
> > of them.  I can't remember which fixes went in between A and B3,
> > but you should be able to find them on the website in the various
> > errata.
> 
> Note that these were rev A MPC850s not MPC860s.  Are these two chip families
> basically the same except for marketing and perhaps a process revision, or am
> I smoking something?

Oh, I assumed they were Rev. A MPC860's.  The Rev. A MPC823/MPC850
is much much better than the Rev. A MPC860/MPC821.  If I remember
correctly, the Rev. Z3 MPC823's correspond to Rev. B3 MPC821, so
a Rev. A MPC823/MPC850 is "better" than a MPC821/MPC860 Rev B3.

> > There were/are tons and tons of I2C errata.  Most related to > multi-master
> > mode.  Another long and sordid story, no doubt.
> >
> > > > wait for the boards to which rev A 850s had been nailed to be reworked (several
> > > > days' turnaround) to get working boards so I can bring them up and give them to
> > > > the other software folks.
> > >
> > > There are advantages to working with people with Motorola connections.
> > >
> > > > It also appears that there are a lot of errata associated with the MPC850 rev
> > > > A parts which are ostensibly fixed (and, in my experience, ARE fixed) in rev B.
> > >
> > > Every revision is better, but Rev. B still has some things to work
> > > around.
> >
> > Really?  Hopefully nothing I need to worry about.  Figuring out the
> > G14 errata for the MPC823 was a life-unaffirming experience.
> >
> > >         -- Dan
> >
> > BTW, Brendan, I work in Motorola supporting the MPC821/MPC823,
> > and I tend to lurk on this mailing list as well as comp.sys.powerpc.tech
> 
> BTW, Richard, you may be a very very useful resource for those of us paving new
> ground on these parts.  Can I be so bold as to hit you with the occasional deep
> technical question?  I promise it won't be often...  Really.

I support MPC821/MPC823 parts.  If a question is related to these
two, or is something obviously similar, ie UPM on the MPC850 say, then
I would be more than happy to at least try to answer it.  Seeing as
the MPC860/MPC850 support team has about 10x the engineers of the
MPC821/MPC823 support team, you can understand why any really deep
MPC850/MPC860 questions need to be sent to them. :)
 
> Thanks for the info.
> 
>  --
> Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
>   USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
> Despite the cost of living, have you noticed how popular it remains?
>   -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
