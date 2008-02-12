Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Feb 2008 10:26:39 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212232639.GD21230@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B1EEA8.4040904@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]
On Tue, Feb 12, 2008 at 01:08:24PM -0600, Timur Tabi wrote:
> Grant Likely wrote:
> > On Feb 12, 2008 8:44 AM, Timur Tabi <timur@freescale.com> wrote:
> >> Arnd Bergmann wrote:
>  >  I think it
> > is a slippery slope to try and encode conditionals into the structure;
> 
> Perhaps, which is why I said it should be simple conditionals - two
> values and a comparison.

I can pretty much guarantee you that someone will find that
insufficient and want to expand the conditional representation.  This
way madness lies.

> > but it is entirely reasonable to encode *data* into the dt that helps
> > make those conditional decisions.
> 
> That's okay too, except that if we just add additional nodes that
> describe conditions, then we need to make sure that whatever parses
> that DTB must also parse those additional nodes.  The only way to do
> that is create a new version number, like 18, which is marked as
> being incompatible with the current version (17).  Otherwise, a
> person could pass that DTB to an old version of U-Boot, and U-boot
> will just pass it on to the kernel as-is.

No.  As Grant says, that's not what the version number is for.  It
represents the version of the encoding, not the content.  If you must
version the content (which you should try really hard to avoid) the
correct way is to add versioning properties to the root node.

> > We've already got that issue.  If you pass the device tree for the
> > wrong board it will still validate correctly, but the board is not
> > going to boot.
> 
> There's nothing stopping U-Boot today from scanning the device tree
> and making sure the SOC's compatible node is correct.  That's not
> currently done, but it could be.
> 
>  >  The device tree must match what the bootloader
> > expects.  Changing the version number will do nothing to help this.
> > The version number ensures that the tree is parsable.  It does not
> > ensure that it is correct.
> 
> I think you're missing the point.  If we add conditional expressions
> to the device tree (whether attached to a node or as part of a
> separate node or whatever), we must also add a mechanism to ensure
> that these conditions are parsed by the boot loader.  As far as I
> know, the only mechanism that can do this is the version identifier.

No. a) the version identifier is not a mechanism for doing that and b)
the conditional mechanism is inherently agent-specific, therefore in
any case you *must* match an input incomplete tree (by which I mean
*anything* that requires processing before it's ready for consumption
by the kernel) to the specific bootloader or agent that will process
it and pass to the kernel.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
