Date: Wed, 11 Aug 2004 08:45:11 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Josh Boyer <jwboyer@charter.net>
Cc: Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Large TLBs on 40x
Message-ID: <20040811084511.A8378@home.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com> <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com> <20040810073502.A32095@home.com> <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092232201.32005.4.camel@c68.115.86.108.roc.mn.charter.com>; from jwboyer@charter.net on Wed, Aug 11, 2004 at 08:50:03AM -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 11, 2004 at 08:50:03AM -0500, Josh Boyer wrote:
> On Tue, 2004-08-10 at 09:35, Matt Porter wrote:
> > On Tue, Aug 10, 2004 at 02:04:44AM -0400, Dan Malek wrote:
> > >
> > > On Aug 9, 2004, at 10:21 PM, Josh Boyer wrote:
> > >
> > > > I have some boards I could test such a patch on.  Or is it a case of
> > > > "this isn't trivial to do"?
> > >
> > > Ummmmm.....what are we talking about here?
> > >
> > > Both MPC8xx, and IBM40x have configuration options for
> > > pinning some (small) amount of kernel space.  You can choose
> > > to enable this if you wish, I don't think it is normally enabled.
> > > I've never found a benchmark that proved either was better,
> > > but I left the code there for others to experiment with.
> >
> > PPC40x no longer has this in 2.6. It has been deprecated by the dynamic
> > large tlb support. He's looking for an option (like nobats) to cause
> > kernel lowmem to not be mapped by large page entries.
> >
> > So, to answer the original question, I would suggest a patch
> > that that uses a 'noltlb' cmdline option, then skips the PPC40x
> > large page mapping in 4xx_mmu.c based on that. See the code
> > that implements 'nobats' for an example.
>
> Hm...  like this?  Against 2.6.8-rc4.

Looks good to me, except we should probably have the cmdline option
be 'noltlbs'...minor nit.

Please repost after reading http://kerneltrap.org/node/view/3180
and agreeing to the DCO by providing a signed off line. Then it
can go into mainline.

Thanks,
Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
