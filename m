Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41274P75HzzF35f
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 13:21:57 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w583LpKF024418
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Jun 2018 22:21:52 -0500
Message-ID: <2c9c1121772e9ac2c1e3ff12d8ac02c5c78fe199.camel@kernel.crashing.org>
Subject: [PATCH] powerpc: Don't let userspace trigger a kernel WARN_ON
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Fri, 08 Jun 2018 13:21:51 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 2865d08dd9ea876524652f3900b4b3b9c8b22e77
"powerpc/mm: Move the DSISR_PROTFAULT sanity check",
I completely missed the fact that an attempt at reading
kernel memory *will* trip the warning.

So this partially reverts it. We keep the test in a
helper to keep the code clean, but we move it back to
after the VMA has been found.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index c01d627e687a..20384445ca44 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -416,9 +416,6 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return SIGBUS;
 	}
 
-	/* Additional sanity check(s) */
-	sanity_check_fault(is_write, error_code);
-
 	/*
 	 * The kernel should never take an execute fault nor should it
 	 * take a page fault to a kernel address.
@@ -511,6 +508,10 @@ static int __do_page_fault(struct pt_regs *regs, unsigned long address,
 		return bad_area(regs, address);
 
 good_area:
+	/* Additional sanity check(s) */
+	sanity_check_fault(is_write, error_code);
+
+	/* Check for VMA access permissions */
 	if (unlikely(access_error(is_write, is_exec, vma)))
 		return bad_access(regs, address);
 
