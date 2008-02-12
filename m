Return-Path: <timur@freescale.com>
Message-ID: <47B1EEA8.4040904@freescale.com>
Date: Tue, 12 Feb 2008 13:08:24 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>	
	<20080211235409.GB18348@localhost.localdomain>	
	<20080211235652.GC18348@localhost.localdomain>	
	<200802120121.45349.arnd@arndb.de> <47B1BEE7.4050808@freescale.com>
	<fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
In-Reply-To: <fa686aa40802121058u6c6e4ba9s3ced2e35950745ea@mail.gmail.com>
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
> On Feb 12, 2008 8:44 AM, Timur Tabi <timur@freescale.com> wrote:
>> Arnd Bergmann wrote:
>>
>>> On Tuesday 12 February 2008, David Gibson wrote:
>>>> Or to expand.  It's relatively easy now to just include multiple nodes
>>>> in the tree and either delete or nop some of them out conditionally
>>>> using libfdt.
>> Yes, but what better place to store the conditions than in the device tree
>> itself?  How would libfdt know where the conditions are?  Do you want to have
>> two binary blobs?
> 
> The transient state of the dts before it is handed to the kernel
> proper is almost irrelevant.  It is totally reasonable to add in
> whatever properties/nodes that are needed to *eventually* describe the
> hardware correctly.  Heck, we already do this will all dts files that
> go through u-boot is a simple sense.  We put placeholder properties
> for mac addresses and bus frequencies, but u-boot fills them in.

I agree with that.

> However, if a designer does write a device tree containing more nodes
> than is needed, then it is also the responsibility of that designer to
> make sure the boot loader can use that tree to generate a real
> description of hardware.  

No problem here.

> This requires coordination and
> documentation, but id does not requires special formatting or
> versioning of the device tree blob.

Unless the mechanism by which the designer ensures that the boot loader presents 
a proper device tree to the kernel requires special versioning.

> The dtb is a data structure, not a programming language.

But we have a problem with the current device tree definition that makes it 
difficult to use in real-world situations.  The current "solution" is to have 
multiple DTBs, each one covering a different variant of the hardware.  My 
proposal is to expand the definition of the DTB to allow the boot loader to 
modify it in a standard manner.  I believe that such a change would be both 
useful and not problematic.

 >  I think it
> is a slippery slope to try and encode conditionals into the structure;

Perhaps, which is why I said it should be simple conditionals - two values and a 
comparison.

> but it is entirely reasonable to encode *data* into the dt that helps
> make those conditional decisions.

That's okay too, except that if we just add additional nodes that describe 
conditions, then we need to make sure that whatever parses that DTB must also 
parse those additional nodes.  The only way to do that is create a new version 
number, like 18, which is marked as being incompatible with the current version 
(17).  Otherwise, a person could pass that DTB to an old version of U-Boot, and 
U-boot will just pass it on to the kernel as-is.

> We've already got that issue.  If you pass the device tree for the
> wrong board it will still validate correctly, but the board is not
> going to boot.

There's nothing stopping U-Boot today from scanning the device tree and making 
sure the SOC's compatible node is correct.  That's not currently done, but it 
could be.

 >  The device tree must match what the bootloader
> expects.  Changing the version number will do nothing to help this.
> The version number ensures that the tree is parsable.  It does not
> ensure that it is correct.

I think you're missing the point.  If we add conditional expressions to the 
device tree (whether attached to a node or as part of a separate node or 
whatever), we must also add a mechanism to ensure that these conditions are 
parsed by the boot loader.  As far as I know, the only mechanism that can do 
this is the version identifier.

-- 
Timur Tabi
Linux kernel developer at Freescale
