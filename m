Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.protection.outlook.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DB592C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Dec 2013 10:35:43 +1100 (EST)
Date: Thu, 12 Dec 2013 17:35:27 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [1/3] powerpc/vfio: Enable on POWERNV platform
Message-ID: <20131212233527.GA16929@home.buserror.net>
References: <1369107191-28547-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1369107191-28547-2-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Tue, May 21, 2013 at 01:33:09PM +1000, Alexey Kardashevskiy wrote:
> +static int iommu_add_device(struct device *dev)
> +{
> +	struct iommu_table *tbl;
> +	int ret = 0;
> +
> +	if (WARN_ON(dev->iommu_group)) {
> +		pr_warn("iommu_tce: device %s is already in iommu group %d, skipping\n",
> +				dev_name(dev),
> +				iommu_group_id(dev->iommu_group));
> +		return -EBUSY;
> +	}
[snip]
> +static int __init tce_iommu_init(void)
> +{
> +	struct pci_dev *pdev = NULL;
> +
> +	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
> +
> +	for_each_pci_dev(pdev)
> +		iommu_add_device(&pdev->dev);
> +
> +	bus_register_notifier(&pci_bus_type, &tce_iommu_bus_nb);
> +	return 0;
> +}
> +
> +subsys_initcall_sync(tce_iommu_init);

This is missing a check to see whether the appropriate hardware is
present.  This file should also be renamed to something less generic, and
depend on a kconfig symbol more specific than CONFIG_PPC64.

When this is combined with CONFIG_FSL_PAMU on hardware with a PAMU, I get
a bunch of those "WARN_ON(dev->iommu_group)" dumps because PAMU already
got to them.  Presumably without PAMU it silently (or with just pr_debug)
bails out at some other point.

-Scott
