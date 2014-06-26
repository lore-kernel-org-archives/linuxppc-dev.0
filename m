Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59AF81A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 17:15:28 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Jun 2014 17:15:27 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3583F2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 17:15:25 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5Q6r5tW50266198
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 16:53:06 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q7FOlP008893
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 17:15:24 +1000
Date: Thu, 26 Jun 2014 17:15:24 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: sysfs entries lost
Message-ID: <20140626071524.GA6587@shangw>
References: <1403765927-8638-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403765927-8638-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2014 at 02:58:47AM -0400, Mike Qiu wrote:
>The sysfs entries are lost because of commit 2213fb1 ("powerpc/eeh:
>Skip eeh sysfs when eeh is disabled"). That commit added condition
>to create sysfs entries with EEH_ENABLED, which isn't populated
>when trying to create sysfs entries on PowerNV platform during system
>boot time. The patch fixes the issue by:
>
>   * Reoder EEH initialization functions so that they're same on
>     PowerNV/pSeries.
>   * Cache PE's primary bus by PowerNV platform instead of EEH core
>     to avoid kernel crash caused by the function reorder. Another
>     benefit with this is to avoid one eeh_probe_mode_dev() in EEH
>     core.
>
>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>

Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Thanks,
Gavin

>---
> arch/powerpc/kernel/eeh_pe.c                 | 11 -----------
> arch/powerpc/platforms/powernv/eeh-powernv.c | 17 ++++++++++++++++-
> arch/powerpc/platforms/powernv/pci-ioda.c    |  2 +-
> 3 files changed, 17 insertions(+), 13 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index fbd01eb..1dce071a 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -351,17 +351,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
> 	pe->config_addr	= edev->config_addr;
>
> 	/*
>-	 * While doing PE reset, we probably hot-reset the
>-	 * upstream bridge. However, the PCI devices including
>-	 * the associated EEH devices might be removed when EEH
>-	 * core is doing recovery. So that won't safe to retrieve
>-	 * the bridge through downstream EEH device. We have to
>-	 * trace the parent PCI bus, then the upstream bridge.
>-	 */
>-	if (eeh_probe_mode_dev())
>-		pe->bus = eeh_dev_to_pci_dev(edev)->bus;
>-
>-	/*
> 	 * Put the new EEH PE into hierarchy tree. If the parent
> 	 * can't be found, the newly created PE will be attached
> 	 * to PHB directly. Otherwise, we have to associate the
>diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
>index 56a206f..48eb223 100644
>--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
>+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
>@@ -107,6 +107,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
> 	struct pnv_phb *phb = hose->private_data;
> 	struct device_node *dn = pci_device_to_OF_node(dev);
> 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
>+	int ret;
>
> 	/*
> 	 * When probing the root bridge, which doesn't have any
>@@ -143,7 +144,21 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
> 	edev->pe_config_addr	= phb->bdfn_to_pe(phb, dev->bus, dev->devfn & 0xff);
>
> 	/* Create PE */
>-	eeh_add_to_parent_pe(edev);
>+	ret = eeh_add_to_parent_pe(edev);
>+	if (ret) {
>+		pr_warn("%s: Can't add PCI dev %s to parent PE (%d)\n",
>+			__func__, pci_name(dev), ret);
>+		return ret;
>+	}
>+
>+	/*
>+	 * Cache the PE primary bus, which can't be fetched when
>+	 * full hotplug is in progress. In that case, all child
>+	 * PCI devices of the PE are expected to be removed prior
>+	 * to PE reset.
>+	 */
>+	if (!edev->pe->bus)
>+		edev->pe->bus = dev->bus;
>
> 	/*
> 	 * Enable EEH explicitly so that we will do EEH check
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index de19ede..81f2d3a 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -1142,8 +1142,8 @@ static void pnv_pci_ioda_fixup(void)
>
> #ifdef CONFIG_EEH
> 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
>-	eeh_addr_cache_build();
> 	eeh_init();
>+	eeh_addr_cache_build();
> #endif
> }
>
>-- 
>1.8.1.4
>
