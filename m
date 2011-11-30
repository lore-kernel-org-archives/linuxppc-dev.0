Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E02021007D1
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Dec 2011 00:32:21 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 30 Nov 2011 18:19:53 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAUCl5XJ4239522
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2011 18:17:05 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAUCl5Z8001952
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2011 23:47:05 +1100
Subject: [RFC PATCH v3 4/4] cpuidle: (POWER) Handle power_save=off
To: benh@kernel.crashing.org, len.brown@intel.com
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2011 18:17:03 +0530
Message-ID: <20111130124701.972.7269.stgit@deepthi-ThinkPad-T420>
In-Reply-To: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
References: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch makes pseries_idle_driver not to be registered when
power_save=off kernel boot option is specified. The
cpuidle_disable variable used here is similar to
its usage on x86. If cpuidle_disable is set then
sysfs entries for cpuidle framework are not created
and the required drivers are not loaded.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
---
 arch/powerpc/include/asm/processor.h            |    1 +
 arch/powerpc/platforms/pseries/processor_idle.c |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 811b7e7..b585bff 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -382,6 +382,7 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+extern unsigned long cpuidle_disable;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index 352b78a..4f59af0 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -269,6 +269,9 @@ static int pseries_idle_probe(void)
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -ENODEV;
 
+	if (cpuidle_disable != IDLE_NO_OVERRIDE)
+		return -ENODEV;
+
 	if (max_idle_state == 0) {
 		printk(KERN_DEBUG "pseries processor idle disabled.\n");
 		return -EPERM;
