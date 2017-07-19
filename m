Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4NP00NpzDrLv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:44 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 08/24] powerpc/mm: Move error_code checks for bad faults
 earlier
Date: Wed, 19 Jul 2017 14:49:30 +1000
Message-Id: <20170719044946.22030-8-benh@kernel.crashing.org>
In-Reply-To: <20170719044946.22030-1-benh@kernel.crashing.org>
References: <20170719044946.22030-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There's no point looking for the VMA etc.. when we already know
we are going to fail.

This adds some code to set "code" for the si_code but that will
be gone in subsequent patches.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 26ec0dd4f419..e2f3144a48b9 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -237,6 +237,26 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(debugger_fault_handler(regs)))
 		goto bail;
 
+#if defined(CONFIG_6xx)
+	if (error_code & 0x95700000) {
+		/* an error such as lwarx to I/O controller space,
+		   address matching DABR, eciwx, etc. */
+		code = SEGV_ACCERR;
+		goto bad_area_nosemaphore;
+	}
+#endif /* CONFIG_6xx */
+#if defined(CONFIG_8xx)
+        /* The MPC8xx seems to always set 0x80000000, which is
+         * "undefined".  Of those that can be set, this is the only
+         * one which seems bad.
+         */
+	if (error_code & 0x10000000) {
+                /* Guarded storage error. */
+		code = SEGV_ACCERR;
+		goto bad_area_nosemaphore;
+	}
+#endif /* CONFIG_8xx */
+
 	/*
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address.
@@ -351,21 +371,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 
 good_area:
 	code = SEGV_ACCERR;
-#if defined(CONFIG_6xx)
-	if (error_code & 0x95700000)
-		/* an error such as lwarx to I/O controller space,
-		   address matching DABR, eciwx, etc. */
-		goto bad_area;
-#endif /* CONFIG_6xx */
-#if defined(CONFIG_8xx)
-        /* The MPC8xx seems to always set 0x80000000, which is
-         * "undefined".  Of those that can be set, this is the only
-         * one which seems bad.
-         */
-	if (error_code & 0x10000000)
-                /* Guarded storage error. */
-		goto bad_area;
-#endif /* CONFIG_8xx */
 
 	if (is_exec) {
 		/*
-- 
2.13.3
