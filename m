Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 28AA71402EF
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 19:11:04 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 May 2014 14:41:02 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3BB4F125806C
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 14:39:53 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s459B3Oc38338750
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:41:03 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s459AsLx024970
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 14:40:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [V6 01/11] perf: Add PERF_SAMPLE_BRANCH_COND
Date: Mon,  5 May 2014 14:39:03 +0530
Message-Id: <1399280953-31442-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1399280953-31442-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, ak@linux.intel.com, eranian@google.com,
 michael@ellerman.id.au, acme@ghostprotocols.net, sukadev@linux.vnet.ibm.com,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch introduces new branch filter PERF_SAMPLE_BRANCH_COND which
will extend the existing perf ABI. Various architectures can provide
this functionality with either with HW filtering support (if present)
or with SW filtering of captured branch instructions.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Reviewed-by: Stephane Eranian <eranian@google.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 include/uapi/linux/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 853bc1c..696f69b4 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -163,8 +163,9 @@ enum perf_branch_sample_type {
 	PERF_SAMPLE_BRANCH_ABORT_TX	= 1U << 7, /* transaction aborts */
 	PERF_SAMPLE_BRANCH_IN_TX	= 1U << 8, /* in transaction */
 	PERF_SAMPLE_BRANCH_NO_TX	= 1U << 9, /* not in transaction */
+	PERF_SAMPLE_BRANCH_COND		= 1U << 10, /* conditional branches */
 
-	PERF_SAMPLE_BRANCH_MAX		= 1U << 10, /* non-ABI */
+	PERF_SAMPLE_BRANCH_MAX		= 1U << 11, /* non-ABI */
 };
 
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
-- 
1.7.11.7
