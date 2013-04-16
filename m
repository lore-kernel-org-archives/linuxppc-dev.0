Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C9D8A2C0122
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:57:02 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Apr 2013 18:22:49 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 9E2F6E0055
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:28:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3GCupke4915680
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 18:26:51 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3GCusoD001582
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Apr 2013 22:56:54 +1000
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] powerpc, perf: Add new BHRB related generic functions,
 data and flags
Date: Tue, 16 Apr 2013 18:26:38 +0530
Message-Id: <1366117000-10979-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1366117000-10979-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index 57b42da..3f0c15c 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -33,6 +33,8 @@ struct power_pmu {
 				unsigned long *valp);
 	int		(*get_alternatives)(u64 event_id, unsigned int flags,
 				u64 alt[]);
+	u64             (*bhrb_filter_map)(u64 branch_sample_type);
+	void            (*config_bhrb)(u64 pmu_bhrb_filter);
 	void		(*disable_pmc)(unsigned int pmc, unsigned long mmcr[]);
 	int		(*limited_pmc_event)(u64 event_id);
 	u32		flags;
@@ -42,6 +44,9 @@ struct power_pmu {
 	int		(*cache_events)[PERF_COUNT_HW_CACHE_MAX]
 			       [PERF_COUNT_HW_CACHE_OP_MAX]
 			       [PERF_COUNT_HW_CACHE_RESULT_MAX];
+
+	/* BHRB entries in the PMU */
+	int		bhrb_nr;
 };
 
 /*
@@ -54,6 +59,7 @@ struct power_pmu {
 #define PPMU_SIAR_VALID		0x00000010 /* Processor has SIAR Valid bit */
 #define PPMU_HAS_SSLOT		0x00000020 /* Has sampled slot in MMCRA */
 #define PPMU_HAS_SIER		0x00000040 /* Has SIER */
+#define PPMU_BHRB		0x00000080 /* has BHRB feature enabled */
 
 /*
  * Values for flags to get_alternatives()
-- 
1.7.11.7
