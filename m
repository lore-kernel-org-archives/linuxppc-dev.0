Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxX471cc9zDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 10:48:23 +1000 (AEST)
Date: Sat, 30 Apr 2016 10:48:00 +1000
From: Anton Blanchard <anton@samba.org>
To: Alexander Graf <agraf@suse.de>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Ellerman
 <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>,
 linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v2] spapr: Don't set the TM ibm,pa-features bit in PR KVM mode
Message-ID: <20160430104800.0a7c1d11@kryten>
In-Reply-To: <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
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

v2: Fix build with CONFIG_KVM disabled, noticed by Alex.

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b69995e..dc3e3c9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -696,6 +696,14 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     } else /* env->mmu_model == POWERPC_MMU_2_07 */ {
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
+
+#ifdef CONFIG_KVM
+        /* Don't enable TM in PR KVM mode */
+        if (kvm_enabled() &&
+            kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)) {
+            pa_features[24] &= ~0x80;
+        }
+#endif
     }
     if (env->ci_large_pages) {
         pa_features[3] |= 0x20;
