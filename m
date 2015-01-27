Return-Path: <B43198@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0142.outbound.protection.outlook.com [65.55.169.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 970641A0548
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 02:35:00 +1100 (AEDT)
From: Bogdan Purcareata <bogdan.purcareata@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] powerpc/mpic: Add DT option to skip readback after EOI
Date: Tue, 27 Jan 2015 15:19:12 +0000
Message-ID: <1422371952-1126-1-git-send-email-bogdan.purcareata@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Bogdan Purcareata <bogdan.purcareata@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The readback acts as a synchronization mechanism in handling external
interrupts, making sure the core waits until EOI write completion. This is
required in certain scenarios, such as when the MPIC communicates with a PCI
device in posted write mode. If the device uses legacy interrupts, and the CPU
returns from the interrupt as soon as it fires the EOI write, there is a chance
to receive spurious interrupts because the line isn't deasserted yet.

This doesn't happen in an emulated environment, e.g. KVM openpic, therefore the
readback is not required. In order to satisfy both cases, make the readback
optional and configurable through the device tree.

Skipping the readback saves a MMIO trap per interrupt.

v2: updated commit message

Signed-off-by: Scott Wood <scottwood@freescale.com>
[add DT binding, update commit message]
Signed-off-by: Bogdan Purcareata <bogdan.purcareata@freescale.com>
---
 Documentation/devicetree/bindings/powerpc/fsl/mpic.txt | 13 +++++++++++++
 arch/powerpc/include/asm/mpic.h                        |  2 ++
 arch/powerpc/sysdev/mpic.c                             |  8 +++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
index dc57446..9789094 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
@@ -77,6 +77,19 @@ PROPERTIES
           in the global feature registers.  If specified, this field will
           override the value read from MPIC_GREG_FEATURE_LAST_SRC.
 
+  - mpic-eoi-no-readback
+      Usage: optional
+      Value type: <empty>
+      Definition: The presence of this property specifies that the
+          MPIC will not issue a readback when delivering the EOI for an
+          external interrupt. The readback operation is done by reading
+          the CPU WHOAMI register after writing to the CPU EOI register.
+          Originally, this was required due to the fact that the MPIC
+          operates at lower frequencies, or in scenarios where the MPIC
+          is connected through PCI with write posting. This is not the
+          case in an emulated environment (e.g. KVM guest), or in scenarios
+          where interrupts are not handled in a loop of get_irq() calls.
+
 INTERRUPT SPECIFIER DEFINITION
 
   Interrupt specifiers consists of 4 cells encoded as
diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 754f93d..e2a4146 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -386,6 +386,8 @@ extern struct bus_type mpic_subsys;
  * from the BRR1 register).
 */
 #define MPIC_FSL_HAS_EIMR		0x00010000
+/* Dont bother with readback after MPIC EOI */
+#define MPIC_EOI_NO_READBACK	0x00020000
 
 /* MPIC HW modification ID */
 #define MPIC_REGSET_MASK		0xf0000000
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index f3e8624..431f68e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -656,7 +656,9 @@ static inline struct mpic * mpic_from_irq_data(struct irq_data *d)
 static inline void mpic_eoi(struct mpic *mpic)
 {
 	mpic_cpu_write(MPIC_INFO(CPU_EOI), 0);
-	(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
+
+	if (!(mpic->flags & MPIC_EOI_NO_READBACK))
+		(void)mpic_cpu_read(MPIC_INFO(CPU_WHOAMI));
 }
 
 /*
@@ -1290,6 +1292,10 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		flags |= MPIC_SINGLE_DEST_CPU;
 	if (of_device_is_compatible(node, "fsl,mpic"))
 		flags |= MPIC_FSL | MPIC_LARGE_VECTORS;
+	if (of_get_property(node, "mpic-eoi-no-readback", NULL)) {
+		pr_debug("mpic: no readback activated");
+		flags |= MPIC_EOI_NO_READBACK;
+	}
 
 	mpic = kzalloc(sizeof(struct mpic), GFP_KERNEL);
 	if (mpic == NULL)
-- 
2.1.4
