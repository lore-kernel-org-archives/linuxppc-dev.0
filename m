Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 819612C00A9
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 16:23:14 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 22 May 2013 11:47:22 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 560BF3940063
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:53:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4M6N3dn60620898
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 11:53:03 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4M6N6kn011750
 for <linuxppc-dev@ozlabs.org>; Wed, 22 May 2013 06:23:07 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] perf: New conditional branch filter criteria in branch
 stack sampling
Date: Wed, 22 May 2013 11:52:37 +0530
Message-Id: <1369203761-12649-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, peterz@infradead.org,
 eranian@google.com, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER8 PMU based BHRB supports filtering for conditional branches.
This patch introduces new branch filter PERF_SAMPLE_BRANCH_COND which
will extend the existing perf ABI. Other architectures can provide
this functionality with either HW filtering support (if present) or
with SW filtering of instructions.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 include/uapi/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index fb104e5..cb0de86 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -157,8 +157,9 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_ANY_CALL	= 1U << 4, /* any call branch */
 	PERF_SAMPLE_BRANCH_ANY_RETURN	= 1U << 5, /* any return branch */
 	PERF_SAMPLE_BRANCH_IND_CALL	= 1U << 6, /* indirect calls */
+	PERF_SAMPLE_BRANCH_COND		= 1U << 7, /* conditional branches */
 
-	PERF_SAMPLE_BRANCH_MAX		= 1U << 7, /* non-ABI */
+	PERF_SAMPLE_BRANCH_MAX		= 1U << 8, /* non-ABI */
 };
 
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
-- 
1.7.11.7
