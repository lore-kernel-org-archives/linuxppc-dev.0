Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FXb84mHqzF3Jg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 18:09:56 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J896Aq033318
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:54 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkfmcevy4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:52 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Sep 2018 09:08:46 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 2/4] powerpc/pseries: Do not save the previous DTL mask
 value
Date: Wed, 19 Sep 2018 13:38:19 +0530
In-Reply-To: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <81b0fe2771c5a5243a594d47e669c88051b0d64e.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is enabled, we always initialize
DTL enable mask to DTL_LOG_PREEMPT (0x2). There are no other places
where the mask is changed. As such, when reading the DTL log buffer
through debugfs, there is no need to save and restore the previous mask
value.

We don't need to save and restore the earlier mask value if
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not enabled. So, remove the field
from the structure as well.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/dtl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index e0421aa6eafa..fe333c2525fb 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -55,7 +55,6 @@ struct dtl_ring {
 	struct dtl_entry *write_ptr;
 	struct dtl_entry *buf;
 	struct dtl_entry *buf_end;
-	u8	saved_dtl_mask;
 };
 
 static DEFINE_PER_CPU(struct dtl_ring, dtl_rings);
@@ -105,7 +104,6 @@ static int dtl_start(struct dtl *dtl)
 	dtlr->write_ptr = dtl->buf;
 
 	/* enable event logging */
-	dtlr->saved_dtl_mask = lppaca_of(dtl->cpu).dtl_enable_mask;
 	lppaca_of(dtl->cpu).dtl_enable_mask |= dtl_event_mask;
 
 	dtl_consumer = consume_dtle;
@@ -123,7 +121,7 @@ static void dtl_stop(struct dtl *dtl)
 	dtlr->buf = NULL;
 
 	/* restore dtl_enable_mask */
-	lppaca_of(dtl->cpu).dtl_enable_mask = dtlr->saved_dtl_mask;
+	lppaca_of(dtl->cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
 
 	if (atomic_dec_and_test(&dtl_count))
 		dtl_consumer = NULL;
-- 
2.18.0
