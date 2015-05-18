Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3240D1A006F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 20:56:25 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 18 May 2015 16:26:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 1C09F3940053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:26:20 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4IAuIBv18284612
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 16:26:19 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4IAFLTL026099
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 May 2015 15:45:21 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 02/13] powerpc,
 process: Remove the unused extern dscr_default
Date: Mon, 18 May 2015 16:26:05 +0530
Message-Id: <1431946576-1009-3-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1431946576-1009-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, shuahkh@osg.samsung.com, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The process context switch code no longer uses dscr_default variable
from the sysfs.c file. The variable became unused when we started
storing the CPU specific DSCR value in the PACA structure instead.
This patch just removes this extern declaration. It was originally
added by the following commit.

efcac658: powerpc: Per process DSCR + some fixes (try#4)

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index febb50d..8005e18 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1112,7 +1112,6 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 /*
  * Copy a thread..
  */
-extern unsigned long dscr_default; /* defined in arch/powerpc/kernel/sysfs.c */
 
 /*
  * Copy architecture-specific thread state
-- 
1.9.3
