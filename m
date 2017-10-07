Return-Path: <srs0=cc4y=bg=linux.vnet.ibm.com=sukadev@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y89Rm5RWxzDqnQ
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:52 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3y89Rm1X5Zz8vjG
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 13:28:52 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3y89Rl0ql4z9t84
 for <linuxppc-dev@ozlabs.org>; Sat,  7 Oct 2017 13:28:50 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v972OcpL039663
 for <linuxppc-dev@ozlabs.org>; Fri, 6 Oct 2017 22:28:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2deehw0pb9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 06 Oct 2017 22:28:48 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 6 Oct 2017 20:28:48 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 hbabu@us.ibm.com, nicholas.piggin@gmail.com, linuxppc-dev@ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/18] powerpc: have copy depend on CONFIG_BOOK3S_64
Date: Fri,  6 Oct 2017 19:28:12 -0700
In-Reply-To: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1507343298-27496-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1507343298-27496-13-git-send-email-sukadev@linux.vnet.ibm.com>
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
