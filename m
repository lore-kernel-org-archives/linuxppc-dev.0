Date: Thu, 21 Mar 2002 14:10:31 -0800
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Troy Benjegerdes <hozer@drgw.net>,
	Michael Sokolov <msokolov@ivan.Harhan.ORG>,
	linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [Linux-galileo] Re: EV-64260-BP & GT64260 bi_recs
Message-ID: <20020321221031.GA6671@zumanetworks.com>
References: <0203200102.AA08371@ivan.Harhan.ORG> <20020321141524.U6003@altus.drgw.net> <3C9A301A.5B1B14DE@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C9A301A.5B1B14DE@mvista.com>
From: Nye Liu <nyet@zumanetworks.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 21, 2002 at 02:10:18PM -0500, Mark A. Greer wrote:
> Troy Benjegerdes wrote:
>
> > FYI, the gt eth driver is completely busticated for SMP. I managed to get
> > zuma's mpsc driver working on SMP by turning on snooping. (this may be the
> > 'wrong' thing to do , but it works for now)
>
> I haven't looked at the zuma version of the drivers but the ones inherited from
> marvell need to be dumped and completely rewritten...and made SMP-safe.  Its been
> on my list but I haven't gotten around to do that.  If/when I do, I'll look at what
> Nye, et. al. has done first.  They may have all the issues settled already.

Mark: myself, Troy, and rex will be working on this. The serial driver
is fine in SMP (although it depends on snooping, which, according to
Galileo, is broken for SDMA *and* ETHDMA).

The GT's ethernet snooping is DEFINITELY broken; not sure where we will
go from here for smp. I will let people smarter than me handle that..

The good news is that PCI snooping seems to be rock solid.

Troy: the question in my mind is whether the SDMA snooping is always
safe or not. We will torture test the SDMA some here; but keep in mind
when we first did this, the SDMA snooping seems to cause problems
under severe stress testing, which is why by default the driver does
explicit cache flushes. Maybe things have changed since then; it needs
testing.

What I dont get is that in BOTH (SDMA and ETHDMA) situations (with
CPU snooping on), if DMA snooping is off, invalidates were still
required. Perhaps somebody more knowledgeable can explain why this is.

Mike S: I would also be VERY interested in any work you may have already
done in the mpsc or eth drivers; especially with regards to SMP and
cache coherency.

Finally, my EVB board is growing increasingly less stable by the day (i
think my cpu module is very loose; if i touch the cpu, the board bombs
out), so testing on that platform is becoming increasingly difficult.

The good news is that our custom board is pretty stable, but i would
still like other GT EVB users lurking here to stress test the _galileo
tree as best they can, since right now, I seem to be the only active
developer with an EVB contributing to _gal.

--
Nye Liu
nyet@zumanetworks.com

"Who would be stupid enough to quote a fictitious character?"
	-- Don Quixote

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
