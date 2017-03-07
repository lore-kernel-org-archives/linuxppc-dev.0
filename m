Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdCvw2vfKzDqXg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 10:45:48 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: amodra@gmail.com,
	anton@samba.org
Subject: [PATCH] powerpc/boot: Fix zImage TOC alignment
Date: Wed,  8 Mar 2017 10:40:21 +1100
Message-Id: <1488930021-20227-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent toolchains force the TOC to be 256 byte aligned. We need to
enforce this alignment in the zImage linker script, otherwise pointers
to our TOC variables (__toc_start) could be incorrect. If the actual
start of the TOC and __toc_start don't have the same value we crash
early in the zImage wrapper.

Cc: stable@vger.kernel.org
Suggested-by: Alan Modra <amodra@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/boot/zImage.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/boot/zImage.lds.S b/arch/powerpc/boot/zImage.lds.S
index 861e72109df2..f080abfc2f83 100644
--- a/arch/powerpc/boot/zImage.lds.S
+++ b/arch/powerpc/boot/zImage.lds.S
@@ -68,6 +68,7 @@ SECTIONS
   }
 
 #ifdef CONFIG_PPC64_BOOT_WRAPPER
+  . = ALIGN(256);
   .got :
   {
     __toc_start = .;
-- 
2.7.4
