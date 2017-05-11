Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNyRF3q8NzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 01:57:13 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u187so4041856pgb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 08:57:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/5] powerpc/64: place sfpr section explicitly with the linker
 script
Date: Fri, 12 May 2017 01:56:48 +1000
Message-Id: <20170511155652.8287-2-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 2f793be3d2b1..bcfda21c3179 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -115,6 +115,14 @@ SECTIONS
 		KPROBES_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
+		/*
+		 * -Os builds call FP save/restore functions. The powerpc64
+		 * linker generates those on demand in the .sfpr section.
+		 * .sfpr gets placed at the beginning of a group of input
+		 * sections, which can break start-of-text offset if it is
+		 * included with the main text sections, so put it by itself.
+		 */
+		*(.sfpr);
 		MEM_KEEP(init.text)
 		MEM_KEEP(exit.text)
 
-- 
2.11.0
