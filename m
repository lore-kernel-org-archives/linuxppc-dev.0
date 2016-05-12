Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r59k40kpdzDqZh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 21:29:16 +1000 (AEST)
From: Thomas Huth <thuth@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc: Use privileged SPR number for MMCR2
Date: Thu, 12 May 2016 13:29:11 +0200
Message-Id: <1463052551-18206-1-git-send-email-thuth@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We are already using the privileged versions of MMCR0, MMCR1
and MMCRA in the kernel, so for MMCR2, we should better use
the privileged versions, too, to be consistent.

Suggested-by: Paul Mackerras <paulus@ozlabs.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/powerpc/include/asm/reg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index ce3e1b7..166d863 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -715,7 +715,7 @@
 #define   MMCR0_FCWAIT	0x00000002UL /* freeze counter in WAIT state */
 #define   MMCR0_FCHV	0x00000001UL /* freeze conditions in hypervisor mode */
 #define SPRN_MMCR1	798
-#define SPRN_MMCR2	769
+#define SPRN_MMCR2	785
 #define SPRN_MMCRA	0x312
 #define   MMCRA_SDSYNC	0x80000000UL /* SDAR synced with SIAR */
 #define   MMCRA_SDAR_DCACHE_MISS 0x40000000UL
-- 
1.8.3.1
