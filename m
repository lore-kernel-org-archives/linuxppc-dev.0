Date: Tue, 10 Aug 2004 07:35:02 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
Cc: Josh Boyer <jwboyer@charter.net>,
	linuxppc-embedded@lists.linuxppc.org,
	Matt Porter <mporter@kernel.crashing.org>
Subject: Re: Large TLBs on 40x
Message-ID: <20040810073502.A32095@home.com>
References: <20040804093937.B12758@home.com> <285BFD4E-E638-11D8-852B-003065F9B7DC@embeddededge.com> <1092104488.2974.2.camel@c68.115.86.108.roc.mn.charter.com> <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2D5216A6-EA93-11D8-899E-003065F9B7DC@embeddededge.com>; from dan@embeddededge.com on Tue, Aug 10, 2004 at 02:04:44AM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Aug 10, 2004 at 02:04:44AM -0400, Dan Malek wrote:
>
> On Aug 9, 2004, at 10:21 PM, Josh Boyer wrote:
>
> > I have some boards I could test such a patch on.  Or is it a case of
> > "this isn't trivial to do"?
>
> Ummmmm.....what are we talking about here?
>
> Both MPC8xx, and IBM40x have configuration options for
> pinning some (small) amount of kernel space.  You can choose
> to enable this if you wish, I don't think it is normally enabled.
> I've never found a benchmark that proved either was better,
> but I left the code there for others to experiment with.

PPC40x no longer has this in 2.6. It has been deprecated by the dynamic
large tlb support. He's looking for an option (like nobats) to cause
kernel lowmem to not be mapped by large page entries.

So, to answer the original question, I would suggest a patch
that that uses a 'noltlb' cmdline option, then skips the PPC40x
large page mapping in 4xx_mmu.c based on that. See the code
that implements 'nobats' for an example.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
