Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4390E1A000E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:33:17 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 15:33:16 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BB25E2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:33:14 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P5Wwfq51118146
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:32:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P5XEU9002266
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 15:33:14 +1000
Date: Wed, 25 Jun 2014 15:33:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Create eeh sysfs entry in post_init()
Message-ID: <20140625053312.GA3808@shangw>
References: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: weiyang@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 24, 2014 at 11:32:07PM -0400, Mike Qiu wrote:

[ cc Richard ]

>Eeh sysfs entry created must be after EEH_ENABLED been set
>in eeh_subsystem_flags.
>
>In PowerNV platform, it try to create sysfs entry before
>EEH_ENABLED been set, when boot up. So nothing will be
>created for eeh in sysfs.
>

Could you please make the commit log more clear? :-)

I guess the issue is introduced by commit 2213fb1 ("
powerpc/eeh: Skip eeh sysfs when eeh is disabled"). The
commit checks EEH is enabled while creating PCI device
EEH sysfs files. If not, the sysfs files won't be created.
That's to avoid warning reported during PCI hotplug.

The problem you're reporting (if I understand completely):
You don't see the sysfs files after the system boots up.
If it's the case, you probably need following changes in
arch/powerpc/platforms/powernv/pci.c::pnv_pci_ioda_fixup().
Could you have a try with it?

#ifdef CONFIG_EEH
	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
-	eeh_addr_cache_build();
	eeh_init();
+	eeh_addr_cache_build();
#endif

Eventually PowerNV/pSeries have same function call sequence:

- Set EEH probe mode
- Doing probe (with device node or PCI device)
- Build address cache.
 
>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>---
> arch/powerpc/platforms/powernv/eeh-ioda.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>index 8ad0c5b..5f95581 100644
>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>@@ -136,6 +136,9 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
> 	struct pnv_phb *phb = hose->private_data;
> 	int ret;
>
>+	/* Creat sysfs after EEH_ENABLED been set */
>+	eeh_add_sysfs_files(hose->bus);
>+
> 	/* Register OPAL event notifier */
> 	if (!ioda_eeh_nb_init) {
> 		ret = opal_notifier_register(&ioda_eeh_nb);

Thanks,
Gavin
