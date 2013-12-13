Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 14B432C009D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 Dec 2013 08:02:57 +1100 (EST)
Message-ID: <1386968550.10013.320.camel@snotra.buserror.net>
Subject: Re: [1/3] powerpc/vfio: Enable on POWERNV platform
From: Scott Wood <scottwood@freescale.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 13 Dec 2013 15:02:30 -0600
In-Reply-To: <52AA78AE.2050800@ozlabs.ru>
References: <1369107191-28547-2-git-send-email-aik@ozlabs.ru>
 <20131212233527.GA16929@home.buserror.net> <52AA78AE.2050800@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bharat Bhushan <bharat.bhushan@freescale.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, Varun Sethi <Varun.Sethi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-12-13 at 14:02 +1100, Alexey Kardashevskiy wrote:
> On 12/13/2013 10:35 AM, Scott Wood wrote:
> > On Tue, May 21, 2013 at 01:33:09PM +1000, Alexey Kardashevskiy wrote:
> >> +static int iommu_add_device(struct device *dev)
> >> +{
> >> +	struct iommu_table *tbl;
> >> +	int ret = 0;
> >> +
> >> +	if (WARN_ON(dev->iommu_group)) {
> >> +		pr_warn("iommu_tce: device %s is already in iommu group %d, skipping\n",
> >> +				dev_name(dev),
> >> +				iommu_group_id(dev->iommu_group));
> >> +		return -EBUSY;
> >> +	}
> > [snip]
> >> +static int __init tce_iommu_init(void)
> >> +{
> >> +	struct pci_dev *pdev = NULL;
> >> +
> >> +	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
> >> +
> >> +	for_each_pci_dev(pdev)
> >> +		iommu_add_device(&pdev->dev);
> >> +
> >> +	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> >> +	return 0;
> >> +}
> >> +
> >> +subsys_initcall_sync(tce_iommu_init);
> > 
> > This is missing a check to see whether the appropriate hardware is
> > present.  This file should also be renamed to something less generic, and
> > depend on a kconfig symbol more specific than CONFIG_PPC64.
> > 
> > When this is combined with CONFIG_FSL_PAMU on hardware with a PAMU, I get
> > a bunch of those "WARN_ON(dev->iommu_group)" dumps because PAMU already
> > got to them.  Presumably without PAMU it silently (or with just pr_debug)
> > bails out at some other point.
> 
> 
> I posted (yet again) yesterday "[PATCH v11] PPC: POWERNV: move
> iommu_add_device earlier" which should fix this. And Bharat asked many
> times for this to get accepted :)

I still get the WARN_ONs even with that patch.  You're still registering
the bus notifier unconditionally.

-Scott
