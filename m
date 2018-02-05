Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zZbSw0nx1zF0ry
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 16:17:50 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w155EFNC088252
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Feb 2018 00:17:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fxfx11uy4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Feb 2018 00:17:48 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Mon, 5 Feb 2018 05:17:46 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 w155HhrT50397350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Feb 2018 05:17:43 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 788D511C04A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 05:11:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26FC811C058
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 05:11:08 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 05:11:08 +0000 (GMT)
Received: from camb691.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2F386A00DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Feb 2018 16:17:40 +1100 (AEDT)
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/tm: Update function prototype comment
Date: Mon,  5 Feb 2018 16:17:16 +1100
Message-Id: <20180205051716.22529-1-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit eb5c3f1c8647 ("powerpc: Always save/restore checkpointed regs
during treclaim/trecheckpoint") __tm_recheckpoint was modified to no
longer take the second parameter 'unsigned long orig_msr' as part of a
TM rewrite to simplify the reclaiming/recheckpointing process.

There is a comment in the asm file where the function is delcared which
has an incorrect prototype with the 'orig_msr' parameter.

This patch corrects the comment.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/tm.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index b92ac8e711db..2eb20264e70d 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -300,8 +300,8 @@ _GLOBAL(tm_reclaim)
 	blr
 
 
-	/* void __tm_recheckpoint(struct thread_struct *thread,
-	 *			  unsigned long orig_msr)
+       /*
+	 * void __tm_recheckpoint(struct thread_struct *thread)
 	 *	- Restore the checkpointed register state saved by tm_reclaim
 	 *	  when we switch_to a process.
 	 *
-- 
2.16.1
