Return-Path: <santosh@fossix.org>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1rTG1s6TzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jul 2017 14:22:57 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id u36so25012966pgn.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 03 Jul 2017 21:22:57 -0700 (PDT)
From: Santosh Sivaraj <santosh@fossix.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/smp: Get cpu only after validity check
Date: Tue,  4 Jul 2017 09:52:46 +0530
Message-Id: <20170704042246.22609-1-santosh@fossix.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Check for validity of cpu before calling get_hard_smp_processor_id.

Found with coverity.

Signed-off-by: Santosh Sivaraj <santosh@fossix.org>
---
 arch/powerpc/platforms/powernv/smp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 40dae96..c6448c7 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -57,7 +57,7 @@ static void pnv_smp_setup_cpu(int cpu)
 
 static int pnv_smp_kick_cpu(int nr)
 {
-	unsigned int pcpu = get_hard_smp_processor_id(nr);
+	unsigned int pcpu;
 	unsigned long start_here =
 			__pa(ppc_function_entry(generic_secondary_smp_init));
 	long rc;
@@ -66,6 +66,7 @@ static int pnv_smp_kick_cpu(int nr)
 	if (nr < 0 || nr >= nr_cpu_ids)
 		return -EINVAL;
 
+	pcpu = get_hard_smp_processor_id(nr);
 	/*
 	 * If we already started or OPAL is not supported, we just
 	 * kick the CPU via the PACA
-- 
2.9.4
