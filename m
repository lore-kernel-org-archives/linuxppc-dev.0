Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F78D1A0012
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 16:24:07 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Wed, 25 Jun 2014 11:54:00 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A277F394003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 11:53:55 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5P6OBlB8388898
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 11:54:11 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5P6Nst0027576
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jun 2014 11:53:54 +0530
Date: Wed, 25 Jun 2014 14:23:53 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] Bugfix: powerpc/eeh: Create eeh sysfs entry in post_init()
Message-ID: <20140625062353.GB15078@richard>
References: <1403667127-1622-1-git-send-email-qiudayu@linux.vnet.ibm.com>
 <20140625053312.GA3808@shangw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140625053312.GA3808@shangw>
Cc: linuxppc-dev@lists.ozlabs.org, weiyang@linux.vnet.ibm.com,
 Mike Qiu <qiudayu@linux.vnet.ibm.com>, kvm-ppc@vger.kernel.org
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 25, 2014 at 03:33:12PM +1000, Gavin Shan wrote:
>On Tue, Jun 24, 2014 at 11:32:07PM -0400, Mike Qiu wrote:
>
>[ cc Richard ]
>
>>Eeh sysfs entry created must be after EEH_ENABLED been set
>>in eeh_subsystem_flags.
>>
>>In PowerNV platform, it try to create sysfs entry before
>>EEH_ENABLED been set, when boot up. So nothing will be
>>created for eeh in sysfs.
>>
>
>Could you please make the commit log more clear? :-)
>
>I guess the issue is introduced by commit 2213fb1 ("
>powerpc/eeh: Skip eeh sysfs when eeh is disabled"). The
>commit checks EEH is enabled while creating PCI device
>EEH sysfs files. If not, the sysfs files won't be created.
>That's to avoid warning reported during PCI hotplug.
>
>The problem you're reporting (if I understand completely):
>You don't see the sysfs files after the system boots up.
>If it's the case, you probably need following changes in
>arch/powerpc/platforms/powernv/pci.c::pnv_pci_ioda_fixup().
>Could you have a try with it?
>
>#ifdef CONFIG_EEH
>	eeh_probe_mode_set(EEH_PROBE_MODE_DEV);
>-	eeh_addr_cache_build();
>	eeh_init();
>+	eeh_addr_cache_build();
>#endif
>

I think this is a more proper fix.

BTW, I have one confusion in this mode set.

eeh_init()
  -> eeh_ops->dev_probe()
     -> powernv_eeh_dev_probe()
        -> eeh_set_enable(true)   <- here the eeh is marked enabled

We can see this flag would be set for each pci_dev. So is it possible to make
this "set" only once?

>Eventually PowerNV/pSeries have same function call sequence:
>
>- Set EEH probe mode
>- Doing probe (with device node or PCI device)
>- Build address cache.
>
>>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>>---
>> arch/powerpc/platforms/powernv/eeh-ioda.c | 3 +++
>> 1 file changed, 3 insertions(+)
>>
>>diff --git a/arch/powerpc/platforms/powernv/eeh-ioda.c b/arch/powerpc/platforms/powernv/eeh-ioda.c
>>index 8ad0c5b..5f95581 100644
>>--- a/arch/powerpc/platforms/powernv/eeh-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/eeh-ioda.c
>>@@ -136,6 +136,9 @@ static int ioda_eeh_post_init(struct pci_controller *hose)
>> 	struct pnv_phb *phb = hose->private_data;
>> 	int ret;
>>
>>+	/* Creat sysfs after EEH_ENABLED been set */
>>+	eeh_add_sysfs_files(hose->bus);
>>+
>> 	/* Register OPAL event notifier */
>> 	if (!ioda_eeh_nb_init) {
>> 		ret = opal_notifier_register(&ioda_eeh_nb);
>
>Thanks,
>Gavin

-- 
Richard Yang
Help you, Help me
