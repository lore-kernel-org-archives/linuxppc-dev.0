Return-Path: <jan.veldeman@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.173])
	by ozlabs.org (Postfix) with ESMTP id 2EA2467B15
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 19:26:44 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id j3so1127560ugf
	for <linuxppc-dev@ozlabs.org>; Wed, 31 May 2006 02:26:42 -0700 (PDT)
Message-ID: <ef135be40605310219n5d900fan897995551ea63fca@mail.gmail.com>
Date: Wed, 31 May 2006 11:19:59 +0200
From: "Jan Veldeman" <jan.veldeman@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: unresolved symbol dma_spin_lock with CONFIG_DEBUG_SPINLOCK enabled
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

when compiling for a platform without CONFIG_GENERIC_ISA_DMA set and with
CONFIG_DEBUG_SPINLOCK enabled, the linker complains about an unresolved symbol
to dma_spin_lock (which is declared in kernel/dma.c but doesn't get compiled).
Without CONFIG_DEBUG_SPINLOCK, these statements are removed by the compiler,
so that dma_spin_lock isn't referenced.

I see 3 possible solutions for this problem:

1. compile in kernel/dma.c when CONFIG_DEBUG_SPINLOCK is enabled

diff --git a/kernel/Makefile b/kernel/Makefile
index 58908f9..6cab2a3 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_FUTEX) += futex.o
 ifeq ($(CONFIG_COMPAT),y)
 obj-$(CONFIG_FUTEX) += futex_compat.o
 endif
+obj-$(CONFIG_DEBUG_SPINLOCK) += dma.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o


as it's a debug build, the extra space shouldn't mind.
It will also solve similar problems for other architectures (if they exist, I
didn't check this)

2. stub the claim/release_dma_lock in include/asm-powerpc/dma.h

diff --git a/include/asm-powerpc/dma.h b/include/asm-powerpc/dma.h
index 4bb57fe..de5efc7 100644
--- a/include/asm-powerpc/dma.h
+++ b/include/asm-powerpc/dma.h
@@ -182,6 +182,8 @@ extern long ppc_cs4232_dma, ppc_cs4232_d

 #define DMA_AUTOINIT           0x10

+#ifdef CONFIG_GENERIC_ISA_DMA
+
 extern spinlock_t dma_spin_lock;

 static __inline__ unsigned long claim_dma_lock(void)
@@ -196,6 +198,22 @@ static __inline__ void release_dma_lock(
        spin_unlock_irqrestore(&dma_spin_lock, flags);
 }

+#else /* CONFIG_GENERIC_ISA_DMA */
+
+/* dma_spin_lock isn't declared because kernel/dma.c doesn't get compiled,
+ * so stub these functions */
+
+static __inline__ unsigned long claim_dma_lock(void)
+{
+       return 0;
+}
+
+static __inline__ void release_dma_lock(unsigned long flags)
+{
+}
+
+#endif /* CONFIG_GENERIC_ISA_DMA */
+
 /* enable/disable a specific DMA channel */
 static __inline__ void enable_dma(unsigned int dmanr)
 {

but this just doesn't feel right

3. fix the driver using claim_dma_lock on platforms without
    CONFIG_GENERIC_ISA_DMA

This just looks like a lot of work and would make it harder for drivers.

Any suggestions/remarks?

Best regards,
Jan
