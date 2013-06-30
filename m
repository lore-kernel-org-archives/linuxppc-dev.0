Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205]) by ozlabs.org (Postfix) with ESMTP id 9D1ED2C02B1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jun 2013 11:29:25 +1000 (EST)
Date: Sat, 29 Jun 2013 18:29:20 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/pci: Avoid overriding MSI interrupt
Message-ID: <20130630012920.GA2673@roeck-us.net>
References: <1372425030-5759-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1372547360.18612.76.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1372547360.18612.76.camel@pasglop>
Cc: Yuanquan.Chen@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 30, 2013 at 09:09:20AM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2013-06-28 at 21:10 +0800, Gavin Shan wrote:
> > The issue was introduced by commit 37f02195 ("powerpc/pci: fix
> > PCI-e devices rescan issue on powerpc platform"). The field
> > (struct pci_dev::irq) is reused by PCI core to trace the base
> > MSI interrupt number if the MSI stuff is enabled on the corresponding
> > device. When running to pcibios_setup_device(), we possibly still
> > have enabled MSI interrupt on the device. That means "pci_dev->irq"
> > still have the base MSI interrupt number and it will be overwritten
> > if we're going fix "pci_dev->irq" again by pci_read_irq_line().
> > Eventually, when we enable the device, it runs to kernel crash caused
> > by fetching the the MSI interrupt descriptor (struct msi_desc) from
> > non-MSI interrupt and using the NULL descriptor.
> 
> So finally I decided instead to apply Guenter patch
> 
> [PATCH v2] powerpc/pci: Improve device hotplug initialization
> 
> Which fixes the underlying problem instead.
> 

Guess I am not hitting above bug because I have my own patch applied ;).

Thanks a lot!

Guenter
