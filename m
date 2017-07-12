Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6krv2k7jzDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 13:26:55 +1000 (AEST)
Message-ID: <1499830007.2865.36.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Hande page faults for bad paste and bad AMO
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Date: Wed, 12 Jul 2017 13:26:47 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On POWER9 and bad paste instruction (targeting the wrong memory
type) or an invalid opcode in an AMO (atomic memory operation)
will result in specific DSISR bits to be set.

We currently don't understand those bits and thus just "hang"
the process taking constant page faults.

Additionally in the case of paste, it appears that we don't
always get a valid DAR value when the error is a wrong memory
type.

So we need to test those errors early in do_page_fault(),
I chose to generate a SIGBUS which is more correct than a SIGSEGV.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0266c664014a..5dfce2022f74 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -337,6 +337,21 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 #endif /* CONFIG_PPC_ICSWX */
 
+#ifdef CONFIG_PPC_STD_MMU_64
+	/*
+	 * These faults indicate a copy/paste on an invalid memory type
+	 * or an incorrect AMO operation. They have been observed as not
+	 * properly updating the DAR, so handle them early
+	 */
+	if (error_code & (DSISR_BAD_COPYPASTE | DSISR_BAD_AMO)) {
+		if (user_mode(regs))
+			_exception(SIGBUS, regs, BUS_OBJERR, address);
+		else
+			rc = SIGBUS;
+		goto bail;
+	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
+
 	if (notify_page_fault(regs))
 		goto bail;
 
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e50e47375d6..71f524f2b109 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -282,6 +282,8 @@
 #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
 #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
 #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
+#define   DSISR_BAD_COPYPASTE   0x00000008      /* Copy/Paste on wrong mem type */
+#define   DSISR_BAD_AMO		0x00000004	/* Incorrect AMO opcode */
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
