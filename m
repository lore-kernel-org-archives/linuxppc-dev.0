Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yClhL1D3zzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 09:22:09 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9CMJ9QS089265
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 18:22:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2djbjwcruk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 18:22:07 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 12 Oct 2017 18:22:06 -0400
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, mpe@ellerman.id.au,
 paulus@samba.org, maurosr@linux.vnet.ibm.com
Subject: [PATCH] powerpc/powernv: Enable reset_devices parameter to issue a
 PHB reset
Date: Thu, 12 Oct 2017 19:21:53 -0300
Message-Id: <20171012222153.24905-1-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During a kdump kernel boot in PowerPC, we request a reset of the
PHBs to the FW. It makes sense, since if we are booting a kdump
kernel it means we had some trouble before and we cannot rely in
the adapters' health; they could be in a bad state, hence the
reset is needed.

But not only in a kdump kernel we could use this reset - there are
situations, specially when debugging drivers, that we could break
an adapter in a way it requires such reset. One can tell to just
go ahead and reboot the machine, but happens that many times doing
kexec is much faster, and so preferable than a full power cycle.
Also, we could have situations in which adapters are in bad state
due to adapter's FW issue, and only a PHB Fundamental Reset could
revive them.

This patch enables the reset_devices parameter to perform such reset.
The parameter is barely used - only few drivers make use of it.
This is a PowerPC-only change.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
This patch was built/tested against powerpc/next branch.

We recently had a situation in which i40e driver couldn't start,
even after a full power cycle, due to a bug in its FW triggered
by a DCB condition in switch (thanks Mauro for narrowing this).
This patch enabled us to revive the adapter and use network
while debugging.


 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 arch/powerpc/platforms/powernv/pci-ioda.c       | 7 +++++--
 init/main.c                                     | 4 ++--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 05496622b4ef..e75cf4a9345d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3656,7 +3656,8 @@
 			the bottom of the address space.
 
 	reset_devices	[KNL] Force drivers to reset the underlying device
-			during initialization.
+			during initialization. In PowerPC bare-metal (aka
+			PowerNV), it also issues a Fundamental Reset on PHBs.
 
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fb5cd7511189..0a5f2a221a09 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -4014,9 +4014,12 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 * If we're running in kdump kernel, the previous kernel never
 	 * shutdown PCI devices correctly. We already got IODA table
 	 * cleaned out. So we have to issue PHB reset to stop all PCI
-	 * transactions from previous kernel.
+	 * transactions from previous kernel. Also, reset_devices
+	 * parameter will force the issue of reset (useful in debug
+	 * scenarios).
 	 */
-	if (is_kdump_kernel()) {
+
+	if (is_kdump_kernel() || reset_devices) {
 		pr_info("  Issue PHB reset ...\n");
 		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
 		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
diff --git a/init/main.c b/init/main.c
index 0ee9c6866ada..9d3dc50fadfe 100644
--- a/init/main.c
+++ b/init/main.c
@@ -157,10 +157,10 @@ EXPORT_SYMBOL(reset_devices);
 static int __init set_reset_devices(char *str)
 {
 	reset_devices = 1;
-	return 1;
+	return 0;
 }
 
-__setup("reset_devices", set_reset_devices);
+early_param("reset_devices", set_reset_devices);
 
 static const char *argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 const char *envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
-- 
2.14.2
