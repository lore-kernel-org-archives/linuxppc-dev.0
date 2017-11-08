Return-Path: <srs0=buqp=cg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWqqs5Vw7zDr79
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:25 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yWqqs3K3Nz8w0l
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 13:24:25 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yWqqr3zZrz9sNr
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2017 13:24:24 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA82Nqwt115282
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Nov 2017 21:24:22 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e3qx3k728-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Nov 2017 21:24:22 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 7 Nov 2017 19:24:21 -0700
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 12/18] powerpc: have copy depend on CONFIG_BOOK3S_64
Date: Tue,  7 Nov 2017 18:23:52 -0800
In-Reply-To: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1510107838-15181-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1510107838-15181-13-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Have the COPY/PASTE instructions depend on CONFIG_BOOK3S_64 rather than
CONFIG_PPC_STD_MMU_64.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/process.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bb..37ed60b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1215,10 +1215,14 @@ struct task_struct *__switch_to(struct task_struct *prev,
 		batch = this_cpu_ptr(&ppc64_tlb_batch);
 		batch->active = 1;
 	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	if (current_thread_info()->task->thread.regs) {
+#ifdef CONFIG_PPC_STD_MMU_64
 		restore_math(current_thread_info()->task->thread.regs);
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
+#ifdef CONFIG_PPC_BOOK3S_64
 		/*
 		 * The copy-paste buffer can only store into foreign real
 		 * addresses, so unprivileged processes can not see the
@@ -1237,8 +1241,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 			asm volatile(PPC_COPY(%0, %1)
 					: : "r"(dummy_copy_buffer), "r"(0));
 		}
+#endif /* CONFIG_PPC_BOOK3S_64 */
 	}
-#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	return last;
 }
-- 
2.7.4
