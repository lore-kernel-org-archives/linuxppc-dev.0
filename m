Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 72833679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2006 17:15:19 +1100 (EST)
Date: Tue, 28 Mar 2006 17:14:44 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: a couple of trivial compile warning fixes
Message-Id: <20060328171444.694eeb4f.sfr@canb.auug.org.au>
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

 arch/powerpc/kernel/prom.c             |    5 ++++-
 arch/powerpc/platforms/pseries/setup.c |    2 --
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

364e2efc3de4e6407ca2bd13e8ed1ec624a9cbce
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5a24415..d98fbe2 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -860,7 +860,10 @@ static int __init early_init_dt_scan_cpu
 {
 	static int logical_cpuid = 0;
 	char *type = of_get_flat_dt_prop(node, "device_type", NULL);
-	u32 *prop, *intserv;
+#ifdef CONFIG_ALTIVEC
+	u32 *prop;
+#endif
+	u32 *intserv;
 	int i, nthreads;
 	unsigned long len;
 	int found = 0;
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f736234..1b0c4c0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -455,8 +455,6 @@ out:
 
 static void pseries_shared_idle_sleep(void)
 {
-	unsigned int cpu = smp_processor_id();
-
 	/*
 	 * Indicate to the HV that we are idle. Now would be
 	 * a good time to find other work to dispatch.
-- 
1.2.4
