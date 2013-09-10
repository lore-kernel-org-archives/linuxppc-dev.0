Return-Path: <murzin.v@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com
 [IPv6:2a00:1450:4010:c04::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 150F42C010B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Sep 2013 02:39:43 +1000 (EST)
Received: by mail-lb0-f171.google.com with SMTP id u14so6613803lbd.30
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 09:39:36 -0700 (PDT)
From: Vladimir Murzin <murzin.v@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc: export cpu_to_chip_id
Date: Tue, 10 Sep 2013 18:38:55 +0200
Message-Id: <1378831135-2179-1-git-send-email-murzin.v@gmail.com>
Cc: chenhui.zhao@freescale.com, Vladimir Murzin <murzin.v@gmail.com>,
 paulus@samba.org, srivatsa.bhat@linux.vnet.ibm.com, tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While cross-building for PPC64 I've got

ERROR: ".cpu_to_chip_id" [drivers/block/mtip32xx/mtip32xx.ko] undefined!

mtip32xx refer to topology_physical_package_id, which stands for
cpu_to_chip-id.

Make cpu_to_chip-id (and topology_physical_package_id) available for
external users.

Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
---
 arch/powerpc/kernel/smp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 442d8e2..1d9c1c2 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -611,6 +611,7 @@ int cpu_to_chip_id(int cpu)
 	of_node_put(np);
 	return of_get_ibm_chip_id(np);
 }
+EXPORT_SYMBOL_GPL(cpu_to_chip_id);
 
 /* Helper routines for cpu to core mapping */
 int cpu_core_index_of_thread(int cpu)
-- 
1.7.10.4
