Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 03F152C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jan 2014 12:32:59 +1100 (EST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH v4 1/3] powerpc: add barrier after writing kernel PTE
Date: Wed, 8 Jan 2014 19:32:41 -0600
Message-ID: <1389231163-11175-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no barrier between something like ioremap() writing to
a PTE, and returning the value to a caller that may then store the
pointer in a place that is visible to other CPUs.  Such callers
generally don't perform barriers of their own.

Even if callers of ioremap() and similar things did use barriers,
the most logical choise would be smp_wmb(), which is not
architecturally sufficient when BookE hardware tablewalk is used.  A
full sync is specified by the architecture.

For userspace mappings, OTOH, we generally already have an lwsync due
to locking, and if we occasionally take a spurious fault due to not
having a full sync with hardware tablewalk, it will not be fatal
because we will retry rather than oops.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v4: no change

 arch/powerpc/mm/pgtable_32.c |  1 +
 arch/powerpc/mm/pgtable_64.c | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 5b96017..343a87f 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -299,6 +299,7 @@ int map_page(unsigned long va, phys_addr_t pa, int flags)
 		set_pte_at(&init_mm, va, pg, pfn_pte(pa >> PAGE_SHIFT,
 						     __pgprot(flags)));
 	}
+	smp_wmb();
 	return err;
 }
 
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 02e8681..7551382 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -153,6 +153,18 @@ int map_kernel_page(unsigned long ea, unsigned long pa, int flags)
 		}
 #endif /* !CONFIG_PPC_MMU_NOHASH */
 	}
+
+#ifdef CONFIG_PPC_BOOK3E_64
+	/*
+	 * With hardware tablewalk, a sync is needed to ensure that
+	 * subsequent accesses see the PTE we just wrote.  Unlike userspace
+	 * mappings, we can't tolerate spurious faults, so make sure
+	 * the new PTE will be seen the first time.
+	 */
+	mb();
+#else
+	smp_wmb();
+#endif
 	return 0;
 }
 
-- 
1.8.3.2
