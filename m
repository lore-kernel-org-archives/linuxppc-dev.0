Return-Path: <oohall@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2ZCW3x3RzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 03:43:19 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id c198so672788pfc.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:43:19 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, bsingharora@gmail.com, linux-nvdimm@lists.01.org,
 Rashmica Gupta <rashmica.g@gmail.com>, Anton Blanchard <anton@samba.org>,
 Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH 8/9] powerpc/mm: Wire up hpte_removebolted for powernv
Date: Wed, 12 Apr 2017 03:42:32 +1000
Message-Id: <20170411174233.21902-9-oohall@gmail.com>
In-Reply-To: <20170411174233.21902-1-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Rashmica Gupta <rashmica.g@gmail.com>

Adds support for removing bolted (i.e kernel linear mapping) mappings on
powernv. This is needed to support memory hot unplug operations which
are required for the teardown of DAX/PMEM devices.

Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Anton Blanchard <anton@samba.org>
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
Could the original author of this add their S-o-b? I pulled it out of
Rashmica's memtrace patch, but I remember someone saying Anton wrote
it originally.
---
 arch/powerpc/mm/hash_native_64.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 65bb8f33b399..9ba91d4905a4 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -407,6 +407,36 @@ static void native_hpte_updateboltedpp(unsigned long newpp, unsigned long ea,
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
@@ -725,6 +755,7 @@ void __init hpte_init_native(void)
 	mmu_hash_ops.hpte_invalidate	= native_hpte_invalidate;
 	mmu_hash_ops.hpte_updatepp	= native_hpte_updatepp;
 	mmu_hash_ops.hpte_updateboltedpp = native_hpte_updateboltedpp;
+	mmu_hash_ops.hpte_removebolted = native_hpte_removebolted;
 	mmu_hash_ops.hpte_insert	= native_hpte_insert;
 	mmu_hash_ops.hpte_remove	= native_hpte_remove;
 	mmu_hash_ops.hpte_clear_all	= native_hpte_clear;
-- 
2.9.3
