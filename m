Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 045F62C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 09:09:33 +1000 (EST)
Message-ID: <1372547360.18612.76.camel@pasglop>
Subject: Re: [PATCH] powerpc/pci: Avoid overriding MSI interrupt
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Date: Sun, 30 Jun 2013 09:09:20 +1000
In-Reply-To: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Yuanquan.Chen@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-06-28 at 21:10 +0800, Gavin Shan wrote:
> The issue was introduced by commit 37f02195 ("powerpc/pci: fix
> PCI-e devices rescan issue on powerpc platform"). The field
> (struct pci_dev::irq) is reused by PCI core to trace the base
> MSI interrupt number if the MSI stuff is enabled on the corresponding
> device. When running to pcibios_setup_device(), we possibly still
> have enabled MSI interrupt on the device. That means "pci_dev->irq"
> still have the base MSI interrupt number and it will be overwritten
> if we're going fix "pci_dev->irq" again by pci_read_irq_line().
> Eventually, when we enable the device, it runs to kernel crash caused
> by fetching the the MSI interrupt descriptor (struct msi_desc) from
> non-MSI interrupt and using the NULL descriptor.

So finally I decided instead to apply Guenter patch

[PATCH v2] powerpc/pci: Improve device hotplug initialization

Which fixes the underlying problem instead.

I'm running some tests, so far it looks good. However, Gavin, when you
have a chance on vpl3, try injecting errors to other adapters, for
example the VGA adapter (you need to do lspci to trigger the EEH
detection after that since there's no driver and use the "loc code"
variant off errinjct) or eth2 (the cxgb3).

All I get from EEH with these is:

[  362.962564] EEH: Detected PCI bus error on PHB#7-PE#10000
[  362.962570] eeh_handle_event: Cannot find PCI bus for PHB#7-PE#10000

and

[  424.381083] EEH: Detected PCI bus error on PHB#6-PE#10000
[  424.381089] eeh_handle_event: Cannot find PCI bus for PHB#6-PE#10000

Followed by ... nothing.

This is a tree which has Cascardo patch and Gunther patch (usual
location on vpl3).

Can you have a look ?

Cheers,
Ben.
