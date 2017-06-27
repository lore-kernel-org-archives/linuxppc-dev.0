Return-Path: <santosh@fossix.org>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxcJB5djPzDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 17:00:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id d5so3525618pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 00:00:26 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/smp: Convert NR_CPUS to nr_cpu_ids
Date: Tue, 27 Jun 2017 12:30:06 +0530
Message-Id: <20170627070006.32132-2-santosh@fossix.org>
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

nr_cpu_ids can be limited by nr_cpus boot parameter, whereas NR_CPUS is a
compile time constant, which shouldn't be compared against during cpu kick.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/kernel/smp.c            | 2 +-
 arch/powerpc/platforms/cell/smp.c    | 2 +-
 arch/powerpc/platforms/powernv/smp.c | 2 +-
 arch/powerpc/platforms/pseries/smp.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 05bf583..4180197 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -112,7 +112,7 @@ int smp_generic_cpu_bootable(unsigned int nr)
 #ifdef CONFIG_PPC64
 int smp_generic_kick_cpu(int nr)
 {
-	if (nr < 0 || nr >= NR_CPUS)
+	if (nr < 0 || nr >= nr_cpu_ids)
 		return -EINVAL;
 
 	/*
diff --git a/arch/powerpc/platforms/cell/smp.c b/arch/powerpc/platforms/cell/smp.c
index ee8c535..f84d52a 100644
--- a/arch/powerpc/platforms/cell/smp.c
+++ b/arch/powerpc/platforms/cell/smp.c
@@ -115,7 +115,7 @@ static void smp_cell_setup_cpu(int cpu)
 
 static int smp_cell_kick_cpu(int nr)
 {
-	if (nr < 0 || nr >= NR_CPUS)
+	if (nr < 0 || nr >= nr_cpu_ids)
 		return -EINVAL;
 
 	if (!smp_startup_cpu(nr))
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 292825f..40dae96 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -63,7 +63,7 @@ static int pnv_smp_kick_cpu(int nr)
 	long rc;
 	uint8_t status;
 
-	if (nr < 0 || nr >= NR_CPUS)
+	if (nr < 0 || nr >= nr_cpu_ids)
 		return -EINVAL;
 
 	/*
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index c82182a..24785f6 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -151,7 +151,7 @@ static void smp_setup_cpu(int cpu)
 
 static int smp_pSeries_kick_cpu(int nr)
 {
-	if (nr < 0 || nr >= NR_CPUS)
+	if (nr < 0 || nr >= nr_cpu_ids)
 		return -EINVAL;
 
 	if (!smp_startup_cpu(nr))
-- 
2.9.4
