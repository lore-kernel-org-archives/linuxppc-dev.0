Return-Path: <dwg@au1.ibm.com>
Date: Fri, 1 Aug 2008 13:38:03 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Board level compatibility matching
Message-ID: <20080801033803.GH5008@yookeroo.seuss>
References: <fa686aa40807311319k44d270b0t4fa9cb0e6523339@mail.gmail.com>
	<20080801025439.GB5008@yookeroo.seuss>
	<20080801032533.GB6595@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080801032533.GB6595@secretlab.ca>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 09:25:33PM -0600, Grant Likely wrote:
> On Fri, Aug 01, 2008 at 12:54:39PM +1000, David Gibson wrote:
> > On Thu, Jul 31, 2008 at 02:19:57PM -0600, Grant Likely wrote:
[snip]
> > > - Add a property to the device tree that explicitly specifies the SoC
> > > that the board is based on.  Something like 'soc-model =
> > > "fsl,mpc5200b"' would be appropriate.  This in and of itself does not
> > > change the usage conventions, it just provides more information about
> > > the hardware.  (Another idea is to add a string to the top level
> > > compatible property, but there are still arguments about what
> > > compatible really means in the root node.)
> > 
> > No.  This sort of information belongs in the board compatible
> > property.  compatible = "myspecificboard", "generic-mpc5200-board" or
> > the like.
> 
> The last number of times this topic came up, there was opposition to
> using any kind of "generic-<blah>-board".  Mostly because of the
> definition of what it means to be 'compatible' tends to change over
> time.  That is why I suggested a new property explicitly for defining

Well, there is that.  But fundamentally the trade-off is between
specifying mostly-compatible boards in the device tree and dealing
with the not-quite-compatible ones, and having a large and growing
list of compatible strings to match in the platform support files.

Creating new properties doesn't get rid of this tradeoff, it shuffles
it about.

> the SoC used.  It encodes real information without trying to stretch the
> meaning of 'compatible'.

But the implication is that it will be used to pick compatible
platform code.  This is *not* always a function of the SoC in use, so
using the SoC type in this way just muddies the waters.

We already have a method for having a heirarchy of things compatible
by other things, picking a specific form if available then a more
generic match if possible - matching on the compatible node (we
should, of course, make sure that the platform match code, like the
driver match code will always prefer a match early in the compatible
list to one later).  Replacing this free-form heirarchy that we can
set up to match our needs with one that artificially assumes that
artificially assumes one of the levels will have a 1-to-1
correspondance with the SoC type is just silly.

> However, I'm raising this question as an RFC.  I can probably be
> convinced otherwise.
> 
> > Groups of boards sufficiently similar to share platform
> > code are *usually* divided by which SoC they're based on, but not
> > always.  Sometimes they're divided by the main bridge chip, or by
> > vendor (if the vendor is careful to use the same conventions on
> > different boards even with different SoCs).  And sometimes boards will
> > have idiosyncratic wiring that requires special platform support, even
> > if all the major components are the same as some standard design.
> 
> Which is another reason I didn't want to encode it in compatible.
> However, it still leaves the problem of how to bind across platform
> lines.  For the SoC case, I expect that the catch-all machines really
> perform a 'best-effort' match, as in if nothing has claimed the before
> it gets to it, and the SoC matches (or some other property for that
> matter), then it should be okay to bind.

We can already do this with compatible.  In fact, that's precisely how
it's designed to work.

> > > - Prioritize board ports in the arch/powerpc/platforms directory to
> > > identify level-1 machines support from the level-2 ones.  Make sure
> > > that level-1 stuff always gets probed before level-2 stuff within each
> > > SoC family.  In all likelyhood, this would probably just involve
> > > making sure that board specific machines get linked in before the
> > > catchall machine.
> > 
> > Again, this is imposing too much structure on which boards are
> > compatible with which.  Certainly compatibility by SoC with a few
> > exceptions is common, but it's not universal.
> > 
> > Splitting highly-specific from fairly-generic platform code might help
> > readability.  But, we have to remember that the distinction is only a
> > useful-guideline one, not a true structural difference.
> 
> Heh; I probably sounded more rigid than I intended to be.  I fully
> understand that the distinction is in the useful guideline category and
> that Linux must always have the option of doing something different.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
