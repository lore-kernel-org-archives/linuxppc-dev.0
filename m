Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0113.hostedemail.com
 [216.40.44.113])
 by lists.ozlabs.org (Postfix) with ESMTP id BACAC1A0AF2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 10:54:00 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave04.hostedemail.com (Postfix) with ESMTP id AD0E4B19A9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 23:47:22 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 06/25] powerpc: Use bool function return values of true/false
 not 1/0
Date: Mon, 30 Mar 2015 16:46:04 -0700
Message-Id: <6d45a6e4596f0b282048fc4b8db9e7f7a19a46e3.1427759009.git.joe@perches.com>
In-Reply-To: <cover.1427759009.git.joe@perches.com>
References: <cover.1427759009.git.joe@perches.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the normal return values for bool functions

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/include/asm/dcr-native.h    | 2 +-
 arch/powerpc/include/asm/dma-mapping.h   | 4 ++--
 arch/powerpc/include/asm/kvm_book3s_64.h | 4 ++--
 arch/powerpc/sysdev/dcr.c                | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 7d2e623..4efc11d 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -31,7 +31,7 @@ typedef struct {
 
 static inline bool dcr_map_ok_native(dcr_host_native_t host)
 {
-	return 1;
+	return true;
 }
 
 #define dcr_map_native(dev, dcr_n, dcr_c) \
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 894d538..9103687 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -191,11 +191,11 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	struct dev_archdata *sd = &dev->archdata;
 
 	if (sd->max_direct_dma_addr && addr + size > sd->max_direct_dma_addr)
-		return 0;
+		return false;
 #endif
 
 	if (!dev->dma_mask)
-		return 0;
+		return false;
 
 	return addr + size - 1 <= *dev->dma_mask;
 }
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 2d81e20..2a244bf 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -335,7 +335,7 @@ static inline bool hpte_read_permission(unsigned long pp, unsigned long key)
 {
 	if (key)
 		return PP_RWRX <= pp && pp <= PP_RXRX;
-	return 1;
+	return true;
 }
 
 static inline bool hpte_write_permission(unsigned long pp, unsigned long key)
@@ -373,7 +373,7 @@ static inline bool slot_is_aligned(struct kvm_memory_slot *memslot,
 	unsigned long mask = (pagesize >> PAGE_SHIFT) - 1;
 
 	if (pagesize <= PAGE_SIZE)
-		return 1;
+		return true;
 	return !(memslot->base_gfn & mask) && !(memslot->npages & mask);
 }
 
diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index 2d8a101..121e26f 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -54,7 +54,7 @@ bool dcr_map_ok_generic(dcr_host_t host)
 	else if (host.type == DCR_HOST_MMIO)
 		return dcr_map_ok_mmio(host.host.mmio);
 	else
-		return 0;
+		return false;
 }
 EXPORT_SYMBOL_GPL(dcr_map_ok_generic);
 
-- 
2.1.2
