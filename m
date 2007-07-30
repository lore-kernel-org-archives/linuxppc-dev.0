Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id A4B65DDE08
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 03:45:36 +1000 (EST)
Message-ID: <46AE2487.7060103@mvista.com>
Date: Mon, 30 Jul 2007 10:48:55 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707291606.21612.arnd@arndb.de> <46AE146D.8010504@mvista.com>
	<200707301928.51253.arnd@arndb.de>
In-Reply-To: <200707301928.51253.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, norsk5@yahoo.com,
	bluesmoke-devel@lists.sourceforge.net
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
>> Arnd Bergmann wrote:
> 
>>> I'd suggest either to integrate EDAC into the 85xx specific PCI code,
>>> or to have an extra device in the device tree for this.
>> How about I create a platform device just for EDAC and leave the PCI of_device
>> to the 85xx PCI code? That would be a lot less modification than adding a
>> device for every PCI hose per DTS file.... Just a thought....
> 
> Hmm, I can see your point about not having to change all the device trees,
> but if you really want to have a device for each of them, an of_device seems
> more natural to me than a platform_device.
> 
> What about the other option I mentioned, handling the EDAC stuff from the
> fsl_add_bridge() function?

I'm not sure I follow your thought on this quite yet. Do you mean the setup of
either of_device or platform_device or do you mean the actual pci err driver?
I'm not understanding how doing the setup code in fsl_add_bridge() would allow
us to prevent the of_device being monopolized by the EDAC driver or the future
PCI code.... The EDAC driver still needs some sort of "device" to claim one way
or another right?

Of course I can go ahead and add the PCI err device in the DTS files for all
85xx if Kumar is okay with that idea....

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
