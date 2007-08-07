Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070807040918.GD13522@localhost.localdomain>
References: <20070730150648.GA5005@ru.mvista.com>
	<20070801020836.GB31391@localhost.localdomain>
	<65ff446478a9fd0a48061079d5f04f8f@kernel.crashing.org>
	<20070801050422.GI31391@localhost.localdomain>
	<20070801054751.GM31391@localhost.localdomain>
	<46B1F6D4.3070707@ru.mvista.com>
	<20070803031349.GD6418@localhost.localdomain>
	<46B34E1F.5060009@ru.mvista.com>
	<f8e837f0c3f73a9b47d52be05f1d54cc@kernel.crashing.org>
	<20070807040918.GD13522@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2c959d4df36f91dd9ee900d415c836f9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/6] PowerPC 440EPx: Sequoia DTS
Date: Tue, 7 Aug 2007 18:58:20 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Most characters are allowed in the unit-address...  The following
>> is just fine: "my-secret-base@the-moon".  ISA uses letters to
>> distinguish between its different address spaces, for example.
>
> Yeah, I should probably make dtc a bit more flexible about accepting
> that, too.  At present, it only takes hex digits and ',', since those
> are the common character.

Sounds good.  And then the legacy ISA devices in existing
DTS files should be changed to say @i60 instead of @60, etc.
(@60 is correct since the default is legacy I/O space, but
it's good the be more verbose in those cases).

>> David, can multiple devices sit on the same chip-select
>> on EBC, or on the same "minor" address?  If not, you can
>> simplify your unit address representation.
>
> As far as I know, multiple devices could sit on the same chip select:
> provided there was enough address decoding logic in or around the
> devices, and that there existing bus timing parameters which would
> work with all the devices on a chip select (or "bank" in the
> terminology of the EBC bridge documentation).

Ah, that's what multiple banks are for!

> Devices on different banks can certainly have the same address/offset
> within the bank - e.g. on Ebony most of the devices are at offset 0.
> The OPB address range for each bank is separately programmable in the
> EBC bridge DCRs.

Okay, seems like the <bank,offset> representation is the simplest
possible, then.  Good.  <rubber stamp>

> (Incidentally, this is why I created the binding in this way, rather
> than just using the firmware established addresses in OPB space, which
> are usually fixed for a particular board/platform.  This way provides
> enough information that, if necessary, the kernel or another client
> can reprogram the EBC from scratch to access the various devices
> present.  Well.. actually fully reprogramming would also need the the
> bus timing parameters, which I was thinking of adding information
> before, but I haven't gotten to it yet.)

It gives a full "as simple as possible but no simpler" description
of the hardware, so it's just fine independent of whether you want
to reprogram the EBC or not.


Segher
