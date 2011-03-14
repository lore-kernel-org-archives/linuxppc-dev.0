Return-Path: <meador_inge@mentor.com>
From: Meador Inge <meador_inge@mentor.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/3] powerpc: factoring mpic cpu id fetching into a function
Date: Mon, 14 Mar 2011 15:01:07 -0500
Message-Id: <1300132867-4840-4-git-send-email-meador_inge@mentor.com>
In-Reply-To: <1300132867-4840-1-git-send-email-meador_inge@mentor.com>
References: <1300132867-4840-1-git-send-email-meador_inge@mentor.com>
Cc: devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following code snippet:

	unsigned int cpu = 0;
	if (mpic->flags & MPIC_PRIMARY)
		cpu = hard_smp_processor_id();

is seen in several places in the 'mpic.c' code.  This changeset factors
that pattern out into a helper function called 'mpic_processor_id'.

Signed-off-by: Meador Inge <meador_inge@mentor.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic.c |   31 ++++++++++++++-----------------
 1 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 112bff0..bf77eb7 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -147,6 +147,16 @@ static u32 mpic_infos[][MPIC_IDX_END] = {
 
 #endif /* CONFIG_MPIC_WEIRD */
 
+static inline unsigned int mpic_processor_id(struct mpic *mpic)
+{
+	unsigned int cpu = 0;
+
+	if (mpic->flags & MPIC_PRIMARY)
+		cpu = hard_smp_processor_id();
+
+	return cpu;
+}
+
 /*
  * Register accessor functions
  */
@@ -210,19 +220,14 @@ static inline void _mpic_ipi_write(struct mpic *mpic, unsigned int ipi, u32 valu
 
 static inline u32 _mpic_cpu_read(struct mpic *mpic, unsigned int reg)
 {
-	unsigned int cpu = 0;
+	unsigned int cpu = mpic_processor_id(mpic);
 
-	if (mpic->flags & MPIC_PRIMARY)
-		cpu = hard_smp_processor_id();
 	return _mpic_read(mpic->reg_type, &mpic->cpuregs[cpu], reg);
 }
 
 static inline void _mpic_cpu_write(struct mpic *mpic, unsigned int reg, u32 value)
 {
-	unsigned int cpu = 0;
-
-	if (mpic->flags & MPIC_PRIMARY)
-		cpu = hard_smp_processor_id();
+	unsigned int cpu = mpic_processor_id(mpic);
 
 	_mpic_write(mpic->reg_type, &mpic->cpuregs[cpu], reg, value);
 }
@@ -1005,13 +1010,8 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
 	 * is done here.
 	 */
 	if (!mpic_is_ipi(mpic, hw) && (mpic->flags & MPIC_NO_RESET)) {
-		unsigned int cpu = 0;
-
-		if (mpic->flags & MPIC_PRIMARY)
-			cpu = hard_smp_processor_id();
-
 		mpic_set_vector(virq, hw);
-		mpic_set_destination(virq, cpu);
+		mpic_set_destination(virq, mpic_processor_id(mpic));
 		mpic_irq_set_priority(virq, 8);
 	}
 
@@ -1355,10 +1355,7 @@ void __init mpic_init(struct mpic *mpic)
 
 	mpic_pasemi_msi_init(mpic);
 
-	if (mpic->flags & MPIC_PRIMARY)
-		cpu = hard_smp_processor_id();
-	else
-		cpu = 0;
+	cpu = mpic_processor_id(mpic);
 
 	if (!(mpic->flags & MPIC_NO_RESET)) {
 		for (i = 0; i < mpic->num_sources; i++) {
-- 
1.6.3.3
