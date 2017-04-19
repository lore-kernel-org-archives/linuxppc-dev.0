Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7dyD5v5FzDqCf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:49:24 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3JNmeQS039101
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 19:49:19 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29wqpwfmne-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 19:49:19 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 20 Apr 2017 09:49:17 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3JNn7Aq43581640
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:49:15 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3JNmhNF030074
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 09:48:43 +1000
Date: Thu, 20 Apr 2017 09:48:18 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, aik@ozlabs.ru
Subject: Re: [PATCH v3 2/2] powerpc/eeh: Clean up and document event handling
 functions
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170419073927.29224-1-ruscur@russell.cc>
 <20170419073927.29224-2-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170419073927.29224-2-ruscur@russell.cc>
Message-Id: <20170419234818.GA7528@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 19, 2017 at 05:39:27PM +1000, Russell Currey wrote:
>Remove unnecessary tags in eeh_handle_normal_event(), and add function
>comments for eeh_handle_normal_event() and eeh_handle_special_event().
>
>The only functional difference is that in the case of a PE reaching the
>maximum number of failures, rather than one message telling you of this
>and suggesting you reseat the device, there are two separate messages.
>
>Suggested-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---
>V3: new.  Thanks to Alexey for the suggestions.
>---
> arch/powerpc/kernel/eeh_driver.c | 36 ++++++++++++++++++++++++------------
> 1 file changed, 24 insertions(+), 12 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>index e50d1470714f..c405c79e50cd 100644
>--- a/arch/powerpc/kernel/eeh_driver.c
>+++ b/arch/powerpc/kernel/eeh_driver.c
>@@ -724,6 +724,15 @@ static int eeh_reset_device(struct eeh_pe *pe, struct pci_bus *bus,
>  */
> #define MAX_WAIT_FOR_RECOVERY 300
>
>+/**
>+ * eeh_handle_normal_event - Handle EEH events on a specific PE
>+ * @pe: EEH PE
>+ *
>+ * Attempts to recover the given PE.  If recovery fails or the PE has failed
>+ * too many times, remove the PE.
>+ *
>+ * Returns true if @pe should no longer be used, else false.
>+ */

I think this bit of comments would be part of PATCH[1/2]? Also, the
comments needn't to be in any document as it's static one. I guess
you might not want it to show in stable branches as PATCH[1/2] has
been tagged as stable. It's fine if that's the case.

> static bool eeh_handle_normal_event(struct eeh_pe *pe)
> {
> 	struct pci_bus *frozen_bus;
>@@ -741,8 +750,13 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
>
> 	eeh_pe_update_time_stamp(pe);
> 	pe->freeze_count++;
>-	if (pe->freeze_count > eeh_max_freezes)
>-		goto excess_failures;
>+	if (pe->freeze_count > eeh_max_freezes) {
>+		pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
>+		       "last hour and has been permanently disabled.\n",
>+		       pe->phb->global_number, pe->addr,
>+		       pe->freeze_count);
>+		goto hard_fail;
>+	}
> 	pr_warn("EEH: This PCI device has failed %d times in the last hour\n",
> 		pe->freeze_count);
>
>@@ -872,25 +886,16 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
>
> 	return false;
>
>-excess_failures:
>+hard_fail:
> 	/*
> 	 * About 90% of all real-life EEH failures in the field
> 	 * are due to poorly seated PCI cards. Only 10% or so are
> 	 * due to actual, failed cards.
> 	 */

This bit of comments apply to "excess_failures" only, so it would
be moved together with the pr_err(). Frankly speaking, I don't see
the benebit of the cleanup. "excess_failure" in the original code
indicates the case (excessive failures) explicitly, which is nice.
However, it's not a big deal.

>-	pr_err("EEH: PHB#%x-PE#%x has failed %d times in the\n"
>-	       "last hour and has been permanently disabled.\n"
>-	       "Please try reseating or replacing it.\n",
>-		pe->phb->global_number, pe->addr,
>-		pe->freeze_count);
>-	goto perm_error;
>-
>-hard_fail:
> 	pr_err("EEH: Unable to recover from failure from PHB#%x-PE#%x.\n"
> 	       "Please try reseating or replacing it\n",
> 		pe->phb->global_number, pe->addr);
>
>-perm_error:

We will have the message from above pr_err() for "perm_error" case, but
we don't have that in original code.

> 	eeh_slot_error_detail(pe, EEH_LOG_PERM);
>
> 	/* Notify all devices that they're about to go down. */
>@@ -923,6 +928,13 @@ static bool eeh_handle_normal_event(struct eeh_pe *pe)
> 	return false;
> }
>
>+/**
>+ * eeh_handle_special_event - Handle EEH events without a specific failing PE
>+ *
>+ * Called when an EEH event is detected but can't be narrowed down to a
>+ * specific PE.  Iterates through possible failures and handles them as
>+ * necessary.
>+ */
> static void eeh_handle_special_event(void)
> {
> 	struct eeh_pe *pe, *phb_pe;

Thanks,
Gavin
