Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A5C50DDEFA
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Oct 2007 02:47:36 +1000 (EST)
Date: Fri, 26 Oct 2007 11:55:10 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] Fix CONFIG_SMP=n build breaks
Message-ID: <20071026165510.GA2323@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Fix two build errors on powerpc allyesconfig + CONFIG_SMP=n:

arch/powerpc/platforms/built-in.o: In function `cpu_affinity_set':
arch/powerpc/platforms/cell/spu_priv1_mmio.c:78: undefined reference to `.iic_get_target_id'
arch/powerpc/platforms/built-in.o: In function `iic_init_IRQ':
arch/powerpc/platforms/cell/interrupt.c:397: undefined reference to `.iic_setup_cpu'


Signed-off-by: Olof Johansson <olof@lixom.net>

diff --git a/arch/powerpc/platforms/cell/interrupt.c b/arch/powerpc/platforms/cell/interrupt.c
index 151fd8b..222678f 100644
--- a/arch/powerpc/platforms/cell/interrupt.c
+++ b/arch/powerpc/platforms/cell/interrupt.c
@@ -158,6 +158,11 @@ static unsigned int iic_get_irq(void)
 	return virq;
 }
 
+void iic_setup_cpu(void)
+{
+	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
+}
+
 #ifdef CONFIG_SMP
 
 /* Use the highest interrupt priorities for IPI */
@@ -166,11 +171,6 @@ static inline int iic_ipi_to_irq(int ipi)
 	return IIC_IRQ_TYPE_IPI + 0xf - ipi;
 }
 
-void iic_setup_cpu(void)
-{
-	out_be64(&__get_cpu_var(iic).regs->prio, 0xff);
-}
-
 void iic_cause_IPI(int cpu, int mesg)
 {
 	out_be64(&per_cpu(iic, cpu).regs->generate, (0xf - mesg) << 4);
diff --git a/arch/powerpc/platforms/cell/spu_priv1_mmio.c b/arch/powerpc/platforms/cell/spu_priv1_mmio.c
index 67fa724..e5e08ac 100644
--- a/arch/powerpc/platforms/cell/spu_priv1_mmio.c
+++ b/arch/powerpc/platforms/cell/spu_priv1_mmio.c
@@ -75,9 +75,11 @@ static u64 int_stat_get(struct spu *spu, int class)
 
 static void cpu_affinity_set(struct spu *spu, int cpu)
 {
+#ifdef CONFIG_SMP
 	u64 target = iic_get_target_id(cpu);
 	u64 route = target << 48 | target << 32 | target << 16;
 	out_be64(&spu->priv1->int_route_RW, route);
+#endif
 }
 
 static u64 mfc_dar_get(struct spu *spu)
