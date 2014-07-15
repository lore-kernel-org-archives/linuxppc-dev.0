Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CA2E1A014D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 15:07:15 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 15:07:11 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3CFBD3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 15:07:10 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F56rSg9503064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 15:06:54 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F579ti001115
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 15:07:09 +1000
Date: Tue, 15 Jul 2014 15:07:07 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] Bugfix: powerpc/eeh: Wrong place to call pci_get_slot()
Message-ID: <20140715050707.GA17089@shangw>
References: <1405391628-1680-1-git-send-email-qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
In-Reply-To: <1405391628-1680-1-git-send-email-qiudayu@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 14, 2014 at 10:33:48PM -0400, Mike Qiu wrote:
>pci_get_slot() is called with hold of PCI bus semaphore and it's not
>safe to be called in interrupt context. However, we possibly checks
>EEH error and calls the function in interrupt context. To avoid using
>pci_get_slot(), we turn into device tree for fetching location code.
>Otherwise, we might run into WARN_ON() as following messages indicate:
>
> WARNING: at drivers/pci/search.c:223
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc3+ #72
> task: c000000001367af0 ti: c000000001444000 task.ti: c000000001444000
> NIP: c000000000497b70 LR: c000000000037530 CTR: 000000003003d114
> REGS: c000000001446fa0 TRAP: 0700   Not tainted  (3.16.0-rc3+)
> MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 48002422  XER: 20000000
> CFAR: c00000000003752c SOFTE: 0
>   :
> NIP [c000000000497b70] .pci_get_slot+0x40/0x110
> LR [c000000000037530] .eeh_pe_loc_get+0x150/0x190
> Call Trace:
>   .of_get_property+0x30/0x60 (unreliable)
>   .eeh_pe_loc_get+0x150/0x190
>   .eeh_dev_check_failure+0x1b4/0x550
>   .eeh_check_failure+0x90/0xf0
>   .lpfc_sli_check_eratt+0x504/0x7c0 [lpfc]
>   .lpfc_poll_eratt+0x64/0x100 [lpfc]
>   .call_timer_fn+0x64/0x190
>   .run_timer_softirq+0x2cc/0x3e0
>
>Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
>---
> Changelog[v2]:
>	Check the child device_node of root bus for root port
>	directly instead of search pdev from device-tree and
>	then translate it to device-node
>

I run into following warning with your patch. Please test the attached
one. If no problem found, send that one please.

arch/powerpc/kernel/eeh_pe.c: In function 'eeh_pe_loc_get':
arch/powerpc/kernel/eeh_pe.c:806:18: warning: unused variable 'pdev'

Thanks,
Gavin

