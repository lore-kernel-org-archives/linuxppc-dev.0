Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 913A51A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:30:32 +1100 (AEDT)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 8 Dec 2014 16:30:31 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4D12F2BB0062
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 17:30:28 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sB86USOn31195384
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 17:30:28 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sB86UR7U028973
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Dec 2014 17:30:27 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc, process: Remove the unused extern dscr_default
Date: Mon,  8 Dec 2014 12:00:09 +0530
Message-Id: <1418020212-4303-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1418020212-4303-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, anton@samba.org
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
 arch/powerpc/kernel/process.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 923cd2d..73925a9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1116,8 +1116,6 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 /*
  * Copy a thread..
  */
-extern unsigned long dscr_default; /* defined in arch/powerpc/kernel/sysfs.c */
-
 int copy_thread(unsigned long clone_flags, unsigned long usp,
 		unsigned long arg, struct task_struct *p)
 {
-- 
1.9.3
