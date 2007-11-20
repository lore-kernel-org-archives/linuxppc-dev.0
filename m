Return-Path: <dgibson@ozlabs.org>
Date: Tue, 20 Nov 2007 11:22:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Revisited, audio codec device tree entries.
Message-ID: <20071120002259.GA3126@localhost.localdomain>
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
	<0fd3304ee694b2dc6a8f3055c08dc015@kernel.crashing.org>
	<9e4733910711181349q1f840bc2w8d30bb33d2a353ce@mail.gmail.com>
	<4740C0E3.5080704@genesi-usa.com> <4740CB41.8030101@genesi-usa.com>
	<20071119001209.GD20794@localhost.localdomain>
	<f334e85d77c624ef0112437a4049a3cd@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f334e85d77c624ef0112437a4049a3cd@kernel.crashing.org>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 19, 2007 at 01:48:40PM +0100, Segher Boessenkool wrote:
> > Matt, the various properties you list do not mean what you think they
> > mean.
> >
> > name - should be named according to the generic names convention.
> > It's pretty much arbitrary, meant for human readability of the device
> > tree.  Drivers should not depend on it (some do, historically, but new
> > drivers and trees should not).
> 
> It is not arbitrary, there is a single well-defined name for every 
> common
> "class" of device.  It _is_ machine-readable (but shouldn't be used for
> driver matching, indeed -- it says nothing about the programming model).

Sorry, that was an (over?) simplification on my part.  Yes, there are
conventions as to what devices should be called by class (usually, but
not universally observed), yes they can be used machine-readable under
some circumstances.

My point is that since driver matching is *not* done off name, and
machine-readable uses are not common, the name tends not to matter
very much.  Plus if an incorrect name is used, it's usually not too
bad to fix.

> > device_type - indicates the open firmware method interface for the
> > device.
> 
> Not "method interface", just "interface".

Right, I say "method interface" just to emphasise the fact that we're
talking about the runtime OF-call interface, rather than
register-level or other programming interface.

> > Therefore, meaningless in flattened trees.
> 
> Even in flat trees, a "device_type" of for example "block" indicates the
> node will have the required properties for that device type, for example
> "block-size".  Such properties are perfectly useful.  OTOH, it isn't 
> very
> useful to search for device with a specific device type from within the
> kernel, since it currently has no firmware interaction to speak of (flat
> trees don't interact, and the kernel kills "real" OF dead as soon as
> possible).

Uh... it was you who convinced me that device_type was not appropriate
for new flat-tree devices.
 
> > No new driver should use this.
> 
> Not without very good rationalisation, anyway.
> 
> > compatible - *this* is the one for driver selection.  It describes the
> > hardware level interface(s) of the device.
> >
> > model - usually just for debugging / diagnosis / human-readable
> > purposes, describes exact model / revision of the hardware.  It can be
> > used to enable driver quirks / workarounds for when various devices
> > are supposed to be compatible (as encoded in 'compatible') but
> > aren't, due to hardware bugs.  However, you should never aim to use it
> > this way in design.
> 
> Yeah.  Any non-workaround value a driver would derive from "model" is
> usually better described using a separate property.

Well, yes, if the need for the workaround is known when the device
tree is created.  But by their nature workarounds tend not to be
planned, so from the driver's perspective it's legitimate to use *any*
reliable-in-practice information to activate a workaround (even if
it's not reliable in theory, if there's no other option).  That
includes both everything in the device tree, and any information the
driver can probe from the hardware.

My point above is that iIt's reasonably common in such cases for
"model" to be a decent choice.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
