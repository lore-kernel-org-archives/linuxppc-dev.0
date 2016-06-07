Return-Path: <anton@au1.ibm.com>
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rP9wP5dpyzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 22:33:41 +1000 (AEST)
Received: from pps.filterd (m0075420.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u57CTLfY017608
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 08:33:39 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23duqs9bkg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 08:33:37 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anton@au1.ibm.com>;
 Tue, 7 Jun 2016 22:33:34 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2AE192BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jun 2016 22:33:17 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u57CX6Al7733712
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 22:33:06 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u57CWl12032447
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Jun 2016 22:32:47 +1000
Date: Tue, 7 Jun 2016 22:32:10 +1000
From: Anton Blanchard <anton@au1.ibm.com>
To: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Neuling
 <mikey@neuling.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH 2/2] spapr: Better handling of ibm,pa-features TM bit
In-Reply-To: <20160607222842.4a745724@kryten>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
 <20160430104800.0a7c1d11@kryten> <20160607222842.4a745724@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20160607223210.2b1b42ae@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

There are a few issues with our handling of the ibm,pa-features
TM bit:

- We don't support transactional memory in PR KVM, so don't tell
  the OS that we do.

- In full emulation we have a minimal implementation of TM that always
  fails, so for performance reasons lets not tell the OS that we
  support it either.

- In HV KVM mode, we should mirror the host TM enabled state by
  looking at the AT_HWCAP2 bit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0636642..c403fbb 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -620,7 +620,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
         0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
     uint8_t *pa_features;
     size_t pa_size;
 
@@ -697,6 +697,19 @@ static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
     } else /* env->mmu_model == POWERPC_MMU_2_07 */ {
         pa_features = pa_features_207;
         pa_size = sizeof(pa_features_207);
+
+#ifdef CONFIG_KVM
+        /* Only enable TM in HV KVM mode */
+        if (kvm_enabled() &&
+            !kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO)) {
+            unsigned long hwcap2 = qemu_getauxval(AT_HWCAP2);
+
+            /* Guest should inherit host TM enabled bit */
+            if (hwcap2 & PPC_FEATURE2_HAS_HTM) {
+                pa_features[24] |= 0x80;
+            }
+        }
+#endif
     }
     if (env->ci_large_pages) {
         pa_features[3] |= 0x20;
