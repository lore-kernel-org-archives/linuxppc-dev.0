Return-Path: <dgibson@ozlabs.org>
Date: Mon, 16 Apr 2007 10:51:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: [PATCH dtc take 2] Fix reserve map output for asm format.
Message-ID: <20070416005145.GA19270@localhost.localdomain>
References: <aa6a7bd73be20ea11e3e98f87a66e478@bga.com>
	<4622C226.1070304@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4622C226.1070304@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 15, 2007 at 08:24:06PM -0400, Jerry Van Baren wrote:
> Milton Miller wrote:
> > Sometime around Sun Apr 15 12:29:14 EST 2007, Jerry Van Baren wrote:
> >> Add extra reserve map slots output for asm format (previously done for 
> >> dtb
> >>   output).
> >>
> >> Signed-off-by: Gerald Van Baren <vanbaren at cideas.com>
> >> ---
> >>
> >> Hi Jon, David,
> >>
> >> Here is a patch that fixes the asm output without the (unnecessary)
> >> calloc change.
> >>
> >> Best regards,
> >> gvb
> > 
> > 
> > The previous description had
> >> Use cmalloc to pre-zero memory (for dtb input) and handle dtb (binary)
> >>   input being shorter than the total blob length (result of putting
> >>   extra space in the blob).
> > 
> > 
> > Which at least said in the description the unrelated things it was 
> > doing.
> 
> That was my added comment WRT the change from malloc to cmalloc.  David 
> wasn't wild about using cmalloc, so I removed it.  Using cmalloc is not 
> necessary.
> 
> >>         while (sizeleft) {
> >> -               if (feof(f))
> >> -                       die("EOF before reading %d bytes of DT blob\n",
> >> -                           totalsize);
> >> +               if (feof(f)) {
> >> +                       WARNMSG("EOF after reading %d of %d bytes of 
> >> DT blob, assuming there is extra space in the blob.\n",
> >> +                           totalsize - sizeleft, totalsize);
> >> +                       break;
> >> +               }
> > 
> > I thnk the above should be an ERROR and cause failure without
> > the -f (force) option.
> > 
> > The total_size says how much data should be copied.  Anything
> > less and there is data missing.   Assuming zeros is wrong for
> > most sections (the exception being the memory reserve list
> > that had a terminating 0 entry within the read portion).
> > 
> > milton
> 
> The reason total_size is bigger than the actual size is because I 
> created the blob with extra space using the -S parameter.  It is 
> intentionally bigger.  The extra space is ignored by dtc when creating a 
> dts/asm format output which is why cmalloc() is unnecessary.
> 
> I suppose we could require a -f force but I'm not wild about creating a 
> nanny program.  There is nothing wrong with the blob - it parses just 
> fine.  If there were problems with the blob contents, other errors would 
> be raised.

I think the warning is fine, but not for exactly the reasons you
state.  Several points:

- At least with v17 input, where it's possible, we probably *should*
check that an input blob isn't truncated in the middle of the strings
or structure sections.  That should be more than a warning.

- Milton, saying totalsize indicates the amount of data to be copied
is misleading in this context.  That's a good philosphy for things
that just read and/or slightly tweak the tree - data outside the known
sections which it can't interpret should be left unaltered wherever
possible.  dtc, however, *always* fully interprets and re-emits the
tree.  Any data outside the known and understood sections is *always*
discarded, so I don't think there's any problem assuming it to be
zero.

- That said, I think when using -S, at least the default behaviour
should emit extra zero bytes in addition to changing the totalsize
header.  Then at least in the simplest case of feeding dtc's dtb
output back into dtc, the warning will not occur.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
