Return-Path: <glikely@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.200])
	by ozlabs.org (Postfix) with ESMTP id D530E67FC8
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 06:16:18 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id 12so172696nzp
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Aug 2005 13:16:16 -0700 (PDT)
Date: Wed, 17 Aug 2005 14:05:47 -0600
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050817200547.GA21017@siegfried.thelikelysolution.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Grant Likely <glikely@gmail.com>
Subject: [PATCH] Fix for TLB errata on early Xilinx Virtex-II Pro silicon
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Early versions of the Xilinx Virtex-II Pro have a TLB errata where
only even numbered TLB entries work correctly.  Occurs on chips where
PVR == 0x20010820 || 0x20010860

See Record #14052, solution #12 in the Xilinx answers database
http://www.xilinx.com/xlnx/xil_ans_display.jsp?getPagePath=14052

This patch adds a config option to use only even TLB entries on the V2Pro
It also makes a trivial change to the Kconfig so that Xilinx options depend
on VIRTEX_II_PRO instead of XILINX_ML300

Signed-off-by: Grant Likely <grant.likely@gdcanada.com>
---

 arch/ppc/kernel/head_4xx.S     |   11 +++++++++++
 arch/ppc/platforms/4xx/Kconfig |   28 ++++++++++++++++++++++------
 2 files changed, 33 insertions(+), 6 deletions(-)

322a82cd190a777e4ebe728cad2a2a3759039260
diff --git a/arch/ppc/kernel/head_4xx.S b/arch/ppc/kernel/head_4xx.S
--- a/arch/ppc/kernel/head_4xx.S
+++ b/arch/ppc/kernel/head_4xx.S
@@ -769,7 +769,11 @@ finish_tlb_load:
        /* load the next available TLB index.
        */
        lwz     r9, tlb_4xx_index@l(0)
+#if defined(CONFIG_VIRTEX_II_PRO_TLB_FIX)
+       addi    r9, r9, 2
+#else
        addi    r9, r9, 1
+#endif
        andi.   r9, r9, (PPC4XX_TLB_SIZE-1)
        stw     r9, tlb_4xx_index@l(0)

@@ -926,7 +930,14 @@ initial_mmu:
        clrrwi  r3,r3,10                /* Mask off the effective page number */        ori     r3,r3,(TLB_VALID | TLB_PAGESZ(PAGESZ_16M))

+#if defined(CONFIG_VIRTEX_II_PRO_TLB_FIX)
+       /* Odd numbered TLB slots are broken on Xilinx V2Pro processors
+        * where PVR = 20010820 | 20010860
+        */
+        li      r0,62                    /* TLB slot 62 */
+#else
         li      r0,63                    /* TLB slot 63 */
+#endif

        tlbwe   r4,r0,TLB_DATA          /* Load the data portion of the entry */        tlbwe   r3,r0,TLB_TAG           /* Load the tag portion of the entry */
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -161,11 +161,6 @@ config IBM_OCP
        depends on ASH || BAMBOO || BUBINGA || CPCI405 || EBONY || EP405 || LUAN || OCOTEA || REDWOOD_5 || REDWOOD_6 || SYCAMORE || WALNUT
        default y

-config XILINX_OCP
-       bool
-       depends on XILINX_ML300
-       default y
-
 config IBM_EMAC4
        bool
        depends on 440GX || 440SP
@@ -201,6 +196,27 @@ config VIRTEX_II_PRO
        depends on XILINX_ML300
        default y

+config VIRTEX_II_PRO_TLB_FIX
+       bool "Virtex-II Pro TLB bugfix"
+       depends on VIRTEX_II_PRO
+       default n
+       help
+         Early versions of the Xilinx Virtex-II Pro have a TLB errata where
+         only even numbered TLB entries work correctly.  Say Y here if
+         PVR == 0x20010820 || 0x20010860, or if your board crashes early
+         after enabling the MMU
+
+         See Record #14052, solution #12 in the Xilinx answers database
+         http://www.xilinx.com/xlnx/xil_ans_display.jsp?getPagePath=14052
+
+         It is safe to say Y here, but there is a performance impact.
+         Say N if unsure.
+
+config XILINX_OCP
+       bool
+       depends on VIRTEX_II_PRO
+       default y
+
 config STB03xxx
        bool
        depends on REDWOOD_5 || REDWOOD_6
@@ -208,7 +224,7 @@ config STB03xxx

 config EMBEDDEDBOOT
        bool
-       depends on EP405 || XILINX_ML300
+       depends on EP405 || VIRTEX_II_PRO
        default y

 config IBM_OPENBIOS
