Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qkKZk30lrzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Apr 2016 05:17:34 +1000 (AEST)
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 11 Apr 2016 16:17:29 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 617DC352006E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 15:17:13 -0400 (EDT)
Received: from d24av05.br.ibm.com (d24av05.br.ibm.com [9.18.232.44])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3BIHP1b23331280
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 15:17:25 -0300
Received: from d24av05.br.ibm.com (localhost [127.0.0.1])
 by d24av05.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3BJHNqu024176
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 15:17:24 -0400
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, nfont@linux.vnet.ibm.com
Subject: [PATCH 1/2 v3] Revert "powerpc/eeh: Fix crash in
 eeh_add_device_early() on Cell"
Date: Mon, 11 Apr 2016 16:17:22 -0300
Message-Id: <1460402243-24346-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This reverts commit 89a51df5ab1d38b257300b8ac940bbac3bb0eb9b.

The function eeh_add_device_early() is used to perform EEH initialization in
devices added later on the system, like in hotplug/DLPAR scenarios. Since the
commit 89a51df5ab1d ("powerpc/eeh: Fix crash in eeh_add_device_early() on Cell")
a new check was introduced in this function - Cell has no EEH capabilities
which led to kernel oops if hotplug was performed, so checking for
eeh_enabled() was introduced to avoid the issue.

However, in architectures that EEH is present like pSeries or PowerNV, we might
reach a case in which no PCI devices are present on boot time and so EEH is not
initialized. Then, if a device is added via DLPAR for example,
eeh_add_device_early() fails because eeh_enabled() is false, and EEH end up
not being enabled at all.

This reverts the aforementioned patch since a new verification was introduced by
the commit d91dafc02f42 ("powerpc/eeh: Delay probing EEH device during hotplug")
and so the original Cell issue does not happen anymore.

Cc: stable@vger.kernel.org
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/eeh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 6544017..6758484 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1068,7 +1068,7 @@ void eeh_add_device_early(struct pci_dn *pdn)
 	struct pci_controller *phb;
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 
-	if (!edev || !eeh_enabled())
+	if (!edev)
 		return;
 
 	if (!eeh_has_flag(EEH_PROBE_MODE_DEVTREE))
-- 
2.1.0
