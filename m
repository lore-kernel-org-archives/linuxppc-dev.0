Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sHcC55sVLzDrcD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Aug 2016 11:57:21 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g202so5345270pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Aug 2016 18:57:21 -0700 (PDT)
From: Balbir Singh <bsingharora@gmail.com>
To: benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 2/2] Detect instruction fetch denied and report
Date: Mon, 22 Aug 2016 11:56:57 +1000
Message-Id: <1471831017-18167-2-git-send-email-bsingharora@gmail.com>
In-Reply-To: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
References: <1471831017-18167-1-git-send-email-bsingharora@gmail.com>
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
index a4db22f..f162e77 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -404,6 +404,10 @@ good_area:
 		    (cpu_has_feature(CPU_FTR_NOEXECUTE) ||
 		     !(vma->vm_flags & (VM_READ | VM_WRITE))))
 			goto bad_area;
+#ifdef CONFIG_PPC_RADIX_MMU
+		if (radix_enabled() && regs->msr & PPC_BIT(35))
+			goto bad_area;
+#endif
 #ifdef CONFIG_PPC_STD_MMU
 		/*
 		 * protfault should only happen due to us
-- 
2.5.5
