Return-Path: <milindchoudhary@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id B10EEDDF05
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 04:22:12 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id i31so268278wxd
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 11:22:11 -0700 (PDT)
Date: Wed, 11 Apr 2007 23:54:03 +0530
From: Milind Arun Choudhary <milindchoudhary@gmail.com>
To: kernel-janitors@lists.osdl.org, linuxppc-dev@ozlabs.org
Subject: [KJ][PATCH]SPIN_LOCK_UNLOCKED cleanup in arch/powerpc
Message-ID: <20070411182403.GA10121@arun.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: akpm@linux-foundation.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SPIN_LOCK_UNLOCKED cleanup,use DEFINE_SPINLOCK or 
__SPIN_LOCK_UNLOCKED where ever appropriate. 

Signed-off-by: Milind Arun Choudhary <milindchoudhary@gmail.com>

--

 kernel/irq.c              |    2 +-
 kernel/rtas.c             |    2 +-
 oprofile/op_model_cell.c  |    2 +-
 platforms/cell/spu_base.c |    2 +-
 platforms/ps3/htab.c      |    2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1009308..6c83fe2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -394,7 +394,7 @@ EXPORT_SYMBOL(do_softirq);
 #ifdef CONFIG_PPC_MERGE
 
 static LIST_HEAD(irq_hosts);
-static spinlock_t irq_big_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(irq_big_lock);
 static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
 static unsigned int irq_radix_writer;
 struct irq_map_entry irq_map[NR_IRQS];
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 9d0735a..8746cb3 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -36,7 +36,7 @@
 #include <asm/syscalls.h>
 
 struct rtas_t rtas = {
-	.lock = SPIN_LOCK_UNLOCKED
+	.lock = __SPIN_LOCK_UNLOCKED(rtas.lock)
 };
 EXPORT_SYMBOL(rtas);
 
diff --git a/arch/powerpc/oprofile/op_model_cell.c b/arch/powerpc/oprofile/op_model_cell.c
index e08e1d7..c9d734b 100644
--- a/arch/powerpc/oprofile/op_model_cell.c
+++ b/arch/powerpc/oprofile/op_model_cell.c
@@ -130,7 +130,7 @@ static int pm_rtas_token;
 static u32 reset_value[NR_PHYS_CTRS];
 static int num_counters;
 static int oprofile_running;
-static spinlock_t virt_cntr_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(virt_cntr_lock);
 
 static u32 ctr_enabled;
 
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index eba7a26..dc433f0 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -41,7 +41,7 @@ const struct spu_priv1_ops *spu_priv1_ops;
 static struct list_head spu_list[MAX_NUMNODES];
 static LIST_HEAD(spu_full_list);
 static DEFINE_MUTEX(spu_mutex);
-static spinlock_t spu_list_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(spu_list_lock);
 
 EXPORT_SYMBOL_GPL(spu_priv1_ops);
 
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index e12e59f..ea60c45 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -39,7 +39,7 @@ static unsigned long htab_addr;
 static unsigned char *bolttab;
 static unsigned char *inusetab;
 
-static spinlock_t ps3_bolttab_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(ps3_bolttab_lock);
 
 #define debug_dump_hpte(_a, _b, _c, _d, _e, _f, _g) \
 	_debug_dump_hpte(_a, _b, _c, _d, _e, _f, _g, __func__, __LINE__)


-- 
Milind Arun Choudhary
