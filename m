Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 13:28:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807032806.GE15619@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46B76A5A.3030300@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 10:37:14PM +0400, Sergei Shtylyov wrote:
> Hello.

[snip]
> >>>Can you describe some of the options for *not* direct mapped flash
> >>>chips - I can't reasonably come up with a way of describing the
> >>>distinction when I've never seen NOR flash other than direct mapped.
> 
> >>    You're lucky to live in the single-endian world.  Once you're in bi-endian 
> >>one, all kinds of strange mappings become possible.  I've seen the MIPS 
> 
>     Well, not necessarily -- 16-bit only accesses are always possibly (no 
> dount this would be a strange mapping however)...

I have no idea what you're getting at here.

> >>mapping driver which required swapping flash bytes in s/w in BE mode, i.e. 
> >>couldn't be served by physmap, yet that's not all...  here's the code of its 
> >>map read*() methods:
> 
> > Aha!  Ok, now I understand the sorts of situations you're talking
> > about.  By "not direct mapped", I thought you were talking about some
> > kind of access via address/data registers on some indirect bus
> > controller, rather than weird variations on endianness and
> > bit-swizzling.
> 
>     No, that would be just too ridiculous for a NOR flash -- I hope. :-)

Heh.  In my experience, very little is so ridiculous that some
embedded vendor won't do it.

> > Hrm.. this is a property of how the flash is wired onto the bus,
> > rather than of the flash chips themselves, 
> 
>     Indeed.
> 
> > so I'm not entirely sure where description of it belongs.
> 
>     So, you're saying that the 1:1 address correspondence rule stops to apply 
> here?

Well.. it all depends what exactly you consider the address space of
the flash bank.  By which I mean the whole shmozzle represented by the
device node, not the individual flash chips.  It's not immediately
obvious whether or not that should include any swizzling done by the
bus wiring.

It would be possible, I guess, to define a 'swizzled-ranges' property
or something which allows child devices to be embedded in the parent's
address range in a not-direct way.  However, the swizzling on the
flash bank is really a property of the flash bank, not of the parent
bus - requiring it to be encoded in the parent is pretty yucky -
especially if the flash bank is just part of a larger chunk of bus
address space, defined by a single large ranges entry in the parent.

> > Simplest option seems to me to add a property "endianness" or
> 
>     And we even have a precedent of "big-endian" prop in the MPIC nodes 
> (although I'm not sure why it's needed there).
> 
> > "bit-swizzling" or something which can be defined to describe some odd
> > connections.  If absent we'd default to direct mapping.  Segher, is
> > that idea going to cause you to scream?
> 
>     Actually, checking for the presence of all possible perverted mapping 
> props doesn't seem a good idea -- it's simpler to check for the presence of 
> one prop (like "direct-mapped" I was thinking about, or maybe "simple-map").
> 
> >>>>>+     - reg : Address range of the flash chip
> >>>>>+     - bank-width : Width (in bytes) of the flash bank.  Equal to the device width
> >>>>>+       times the number of interleaved chips.
> >>>>>+     - device-width : (optional) Width of a single flash chip.  If omitted,
> >>>>>+       assumed to be equal to 'bank-width'.
> 
> >>>>   Why then not just introduce the "interleave" prop and obsolete the
> >>>>"bank-width"?
> 
> >>>Because they're equivalent information, and bank-width is what the
> >>>code ends up actually caring about.  I don't see any reason to prefer
> >>>giving the interleave.
> 
> >>    Well, "device-width" is not the thing that we care about either. ;-)
> 
> > Well, yes but we need to encode it somehow.  Segher preferred
> > device-width to interleave, because it's closer to a description of
> > the actual hardware, rather than an abstration decribing its wiring.
> 
> > In other words I *still* don't see any reason to prefer giving the
> > interleave.
> 
>     I wasn't talking of "interleave" preference over "device-width", I was 
> talking about obsoleting "bank-width" with this pair.

Whatever.  You haven't given any argument to prefer interleave over
either device-width or bank-width.

