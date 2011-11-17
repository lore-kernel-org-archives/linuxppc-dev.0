Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A5CBB73A7
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:29:20 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Thu, 17 Nov 2011 11:27:30 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAHBQ5MG2474214
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:26:05 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAHBTDMV003490
 for <linuxppc-dev@ozlabs.org>; Thu, 17 Nov 2011 22:29:14 +1100
Subject: [RFC PATCH v2 4/4] cpuidle: (POWER) Handle power_save=off
To: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-pm@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Thu, 17 Nov 2011 16:59:12 +0530
Message-ID: <20111117112906.9191.54050.stgit@localhost6.localdomain6>
In-Reply-To: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
References: <20111117112815.9191.2322.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-kernel@vger.kernel.org
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
boot_option_idle_override variable used here is similar to
its usage on x86.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
---
 arch/powerpc/include/asm/processor.h            |    1 +
 arch/powerpc/platforms/pseries/processor_idle.c |    4 ++++
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 811b7e7..b286fb7 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -382,6 +382,7 @@ static inline unsigned long get_clean_sp(struct pt_regs *regs, int is_32)
 }
 #endif
 
+extern unsigned long  boot_option_idle_override;
 enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index b5addd7..5f74b4e 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -260,6 +260,10 @@ static int pseries_idle_probe(void)
 		return -EPERM;
 	}
 
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE) {
+		return -ENODEV;
+	}
+
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		printk(KERN_DEBUG "Using default idle\n");
 		return -ENODEV;
