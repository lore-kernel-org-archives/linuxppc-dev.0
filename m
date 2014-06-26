Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CCB501A0008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 10:12:11 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Jun 2014 10:12:09 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A0BE12CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 10:12:05 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5PNnkuF11206982
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 09:49:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5Q0C4nA018900
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jun 2014 10:12:05 +1000
Date: Thu, 26 Jun 2014 10:12:04 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Create eeh sysfs entry in post_init()
Message-ID: <20140626001204.GA6787@shangw>
References: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140625053312.GA3808@shangw>
 <53AA79FB.5000202@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
In-Reply-To: <53AA79FB.5000202@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 25, 2014 at 03:27:55PM +0800, Mike Qiu wrote:
>On 06/25/2014 01:33 PM, Gavin Shan wrote:
>>On Tue, Jun 24, 2014 at 11:32:07PM -0400, Mike Qiu wrote:
>>
>>[ cc Richard ]
>>
>>>Eeh sysfs entry created must be after EEH_ENABLED been set
>>>in eeh_subsystem_flags.
>>>
>>>In PowerNV platform, it try to create sysfs entry before
>>>EEH_ENABLED been set, when boot up. So nothing will be
>>>created for eeh in sysfs.
>>>
>>Could you please make the commit log more clear? :-)
>>
>>I guess the issue is introduced by commit 2213fb1 ("
>>powerpc/eeh: Skip eeh sysfs when eeh is disabled"). The
>>commit checks EEH is enabled while creating PCI device
>>EEH sysfs files. If not, the sysfs files won't be created.
>>That's to avoid warning reported during PCI hotplug.
>>
>>The problem you're reporting (if I understand completely):
>>You don't see the sysfs files after the system boots up.
>>If it's the case, you probably need following changes in
>>arch/powerpc/platforms/powernv/pci.c::pnv_pci_ioda_fixup().
>>Could you have a try with it?
>>
>>#ifdef CONFIG_EEH
>>	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
>>-	eeh_addr_cache_build();
>>	eeh_init();
>>+	eeh_addr_cache_build();
>>#endif
>
>But this was not work, as I test, see boot log below:
>

Yeah, we can't convert eeh_dev to pci_dev that time. The
association is populated by eeh_addr_cache_build(). The
attached patch should fix your issue. I tried on P7 machine
and sysfs entries created. Could you help having a test
on your machine? :-)

Thanks,
Gavin

--+QahgC5+KEYLbs62
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-powerpc-eeh-sysfs-entries-lost.patch"

>From 70b8ac1d64192954e04bc4a4f2736349d7df6a8a Mon Sep 17 00:00:00 2001
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
Date: Thu, 26 Jun 2014 09:50:25 +1000
Subject: [PATCH] powerpc/eeh: sysfs entries lost

The sysfs entries are lost because of commit 2213fb1 ("powerpc/eeh:
Skip eeh sysfs when eeh is disabled"). That commit added condition
to create sysfs entries with EEH_ENABLED, which isn't populated
when trying to create sysfs entries on PowerNV platform during system
boot time. The patch fixes the issue by:

   * Reoder EEH initialization functions so that they're same on
     PowerNV/pSeries.
   * Cache PE's primary bus by PowerNV platform instead of EEH core
     to avoid kernel crash caused by the function reorder. Another
     benefit with this is to avoid one eeh_probe_mode_dev() in EEH
     core.

Reported-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c                 | 11 -----------
 arch/powerpc/platforms/powernv/eeh-powernv.c | 17 ++++++++++++++++-
 arch/powerpc/platforms/powernv/pci-ioda.c    |  2 +-
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fbd01eb..1dce071a 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -351,17 +351,6 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
 	pe->config_addr	= edev->config_addr;
 
 	/*
-	 * While doing PE reset, we probably hot-reset the
-	 * upstream bridge. However, the PCI devices including
-	 * the associated EEH devices might be removed when EEH
-	 * core is doing recovery. So that won't safe to retrieve
-	 * the bridge through downstream EEH device. We have to
-	 * trace the parent PCI bus, then the upstream bridge.
-	 */
-	if (eeh_probe_mode_dev())
-		pe->bus = eeh_dev_to_pci_dev(edev)->bus;
-
-	/*
 	 * Put the new EEH PE into hierarchy tree. If the parent
 	 * can't be found, the newly created PE will be attached
 	 * to PHB directly. Otherwise, we have to associate the
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 56a206f..48eb223 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -107,6 +107,7 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	struct pnv_phb *phb = hose->private_data;
 	struct device_node *dn = pci_device_to_OF_node(dev);
 	struct eeh_dev *edev = of_node_to_eeh_dev(dn);
+	int ret;
 
 	/*
 	 * When probing the root bridge, which doesn't have any
@@ -143,7 +144,21 @@ static int powernv_eeh_dev_probe(struct pci_dev *dev, void *flag)
 	edev->pe_config_addr	= phb->bdfn_to_pe(phb, dev->bus, dev->devfn & 0xff);
 
 	/* Create PE */
-	eeh_add_to_parent_pe(edev);
+	ret = eeh_add_to_parent_pe(edev);
+	if (ret) {
+		pr_warn("%s: Can't add PCI dev %s to parent PE (%d)\n",
+			__func__, pci_name(dev), ret);
+		return ret;
+	}
+
+	/*
+	 * Cache the PE primary bus, which can't be fetched when
+	 * full hotplug is in progress. In that case, all child
+	 * PCI devices of the PE are expected to be removed prior
+	 * to PE reset.
+	 */
+	if (!edev->pe->bus)
+		edev->pe->bus = dev->bus;
 
 	/*
 	 * Enable EEH explicitly so that we will do EEH check
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index de19ede..81f2d3a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1142,8 +1142,8 @@ static void pnv_pci_ioda_fixup(void)
 
 #ifdef CONFIG_EEH
 	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
-	eeh_addr_cache_build();
 	eeh_init();
+	eeh_addr_cache_build();
 #endif
 }
 
-- 
1.8.3.2


--+QahgC5+KEYLbs62--
