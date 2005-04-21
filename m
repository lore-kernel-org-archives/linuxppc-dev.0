Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id 7407767A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 00:54:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 21 Apr 2005 09:54:06 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B859369@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Kumar Gala" <kumar.gala@freescale.com>,
	"Vitaly Bordug" <vbordug@ru.mvista.com>, "Wolfgang Denk" <wd@denx.de>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: RE: [PATCH 2.6.12-rc2] Freescale 8272ADS PCI bridge support to
	thestock linux-2.5 (updated)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20

> Not 100% sure.  Maybe Wolfgang or someone else know what the existing=20
> m8260 pci functionality is suppose to work with.  It seems=20
> odd that it=20
> did not have some of the bits you added for the 8272ads.  Its=20
> not clear=20
> to me if it actually worked on any systems or not.  Let see=20
> if Wolfgang=20
> has any insight as a first step.

The current one works on 8266/8265 based boards. It requires u-boot to
partiallyt set up PCI first.
I have a patch tat enables 8266ADS support, but have never posted it
(also because it has been superceded by PQ2ADS patches)

The missing pieces are the siumcr setup, which is done in U-Boot (almost
better to do it there as it is highly board dependant, and you would
have an afoul lot of #ifdefs to support all variants)

The other missing part is setup of the second outbound PCI wondow
(pcimask1/pcibr1). This is not used, bacqause the whole outbound window
is set up to be contiguous, and is covered by pcimsk0/pcibr0

I am running a slightly modified version of m8260_setup_pci on an
internal board port, and it works just fine.

Only change I'v had to do (to m8260_find bridges) is to add a bit on the
IORESOURCE_IO part, so that IO memory is detected correctly.

        pci_init_resource(&hose->io_resource,
			  MPC826x_PCI_LOWER_IO,
			  MPC826x_PCI_UPPER_IO,
			  IORESOURCE_IO | 1, "PCI I/O"); // the 1 added
so IO areas work. :FIXME: find real source
