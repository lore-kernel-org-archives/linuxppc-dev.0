Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.244])
	by ozlabs.org (Postfix) with ESMTP id 56DCFDDFB9
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 06:34:20 +1100 (EST)
Received: by hs-out-0708.google.com with SMTP id x43so372815hsb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:34:18 -0800 (PST)
Message-ID: <fa686aa40802121134i4bc0c9bep30920a5afdeb240c@mail.gmail.com>
Date: Tue, 12 Feb 2008 12:34:18 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Timur Tabi" <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
In-Reply-To: <47B1EEA8.4040904@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Feb 12, 2008 12:08 PM, Timur Tabi <timur@freescale.com> wrote:
> Grant Likely wrote:
> > On Feb 12, 2008 8:44 AM, Timur Tabi <timur@freescale.com> wrote:
> > This requires coordination and
> > documentation, but id does not requires special formatting or
> > versioning of the device tree blob.
>
> Unless the mechanism by which the designer ensures that the boot loader presents
> a proper device tree to the kernel requires special versioning.

Then use a local version in the data; don't overload the purpose of
the dtb version.

> > The dtb is a data structure, not a programming language.
>
> But we have a problem with the current device tree definition that makes it
> difficult to use in real-world situations.  The current "solution" is to have
> multiple DTBs, each one covering a different variant of the hardware.  My
> proposal is to expand the definition of the DTB to allow the boot loader to
> modify it in a standard manner.  I believe that such a change would be both
> useful and not problematic.

I don't think it is yet possible to define a reasonable 'standard
manner' for massaging device trees.  There are going to be a lot of
experiments and false starts before we come to consensus on common
manipulations which everyone will want to have access too.  Therefore
for the time being dtb fixups and manipulations will remain a board
specific thing.

Plus, even when we do have a common set of manipulations, they can be
implemented with property values.  It is not something that needs to
change the dtb version.

>  >  I think it
> > is a slippery slope to try and encode conditionals into the structure;
>
> Perhaps, which is why I said it should be simple conditionals - two values and a
> comparison.

And when something comes along that doesn't fit into that model?  Add
more constructs?  I say better to handle that within the existing data
format.  If we get it wrong, then we just change the affected device
trees and boot loaders.  We don't have to upgrade every platform that
uses dt blobs.

> > but it is entirely reasonable to encode *data* into the dt that helps
> > make those conditional decisions.
>
> That's okay too, except that if we just add additional nodes that describe
> conditions, then we need to make sure that whatever parses that DTB must also
> parse those additional nodes.  The only way to do that is create a new version
> number, like 18, which is marked as being incompatible with the current version
> (17).  Otherwise, a person could pass that DTB to an old version of U-Boot, and
> U-boot will just pass it on to the kernel as-is.

That's not a dtb version issue.  That is a dtb content issue.  It does
not warrant changing the dtb version number.

> > We've already got that issue.  If you pass the device tree for the
> > wrong board it will still validate correctly, but the board is not
> > going to boot.
>
> There's nothing stopping U-Boot today from scanning the device tree and making
> sure the SOC's compatible node is correct.  That's not currently done, but it
> could be.

Fair enough, and it is also reasonable for the boot loader to look for
a specific property name to decide how to massage the data structure.
This alone does not require a dtb version change.

>  >  The device tree must match what the bootloader
> > expects.  Changing the version number will do nothing to help this.
> > The version number ensures that the tree is parsable.  It does not
> > ensure that it is correct.
>
> I think you're missing the point.  If we add conditional expressions to the
> device tree (whether attached to a node or as part of a separate node or
> whatever), we must also add a mechanism to ensure that these conditions are
> parsed by the boot loader.  As far as I know, the only mechanism that can do
> this is the version identifier.

I'm not missing the point because I disagree entirely with the
addition of conditional expressions to the device tree.  Instead, I
think properties can be added to the device tree that a bootloader can
look for and decide to apply conditions against them which means the
conditions are encoded in the boot loader, not the device tree.  (the
device tree simply contains data which supports the boot loaders
decision; a rather different thing).

Finally, it is *always* required that the user (or installer) know
enough to pass the correct device tree to the correct board.  No
amount of versioning at the dtb level is going to change this
situation.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
