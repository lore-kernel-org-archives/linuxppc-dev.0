Return-Path: <sr@denx.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id 4575567B2A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 18:48:16 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Yosemite/440EP 'issues' as a PCI target
Date: Fri, 10 Feb 2006 08:47:53 +0100
References: <20060209003459.0ED30352564@atlas.denx.de>
	<43EBD715.4020303@ovro.caltech.edu>
In-Reply-To: <43EBD715.4020303@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200602100847.54363.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi David,

On Friday 10 February 2006 00:58, David Hawkins wrote:
> Now what if the host wants to interrupt the 440EP.
> Errr, there is no register defined for this purpose.
> The UIC chapter, p220-222 v1.18 manual indicates
> all the interrupt bits. Sure there are a couple of
> PCI source interrupts, one for writes to the PCI
> configuration-space command register (so can't really
> use that),

You could use it but I wouldn't recommend it.

> and another for power-management events. 
>
> Have I missed something?

No. This sounds pretty much like the 405GP(r) which also lacks this 
host-to-target interrupt facility.

> I'll have an FPGA/CPLD on the external bus, so I guess
> I can implement a mailbox/doorbell register in that
> and then have that register trigger an external interrupt
> on the 440EP. The 440EP PCI target BARs will then need
> to be setup to decode to the EBC decode range.
> Sounds like a hack ... (even more of a hack is to
> loop back a GPIO onto an EXTINT and setup the target
> decode to cover the GPIO registers, and the x86 can
> toggle a GPIO directly).

Yes, those are the choices available. If the CPU doesn't offer such features 
directly, I wouldn't even call those solutions a "hack". ;-)

> Of course if I have a few unused peripherals I might
> be able to cause them to generate an interrupt. But
> that gets tricky since in a lot of cases, as device
> interrupts are often controlled via DCRs.

I wouldn't go this way.

Best regards,
Stefan
