Message-ID: <3A1321C7.CAC069A0@mvista.com>
Date: Wed, 15 Nov 2000 18:52:39 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: ajay.kunnath@exgate.tek.com
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Local-PCI bridge mapping
References: <21F9768AF088D211BF1C0008C71E5786014EED18@ap-bang-m02.india.tek.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
