Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN7ZW3v5vzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2017 03:45:23 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1EGiV1s142465
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 11:45:21 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28m3g16pnb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 11:45:21 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 16:45:18 -0000
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] powerpc/mm: move mmap_sem unlock up from do_sigbus
Date: Tue, 14 Feb 2017 17:45:10 +0100
In-Reply-To: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
Message-Id: <925b1b5f2d28b5015354405af72bf23d21a1c5c4.1487090656.git.ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move mmap_sem releasing in the do_sigbus()'s unique caller : mm_fault_error()

No functional changes.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/mm/fault.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 62a50d6d1053..ee09604bbe12 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -119,8 +119,6 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	siginfo_t info;
 	unsigned int lsb = 0;
 
-	up_read(&current->mm->mmap_sem);
-
 	if (!user_mode(regs))
 		return MM_FAULT_ERR(SIGBUS);
 
@@ -184,8 +182,10 @@ static int mm_fault_error(struct pt_regs *regs, unsigned long addr, int fault)
 		return MM_FAULT_RETURN;
 	}
 
-	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE))
+	if (fault & (VM_FAULT_SIGBUS|VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		up_read(&current->mm->mmap_sem);
 		return do_sigbus(regs, addr, fault);
+	}
 
 	/* We don't understand the fault code, this is fatal */
 	BUG();
-- 
2.7.4
