Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1633C2C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 13:04:11 +1100 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Mon, 3 Feb 2014 19:04:08 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 1FA533E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Feb 2014 19:04:06 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1423gjY5243356
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 03:03:47 +0100
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1423juN031421
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Feb 2014 19:03:45 -0700
Date: Tue, 4 Feb 2014 10:03:24 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: drop taken reference to driver on
 eeh_rmv_device
Message-ID: <20140204020324.GA16311@shangw.(null)>
References: <1391086848-11311-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <20140131004611.GA6790@shangw.(null)>
 <20140131172458.GA2039@oc0268524204.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140131172458.GA2039@oc0268524204.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <shangw@linux.vnet.ibm.com>,
 paulus@samba.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 31, 2014 at 03:24:58PM -0200, Thadeu Lima de Souza Cascardo wrote:
>On Fri, Jan 31, 2014 at 08:46:11AM +0800, Gavin Shan wrote:
>> On Thu, Jan 30, 2014 at 11:00:48AM -0200, Thadeu Lima de Souza Cascardo wrote:
>> >Commit f5c57710dd62dd06f176934a8b4b8accbf00f9f8 ("powerpc/eeh: Use
>> >partial hotplug for EEH unaware drivers") introduces eeh_rmv_device,
>> >which may grab a reference to a driver, but not release it.
>> >
>> >That prevents a driver from being removed after it has gone through EEH
>> >recovery.
>> >
>> >This patch drops the reference in either exit path if it was taken.
>> >
>> >Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
>> >---
>> > arch/powerpc/kernel/eeh_driver.c |    5 ++++-
>> > 1 files changed, 4 insertions(+), 1 deletions(-)
>> >
>> >diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> >index 7bb30dc..afe7337 100644
>> >--- a/arch/powerpc/kernel/eeh_driver.c
>> >+++ b/arch/powerpc/kernel/eeh_driver.c
>> >@@ -364,7 +364,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
>> > 		return NULL;
>> > 	driver = eeh_pcid_get(dev);
>> > 	if (driver && driver->err_handler)
>> >-		return NULL;
>> >+		goto out;
>> >
>> > 	/* Remove it from PCI subsystem */
>> > 	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
>> >@@ -377,6 +377,9 @@ static void *eeh_rmv_device(void *data, void *userdata)
>> 
>> For normal case (driver without EEH support), we probably release the reference
>> to the driver before pci_stop_and_remove_bus_device().
>
>You are right, we need to call it before we call
>pci_stop_and_remove_bus_device, otherwise dev->driver will be NULL, and
>eeh_pcid_put will not do module_put. On the other hand, we could change
>the call to eeh_pcid_put to accept struct pci_driver instead.
>
>> 
>> > 	pci_stop_and_remove_bus_device(dev);
>> > 	pci_unlock_rescan_remove();
>> >
>> >+out:
>> >+	if (driver)
>> >+		eeh_pcid_put(dev);
>> > 	return NULL;
>> 
>> We needn't "if (driver)" here as eeh_pcid_put() already had the check.
>> 
>
>What if try_module_get returned false on eeh_pcid_get?
>
>How about something like the patch below?
>
>> > }
>> >
>> 
>> Thanks,
>> Gavin
>---
>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>index 7bb30dc..3a397fa 100644
>--- a/arch/powerpc/kernel/eeh_driver.c
>+++ b/arch/powerpc/kernel/eeh_driver.c
>@@ -352,6 +352,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
> 	struct eeh_dev *edev = (struct eeh_dev *)data;
> 	struct pci_dev *dev = eeh_dev_to_pci_dev(edev);
> 	int *removed = (int *)userdata;
>+	bool has_err_handler;
>
> 	/*
> 	 * Actually, we should remove the PCI bridges as well.
>@@ -362,8 +363,12 @@ static void *eeh_rmv_device(void *data, void *userdata)
> 	 */
> 	if (!dev || (dev->hdr_type & PCI_HEADER_TYPE_BRIDGE))
> 		return NULL;
>+
> 	driver = eeh_pcid_get(dev);
>-	if (driver && driver->err_handler)
>+	has_err_handler = driver && driver->err_handler;
>+	if (driver)
>+		eeh_pcid_put(dev);
>+	if (has_err_handler)
> 		return NULL;
>
> 	/* Remove it from PCI subsystem */

It looks good to me. Could you please send v2 with:

Acked-by: Gavin Shan <shangw@linux.vnet.ibm.com>

Or we can simply do like this. It depends your preference :-)

	if (driver) {
		eeh_pcid_put(dev);
		if (driver->err_handler)
			return NULL;
	}

Thanks,
Gavin
