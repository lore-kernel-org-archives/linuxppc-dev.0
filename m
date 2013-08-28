Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3B7462C049C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 18:50:36 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id w10so6031625pde.37
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2013 01:50:34 -0700 (PDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v9 11/13] KVM: PPC: add trampolines for VFIO external API
Date: Wed, 28 Aug 2013 18:50:23 +1000
Message-Id: <1377679823-3780-1-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
References: <1377679070-3515-1-git-send-email-aik@ozlabs.ru>
Cc: kvm@vger.kernel.org, Gleb Natapov <gleb@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

KVM is going to use VFIO's external API. However KVM can operate even VFIO
is not compiled or loaded so KVM is linked to VFIO dynamically.

This adds proxy functions for VFIO external API.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kvm/book3s_64_vio.c | 49 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index cae1099..047b94c 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -27,6 +27,8 @@
 #include <linux/hugetlb.h>
 #include <linux/list.h>
 #include <linux/anon_inodes.h>
+#include <linux/module.h>
+#include <linux/vfio.h>
 
 #include <asm/tlbflush.h>
 #include <asm/kvm_ppc.h>
@@ -42,6 +44,53 @@
 
 #define ERROR_ADDR      ((void *)~(unsigned long)0x0)
 
+/*
+ * Dynamically linked version of the external user VFIO API.
+ *
+ * As a IOMMU group access control is implemented by VFIO,
+ * there is some API to vefiry that specific process can own
+ * a group. As KVM may run when VFIO is not loaded, KVM is not
+ * linked statically to VFIO, instead wrappers are used.
+ */
+struct vfio_group *kvmppc_vfio_group_get_external_user(struct file *filep)
+{
+	struct vfio_group *ret;
+	struct vfio_group * (*proc)(struct file *) =
+			symbol_get(vfio_group_get_external_user);
+	if (!proc)
+		return NULL;
+
+	ret = proc(filep);
+	symbol_put(vfio_group_get_external_user);
+
+	return ret;
+}
+
+void kvmppc_vfio_group_put_external_user(struct vfio_group *group)
+{
+	void (*proc)(struct vfio_group *) =
+			symbol_get(vfio_group_put_external_user);
+	if (!proc)
+		return;
+
+	proc(group);
+	symbol_put(vfio_group_put_external_user);
+}
+
+int kvmppc_vfio_external_user_iommu_id(struct vfio_group *group)
+{
+	int ret;
+	int (*proc)(struct vfio_group *) =
+			symbol_get(vfio_external_user_iommu_id);
+	if (!proc)
+		return -EINVAL;
+
+	ret = proc(group);
+	symbol_put(vfio_external_user_iommu_id);
+
+	return ret;
+}
+
 static long kvmppc_stt_npages(unsigned long window_size)
 {
 	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
-- 
1.8.4.rc4
