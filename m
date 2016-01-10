Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E33B1A0908
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 14:08:35 +1100 (AEDT)
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Sun, 10 Jan 2016 01:08:29 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id F0A701DC0060
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jan 2016 22:08:22 -0500 (EST)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0A35wUK29884750
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 01:05:59 -0200
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0A38P9Q008429
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jan 2016 01:08:25 -0200
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, gwshan@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, gpiccoli@linux.vnet.ibm.com
Subject: [PATCH] powerpc/eeh: Validate arch in eeh_add_device_early()
Date: Sun, 10 Jan 2016 01:08:15 -0200
Message-Id: <1452395295-1759-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
added a check on function eeh_add_device_early(): since in Cell arch eeh_ops
is NULL, that code used to crash on Cell. The commit's approach was validate
if EEH was available by checking the result of function eeh_enabled().

Since the function eeh_add_device_early() is used to perform EEH
initialization in devices added later on the system, like in hotplug/DLPAR
scenarios, we might reach a case in which no PCI devices are present on boot
and so EEH is not initialized. Then, if a device is added via DLPAR for
example, eeh_add_device_early() fails because eeh_enabled() is false.

We can hit a kernel oops on pSeries arch if eeh_add_device_early() fails:
if we have no PCI devices on machine at boot time, and then we add a PCI device
via DLPAR operation, the function query_ddw() triggers the oops on NULL pointer
dereference in the line "cfg_addr = edev->config_addr;". It happens because
config_addr in edev is NULL, since the function eeh_add_device_early() was not
completed successfully.

This patch just changes the way the arch checking is done in function
eeh_add_device_early(): we use no more eeh_enabled(), but instead we check the
running architecture by using the macro machine_is(). If we are running on
pSeries or PowerNV, the EEH mechanism can be enabled; otherwise, we bail out
the function. This way, we don't enable EEH on Cell and we don't hit the oops
on DLPAR either.

Fixes: 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 40e4d4a..81e2d3e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1072,7 +1072,13 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	struct pci_controller *phb;
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
-	if (!edev || !eeh_enabled())
+	if (!edev)
+		return;
+
+	/* Some platforms (like Cell) don't have EEH capabilities, so we
+	 * need to abort here. In case of pseries or powernv, we have EEH
+	 * so we can continue. */
+	if (!machine_is(pseries) && !machine_is(powernv))
 		return;
 
 	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
-- 
2.1.0
