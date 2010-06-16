Return-Path: <tim.bird@am.sony.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 73002B7D61
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 03:59:02 +1000 (EST)
Message-ID: <4C190D50.2010501@am.sony.com>
Date: Wed, 16 Jun 2010 10:43:44 -0700
From: Tim Bird <tim.bird@am.sony.com>
MIME-Version: 1.0
To: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Request review of device tree documentation
References: <4C13430B.5000907@firmworks.com>	<1276339529.1962.184.camel@pasglop>
	<1276339684.1962.186.camel@pasglop>	<4C13B618.1030006@firmworks.com>
	<1276383132.1962.195.camel@pasglop>	<AANLkTimRV8u3gDNCAIlROJoPcKs7jFwj2na3ZDFOg3O0@mail.gmail.com>	<4C146F18.9030008@firmworks.com>	<AANLkTikls3hjXOmKFqG2D_9GaJSjOXNuuRXPlanAjo5E@mail.gmail.com>	<20100614124438.GF9323@yookeroo>	<alpine.LFD.2.00.1006141044510.13427@xanadu.home>	<20100614160201.GD9550@shareable.org>
	<4C165FD1.6080505@firmworks.com>	<4C186AA8.4040709@compulab.co.il>
	<4C186B7B.1060308@firmworks.com>	<4C186C72.2020506@compulab.co.il>
	<4C187013.5000400@firmworks.com>	<4C18738C.4090809@compulab.co.il>
	<4C187FF0.5020806@firmworks.com>	<4C18A9C7.5070800@compulab.co.il>
	<alpine.LFD.2.00.1006160917390.13427@xanadu.home>
In-Reply-To: <alpine.LFD.2.00.1006160917390.13427@xanadu.home>
Content-Type: text/plain; charset="UTF-8"
Cc: "microblaze-uclinux@itee.uq.edu.au" <microblaze-uclinux@itee.uq.edu.au>,
	devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
	Jamie Lokier <jamie@shareable.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Mike Rapoport <mike@compulab.co.il>, Mitch Bradley <wmb@firmworks.com>,
	Dan Malek <ppc6dev@digitaldans.com>,
	Jeremy Kerr <jeremy.kerr@canonical.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/16/2010 07:39 AM, Nicolas Pitre wrote:
> The cost function _is_ different for the Linux community and decision 
> makers at chip vendor companies. I know that for having worked long 
> enough at a prominent chip vendor already.
> 
> Those vendors want to ship a product and be first on the market before 
> the competitors do.  They grab a kernel tree, fit in their existing HAL 
> as quickly as they can, so that they are able to demo the new chip to 
> potential customers even before moving to full production.  And if the 
> HAL fitting work has been done into last year's kernel already, then 
> they will simply reuse that kernel to minimize the effort further as in 
> theory only the HAL part needs to be swapped with the new one (doesn't 
> matter if last year's kernel was itself already based on a kernel from 
> the year before).  Once the software appears to work, they send it to 
> customers and forget about it as they move to the next chip design.  So 
> here, the cost is directly related to bring-up time, and quick (or big) 
> ugly software hacks are more than a convenience but rather a necessity 
> if you want to win the race.
> 
> People from the Linux community care about totally different things. The 
> most important factor here is _long term_ maintainability.  It is 
> important that the code be clean, use a uniform coding style, and follow 
> common interfaces.  This is so because the cost function here is 
> directly related to the difficulty for the Linux community to evolve the 
> kernel with generic improvements and new features.  If each driver has a 
> different style, or rely on a different HAL, then it quickly becomes 
> extremely expensive to update those drivers along with the generic 
> improvements.  And if the HAL is in binary form only, or stuck behind 
> some unalterable BIOS-like calls or firmware API, then it may even be 
> impossible to update those drivers as the execution context assumed by 
> the HAL firmware may not be guaranteed anymore (think about UP vs SMP, 
> different preemption modes, different realtime kernel modes, etc.)  And 
> of course it is impossible to anticipate what execution context and 
> requirements the kernel might need in the future, hence this can't be 
> provisioned for (and much less validated) into the HAL design in advance 
> (and see above why it is next to hopeless to expect vendors to update 
> their HAL for old products in a timely fashion).
> 
> So there *is* indeed a big difference between both points of view.  And 
> sometimes the imperatives from each group are in total conflict.

This is absolutely correct.  At the CE Linux Forum, we've been working
for years to try to get vendors more involved in the community, with
a variety of techniques, including white papers for management,
magazine articles, outreach at industry events, and hosting our
own events to introduce "industry" and "community" developers.

It is not uncommon for vendors to throw the software away (or big
chunks of it) for each release, which is completely contrary
to the goals of mainline developers.  I once had a product line
where each year for 3 years, the product team used a different
processor ARCHITECTURE.  Stuff like that significantly impairs
the argument that they'll see big wins from mainlining things.

>>> Which of course raises the question:  How does the Linux community view such
>>> SoC vendors?  Are they embraced and eagerly supported,

No.  Mostly, they get chastised and told how wrong they are,
so they just stay away.   Any work they have done is often thrown
under the bus by people who refuse to acknowledge their requirements.
(Witness the suspend blockers thread on linux-pm).

>>> or (either openly or
>>> secretly) viewed as a nuisance?  How does the widespread objection to
>>> something that such vendors "would make extensive use of" mesh with that
>>> view?
>>
>> I cannot tell for the entire Linux community, but from what I know, such
>> vendors are not much welcomed in the community.
> 
> And the reverse is also true: those vendors are not amenable to more 
> openness and early community involvement which could help them get to 
> market with "community acceptable" support for their products due to 
> NDAs and such, or simply because of the perception that the Linux 
> community is putting too much value on "expendable software".  It is way 
> too common to hear from hardware designers that "software is cheap"... 
> which is not quite the case in the end.  That's a real pity.

Also true.  Nicolas - you're on a roll today. :-)
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Network Entertainment
=============================
