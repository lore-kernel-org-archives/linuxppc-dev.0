Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E84E02C0089
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Feb 2014 04:25:12 +1100 (EST)
Received: from /spool/local
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Fri, 31 Jan 2014 15:25:04 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 054373520064
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 12:24:59 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay03.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0VHOPhR36897010
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 15:24:26 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0VHOxdv007521
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 15:24:59 -0200
Date: Fri, 31 Jan 2014 15:24:58 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: Gavin Shan <shangw@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: drop taken reference to driver on
 eeh_rmv_device
Message-ID: <20140131172458.GA2039@oc0268524204.ibm.com>
References: <1391086848-11311-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <20140131004611.GA6790@shangw.(null)>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140131004611.GA6790@shangw.(null)>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 31, 2014 at 08:46:11AM +0800, Gavin Shan wrote:
> On Thu, Jan 30, 2014 at 11:00:48AM -0200, Thadeu Lima de Souza Cascardo wrote:
> >Commit f5c57710dd62dd06f176934a8b4b8accbf00f9f8 ("powerpc/eeh: Use
> >partial hotplug for EEH unaware drivers") introduces eeh_rmv_device,
> >which may grab a reference to a driver, but not release it.
> >
> >That prevents a driver from being removed after it has gone through EEH
> >recovery.
> >
> >This patch drops the reference in either exit path if it was taken.
> >
> >Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> >---
> > arch/powerpc/kernel/eeh_driver.c |    5 ++++-
> > 1 files changed, 4 insertions(+), 1 deletions(-)
> >
> >diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
> >index 7bb30dc..afe7337 100644
> >--- a/arch/powerpc/kernel/eeh_driver.c
> >+++ b/arch/powerpc/kernel/eeh_driver.c
> >@@ -364,7 +364,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
> > 		return NULL;
> > 	driver = eeh_pcid_get(dev);
> > 	if (driver && driver->err_handler)
> >-		return NULL;
> >+		goto out;
> >
> > 	/* Remove it from PCI subsystem */
> > 	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
> >@@ -377,6 +377,9 @@ static void *eeh_rmv_device(void *data, void *userdata)
> 
> For normal case (driver without EEH support), we probably release the reference
> to the driver before pci_stop_and_remove_bus_device().

You are right, we need to call it before we call
pci_stop_and_remove_bus_device, otherwise dev->driver will be NULL, and
eeh_pcid_put will not do module_put. On the other hand, we could change
the call to eeh_pcid_put to accept struct pci_driver instead.

> 
> > 	pci_stop_and_remove_bus_device(dev);
> > 	pci_unlock_rescan_remove();
> >
> >+out:
> >+	if (driver)
> >+		eeh_pcid_put(dev);
> > 	return NULL;
> 
> We needn't "if (driver)" here as eeh_pcid_put() already had the check.
> 

What if try_module_get returned false on eeh_pcid_get?

How about something like the patch below?

> > }
> >
> 
> Thanks,
> Gavin
---
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 7bb30dc..3a397fa 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -352,6 +352,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	struct eeh_dev *edev = (struct eeh_dev *)data;
 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
 	int *removed = (int *)userdata;
+	bool has_err_handler;
 
 	/*
 	 * Actually, we should remove the PCI bridges as well.
@@ -362,8 +363,12 @@ static void *eeh_rmv_device(void *data, void *userdata)
 	 */
 	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
 		return NULL;
+
 	driver = eeh_pcid_get(dev);
-	if (driver && driver->err_handler)
+	has_err_handler = driver && driver->err_handler;
+	if (driver)
+		eeh_pcid_put(dev);
+	if (has_err_handler)
 		return NULL;
 
 	/* Remove it from PCI subsystem */
---
