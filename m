Return-Path: <mgreer@mvista.com>
Date: Wed, 16 Jan 2008 19:28:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 3/4] powerpc: Katana750i - Add DTS file
Message-ID: <20080117022815.GA29671@mag.az.mvista.com>
References: <20080114225150.GB21940@mag.az.mvista.com>
	<20080114225926.GB22862@mag.az.mvista.com>
	<20080114233406.GB20649@localhost.localdomain>
	<20080115190806.GD26853@mag.az.mvista.com>
	<20080116002228.GC4283@localhost.localdomain>
	<20080116204809.GA24595@mag.az.mvista.com>
	<20080117010634.GA11567@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080117010634.GA11567@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 17, 2008 at 12:06:34PM +1100, David Gibson wrote:
> On Wed, Jan 16, 2008 at 01:48:09PM -0700, Mark A. Greer wrote:
> > On Wed, Jan 16, 2008 at 11:22:28AM +1100, David Gibson wrote:
> > > On Tue, Jan 15, 2008 at 12:08:06PM -0700, Mark A. Greer wrote:
> > > > On Tue, Jan 15, 2008 at 10:34:06AM +1100, David Gibson wrote:
> > > > > On Mon, Jan 14, 2008 at 03:59:26PM -0700, Mark A. Greer wrote:
> > > > > > From: Mark A. Greer <mgreer@mvista.com>
> > > > 
> > > > Hi David.  Thanks for the review.
> > > > 
> > > > > > Add DTS file for the Emerson Katana 750i & 752i platforms.
> > > > > 
> > > > > [snip]
> > > > > > +/dts-v1/;
> > > > > > +
> > > > > > +/ {
> > > > > > +	#address-cells = <1>;
> > > > > > +	#size-cells = <1>;
> > > > > > +	model = "Katana-75xi";	/* Default */
> > > > > > +	compatible = "emerson,katana-750i";
> > > > > > +	coherency-off;
> > > > > 
> > > > > Where is this flag used from?
> > > > 
> > > > Its used in the bootwrapper if & when you use the mv64x60 code to setup
> > > > some of the windows to the I/O ctlrs.  This port does use that code
> > > > (because firmware doesn't do it properly) so I need the flag.
> > > 
> > > Hrm.. ok.  I'm just wondering if a new flag is really the right
> > > approach for this, or whether you should be basing the setup off the
> > > compatible property, either for the board or for the main bridge.
> > 
> > I'd prefer to keep the flag.  Otherwise, the bootwrapper will need a
> > table to look up the compatible field to see if coherency is supposed
> > to be on or off.  We'd have to add an entry to that table for any
> > compatible that need coherency off, etc.  A flag seems cleaner.
> 
> Hrm.  Except that you already have such a table in the cuboot file,
> adding another flag to that wouldn't be hard.
> 
> What piece of hardware is it that actually determines whether
> coherency works or not?  The CPU?  The bridge?

The bridge + the platform.  There's a hw erratum that some boards have
worked around and other haven't.

Spoze I can just code it in the cuboot file as you say.
I'll have to remove the sanity check in the kernel that ensures
that coherency-off & CONFIG_NOT_COHERENT_CACHE match.

> [snip]
> > > > > > +		CUNIT: cunit@f200 {
> > > > > 
> > > > > What is this device?  It needs some sort of "compatible" value.
> > > > 
> > > > Does it?  Its a separate block of regs but its only used in the mpsc
> > > > node--its never looked up on its own by kernel code.  Do all nodes need
> > > > "compatible" even when it'll never be used?  (Just want to know.)
> > > 
> > > Hrm.. if it's really just extra mpsc registers, should it be a
> > > seperate device, or just another range in the mpsc's "reg" property?
> > 
> > Okay, putting into the reg property makes sense.  Its values will be
> > put into both mpsc@xxx 'reg' properties since its share.  That doesn't
> > matter, correct?
> 
> Ah, sorry, I forgot there were multiple mpscs.  Their reg properties
> certainly shouldn't overlap, so you will need a separate node.

Okay.

> However, you could combine your several nodes with MPSC common
> registers into a single "mpsc-common" (or something) block.  That
> would also reduce the number of phandles you need in the mpsc nodes,
> too.

True, that will help.

> Or possibly this should be arranged as for the multiethernet.

Do you mean putting sdma/brg/... as subnodes of the mpsc node?
I remember debating this way back when.  IIRC, leaving them out seemed
like the right thing to do (tm).  If you think that's better, I can do
that.

> > Also, would you mind letting it go thru as it is now and I'll make a
> > separate patch to change this dts, the prpmc2800.dts, and related code
> > afterwards?
> 
> Well, that's not really up to me.

Yeah, but paulus is looing to you to monitor bootwrapper stuff so... :)

> [snip]
> > > Yes :(.  I've looked at this before, though obviously I never got to
> > > figuring out what to do about it.
> > > 
> > > > IMHO we need a way to change the default cmdline in the field so
> > > > sysadmins can change it per board and not have to type it in every time
> > > > they boot.  /chosen/bootargs and __builtin_cmdline can both do that.
> > > > We don't need both, though.  And, since bootargs is specified by OF
> > > > and documented in booting-without-of.txt, can we finally get rid of
> > > > __builtin_cmdline?  I'd sure like to.
> > > > 
> > > > We can probably get rid of CONFIG_CMDLINE too since everyone uses DTs
> > > > now and they can have a /chosen/bootargs.  Anyone have a reason to keep
> > > > CONFIG_CMDLINE around?
> > > > 
> > > > Would you mind elaborating on why you are opposed to /chosen/bootargs?
> > > 
> > > Just because it's nasty for people to have to go in and change the dts
> > > just to change their default command line - which they might well want
> > > to do for things as simple as setting a default root device.
> > 
> > Yeah, but changing CONFIG_CMDLINE requires a kernel rebuild so
> > that's not great either.  Modifying __builtin_cmdline is probably the
> > easiest way to change things in the field (assuming you have a zImage)
> > but its also the least standard way of the three. :(
> 
> But since the device tree is built into the zImage, changing it there
> will also require a rebuild.

Nope, you can run the wrapper script to change it without rebuilding the
kernel.  You just need the dts file and a working dtc (and the wrapper
script).  Goes back to paulus' original intent with the wrapper script.

> No difference from that PoV.  I'd really
> suggest leaving this with CONFIG_CMDLINE just for similarity to other
> platforms until we figure out how to clean up the commandline
> confusion more generally.

I think (hope) your opinion may change when you see my previous comment.

Mark
