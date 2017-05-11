Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNyRQ4pjSzDqNM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:57:22 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 64so4040072pgb.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:57:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 4/5] powerpc/64: do not create new section for save/restore
 functions
Date: Fri, 12 May 2017 01:56:51 +1000
Message-Id: <20170511155652.8287-5-npiggin@gmail.com>
In-Reply-To: <20170511155652.8287-1-npiggin@gmail.com>
References: <20170511155652.8287-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to create a new section for these. Consolidate with
32-bit and just use .text.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/crtsavres.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 18af0b3d3eb2..7e5e1c28e56a 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -44,10 +44,10 @@
 
 #ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 
-#ifndef CONFIG_PPC64
-
 	.section ".text"
 
+#ifndef CONFIG_PPC64
+
 /* Routines for saving integer registers, called by the compiler.  */
 /* Called with r11 pointing to the stack header word of the caller of the */
 /* function, just beyond the end of the integer save area.  */
@@ -314,8 +314,6 @@ _GLOBAL(_restvr_31)
 
 #else /* CONFIG_PPC64 */
 
-	.section ".text.save.restore","ax",@progbits
-
 .globl	_savegpr0_14
 _savegpr0_14:
 	std	r14,-144(r1)
-- 
2.11.0
