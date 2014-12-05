Return-Path: <gkurz@linux.vnet.ibm.com>
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9BC001A02F6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Dec 2014 02:42:36 +1100 (AEDT)
Received: from /spool/local
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gkurz@linux.vnet.ibm.com>;
 Fri, 5 Dec 2014 15:42:32 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CA19219004D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 15:42:01 +0000 (GMT)
Received: from d06av11.portsmouth.uk.ibm.com (d06av11.portsmouth.uk.ibm.com
 [9.149.37.252])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB5FgT7758720424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 15:42:29 GMT
Received: from d06av11.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av11.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB5FgSvV015046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Dec 2014 08:42:29 -0700
Subject: [PATCH] powerpc: drop the cpu_bootable hook
From: Greg Kurz <gkurz@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 05 Dec 2014 16:42:28 +0100
Message-ID: <20141205154045.12630.60319.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20141205151517.11028.6894.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20141205151517.11028.6894.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

All powerpc platforms share the same cpu_bootable hook, which does nothing
but { return 1 }. It is not needed anymore. Let's drop it at last.

Signed-off-by: Greg Kurz <gkurz@linux.vnet.ibm.com>
---

v3: drop smp_generic_cpu_bootable() as well

I knew that posting a few minutes before leaving is bad idea on fridays... ;)

 arch/powerpc/include/asm/smp.h       |    1 -
 arch/powerpc/kernel/smp.c            |   14 +-------------
 arch/powerpc/platforms/85xx/smp.c    |    1 -
 arch/powerpc/platforms/cell/smp.c    |    1 -
 arch/powerpc/platforms/powernv/smp.c |    1 -
 arch/powerpc/platforms/pseries/smp.c |    1 -
 6 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index fae8cad..76edb9c 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -50,7 +50,6 @@ struct smp_ops_t {
 	void  (*give_timebase)(void);
 	int   (*cpu_disable)(void);
 	void  (*cpu_die)(unsigned int nr);
-	int   (*cpu_bootable)(unsigned int nr);
 };
 
 extern void smp_send_debugger_break(void);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8d7f114..e8bd931 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -82,17 +82,6 @@ volatile unsigned int cpu_callin_map[NR_CPUS];
 
 static void (*crash_ipi_function_ptr)(struct pt_regs *) = NULL;
 
-/*
- * Returns 1 if the specified cpu should be brought up during boot.
- * Used to inhibit booting threads if they've been disabled or
- * limited on the command line
- */
-int smp_generic_cpu_bootable(unsigned int nr)
-{
-	return 1;
-}
-
-
 #ifdef CONFIG_PPC64
 int smp_generic_kick_cpu(int nr)
 {
@@ -489,8 +478,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	    cpu_thread_in_subcore(cpu))
 		return -EBUSY;
 
-	if (smp_ops == NULL ||
-	    (smp_ops->cpu_bootable && !smp_ops->cpu_bootable(cpu)))
+	if (smp_ops == NULL)
 		return -EINVAL;
 
 	cpu_idle_thread_init(cpu, tidle);
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index d7c1e69..3aedc35 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -326,7 +326,6 @@ out:
 
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
-	.cpu_bootable = smp_generic_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable	= generic_cpu_disable,
 	.cpu_die	= generic_cpu_die,
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index c8017a7..09f4eec 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -142,7 +142,6 @@ static struct smp_ops_t bpa_iic_smp_ops = {
 	.probe		= smp_iic_probe,
 	.kick_cpu	= smp_cell_kick_cpu,
 	.setup_cpu	= smp_cell_setup_cpu,
-	.cpu_bootable	= smp_generic_cpu_bootable,
 };
 
 /* This is called very early */
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 4753958..2e8a727 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -191,7 +191,6 @@ static struct smp_ops_t pnv_smp_ops = {
 	.probe		= xics_smp_probe,
 	.kick_cpu	= pnv_smp_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
-	.cpu_bootable	= smp_generic_cpu_bootable,
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_disable	= pnv_smp_cpu_disable,
 	.cpu_die	= generic_cpu_die,
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index a3555b1..505a689 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -222,7 +222,6 @@ static struct smp_ops_t pSeries_xics_smp_ops = {
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
 	.setup_cpu	= smp_xics_setup_cpu,
-	.cpu_bootable	= smp_generic_cpu_bootable,
 };
 
 /* This is called very early */
