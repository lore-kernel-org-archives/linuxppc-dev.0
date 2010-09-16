Return-Path: <msm@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140]) by ozlabs.org (Postfix) with ESMTP id 47A381DD35
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 09:04:26 +1000 (EST)
Received: from mail53-db3 (localhost.localdomain [127.0.0.1])	by
	mail53-db3-R.bigfish.com (Postfix) with ESMTP id 5EFB713A8354	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:19 +0000 (UTC)
Received: from DB3EHSMHS008.bigfish.com (unknown [10.3.81.245])	by
	mail53-db3.bigfish.com (Postfix) with ESMTP id E5F6528004E	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Sep 2010 22:49:18 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP
	id o8GMnGYd026835	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Sep 2010 15:49:16 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc/85xx: Minor fixups for kexec on 85xx
Date: Thu, 16 Sep 2010 17:58:25 -0500
Message-ID: <1284677906-23787-3-git-send-email-msm@freescale.com>
In-Reply-To: <1284677906-23787-1-git-send-email-msm@freescale.com>
References: <1284677906-23787-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make kexec_down_cpus atmoic since it will be incremented by all
cores as they are coming down

Remove duplicate calls to mpc85xx_smp_kexec_down, now it's called
by the crash and normal kexec pathway only once

Increase the timeout to wait for other cores to shutdown

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
 arch/powerpc/platforms/85xx/smp.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index cb8ad3b..29416a9 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -114,17 +114,15 @@ struct smp_ops_t smp_85xx_ops = {
 };
 
 #ifdef CONFIG_KEXEC
-static int kexec_down_cpus = 0;
+atomic_t kexec_down_cpus = ATOMIC_INIT(0);
 
 void mpc85xx_smp_kexec_cpu_down(int crash_shutdown, int secondary)
 {
-	/* When crashing, this gets called on all CPU's we only
-	 * take down the non-boot cpus */
-	if (smp_processor_id() != boot_cpuid)
-	{
-		local_irq_disable();
-		kexec_down_cpus++;
+	local_irq_disable();
 
+	if (secondary) {
+		atomic_inc(&kexec_down_cpus);
+		/* loop forever */
 		while (1);
 	}
 }
@@ -137,14 +135,14 @@ static void mpc85xx_smp_kexec_down(void *arg)
 
 static void mpc85xx_smp_machine_kexec(struct kimage *image)
 {
-	int timeout = 2000;
-	int i;
+	int timeout = INT_MAX;
+	int i, num_cpus = num_present_cpus();
 
-	set_cpus_allowed(current, cpumask_of_cpu(boot_cpuid));
 
-	smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
+	if (image->type == KEXEC_TYPE_DEFAULT)
+		smp_call_function(mpc85xx_smp_kexec_down, NULL, 0);
 
-	while ( (kexec_down_cpus != (num_online_cpus() - 1)) &&
+	while ( (atomic_read(&kexec_down_cpus) != (num_cpus - 1)) &&
 		( timeout > 0 ) )
 	{
 		timeout--;
@@ -153,7 +151,7 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
 	if ( !timeout )
 		printk(KERN_ERR "Unable to bring down secondary cpu(s)");
 
-	for (i = 0; i < num_present_cpus(); i++)
+	for (i = 0; i < num_cpus; i++)
 	{
 		if ( i == smp_processor_id() ) continue;
 		mpic_reset_core(i);
-- 
1.6.6.1
