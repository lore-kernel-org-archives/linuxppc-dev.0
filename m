Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQdW16LvPzDvsS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Nov 2016 14:20:45 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id 144so3601815pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 19:20:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: place .text immediately following .head.text
Date: Sat, 26 Nov 2016 14:20:31 +1100
Message-Id: <20161126032031.12765-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Do not introduce any additional alignment. Placement of text section
will be set by fixed section macros. Without this, output section
alignment defaults to 4096, which makes BookE text section start at
0x1000 when it is expected to start at 0x100.

This was introduced by 57f266497d81 ("powerpc: Use gas sections for
arranging exception vectors") and was caught with the scripted head
section checker (not yet merged).

Fixes: 57f266497d81
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 8295f51..7394b77 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -94,8 +94,17 @@ SECTIONS
 	 * detected, and will result in a crash at boot due to offsets being
 	 * wrong.
 	 */
+#ifdef CONFIG_PPC64
+	/*
+	 * BLOCK(0) overrides the default output section alignment because
+	 * this needs to start right after .head.text in order for fixed
+	 * section placement to work.
+	 */
+	.text BLOCK(0) : AT(ADDR(.text) - LOAD_OFFSET) {
+#else
 	.text : AT(ADDR(.text) - LOAD_OFFSET) {
 		ALIGN_FUNCTION();
+#endif
 		/* careful! __ftr_alt_* sections need to be close to .text */
 		*(.text .fixup __ftr_alt_* .ref.text)
 		SCHED_TEXT
-- 
2.10.2
