Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCR4l2hckzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 16:52:23 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
 stewart@linux.vnet.ibm.com, bsingharora@gmail.com, mpe@ellerman.id.au,
 Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: Initialise nest mmu
Date: Mon, 15 Aug 2016 16:51:59 +1000
Message-Id: <1471243919-18362-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER9 contains an off core mmu called the nest mmu (NMMU). This is
used by other hardware units on the chip to translate virtual
addresses into real addresses. The unit attempting an address
translation provides the majority of the context required for the
translation request except for the base address of the partition table
(ie. the PTCR) which needs to be programmed into the NMMU.

This patch adds a call to OPAL to set the PTCR for the nest mmu in
opal_init().

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---

This patch depends on a new OPAL call which has yet to be added to
skiboot, although the patch to do so has been posted to
http://patchwork.ozlabs.org/patch/659106/

 arch/powerpc/include/asm/opal-api.h            | 3 ++-
 arch/powerpc/include/asm/opal.h                | 1 +
 arch/powerpc/platforms/powernv/opal-wrappers.S | 1 +
 arch/powerpc/platforms/powernv/opal.c          | 3 +++
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 0e2e57b..a0aa285 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -167,7 +167,8 @@
 #define OPAL_INT_EOI				124
 #define OPAL_INT_SET_MFRR			125
 #define OPAL_PCI_TCE_KILL			126
-#define OPAL_LAST				126
+#define OPAL_NMMU_SET_PTCR			127
+#define OPAL_LAST				127

 /* Device tree flags */

diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index ee05bd2..433df5e 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -228,6 +228,7 @@ int64_t opal_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 int64_t opal_rm_pci_tce_kill(uint64_t phb_id, uint32_t kill_type,
 			     uint32_t pe_num, uint32_t tce_size,
 			     uint64_t dma_addr, uint32_t npages);
+int64_t opal_nmmu_set_ptcr(uint64_t chip_id, uint64_t ptcr);

 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 3d29d40..a955649 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -308,3 +308,4 @@ OPAL_CALL(opal_int_eoi,				OPAL_INT_EOI);
 OPAL_CALL(opal_int_set_mfrr,			OPAL_INT_SET_MFRR);
 OPAL_CALL(opal_pci_tce_kill,			OPAL_PCI_TCE_KILL);
 OPAL_CALL_REAL(opal_rm_pci_tce_kill,		OPAL_PCI_TCE_KILL);
+OPAL_CALL(opal_nmmu_set_ptcr,			OPAL_NMMU_SET_PTCR);
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 8b4fc68..b533245 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -762,6 +762,9 @@ static int __init opal_init(void)
 	/* Initialise OPAL kmsg dumper for flushing console on panic */
 	opal_kmsg_init();

+	/* Update partition table control register on all Nest MMUs */
+	opal_nmmu_set_ptcr(-1UL, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
+
 	return 0;
 }
 machine_subsys_initcall(powernv, opal_init);
--
2.1.4
