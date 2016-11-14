Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHJrX4cDXzDvXN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 16:25:32 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id e9so7663404pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Nov 2016 21:25:32 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [powerpc v4 2/3] Detect instruction fetch denied and report
Date: Mon, 14 Nov 2016 16:25:11 +1100
Message-Id: <1479101112-21120-3-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1479101112-21120-1-git-send-email-bsingharora@gmail.com>
References: <1479101112-21120-1-git-send-email-bsingharora@gmail.com>
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
 arch/powerpc/mm/fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d0b137d..1e7ff7b 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -404,6 +404,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
+
+		if (regs->msr & SRR1_ISI_N_OR_G)
+			goto bad_area;
+
 #ifdef CONFIG_PPC_STD_MMU
 		/*
 		 * protfault should only happen due to us
-- 
2.5.5
