Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 35FCEDDECB
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 06:14:20 +1000 (EST)
Message-ID: <46AE4764.7020101@mvista.com>
Date: Mon, 30 Jul 2007 13:17:40 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, galak@kernel.crashing.org
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707302046.10010.arnd@arndb.de> <46AE3C06.5060100@mvista.com>
	<200707302158.16530.arnd@arndb.de>
In-Reply-To: <200707302158.16530.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	norsk5@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Monday 30 July 2007, Dave Jiang wrote:
>> Maybe we are just better off adding entries in the DTS to get around this
>> problem....
> 
> The best solution may be to look at how it's structured at the
> register level. If the PCI EDAC registers are implemented separately
> from the regular PCI registers, a device tree entry would be appropriate.
> If not, your idea of registering a platform_device from fsl_add_bridge
> is probably more sensible.
> 

We can probably do either. From looking at the 8560 and 8548 manuals, the PCI
error registers are 0xe00 offset of the start of PCI registers. For example,
the PCI registers would start at 0x8000 offset. And the PCI error registers
would be at 0xe00 offset from there and would be the very last block of
registers. Currently the PCI dts devices seem to claim 0x1000 for size. So the
way to have the least code changes would be to register a platform_device from
fsl_add_bridge() or where appropriate for the 85xx PCI code. Most likely the
83xx and 86xx will have similar code and maybe we can do some reuse out of this.

I can add dts entries instead and pick up of_devices if Kumar prefers it that
way instead....

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
