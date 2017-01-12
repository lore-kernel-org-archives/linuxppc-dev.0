Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tzfzc11YBzDqVc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jan 2017 20:07:40 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org,
	kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org
Subject: [PATCH 05/18] powerpc/64: More definitions for POWER9
Date: Thu, 12 Jan 2017 20:07:13 +1100
Message-Id: <1484212046-29591-6-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
References: <1484212046-29591-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds definitions for bits in the DSISR register which are used
by POWER9 for various translation-related exception conditions, and
for some more bits in the partition table entry that will be needed
by KVM.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 12 +++++++++++-
 arch/powerpc/include/asm/reg.h           |  4 ++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index e8cbdc0..d827825 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -44,10 +44,20 @@ struct patb_entry {
 };
 extern struct patb_entry *partition_tb;
 
+/* Bits in patb0 field */
 #define PATB_HR		(1UL << 63)
-#define PATB_GR		(1UL << 63)
 #define RPDB_MASK	0x0ffffffffffff00fUL
 #define RPDB_SHIFT	(1UL << 8)
+#define RTS1_SHIFT	61		/* top 2 bits of radix tree size */
+#define RTS1_MASK	(3UL << RTS1_SHIFT)
+#define RTS2_SHIFT	5		/* bottom 3 bits of radix tree size */
+#define RTS2_MASK	(7UL << RTS2_SHIFT)
+#define RPDS_MASK	0x1f		/* root page dir. size field */
+
+/* Bits in patb1 field */
+#define PATB_GR		(1UL << 63)	/* guest uses radix; must match HR */
+#define PRTS_MASK	0x1f		/* process table size field */
+
 /*
  * Limit process table to PAGE_SIZE table. This
  * also limit the max pid we can support.
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 0d4531a..aa44a83 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -274,10 +274,14 @@
 #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
 #define   DSISR_NOHPTE		0x40000000	/* no translation found */
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
+#define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
 #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
 #define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
 #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
+#define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
+#define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
+#define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
-- 
2.7.4
