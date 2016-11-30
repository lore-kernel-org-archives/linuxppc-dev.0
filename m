Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tT6RR2RcZzDvnY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 15:11:15 +1100 (AEDT)
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tT6RQ1yhzz9tl4
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2016 15:11:14 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id x23so986pgx.3
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Nov 2016 20:11:14 -0800 (PST)
To: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2] KVM/PPC Patch for KVM issue in real mode
Cc: Paul Mackerras <paulus@samba.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Radim <rkrcmar@redhat.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <20a3e138-8a6e-6ad8-b9ba-ec8332f011a5@gmail.com>
Date: Wed, 30 Nov 2016 15:11:06 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Some KVM functions for book3s_hv are called in real mode.
In real mode the top 4 bits of the address space are ignored,
hence an address beginning with 0xc0000000+offset is the
same as 0xd0000000+offset. The issue was observed when
a kvm memslot resolution lead to random values when
access from kvmppc_h_enter(). The issue is hit if the
KVM host is running with a page size of 4K, since
kvzalloc() looks at size < PAGE_SIZE. On systems with
64K the issue is not observed easily, it largely depends
on the size of the structure being allocated.

The proposed fix moves all KVM allocations for book3s_hv
to kzalloc() until all structures used in real mode are
audited. For safety allocations are moved to kmalloc
space. The impact is a large allocation on systems with
4K page size.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 Changelog v2:
   Fix build failures reported by the kbuild test robot
   http://www.spinics.net/lists/kvm/msg141727.html

 arch/powerpc/include/asm/kvm_host.h | 19 +++++++++++++++++++
 include/linux/kvm_host.h            | 11 +++++++++++
 virt/kvm/kvm_main.c                 |  2 +-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index f15713a..53f5172 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -734,6 +734,25 @@ struct kvm_vcpu_arch {
 #define __KVM_HAVE_ARCH_WQP
 #define __KVM_HAVE_CREATE_DEVICE
 
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+#define __KVM_HAVE_ARCH_VZALLOC_OVERRIDE
+
+/*
+ * KVM uses some of these data structures -- the ones
+ * from kvzalloc() in real mode. If the data structure
+ * happens to come from a vmalloc'd range then its access
+ * in real mode will lead to problems due to the aliasing
+ * issue - (top 4 bits are ignore).
+ * A 0xd000+offset will point to a 0xc000+offset in realmode
+ * Hence we want our data structures from come from kmalloc'd
+ * regions, so that we don't have these aliasing issues
+ */
+static inline void *kvm_arch_vzalloc(unsigned long size)
+{
+	return kzalloc(size, GFP_KERNEL);
+}
+#endif
+
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 01c0b9c..0c88af5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -19,6 +19,7 @@
 #include <linux/preempt.h>
 #include <linux/msi.h>
 #include <linux/slab.h>
+#include <linux/vmalloc.h>
 #include <linux/rcupdate.h>
 #include <linux/ratelimit.h>
 #include <linux/err.h>
@@ -793,6 +794,16 @@ static inline bool kvm_arch_has_noncoherent_dma(struct kvm *kvm)
 	return false;
 }
 #endif
+
+#ifdef __KVM_HAVE_ARCH_VZALLOC_OVERRIDE
+static void *kvm_arch_vzalloc(unsigned long size);
+#else
+static inline void *kvm_arch_vzalloc(unsigned long size)
+{
+	return vzalloc(size);
+}
+#endif
+
 #ifdef __KVM_HAVE_ARCH_ASSIGNED_DEVICE
 void kvm_arch_start_assignment(struct kvm *kvm);
 void kvm_arch_end_assignment(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fbf04c0..57e3dca 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -689,7 +689,7 @@ static struct kvm *kvm_create_vm(unsigned long type)
 void *kvm_kvzalloc(unsigned long size)
 {
 	if (size > PAGE_SIZE)
-		return vzalloc(size);
+		return kvm_arch_vzalloc(size);
 	else
 		return kzalloc(size, GFP_KERNEL);
 }
-- 
2.5.5
