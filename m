Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 7D0ABDDE30
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 05:25:50 +1000 (EST)
Message-ID: <46AE3C06.5060100@mvista.com>
Date: Mon, 30 Jul 2007 12:29:10 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707301928.51253.arnd@arndb.de> <46AE2487.7060103@mvista.com>
	<200707302046.10010.arnd@arndb.de>
In-Reply-To: <200707302046.10010.arnd@arndb.de>
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
>>> What about the other option I mentioned, handling the EDAC stuff from the
>>> fsl_add_bridge() function?
>> I'm not sure I follow your thought on this quite yet. Do you mean the setup of
>> either of_device or platform_device or do you mean the actual pci err driver?
>> I'm not understanding how doing the setup code in fsl_add_bridge() would allow
>> us to prevent the of_device being monopolized by the EDAC driver or the future
>> PCI code.... The EDAC driver still needs some sort of "device" to claim one way
>> or another right?
> 
> What I meant is calling the edac_pci_alloc_ctl_info() function directly
> from fsl_add_bridge() where appropriate, with all the 85xx PCI EDAC
> code moved into fsl_pci.c.

I don't believe that EDAC core has been loaded at the time of 85xx PCI
initialization. Plus, the EDAC driver can be loaded as a kernel module. So that
probably won't work.... Also, instead of having centralized EDAC chip driver,
now you have things scattered over various places. One probably needs to add
83xx and 86xx code as well and whatever else eventually.

Maybe we are just better off adding entries in the DTS to get around this
problem....

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
