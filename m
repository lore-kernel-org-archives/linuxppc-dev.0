Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wf0Dl4GVszDqKR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 07:03:19 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51KwoeF100286
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 17:03:13 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atqbf88sm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Jun 2017 17:03:13 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 1 Jun 2017 18:03:10 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51L37EV13172808
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:07 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51L370s002848
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Jun 2017 18:03:07 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 1/8] powerpc/perf/hv-24x7: Fix passing of catalog version
 number
Date: Thu,  1 Jun 2017 18:02:20 -0300
In-Reply-To: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1496350947-30951-1-git-send-email-bauerman@linux.vnet.ibm.com>
Message-Id: <1496350947-30951-2-git-send-email-bauerman@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

H_GET_24X7_CATALOG_PAGE needs to be passed the version number obtained from
the first catalog page obtained previously. This is a 64 bit number, but
create_events_from_catalog truncates it to 32-bit.

This worked on POWER8, but POWER9 actually uses the upper bits so the call
fails with H_P3 because the hypervisor doesn't recognize the version.

This patch also adds the hcall return code to the error message, which is
helpful when debugging the problem.

Fixes: 5c5cd7b50259 ("powerpc/perf/hv-24x7: parse catalog and populate sysfs with events")
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
---
 arch/powerpc/perf/hv-24x7.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/hv-24x7.c b/arch/powerpc/perf/hv-24x7.c
index 7b2ca16b1eb4..1354cde7095c 100644
--- a/arch/powerpc/perf/hv-24x7.c
+++ b/arch/powerpc/perf/hv-24x7.c
@@ -670,7 +670,7 @@ static int create_events_from_catalog(struct attribute ***events_,
 	       event_data_bytes, junk_events, event_idx, event_attr_ct, i,
 	       attr_max, event_idx_last, desc_ct, long_desc_ct;
 	ssize_t ct, ev_len;
-	uint32_t catalog_version_num;
+	uint64_t catalog_version_num;
 	struct attribute **events, **event_descs, **event_long_descs;
 	struct hv_24x7_catalog_page_0 *page_0 =
 		kmem_cache_alloc(hv_page_cache, GFP_KERNEL);
@@ -706,8 +706,8 @@ static int create_events_from_catalog(struct attribute ***events_,
 	event_data_offs   = be16_to_cpu(page_0->event_data_offs);
 	event_data_len    = be16_to_cpu(page_0->event_data_len);
 
-	pr_devel("cv %zu cl %zu eec %zu edo %zu edl %zu\n",
-			(size_t)catalog_version_num, catalog_len,
+	pr_devel("cv %llu cl %zu eec %zu edo %zu edl %zu\n",
+			catalog_version_num, catalog_len,
 			event_entry_count, event_data_offs, event_data_len);
 
 	if ((MAX_4K < event_data_len)
@@ -761,8 +761,8 @@ static int create_events_from_catalog(struct attribute ***events_,
 				catalog_version_num,
 				i + event_data_offs);
 		if (hret) {
-			pr_err("failed to get event data in page %zu\n",
-					i + event_data_offs);
+			pr_err("Failed to get event data in page %zu: rc=%ld\n",
+			       i + event_data_offs, hret);
 			ret = -EIO;
 			goto e_event_data;
 		}
-- 
2.7.4
