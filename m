Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06AB967C9C
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 09:03:13 +1100 (EST)
In-Reply-To: <457F1F6E.4020502@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>
	<1165890570.11914.5.camel@localhost.localdomain>
	<457F1F6E.4020502@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E8320867-EDC5-42F9-81EE-E66B6D216ADA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Tue, 12 Dec 2006 16:03:04 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 3:30 PM, Scott Wood wrote:

> Benjamin Herrenschmidt wrote:
>> Well, either you want all freescale boards have one platform.
>> in which case you write one ppc_md() structure, call it
>> mpc83xx_fslboards or something like that, and have a probe routine  
>> that
>> test for all matches, or create as many ppc_md structures as you have
>> boards each with it's own probe().
>>
>> The point here is that other developpers making their own mpc83xx  
>> based
>> boards will not want to use your ppc_md.
>
> They *may* not want to (and they certainly shouldn't be forced to),  
> but
> some may not want to define a new ppc_md (or modify a probe function)
> for every new board if all of the differences are encapsulated in the
> device tree.  I thought one of the main goals of having a device  
> tree is
> that if it's done right, the kernel need not know about every single
> model of board, just the different components that a device tree can
> specify.

That's true, and if that's the case you'd just set your "model" to  
match an existing supported ppc_md.

> If a board has truly board-specific logic that needs custom code in  
> the
> kernel itself (rather than the bootloader), then it can go in as a
> driver with a device tree node (this should be done with the BCSR  
> stuff
> where needed).

This is not always the case, there are times when you have board  
specific modifications you make in the early kernel code.  There are  
a number of different reasons you would want to do this.  The BCSR  
stuff you reference is a Freescale board specific feature.

> What about something like the original patch, but with "mpc83xx- 
> generic"
> (or similar) as the compatible match?  This would address the "matches
> everything with mpc83xx in it" concern, without requiring kernel  
> changes
> when a new device tree is all that's really needed, and without
> requiring non-freescale boards to have something like "fslboards"  
> in the
>   compatible property just in order to use generic platform
> initialization code *if they want to*.  Once the BCSR and RTC stuff is
> (re)moved, there's really not much of anything fslboard-specific in  
> there.

True, but I dont see what the desire is to create a 'generic' 83xx  
support.  Who gets to define what is considered 'generic'?  What  
issue are you guys trying to solve?

Once upon a time I thought the concept of a generic board and such  
was a good thing.  After many a discussion with DanM, I've been  
convinced there isn't that much utility to it in the embedded space :).

If there is some real issue you guys are thinking about, lets talk  
about it.  But the concept of 'generic' 83xx board support is as  
useless waste of time.  I'm all for refactoring code so my board code  
is simpler, but at the end of the day I know there are people that  
are going to need board specific code for their environments.

- kumar

> More generally (and longer-term), what about a completely generic
> platform init file that implements the "booting-without-of.txt"
> platform?  That is, a string that can be placed in the compatible
> property, regardless of board or CPU, in order to assert that nothing
> board-specific has to be done other than as specified by the device
> tree.  The model property could still hold the actual board ID if  
> needed
> to present to the user, or for matching a more specialized machine
> description if problems arise and the device tree cannot be easily
> changed (the generic probe could be arranged to run last).
>
> Alternately, just allow the kernel to boot without finding a matching
> probe, if generic code is able to extract enough information from the
> device tree for generic versions of any non-optional ppc_md  
> functions to
> work.  If a probe does match, then it can fill in any ppc_md fields it
> wants to override (and/or do special initialization, etc).  ppc_md
> fields can also be filled in by CPU-specific code, or by drivers the
> device tree instantiates.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
