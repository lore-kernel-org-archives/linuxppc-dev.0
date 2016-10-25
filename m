Return-Path: <zhong@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t2z6P6PQ7zDvgw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 14:24:45 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9P3O4Qu092766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 23:24:43 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 269muqhfmj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 23:24:43 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <zhong@linux.vnet.ibm.com>;
 Tue, 25 Oct 2016 04:24:41 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 969981B08023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 04:26:45 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com
 [9.149.37.248])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9P3Od3A11665738
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Oct 2016 03:24:39 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9P3Oc6G014150
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Oct 2016 23:24:39 -0400
Subject: [RFC PATCH] powerpc/powernv: recheck lock bit in
 core_idle_lock_held after lwarx
From: Li Zhong <zhong@linux.vnet.ibm.com>
To: PowerPC email list <linuxppc-dev@lists.ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, shreyas@linux.vnet.ibm.com,
 ego@linux.vnet.ibm.com
Date: Tue, 25 Oct 2016 11:24:34 +0800
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1477365874.10026.7.camel@TP420>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The core_idle_lock_held loops when the lock bit is held by others.
However, it is possible that after the lock bit is cleared, some one
else sees it first and sets the lock bit. And lwarx loads a value with
lock bit set, and the lock bit may be cleared in the following stwcx.
It is possible the first one is still executing in the critical section.

This patch rechecks the lock bit after lwarx, and go back to loop if it
is set.

Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle_book3s.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index bd739fe..ce07b3f 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -99,6 +99,8 @@ core_idle_lock_held:
 	bne	3b
 	HMT_MEDIUM
 	lwarx	r15,0,r14
+	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
+	bne-	core_idle_lock_held
 	blr
 
 /*
-- 
1.9.1
