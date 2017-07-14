Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x87Gg350LzDqg2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 19:50:35 +1000 (AEST)
Message-ID: <1500021087.2865.86.camel@kernel.crashing.org>
Subject: [PATCH/RFC] powerpc: Better handle "error" type page faults on
 book3s64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>, "Aneesh Kumar K
 . V" <aneesh.kumar@linux.vnet.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 14 Jul 2017 18:31:27 +1000
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

There are a number of conditions in the DSISR that represent
conditions for which there is no point looking for a VMA or
trying to update a PTE. In fact, POWER9 adds a few with bad
AMOs, bad "paste" instruction etc...

This improve our existing code to use symbolic constants for
all DSISR bits, properly avoid hash_page() for the new bits,
and handle both the old and new bits early in do_page_fault()

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--

This obsoletes 
[PATCH] powerpc: Hande page faults for bad paste and bad AMO

Note: We should further update 32-bit etc... to do something
similar, or even consolidate the code.

According to architectures back to 1.07 and 32-bit 6xx PEM,
those low DSISR bits are 0 on all other implementations, and
we do mask out the SRR1 bits on instruction interrupts, so
I think such consolidation, at least for BookS should be trivial
but I will leave it as a separate patch.

---
 arch/powerpc/include/asm/reg.h       | 18 ++++++++++++++++++
 arch/powerpc/kernel/exceptions-64s.S |  6 ++++--
 arch/powerpc/mm/fault.c              | 21 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e50e47..bf5f8ff 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -272,16 +272,34 @@
 #define SPRN_DAR	0x013	/* Data Address Register */
 #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
 #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
+#define   DSISR_BAD_DIRECT_ST	0x80000000	/* Direct store error (obsolete) */
 #define   DSISR_NOHPTE		0x40000000	/* no translation found */
+#define   DSISR_ATT_CONFLICT	0x20000000	/* Attribute conflicts (P9) */
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
 #define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
 #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
 #define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
 #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
+#define   DSISR_BAD_EXT_CTRL	0x00100000	/* External control error (obsolete) */
 #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
 #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
 #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
+#define   DSISR_BAD_COPYPASTE   0x00000008      /* Copy/Paste on wrong mem type */
+#define   DSISR_BAD_AMO		0x00000004	/* Incorrect AMO opcode */
+#define   DSISR_BAD_CI_LDST	0x00000002	/* CI load/store with DR=1 or in G=0 HV space */
+
+/* Don't bother going to hash_page for any of these */
+#define   DSISR_DONT_HASH	(DSISR_BAD_DIRECT_ST |	\
+				 DSISR_ATT_CONFLICT |	\
+				 DSISR_BADACCESS |	\
+				 DSISR_DABRMATCH |	\
+				 DSISR_BAD_EXT_CTRL |   \
+				 DSISR_UNSUPP_MMU |	\
+				 DSISR_BAD_COPYPASTE |	\
+				 DSISR_BAD_AMO |	\
+				 DSISR_BAD_CI_LDST)
+
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5204bd6..58ad8ae 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1413,8 +1413,10 @@ USE_TEXT_SECTION()
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 #ifdef CONFIG_PPC_STD_MMU_64
-	andis.	r0,r4,0xa450		/* weird error? */
-	bne-	handle_page_fault	/* if not, try to insert a HPTE */
+	lis	r0,DSISR_DONT_HASH@h
+	ori	r0,r0,DSISR_DONT_HASH@l
+	and.	r0,r0,r4
+	bne-	handle_page_fault
 	CURRENT_THREAD_INFO(r11, r1)
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
 	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 0266c66..e55cb5c 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -337,6 +337,27 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 #endif /* CONFIG_PPC_ICSWX */
 
+#ifdef CONFIG_PPC_STD_MMU_64
+	/*
+	 * These faults indicate various errors that can't be recovered
+	 * by updating the PTE, there is no point handling them any later
+	 * than here. I also noticed in some case the DAR isn't being set
+	 * propertly (DSISR_BAD_COPYPASTE for example).
+	 */
+	if (error_code & (DSISR_ATT_CONFLICT |
+			  DSISR_BADACCESS |
+			  DSISR_UNSUPP_MMU |
+			  DSISR_BAD_COPYPASTE |
+			  DSISR_BAD_AMO |
+			  DSISR_BAD_CI_LDST)) {
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
 
