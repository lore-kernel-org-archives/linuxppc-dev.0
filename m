Date: Fri, 1 Sep 2000 08:03:21 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Timothy A. Seufert" <tas@mindspring.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
Message-ID: <20000901080321.C14222@opus.bloom.county>
References: <39AE80BD.D86B34DA@embeddededge.com> <Pine.HPX.4.10.10008311808260.15978-100000@gra-ux1.iram.es> <20000831184447.D3823@opus.bloom.county> <v04220803b5d51a99c774@[10.0.0.42]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04220803b5d51a99c774@[10.0.0.42]>; from tas@mindspring.com on Fri, Sep 01, 2000 at 01:42:14AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Sep 01, 2000 at 01:42:14AM -0700, Timothy A. Seufert wrote:
> At 6:44 PM -0700 8/31/00, Tom Rini wrote:
> >On Thu, Aug 31, 2000 at 06:10:55PM +0200, Gabriel Paubert wrote:
> >>
> >>
> >>  On Thu, 31 Aug 2000, Dan Malek wrote:
> >>
> >>  > I would also like to see us spend a little more time trying to
> >>  > stabilize 2.4 instead of trying to solve elaborate configuration and
> >>  > boot schemes.  That is what 2.5 is for.
> >>
> >>  What are your problems with 2.4 ? I'm at 2.4.0-test7 and I've not had any
> >>  problem so far, although I still need to upgrade my modutils.
> >
> >Here's a few: The PCI resource allocation/conflict stuff has "issues" with
> >some Pmacs (7600, Yikes! G4, I don't know about others).
>
> B&W G3 as well (same thing as the Yikes! G4 really).  I have the
> following problems on one (latest BK 2.4.0-test8 kernel, as of a
> couple minutes ago):
>
> 1. Resource conflicts are reported for the CMD646 IDE controller and
> an Adaptec 2940UW card

There should be more conflicts reported than that.  But not all drivers check
for conflicts yet.

> 2. During the fb probe of the Rage 128 PCI card, a pattern of colored
> characters is written to the screen.  This might be somebody's
> deliberate debug output, as it almost looks too regular to be an
> error.

That does seem odd, I didn't get that one.

> 3. When attempting to do the partition scan, the kernel has massive
> problems with lost IDE interrupts and failed DMA stuff.  Eventually
> it gives up and moves on without successfully scanning my IDE drive.

On the cmd646?  Did/does this happen w/ older kernels as well?  I know
test7/test8-preX are more broken.

> 4. Probably due to the resource conflict problem, the aic7xxx driver
> doesn't recognize the 2940.  This is a showstopper for me because my
> root partition's on a drive connected to the 2940.

This can be kludged around.  search for pci_enable_device (should be 2 lines
something like:
if(pci_enable_device())
	break; or return;
and comment it out.  Then you can see what else is broken.  (I currently have
USB kbd problems as well, w/ the standard apple kbd)

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
