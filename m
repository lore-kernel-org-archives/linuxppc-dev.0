Return-Path: <brking@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5A9E02C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Nov 2013 09:28:02 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 25 Nov 2013 15:27:59 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 837F73E40026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2013 15:27:56 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id rAPKQ7me37355670
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2013 21:26:07 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAPMRtWe018834
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Nov 2013 15:27:56 -0700
Message-Id: <201311252227.rAPMRtC2018812@d03av05.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Increase EEH recovery timeout for SR-IOV
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 25 Nov 2013 16:27:54 -0600
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 shangw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


In order to support concurrent adapter firmware download
to SR-IOV adapters on pSeries, each VF will see an EEH event
where the slot will remain in the unavailable state for
the duration of the adapter firmware update, which can take
as long as 5 minutes. Extend the EEH recovery timeout to
account for this.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/kernel/eeh.c        |    2 +-
 arch/powerpc/kernel/eeh_driver.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN arch/powerpc/kernel/eeh.c~eeh_sriov_vf_delay arch/powerpc/kernel/eeh.c
--- linux/arch/powerpc/kernel/eeh.c~eeh_sriov_vf_delay	2013-11-25 16:12:26.000000000 -0600
+++ linux-bjking1/arch/powerpc/kernel/eeh.c	2013-11-25 16:12:26.000000000 -0600
@@ -84,7 +84,7 @@
 #define EEH_MAX_FAILS	2100000
 
 /* Time to wait for a PCI slot to report status, in milliseconds */
-#define PCI_BUS_RESET_WAIT_MSEC (60*1000)
+#define PCI_BUS_RESET_WAIT_MSEC (5*60*1000)
 
 /* Platform dependent EEH operations */
 struct eeh_ops *eeh_ops = NULL;
diff -puN arch/powerpc/kernel/eeh_driver.c~eeh_sriov_vf_delay arch/powerpc/kernel/eeh_driver.c
--- linux/arch/powerpc/kernel/eeh_driver.c~eeh_sriov_vf_delay	2013-11-25 16:12:26.000000000 -0600
+++ linux-bjking1/arch/powerpc/kernel/eeh_driver.c	2013-11-25 16:12:26.000000000 -0600
@@ -468,7 +468,7 @@ static int eeh_reset_device(struct eeh_p
 /* The longest amount of time to wait for a pci device
  * to come back on line, in seconds.
  */
-#define MAX_WAIT_FOR_RECOVERY 150
+#define MAX_WAIT_FOR_RECOVERY 300
 
 static void eeh_handle_normal_event(struct eeh_pe *pe)
 {
_
