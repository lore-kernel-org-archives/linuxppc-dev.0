Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1983A67B6D
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 17:07:48 +1100 (EST)
In-Reply-To: <457F8EC3.60201@freescale.com>
References: <20061208190758.6cee088f.kim.phillips@freescale.com>	<1165648490.1103.117.camel@localhost.localdomain>	<91EF8E0D-06BC-47FD-89E6-6350430946F9@kernel.crashing.org>	<20061211155155.26868ca6.kim.phillips@freescale.com>	<A1A95A77-B86C-41CF-87DC-58CD63843CE3@kernel.crashing.org>	<20061211201055.21031c9b.kim.phillips@freescale.com>	<1165890570.11914.5.camel@localhost.localdomain>	<457F1F6E.4020502@freescale.com>	<1165960058.11914.72.camel@localhost.localdomain>	<7152860A-27A3-4C08-B6A5-DFA57A63ACED@kernel.crashing.org>	<20061212162416.06f0dd76.kim.phillips@freescale.com>	<A2576248-6DF4-44BE-99D2-0D8477865B17@kernel.crashing.org>	<457F2FE1.1080308@freescale.com>
	<513E2628-5785-4100-9E83-986990E06DF5@kernel.crashing.org>
	<457F8EC3.60201@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <2B135C85-9FF6-435E-975B-D0D3E7ACFF5B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: consolidate mpc83xx platform files
Date: Wed, 13 Dec 2006 00:07:43 -0600
To: Geoff Thorpe <Geoff.Thorpe@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 12, 2006, at 11:25 PM, Geoff Thorpe wrote:

> Kumar Gala wrote:
>
>> It adds code to all those people that don't need it just so we =20
>> don't  duplicate a few lines of source code.
>>
>
> Sounds like you're describing the raison d'=EAtre for device-trees =20
> though? After all, if you want to build a kernel that supports =20
> these minor h/w variations depending on the device-tree it's booted =20=

> with, then the "few lines of duplicated source code" you're talking =20=

> about would also "add code to all those people that don't need it".

No, because those people (myself included) wouldn't build in support =20
for the freescale referend boards into the kernel I'm building for my =20=

custom board.

My question has been what's the value in trying to save a few lines =20
of code for the reference boards.  The idea of a generic board =20
doesn't make sense in the embedded space.  Just because the reference =20=

boards for mpc83xx look similar doesn't mean anything else using it =20
will.  I know both of the boards I've worked would and still do =20
require custom code.

The reason for the custom code is the device tree doesn't describe =20
all variants of all hardware.  Its just not spec'd that far. How do =20
you describe the FPGA and local bus interface to it on my board? How =20
do you describe the compact flash drive on localbus?  How do you =20
describe the microcontroller connect over SPI?  You dont because =20
there isn't any spec.  The majority of developers dont have the time =20
to spend trying to come up with one to solve their specific problem =20
so they hard code some solution that works for them.

Over time will we improve the spec, it will cover more cases and =20
that's great, but trying to come up with some generic board port =20
right now is a waste of time.  There are a ton of better things to be =20=

spending your guys time on.

I've yet to see anything that describes any real value to a customer.

> Kumar Gala also wrote:
>
>> On Dec 12, 2006, at 4:41 PM, Scott Wood wrote:
>>
>>> And an 83xx-generic machine description does not stop them from  =20
>>> doing so.  "Generic" does not mean "universal".  It means =20
>>> "there's  nothing special about this board".  If you need board-=20
>>> specific code  in the kernel, then don't label it generic.
>>>
>>
>> But what value does this have?  83xx, and the majority of =20
>> freescale's  devices are not put into something as standard as a =20
>> desktop computer.
>
> Then what value do device-trees have at all? Why require new code =20
> for new h/w if it's technically unnecessary? If I've understood =20
> correctly (I confess to not having followed all of the discussion =20
> nor the finer technical points), this would require new code to =20
> find its way "upstream" (to whoever/wherever/whatever that means) =20
> from freescale and then downstream to it's user before the h/w is =20
> supported, when this situation is precisely what device-trees =20
> apparently ought to resolve.

This is partial true, but if freescale puts out a new processor/board =20=

there is some expectation that its going to require some new code.  =20
If nothing else it's going to require a device-tree be provided.  If =20
the concern is about how long it takes to support new HW for existing =20=

functionality I think that's BS.

> Maybe I'm missing something (quite possible). Ben's objection =20
> seemed to be one of naming, but yours seems to be that new h/w =20
> should require new code because it's not wintel fodder for desktop =20
> grannies? So why bother separating h/w description from the =20
> compiled kernel in the first place?

My argument is that trying to describe all HW variants for embedded =20
systems in the device tree is never going to happen.  Describing the =20
generality of devices on SoC is useful because everyone has to deal =20
with that.  Once you start going past that you get into trouble =20
because of all the various ways people hook things up to busses.

There are a number of subtle reasons I think a generic port is =20
pointless and the only arguments I've heard are some concern about =20
duplication of code and the ability to boot a kernel w/o modification =20=

on new HW.

The duplication code I believe is a style issue and we can reduce the =20=

duplication to a minimum.  The ability to boot a kernel w/o =20
modification on new HW is a nice to have, but I dont see this as =20
providing any "real value".

I'd rather see people spending time on problems which need solutions =20
and this isn't one of them.

- k=
