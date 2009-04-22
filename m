Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [BUILD FAILURE 11/12] Next April 21 : PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
Date: Wed, 22 Apr 2009 09:30:00 +0200
References: <1240340081.9110.144.camel@subratamodak.linux.ibm.com>
	<200904211919.38104.david-b@pacbell.net>
	<49EE8855.1080306@oracle.com>
In-Reply-To: <49EE8855.1080306@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200904220930.01735.arnd@arndb.de>
Cc: sachinp <sachinp@linux.vnet.ibm.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>, samr <sam@ravnborg.org>,
	linux-usb@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	David Brownell <david-b@pacbell.net>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	linux-next <linux-next@vger.kernel.org>, subrata@linux.vnet.ibm.com,
	Alexander Beregalov <a.beregalov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 22 April 2009, Randy Dunlap wrote:
> > Is there maybe a way to force Kconfig to just reject
> > such illegal configs -- neither option set -- rather
> > than trying some how to fix it?
>=20
> Not that I know of. =A0cc-ing Sam.

We could just make the USB_OHCI_HCD_PPC_OF option implicit
and selected only if at least one of USB_OHCI_HCD_PPC_OF_BE
and USB_OHCI_HCD_PPC_OF_LE are set.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 845479f..07e3e25 100644
=2D-- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -161,26 +161,26 @@ config USB_OHCI_HCD_PPC_SOC
 	  Enables support for the USB controller on the MPC52xx or
 	  STB03xxx processor chip.  If unsure, say Y.
=20
=2Dconfig USB_OHCI_HCD_PPC_OF
=2D	bool "OHCI support for PPC USB controller on OF platform bus"
=2D	depends on USB_OHCI_HCD && PPC_OF
=2D	default y
=2D	---help---
=2D	  Enables support for the USB controller PowerPC present on the
=2D	  OpenFirmware platform bus.
=2D
 config USB_OHCI_HCD_PPC_OF_BE
=2D	bool "Support big endian HC"
=2D	depends on USB_OHCI_HCD_PPC_OF
=2D	default y
+	bool "OHCI support for OF platform bus (big endian)"
+	depends on USB_OHCI_HCD && PPC_OF
 	select USB_OHCI_BIG_ENDIAN_DESC
 	select USB_OHCI_BIG_ENDIAN_MMIO
+	---help---
+	  Enables support for big-endian USB controllers present on the
+	  OpenFirmware platform bus.
=20
 config USB_OHCI_HCD_PPC_OF_LE
=2D	bool "Support little endian HC"
=2D	depends on USB_OHCI_HCD_PPC_OF
=2D	default n
+	bool "OHCI support for OF platform bus (little endian)"
+	depends on USB_OHCI_HCD && PPC_OF
 	select USB_OHCI_LITTLE_ENDIAN
+	---help---
+	  Enables support for little-endian USB controllers present on the
+	  OpenFirmware platform bus.
+
+config USB_OHCI_HCD_PPC_OF
+	bool
+	default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
=20
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"