> >>>>>Index: working-2.6/drivers/mtd/maps/physmap_of.c
> >>>>>===================================================================
> >>>>>--- working-2.6.orig/drivers/mtd/maps/physmap_of.c	2007-07-30 17:07:11.000000000 +1000
> >>>>>+++ working-2.6/drivers/mtd/maps/physmap_of.c	2007-07-30 17:07:14.000000000 +1000
> 
> >>[...]
> 
> >>>>>+	for (pp = dp->child, i = 0 ; pp; pp = pp->sibling, i++) {
> >>>>>+		const u32 *reg;
> >>>>>+		const char *name;
> >>>>>+		const void *ro;
> 
> >>>>   We hardly need the above 2 variables.
> 
> >>>They're all used...
> 
> >>    I meant that there's no necessity in them.
> 
> > By which you mean....?
> 
>     They're only written to once, and then read immediately which might be 
> easily collapsed into a single statement.

Ah, yes, ok.  Changed.

> >>[...]
> 
> >>>>>@@ -221,6 +297,14 @@ err_out:
> >>>>>
> >>>>>static struct of_device_id of_physmap_match[] = {
> >>>>>	{
> >>>>>+		.compatible	= "cfi-flash",
> >>>>>+		.data		= (void *)"cfi_probe",
> >>>>>+	},
> >>>>>+	{
> >>>>>+		.compatible	= "jedec-flash",
> >>>>>+		.data		= (void *)"jedec_probe",
> >>>>>+	},
> >>>>>+	{
> 
> >>>>   This would also trigger on non-linearly mapped CFI or JEDEC
> >>>>flashes which is not a good idea -- however, as we're using the MTD
> >>>>probing code anyway, it will just fail, so it's not luckily is not a
> >>>>fatal design flaw.
> 
> >>>Well, if there's nothing else to distinguish them.  Which there isn't
> >>>yet, but will need to be: see above about incomplete - helpful
> >>>suggestions about how to describe the mapping would be more useful
> >>>than merely pointing out the lack.
> 
> >>    I was thinking about adding "direct-mapped" prop... but maybe adding 
> >>"ranges" to the parent node (that's "ebc") would indeed ensure that the flash 
> >>is mapped 1:1 to the EBC's parent bus also.
> 
> > The ebc already has a ranges property.  But that can't describe the
> 
>     Not in the device tree that started that thread -- I haven't seen another.

Ah sorry.  The ranges property isn't in the dts, it's added by the
bootwrapper based on the EBC register contents.

> > sorts of bit-swizzling you're talking about.
> 
>     Let's hear what Segher says (if he's not yet tired of all this :-).
> 
> >>>>>Index: working-2.6/arch/powerpc/boot/dts/ebony.dts
> >>>>>===================================================================
> >>>>>--- working-2.6.orig/arch/powerpc/boot/dts/ebony.dts	2007-07-30 17:07:14.000000000 +1000
> >>>>>+++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-07-30 17:07:14.000000000 +1000
> 
> >>>>[...]
> 
> >>>>>@@ -158,14 +161,20 @@
> >>>>>				};
> 
> >>>>>				large-flash@2,0 {
> 
> >>>>   Hmm... what does @2,0 mean? :-O
> 
> >>>EBC chip select 2, offset 0.
> 
> >>    Well, so this node is under some kind of local bus node -- that's good.
> >>Didn't know that the spec allows commas after @...
> 
> > Well, now you do.  I believe USB usually uses that format, too.
> 
>     USB what, hosts or devices?

Devices.

> >>>>>-					device_type = "rom";
> >>>>>-					compatible = "direct-mapped";
> >>>>>-					probe-type = "JEDEC";
> >>>>>+					compatible = "jedec-flash";
> >>>>>					bank-width = <1>;
> >>>>>-					partitions = <0 380000
> >>>>>-						      380000 80000>;
> >>>>>-					partition-names = "fs", "firmware";
> >>>>>+//					partitions = <0 380000
> >>>>>+//						      380000 80000>;
> >>>>>+//					partition-names = "fs", "firmware";
> >>>>>					reg = <2 0 400000>;
> >>>>>+					#address-cells = <1>;
> >>>>>+					#size-cells = <1>;
> 
> >>>>   Heh...
> 
> >>>Yeah, that bit's a bit ugly, I'll grant you.
> 
> >>    Don't we need "ranges" here, at least from the formal PoV -- as the parent 
> >>and child address spaces differ? I know the physmap_of parser doesn't care but 
> >>still...
> 
> > That's one I've wondered about.  To describe the partitions address
> > space as lying (ultimately) in the physical address space, which in a
> > sense it does, yes we'd need a ranges property here.  But we also have
> > a 'reg' at the top level which would overlap with that hypothetical
> > ranges which would be weird.  Or we could exclude the top-level reg,
> > but then that's a pain if we do want to map the flash as a whole.
> 
>     Hm, right... the option here would be to always have at least one 
> partition and no "reg" property in the MTD node itself... or have "reg" with 
> no partition and "ranges" if partitions are there... :-)

Eck.

> > So I left out ranges, on the grounds that there isn't actually
> > anything at present which will attempt to access flash partitions
> > "generically" as a device tree device. 
> 
> > I'm not sold on this approach, but I haven't heard you give a better
> > argument yet.
> 
>    Well, that was mostly thoretic speculation...
> 
> WBR, Sergei
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
