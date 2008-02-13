Return-Path: <dgibson@ozlabs.org>
Date: Wed, 13 Feb 2008 11:08:36 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: Could the DTS experts look at this?
Message-ID: <20080213000836.GG21230@localhost.localdomain>
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
	<47B1EEA8.4040904@freescale.com>
	<20080212232639.GD21230@localhost.localdomain>
	<47B2300B.4060101@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47B2300B.4060101@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 12, 2008 at 05:47:23PM -0600, Timur Tabi wrote:
> David Gibson wrote:
> 
> > I can pretty much guarantee you that someone will find that
> > insufficient and want to expand the conditional representation.  This
> > way madness lies.
> 
> Then let them.  We can have version numbers associated with the conditional 
> expressions.  If they want to make more complex condition expressions, they can 
> bump the version number and define a spec and write code to parse it.
> 
> > No.  As Grant says, that's not what the version number is for.  It
> > represents the version of the encoding, not the content.  If you must
> > version the content (which you should try really hard to avoid) the
> > correct way is to add versioning properties to the root node.
> 
> And that's why I prefer updating the DTB format to allow attaching
> conditional expressions to nodes.  This would then necessitate
> bumping the version number.  Older U-Boots will reject this new DTB.
> We can also modify DTC to support conditional nodes, so that if a
> customer has an older U-Boot he can't update, he can use DTC to
> generate a V17 DTB that has the conditionals already processed.

Well, yes, folding conditionals into the format would mean a version
bump.  But I am *not* going to put conditionals into a dtb version,
and I'm pretty sure BenH and Paulus would also reject this notion.
It's simply not what the format is for.  dtbs are for parsing by the
kernel, giving a complete device representation.  If bootloaders and
other things also find them a useful input format, that's great, but
I'm not going to significantly extend the semantics just to support
other uses.

Now, if you want to define a new binary-level "meta-dtb" format,
designed for representing various conditionals or whatnot, which can
be processed into a final true dtb, go for it.  But a) if you base it
on the dtb format, make sure you use a different magic number so as
not to interfere with the actual dtbs version progression and b) I
think you'll find it's more trouble than it's worth, at least at this
stage (feel free to try to prove me wrong on this point, of course).

At present, I think the "meta-dtb" format which makes the most sense,
based on a balance between simplicity and flexibility is C, with one
or more dtb fragments embedded.  This can be done now (though if there
are libfdt extensions which would make this usage easier, please
suggest them - fdt_graft() is an obvious one).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
