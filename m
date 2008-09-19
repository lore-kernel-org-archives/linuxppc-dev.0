Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id E7DE6DDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Sep 2008 17:04:00 +1000 (EST)
Message-ID: <48D34F3D.6000302@coritel.it>
Date: Fri, 19 Sep 2008 09:05:33 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Abg Abg <abg.mur22@yahoo.com>
Subject: Re: Network driver on ppc 405EX
References: <371343.22518.qm@web59716.mail.ac4.yahoo.com>
In-Reply-To: <371343.22518.qm@web59716.mail.ac4.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Have you already enabled the device? You can enable it with
pci_enable_device. Then you can call the pci_request_region and then the
ioremap. In addition, you can check the pci configuration with the
command lspci. You can found an example on Linux Device Drivers.

Regards.

Abg Abg ha scritto:
> Hi, 
>   Hope this is the correct list for driver related queries for ppc boards
> 
> I was porting a network driver for a ppc 405EX based embedded system (kilauea config).
> The module builds fine and loads and I see the probe routine get called correctly.
> However when I try remapping the BAR0 address from the PCI config space, the ioremap fails.
> A little debugging showed that the address passed to ioremap was zero.
> I pass the address to the ioremap via pci_resource_start(pdev, 0) where pdev is a type struct pci_dev *.
> 
> I dumped the contents of the pdev and saw that the vendor-id, device id etc were correct, however the BAR0 address seemed to be all zeroes.
> 
> The question that I had was
> 1. Is there any kernel config that needs to be done for PCI devices to be able to remap the BAR0 addresses.
> 2. Any other kernel parameter that needs to be tweaked?
> 
> Thanks,
> Abg
> 
> 
>       
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
