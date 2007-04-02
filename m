Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2ED2DDE32
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 08:11:21 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH] POWERPC: CPU15 workaround for mpc8xx
Date: Tue, 03 Apr 2007 02:11:10 +0400
Message-ID: <20070402221110.4255.74986.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Implements workaround for CPU15 Silicon Errata on MPC8xx processors.
Based on the DENX workaround patches.

Original commit ids from linuxppc_32_4_devel:

Commit: baf9a6caca75b1f338ae370669e5882809000164 
	Author: wd <wd> Wed, 25 Aug 2004 15:16:30 +0000 
    Implement work-around for CPU15 Silicon Errata on MPC8xx
processors.
Commit: 3ad403717f1d9c6a09ec41a5b016ac5245591122 
	Author: wd <wd> Sun, 13 Feb 2005 20:04:14 +0000 
	Improve CPU15 workaround.
	Based on comments by Joakim Tjernlund 
	- make the sysctl support a compile time option as the overhead
	for sysctl support in the TLB handler is 6 instrunctions when the
	fix  itself is only 4 instructions
	- moved code out of CPU6 workaround code to avoid conflicts

Signed-off-by: Nick Ivanter <nick@emcraft.com>
Signed-off-by: Wolfgang Denk <wd@denx.de>

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/kernel/head_8xx.S     |   17 +++++++++
 arch/powerpc/platforms/8xx/Kconfig |   12 ++++++
 include/linux/sysctl.h             |    1 +
 kernel/sysctl.c                    |   67 ++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 901be47..dd67da9 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -301,6 +301,23 @@ InstructionTLBMiss:
 	stw	r10, 0(r0)
 	stw	r11, 4(r0)
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
+#ifdef CONFIG_8xx_CPU15
+#ifdef CONFIG_8xx_CPU15_SYSCTL
+	lis	r11, cpu15_fix@h
+	ori	r11, r11, cpu15_fix@l
+	tophys(r11,r11)
+	lwz	r11, 0(r11)		/* value of cpu15 variable */
+	cmpwi	r11, 0
+	beq	4f
+#endif
+	subi	r11, r10, 0x1000	/* EA of prev page */
+	tlbie	r11
+	addi	r11, r10, 0x1000	/* EA of next page */
+	tlbie	r11
+#ifdef CONFIG_8xx_CPU15_SYSCTL
+4:
+#endif
+#endif
 	DO_8xx_CPU6(0x3780, r3)
 	mtspr	SPRN_MD_EPN, r10	/* Have to use MD_EPN for walk, MI_EPN can't */
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table entry address */
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index beea683..3bce162 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -103,6 +103,18 @@ config 8xx_CPU6
 
 	  If in doubt, say N here.
 
+config 8xx_CPU15
+	bool "CPU15 Silicon Errata"
+	help
+	  MPC8xx CPUs have a bug in the silicon, which may cause the
+	  incorrect code execution after branch on MMU page boundary.
+	  Say Y to enable a workaround for this problem.
+
+config 8xx_CPU15_SYSCTL
+	bool "CPU15 Silicon Errata Sysctl"
+	depends on 8xx_CPU15
+	default y
+
 choice
 	prompt "Microcode patch selection"
 	default NO_UCODE_PATCH
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 2c5fb38..6109ffe 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -165,6 +165,7 @@ enum
 	KERN_MAX_LOCK_DEPTH=74,
 	KERN_NMI_WATCHDOG=75, /* int: enable/disable nmi watchdog */
 	KERN_PANIC_ON_NMI=76, /* int: whether we will panic on an unrecovered */
+	KERN_8XX_CPU15=77, /* boolean: patch cpu15 errata on mpc8xx cpu */
 };
 
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 1b255df..3391b14 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -158,6 +158,63 @@ extern ctl_table inotify_table[];
 int sysctl_legacy_va_layout;
 #endif
 
+static void *get_uts(ctl_table *table, int write)
+{
+	char *which = table->data;
+#ifdef CONFIG_UTS_NS
+	struct uts_namespace *uts_ns = current->nsproxy->uts_ns;
+	which = (which - (char *)&init_uts_ns) + (char *)uts_ns;
+#endif
+	if (!write)
+		down_read(&uts_sem);
+	else
+		down_write(&uts_sem);
+	return which;
+}
+
+static void put_uts(ctl_table *table, int write, void *which)
+{
+	if (!write)
+		up_read(&uts_sem);
+	else
+		up_write(&uts_sem);
+}
+
+#ifdef CONFIG_SYSVIPC
+static void *get_ipc(ctl_table *table, int write)
+{
+	char *which = table->data;
+	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
+	which = (which - (char *)&init_ipc_ns) + (char *)ipc_ns;
+	return which;
+}
+#else
+#define get_ipc(T,W) ((T)->data)
+#endif
+
+/* /proc declarations: */
+
+#ifdef CONFIG_PROC_SYSCTL
+
+static ssize_t proc_readsys(struct file *, char __user *, size_t, loff_t *);
+static ssize_t proc_writesys(struct file *, const char __user *, size_t, loff_t *);
+static int proc_opensys(struct inode *, struct file *);
+
+const struct file_operations proc_sys_file_operations = {
+	.open		= proc_opensys,
+	.read		= proc_readsys,
+	.write		= proc_writesys,
+};
+
+extern struct proc_dir_entry *proc_sys_root;
+
+static void register_proc_table(ctl_table *, struct proc_dir_entry *, void *);
+static void unregister_proc_table(ctl_table *, struct proc_dir_entry *);
+#endif
+
+#ifdef CONFIG_8xx_CPU15_SYSCTL
+int cpu15_fix = 0;      /* disabled by default */
+#endif
 
 /* The default sysctl tables: */
 
@@ -603,6 +660,16 @@ static ctl_table kern_table[] = {
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
+#ifdef CONFIG_8xx_CPU15_SYSCTL
+	{
+		.ctl_name	= KERN_8XX_CPU15,
+		.procname	= "8xx_cpu15",
+		.data		= &cpu15_fix,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+#endif
 
 	{ .ctl_name = 0 }
 };
