Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgNXG3XDlzDq6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 10:20:14 +1000 (AEST)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Apr 2016 21:20:09 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8280D1DC0071
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 20:20:01 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u36NHpdB4698366
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 20:17:51 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u370K55s011214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:20:06 -0300
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Subject: [PATCH 1/2 v2] Revert "powerpc/eeh: Fix crash in
 eeh_add_device_early() on Cell"
Date: Wed,  6 Apr 2016 21:20:04 -0300
Message-Id: <1459988405-13991-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
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
