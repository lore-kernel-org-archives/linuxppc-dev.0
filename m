Return-Path: <leitao@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e24smtp05.br.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BBF10B7D42
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Feb 2010 04:46:35 +1100 (EST)
Received: from mailhub1.br.ibm.com (mailhub1.br.ibm.com [9.18.232.109])
	by e24smtp05.br.ibm.com (8.14.3/8.13.1) with ESMTP id o12HZNr1007829
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 15:35:23 -0200
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
	by mailhub1.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o12Hmwd4446852
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 15:48:58 -0200
Received: from d24av05.br.ibm.com (loopback [127.0.0.1])
	by d24av05.br.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o12HkSB0016047
	for <linuxppc-dev@ozlabs.org>; Tue, 2 Feb 2010 15:46:29 -0200
Message-ID: <4B6864F4.1030106@linux.vnet.ibm.com>
Date: Tue, 02 Feb 2010 15:46:28 -0200
From: Breno Leitao <leitao@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] eeh: Fixing a bug when pci structure is null
References: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
In-Reply-To: <1264789719-15591-1-git-send-email-leitao@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linas Vepstas <linasvepstas@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 During a EEH recover, the pci_dev structure can be null, mainly if an
 eeh event is detected during cpi config operation. In this case, the
 pci_dev will not be known (and will be null) and the kernel will crash
 with the following message:
 
 Unable to handle kernel paging request for data at address 0x000000a0
 Faulting instruction address: 0xc00000000006b8b4
 Oops: Kernel access of bad area, sig: 11 [#1]
 
 NIP [c00000000006b8b4] .eeh_event_handler+0x10c/0x1a0
 LR [c00000000006b8a8] .eeh_event_handler+0x100/0x1a0
 Call Trace:
 [c0000003a80dff00] [c00000000006b8a8] .eeh_event_handler+0x100/0x1a0
 [c0000003a80dff90] [c000000000031f1c] .kernel_thread+0x54/0x70
 
 The bug occurs because pci_name() tries to access a null pointer.
 This patch just guarantee that pci_name() is not called on Null pointers.
 
 Signed-off-by: Breno Leitao <leitao@linux.vnet.ibm.com>
 Signed-off-by: Linas Vepstas <linasvepstas@gmail.com>
 ---
  arch/powerpc/include/asm/ppc-pci.h          |    7 +++++++
  arch/powerpc/platforms/pseries/eeh.c        |    4 ++--
  arch/powerpc/platforms/pseries/eeh_driver.c |    4 ++--
  arch/powerpc/platforms/pseries/eeh_event.c  |    2 +-
  4 files changed, 12 insertions(+), 5 deletions(-)
 
 diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
 index 2828f9d..724dbe2 100644
 --- a/arch/powerpc/include/asm/ppc-pci.h
 +++ b/arch/powerpc/include/asm/ppc-pci.h
 @@ -137,6 +137,13 @@ struct device_node * find_device_pe(struct device_node *dn);
  void eeh_sysfs_add_device(struct pci_dev *pdev);
  void eeh_sysfs_remove_device(struct pci_dev *pdev);
 
 +static inline const char *eeh_pci_name(struct pci_dev *pdev) 
 +{ 
 +	if (NULL==pdev) 
 +		return "<null>"; 
 +	return pci_name(pdev); 
 +} 
 +
  #endif /* CONFIG_EEH */
 
  #else /* CONFIG_PCI */
 diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
 index ccd8dd0..f9360fe 100644
 --- a/arch/powerpc/platforms/pseries/eeh.c
 +++ b/arch/powerpc/platforms/pseries/eeh.c
 @@ -491,7 +491,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
  	    pdn->eeh_mode & EEH_MODE_NOCHECK) {
  		ignored_check++;
  		pr_debug("EEH: Ignored check (%x) for %s %s\n",
 -			 pdn->eeh_mode, pci_name (dev), dn->full_name);
 +			 pdn->eeh_mode, eeh_pci_name (dev), dn->full_name);
  		return 0;
  	}
 
 @@ -515,7 +515,7 @@ int eeh_dn_check_failure(struct device_node *dn, struct pci_dev *dev)
  			printk (KERN_ERR "EEH: %d reads ignored for recovering device at "
  				"location=%s driver=%s pci addr=%s\n",
  				pdn->eeh_check_count, location,
 -				dev->driver->name, pci_name(dev));
 +				dev->driver->name, eeh_pci_name(dev));
  			printk (KERN_ERR "EEH: Might be infinite loop in %s driver\n",
  				dev->driver->name);
  			dump_stack();
 diff --git a/arch/powerpc/platforms/pseries/eeh_driver.c b/arch/powerpc/platforms/pseries/eeh_driver.c
 index ef8e454..8f948a0 100644
 --- a/arch/powerpc/platforms/pseries/eeh_driver.c
 +++ b/arch/powerpc/platforms/pseries/eeh_driver.c
 @@ -337,7 +337,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
  		location = location ? location : "unknown";
  		printk(KERN_ERR "EEH: Error: Cannot find partition endpoint "
  		                "for location=%s pci addr=%s\n",
 -		        location, pci_name(event->dev));
 +		        location, eeh_pci_name(event->dev));
  		return NULL;
  	}
 
 @@ -368,7 +368,7 @@ struct pci_dn * handle_eeh_events (struct eeh_event *event)
  		pci_str = pci_name (frozen_pdn->pcidev);
  		drv_str = pcid_name (frozen_pdn->pcidev);
  	} else {
 -		pci_str = pci_name (event->dev);
 +		pci_str = eeh_pci_name (event->dev);
  		drv_str = pcid_name (event->dev);
  	}
  	
 diff --git a/arch/powerpc/platforms/pseries/eeh_event.c b/arch/powerpc/platforms/pseries/eeh_event.c
 index ddb80f5..ec5df8f 100644
 --- a/arch/powerpc/platforms/pseries/eeh_event.c
 +++ b/arch/powerpc/platforms/pseries/eeh_event.c
 @@ -80,7 +80,7 @@ static int eeh_event_handler(void * dummy)
  	eeh_mark_slot(event->dn, EEH_MODE_RECOVERING);
 
  	printk(KERN_INFO "EEH: Detected PCI bus error on device %s\n",
 -	       pci_name(event->dev));
 +	       eeh_pci_name(event->dev));
 
  	pdn = handle_eeh_events(event);
