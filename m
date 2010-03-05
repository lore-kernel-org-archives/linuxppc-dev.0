Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 13:43:59 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204359.18424.11697.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 11/13] powerpc/476: Software workaround to fix dcr read/write
	sequencing.
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: Software workaround to fix dcr read/write sequencing.

From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>

Copy the register containing the dcr address to a spr before mfdcrx or
mtdcrx instruction.  SPRN_SPRG_WSCRATCH_CRIT seems safe enough to use
as a dummy register, as it is only otherwise used by critical interrupts,
and we don't care if what we write is overwritten.

Ideally, would only do this when CPU_FTR_476_DD1_1 is set, but I'm not
getting the feature macros working in inlined assembler.  The dummy store
is pretty cheap though, so I'm doing it unconditionally for 47x.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/dcr-native.h |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/include/asm/dcr-native.h b/arch/powerpc/include/asm/dcr-native.h
index 7d2e623..768ce50 100644
--- a/arch/powerpc/include/asm/dcr-native.h
+++ b/arch/powerpc/include/asm/dcr-native.h
@@ -50,14 +50,34 @@ extern unsigned int __mfdcr(unsigned int reg);
 static inline unsigned int mfdcrx(unsigned int reg)
 {
 	unsigned int ret;
-	asm volatile(".long 0x7c000206 | (%0 << 21) | (%1 << 16)"
+	asm volatile(
+#ifdef CONFIG_PPC_47x
+		/*
+		 * Workaround: move reg to an spr prior to mfdcrx instruction
+		 */
+		     /* __stringify(BEGIN_FTR_SECTION) */
+		     "mtspr "__stringify(SPRN_SPRG_WSCRATCH_CRIT)",%1;"
+		     /* __stringify(END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)) */
+#endif
+		     ".long 0x7c000206 | (%0 << 21) | (%1 << 16)"
 		     : "=r" (ret) : "r" (reg));
 	return ret;
 }
 
 static inline void mtdcrx(unsigned int reg, unsigned int val)
 {
-	asm volatile(".long 0x7c000306 | (%0 << 21) | (%1 << 16)"
+	asm volatile(
+#ifdef CONFIG_PPC_47x
+		/*
+		 * Workaround: move reg to an spr prior to mtdcrx instruction.
+		 * (Would love to get the FTR_SECTION macros working for
+		 * inlined assembler -- shaggy)
+		 */
+		     /* __stringify(BEGIN_FTR_SECTION) */
+		     "mtspr "__stringify(SPRN_SPRG_WSCRATCH_CRIT)",%1;"
+		     /* __stringify(END_FTR_SECTION_IFSET(CPU_FTR_476_DD1_1)) */
+#endif
+		     ".long 0x7c000306 | (%0 << 21) | (%1 << 16)"
 		     : : "r" (val), "r" (reg));
 }
 

-- 
Dave Kleikamp
IBM Linux Technology Center
