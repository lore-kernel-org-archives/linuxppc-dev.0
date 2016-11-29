Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSW7414yBzDw7J
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 15:40:00 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 3so15099175pgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Nov 2016 20:40:00 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/4] powerpc/64: place sfpr section explicitly with the linker
 script
Date: Tue, 29 Nov 2016 15:39:39 +1100
Message-Id: <20161129043942.13848-2-npiggin@gmail.com>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 861f4e1..f710d15 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -93,6 +93,14 @@ SECTIONS
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
2.10.2