> arch/powerpc/kernel/eeh_pe.c | 24 ++++++------------------
> 1 file changed, 6 insertions(+), 18 deletions(-)
>
>diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
>index fbd01eb..f96c10f 100644
>--- a/arch/powerpc/kernel/eeh_pe.c
>+++ b/arch/powerpc/kernel/eeh_pe.c
>@@ -802,7 +802,6 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
>  */
> const char *eeh_pe_loc_get(struct eeh_pe *pe)
> {
>-	struct pci_controller *hose;
> 	struct pci_bus *bus = eeh_pe_bus_get(pe);
> 	struct pci_dev *pdev;
> 	struct device_node *dn;
>@@ -811,29 +810,20 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
> 	if (!bus)
> 		return "N/A";
>
>+	dn = pci_bus_to_OF_node(bus);
> 	/* PHB PE or root PE ? */
>-	if (pci_is_root_bus(bus)) {
>-		hose = pci_bus_to_host(bus);
>-		loc = of_get_property(hose->dn,
>-				"ibm,loc-code", NULL);
>+	if (dn && pci_is_root_bus(bus)) {
>+		loc = of_get_property(dn, "ibm,loc-code", NULL);
> 		if (loc)
> 			return loc;
>-		loc = of_get_property(hose->dn,
>-				"ibm,io-base-loc-code", NULL);
>+		loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
> 		if (loc)
> 			return loc;
>
>-		pdev = pci_get_slot(bus, 0x0);
>-	} else {
>-		pdev = bus->self;
>-	}
>-
>-	if (!pdev) {
>-		loc = "N/A";
>-		goto out;
>+		/* Check the root port */
>+		dn = dn->child;
> 	}
>
>-	dn = pci_device_to_OF_node(pdev);
> 	if (!dn) {
> 		loc = "N/A";
> 		goto out;
>@@ -846,8 +836,6 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
> 		loc = "N/A";
>
> out:
>-	if (pci_is_root_bus(bus) && pdev)
>-		pci_dev_put(pdev);
> 	return loc;
> }
>
>-- 
>1.8.1.4
>

--jI8keyz6grp/JLjh
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-powerpc-eeh-Wrong-place-to-call-pci_get_slot.patch"

>From 14e45dbe5cd8732ad824f66d576e3642ec338f76 Mon Sep 17 00:00:00 2001
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Date: Mon, 14 Jul 2014 22:33:48 -0400
Subject: [PATCH] powerpc/eeh: Wrong place to call pci_get_slot()

pci_get_slot() is called with hold of PCI bus semaphore and it's not
safe to be called in interrupt context. However, we possibly checks
EEH error and calls the function in interrupt context. To avoid using
pci_get_slot(), we turn into device tree for fetching location code.
Otherwise, we might run into WARN_ON() as following messages indicate:

 WARNING: at drivers/pci/search.c:223
 CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.16.0-rc3+ #72
 task: c000000001367af0 ti: c000000001444000 task.ti: c000000001444000
 NIP: c000000000497b70 LR: c000000000037530 CTR: 000000003003d114
 REGS: c000000001446fa0 TRAP: 0700   Not tainted  (3.16.0-rc3+)
 MSR: 9000000000029032 <SF,HV,EE,ME,IR,DR,RI>  CR: 48002422  XER: 20000000
 CFAR: c00000000003752c SOFTE: 0
   :
 NIP [c000000000497b70] .pci_get_slot+0x40/0x110
 LR [c000000000037530] .eeh_pe_loc_get+0x150/0x190
 Call Trace:
   .of_get_property+0x30/0x60 (unreliable)
   .eeh_pe_loc_get+0x150/0x190
   .eeh_dev_check_failure+0x1b4/0x550
   .eeh_check_failure+0x90/0xf0
   .lpfc_sli_check_eratt+0x504/0x7c0 [lpfc]
   .lpfc_poll_eratt+0x64/0x100 [lpfc]
   .call_timer_fn+0x64/0x190
   .run_timer_softirq+0x2cc/0x3e0

Cc: Stable@vger.kernel.org
Signed-off-by: Mike Qiu <qiudayu@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh_pe.c | 45 +++++++++++++-------------------------------
 1 file changed, 13 insertions(+), 32 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index fbd01eb..920c9dc 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -802,53 +802,34 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
  */
 const char *eeh_pe_loc_get(struct eeh_pe *pe)
 {
-	struct pci_controller *hose;
 	struct pci_bus *bus = eeh_pe_bus_get(pe);
-	struct pci_dev *pdev;
 	struct device_node *dn;
-	const char *loc;
+	const char *loc = NULL;
 
-	if (!bus)
-		return "N/A";
+	dn = bus ? pci_bus_to_OF_node(bus) : NULL;
+	if (!dn)
+		goto out;
 
 	/* PHB PE or root PE ? */
 	if (pci_is_root_bus(bus)) {
-		hose = pci_bus_to_host(bus);
-		loc = of_get_property(hose->dn,
-				"ibm,loc-code", NULL);
+		loc = of_get_property(dn, "ibm,loc-code", NULL);
+		if (!loc)
+			loc = of_get_property(dn, "ibm,io-base-loc-code", NULL);
 		if (loc)
-			return loc;
-		loc = of_get_property(hose->dn,
-				"ibm,io-base-loc-code", NULL);
-		if (loc)
-			return loc;
-
-		pdev = pci_get_slot(bus, 0x0);
-	} else {
-		pdev = bus->self;
-	}
-
-	if (!pdev) {
-		loc = "N/A";
-		goto out;
-	}
+			goto out;
 
-	dn = pci_device_to_OF_node(pdev);
-	if (!dn) {
-		loc = "N/A";
-		goto out;
+		/* Check the root port */
+		dn = dn->child;
+		if (!dn)
+			goto out;
 	}
 
 	loc = of_get_property(dn, "ibm,loc-code", NULL);
 	if (!loc)
 		loc = of_get_property(dn, "ibm,slot-location-code", NULL);
-	if (!loc)
-		loc = "N/A";
 
 out:
-	if (pci_is_root_bus(bus) && pdev)
-		pci_dev_put(pdev);
-	return loc;
+	return loc ? loc : "N/A";
 }
 
 /**
-- 
1.8.3.2


--jI8keyz6grp/JLjh--
