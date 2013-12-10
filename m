Return-Path: <benh@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0D0C82C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 14:59:38 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Tue, 10 Dec 2013 13:59:37 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AC0642BB002D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 14:59:34 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBA3fFhm9175504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 14:41:15 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBA3xXlr023691
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 14:59:34 +1100
Message-ID: <1386647973.32037.57.camel@pasglop>
Subject: Re: [PATCH 1/9] PCI: Use dev_is_pci() to check whether it is pci
 device
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 10 Dec 2013 14:59:33 +1100
In-Reply-To: <20131210000154.GE4699@google.com>
References: <1386244373-35796-1-git-send-email-wangyijing@huawei.com>
 <20131210000154.GE4699@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 Hanjun Guo <guohanjun@huawei.com>, Yijing Wang <wangyijing@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-12-09 at 17:01 -0700, Bjorn Helgaas wrote:
> [+cc arch lists]
> 
> On Thu, Dec 05, 2013 at 07:52:53PM +0800, Yijing Wang wrote:
> > Use dev_is_pci() instead of directly compare
> > pci_bus_type to check whether it is pci device.
> > 
> > Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> 
> I applied all these to my pci/yijing-dev_is_pci branch for v3.14, thanks!
> 
> Browse them here: http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/yijing-dev_is_pci

Ah ok. I also have the powerpc one in powerpc -next, no biggie though

Cheers,
Ben.

> This should be no functional change.
> 
>  arch/alpha/kernel/pci_iommu.c        |    2 +-
>  arch/arm/common/it8152.c             |    4 ++--
>  arch/arm/mach-ixp4xx/common-pci.c    |    6 +++---
>  arch/ia64/hp/common/sba_iommu.c      |    2 +-
>  arch/ia64/sn/pci/pci_dma.c           |   24 ++++++++++++------------
>  arch/parisc/kernel/drivers.c         |   22 +++++-----------------
>  arch/powerpc/sysdev/fsl_pci.c        |    2 +-
>  arch/sparc/include/asm/dma-mapping.h |   10 ++++------
>  arch/sparc/kernel/iommu.c            |    2 +-
>  arch/sparc/kernel/ioport.c           |    4 +---
>  arch/x86/kernel/acpi/boot.c          |    4 +---
>  drivers/pci/pci-acpi.c               |    2 +-
>  12 files changed, 33 insertions(+), 51 deletions(-)
> 
> Bjorn
> 
> > ---
> >  drivers/pci/pci-acpi.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > index 577074e..e0431f1 100644
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -358,7 +358,7 @@ static void pci_acpi_cleanup(struct device *dev)
> >  
> >  static bool pci_acpi_bus_match(struct device *dev)
> >  {
> > -	return dev->bus == &pci_bus_type;
> > +	return dev_is_pci(dev);
> >  }
> >  
> >  static struct acpi_bus_type acpi_pci_bus = {
> > -- 
> > 1.7.1
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
