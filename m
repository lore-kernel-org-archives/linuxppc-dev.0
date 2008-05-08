Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <88224b0a089ef8cbf85a4bf074feba0bbb10732c.1210220828.git.michael@ellerman.id.au>
In-Reply-To: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
References: <5d2ed2a7e92250bdc6d9959dbeaeb3784a7109b4.1210220828.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 12/12] Fix sparse warnings in arch/powerpc/platforms/pseries
Date: Thu,  8 May 2008 14:27:23 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Don't return void in pseries/iommu.c
Make mce_data_buf static in pseries/ras.c
Make things static in pseries/rtasd.c
Make things static in pseries/setup.c
vtermno may as well be static in platforms/pseries/lpar.c

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   15 +++++++++------
 arch/powerpc/platforms/pseries/lpar.c  |    2 +-
 arch/powerpc/platforms/pseries/ras.c   |    2 +-
 arch/powerpc/platforms/pseries/rtasd.c |    4 ++--
 arch/powerpc/platforms/pseries/setup.c |    4 ++--
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 176f1f3..9a12908 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -135,9 +135,10 @@ static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	u64 rpn;
 	long l, limit;
 
-	if (npages == 1)
-		return tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
-					   direction);
+	if (npages == 1) {
+		tce_build_pSeriesLP(tbl, tcenum, npages, uaddr, direction);
+		return;
+	}
 
 	tcep = __get_cpu_var(tce_page);
 
@@ -147,9 +148,11 @@ static void tce_buildmulti_pSeriesLP(struct iommu_table *tbl, long tcenum,
 	if (!tcep) {
 		tcep = (u64 *)__get_free_page(GFP_ATOMIC);
 		/* If allocation fails, fall back to the loop implementation */
-		if (!tcep)
-			return tce_build_pSeriesLP(tbl, tcenum, npages,
-						   uaddr, direction);
+		if (!tcep) {
+			tce_build_pSeriesLP(tbl, tcenum, npages, uaddr,
+					    direction);
+			return;
+		}
 		__get_cpu_var(tce_page) = tcep;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 2cbaedb..3b4651b 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -52,7 +52,7 @@ EXPORT_SYMBOL(plpar_hcall_norets);
 extern void pSeries_find_serial_port(void);
 
 
-int vtermno;	/* virtual terminal# for udbg  */
+static int vtermno;	/* virtual terminal# for udbg  */
 
 #define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
 static void udbg_hvsi_putc(char c)
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index 2b548af..d20b96e 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -55,7 +55,7 @@
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static DEFINE_SPINLOCK(ras_log_buf_lock);
 
-char mce_data_buf[RTAS_ERROR_LOG_MAX];
+static char mce_data_buf[RTAS_ERROR_LOG_MAX];
 
 static int ras_get_sensor_state_token;
 static int ras_check_exception_token;
diff --git a/arch/powerpc/platforms/pseries/rtasd.c b/arch/powerpc/platforms/pseries/rtasd.c
index 7d3e2b0..c9ffd8c 100644
--- a/arch/powerpc/platforms/pseries/rtasd.c
+++ b/arch/powerpc/platforms/pseries/rtasd.c
@@ -32,7 +32,7 @@
 
 static DEFINE_SPINLOCK(rtasd_log_lock);
 
-DECLARE_WAIT_QUEUE_HEAD(rtas_log_wait);
+static DECLARE_WAIT_QUEUE_HEAD(rtas_log_wait);
 
 static char *rtas_log_buf;
 static unsigned long rtas_log_start;
@@ -329,7 +329,7 @@ static unsigned int rtas_log_poll(struct file *file, poll_table * wait)
 	return 0;
 }
 
-const struct file_operations proc_rtas_log_operations = {
+static const struct file_operations proc_rtas_log_operations = {
 	.read =		rtas_log_read,
 	.poll =		rtas_log_poll,
 	.open =		rtas_log_open,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f5d29f5..90beb44 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -109,7 +109,7 @@ static void __init fwnmi_init(void)
 		fwnmi_active = 1;
 }
 
-void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
+static void pseries_8259_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq = i8259_irq();
 	if (cascade_irq != NO_IRQ)
@@ -482,7 +482,7 @@ static int pSeries_pci_probe_mode(struct pci_bus *bus)
  * possible with power button press. If ibm,power-off-ups token is used
  * it will allow auto poweron after power is restored.
  */
-void pSeries_power_off(void)
+static void pSeries_power_off(void)
 {
 	int rc;
 	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
-- 
1.5.5
