Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E6D89B6FB7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Feb 2012 13:16:14 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: kvm-ppc@vger.kernel.org
Subject: [PATCH] KVM: PPC: Don't sync timebase when inside KVM
Date: Wed, 29 Feb 2012 03:16:09 +0100
Message-Id: <1330481769-24390-1-git-send-email-agraf@suse.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we know that we're running inside of a KVM guest, we don't have to
worry about synchronizing timebases between different CPUs, since the
host already took care of that.

This fixes CPU overcommit scenarios where vCPUs could hang forever trying
to sync each other while not being scheduled.

Reported-by: Stuart Yoder <B08248@freescale.com>
Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/kernel/smp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 46695fe..670b453 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -49,6 +49,8 @@
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #endif
+#include <linux/kvm_para.h>
+#include <asm/kvm_para.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -541,7 +543,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 
 	DBG("Processor %u found.\n", cpu);
 
-	if (smp_ops->give_timebase)
+	if (!kvm_para_available() && smp_ops->give_timebase)
 		smp_ops->give_timebase();
 
 	/* Wait until cpu puts itself in the online map */
@@ -626,7 +628,7 @@ void __devinit start_secondary(void *unused)
 
 	if (smp_ops->setup_cpu)
 		smp_ops->setup_cpu(cpu);
-	if (smp_ops->take_timebase)
+	if (!kvm_para_available() && smp_ops->take_timebase)
 		smp_ops->take_timebase();
 
 	secondary_cpu_time_init();
-- 
1.6.0.2
