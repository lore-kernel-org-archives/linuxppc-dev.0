Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 3F01AB7C3A
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Oct 2009 02:47:37 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm@vger.kernel.org
Subject: [PATCH 19/27] Export symbols for KVM module
Date: Fri, 30 Oct 2009 16:47:19 +0100
Message-Id: <1256917647-6200-20-git-send-email-agraf@suse.de>
In-Reply-To: <1256917647-6200-1-git-send-email-agraf@suse.de>
References: <1256917647-6200-1-git-send-email-agraf@suse.de>
Cc: Kevin Wolf <kwolf@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	Hollis Blanchard <hollisb@us.ibm.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Avi Kivity <avi@redhat.com>, bphilips@suse.de,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We want to be able to build KVM as a module. To enable us doing so, we
need some more exports from core Linux parts.

This patch exports all functions and variables that are required for KVM.

Signed-off-by: Alexander Graf <agraf@suse.de>

---

v3 -> v4:

  - don't export switch_slb
  - don't export init_context
  - don't export mm_alloc
---
 arch/powerpc/kernel/ppc_ksyms.c |    3 ++-
 arch/powerpc/kernel/time.c      |    1 +
 arch/powerpc/mm/hash_utils_64.c |    2 ++
 3 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c8b27bb..baf778c 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -163,11 +163,12 @@ EXPORT_SYMBOL(screen_info);
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
-EXPORT_SYMBOL(tb_ticks_per_jiffy);
 EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(cacheable_memzero);
 #endif
 
+EXPORT_SYMBOL(tb_ticks_per_jiffy);
+
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(switch_mmu_context);
 #endif
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 92dc844..e05f6af 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -268,6 +268,7 @@ void account_system_vtime(struct task_struct *tsk)
 	per_cpu(cputime_scaled_last_delta, smp_processor_id()) = deltascaled;
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(account_system_vtime);
 
 /*
  * Transfer the user and system times accumulated in the paca
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1ade7eb..2b2a4aa 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -92,6 +92,7 @@ struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 struct hash_pte *htab_address;
 unsigned long htab_size_bytes;
 unsigned long htab_hash_mask;
+EXPORT_SYMBOL_GPL(htab_hash_mask);
 int mmu_linear_psize = MMU_PAGE_4K;
 int mmu_virtual_psize = MMU_PAGE_4K;
 int mmu_vmalloc_psize = MMU_PAGE_4K;
@@ -102,6 +103,7 @@ int mmu_io_psize = MMU_PAGE_4K;
 int mmu_kernel_ssize = MMU_SEGSIZE_256M;
 int mmu_highuser_ssize = MMU_SEGSIZE_256M;
 u16 mmu_slb_size = 64;
+EXPORT_SYMBOL_GPL(mmu_slb_size);
 #ifdef CONFIG_HUGETLB_PAGE
 unsigned int HPAGE_SHIFT;
 #endif
-- 
1.6.0.2
