Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvqT16GKSzDr0V
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 19:16:53 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u62so8934876pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 02:16:53 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: arnd@arndb.de, benh@kernel.crashing.org, mpe@ellerman.id.au,
 ego@linux.vnet.ibm.com
Subject: [PATCH] powerpc/smp: Do not BUG_ON if invalid CPU during kick
Date: Sat, 24 Jun 2017 14:46:40 +0530
Message-Id: <20170624091640.20935-1-santosh@fossix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During secondary start, we do not need to BUG_ON if an invalid CPU number
is passed. We alreay print an error if secondary cannot be started, so
just return an error instead.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/smp.c            | 3 ++-
 arch/powerpc/platforms/cell/smp.c    | 3 ++-
 arch/powerpc/platforms/powernv/smp.c | 3 ++-
 arch/powerpc/platforms/pseries/smp.c | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index df2a416..05bf583 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -112,7 +112,8 @@ int smp_generic_cpu_bootable(unsigned int nr)
 #ifdef CONFIG_PPC64
 int smp_generic_kick_cpu(int nr)
 {
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
+	if (nr < 0 || nr >= NR_CPUS)
+		return -EINVAL;
 
 	/*
 	 * The processor is currently spinning, waiting for the
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index 895560f..ee8c535 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -115,7 +115,8 @@ static void smp_cell_setup_cpu(int cpu)
 
 static int smp_cell_kick_cpu(int nr)
 {
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
+	if (nr < 0 || nr >= NR_CPUS)
+		return -EINVAL;
 
 	if (!smp_startup_cpu(nr))
 		return -ENOENT;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c04c87a..292825f 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -63,7 +63,8 @@ static int pnv_smp_kick_cpu(int nr)
 	long rc;
 	uint8_t status;
 
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
+	if (nr < 0 || nr >= NR_CPUS)
+		return -EINVAL;
 
 	/*
 	 * If we already started or OPAL is not supported, we just
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 52ca6b3..c82182a 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -151,7 +151,8 @@ static void smp_setup_cpu(int cpu)
 
 static int smp_pSeries_kick_cpu(int nr)
 {
-	BUG_ON(nr < 0 || nr >= NR_CPUS);
+	if (nr < 0 || nr >= NR_CPUS)
+		return -EINVAL;
 
 	if (!smp_startup_cpu(nr))
 		return -ENOENT;
-- 
2.9.4
