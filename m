Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Feb 2008 10:35:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080212233548.GE21230@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
	<fa686aa40802121134i4bc0c9bep30920a5afdeb240c@mail.gmail.com>
	<47B1F763.9000404@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B1F763.9000404@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 01:45:39PM -0600, Timur Tabi wrote:
> Grant Likely wrote:
[snip]
> > That's not a dtb version issue.  That is a dtb content issue. 
> 
> Technically, that's true, but ...
> 
> > It does
> > not warrant changing the dtb version number.
> 
> Then how do you solve the problem of passing a device tree to a boot
> loader that does not know how to parse it properly?  A device tree
> with these additional nodes *must* be parsed by a boot loader that
> is aware of them.

Correct.  Just as you must give a dtb with the information to the
correct board to a bootloader or things won't work.  Changing this is
not within the reasonable scope of what dtbs will do.

>  Otherwise, it will pass the device tree as-is to
> the kernel without warning.  This is a bad thing, and steps should
> be taken to prevent that.  If you can think of a way to make this
> happen without changing the version number, I'd love to hear.  All
> I'm hearing from you now is denial that this is a problem.
> 
> >>> We've already got that issue.  If you pass the device tree for the
> >>> wrong board it will still validate correctly, but the board is not
> >>> going to boot.
> >> There's nothing stopping U-Boot today from scanning the device tree and making
> >> sure the SOC's compatible node is correct.  That's not currently done, but it
> >> could be.
> > 
> > Fair enough, and it is also reasonable for the boot loader to look for
> > a specific property name to decide how to massage the data structure.
> > This alone does not require a dtb version change.
> 
> Current versions of U-Boot do not know how to do this.  So again,
> I'm asking you: how do you solve the problem of passing a device
> tree with additional nodes to a boot loader that does not know how
> to parse them properly?  How do you prevent that old U-Boot from
> ignoring those nodes?

You don't.  If your agent takes a dtb, dtb layout and agent must
match.

> > I'm not missing the point because I disagree entirely with the
> > addition of conditional expressions to the device tree.  Instead, I
> > think properties can be added to the device tree that a bootloader can
> > look for and decide to apply conditions against them which means the
> > conditions are encoded in the boot loader, not the device tree.  (the
> > device tree simply contains data which supports the boot loaders
> > decision; a rather different thing).
> 
> Then why bother passing a DTB to the boot loader at all?  Why not
> just have the boot loader create the device tree from scratch?

That's a perfectly acceptable option - and it's what I'd expect if a
real OF decided to add support for flattened device trees (which might
happen with ePAPR).  libfdt's serial-write functions are designed for
exactly this use case.

In fact, in one way of looking at it that's always what happens: the
dtb format is defined for passing hardware information from the
bootloader to the kernel; nothing else.  Passing a dtb *into* the
bootloader is just a bootloader implementation convenience, because
the possible variations on an output tree are small, so it's useful to
have a skeleton tree built-in.  But in order for the bootloader to
process those variations correctly, the skeleton *must* be in the
right format.  dtb input to a bootloader must match the bootloaders
expectations.  This has always been true, and will continue to be
true.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
