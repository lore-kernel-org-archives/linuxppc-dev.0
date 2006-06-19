Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ACB0667AC6
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2006 09:34:15 +1000 (EST)
In-Reply-To: <1150759075.23600.297.camel@localhost.localdomain>
References: <1150598731.23600.146.camel@localhost.localdomain>
	<EC61A880-9242-4BCE-B72D-8AFC038CD592@freescale.com>
	<3E324A7E-388E-4917-B380-B0831A5F9D19@kernel.crashing.org>
	<1150759075.23600.297.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DDDC9CD5-E027-44C4-8EE1-D1476EE35967@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Interrupt mapping documentation
Date: Tue, 20 Jun 2006 01:34:04 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Becky Bruce <Becky.Bruce@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Most "real" device trees (on a "real" OF) do not have "interrupt-
>> controller"
>> as the name of their main interrupt controller nodes.  This sounds
>> like a
>> spec bug.
>
> I haven't specified that it _should_ be called interrupt- 
> controller, but
> it's generally called that way at least on chrp/pSeries and I think
> there's an OF recommended practices RFC that says something around  
> those
> lines, so I changed the examples to reflect that.

In my opinion, the device _name_ should in the first place be useful
to the human user, so be a _bit_ detailed, although not to much.  The
various OF documents, no matter what their status, seem to swing one
way or the other though.

Anyway, "mpic" or "openpic" are very common interrupt controller
device node names as well.

>>> "In general, the format of an address for a device is defined by the
>>> parent bus type, based on the #address-cells and #size-cells
>>> property. In the absence of such a property, the parent's parent
>>> values are used, etc..."
>>
>> Bad already; #size-cells has nothing to do with addresses (it's
>> important for address _ranges_ though).
>
> That's an old bit of the spec that you could have commented on a long
> time ago :)

I never read the thing before ;-P  [Or detailed enough to comment on
it, anyway].  Doesn't mean you shouldn't fix it :-)

> Though a "reg" property contains an address range and the

This is not true in general.  There's nodes with #size-cells = 0...
Degenerate range yeah, yadda yadda.

> above was talking about those mostly. I need to clarify.

Please!

> In addition,
> the default-to-parent thing is something I'll remove from the spec and
> write that the absence of the property is undefined I think.

Great.  The "default to two" thing is just a compatibility thing for old
old OpenBoot afaict anyway.

> We'll keep
> the current behaviour in linux for now though.

Fine of course.

>>> The additions in the patch specify new requirements that don't seem
>>> to match up with the statement above.  In the new patch, #address-
>>> cells is listed as a required node for interrupt-controller nodes,
>>> there's no mention of inheritance from a parent,
>>
>> Inheritance from the parent does not exist, in real OF.  Absence of
>> #address-cells means "default to 2".  This needs to be fixed in DTC.
>
> Yes. Except that I will probably not do the "default to 2". The kernel
> doesn't do it and there might still be things relying on the old
> (broken) linux behaviour. Thus I'll probably spec it as undefined.

Error or warning, in the compiler?  My vote is error...

>>> and in one place in
>>> the Nexus section, it's stated that if there's no #address-cells  
>>> node
>>> the kernel assumes it's 0.
>>
>> Also wrong.  Although I think that's what the IMAP thing says as  
>> well...
>
> Yes, it seems the default is different when parsing interrupts... at
> least when hitting an interrupt-controller node, which is not a  
> standard
> address parsing.

This in practice would apply to interrupt controller nodes that are
a _real_ interrupt controller, so not a parent of a bus, so a) no
child nodes that need addresses, and b) indeed no interrupt unit spec
to care about, for the incoming interrupts.  It's still ugly though :-(

>>> I think the doc needs a bit of clarification in this area.
>>
>> Yeah.
>>
>> Just *require* #address-cells for everything with addressable sub- 
>> nodes,
>> at least in DTC.  Doesn't cost much, and no confusion anymore.
>
> Yes. We should do that.

Oh, agreement!

> In the case of interrupt controllers/nexus, #address-cells is not for
> addressable sub-nodes though but for defining the format of unit
> interrupt specifiers for interrupt-childs which aren't necessary sub
> nodes... confusing heh ?

You want confusing?  You can have the situation where some of those
interrupt children *are* bus children, as well!  *And* some are not.

No I still havent't figured out the complete IMAP-compatible interrupt
map for JS21 yet.


Segher
