Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 48365B7BDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 08:19:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31E74DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 08:19:05 +1000 (EST)
Subject: Re: [RFC] Clock binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mitch Bradley <wmb@firmworks.com>
In-Reply-To: <4A96F69A.5050003@firmworks.com>
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop>  <4A96F69A.5050003@firmworks.com>
Content-Type: text/plain
Date: Fri, 28 Aug 2009 08:18:51 +1000
Message-Id: <1251411532.20467.74.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-08-27 at 11:11 -1000, Mitch Bradley wrote:

> I refrained from commenting as I didn't want to get involved in an 
> endless argument about "goodness".

Oh well, I asked for it, didn't it ? :-)

> Indexed arrays are appropriate for some cases and names are better for 
> others.  Names are especially good for large spaces that are sparse or 
> weakly-structured.  The same is true for subroutine arguments.  It's 
> nice to be able to write setup_uart(baud=115200, flow_control=rts_cts), 
> but you would go crazy (or become a COBOL programmer) if you had to name 
> every argument to every subroutine.

Agreed.

> Open Firmware often avoids indexed structures.  Cases in point include 
> the use of named properties instead of fixed structures and named 
> methods instead of function pointer arrays.  Open Firmware's use of 
> arrays for reg properties seems like the right choice for that 
> particular case, but shouldn't be construed to suggest that arrays are 
> good for everything.

Well, the "reg" property is fine for the common cases of devices with
one IO (or MMIO) range, no confusion possible, or PCI since it encodes
the BAR number. For other cases, especially random embedded stuff that
maps several regions of memory, it's a bit harder since we go back to
the need of having "somebody" define which region is which.

> One problem you run into with names is the "registration authority" 
> problem.

Right.

>   Who maintains the list of valid names to avoid collisions and 
> to ensure consistent spelling?  It's a solvable problem, but one that 
> must be considered.  Of course, a related problem exists with indices - 
> what is the meaning of index value "N", and how do you manage the 
> addition of new fields and deletion of others?  Names are easier to 
> manage in some cases and indices easier in others.

Maybe to some extent. I tend to prefer names whenever possible, but I
agree that the "central authority" problem is always around.

> In the particular case of a clock binding, I don't have enough 
> experience with the problem details to have formed a strong opinion.

I'm in a similar situation, hence my request for comment. From my
observations though, clock inputs are generally named on a given chip,
IO core, SoC, etc... hence, I would suggest using a case insensitive
matching with a recommendation to use the name of the clock pin or clock
input signal in the case of IP cores as per the spec of the chip. This
sounds better than an arbitrary number. So at least for the naming of
clock inputs on a device, I do have a warm feeling with using names.

It has the added advantage from my selfish point of view which is that I
have to deal in Linux with an existing name based API and existing
drivers using it :-) Though the common case for 1 clock per device is to
pass NULL, which makes the problem go away.

In the same idea of simplifying the easy cases, you'll note that I made
it legit to have a clock provider simply have a "clock-frequency"
property and as such "fit" within existing practices for fixed frequency
non-programable clock sources.

Now, where I'm less comfortable is the naming on the clock provider
side. IE. My initial proposal was calling for binding named inputs to
indexed outputs on the provider. My new proposal makes that index a
simple convention in a given tree by having the provider also map those
to names since I didn't like the discrepancy here.  

I suppose we could go roughly with the same idea, which is that the name
is case insensitive and matched on the part manufacturer's output
pin/signal name.

In any case, I'm sure what we do won't be absolutely perfect but it's
that or doing nothing and at this stage I believe we are in a situation
where even an imperfect solution will be greatly beneficial. In any
case, driver and architecture code can always work around problems such
as a device-tree providing a different name than what the driver
expects.

> Are there well-known clock names that will be used in common code that 
> is shared among different vendors (e.g. "primary-clock")?  If so, the 
> binding should "preregister" a list of common names.

Well... I was more thinking about the signal name on the part. I want to
avoid using global clock names. IE. I want to avoid having to put in the
picture the name of the clock wires in the SoC or chip (SYSCLK,
PCICLK, ...) because typically those do vary from board to board and
vendor to vendor. But the name of the clock input on a device chip and
the name of the clock output on a PLL chip tend to be defined by the
datasheet of the said chip :-) Of course there are going to be
interesting variations such as compatible chips from different
manufacturers but, mostly we should cope better than magic indices.

> Will implementors of new hardware have to scratch their heads to decide 
> what to name their clock inputs?  The binding should offer some guidance 
> about good name choices and spelling rules, to avoid an eventuall mess 
> as new people come on board and pull names out of the air, with 
> different conventions for capitalization and punctuation and abbreviation.

Should they ? IE. If the names come from the part datasheet, and we make
the matching case insensitive, I don't see that much need of the chip
vendors or board designers caring that much about rules for naming the
clocks.

> One advantage of indices is that they avoid endless arguments about the 
> exact name (and spelling) of things.

Right, though in that case, nobody gets to have to decide on the name,
it comes from the chip manufacturer pin naming or data sheet.

>   In my current project, there are 
> several different hardware manuals for the same that must all be 
> consulted to get the full picture, and they often use different names or 
> inconsistent spellings for the same thing.  It makes finding things very 
> challenging.

Agreed about the general problem area.

