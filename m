Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC4NQ2tFXzDrLk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 14:50:46 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 09/24] powerpc/mm: Overhaul handling of bad page faults
Date: Wed, 19 Jul 2017 14:49:31 +1000
Message-Id: <20170719044946.22030-9-benh@kernel.crashing.org>
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

A bad page fault is when the HW signals an error such as a bad
copy/paste, an AMO error, or some other type of error that will
not be fixed by updating the PTE.

Use a helper page_fault_is_bad() to check for bad page faults thus
removing the per-processor family open-coding in __do_page_fault()
and trigger a SIGBUS rather than a SIGSEGV which is more appropriate.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/mm/fault.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index e2f3144a48b9..4470500b4871 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -188,8 +188,16 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
  */
 #if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 #define page_fault_is_write(__err)	((__err) & ESR_DST)
+#define page_fault_is_bad(__err)	(0)
 #else
 #define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
+#if defined(CONFIG_8xx)
+#define page_fault_is_bad(__err)	((__err) & 0x10000000)
+#elif defined(CONFIG_PPC64)
+#define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_64S)
+#else
+#define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
+#endif
 #endif
 
 /*
@@ -237,25 +245,13 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 	if (unlikely(debugger_fault_handler(regs)))
 		goto bail;
 
-#if defined(CONFIG_6xx)
-	if (error_code & 0x95700000) {
-		/* an error such as lwarx to I/O controller space,
-		   address matching DABR, eciwx, etc. */
-		code = SEGV_ACCERR;
-		goto bad_area_nosemaphore;
-	}
-#endif /* CONFIG_6xx */
-#if defined(CONFIG_8xx)
-        /* The MPC8xx seems to always set 0x80000000, which is
-         * "undefined".  Of those that can be set, this is the only
-         * one which seems bad.
-         */
-	if (error_code & 0x10000000) {
-                /* Guarded storage error. */
-		code = SEGV_ACCERR;
-		goto bad_area_nosemaphore;
+	if (unlikely(page_fault_is_bad(error_code))) {
+		if (is_user)
+			_exception(SIGBUS, regs, BUS_OBJERR, address);
+		else
+			rc = SIGBUS;
+		goto bail;
 	}
-#endif /* CONFIG_8xx */
 
 	/*
 	 * The kernel should never take an execute fault nor should it
-- 
2.13.3
