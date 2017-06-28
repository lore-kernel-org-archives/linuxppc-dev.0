Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wy4zw0lt5zDr3r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jun 2017 11:33:00 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id d5so6865193pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 18:33:00 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Anton Blanchard <anton@samba.org>,
	Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v4 5/6] powerpc/mm: Wire up hpte_removebolted for powernv
Date: Wed, 28 Jun 2017 11:32:35 +1000
Message-Id: <20170628013236.413-5-oohall@gmail.com>
In-Reply-To: <20170628013236.413-1-oohall@gmail.com>
References: <20170628013236.413-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

Adds support for removing bolted (i.e kernel linear mapping) mappings on
powernv. This is needed to support memory hot unplug operations which
are required for the teardown of DAX/PMEM devices.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Rashmica Gupta <rashmica.g@gmail.com>
Signed-off-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
v1 -> v2: Fixed the commit author
          Added VM_WARN_ON() if we attempt to remove an unbolted hpte
---
 arch/powerpc/mm/hash_native_64.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 65bb8f33b399..b534d041cfe8 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -407,6 +407,38 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
 	tlbie(vpn, psize, psize, ssize, 0);
 }
 
+/*
+ * Remove a bolted kernel entry. Memory hotplug uses this.
+ *
+ * No need to lock here because we should be the only user.
+ */
+static int native_hpte_removebolted(unsigned long ea, int psize, int ssize)
+{
+	unsigned long vpn;
+	unsigned long vsid;
+	long slot;
+	struct hash_pte *hptep;
+
+	vsid = get_kernel_vsid(ea, ssize);
+	vpn = hpt_vpn(ea, vsid, ssize);
+
+	slot = native_hpte_find(vpn, psize, ssize);
+	if (slot == -1)
+		return -ENOENT;
+
+	hptep = htab_address + slot;
+
+	VM_WARN_ON(!(be64_to_cpu(hptep->v) & HPTE_V_BOLTED));
+
+	/* Invalidate the hpte */
+	hptep->v = 0;
+
+	/* Invalidate the TLB */
+	tlbie(vpn, psize, psize, ssize, 0);
+	return 0;
+}
+
+
 static void native_hpte_invalidate(unsigned long slot, unsigned long vpn,
 				   int bpsize, int apsize, int ssize, int local)
 {
@@ -725,6 +757,7 @@ void __init hpte_init_native(void)
 	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
 	mmu_hash_ops.hpte_updatepp	= native_hpte_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
+	mmu_hash_ops.hpte_removebolted = native_hpte_removebolted;
 	mmu_hash_ops.hpte_insert	= native_hpte_insert;
 	mmu_hash_ops.hpte_remove	= native_hpte_remove;
 	mmu_hash_ops.hpte_clear_all	= native_hpte_clear;
-- 
2.9.4