> With a name-based interface, it pays to keep in mind that lots of people 
> will ultimately be involved. Many of them will be new so they won't know 
> the conventions well, and few will be careful and precise in their use 
> of language (i.e. names).  Provide a lot of guidance about how to choose 
> a set of names.

And the easier the problem appears to be, the more people without a clue
about what they are talking about will feel compelled to intervene in
the discussion :-)

> Suppose there were a conventional set of names like "clock0", "clock1", 
> ..., essentially boiling down to verbosely-spelled indices.  I expect 
> that a lot of people would choose to use it just to avoid having to 
> thing of better names and having "bike shed" arguments with coworkers.
> 
> So there you have it - my incoherent rambling commentary with no 
> particular conclusion.

Nah, it's interesting, it also forces me to write down my thought with
better details.

Cheers,
Ben.

> > Cheers,
> > Ben.
> >
> >   
> >> > I'm cooking up a patch that replace our current primitive implementation
> >> > in arch/powerpc/kernel/clock.c with something along the lines of what I
> >> > described. However, I want a bit more churn here on the device-tree
> >> > related bits.
> >> > 
> >> > So, basically, the goal here is to define a binding so that we can link
> >> > a device clock inputs to a clock provider clock outputs.
> >> > 
> >> > In general, in a system, there's actually 3 "names" involved. The clock
> >> > provider output name, the clock signal name, and the clock input name on
> >> > the device. However, I want to avoid involving the clock signal name as
> >> > it's a "global" name and it will just end up being a mess if we start
> >> > exposing that.
> >> > 
> >> > So basically, it boils down to a device having some clock inputs,
> >> > referenced by names, that need to be linked to another node which is a
> >> > clock provider, which has outputs, references either by number or names,
> >> > see discussion below.
> >> > 
> >> > First, why names, and not numbers ? IE. It's the OF "tradition" for
> >> > resources to just be an array, like interrupts, or address ranges in
> >> > "reg" properties, and one has to know what the Nth interrupt correspond
> >> > too.
> >> > 
> >> > My answer here is that maybe the tradition but it's crap  :-)  Names are
> >> > much better in the long run, besides it makes it easier to represent if
> >> > not all inputs have been wired. Also, to some extent, things like PCI do
> >> > encode a "name" with "reg" or "assigned-addresses" properties as part of
> >> > the config space offset in the top part of the address, and that has
> >> > proved very useful.
> >> > 
> >> > Thus I think using names is the way to go, and we should even generalize
> >> > that and add a new "interrupt-names" property to name the members of an
> >> > "interrupts"  :-) 
> >> > 
> >> > So back to the subject at hand. That leaves us with having to populate
> >> > the driver with some kind of map (I call it clock-map). Ideally, if
> >> > everything is named, which is the best approach imho, that map would
> >> > bind a list of:
> >> > 
> >> > 	- clock input name
> >> > 	- clock provider phandle
> >> > 	- clock output name on provider
> >> > 
> >> > However, it's a bit nasty to mix strings and numbers (phandles) in a
> >> > single property. It's possible, but would likely lead to the phandle not
> >> > being aligned and tools such as lsprop to fail miserably to display
> >> > those properties in any kind of readable form.
> >> > 
> >> > My earlier emails proposed an approach like this:
> >> > 
> >> > 	- clock input names go into a "clock-names" property
> >> > 	  (which I suggest naming instead "clock-input-names" btw)
> >> > 
> >> > 	- the map goes into a "clock-map" property and for each input
> >> > 	  provides a phandle and a one cell numerical ID that identifies
> >> > 	  the clock on the source.
> >> > 
> >> > However, I really dislike that numerical clock ID. Magic numbers suck.
> >> > It should be a string. But I don't want to add a 3rd property in there.
> >> > 
> >> > Hence my idea below. It's not perfect but it's the less sucky i've come
> >> > up with so far. And then we can do some small refinements.
> >> > 
> >> > 	* Device has:
> >> > 
> >> > 		- "clock-input-names" as above
> >> > 		- "clock-map" contains list of phandle,index
> >> > 
> >> > 	* Clock source has:
> >> > 
> >> > 		- "clock-output-names" list of strings
> >> > 
> >> > The "index" in the clock map thus would reference the
> >> > "clock-output-names" array in the clock provider. That means that the
> >> > "magic number" here is entirely local to a given device-tree, doesn't
> >> > leak into driver code, which continues using names.
> >> > 
> >> > In addition, we can even have some smooth "upgrade" path from existing
> >> > "clock-frequency" properties by assuming that if "clock-output-names" is
> >> > absent, but "clock-frequency" exist, then index 0 references a fixed
> >> > frequency clock source without a driver. This could be generally handy
> >> > anyway to represent crystals of fixed bus clocks without having to write
> >> > a clock source driver for them.
> >> > 
> >> > Any comments ?
> >> > 
> >> > I'll post a patch, maybe later today, implementing the above (I may or
> >> > may not have time to also convert the existing 512x code to it, we'll
> >> > see).
> >> > 
> >> > Cheers,
> >> > Ben.
> >> > 
> >> > 
> >> >  
> >> > 
> >> > 
> >> > _______________________________________________
> >> > devicetree-discuss mailing list
> >> > devicetree-discuss@lists.ozlabs.org
> >> > https://lists.ozlabs.org/listinfo/devicetree-discuss
> >>     
> >
> >   
