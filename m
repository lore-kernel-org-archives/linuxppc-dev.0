Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6JxM12LZzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 20:59:18 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6BAwc1d076688
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 06:59:16 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bmd1q05r2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 06:59:16 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 20:59:13 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6BAvuXo20512848
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 20:57:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6BAvtpm013179
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 20:57:56 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix SDAR_MODE value for continous sampling in
 power9
Date: Tue, 11 Jul 2017 16:27:49 +0530
Message-Id: <1499770669-9255-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Incase of continous sampling, code currently defaults
MMCRA[SDAR_MODE] to 0b01 for power9 DD1 which is
'Continous sampling mode update SDAR on TLB miss'.
And for the rest it copies the sdar_mode value from
the event code, which mostly turns out to be 0b00
('No Updates').

Instead, fix the sdar_mode to 0b10
('Continous sampling mode update SDAR on dcache miss')
as default for power9 incase of continous sampling.

Fixes: 78b4416aa2493 ('powerpc/perf: Handle sdar_mode for marked event in power9')
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 8 +++++---
 arch/powerpc/perf/isa207-common.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 8125160be7bc..ae0cd2a29e68 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -90,14 +90,16 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 	 *	MMCRA[SDAR_MODE] will be set to 0b01
 	 * For rest
 	 *	MMCRA[SDAR_MODE] will be set from event code.
+	 *      If sdar_mode from raw code is zero, default to 0b10.
 	 */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
 		if (is_event_marked(event) || (*mmcra & MMCRA_SAMPLE_ENABLE))
 			*mmcra &= MMCRA_SDAR_MODE_NO_UPDATES;
-		else if (!cpu_has_feature(CPU_FTR_POWER9_DD1))
+		else if ((!cpu_has_feature(CPU_FTR_POWER9_DD1) &&
+							p9_SDAR_MODE(event)))
 			*mmcra |=  p9_SDAR_MODE(event) << MMCRA_SDAR_MODE_SHIFT;
-		else if (cpu_has_feature(CPU_FTR_POWER9_DD1))
-			*mmcra |= MMCRA_SDAR_MODE_TLB;
+		else
+			*mmcra |= MMCRA_SDAR_MODE_DCACHE;
 	} else
 		*mmcra |= MMCRA_SDAR_MODE_TLB;
 }
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 8acbe6e802c7..250d91f4d642 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -246,6 +246,7 @@
 #define MMCRA_THR_CMP_SHIFT		32
 #define MMCRA_SDAR_MODE_SHIFT		42
 #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
+#define MMCRA_SDAR_MODE_DCACHE		(2ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_SDAR_MODE_NO_UPDATES	~(0x3ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_IFM_SHIFT			30
 #define MMCRA_THR_CTR_MANT_SHIFT	19
-- 
2.7.4
