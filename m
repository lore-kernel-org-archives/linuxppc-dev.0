Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id 2A7A267A6F
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Feb 2005 23:23:27 +1100 (EST)
Message-ID: <5982.195.212.29.67.1109074991.squirrel@195.212.29.67>
In-Reply-To: <421B1F12.7050601@gmx.de>
References: <20041206185416.GE7153@smtp.west.cox.net>
	<Pine.SOC.4.61.0502221031230.6097@math.ut.ee>
	<421B1F12.7050601@gmx.de>
Date: Tue, 22 Feb 2005 12:23:11 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Sebastian Heutling" <sheutlin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: Tom Rini <trini@kernel.crashing.org>, Christian Kujau <evil@g-house.de>,
	Meelis Roos <mroos@linux.ee>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, Sven Hartge <hartge@ds9.gnuu.de>
Subject: Re: [PATCH 2.6.10-rc3][PPC32] Fix Motorola PReP (PowerstackII
 Utah) PCI IRQ map
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sebastian Heutling said:
> Meelis Roos wrote:
>
>>> The PCI IRQ map for the old Motorola PowerStackII (Utah) boards was
>>> incorrect, but this breakage wasn't exposed until 2.5, and finally
>>> fixed
>>> until recently by Sebastian Heutling <sheutlin@gmx.de>.
>>
>>
>> Yesterday I finally got around to testing it. It seems the patch has
>> been applied in Linus's tree so I downloaded the latest BK and tried it.
>>
>> Still does not work for me but this time it's different. Before the
>> patch SCSI worked fine but PCI NICs caused hangs. Now I can't test PCI
>> NICs because even the onboard 53c825 SCSI hangs - seems it gets no
>> interrupts.
>>
>> It detects the HBA, tries device discovery, gets a timeout, ABORT,
>> timeout, TARGET RESET, timeout, BUS RESET, timeout, HOST RESET and
>> there it hangs.
>>
>> Does it work for anyone else on Powerstack II Pro4000 (Utah)?
>>
> It does work in 2.6.8 using backported patches (e.g. the debian 2.6.8
> kernel). But it doesn't work above that version because of other patches
> in arch/ppc/platforms/prep_pci.c and arch/ppc/platforms/prep_setup.c
> (made by Tom Rini?). I couldn't find out what exactly is causing this
> problem yet (because lack of time and the fact that my Powerstack is
> used as a router).

Ah, this could well be my fault.  Those patches were to improve support
of IBM RS/6000 PReP boxes.  Do those machines have residual data?  If
so, could anyone who has one send me the contents of /proc/residual?

Also, a full boot log when working and failing would be cool.
