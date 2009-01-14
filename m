Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: get the number of SLBs from "slb-size" property
Date: Thu, 15 Jan 2009 10:42:41 +1100
Message-ID: <26961.1231976561@neuling.org>
Sender: mikey@neuling.org
Cc: anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PAPR says that the property for specifying the number of SLBs should
be called "slb-size".  We currently only look for "ibm,slb-size" because
this is what firmware actually presents.

This patch makes us look for the "slb-size" property as well and in
preference to the "ibm,slb-size".  This should future proof us if
firmware changes to match PAPR.  

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/prom.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/prom.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/prom.c
@@ -590,6 +590,11 @@ static void __init check_cpu_slb_size(un
 {
 	u32 *slb_size_ptr;
 
+	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL);
+	if (slb_size_ptr != NULL) {
+		mmu_slb_size = *slb_size_ptr;
+		return;
+	}
 	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
 	if (slb_size_ptr != NULL) {
 		mmu_slb_size = *slb_size_ptr;
