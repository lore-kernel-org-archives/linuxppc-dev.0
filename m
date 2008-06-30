Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 60E6CDDF48
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 09:28:23 +1000 (EST)
In-Reply-To: <20080630173008.d6762380.kim.phillips@freescale.com>
References: <20080627115243.d76e0814.kim.phillips@freescale.com>
	<fa686aa40806272229s795067d5he962c8a1750a260@mail.gmail.com>
	<2b97f7566925ed86b78b364ff5724644@kernel.crashing.org>
	<20080630110410.7ee097ed.kim.phillips@freescale.com>
	<e590624fb4ff66d787a2fa3c44e00cbc@kernel.crashing.org>
	<20080630131441.e9b9ac1c.kim.phillips@freescale.com>
	<e07b0ce3c375e9418ac976256c731f03@kernel.crashing.org>
	<20080630173008.d6762380.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <f34059884cc9de85e6e0fe8a934ae06e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] update crypto node definition and device tree instances
Date: Tue, 1 Jul 2008 01:27:58 +0200
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Yes.  As a side note, since there are multiple devices that contain
>> e.g. a sec-1.0, it would be prudent to describe the exact incarnation
>> in the device tree, like "mpc8272-sec" or something, in either "model"
>
> but 'fsl,sec-X.Y' /does/ describe the exact incarnation,

No it doesn't.  If it's on a different SoC, it can have different
bugs.  It might be _meant_ to be exactly the same, but that's not
the same thing.

> whereas
> 'fsl,mpc8349-sec' /does not/.  "fsl,mpc8349-sec' might mean the SEC 2.1
> or the SEC 2.4, it depends on the revision of the mpc8349.

Oh, nasty.  That just means you'll need to put the revision of
the 8349 in there as well, though -- "fsl,mpc8349-rev2-sec" or
something.

>> or "compatible", just in case a problem shows up with one of them.
>
> I thought 'model' was superseded by 'compatible';

"model" is still a valid property.  "model" shouldn't be needed
to find which device driver to use, but any specific device driver
can use it just fine.

> that's why it's taken out here, along with device_type.

"device_type" simply isn't useful for flat device trees (in pretty
much all cases), since it describes the OF programming model of a
device, and almost none of that applies to flat trees.  So yeah,
taking that out is a good thing (esp. in a case like this, where
it isn't defined anywhere what device_type "crypto" means).

>>>> I can't find a manual online for "freescale sec"; googling
>>>> for "freescale sec-1.0" finds a manual for the PowerQUICC I;
>>>> is that the right one?  I don't know, so the binding needs
>>>> to explain it to me.
>>>
>>> the binding shouldn't be responsible for google's shortcomings
>>
>> The binding needs to describe what device it is for.  I am a stupid
>> user, just like most users, so if the binding doesn't tell me I turn
>> to google.  Don't blame them for not finding it; the binding should
>> have told me in the first place!
>
> Again, I don't see how google's results are pertinent in this
> discussion.

It's not about google.  It's about a user who needs to find out
what a certain "compatible" entry means, or who needs to find out
what value to use for a certain device.

> btw, the title for the binding is:
>
>   g) Freescale SOC SEC Security Engines
>
> Is that what you are looking for?

I'm not looking for the binding, I know where it is, thanks; I'm
looking for information in the binding that tells me what "compatible"
value means what.

> If not, what precisely?  a list of
> all the parts?  There's an SEC in every mpc8[35]xxE!

You could do a list of all, sure.  You could also say what a
"compatible" value looks like, and give some representative
examples.

>> The binding at a minimum should describe how to identify each
>> unique version from the device tree, no matter how miniscule
>> those differences are.  Just a specific "compatible" value will
>> do.
>
> I'm at a loss; isn't that what this patch does?

I lost the patch, sorry.  I came into this thread at the point where
Grant said that "fsl,sec1.0" is a horrible "compatible" value.

> Currently the driver matches on "fsl,sec2.0", and if needs be, will
> call of_device_is_compatible with the version number that introduces
> the feature it wants to implement.

That's okay I suppose.  Each device tree still should put the exact
version of the chip in there as well.


Segher
