Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rTL4c65M1zDqhl
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 16:55:12 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5E6s0FR084150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:11 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23gf59arw5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jun 2016 02:55:10 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Jun 2016 00:55:10 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Kevin Hao <haokexin@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 04/10] jump_label: make it possible for the archs to
 invoke jump_label_init() much earlier
Date: Tue, 14 Jun 2016 12:24:42 +0530
In-Reply-To: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465887288-12952-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1465887288-12952-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
 kernel/jump_label.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 05254eeb4b4e..14d81315fd7e 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -205,6 +205,9 @@ void __init jump_label_init(void)
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
+	if (static_key_initialized)
+		return;
+
 	jump_label_lock();
 	jump_label_sort_entries(iter_start, iter_stop);
 
-- 
2.7.4
