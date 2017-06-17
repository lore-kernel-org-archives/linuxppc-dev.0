Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqNcr633tzDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 13:53:16 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id o21so13735628qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 20:53:16 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC v2 07/12] powerpc: Macro the mask used for checking DSI exception
Date: Fri, 16 Jun 2017 20:52:39 -0700
Message-Id: <1497671564-20030-8-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Replace the magic number used to check for DSI exception
with a meaningful value.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/reg.h       | 9 ++++++++-
 arch/powerpc/kernel/exceptions-64s.S | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e50e47..2dcb8a1 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -272,16 +272,23 @@
 #define SPRN_DAR	0x013	/* Data Address Register */
 #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
 #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
+#define   DSISR_BIT32		0x80000000	/* not defined */
 #define   DSISR_NOHPTE		0x40000000	/* no translation found */
+#define   DSISR_PAGEATTR_CONFLT	0x20000000	/* page attribute conflict */
+#define   DSISR_BIT35		0x10000000	/* not defined */
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
 #define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
 #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
-#define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
 #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
+#define   DSISR_BIT43		0x00100000	/* not defined */
 #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
 #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
 #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
+#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 | \
+				DSISR_PAGEATTR_CONFLT | \
+				DSISR_BADACCESS |       \
+				DSISR_BIT43)
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae418b8..3fd0528 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1411,7 +1411,7 @@ USE_TEXT_SECTION()
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 #ifdef CONFIG_PPC_STD_MMU_64
-	andis.	r0,r4,0xa410		/* weird error? */
+	andis.	r0,r4,DSISR_PAGE_FAULT_MASK@h
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	andis.  r0,r4,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
-- 
1.8.3.1
