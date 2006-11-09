Return-Path: <apw@shadowen.org>
Received: from hellhawk.shadowen.org (hellhawk.shadowen.org [80.68.90.175])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5621E67C5E
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Nov 2006 02:04:42 +1100 (EST)
Message-ID: <4553436D.30601@shadowen.org>
Date: Thu, 09 Nov 2006 15:04:13 +0000
From: Andy Whitcroft <apw@shadowen.org>
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Nicolas DET <nd@bplan-gmbh.de>
Subject: Re: 2.6.19-rc5-mm1 -- ppc64 ohci-hdc.c compile failure
References: <20061108015452.a2bb40d2.akpm@osdl.org>
In-Reply-To: <20061108015452.a2bb40d2.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steve Fox <drfickle@us.ibm.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are seeing compile failures on ppc64 in ohci-hcd.c as below:

In file included from drivers/usb/host/ohci-hcd.c:949:
drivers/usb/host/ohci-ppc-of.c: In function `ohci_hcd_ppc_of_init':
drivers/usb/host/ohci-ppc-of.c:272: warning: int format, different type
arg (arg 2)
drivers/usb/host/ohci-ppc-of.c:272: warning: int format, different type
arg (arg 3)
drivers/usb/host/ohci-ppc-of.c: At top level:
drivers/usb/host/ohci-ppc-of.c:282: error: redefinition of `__inittest'
drivers/usb/host/ohci-pci.c:252: error: `__inittest' previously defined here
drivers/usb/host/ohci-ppc-of.c:282: error: redefinition of `init_module'
drivers/usb/host/ohci-pci.c:252: error: `init_module' previously defined
here
drivers/usb/host/ohci-ppc-of.c:283: error: redefinition of `__exittest'
drivers/usb/host/ohci-pci.c:260: error: `__exittest' previously defined here
drivers/usb/host/ohci-ppc-of.c:283: error: redefinition of `cleanup_module'
drivers/usb/host/ohci-pci.c:260: error: `cleanup_module' previously
defined here

Seems that the patch below has introduced USB_OHCI_HCD_PPC_OF enabled by
default.  When it and CONFIG_USB_OHCI_HCD_PPC_SOC are enabled which
occured by default on my config then we end up with two module_init()
calls, which is illegal.

  powerpc-add-of_platform-support-for-ohci-bigendian-hc

I am guessing that we are only meant to be able to have one of these
defined at a time?  I changed the default to n for this and I could at
least compile the kernel, but I am sure thats not the right fix.

Nicolas?

-apw
