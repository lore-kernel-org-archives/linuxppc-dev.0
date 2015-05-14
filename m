Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 75B331A03DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 14:45:43 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 amodra@gmail.com
Subject: [PATCH] powerpc: Align TOC to 256 bytes
Date: Thu, 14 May 2015 14:45:40 +1000
Message-Id: <1431578740-29745-1-git-send-email-anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Recent toolchains force the TOC to be 256 byte aligned. We need
to enforce this alignment in our linker script, otherwise pointers
to our TOC variables (__toc_start, __prom_init_toc_start) could
be incorrect.

If they are bad, we die a few hundred instructions into boot.

Cc: stable@vger.kernel.org
Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/vmlinux.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index f096e72..1db6851 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -213,6 +213,7 @@ SECTIONS
 		*(.opd)
 	}
 
+	. = ALIGN(256);
 	.got : AT(ADDR(.got) - LOAD_OFFSET) {
 		__toc_start = .;
 #ifndef CONFIG_RELOCATABLE
-- 
2.1.4
