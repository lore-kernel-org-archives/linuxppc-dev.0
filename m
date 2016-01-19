Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 26E841A001D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jan 2016 07:18:29 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 19 Jan 2016 18:18:25 -0200
Received: from d24relay03.br.ibm.com (d24relay03.br.ibm.com [9.13.184.25])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7ACA1352006C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 15:18:17 -0500 (EST)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0JKGBgn3735978
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 18:16:12 -0200
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0JKINZY008928
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 15:18:23 -0500
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, benh@kernel.crashing.org,
 nfont@linux.vnet.ibm.com, paulus@samba.org,
 "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/eeh: Check for EEH availability in
 eeh_add_device_early()
Date: Tue, 19 Jan 2016 18:18:19 -0200
Message-Id: <1453234700-27593-2-git-send-email-gpiccoli@linux.vnet.ibm.com>
In-Reply-To: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1453234700-27593-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The function eeh_add_device_early() is used to perform EEH initialization in
devices added later on the system, like in hotplug/DLPAR scenarios. Since the
commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
a new check was introduced in this function - Cell has no EEH capabilities
which led to kernel oops if hotplug was performed, so checking for
eeh_enabled() was introduced to avoid the issue.

However, in architectures that EEH is present like pSeries or PowerNV, we might
reach a case in which no PCI devices are present on boot and so EEH is not
initialized. Then, if a device is added via DLPAR for example,
eeh_add_device_early() fails because eeh_enabled() is false.

Also, we can hit a kernel oops on pSeries arch if eeh_add_device_early() fails:
if we have no PCI devices on machine at boot time, and then we add a PCI device
via DLPAR operation, the function query_ddw() triggers the oops on NULL pointer
dereference in the line "cfg_addr = edev->config_addr;". It happens because
config_addr in edev is NULL, since the function eeh_add_device_early() was not
completed successfully.

This patch just changes the way the arch checking is done in function
eeh_add_device_early(): we don't use eeh_enabled() anymore, but instead we
introduce the function eeh_available() that checks the running architecture
by using the macro machine_is(). If we are running on pSeries or PowerNV, the
EEH mechanism is available (even if not initialized yet). This way, we don't
try to enable EEH on Cell and we don't hit the oops on DLPAR either.

Fixes: 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 40e4d4a..69031d7 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1056,6 +1056,23 @@ int eeh_init(void)
 core_initcall_sync(eeh_init);
 
 /**
+ * eeh_available - Checks for the availability of EEH based on running
+ * architecture.
+ *
+ * This routine should be used in case we need to check if EEH is
+ * available in some situation, regardless if EEH is enabled or not.
+ * For example, if we hotplug-add a PCI device on a machine with no
+ * other PCI device, EEH won't be enabled, yet it's available if the
+ * arch supports it.
+ */
+static inline bool eeh_available(void)
+{
+	if (machine_is(pseries) || machine_is(powernv))
+		return true;
+	return false;
+}
+
+/**
  * eeh_add_device_early - Enable EEH for the indicated device node
  * @pdn: PCI device node for which to set up EEH
  *
@@ -1072,7 +1089,7 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	struct pci_controller *phb;
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
-	if (!edev || !eeh_enabled())
+	if (!edev || !eeh_available())
 		return;
 
 	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
-- 
2.1.0
