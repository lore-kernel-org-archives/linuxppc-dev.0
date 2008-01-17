Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 95288DDE27
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 10:18:44 +1100 (EST)
Message-ID: <478FE248.1030101@freescale.com>
Date: Thu, 17 Jan 2008 17:18:32 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Problems with PCI on 8280
References: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D4@ismail.innsys.innovsys.com>
	<478FD066.5000803@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B039BA0D6@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B039BA0D6@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
>  >From: Scott Wood
>  >Are you using cuImage, or a regular uImage with a device-tree-aware u-boot
> 
> cuImage for now.
> 
>  >If the former, try commenting out the call to fixup_pci() in
>  >arch/powerpc/boot/cuboot-pq2.c and let me know if that changes anything.
> 
> Did that, That made our PCI bus fail completely

Hmm...  that suggests that something in u-boot's setup is either 
incorrect, or (more likely in this case) doesn't match the device tree.

Or maybe it's the bus parking/arbiter tweaking at the end that u-boot is 
missing.

> We have our PCI set up to ONE 512MB outbound range doing all three.
> (I can see where you'd save on mem usage by doing two)
> 
> I do see a bug tho.
> In our case prefetch is 256MB, memio is 128MB.
> the calculation for outbound wiondow 1 sets the size to ~(pref+mmio-1). 
> That only works if the resulting size is a power of 2.

Ah.  Yes, I was assuming both windows would be the same size.  The code 
should be changed to check that, and if any conditions for setting 
PCIBRx/PCIMSKx fail, check to see if the firmware-provided values work 
(and if not, bail without touching anything).

> If we comment out the rewrite of the outbound windows, we get PCI to work.
> But since our u-boot sets everything up correctly (Including prefecable 
> memory) we should not need this? or is it rewriting the device tree in 
> some way?

You shouldn't need it...  I'd compare the register values u-boot sets 
with the values the corrected fixup_pci() sets (including the soc regs 
at the end).  Something must be different.

There is no device tree re-writing; it tries to program the hardware to 
match what's in the device tree.

-Scott
