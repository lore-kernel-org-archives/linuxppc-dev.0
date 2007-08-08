Return-Path: <dgibson@ozlabs.org>
Date: Wed, 8 Aug 2007 10:35:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070808003505.GB25082@localhost.localdomain>
References: <65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<20070806042109.GB6103@localhost.localdomain>
	<46B76A5A.3030300@ru.mvista.com>
	<20070807032806.GE15619@localhost.localdomain>
	<e20238f937f1328cc3db88840b3c7fc3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e20238f937f1328cc3db88840b3c7fc3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2007 at 06:43:35PM +0200, Segher Boessenkool wrote:
> >>> Aha!  Ok, now I understand the sorts of situations you're talking
> >>> about.  By "not direct mapped", I thought you were talking about some
> >>> kind of access via address/data registers on some indirect bus
> >>> controller, rather than weird variations on endianness and
> >>> bit-swizzling.
> >>
> >>     No, that would be just too ridiculous for a NOR flash -- I hope. 
> >> :-)
> >
> > Heh.  In my experience, very little is so ridiculous that some
> > embedded vendor won't do it.
> 
> True -- but if you can't map the NOR into the CPU address space,
> there are cheaper alternatives.  Most embedded vendors care about
> that, too ;-)
> 
> >>     So, you're saying that the 1:1 address correspondence rule stops 
> >> to apply
> >> here?
> >
> > Well.. it all depends what exactly you consider the address space of
> > the flash bank.  By which I mean the whole shmozzle represented by the
> > device node, not the individual flash chips.  It's not immediately
> > obvious whether or not that should include any swizzling done by the
> > bus wiring.
> 
> The parent device/bus shouldn't care, from its viewpoint the flash
> bank is just one linear hunk of address space.  For reading or
> writing the flash bank appears linear to the CPU as well (at least
> that's the only thing our current proposed binding supports); the
> only thing that gets "interesting" is sending commands to the flash
> chips.
> 
> > It would be possible, I guess, to define a 'swizzled-ranges' property
> > or something which allows child devices to be embedded in the parent's
> > address range in a not-direct way.
> 
> Let's not even consider this please.
> 
> > However, the swizzling on the
> > flash bank is really a property of the flash bank,
> 
> Yeah, it's the "fine structure" of the flash bank.  Something
> only the flash driver has to deal with.  So no contaminating the
> parent device node, thank you.

Sounds like we're in agreement, then.


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
