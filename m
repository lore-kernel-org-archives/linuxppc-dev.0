Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxcJ936yVzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:00:25 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id u62so3199148pgb.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:00:24 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/smp: Do not BUG_ON if invalid CPU during kick
Date: Tue, 27 Jun 2017 12:30:05 +0530
Message-Id: <20170627070006.32132-1-santosh@fossix.org>
In-Reply-To: <8760fiewx0.fsf@concordia.ellerman.id.au>
References: <8760fiewx0.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During secondary start, we do not need to BUG_ON if an invalid CPU number
is passed. We already print an error if secondary cannot be started, so
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
