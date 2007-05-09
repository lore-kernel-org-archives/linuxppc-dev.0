Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id C6B25DDECA
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 02:19:45 +1000 (EST)
Date: Thu, 10 May 2007 02:19:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] pmu_sys_suspended is only defined for PPC32
Message-Id: <20070510021951.df5b7551.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/pmu.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/linux/pmu.h b/include/linux/pmu.h
index 37ca573..5ad913f 100644
--- a/include/linux/pmu.h
+++ b/include/linux/pmu.h
@@ -226,7 +226,7 @@ extern unsigned int pmu_power_flags;
 extern void pmu_backlight_init(void);
 
 /* some code needs to know if the PMU was suspended for hibernation */
-#ifdef CONFIG_PM
+#if defined(CONFIG_PM) && defined(CONFIG_PPC32)
 extern int pmu_sys_suspended;
 #else
 /* if power management is not configured it can't be suspended */
-- 
1.5.1.3
