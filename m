Return-Path: <wmb@firmworks.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 78885B7BBB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 28 Aug 2009 07:12:26 +1000 (EST)
Received: from rs35.luxsci.com (rs35.luxsci.com [66.216.127.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AF0D0DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Aug 2009 07:12:25 +1000 (EST)
Message-ID: <4A96F69A.5050003@firmworks.com>
Date: Thu, 27 Aug 2009 11:11:54 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Clock binding
References: <1250569288.19007.15.camel@pasglop>
	<1251346157.20467.22.camel@pasglop>
In-Reply-To: <1251346157.20467.22.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

>
> On Tue, 2009-08-18 at 14:21 +1000, Benjamin Herrenschmidt wrote:
>   
>> > So here's a followup to my discussion about the clock API.
>>     
>
> Really nobody has a comment here ?  :-)  Not even Mitch ?
>   

I refrained from commenting as I didn't want to get involved in an 
endless argument about "goodness".

Indexed arrays are appropriate for some cases and names are better for 
others.  Names are especially good for large spaces that are sparse or 
weakly-structured.  The same is true for subroutine arguments.  It's 
nice to be able to write setup_uart(baud=115200, flow_control=rts_cts), 
but you would go crazy (or become a COBOL programmer) if you had to name 
every argument to every subroutine.

Open Firmware often avoids indexed structures.  Cases in point include 
the use of named properties instead of fixed structures and named 
methods instead of function pointer arrays.  Open Firmware's use of 
arrays for reg properties seems like the right choice for that 
particular case, but shouldn't be construed to suggest that arrays are 
good for everything.

One problem you run into with names is the "registration authority" 
problem.  Who maintains the list of valid names to avoid collisions and 
to ensure consistent spelling?  It's a solvable problem, but one that 
must be considered.  Of course, a related problem exists with indices - 
what is the meaning of index value "N", and how do you manage the 
addition of new fields and deletion of others?  Names are easier to 
manage in some cases and indices easier in others.

In the particular case of a clock binding, I don't have enough 
experience with the problem details to have formed a strong opinion.

Are there well-known clock names that will be used in common code that 
is shared among different vendors (e.g. "primary-clock")?  If so, the 
binding should "preregister" a list of common names.

Will implementors of new hardware have to scratch their heads to decide 
what to name their clock inputs?  The binding should offer some guidance 
about good name choices and spelling rules, to avoid an eventuall mess 
as new people come on board and pull names out of the air, with 
different conventions for capitalization and punctuation and abbreviation.

One advantage of indices is that they avoid endless arguments about the 
exact name (and spelling) of things.  In my current project, there are 
several different hardware manuals for the same that must all be 
consulted to get the full picture, and they often use different names or 
inconsistent spellings for the same thing.  It makes finding things very 
challenging.

With a name-based interface, it pays to keep in mind that lots of people 
will ultimately be involved. Many of them will be new so they won't know 
the conventions well, and few will be careful and precise in their use 
of language (i.e. names).  Provide a lot of guidance about how to choose 
a set of names.

Suppose there were a conventional set of names like "clock0", "clock1", 
..., essentially boiling down to verbosely-spelled indices.  I expect 
that a lot of people would choose to use it just to avoid having to 
thing of better names and having "bike shed" arguments with coworkers.

So there you have it - my incoherent rambling commentary with no 
particular conclusion.

> Cheers,
> Ben.
>
>   
>> > I'm cooking up a patch that replace our current primitive implementation
>> > in arch/powerpc/kernel/clock.c with something along the lines of what I
>> > described. However, I want a bit more churn here on the device-tree
>> > related bits.
>> > 
>> > So, basically, the goal here is to define a binding so that we can link
>> > a device clock inputs to a clock provider clock outputs.
>> > 
>> > In general, in a system, there's actually 3 "names" involved. The clock
>> > provider output name, the clock signal name, and the clock input name on
>> > the device. However, I want to avoid involving the clock signal name as
>> > it's a "global" name and it will just end up being a mess if we start
>> > exposing that.
>> > 
>> > So basically, it boils down to a device having some clock inputs,
>> > referenced by names, that need to be linked to another node which is a
>> > clock provider, which has outputs, references either by number or names,
>> > see discussion below.
>> > 
>> > First, why names, and not numbers ? IE. It's the OF "tradition" for
>> > resources to just be an array, like interrupts, or address ranges in
>> > "reg" properties, and one has to know what the Nth interrupt correspond
>> > too.
>> > 
>> > My answer here is that maybe the tradition but it's crap  :-)  Names are
>> > much better in the long run, besides it makes it easier to represent if
>> > not all inputs have been wired. Also, to some extent, things like PCI do
>> > encode a "name" with "reg" or "assigned-addresses" properties as part of
>> > the config space offset in the top part of the address, and that has
>> > proved very useful.
>> > 
>> > Thus I think using names is the way to go, and we should even generalize
>> > that and add a new "interrupt-names" property to name the members of an
>> > "interrupts"  :-) 
>> > 
>> > So back to the subject at hand. That leaves us with having to populate
>> > the driver with some kind of map (I call it clock-map). Ideally, if
>> > everything is named, which is the best approach imho, that map would
>> > bind a list of:
>> > 
>> > 	- clock input name
>> > 	- clock provider phandle
>> > 	- clock output name on provider
>> > 
>> > However, it's a bit nasty to mix strings and numbers (phandles) in a
>> > single property. It's possible, but would likely lead to the phandle not
>> > being aligned and tools such as lsprop to fail miserably to display
>> > those properties in any kind of readable form.
>> > 
>> > My earlier emails proposed an approach like this:
>> > 
>> > 	- clock input names go into a "clock-names" property
>> > 	  (which I suggest naming instead "clock-input-names" btw)
>> > 
>> > 	- the map goes into a "clock-map" property and for each input
>> > 	  provides a phandle and a one cell numerical ID that identifies
>> > 	  the clock on the source.
>> > 
>> > However, I really dislike that numerical clock ID. Magic numbers suck.
>> > It should be a string. But I don't want to add a 3rd property in there.
>> > 
>> > Hence my idea below. It's not perfect but it's the less sucky i've come
>> > up with so far. And then we can do some small refinements.
>> > 
>> > 	* Device has:
>> > 
>> > 		- "clock-input-names" as above
>> > 		- "clock-map" contains list of phandle,index
>> > 
>> > 	* Clock source has:
>> > 
>> > 		- "clock-output-names" list of strings
>> > 
>> > The "index" in the clock map thus would reference the
>> > "clock-output-names" array in the clock provider. That means that the
>> > "magic number" here is entirely local to a given device-tree, doesn't
>> > leak into driver code, which continues using names.
>> > 
>> > In addition, we can even have some smooth "upgrade" path from existing
>> > "clock-frequency" properties by assuming that if "clock-output-names" is
>> > absent, but "clock-frequency" exist, then index 0 references a fixed
>> > frequency clock source without a driver. This could be generally handy
>> > anyway to represent crystals of fixed bus clocks without having to write
>> > a clock source driver for them.
>> > 
>> > Any comments ?
>> > 
>> > I'll post a patch, maybe later today, implementing the above (I may or
>> > may not have time to also convert the existing 512x code to it, we'll
>> > see).
>> > 
>> > Cheers,
>> > Ben.
>> > 
>> > 
>> >  
>> > 
>> > 
>> > _______________________________________________
>> > devicetree-discuss mailing list
>> > devicetree-discuss@lists.ozlabs.org
>> > https://lists.ozlabs.org/listinfo/devicetree-discuss
>>     
>
>   
