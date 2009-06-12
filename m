Return-Path: <subrata@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B604BB71D6
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 19:36:00 +1000 (EST)
Subject: Re: [BUILD FAILURE 02/04] Next June 04:PPC64 randconfig
	[drivers/usb/host/ohci-hcd.o]
From: Subrata Modak <subrata@linux.vnet.ibm.com>
To: David Brownell <david-b@pacbell.net>
In-Reply-To: <200906091738.58154.david-b@pacbell.net>
References: <20090605182651.24094.36577.sendpatchset@elm3a191.beaverton.ibm.com>
	<200906091738.58154.david-b@pacbell.net>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 15:05:48 +0530
Message-Id: <1244799348.5234.13.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>,
	Randy Dunlap <randy.dunlap@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>, linux-usb@vger.kernel.org,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Linux-Next <linux-next@vger.kernel.org>, kernel@wantstofly.org
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-06-09 at 17:38 -0700, David Brownell wrote:
> On Friday 05 June 2009, Subrata Modak wrote:
> > Correct, it fixes the issue. However, since few changes might have gone
> > to the Kconfig, the patch does not apply cleanly. Below is the patch, just
> > a retake of the earlier one, but on the latest code. 
> 
> And it got mangled a bit along the way.  Plus, the original one
> goofed up Kconfig dependency displays ... both issues fixed in
> this version, against current mainline GIT.
> 
> If someone can verify all four PPC/OF/OHCI configs build on
> on PPC64, I'm OK with it.
> 
> - Dave

Dave,

Sorry for being late. The patch fixes the issue on the latest git for
PPC64. Infact, the whole drivers/usb/host/ builds just fine:

linux-2.6 # make drivers/usb/host/
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  SYMLINK include/asm -> include/asm-powerpc
  CALL    scripts/checksyscalls.sh
  CC      drivers/usb/host/ohci-hcd.o
  CC      drivers/usb/host/pci-quirks.o
  CC      drivers/usb/host/uhci-hcd.o
  LD      drivers/usb/host/built-in.o
  CC [M]  drivers/usb/host/isp116x-hcd.o
  CC [M]  drivers/usb/host/u132-hcd.o

You can check in the patch now.

Regards--
Subrata

> 
> 
> ========== CUT HERE
> From: Arnd Bergmann <arnd@arndb.de>
> Subject: fix build failure for PPC64 randconfig [usb/ohci]
> 
> We could just make the USB_OHCI_HCD_PPC_OF option implicit
> and selected only if at least one of USB_OHCI_HCD_PPC_OF_BE
> and USB_OHCI_HCD_PPC_OF_LE are set.
> 
> [ dbrownell@users.sourceforge.net: fix patch manglation and dependencies ]
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Resent-by: Subrata Modak <subrata@linux.vnet.ibm.com>
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  drivers/usb/host/Kconfig |   29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -180,26 +180,27 @@ config USB_OHCI_HCD_PPC_SOC
>  	  Enables support for the USB controller on the MPC52xx or
>  	  STB03xxx processor chip.  If unsure, say Y.
> 
> -config USB_OHCI_HCD_PPC_OF
> -	bool "OHCI support for PPC USB controller on OF platform bus"
> -	depends on USB_OHCI_HCD && PPC_OF
> -	default y
> -	---help---
> -	  Enables support for the USB controller PowerPC present on the
> -	  OpenFirmware platform bus.
> -
>  config USB_OHCI_HCD_PPC_OF_BE
> -	bool "Support big endian HC"
> -	depends on USB_OHCI_HCD_PPC_OF
> -	default y
> +	bool "OHCI support for OF platform bus (big endian)"
> +	depends on USB_OHCI_HCD && PPC_OF
>  	select USB_OHCI_BIG_ENDIAN_DESC
>  	select USB_OHCI_BIG_ENDIAN_MMIO
> +	---help---
> +	  Enables support for big-endian USB controllers present on the
> +	  OpenFirmware platform bus.
> 
>  config USB_OHCI_HCD_PPC_OF_LE
> -	bool "Support little endian HC"
> -	depends on USB_OHCI_HCD_PPC_OF
> -	default n
> +	bool "OHCI support for OF platform bus (little endian)"
> +	depends on USB_OHCI_HCD && PPC_OF
>  	select USB_OHCI_LITTLE_ENDIAN
> +	---help---
> +	  Enables support for little-endian USB controllers present on the
> +	  OpenFirmware platform bus.
> +
> +config USB_OHCI_HCD_PPC_OF
> +	bool
> +	depends on USB_OHCI_HCD && PPC_OF
> +	default USB_OHCI_HCD_PPC_OF_BE || USB_OHCI_HCD_PPC_OF_LE
> 
>  config USB_OHCI_HCD_PCI
>  	bool "OHCI support for PCI-bus USB controllers"
> 
