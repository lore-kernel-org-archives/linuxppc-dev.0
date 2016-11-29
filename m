Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSW796dcBzDwFY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:40:05 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so15098176pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 20:40:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/64: do not create new section for save/restore
 functions
Date: Tue, 29 Nov 2016 15:39:41 +1100
Message-Id: <20161129043942.13848-4-npiggin@gmail.com>
In-Reply-To: <20161129043942.13848-1-npiggin@gmail.com>
References: <20161129043942.13848-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to create a new section for these. Consolidate
with 32-bit and just use .text.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/lib/crtsavres.S | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 18af0b3..7e5e1c2 100644
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
2.10.2
