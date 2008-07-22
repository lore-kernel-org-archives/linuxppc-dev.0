Return-Path: <dgibson@ozlabs.org>
Date: Tue, 22 Jul 2008 13:48:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jerry Van Baren <gvb.linuxppc.dev@gmail.com>
Subject: Re: Mikrotik RouterBoard 333
Message-ID: <20080722034847.GE14888@yookeroo.seuss>
References: <20080708042631.GB7328@yookeroo.seuss>
	<20080709040925.GA13810@secretlab.ca> <487AA17E.6000808@gmail.com>
	<20080721211344.GA13268@loki.buserror.net>
	<48854C02.7000307@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48854C02.7000307@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 21, 2008 at 10:54:58PM -0400, Jerry Van Baren wrote:
> Scott Wood wrote:
>> On Sun, Jul 13, 2008 at 08:44:46PM -0400, Jerry Van Baren wrote:
>>> I'm a half-ack.  ;-)  I'm partial to u-boot's implementation rather 
>>> than  using a bootwrapper for obvious reasons.  The u-boot 
>>> implementation  takes the blob as a boot parameter and passes it 
>>> along to the kernel  after doing appropriate (optional) fixups.
>>
>> And if those fixups expect a malformed device tree?
>
> Oops, very bad choice of terms on my part.  :-(  The fixups I referred  
> to are mostly "fill in the blank" things like setting the various  
> clocks, MAC information, PCI information, etc. to the correct values  
> based on hardware probing or a priori knowledge.  U-boot does not  
> (should not / will not!) fix broken device trees.  A broken tree w/ the  
> u-boot methodology is fixed by loading a corrected one, not requiring a  
> full rebuild and reload of the firmware.
>
> Note that the blobs are (should be) made from the *.dts files that are  
> part of the linux kernel source, so having correct ones has not been a  
> problem.  Since replacement ones are easily loaded, broken blobs are  
> fixed by replacement, not by contorted fixups a'la the start of this  
> thread.  Since blobs are well defined, even if some boneheaded company  
> didn't release their blob source, it is trivial to dump it (e.g. "fdt  
> print /"), fixed, and then replaced.
>
>>> Other than that quibble, I agree that burning the blob into the 
>>> firmware  so that the firmware must be recompiled and reburned to 
>>> change the blob  is very undesirable.
>>
>> I thought the device tree was *supposed* to be an interface between the
>> firmware and the kernel?  What if the firmware produces the tree
>> dynamically?  What if the firmware itself depends on having the device tree
>> in order to operate?
>>
>> -Scott
>
> Well, yes and no on dynamically generated blobs.  There isn't much point  
> "dynamically" generating the static parts of the blob - if you have  
> static code "dynamically" generating the static parts of the blob, is it  
> dynamic or static?  That is probably exactly where Mikrotik has  
> problems.  The truly dynamic parts are a small part of the blob.

Well.. they often are, particularly for embedded boards.

If there really is a large part of the tree which is dynamic, then
certainly it makes sense for the firmware to generate it and supply a
blob to the kernel.  Of course in this sort of situation it would also
make sense to have a full OF firmware.  Likewise, if the firmware is
sufficiently complex to want to make substantial internal use of the
device tree, it makes sense for it to pass it to the kernel.  If you
have a firmware of this sort of sophistication, though, please, please
try to get the tree *right*.

A lot of firmwares however, as gvb says just take a skeleton device
tree and do nothing more than poke a few integers into specific places
into it.  Maybe either leave in or remove a subtree representing an
optional peripheral.

This is the common case for embedded systems where something in the
installed software stack has to Just Know what the hardware looks
like.  In this case, in theory, it's pretty much arbitrary whether the
the devtree is bundled into the piece of the stack labelled
"firmware"/"bootloader", or the piece labelled "kernel", or even (as
with u-boot) yet another "device tree" section.

In practice however, it makes sense for the tree to be bundled with
the most-easily-updated section of the stack, because that way it's
easier to correct errors in it.  And usually, that means putting it
with the kernel (using the zImage wrapper).  In particular this makes
sense because the kernel is the only real user of the device tree, and
this way platform specific bugs can just be fixed in the device tree,
without needing code to deal with both broken device trees from old
firmwares and fixed device trees from newer firmwares.

> If all else fails, u-boot is GPLed and the user is able to get the  
> source and fix it (well, at least for 3 years after purchasing the  
> hardware).
>
> There are advantages and disadvantages to u-boot and boot-wrapper  
> methods.  There are nothing but disadvantages to having the blob  
> physically a part of the firmware (with a double whammy if the firmware  
> source is not readily available).

Well, "nothing but disadvantages" isn't strictly true.  In theory
boards with this arrangement which are sufficiently similar to
existing systems could run a generic kernel without any porting work.
In practice, board firmwares get things right so exceedingly rarely
that the kernel will need workarounds anyway, so it might as well just
include the device tree itself.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
