Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6zL35tpszDqYj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 10:48:27 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u780hv9L036386
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Aug 2016 20:48:25 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24na1vfxxx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Aug 2016 20:48:24 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 10:48:21 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B8C1A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 10:48:18 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u780mIxx29229176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 10:48:18 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u780mI9O009190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Aug 2016 10:48:18 +1000
Date: Mon, 8 Aug 2016 10:47:47 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/eeh: Fix slot locations on NPU and legacy
 platforms
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20160804050115.9937-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160804050115.9937-1-ruscur@russell.cc>
Message-Id: <20160808004747.GA6485@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 04, 2016 at 03:01:15PM +1000, Russell Currey wrote:
>The slot location code as part of EEH has never functioned perfectly on
>every powerpc system.  The device node properties "ibm,slot-loc",
>"ibm,slot-location-code" and "ibm,io-base-loc-code" have all been
>presented in different cases, and in some situations, there are legacy
>platforms not conforming to the conventions of populating root buses with
>"ibm,io-base-loc-code" and child nodes with "ibm,slot-location-code".
>
>Specifically, some legacy platforms use "ibm,loc-code" instead, which
>stopped working with 7e56f627768.  In addition, EEH PEs for NPU devices
>have slot locations specified on the devices instead of buses due to their
>architecture, and these were not printed.  This has been fixed by looking
>at the top device of a PE for a slot location before checking its bus.
>
>Fixes: 7e56f627768 "powerpc/eeh: Fix PE location code"

Please describe what the patch is going to do if possible. I didn't completely
git it from the changelog.

Fixes: 7e56f627768 ("powerpc/eeh: Fix PE location code")

>Cc: <stable@vger.kernel.org> #4.4+
>Signed-off-by: Russell Currey <ruscur@russell.cc>
>---
> arch/powerpc/kernel/eeh_pe.c | 31 ++++++++++++++++++++++++++-----
> 1 file changed, 26 insertions(+), 5 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index f0520da..034538c 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -881,17 +881,34 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>  * eeh_pe_loc_get - Retrieve location code binding to the given PE
>  * @pe: EEH PE
>  *
>- * Retrieve the location code of the given PE. If the primary PE bus
>- * is root bus, we will grab location code from PHB device tree node
>- * or root port. Otherwise, the upstream bridge's device tree node
>- * of the primary PE bus will be checked for the location code.
>+ * Retrieve the location code of the given PE. The first device associated
>+ * with the PE is checked for a slot location.  If missing, the bus of the
>+ * device is checked instead.  If this is a root bus, the location code is
>+ * taken from the PHB device tree node or root port.  If not, the upstream
>+ * bridge's device tree node of the primary PE bus will be checked instead.
>+ * If a slot location isn't found on the bus, walk through parent buses
>+ * until a location is found.
>  */
> const char *eeh_pe_loc_get(struct eeh_pe *pe)
> {
>-	struct pci_bus *bus = eeh_pe_bus_get(pe);
>+	struct pci_bus *bus;
> 	struct device_node *dn;
> 	const char *loc = NULL;
>
>+	/* Check the slot location of the first (top) PCI device */
>+	struct eeh_dev *edev =
>+		list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
>+
>+	if (edev) {
>+		loc = of_get_property(edev->pdn->node,
>+				      "ibm,slot-location-code", NULL);
>+		if (loc)
>+			return loc;
>+	}

I don't think it's correct as it's to return the child PE's location code.
The @edev's "ibm,loc-code" should be used in this case. On PowerNV, we
needn't check "ibm,loc-code" as it's created based on "ibm,slot-location-code"
of its bus's node, which is covered by original code. However, "ibm,loc-code"
should be checked on pSeries as we don't have "ibm,slot-location-code" and
"ibm,slot-label" there.

Please use eeh_dev_to_pdn() when getting pdn from a EEH device.

>+
>+	/* If there's nothing on the device, look at the bus */
>+	bus = eeh_pe_bus_get(pe);
>+
> 	while (bus) {
> 		dn = pci_bus_to_OF_node(bus);
> 		if (!dn) {
>@@ -905,6 +922,10 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
> 			loc = of_get_property(dn, "ibm,slot-location-code",
> 					      NULL);
>
>+		/* Fall back to ibm,loc-code if nothing else is found */
>+		if (!loc)
>+			loc = of_get_property(dn, "ibm,loc-code", NULL);
>+

We actually need consistent order as above: "ibm,loc-code" has high
priority than "ibm,slot-location-code" and "ibm,io-base-loc-code".

Thanks,
Gavin

> 		if (loc)
> 			return loc;
>
>-- 
>2.9.2
>
