Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 514D6DDDF9
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 03:29:03 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Dave Jiang <djiang@mvista.com>
Subject: Re: [PATCH 2/2] powerpc: MPC85xx EDAC device driver
Date: Mon, 30 Jul 2007 19:28:50 +0200
References: <20070726222225.GB10427@blade.az.mvista.com>
	<200707291606.21612.arnd@arndb.de> <46AE146D.8010504@mvista.com>
In-Reply-To: <46AE146D.8010504@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707301928.51253.arnd@arndb.de>
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

On Monday 30 July 2007, Dave Jiang wrote:
> Arnd Bergmann wrote:

> > I'd suggest either to integrate EDAC into the 85xx specific PCI code,
> > or to have an extra device in the device tree for this.
> 
> How about I create a platform device just for EDAC and leave the PCI of_device
> to the 85xx PCI code? That would be a lot less modification than adding a
> device for every PCI hose per DTS file.... Just a thought....

Hmm, I can see your point about not having to change all the device trees,
but if you really want to have a device for each of them, an of_device seems
more natural to me than a platform_device.

What about the other option I mentioned, handling the EDAC stuff from the
fsl_add_bridge() function?
 
> > The error handling could use some improvement here. In particular, you should
> > unregister the buses in the failure path, maybe you need to clean up other
> > parts as well.
> 
> I think I want individual "devices" work even some may fail or be missing. For
> example, even if L2 fails to register, I still want to be able to get the
> memory controller to report errors. So I really don't want to unregister
> everything that initialized properly even though some failures exists. Maybe I
> need to clean it up a little bit.

In that case, you shouldn't return failure from the module_init() function,
because that will remove the module again, while leaving the drivers
registered.

Another option might be to have separate modules, or separate initcall()
statements if the code can not be modular.

	Arnd <><
