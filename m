Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 81CCBDDE26
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 08:20:41 +1000 (EST)
Message-ID: <46AFB686.40508@mvista.com>
Date: Tue, 31 Jul 2007 15:24:06 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707302158.16530.arnd@arndb.de> <46AFA040.7070303@mvista.com>
	<200708010007.12922.arnd@arndb.de>
In-Reply-To: <200708010007.12922.arnd@arndb.de>
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
> On Tuesday 31 July 2007, Dave Jiang wrote:
>> Actually it seems that for me to grab the interrupt number I have to do the
>> platform device creation in fsl_soc.c and call arch_init() instead of doing it
>> from fsl_add_bridge(). fsl_add_bridge() is called way too early and the mpic
>> interrupt mapping has not been setup yet for me to acquire the interrupt number
>> from of_interrupt_to_resource() call.
> 
> I think in general, it would be a better solution to have the add_bridge
> code called much later, like we do with the 64 bit PCI code when
> using an of_device for the PCI bridge. I don't think it's easy to
> do though, so that shouldn't stop you from doing it the other way.
> 
> Please make the platform_device a child of the PCI host bridge though,
> so it doesn't need to change if/when the PCI initialization gets changed
> to allow doing it from fsl_pci.
> 

Doh! I sent out the reworked patches right before your comments. Do you happen
to know where I can find an example of how to do this? In regards to making a
platform_device a child of the PCI host bridge that is.... Thanks!

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
