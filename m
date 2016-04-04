Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdq5F0KcCzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Apr 2016 21:09:53 +1000 (AEST)
Date: Mon, 4 Apr 2016 21:09:28 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>, Alexander
 Graf <agraf@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH] spapr: Don't set the TM ibm,pa-features bit in PR KVM mode
Message-ID: <20160404210928.0d9ae644@kryten>
In-Reply-To: <20160404204346.1cf44df8@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We don't support transactional memory in PR KVM, so don't tell
the OS that we do.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index e7be21e..538bd87 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -696,6 +696,12 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     } else /* env->mmu_model == POWERPC_MMU_2_07 */ {
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
+
+        /* Don't enable TM in PR KVM mode */
+        if (kvm_enabled() &&
+            kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)) {
+            pa_features[24] &= ~0x80;
+        }
     }
     if (env->ci_large_pages) {
         pa_features[3] |= 0x20;
