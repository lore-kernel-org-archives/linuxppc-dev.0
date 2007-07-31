Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 77DACDDDE9
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 06:45:41 +1000 (EST)
Message-ID: <46AFA040.7070303@mvista.com>
Date: Tue, 31 Jul 2007 13:49:04 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
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
>> I don't believe that EDAC core has been loaded at the time of 85xx PCI
>> initialization. Plus, the EDAC driver can be loaded as a kernel module. So that
>> probably won't work....
> 
> ok, good point.
> 
>> Also, instead of having centralized EDAC chip driver, 
>> now you have things scattered over various places. One probably needs to add
>> 83xx and 86xx code as well and whatever else eventually.
>>
>> Maybe we are just better off adding entries in the DTS to get around this
>> problem....
> 
> The best solution may be to look at how it's structured at the
> register level. If the PCI EDAC registers are implemented separately
> from the regular PCI registers, a device tree entry would be appropriate.
> If not, your idea of registering a platform_device from fsl_add_bridge
> is probably more sensible.

Actually it seems that for me to grab the interrupt number I have to do the
platform device creation in fsl_soc.c and call arch_init() instead of doing it
from fsl_add_bridge(). fsl_add_bridge() is called way too early and the mpic
interrupt mapping has not been setup yet for me to acquire the interrupt number
from of_interrupt_to_resource() call.

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
