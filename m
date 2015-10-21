Return-Path: <kda@linux-powerpc.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AD4BB1A03CA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 16:57:37 +1100 (AEDT)
Received: from mail-lb0-f179.google.com (mail-lb0-f179.google.com
 [209.85.217.179])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9A1914076E
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2015 16:57:36 +1100 (AEDT)
Received: by lbbwb3 with SMTP id wb3so30575290lbb.1
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Oct 2015 22:57:33 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@ozlabs.org,
 Denis Kirjanov <kda@linux-powerpc.org>
Subject: [PATCH] powerpc/msi: fix section mismatch warning
Date: Wed, 21 Oct 2015 08:56:44 +0300
Message-Id: <1445407004-6439-1-git-send-email-kda@linux-powerpc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Building with CONFIG_DEBUG_SECTION_MISMATCH
gives the following warning:

WARNING: vmlinux.o(.text+0x41fa8): Section mismatch in reference from
the function .msi_bitmap_alloc() to the function
.init.text:.memblock_virt_alloc_try_nid()
The function .msi_bitmap_alloc() references
the function __init .memblock_virt_alloc_try_nid().
This is often because .msi_bitmap_alloc lacks a __init
annotation or the annotation of .memblock_virt_alloc_try_nid is wrong.

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/include/asm/msi_bitmap.h | 2 +-
 arch/powerpc/sysdev/msi_bitmap.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include/asm/msi_bitmap.h
index 1ec7125..fbd3424 100644
--- a/arch/powerpc/include/asm/msi_bitmap.h
+++ b/arch/powerpc/include/asm/msi_bitmap.h
@@ -29,7 +29,7 @@ void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq);
 
 int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp);
 
-int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
+int __init_refok msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 		     struct device_node *of_node);
 void msi_bitmap_free(struct msi_bitmap *bmp);
 
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
index 1a826f3..ed5234e 100644
--- a/arch/powerpc/sysdev/msi_bitmap.c
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -112,7 +112,7 @@ int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp)
 	return 0;
 }
 
-int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
+int __init_refok msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
 		     struct device_node *of_node)
 {
 	int size;
-- 
2.4.0
