From: ajay.kunnath@exgate.tek.com
Message-ID: <21F9768AF088D211BF1C0008C71E5786014EED4B@ap-bang-m02.india.tek.com>
To: dan@mvista.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Local-PCI bridge mapping
Date: Wed, 15 Nov 2000 22:24:26 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Dan,

I have written the config read/write functions similar to the ones in
qspan_pci.c for plx.

> Depending upon what you mean by "map", most PCI bridges rely on
> well known physical (bus) address or/and chip selects to function
> properly, just like other devices attached to the processor.

You are correct in that the PLX has a chip select which results in
the its configuration registers being available. "Map" was clearly
the wrong word to use. :-)

The PLX requires a chip select for its internal registers, but does
not require one for the PCI image . The PLX9054 decodes all address
lines on the local bus and generates its own chip select.

The PLX uses address of the memory region used for "I/O" mapped devices
for PCI configuration cycles.

Thanks for the help.

-Ajay


-----Original Message-----
From: Dan Malek [mailto:dan@mvista.com]
Sent: Thursday, November 16, 2000 5:23 AM
To: Kunnath, Ajay
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Local-PCI bridge mapping


ajay.kunnath@exgate.tek.com wrote:

> I have a proprietary MPC860 board which has a PLX 9054 Local-PCI
> bridge. I am running the 2.4.0 version of the kernel from
> montavista.

The PLX isn't supported as a PCI bridge in the 8xx kernel......
The 2.4.0 version of the kernel isn't supported in the CDK for
the 8xx either....If anything works you are just lucky.

> My problem is that I am not able to map the configuration registers
> to any other address but 0x80000000.

What do you mean "map"?  You use ioremap()?  When?

> .... When I map it to 0x80000000, it
> works great, any other address and it just crashes.

Depending upon what you mean by "map", most PCI bridges rely on
well known physical (bus) address or/and chip selects to function
properly, just like other devices attached to the processor.

Tell us how the PLX decodes the configuration space access as a
target, how your system has attached the PLX to the processor,
and we can probably help.  You are going to have to minimally write
a set of functions like those found in qspan_pci.c to accomodate
the PLX.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
