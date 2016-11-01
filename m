Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7XR33wswzDsxl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 00:39:59 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3t7XR26lVVz9t0q
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Nov 2016 00:39:58 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id a136so8341744pfa.0
 for <linuxppc-dev@ozlabs.org>; Tue, 01 Nov 2016 06:39:58 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 2/3] Detect instruction fetch denied and report
Date: Wed,  2 Nov 2016 00:38:19 +1100
Message-Id: <1478007500-23624-3-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
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
index d0b137d..835fd03 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -404,6 +404,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
+
+		if (radix_enabled() && (regs->msr & SRR1_ISI_N_OR_G))
+			goto bad_area;
+
 #ifdef CONFIG_PPC_STD_MMU
 		/*
 		 * protfault should only happen due to us
-- 
2.5.5
