Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDKn1Sb7zDqMt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:38:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YEDa008591
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:35 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452ypdaar-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:38:35 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:38:34 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 04/10] jump_label: make it possible for the archs to
 invoke jump_label_init() much earlier
Date: Wed, 13 Jul 2016 15:08:04 +0530
In-Reply-To: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402690-5373-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402690-5373-5-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Kevin Hao <haokexin@gmail.com>

For some archs (such as powerpc) would want to invoke jump_label_init()
in a much earlier stage. So check static_key_initialized in order to
make sure this function run only once.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---

Ingo did ack this patch in email
http://marc.info/?l=linux-kernel&m=144049104329961&w=2
But there was no Acked-by: 

 kernel/jump_label.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 4b353e0be121..8ada9f5dc507 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -235,6 +235,9 @@ void __init jump_label_init(void)
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
+	if (static_key_initialized)
+		return;
+
 	jump_label_lock();
 	jump_label_sort_entries(iter_start, iter_stop);
 
-- 
2.7.4
