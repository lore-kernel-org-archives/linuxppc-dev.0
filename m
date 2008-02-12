Return-Path: <timur@freescale.com>
Message-ID: <47B1F763.9000404@freescale.com>
Date: Tue, 12 Feb 2008 13:45:39 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>	
	<20080211235409.GB18348@localhost.localdomain>	
	<20080211235652.GC18348@localhost.localdomain>	
	<200802120121.45349.arnd@arndb.de>
	<47B1BEE7.4050808@freescale.com>	
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>	
	<47B1EEA8.4040904@freescale.com>
	<fa686aa40802121134i4bc0c9bep30920a5afdeb240c@mail.gmail.com>
In-Reply-To: <fa686aa40802121134i4bc0c9bep30920a5afdeb240c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Grant Likely wrote:

> Then use a local version in the data; don't overload the purpose of
> the dtb version.

I don't know what you mean by that.

> I don't think it is yet possible to define a reasonable 'standard
> manner' for massaging device trees.  There are going to be a lot of
> experiments and false starts before we come to consensus on common
> manipulations which everyone will want to have access too.  Therefore
> for the time being dtb fixups and manipulations will remain a board
> specific thing.

That's okay with me.  I'm just proposing one method that I like, and Scott 
proposed another.

> And when something comes along that doesn't fit into that model?  Add
> more constructs?

If necessary, yes.  What's wrong with expanding the power of the device tree 
format when it solves more problems?

>  I say better to handle that within the existing data
> format.

And the point I've been trying to make is that we have real problems today that 
cannot be solved elegantly with the current device tree problem.  Having 
board-specific code in U-Boot that is hard-coded to look for specific nodes in 
the device tree, and making hard-coded edits on that tree, is *not* elegant.

>  If we get it wrong, then we just change the affected device
> trees and boot loaders.  We don't have to upgrade every platform that
> uses dt blobs.

Only the platforms that need to take advantage of conditional nodes need to be 
upgraded in the first place.  Most platforms are happy with just one device tree.

>> That's okay too, except that if we just add additional nodes that describe
>> conditions, then we need to make sure that whatever parses that DTB must also
>> parse those additional nodes.  The only way to do that is create a new version
>> number, like 18, which is marked as being incompatible with the current version
>> (17).  Otherwise, a person could pass that DTB to an old version of U-Boot, and
>> U-boot will just pass it on to the kernel as-is.
> 
> That's not a dtb version issue.  That is a dtb content issue. 

Technically, that's true, but ...

> It does
> not warrant changing the dtb version number.

Then how do you solve the problem of passing a device tree to a boot loader that 
does not know how to parse it properly?  A device tree with these additional 
nodes *must* be parsed by a boot loader that is aware of them.  Otherwise, it 
will pass the device tree as-is to the kernel without warning.  This is a bad 
thing, and steps should be taken to prevent that.  If you can think of a way to 
make this happen without changing the version number, I'd love to hear.  All I'm 
hearing from you now is denial that this is a problem.

>>> We've already got that issue.  If you pass the device tree for the
>>> wrong board it will still validate correctly, but the board is not
>>> going to boot.
>> There's nothing stopping U-Boot today from scanning the device tree and making
>> sure the SOC's compatible node is correct.  That's not currently done, but it
>> could be.
> 
> Fair enough, and it is also reasonable for the boot loader to look for
> a specific property name to decide how to massage the data structure.
> This alone does not require a dtb version change.

Current versions of U-Boot do not know how to do this.  So again, I'm asking 
you: how do you solve the problem of passing a device tree with additional nodes 
to a boot loader that does not know how to parse them properly?  How do you 
prevent that old U-Boot from ignoring those nodes?

> I'm not missing the point because I disagree entirely with the
> addition of conditional expressions to the device tree.  Instead, I
> think properties can be added to the device tree that a bootloader can
> look for and decide to apply conditions against them which means the
> conditions are encoded in the boot loader, not the device tree.  (the
> device tree simply contains data which supports the boot loaders
> decision; a rather different thing).

Then why bother passing a DTB to the boot loader at all?  Why not just have the 
boot loader create the device tree from scratch?


-- 
Timur Tabi
Linux kernel developer at Freescale
