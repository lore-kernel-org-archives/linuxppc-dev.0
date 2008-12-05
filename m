Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 410D5DDDED
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 03:59:15 +1100 (EST)
Date: Fri, 5 Dec 2008 19:59:13 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc/qe: Fix few build errors with CONFIG_QUICC_ENGINE=n
Message-ID: <20081205165913.GA786@oksana.dev.rtsoft.ru>
References: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081205165504.GA30966@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some 83xx boards were not ready for the optional QUICC Engine support.

This patch fixes following build errors:

arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
(.text+0xb308): undefined reference to `par_io_data_set'
arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
(.text+0xb334): undefined reference to `par_io_data_set'
arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
(.text+0xb408): undefined reference to `qe_ic_get_high_irq'
arch/powerpc/platforms/built-in.o: In function `flush_disable_caches':
(.text+0xb478): undefined reference to `qe_ic_get_low_irq'
arch/powerpc/platforms/built-in.o: In function `mpc832x_spi_init':
mpc832x_rdb.c:(.init.text+0x574c): undefined reference to `par_io_config_pin'
mpc832x_rdb.c:(.init.text+0x5768): undefined reference to `par_io_config_pin'
mpc832x_rdb.c:(.init.text+0x5784): undefined reference to `par_io_config_pin'
mpc832x_rdb.c:(.init.text+0x57a0): undefined reference to `par_io_config_pin'
mpc832x_rdb.c:(.init.text+0x57bc): undefined reference to `par_io_config_pin'
arch/powerpc/platforms/built-in.o:mpc832x_rdb.c:(.init.text+0x57d8): more undefined references to `par_io_config_pin' follow
arch/powerpc/platforms/built-in.o: In function `mpc836x_rdk_init_IRQ':
mpc836x_rdk.c:(.init.text+0x5e84): undefined reference to `qe_ic_init'
arch/powerpc/platforms/built-in.o: In function `mpc836x_rdk_setup_arch':
mpc836x_rdk.c:(.init.text+0x5f10): undefined reference to `qe_reset'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/include/asm/qe.h    |   16 ++++++++++++++--
 arch/powerpc/include/asm/qe_ic.h |   21 +++++++++++++++++----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/qe.h b/arch/powerpc/include/asm/qe.h
index 3227440..a0a1531 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/arch/powerpc/include/asm/qe.h
@@ -86,7 +86,11 @@ static inline bool qe_clock_is_brg(enum qe_clock clk)
 extern spinlock_t cmxgcr_lock;
 
 /* Export QE common operations */
+#ifdef CONFIG_QUICC_ENGINE
 extern void __init qe_reset(void);
+#else
+static inline void qe_reset(void) {}
+#endif
 
 /* QE PIO */
 #define QE_PIO_PINS 32
@@ -103,16 +107,24 @@ struct qe_pio_regs {
 #endif
 };
 
-extern int par_io_init(struct device_node *np);
-extern int par_io_of_config(struct device_node *np);
 #define QE_PIO_DIR_IN	2
 #define QE_PIO_DIR_OUT	1
 extern void __par_io_config_pin(struct qe_pio_regs __iomem *par_io, u8 pin,
 				int dir, int open_drain, int assignment,
 				int has_irq);
+#ifdef CONFIG_QUICC_ENGINE
+extern int par_io_init(struct device_node *np);
+extern int par_io_of_config(struct device_node *np);
 extern int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
 			     int assignment, int has_irq);
 extern int par_io_data_set(u8 port, u8 pin, u8 val);
+#else
+static inline int par_io_init(struct device_node *np) { return -ENOSYS; }
+static inline int par_io_of_config(struct device_node *np) { return -ENOSYS; }
+static inline int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+		int assignment, int has_irq) { return -ENOSYS; }
+static inline int par_io_data_set(u8 port, u8 pin, u8 val) { return -ENOSYS; }
+#endif /* CONFIG_QUICC_ENGINE */
 
 /*
  * Pin multiplexing functions.
diff --git a/arch/powerpc/include/asm/qe_ic.h b/arch/powerpc/include/asm/qe_ic.h
index 56a7745..cf51966 100644
--- a/arch/powerpc/include/asm/qe_ic.h
+++ b/arch/powerpc/include/asm/qe_ic.h
@@ -17,6 +17,9 @@
 
 #include <linux/irq.h>
 
+struct device_node;
+struct qe_ic;
+
 #define NUM_OF_QE_IC_GROUPS	6
 
 /* Flags when we init the QE IC */
@@ -54,17 +57,27 @@ enum qe_ic_grp_id {
 	QE_IC_GRP_RISCB		/* QE interrupt controller RISC group B */
 };
 
+#ifdef CONFIG_QUICC_ENGINE
 void qe_ic_init(struct device_node *node, unsigned int flags,
 		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
 		void (*high_handler)(unsigned int irq, struct irq_desc *desc));
+unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
+unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
+#else
+static inline void qe_ic_init(struct device_node *node, unsigned int flags,
+		void (*low_handler)(unsigned int irq, struct irq_desc *desc),
+		void (*high_handler)(unsigned int irq, struct irq_desc *desc))
+{}
+static inline unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic)
+{ return 0; }
+static inline unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic)
+{ return 0; }
+#endif /* CONFIG_QUICC_ENGINE */
+
 void qe_ic_set_highest_priority(unsigned int virq, int high);
 int qe_ic_set_priority(unsigned int virq, unsigned int priority);
 int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high);
 
-struct qe_ic;
-unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic);
-unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic);
-
 static inline void qe_ic_cascade_low_ipic(unsigned int irq,
 					  struct irq_desc *desc)
 {
-- 
1.5.6.5
