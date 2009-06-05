Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A58CBB70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 04:27:02 +1000 (EST)
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: linux-usb@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Arnd Bergmann <arnd@arndb.de>
Date: Fri, 05 Jun 2009 13:26:51 -0500
Message-Id: <20090605182651.24094.36577.sendpatchset@elm3a191.beaverton.ibm.com>
Subject: Re: [BUILD FAILURE 02/04] Next June 04:PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Roman Weissgaerber <weissg@vienna.at>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>,
	Subrata Modak <subrata@linux.vnet.ibm.com>, kernel@wantstofly.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>On Thu, 2009-06-04 at 10:07 -0400, Jon Smirl wrote:
>On Thu, Jun 4, 2009 at 9:31 AM, Subrata Modak
> <subrata@linux.vnet.ibm.com> wrote:
> > CC      drivers/usb/host/ohci-hcd.o
> > In file included from drivers/usb/host/ohci-hcd.c:1060:
> > drivers/usb/host/ohci-ppc-of.c:242:2: error: #error "No endianess selected for ppc-of-ohci"
> > make[3]: *** [drivers/usb/host/ohci-hcd.o] Error 1
> > make[2]: *** [drivers/usb/host] Error 2
> > make[1]: *** [drivers/usb] Error 2
> > make: *** [drivers] Error 2
> >
> > I reported this earlier, and there were some discussions:
> > http://groups.google.co.kr/group/linux.kernel/browse_thread/thread/edff9d5572d3d225
> 
> Proposed patch by Arnd should fix this. It has not been merged.
> http://lkml.org/lkml/2009/4/22/49

Correct, it fixes the issue. However, since few changes might have gone
to the Kconfig, the patch does not apply cleanly. Below is the patch, just
a retake of the earlier one, but on the latest code. 

David,

Can you please pickup the following patch ?

Signed-off-by: Arnd Bergmann <arnd@arndb.de>,
Resent-by: Subrata Modak <subrata@linux.vnet.ibm.com>
---

--- linux-2.6.30-rc8/drivers/usb/host/Kconfig.orig	2009-06-05 10:31:30.000000000 -0500
+++ linux-2.6.30-rc8/drivers/usb/host/Kconfig	2009-06-05 10:37:53.000000000 -0500
@@ -181,26 +181,26 @@ config USB_OHCI_HCD_PPC_SOC
 	  Enables support for the USB controller on the MPC52xx or
 	  STB03xxx processor chip.  If unsure, say Y.
 
-config USB_OHCI_HCD_PPC_OF
-	bool "OHCI support for PPC USB controller on OF platform bus"
-	depends on USB_OHCI_HCD && PPC_OF
-	default y
-	---help---
-	  Enables support for the USB controller PowerPC present on the
-	  OpenFirmware platform bus.
-
 config USB_OHCI_HCD_PPC_OF_BE
-	bool "Support big endian HC"
-	depends on USB_OHCI_HCD_PPC_OF
-	default y
+	bool "OHCI support for OF platform bus (big endian)"
+	depends on USB_OHCI_HCD && PPC_OF
 	select USB_OHCI_BIG_ENDIAN_DESC
 	select USB_OHCI_BIG_ENDIAN_MMIO
+	---help---
+	Enables support for big-endian USB controllers present on the
+	OpenFirmware platform bus.
 
 config USB_OHCI_HCD_PPC_OF_LE
-	bool "Support little endian HC"
-	depends on USB_OHCI_HCD_PPC_OF
-	default n
+	bool "OHCI support for OF platform bus (little endian)"
+	depends on USB_OHCI_HCD && PPC_OF
 	select USB_OHCI_LITTLE_ENDIAN
+	---help---
+	Enables support for little-endian USB controllers present on the
+	OpenFirmware platform bus.
+
+	config USB_OHCI_HCD_PPC_OF
+	bool
+	default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
 
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"

---
Regards--
Subrata
>
