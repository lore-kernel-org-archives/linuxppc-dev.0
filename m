Return-Path: <dgibson@ozlabs.org>
Date: Tue, 7 Aug 2007 14:09:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Message-ID: <20070807040918.GD13522@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<f8e837f0c3f73a9b47d52be05f1d54cc@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f8e837f0c3f73a9b47d52be05f1d54cc@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Aug 06, 2007 at 10:35:57PM +0200, Segher Boessenkool wrote:
> >> To be honest, I'm not sure that describing the mapping is really the
> >> job of the compatible property.  That the flash is mapped into the
> >> address space is kind of implicit in the way the reg interacts with
> >> the parents' ranges property.
> >
> >     Ah, I keep forgetting about implied 1:1 parent/child address
> > correspondence... :-<
> 
> It's not implied, it is explicitly specified.
> 
> >     But does it really imply how the (low) address bits of the *child* 
> > bus
> > ("ebc" in this case) are connected to the chip?  I don't think so...
> 
> The currently proposed binding assumes linear mapping.
> 
> Strange setups will need to extend this binding; this
> does mean that the burden for that is not on the "normal"
> case.
> 
> There are so many weird ways in which people wire up memory
> devices that there is no chance to define a "generic" binding
> that works for all in less than 400 pages of documentation.
> 
> >     Well, "device-width" is not the thing that we care about either. 
> > ;-)
> 
> You need to know the device-width to drive the chip (and no,
> it isn't enough to know the exact chip model even) -- why do
> you say you don't care about it?
> 
> >>>    Hmm... what does @2,0 mean? :-O
> >
> >> EBC chip select 2, offset 0.
> >
> >     Well, so this node is under some kind of local bus node -- that's 
> > good.
> > Didn't know that the spec allows commas after @...
> 
> Most characters are allowed in the unit-address...  The following
> is just fine: "my-secret-base@the-moon".  ISA uses letters to
> distinguish between its different address spaces, for example.

Yeah, I should probably make dtc a bit more flexible about accepting
that, too.  At present, it only takes hex digits and ',', since those
are the common character.

> There is a direct correspondence between the first "reg"
> address and the text representation of the unit address;
> this correspondence is bus-dependent however.
> 
> David, can multiple devices sit on the same chip-select
> on EBC, or on the same "minor" address?  If not, you can
> simplify your unit address representation.

As far as I know, multiple devices could sit on the same chip select:
provided there was enough address decoding logic in or around the
devices, and that there existing bus timing parameters which would
work with all the devices on a chip select (or "bank" in the
terminology of the EBC bridge documentation).

Devices on different banks can certainly have the same address/offset
within the bank - e.g. on Ebony most of the devices are at offset 0.
The OPB address range for each bank is separately programmable in the
EBC bridge DCRs.

(Incidentally, this is why I created the binding in this way, rather
than just using the firmware established addresses in OPB space, which
are usually fixed for a particular board/platform.  This way provides
enough information that, if necessary, the kernel or another client
can reprogram the EBC from scratch to access the various devices
present.  Well.. actually fully reprogramming would also need the the
bus timing parameters, which I was thinking of adding information
before, but I haven't gotten to it yet.)

> >> "direct-mapped" is simply not a sufficiently specific compatible
> >> property, no two ways about it.
> >
> >     Yes, for example "direct-mapped-cfi" and "direct-mapped-jedec" 
> > would have
> > been better...
> 
> Nah.  These memory devices are meant to sit at some address/data
> bus; whether it is direct-mapped or not is obvious from the node
> hierarchy the flash node hangs under already; let's make the simple
> case simple and the complicated cases possible.
> 
> 
> Segher
> 
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
