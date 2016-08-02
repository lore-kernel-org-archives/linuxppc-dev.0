Return-Path: <srikar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3cHW6w3czDqRc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 23:19:35 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u72DEmhm118534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 09:19:34 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24jr4au5vm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Aug 2016 09:19:33 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Tue, 2 Aug 2016 23:19:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 979D12BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 23:19:28 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u72DJSKm2555962
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 23:19:28 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u72DJRNi023270
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Aug 2016 23:19:28 +1000
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: linux-mm@kvack.org, Mel Gorman <mgorman@techsingularity.net>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 Andrew Morton <akpm@linux--foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH 2/2] fadump: Disable deferred page struct initialisation
Date: Tue,  2 Aug 2016 18:49:07 +0530
In-Reply-To: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
References: <1470143947-24443-1-git-send-email-srikar@linux.vnet.ibm.com>
Message-Id: <1470143947-24443-3-git-send-email-srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fadump kernel reserves significant number of memory blocks. On a multi-node
machine, with CONFIG_DEFFERRED_STRUCT_PAGE support, fadump kernel fails to
boot. Fix this by disabling deferred page struct initialisation.

Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 3cb3b02a..117faf2 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -318,6 +318,7 @@ int __init fadump_reserve_mem(void)
 				be64_to_cpu(fdm_active->rmr_region.source_len);
 		pr_debug("fadumphdr_addr = %p\n",
 				(void *) fw_dump.fadumphdr_addr);
+		disable_deferred_meminit();
 	} else {
 		/* Reserve the memory at the top of memory. */
 		size = get_fadump_area_size();
-- 
1.8.5.6
