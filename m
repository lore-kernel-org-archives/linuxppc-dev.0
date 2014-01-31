Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B793A2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 11:46:23 +1100 (EST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Thu, 30 Jan 2014 17:46:20 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 436A91FF001B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 17:46:16 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0V0jx8E1769826
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 01:45:59 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0V0kFve001833
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 17:46:15 -0700
Date: Fri, 31 Jan 2014 08:46:11 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: drop taken reference to driver on
 eeh_rmv_device
Message-ID: <20140131004611.GA6790@shangw.(null)>
References: <1391086848-11311-1-git-send-email-cascardo@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391086848-11311-1-git-send-email-cascardo@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, shangw@linux.vnet.ibm.com, paulus@samba.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 30, 2014 at 11:00:48AM -0200, Thadeu Lima de Souza Cascardo wrote:
>Commit f5c57710dd62dd06f176934a8b4b8accbf00f9f8 ("powerpc/eeh: Use
>partial hotplug for EEH unaware drivers") introduces eeh_rmv_device,
>which may grab a reference to a driver, but not release it.
>
>That prevents a driver from being removed after it has gone through EEH
>recovery.
>
>This patch drops the reference in either exit path if it was taken.
>
>Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
>---
> arch/powerpc/kernel/eeh_driver.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>index 7bb30dc..afe7337 100644
>--- a/arch/powerpc/kernel/eeh_driver.c
>+++ b/arch/powerpc/kernel/eeh_driver.c
>@@ -364,7 +364,7 @@ static void *eeh_rmv_device(void *data, void *userdata)
> 		return NULL;
> 	driver = eeh_pcid_get(dev);
> 	if (driver && driver->err_handler)
>-		return NULL;
>+		goto out;
>
> 	/* Remove it from PCI subsystem */
> 	pr_debug("EEH: Removing %s without EEH sensitive driver\n",
>@@ -377,6 +377,9 @@ static void *eeh_rmv_device(void *data, void *userdata)

For normal case (driver without EEH support), we probably release the reference
to the driver before pci_stop_and_remove_bus_device().

> 	pci_stop_and_remove_bus_device(dev);
> 	pci_unlock_rescan_remove();
>
>+out:
>+	if (driver)
>+		eeh_pcid_put(dev);
> 	return NULL;

We needn't "if (driver)" here as eeh_pcid_put() already had the check.

> }
>

Thanks,
Gavin
