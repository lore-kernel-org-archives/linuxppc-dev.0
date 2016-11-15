Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHyq555vtzDvhj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 17:56:33 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id c4so4899974pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 22:56:33 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	Balbir Singh <bsingharora@gmail.com>
Subject: [powerpc v6 2/3] Detect instruction fetch denied and report
Date: Tue, 15 Nov 2016 17:56:15 +1100
Message-Id: <1479192976-17847-3-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
References: <1479192976-17847-1-git-send-email-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ISA 3 allows for prevention of instruction fetch and execution
of user mode pages. If such an error occurs, SRR1 bit 35
reports the error. We catch and report the error in do_page_fault()

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---
 arch/powerpc/mm/fault.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d0b137d..d498e40 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -390,6 +390,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 #endif /* CONFIG_8xx */
 
 	if (is_exec) {
+
+		/*
+		 * An execution fault + no execute ?
+		 */
+		if (regs->msr & SRR1_ISI_N_OR_G)
+			goto bad_area;
+
 		/*
 		 * Allow execution from readable areas if the MMU does not
 		 * provide separate controls over reading and executing.
@@ -404,6 +411,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
+
 #ifdef CONFIG_PPC_STD_MMU
 		/*
 		 * protfault should only happen due to us
-- 
2.5.5
