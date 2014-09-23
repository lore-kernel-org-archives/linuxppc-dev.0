Return-Path: <hpatel@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB2CD1A015A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Sep 2014 15:42:47 +1000 (EST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 78A661400A8
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 15:42:46 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hpatel@linux.vnet.ibm.com>;
 Tue, 23 Sep 2014 11:12:42 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 580363940048
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 11:12:38 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8N5h4ki32833570
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 11:13:05 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8N5ga8k006637
 for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2014 11:12:36 +0530
Subject: [PATCH] powerpc: Fix do_page_fault to check for HWPOISON flag.
From: Henish Patel <hpatel@linux.vnet.ibm.com>
To: michael@ellerman.id.au, linuxppc-dev@ozlabs.org, paulus@samba.org,
 benh@kernel.crashing.org
Date: Tue, 23 Sep 2014 11:12:36 +0530
Message-ID: <20140923054236.18176.50982.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The current implementation of do_page_fault does not check whether the
page being accessed is marked hwpiosoned or not. Hence when an
application tries to access page that is marked hwpoisoned, it results
into Linux hypervisor crash and system goes into IPLing state.

This patch fixes this issue by adding a check for HWPOISON flag and send
SIGBUS to an application that is trying to access hwpoisoned page.

Signed-off-by: Henish Patel <hpatel@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 51ab9e7..5e9b4fd 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -170,10 +170,10 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 		return MM_FAULT_RETURN;
 	}
 
-	/* Bus error. x86 handles HWPOISON here, we'll add this if/when
-	 * we support the feature in HW
+	/* Send SIGBUS to the application when it tries to access a page,
+	 * which has been marked as HWPOISON.
 	 */
-	if (fault & VM_FAULT_SIGBUS)
+	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON))
 		return do_sigbus(regs, addr);
 
 	/* We don't understand the fault code, this is fatal */
