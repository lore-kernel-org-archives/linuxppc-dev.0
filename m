From: Alan Mimms <alan@packetengines.com>
To: Jim Chapman <jim.chapman@iname.com>, bsimon@ctam.com.au
Subject: Re: linuxppc-embedded: /bin/sh wont run from nfsroot.
Date: Wed, 15 Dec 1999 10:56:46 -0800
Content-Type: text/plain
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
References: <19991215055541.23843.qmail@web301.mail.yahoo.com> <385725A3.A1C110DF@ctam.com.au> <385774B8.3405494B@iname.com>
In-Reply-To: <385774B8.3405494B@iname.com>
MIME-Version: 1.0
Message-Id: <99121511085505.00750@alan.corp.packetengines.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 15 Dec 1999, Jim Chapman wrote:
> In a followup, Brendan Simon wrote:
> > 
> > I have made progress now that the caches are disabled.  I will leave
> > them disabled for now until I have a full working system via NFS (unless
> > someone advises me otherwise).
> 
> Make sure your 860 is a rev C part or higher. If it isn't, forget trying
> to use the cache.
> 
> Your CPU is a regular 8xx, not a 'P' (performance) variant, right? The
> latter has "optimized" cache hardware that isn't (yet?) supported by
> linuxppc.

Can you elaborate on the CPU flavors that do and don't work?  I just bought a
pair of RPXCLLF boards from Embedded Planet which have XPC860TZP50B3 on them. 
One might be led to believe that the B on the end is the chip mask rev - does
this part not work with this linux kernel?  (I very pointedly specified that
linux was required to run on the board when I ordered it.)

What is the issue with the "optimized" cache hardware?  There is nothing in the
MPC860 book to say that there are different flavors of cache control registers,
or whatnot.  Is it possible that they have gone to a newer more superscalar
implementation of the 8xx core with the 8xxP parts that does more out of order
operations?  Or did simply doubling the cache size break something that had
been lurking around waiting to bite us?  Do you know what is wrong?

Dan, can you tell us if the DMA operations on the 8xx processors are cache
coherent?  There is nothing in the documentation to lead one to believe
strongly either way, so I have erred on the conservative side and in my drivers
have done cache flushing operations before/after each DMA as appropriate for
DMA direction.  Is this necessary?  If it IS necessary, are all of the drivers
doing this kind of stuff?  That certainly would be the kind of thing I would
expect to break when you double the sizes of the caches - which I believe is
the case with the 8xxP parts.

As a slightly related aside, I have just had a particularly nasty experience
trying to bringup a non-Linux I2C driver on an MPC850 rev A which got shipped
to us by Motorola in a small quantity order in which rev B was specified as
REQUIRED.  MOT sent us 40 chips of which 4 or 5 were rev A.  That killed two
full days before I realized that the IMMR partnum field was 0x20 not 0x21 which
was what I had been seeing on the MPC850B parts.  And now, of course,I have to
wait for the boards to which rev A 850s had been nailed to be reworked (several
days' turnaround) to get working boards so I can bring them up and give them to
the other software folks.

It also appears that there are a lot of errata associated with the MPC850 rev
A parts which are ostensibly fixed (and, in my experience, ARE fixed) in rev B.

-- 
Alan Mimms     Packet Engines, Inc.     Spokane, Washington [99214-0497]
  USA, Earth, Sol, Milky Way, The Local Group, Virgo Supercluster, U0
Despite the cost of living, have you noticed how popular it remains?
  -- Steven Wright?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
