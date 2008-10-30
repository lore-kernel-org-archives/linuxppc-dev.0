Return-Path: <neko@genesi-usa.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.170])
	by ozlabs.org (Postfix) with ESMTP id 50D28DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 04:53:22 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so814579wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 10:53:21 -0700 (PDT)
Message-ID: <4909F492.3080401@genesi-usa.com>
Date: Thu, 30 Oct 2008 12:53:22 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: PowerPC USB controller support - ohci-ppc-of.c and ohci-ppc-soc.c
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi guys,

I'm curious as to the difference between ohci-ppc-of.c and
ohci-ppc-soc.c in drivers/usb/host - the way I am looking at
this, ohci-ppc-soc.c is completely redundant now as no
arch/powerpc platform should be using this method of registering
a platform device, and therefore it's a legacy from arch/ppc
that should go away like CONFIG_PPC_MERGE did?

Can anyone confirm this?

I also noticed a very strange Kconfig dependency when checking
through this stuff with Grant (so I could see what to remove if
I got rid of ohci-ppc-soc.c, the config for USB_OHCI_HCD_PPC_SOC
would disappear;

config USB_OHCI_HCD_PCI
          bool "OHCI support for PCI-bus USB controllers"
          depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx || USB_OHCI_HCD_PPC_OF)
          default y
          select USB_OHCI_LITTLE_ENDIAN
          ---help---
            Enables support for PCI-bus plug-in USB controller cards.
            If unsure, say Y.

I am really curious as to why OHCI for PCI bus depends on STB03xxx
or MPC52xx? Couldn't these be removed? I am guessing USB_OHCI_HCD_PPC_OF
is specifically required here because it sets up the support from the
device tree if it's present (although aren't PCI devices detected and
utilized some other way? Is this a concession to having internal AND
PCI controllers of the same type?) but I do not understand the
dependency on those two chips, specifically, in this day and age.

I'll roll up a patch along with a couple other things tomorrow or the
weekend based on what I hear here..

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
