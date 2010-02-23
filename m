Return-Path: <shaggy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/booke: Fix a couple typos in the advanced ptrace code
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
In-Reply-To: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
References: <20100208215049.17930.8586.sendpatchset@norville.austin.ibm.com>
Content-Type: text/plain
Date: Tue, 23 Feb 2010 13:43:17 -0600
Message-Id: <1266954197.11207.20.camel@norville.austin.ibm.com>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/booke: Fix a couple typos in the advanced ptrace code

Found and fixed a couple typos in the advanced ptrace patches.
(These patches are currently in benh's next tree.)

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>

---

diff --git a/arch/powerpc/include/asm/reg_booke.h
b/arch/powerpc/include/asm/reg_booke.h
index 126cb05..96c2ce8 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -421,8 +421,8 @@
 /* Bit definitions related to the DBCR2. */
 #define DBCR2_DAC1US	0xC0000000	/* Data Addr Cmp 1 Sup/User   */
 #define DBCR2_DAC1ER	0x30000000	/* Data Addr Cmp 1 Eff/Real */
-#define DBCR2_DAC2US	0x00000000	/* Data Addr Cmp 2 Sup/User   */
-#define DBCR2_DAC2ER	0x00000000	/* Data Addr Cmp 2 Eff/Real */
+#define DBCR2_DAC2US	0x0C000000	/* Data Addr Cmp 2 Sup/User   */
+#define DBCR2_DAC2ER	0x03000000	/* Data Addr Cmp 2 Eff/Real */
 #define DBCR2_DAC12M	0x00800000	/* DAC 1-2 range enable */
 #define DBCR2_DAC12MM	0x00400000	/* DAC 1-2 Mask mode*/
 #define DBCR2_DAC12MX	0x00C00000	/* DAC 1-2 range eXclusive */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d9b0586..0efa2e3 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1070,7 +1070,7 @@ static int del_dac(struct task_struct *child, int
slot)
 		child->thread.dvc1 = 0;
 #endif
 	} else if (slot == 2) {
-		if (child->thread.dac1 == 0)
+		if (child->thread.dac2 == 0)
 			return -ENOENT;
 
 #ifdef CONFIG_PPC_ADV_DEBUG_DAC_RANGE
