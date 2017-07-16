Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CNR4bkszDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 13:59:19 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id a66so16022672qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 20:59:19 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Subject: [RFC v6 31/62] powerpc: Handle exceptions caused by pkey violation
Date: Sat, 15 Jul 2017 20:56:33 -0700
Message-Id: <1500177424-13695-32-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Handle Data and  Instruction exceptions caused by memory
protection-key.

The CPU will detect the key fault if the HPTE is already
programmed with the key.

However if the HPTE is not  hashed, a key fault will not
be detected by the  hardware. The   software will detect
pkey violation in such a case.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/reg.h |    3 ++-
 arch/powerpc/mm/fault.c        |   21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index ee04bc0..b7cbc8c 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -286,7 +286,8 @@
 #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
 #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
 #define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 | DSISR_PAGEATTR_CONFLT | \
-				DSISR_BADACCESS | DSISR_DABRMATCH | DSISR_BIT43)
+				DSISR_BADACCESS | DSISR_KEYFAULT | \
+				DSISR_DABRMATCH | DSISR_BIT43)
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3a7d580..ea74fe2 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -261,6 +261,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 #endif
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (error_code & DSISR_KEYFAULT) {
+		code = SEGV_PKUERR;
+		goto bad_area_nosemaphore;
+	}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
@@ -441,6 +448,20 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 #endif /* CONFIG_PPC_STD_MMU */
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
+			is_exec, 0)) {
+		code = SEGV_PKUERR;
+		goto bad_area;
+	}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
+
+	/* handle_mm_fault() needs to know if its a instruction access
+	 * fault.
+	 */
+	if (is_exec)
+		flags |= FAULT_FLAG_INSTRUCTION;
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
-- 
1.7.1
